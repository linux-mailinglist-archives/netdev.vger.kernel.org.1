Return-Path: <netdev+bounces-305403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ztRAcvVTGpOqgEAu9opvQ
	(envelope-from <netdev+bounces-305403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979071A6CC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bjbhaiuH;
	dkim=pass header.d=redhat.com header.s=google header.b=g7HwghTJ;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305403-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A9F30B7D1C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0B3E44F0;
	Tue,  7 Jul 2026 10:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077563E00B4
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420217; cv=none; b=oEiK4P+Yzu9A4p3WMRHapUXtCDjdvW+e++KPsmBgPWaDACZP0bJTb/1JmE2nHyZ96BblktwrSKKjnHezbhalXiW0CUVm4yhgyJfCToux6ElKqcSxFeyNZXQsdsVtlQHLMarVl5c0IoPVAwSzMUynS00tzoMvgUG8bU8fE3ZuI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420217; c=relaxed/simple;
	bh=6z6CU6EQ+brZROdDnjSW/AgL95ryAiJb7RKNl3DSgo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yg4ZJn7/RlBeBsNma2Qsh1ZbhbnuGqZnMnWGY93ySzImhqCCySHT2U1KsSKuxuvdwOS8HcM10ZxX07nPxdmqh+tuhMhIsCKapJ79UgxyOrx0gbLE8T4FbZLlLFojBuSuwBE6M1KzfVFCCHRE4RWABbmfqbKWMhHjpdoiaOZAhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjbhaiuH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7HwghTJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783420215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoSPVAeyfLAakHdkwoRkZKuwxGIMQEg6NmXCD0Y72LU=;
	b=bjbhaiuHUp7lS5edjMbw0xDFz6MR85leQxmFE32mgnG1bG61EqiLJ0iv86+6MlP4OiKuCp
	SpeJeKX8OiGzAiObXNWxp50qWJsDbziaILLLuPEoc21NklZDUw+3KiEuObVH8YZee8+an9
	9NTs3dMsxuMvoaRTUMjSEvIYr6LqLkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-K_imPixtOEyMd8ZGbWj5tg-1; Tue, 07 Jul 2026 06:30:13 -0400
X-MC-Unique: K_imPixtOEyMd8ZGbWj5tg-1
X-Mimecast-MFC-AGG-ID: K_imPixtOEyMd8ZGbWj5tg_1783420213
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4744b72f90bso2467362f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783420213; x=1784025013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoSPVAeyfLAakHdkwoRkZKuwxGIMQEg6NmXCD0Y72LU=;
        b=g7HwghTJAqV3bRAiaWm45BKCoDtr+T1xD7v0YqsMEHt3iUjF5gj/++kax/nQkJP/ZK
         giY5U5vtQVRS2awio7qCi8DOs10d7EGO9+x1JoFVg5TPY/4Lc6WItl40qHjyqhhk8xJt
         lmm5E2APg7ts5FMqiYuP5SjbpMPs+RtmTAqBdf1XMeyX6DRhyXC10b9CTKGNNO2nWhLa
         63cEjqLCxL/2xnwCaBtBHjqV2vqFBN6Ugiqrm8Dt0hG1MUm+nJAG+b0XlgMGN9Y5lny6
         jBYRJ1OwMEtUfUQDtDRm7SL5Zl+XQS0Zain3/MuCwyrBbhL+NekLHW9hqdkmdq+Ufkly
         NjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783420213; x=1784025013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoSPVAeyfLAakHdkwoRkZKuwxGIMQEg6NmXCD0Y72LU=;
        b=b3Sc5/krBkENfYGQCq2g8EmVM9x2mcHjrHKFdtM2uTCSEl/bvz7w6wJqX09kU2Vwgz
         SmiRomxKLK7aULAbUAfYLpp+8Kap3CDTDzNxVk46PPVjOBfRmdQMezWhQx7Cs1Uvl2Qn
         oNLDUM0p1da/WKO6hTyi+n23SoLFgItJZaBTtjKAhshKwAvuEgKsqq4ZAZytSJw0mLMG
         51HHIn64lShOmZV86PWUu3fPbCXUA0f9wSAf3la0T8Yem3etfUb9SCzXqcE8dGtPRWsM
         zWw49mhMg6AcMytjrLAQr2Sar+sx/L4BuISrTBj1ZA4zgTuWGk6V4FNnSG42i5R8X8s3
         Sr0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoRf/cbPla23AoQhm3cFlaC0R1HC87FfFLZB+fLIkH0ColuJ+Mt9vqB1AwZcR7Bt2gHIozfCeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCn3BmPdsV9c9jPqlx+YOkGMLMqeqhjZU7YDB+MzeNodxjlQCs
	BCLE9S7wPluqripISupUUtCK4MlWtpDr/e84sWa1Qz9oPka1uy3fVEsfFeYZZqKlVGJR6Rqjns2
	4jeKFAPtkne6JxgHCgAndUDDaPgaTbtqwrCTfdQLT2OGuntTprgaR8V63ZQ==
X-Gm-Gg: AfdE7cliZv9qXjDrTwwzFjPm9nBiLC7K3kyYKZ553lK37oLIIH8sAsgDMYWLooJgqsa
	9/HyUCQqoN4gWYnY8cpYZN7I/xNyynT32EzF1jm0MK6h37Rko8luZoc2y72AX9qXC4NKg4yrGXh
	tUeF3xsIiaWEwbwOcut3absT++9DEuviJW0w1DZKgj3z/y7GeW4WpBX/paozV0lpoXyo0kxnksy
	bPPyKOiq+a/E201PQuysRt71xXOV7E7Vm5Wt+AYZEl3M4cYVFDzmLGPNCIETQObGwVq77On4/HZ
	6NKpkI5yGVgPoK1GuHMvbxkKQ6XjkIYzZ/4k/ceOuVgXrhEJV30yWV9YdttBBqTQqQCjoAxyRyl
	LuUmaM5ry4onbDs6teHC4PPTEJvi16MO9O2vzyDAp40jyJ0U+t+4oXMIXmp8M8eNVGu2gw1W+Lb
	ISINb96NUYdt/j
X-Received: by 2002:a05:6000:604:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47de668ef06mr4430905f8f.4.1783420212385;
        Tue, 07 Jul 2026 03:30:12 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47de668ef06mr4430875f8f.4.1783420211781;
        Tue, 07 Jul 2026 03:30:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm35594909f8f.7.2026.07.07.03.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:30:11 -0700 (PDT)
Message-ID: <71a1bacf-c54f-45b0-80df-7175261cf2ac@redhat.com>
Date: Tue, 7 Jul 2026 12:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix link-local addresses being
 forwarded out of slave ports
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Meghana Malladi <m-malladi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701112535.4027920-1-danishanwar@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260701112535.4027920-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305403-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:danishanwar@ti.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:m-malladi@ti.com,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,ti.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7979071A6CC

On 7/1/26 1:25 PM, MD Danish Anwar wrote:
> Link-local multicast addresses (01:80:c2:00:00:0x) must only be
> delivered to the host port (P0) and must not be forwarded out of
> the physical slave ports. icssg_fdb_add_del() was programming these
> addresses with P1/P2 membership bits set, causing the firmware to
> forward them out of slave ports.
> 
> Clear P1/P2 membership and set only P0 membership when
> is_link_local_ether_addr() returns true.
> 
> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_config.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 3f8237c17d099..04a81402e3f3c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -732,6 +732,16 @@ int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
>  	u8 fid = vid;
>  	int ret;
>  
> +	/* Link-local addresses (01:80:c2:00:00:0x) must only be delivered to
> +	 * the host port (P0). Clear P1/P2 membership to prevent the firmware
> +	 * from forwarding them out of the physical slave ports.
> +	 */
> +	if (is_link_local_ether_addr(addr)) {
> +		fid_c2 |= ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
> +		fid_c2 &= ~(ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
> +			    ICSSG_FDB_ENTRY_P2_MEMBERSHIP);
> +	}

Sashiko gemeni mentioned it could be safer to reject entirely wrong masks:

https://sashiko.dev/#/patchset/20260701112535.4027920-1-danishanwar%40ti.com

It's not clear to me if the mentioned bad scenario is actually possibly,
please have a look.

/P


