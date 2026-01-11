Return-Path: <netdev+bounces-248835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F1D0F7DD
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAB51300A53F
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099833F8AC;
	Sun, 11 Jan 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm+3H9Nh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC59500963
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151290; cv=none; b=uuXCtVf9bdkH1SuEFW33sTnj4yxX5SVeNOrkbRMNg1OtuMyW75dla2MhfltbXWbARG5511UWt81M/ahGGm2IYuXFc/p5oCoh3kVlQLMrhxkV5n3TYrdtQRBHXXvJwXrC4Mo2fqNBEkz1CmaO0b5U7vA1OvJUsMfOPAl33hi4UR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151290; c=relaxed/simple;
	bh=vfB7wwQOv6IVE0ly9jv3QpWGznBV/7h+jvxKooUUs3g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RujR5a9CFaNiZlM8mywXQvftTeswrdKwcWMiY8UNXBvHwN6Bon3wRyrNMgDdluNtRE6ZGXUdrtP2yx1+gxt9VlwberxyA+u3N8IINQg0W5O58clmb9Jq5o6lqas3MHBNsBgB29G8eEjCt8EdbmpckvEhEh8XE578HBL3cSi46mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm+3H9Nh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fb6c7874cso62739937b3.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 09:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768151288; x=1768756088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14CUfSTshsPYBnbMn2scYI68w2LgxYFZBM4RNYY08ec=;
        b=lm+3H9NhgRLrRqFi5x2oKa7VCrv8kdWmT5c5UU9MeehHnWU4sXcY9sqPT/lGcxh5xq
         P6TsX7yxohHArEtaS0TvGGvor3F0NtVZMvikgz+o+NLbkj+yVfhC68jD50ahR5B0VaSE
         NkevdvQKvRmL8WojBgNBktGahCKlXXVBVtFXRyxMwoi03pKQKHgt/IrK7AZTFnYafcJK
         zxRvm3eOUetSNgQ1v7i+P3j9pcIvI7jmSNxM0zcxRfx0dfvynx+b9gDkYDts4tv1haQp
         YdjaTxdTDcGbwuLvF5PqZTJp8r/uMO3kVg0CrRKqR0DFhjqwpNZTUmZWIW72KLODXA+e
         SYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768151288; x=1768756088;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14CUfSTshsPYBnbMn2scYI68w2LgxYFZBM4RNYY08ec=;
        b=QbpMqNlVLDhNDdUnMU/viH3tEIK1fdwFsnDBdJBNVpZTzbqvC1qtN7YkL9vogNFsa3
         L4jrxDwmJKOG6VLCiMSIOZTJBg3MphJdsS4J7ERfA75kZcMwS4qfv+b7TqsiZSajmqN8
         H69PngaOYXm/yUV33E/UMiXcvfMTSEWALr5E+0WneF0g6kR+WbyjUpkodVCVEvCusvlW
         UNmODLA2ZYHgMWyrk4pGLlah7Q9Wt3c04T7FSVOzWs2/PmrpCODDet6xgRjMUG9p2eAp
         /dI9JbqLV+RdpR9gLvVAwmKHJ3WGNa/PDySbZhWfnSrHGQKNzKsptHHUoCn3BVHIGQsq
         QAnQ==
X-Gm-Message-State: AOJu0YwEZmggn8F//t/jPlrWJ5tp2K6Ft9xh2Tc65IqLHDef6x0uAufB
	yM0QgnBU9mIEcvE76fIOCfGgr3Hwkl5tvkIPqkcA1XHdXln/tFQuneaZH3xIhg==
X-Gm-Gg: AY/fxX531je2olRzcHxYhyzXDPxfvVQHkoH12A9Xd3eY+Io3u4YUY1ea9h5b+nt02ZM
	PfaiYJmhopYC7pk2Bg1goEhVFJdPKLujw6QIM5Y8Ljfr/xzmG4fXSGAKXUlOChH/TO7zbEip4kO
	0i6mgIWTbMkUd0HnPGoYt/3bQqsJVq19sE5W/T8SeNKcZVMlmDpwQ6eYrb5qdVqfAXEG4AwtBRp
	KLo6ZyO/H56BdnInUBgWhGoZQg7agb7y4qkelUzlbd4RL/14Okb8dwBFS7IiYHOdsIdW/fLLqp+
	oNUdQO5S/IUDWV4YVS2v/c9fKagwr6bUrQMvzAzpwKvWk9yhyqiasUpHnyobD7D2+kN1JSan3AK
	qrJUMFrCOQOaxkpruvDr7WstiuiD+F4v5/8/6rVb6LB2xAeap4WxqJRQrQYCkm2vzZ4QMFGF2vl
	zFhcIj33LgLxvjU4I626phv2OFbKnzT9FmFZiqXBv7NXtyAu5n3yAmAdHbyNg=
X-Google-Smtp-Source: AGHT+IGv5P2YMNezQssDg4306hlzj+3yVIXMSWoalTwJ8MWNhRun/Bs/YEi8ZMBC8Tv2gECQCDzvHA==
X-Received: by 2002:a05:690e:4004:b0:643:1a5f:aaec with SMTP id 956f58d0204a3-64716c5fd63mr12458018d50.47.1768151288211;
        Sun, 11 Jan 2026 09:08:08 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d80d2c2sm7093598d50.8.2026.01.11.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:08:06 -0800 (PST)
Date: Sun, 11 Jan 2026 12:08:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, 
 willemb@google.com, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemdebruijn.kernel@gmail.com
Message-ID: <willemdebruijn.kernel.fb5103cf5a5d@gmail.com>
In-Reply-To: <20260110005121.3561437-5-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 4/6] selftests: drv-net: gro: improve feature
 config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> We'll need to do a lot more feature handling to test HW-GRO and LRO.
> Clean up the feature handling for SW GRO a bit to let the next commit
> focus on the new test cases, only.
> 
> Make sure HW GRO-like features are not enabled for the SW tests.
> Be more careful about changing features as "nothing changed"
> situations may result in non-zero error code from ethtool.
> 
> Don't disable TSO on the local interface (receiver) when running over
> netdevsim, we just want GSO to break up the segments on the sender.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

With the s/tso/tcp-segmentation-offload change

Reviewed-by: Willem de Bruijn <willemb@google.com>

