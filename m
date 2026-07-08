Return-Path: <netdev+bounces-305973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KrY9OTqqTmrXRgIAu9opvQ
	(envelope-from <netdev+bounces-305973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:51:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886E729FF8
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.s=20251104 header.b=R7bg9A51;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=riscstar.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305973-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305973-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6322830B4FFF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB353D75D7;
	Wed,  8 Jul 2026 19:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC13D5676
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 19:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540155; cv=none; b=Pyv+ghNDNzorFdPD1JTQpkGHR7aBLq+FdAL6d7Tspu45oa1YXz2/b9UKSsipnqs73FBWpcvcqG1Bl961Cj7QoE2s2GjvWFmqbJPO7aBcevxndtt/D7T9tANyCIpNsREd4JA4XVZWhWtb0/w9b3rsaS+Jn3zPoIbc6O/W1wqLZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540155; c=relaxed/simple;
	bh=8FitnCOIzymqmh2SJdD2U8RGsIUomwearn9KBz4ki5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwmNfsj+U3UFLQGEBcPDMP4kx+y8KPoT4SBoGhhcz861/aWxAi5UVeDmAK2MhqdZceTChiC5ZLustKcl4qRJ/aeUp3XQXq0iNkdHdCgTZwefj+gv6NS+zTf/lqVZWoalE+mJqh24BKAkYqvbhL1192ZydDbmqai+d5Gr+exKOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=R7bg9A51; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so2169396d6.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783540152; x=1784144952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COlIbGYEylMlg+08j+MrlBTktSUlvEsQ0xCdXam5qLY=;
        b=R7bg9A51U2YEVq96hR0rQnFcFnePpmgs57hHYELToqG26iKAaKYzzryl7w/TTKf2CC
         +lGxw+QEA9jAjDWuJn8o89jmSiM3in+PWfOWE9KLcsBGhWY2ChCF0mDU/sjTsZbur2Zf
         ogpg+pkh7VIirM2H6zajzbuFunp9cbVfshGIliWJAJhqPYiJLh9kOTUzf2C7BaxOH/ah
         wFgrmuPXqEJkxBbUjbsthpspMBb6yTB4Q7opegffUhodST78YirtVyvZuDyYD78A2Koi
         v7fHCLfLDRHflzsnPdLx/b44MM/2+Fq0b1Mp/SxN+A8d2S1dSVc2uLtjsNP260VozBDP
         mYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540152; x=1784144952;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COlIbGYEylMlg+08j+MrlBTktSUlvEsQ0xCdXam5qLY=;
        b=nIi2XXt+ePJGHyN0/ktFzS5Vz1+HUBLiARven/573UdR4GnqxGqNVSFnriVI+jWhuE
         Nw9StbnmJya/oTuEfTjPCdtpo++KcM13R/FfubrHmqeWBvYLvfNEOUYm/FBIupMbUlnn
         Kj8wyHK3fbiJ8P37uUyuO3HPPTj6aKlNQjVxzkXxiGDzZXcuc34yBMr85ihT25ItUmia
         ezU0PKwQqOJ8Tm17mMEy5bNRND+LZBHtuCUhO3C0syaWPToHqJ3md5txH/bYR68yYdBK
         H2LeqUFfiRRG5yerA2Lhxm+dOZZ+q073mcUkv27DcjUwxiBCE9M0HYpHfKmRgoCu67+4
         6Liw==
X-Forwarded-Encrypted: i=1; AHgh+RqD1j0BEYjCq93aiCiiOnGQ5YFLXl//fY0IiRe8Rygpm0xwNQk5WrJZkZ1X21wOA+7QToRtM+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPC9nMekMOHVUmErR8ymMM4WeD7NVBOaLZjJcNvnQG8r2iQVh
	LzICmekqghczDx8pV3SjTdI2Fv/IiFZjeJc0xiuAuxN/kNN3lPeffGdbCavs2is0ubk=
X-Gm-Gg: AfdE7cnpg7FEfWT3DLHL/BkVhICCMjmC77CBznL/tMXrKQs6Ub8On26JN/HTZF5jzgM
	P1Qz3BLZXVnSfG+nHsigeqVU6Ry8t1Gx0k+rtK+XYeOk9rapOYEVQJ0Hwzf9DsS4DTIdAe4Z0Kc
	+VFlXmFPSFb6kg4JwxVhCGt/qph90Aj9GYj9g1Ep3kuv0d/NsxvtyAp24cibwKVjJ0NQW2DlzZu
	0+LHxGobc/Ig4X+MwQWs6GsS08hT/8sICc66bDHf/jK4d2hUH8KHf5WjKGAte+uHrZsshvLp64U
	vafhxSwfrAdXJ1/WNsEew7IqtxROBiptoDLRxTMdRak+AXtQfSDA2JWpC24kQ4n+TRmDBSSJU7x
	VVZnuJybrTbnPPhwnlw0ys5ELQ1on4viOewkNkY7E18w3sQCHhzPfJaMkLV83IBl0j3ag9U9XMV
	JObXzuoQw9/e3C
X-Received: by 2002:a05:6214:5293:b0:8ea:c243:84e0 with SMTP id 6a1803df08f44-8fd38f9b4bamr95685346d6.1.1783540152153;
        Wed, 08 Jul 2026 12:49:12 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9b1c4sm193173066d6.48.2026.07.08.12.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 12:49:11 -0700 (PDT)
Message-ID: <8309e9c7-a110-478b-8cd4-c002070d2b4c@riscstar.com>
Date: Wed, 8 Jul 2026 14:49:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] SM8450 IPA support
To: Esteban Urrutia <esteuwu@proton.me>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
 <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
 <48c624c3-5408-4862-b4ec-9321ad279bf9@proton.me>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <48c624c3-5408-4862-b4ec-9321ad279bf9@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305973-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:esteuwu@proton.me,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:elder@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,riscstar-com.20251104.gappssmtp.com:dkim,riscstar.com:mid,riscstar.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3886E729FF8

