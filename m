Return-Path: <netdev+bounces-283539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJsMNzfE9mnBYQIAu9opvQ
	(envelope-from <netdev+bounces-283539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 05:42:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642C4B44F1
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 05:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5940630088BD
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 03:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318393612DB;
	Sun,  3 May 2026 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bogIRTBj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8417B50F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779765; cv=none; b=iISHC480vXjpSaVFClbUoHuht4+7cpdRyuAszAV8xK0qHQMJ8/V69lzhNwkK2JWygcsXICNzPzIj0IqtdJxF5v/APXZcPFh2krRhO2LDmao2P0z+MqPauq9DEdxE4zmkRq/gmJMRLWaPvUNSZlmgpfcIziqGFX0nKdWayAdMifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779765; c=relaxed/simple;
	bh=tjG1kTWygatN70wVlmDcJrkF7ZiwlCkEtZ14WpNp9YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8/RWmD2SZFW6TY0XwYxIraNOfpzBPrRQD0TwfR3NEZdy9A9iCHADgqHhH4hboQzIcqmY/qT2rQRvUe6q/lNpKAVYb+yUA9Idp3/HfqhsMkRHo1gwQdGAUp1dlM33emzcuVunbjxBS9VC7HOdKmbQYp7Bf2ZRVrza0q4LXE0czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bogIRTBj; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95cc3522c40so1989041241.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777779763; x=1778384563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PiiXKGJux6g44aioDbCLD/YNgU+NyVlVqd4RaEM0CyY=;
        b=bogIRTBj2NYB1Wx+NISe61rixqiMmilhr6CMCY7MKJG9isjO5Seco0qVA/yOZsaVcG
         5pOsfzym9wWCYc+pUCe6ybYbOqDaw5zC0prMnbavrZN7dY+N7ngFWBC2pIh3QZYnKi1A
         MXRpArxUJogCawuyP3oz0W1TlDavMuTk+pzBS71GlcJV/OQ/DfIqTQmnc+REdEkj0Z23
         ypD37ohPkyq6mpAQIl6Oci4+/yiHktxJXiKQTsRzk7G4WARSfY3POLfuEX+YzMzRsQVn
         YCRXv2utqrytLSwHwSQ5lGMMCAVityzCZ7CO7b2wBaQGFvkVWyXqQ0wCLDnkKySuwXAh
         +ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777779763; x=1778384563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiiXKGJux6g44aioDbCLD/YNgU+NyVlVqd4RaEM0CyY=;
        b=enTvVxr8NBXVndZ06ZOAj1tYfM5iFiq413QVjRuGiMoqbT6Z0jMTlO5KG8cFPQ0bRK
         AUOHg9SgiqPo/1cqF3G3rIdH1YGiEFa8AUxeHJ7dKv27hTa3MIklNdzZ7DcmyMjigO4I
         Mt4aqgQv/VgRNNLEhzWhuwVJ1+DrGO9rAbJp+15agei8s7ZJfiddPtAIRWZenKBdagnx
         DydHHP04i44xLxZqRuVV6gH58EcRERnWNp7qPaDHbIvTtzKRXLJOQ88n4D7fl0OwXvML
         A93rH/3VNJlffbCuDLocRsk9zl3cw/NqSYxKAVf8lWhMBTW4g+rx5ylX31is4JGe6b2g
         WP0g==
X-Forwarded-Encrypted: i=1; AFNElJ9aELbzaSVuflZX4JgzwWG9A+epnWzLiJ2oG8FeGNumWe0cjI9M7avEXOlrIRQUPdSHNTcHBWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVjc44mT869vz9oNPERYI9i5wIaNEhJjnJO+kV8T8b592LSOj
	AUb35MX/h8gvX6VJoRQ3gMzjY4s0xR7HX+N3/Ypn8Qt0BMxha43CEWpT
X-Gm-Gg: AeBDietbh0lO+KuL/+1WblmRH4EEx+NoJIJ3sIWbnfuLryg7xt1qgp3Oe6/cLv4jR0x
	sUclWn8OFGiBnFhZVinb8EYD8jA7yxIX01vf7jxhw6SxvmYcTsezY0vcjThAHISu7utInql7DHb
	99/IQMhbsBYsZhENuXPlQBYRcJJnBuSUuCSFJL/NKJ9L/xf7WUhS+D6rBfnT+35j5dz4DEfL+Nb
	i5x1Ptg+9q3sDQYKPB+1ZO9XDCcPqSxOG/I5HJGSJFUpxIozAvcaIPxnfGVnleHVMnybgOdnbfI
	NISxSAMJMq53pINBEhcwSJxaNnJHZiPq4+CZzfDfY4hs+5jQy8Fpl1zD+WOXsr3nXrtFNt8+X+s
	+L7LdLXQq5inyvZLq3daEqGLa9xu+ozqTpVRH1S/TLGbld+lwiZHNz6kJpjUa+sbDQqpyBNsMwK
	JQtJHovP59q5nDSJ5tRZGuNpYoDOTN6geoJDcmAh8zW8Q=
X-Received: by 2002:a05:6102:4b0c:b0:604:f29d:84be with SMTP id ada2fe7eead31-62d84a67460mr2488161137.3.1777779762631;
        Sat, 02 May 2026 20:42:42 -0700 (PDT)
Received: from [172.27.209.232] ([129.222.53.215])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95ce0af57f6sm3669350241.8.2026.05.02.20.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 20:42:41 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <1fe6bcb7-b5c0-454f-ad54-5014006edab5@gmail.com>
Date: Sun, 3 May 2026 04:42:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] gpio: tc956x: add TC956x/QPS615 support
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-10-elder@riscstar.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260501155421.3329862-10-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5642C4B44F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283539-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/1/26 16:54, Alex Elder wrote:
> +config GPIO_TC956X
> +	tristate "Toshiba TC956X GPIO support"
> +	depends on TOSHIBA_TC956X_PCI
> +	default m if TOSHIBA_TC956X_PCI

Hi Alex,

In your Kconfig changes, this condition 'if TOSHIBA_TC956X_PCI' is dead
code. Since you have the dependency on TOSHIBA_TC956X_PCI, you can just
make the 'default m' unconditional - assuming this is what you intended.

Perhaps you would prefer to use 'default TOSHIBA_TC956X_PCI', which
would have GPIO_TC956X default to 'm' or 'y' when TOSHIBA_TC956X_PCI is
'm' or 'y', respectively.

- Julian Braha

