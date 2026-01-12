Return-Path: <netdev+bounces-249161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0AED1528B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 430513014DC8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF39329E56;
	Mon, 12 Jan 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmz91PF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A117BB21
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248826; cv=none; b=erRJl7RbRTbAtzpauPJ+zEylgoWw9Wl4hn6e/CDsMdWmiMa7wfA+Owruxq/BxLqZSJRR07Un4d6/zn2UpYGMHmD7ZxuOZtsPuOrE0mxo+ac0T0vfDUwh4eh8VKEyNL/rOEub5Gzv2bJIQI8RZZarV9NKW6dPkdcZKTC7K4OxamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248826; c=relaxed/simple;
	bh=ya//tDErwuyBxTYw3AgNL1nYTckZ6bJd0sczpNUEXQw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eMJBZv6MWAXkt1ICvaSjx7G/wnXcyzOvk7MWf6CKWIf1ZkDSmjjnY1i0XuQZskdVbqAbY2Zt2iOefMZsO5orcmlsvLp81Z8A0gW1XJmee8ZcIyypI9NQmDnixyIn64ne6GFeTBOYODhmYB71/MjAsY74zbzD04EHCRDn7oTH8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmz91PF6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f57cd471so3371196f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768248823; x=1768853623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wStNSoclEWxJVkhOJuxBl2Qy/H+6aQosqYcAz8xUULA=;
        b=bmz91PF6stwlD9D8C5RE7qf7JgoU3KyEGe3sftWUpnxD2nKENDdHol/jktHNvWQcCe
         EHQizbhFONQZyP57K4Jf/TG21gAcI8oLSoVpLIJR+XoBKDsHjK//r0Uje2xmKgTQSGIN
         REuVEvJnSIelM9LM8ktDzCdURSIIKDApj1uKdSI4acozFNZRk74RTzluvC6mJI2pro4d
         pRFbPbtiv2ux8zk43GpDjjzM3QF3Di/O4BulGlwCmhE9C42PwYyizwZT6qJBKDEjOBMX
         0VSGqYXtwsVJoFwHUj6Zttc2a1o6HXZKw5kI8rFWSPnheJerZowQ87s/fqDpXwcjeinO
         3IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768248823; x=1768853623;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wStNSoclEWxJVkhOJuxBl2Qy/H+6aQosqYcAz8xUULA=;
        b=M5ZJo5XAsbTI2eIaC286Sb5LWFSP0QZYuhGghftQZv0u0x2cSuwsDldOpOlNQ9GZFm
         3Awxmf3B5uer+CHJwfgTg7CYnT09+rRJyTY9GtYf7oGM2S9Vm4rj9KYzrS2lIB4/P0LZ
         u2BCSOHi0D0pQ+i0eQqE95xOaipEBkRU6bJAptc55Ke6jOfSbta6eiJkgmcwzyJF6gA0
         fubb/mt+sspMmSa8ljUePwWyl208mMn04eYtlbsXO87PzkPcwjnxsn9DIGkTkw7Y6iKS
         U3TNC//zUZfirZawVPZvzoHK1oWW6qM16ZPdm7joa0nOkRZ/PX1GUg8kkCxdx66pbvT9
         JZiA==
X-Gm-Message-State: AOJu0YxEAZsx1WzptCg94k7pdkmqaTfDLIiVsBHbiB4ks5/7zSvIZ7vG
	/7DSQ8VxYbNpWJqte61Xg7EhAKxY3HdHVkl4Vw3IMlBNf4itFnIfec96
X-Gm-Gg: AY/fxX63cokosAB/N7tpk4ZH40LjIRWS0Vhk++JnZ8gfRuIRYdAFYSRaeWntSIYMTcY
	YHb+nmU7wszl51uHVKdqNmtkm/vVgvVuYBKUtleY3YWEk5b/AqvJQB7DkF8GOwIOe5lKjRnWijB
	QH+66Rqx9NqgktDM2b5oIWiOWwm64DYC3EH7T7z7ycBZ4tkLm1sk4Eceyq7HY+fb688QiyjnLeW
	iR4a4bHHd3QbdloP8m++0NSKuUTW10SIKQcsEPrnZnQWiv8DpK+Qb+H6zRBVhcR7X1ztn463Ve6
	hPVPxFJ/UO8W7gPUu0ZhBS2c1dZmDGuep01y0fBR+/uE066nw3rrwbrnpG3dFAES5+dmbKQgbEh
	xqQktZgrMdpi/YsU2X6QrmFDXWl/4zKedsiMkuw0L+FGBvy+5a39jMrLbj3TR+9Qgei72chgp6t
	6ezpOIJ6iFv+/JbGmnbO02qL6d7Xs6N4h9G91GJeIqUH76PV9ItDE/hOE9bJT0ZtXmMM+M3anBn
	pVJ/5xelEVlpncYA90wZgZ/UrrSs2HtRqDjLud7EEjD9I+i
X-Google-Smtp-Source: AGHT+IH4+z/uWtdz+f3ewwjEcJ5+yXu2F5Y0nCLDjLUyG4dfHNbdm1zvorRjWK5ZDoMxgtVlDkaxBg==
X-Received: by 2002:a05:6000:1a89:b0:430:ff0c:35fb with SMTP id ffacd0b85a97d-432c3761740mr24557795f8f.52.1768248823270;
        Mon, 12 Jan 2026 12:13:43 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0b:c700:d3d:9a2:daf4:1e10? (p200300ea8f0bc7000d3d09a2daf41e10.dip0.t-ipconnect.de. [2003:ea:8f0b:c700:d3d:9a2:daf4:1e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm41248619f8f.11.2026.01.12.12.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 12:13:41 -0800 (PST)
Message-ID: <dad1967f-34a4-4f55-8d77-586558e80f9d@gmail.com>
Date: Mon, 12 Jan 2026 21:13:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: dnet: remove driver
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <24dbdb3c-67df-4949-a278-0e41c25e7b20@gmail.com>
Content-Language: en-US
In-Reply-To: <24dbdb3c-67df-4949-a278-0e41c25e7b20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/2026 6:58 PM, Heiner Kallweit wrote:
> This legacy platform driver was used with some Qong board. Support for
> this board was removed with e731f3146ff3 ("Merge tag 'armsoc-soc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc") in 2020.
> This patch removed arch/arm/mach-imx/mach-qong.c.
> So remove the now orphaned dnet driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Patchwork complained about an orphaned CONFIG_DNET entry in a defconfig.
I'll send a v2.

--
pw-bot: cr