On 6/23/26 8:57 PM, Esteban Urrutia wrote:
> On 6/23/26 11:56 AM, Alex Elder wrote:
>> I assume you have implemented this based on what you found in
>> some downstream code.  And if so, could you please indicate
>> where to find that (so I can do some cross-referencing myself).
>> I no longer have access to any Qualcomm internal documentation.
> 
> Hello. Yes, that would be the case. What I used goes as follows.

Thank you very much for sharing this information.

> 1. My personal findings regarding IPA:
> https://gist.github.com/esteuwu/bd49ed67ed9290f41612bdae1cacb5bc

This was interesting to see.  It's something I should probably
document better.  Most everything maps to the downstream code,
but it's not always completely obvious how, because the upstream
driver has evolved substantially.

> Note that these may be subject to errors since I mostly cross-checked
> values to get here.
> 
> 2. SM8450 downstream device tree:
> https://github.com/LineageOS/android_kernel_qcom_sm8450-devicetrees/blob/lineage-20/qcom/waipio.dtsi#L3304
> 
> 3. SM8475 downstream device tree:
> https://github.com/LineageOS/android_kernel_qcom_sm8450-devicetrees/blob/lineage-20/qcom/cape.dtsi#L2624
> 
> It's worth mentioning that between SM8450 and SM8475, IPA SRAM size is
> different, so I used the smaller SRAM size to support SM8475 as well. Hence
> the reason why I included SM8475's downstream device tree as well.

This means that the SRAM size (ipa_mem_data->smem_size) should
possibly be defined in devicetree (as the IMEM address and size
now are).

The SMEM region is used for "IPA filter tables", and access to
it is shared between the AP and the modem.  Unlike the other
(host) memory regions, the size used is *not* included in the
ipa_init_modem_driver_req message that communicates from the
AP to the modem where the regions are, and their sizes.

So it's possible that the size used must actually match what
is expected by both the AP and modem.  If that is the case,
using the smaller size might have problems on whichever
platform (SM8450?) expects the larger one.

So I'm not sure whether using the smaller size for both
platforms is OK; someone from Qualcomm might be able to
answer that question.

> 4. SM8450/SM8475 downstream IPA driver:
> https://github.com/LineageOS/android_kernel_qcom_sm8450-modules/tree/lineage-20/qcom/opensource/dataipa
> 
> Most of my cross-checking came from the source code in this folder.

Yes, "ipa_utils.c" contains a great deal of the information
needed.

> 
> Finally, for some values such as qmap, aggregation, tre_count and
> event_count, I had to cross-check on the same folder that all
> ipa_data-vX.Y.c files reside, since I couldn't find any reference to these
> values in downstream code.

I'll try to explain those things separately.

					-Alex

> Regards,
> Esteban
> 


