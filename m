Return-Path: <netdev+bounces-297251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q1JdHj1sKGp5EAMAu9opvQ
	(envelope-from <netdev+bounces-297251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AEE663D44
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:40:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.s=20251104 header.b=xOVlCehr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297251-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297251-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=riscstar.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FAE630AE73F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B7374A18;
	Tue,  9 Jun 2026 19:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A63749EC
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:32:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033526; cv=none; b=VX3cMLUFoJNPwjH4XlKieBWEcmI2Hy3/pr0lDA1v9cFLIaqZbIXMJyqlLz8ngqqlwWpgmW3pmVW9vs7ctgbWSar7EAPXrIc2nZWMsFnKnHVK+zt6F3G7EpN6gOOZfvIpJyFDHPyy7fh2wZvHYzy1+tpQBnO6YuaILQAG3+ihMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033526; c=relaxed/simple;
	bh=G0qFOxrdTOLqSxSrQOHRTa8hwYrKFa+ZVBkvz3eXTaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbTQCgWI8J+veC0RzC7SucXX7WIHgKBpII+Jyk5IFwTHIKFqZI3rvMfI6pzNhEONiEzdlusbP8RswiWnadpZ5lGm9HyCKOpjPdPvERAG12dN/kKY1EAwDGb0W60alj9C5tAktRnwt9hl6E4rsQuGNjw1kDjbtmx6MAnXtUvY4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=xOVlCehr; arc=none smtp.client-ip=209.85.167.177
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48611ccd5aeso3473098b6e.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781033523; x=1781638323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqDaomdcEkmPt/kMkSkh61O8nncSS4SHKIlJjYIogSM=;
        b=xOVlCehrQ+pI7QtZEL3EM+d6t3Qr7oDYkEu7o1M8zsz5SIkoMiE03rXPC7Y1K5ewN9
         GABJ7rvi4r6AvJa98alXDxLIly0PBVmetQxOKR8U0f0TENHV45kZVe7AgvVtwd3qP/ov
         bzDTIc/+6rpJjDg4ZPGOqqlACGfCLgrzs+l+tiKKVEDrc0proJNZklSV/jqvW4wPWpin
         GdVVgmreJ2uo1DSiYwF+Ga3pwFtPJ0fD8WEXZ4NYbOpDI2pU/6AAH3nd3vYYaL47euif
         kUck4/oYj/uTejTgxjLK/FAFCcFo6sonMpsEGtjb3Qb3Igj9JOlodr/4J9EMcnIfYuwt
         O/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033523; x=1781638323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqDaomdcEkmPt/kMkSkh61O8nncSS4SHKIlJjYIogSM=;
        b=sH1AjV85OEQGJUJTczHpc1tgwNk/Q0+z3XJ4WER+8NEwX9U/Ja8nLcKaShYAR01OuT
         gIi7Fhb3yeGC/lU9JJGlc3Ss6zp9Q4mi5V+7je6+rYtjCzmLBXq+0y5GurKl7KeRjHJx
         ZQMJXdJ+gFokC8tjucOirPnkOsNFpAI6aTeoHEI5hA+Og3R4yj22ojtyRT1yKP3GbjaA
         l6y433NBlcugjEtyiQbZiR/uSvF7wr6Q+CoH883ENZQ7KiuGdHSZk6RoaArFlrcRuhcs
         uXQ4b7RLC2EhaaF/5CWNe4i443G0SGNzUkL6/eBwc/kga/cwMCW9rOJ+D9KJ8cbqxjBC
         GyJA==
X-Forwarded-Encrypted: i=1; AFNElJ+V6oP0gQXl4ZI9I0isfyKCOFiyA1bT2sL8TG3e+1V0QMjEVo+/+SaLs4QED4eUl4nTA9LFmtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPj04ri1+SusqBZUpoCff7C/gZ7PImN94kGK0MjLhdJ8+oteXe
	PV7GCH6NfpZUfDjhHLQyk8WKBO2uZrS6/2jXi4CXm5tYikrJDI3cSLzeTWQeFQyzQ2c=
X-Gm-Gg: Acq92OG+9EBlD+GJUCcdndp+5Yp8yX5HUkLhEzuIsPrsTy+ZpqbRUqt0K/n28z68KSS
	mU75Cto/mXMK3MpETWRAy7LapuHDcKKB54YzqoNp3HP2rM2h5VxzNwnQCq50dQPNuwuH2aANVTN
	mAozJa/9SK4N0ibxPllN27xyTO6Z/PzXR/BeIauE6oKmkQyllT0lE0pq5WpjtHp4MM95TulEcOC
	KrSInRMFSUmrehA/M9s+bnGjhgjCkx+qU12DxT1gD/UxGAYj1v8R+UMd7lTvH6E8fGpEsDgeM/S
	FpTpRZ862nmjFDVZTU7zO6v+O4mdcmkUvmtnu4zGRMGfH8NPIE1J9J2I4MmNTCWUATZruNsQ2Dc
	aNVTHFupNMUMoGGcGr79Bue113KyAVwennXn3ZLNe70Gh+nr66GxyYMORbyS0i/wcf+44DGSyP8
	0YlhOc0yMrLXhaP7Z8RWUBIAbPd0Pf385FGA==
X-Received: by 2002:a05:6808:4fe2:b0:485:7c72:786e with SMTP id 5614622812f47-4868df054eemr14537468b6e.21.1781033523165;
        Tue, 09 Jun 2026 12:32:03 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b32f372sm16507092b6e.0.2026.06.09.12.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 12:32:02 -0700 (PDT)
Message-ID: <47a9909a-da5b-4b12-806a-1b9542cf8bc2@riscstar.com>
Date: Tue, 9 Jun 2026 14:32:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] net: stmmac: tc956x: add TC956x/QPS615
 support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-14-elder@riscstar.com>
 <c60d1819-18d7-4d4c-a997-586599323d7e@bootlin.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <c60d1819-18d7-4d4c-a997-586599323d7e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297251-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:brgl@kernel.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:daniel@riscstar.com,m:mohd.anwar@oss.qualcomm.com,m:a0987203069@gmail.com,m:alexandre.torgue@foss.st.com,m:ast@kernel.org,m:boon.khai.ng@altera.com,m:chenchuangyu@xiaomi.com,m:chenhuacai@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:hkallweit1@gmail.com,m:inochiama@gmail.com,m:john.fastabend@gmail.com,m:julianbraha@gmail.com,m:livelycarpet87@gmail.com,m:mcoquelin.stm32@gmail.com,m:me@ziyao.cc,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:richardcochran@gmail.com,m:rohan.g.thomas@altera.com,m:sdf@fomichev.me,m:siyanteng@cqsoftware.com.cn,m:weishangjuan@eswincomputing.com,m:wens@kernel.org,m:netdev@vg
 er.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:johnfastabend@gmail.com,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	FORGED_SENDER(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,riscstar.com:email,riscstar.com:mid,riscstar.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,riscstar-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6AEE663D44

On 6/5/26 11:05 AM, Maxime Chevallier wrote:
> Hi Alex,
> 
> On 6/5/26 03:00, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Toshiba TC956x is an Ethernet AVB/TSN bridge and is essentially a
>> small and highly-specialized SoC. TC956x includes an "eMAC" subsystem
>> that can be accessed, along with several other peripherals, via two
>> PCIe endpoint functions. There is a main driver for the endpoint that
>> decomposes things and creates auxiliary bus devices to model the SoC.
>>
>> The eMAC consists of a Designware XGMAC, XPCS and PMA. Each eMAC is
>> supported by an MSIGEN that bridges TC956x level interrupts to PCIe
>> MSIs.
>>
>> Add a driver for the eMAC/MSIGEN combination.
>>
>> Co-developed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> ---
> [...]
> 
>> +static int tc956x_lookup_max_speed(phy_interface_t phy_interface)
>> +{
>> +	switch (phy_interface) {
>> +	case PHY_INTERFACE_MODE_SGMII:
> 
> The SGMII definition we use in the kernel is the Cisco SGMII de-facto
> standard that only supports 10/100/1000M. Some vendors use flavours with
> names such as HS-SGMII and such, that's basically SGMII clocked at 2.5G
> with aneg disabled. It kinda becomes 2500BaseX then.

So for SGMII then, the max speed returned/used should be
SPEED_1000, correct?  And for 2500BASEX it's SPEED_2500.
(I'll fix this.)

For USXGMII I presume we'd use SPEED_10000 as the max_speed.

Can someone explain when the plat_stmmacenet_data->max_speed value
must be set?  It seems like plat_stmmacenet_data->phy_interface
should normally imply the right maximum speed.  It looks like
phylink_interface_max_speed() has a big switch statement related
to this.

Thanks.

					-Alex

> So all in all, we don't support 2500M on SGMII.
> 
>> +	case PHY_INTERFACE_MODE_2500BASEX:
>> +		return SPEED_2500;
>> +
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
> 
> Maxime


