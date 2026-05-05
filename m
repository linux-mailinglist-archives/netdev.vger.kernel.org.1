Return-Path: <netdev+bounces-284272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMZ8A5Wy+Wld/AIAu9opvQ
	(envelope-from <netdev+bounces-284272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:04:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B94C918F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA5B300E730
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0B3BE16A;
	Tue,  5 May 2026 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAd/ep8C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGTbNZVA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541D38AC90
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971561; cv=none; b=fG5+slVtxZsXwUvCkxyfcFIuQBss8dJfPZRpQaSz3rhaxy6y+uIYrhEynNV0SPRDs5JM1ORv0ZHu4FHkiFH8JIOW0icYQp1nDGcavbYM3cSFGI4TykEOB1N0y5zgTtBOS3/LE31Q2SbRbavO4+PCJsXH8Wt9ZXpoVwFuU5RfLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971561; c=relaxed/simple;
	bh=CHfzsbBBWkt442uo449ObgtnuSTM8h9Xz+UeThmzFOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKMhYtCjtJ1yWE8WK3Ba4gyngVjDL3MSaOKyZK49fC8ztfT5dpt5MyQakIHbTppbsXrF/r+Przh2bs9czeY2wd2408SSecjKdWJdA5xxkiAQoo+0PRMuCkHExCviHmzo2aTF12g1gHi/He4bHMIHMW9p8rey0h8ZwAVyqgeiV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAd/ep8C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGTbNZVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777971558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
	b=gAd/ep8CUNH7HQwq8zUjoU7MeyNPlL6R4xPaaiV3HAQq8fi/pAHNW7rhwHYc+jGxovA+uF
	giaTaxTFHFFks0NPoyadeXRkM5t3Z8png268IMxGRzWwHfZDDadJePFDaN8zzdCI9bwSiC
	O53+kdG7zTrA0dGBT9QwLROC9OzBrTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-y5pASOb_NaKD5IBiPUn-Ag-1; Tue, 05 May 2026 04:59:16 -0400
X-MC-Unique: y5pASOb_NaKD5IBiPUn-Ag-1
X-Mimecast-MFC-AGG-ID: y5pASOb_NaKD5IBiPUn-Ag_1777971556
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d035e8593so12934215e9.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777971555; x=1778576355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
        b=OGTbNZVAbvXa0QCpzGF/gEd1atRftGjJVX9OniclUCDeDPa7vxtlr/RAgg7DuJkzgy
         GfD6vMwMjCk0T2G+e3EEavpbEsUJbRlgulmg2vfLouNsDwV054jTkRlGz9DPz0xTJQNa
         yXcciymXL4/9Qh2BeCA5Q/R8cGs0jMZhS/TbG+bs5KiZloB6194W/zwIfobTSgK0eVpG
         oaAJ4IOfr2paYH85vjhdOMb6EMrrOZ7kl6hgk3Ns7BRJbE5NtgQzAhVTBz1xKNcUP294
         PGuF1M4rTT1G49ngdsSEz6BFaDCe1piheWYhB68UFz4Wnt8OkW0o/eaxpPuWav1zP0wD
         3BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971555; x=1778576355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
        b=fy4zNysaShMUNxdq4NHb4LtcaM6n14X9mUoYfXjyKjTvPDTn/y/KpT69MOT6SezICs
         oDtV5MLaEJBDcBI8q51Z53v1quNd3sIavkwV8PUqxr6cEAZmBuVmI8ko7i4C1q/9y/2M
         6Jan7gjlQAm+Prp/AjP6eS33cpWWUM4uI2HDyjFvclhSZNiSUWrK4+9vx59uA6I9so8c
         ORVYk9E91fiS6yq9BGp7ZmTN4O5tiQc1RrrAM4/j979kOfM7C7v5MIP+KFWrKtI1wEqp
         I5OXO51EioPoWRtrtjEihwggy89BsRgdwcvnsAj1+KNoOTCpJDL/g7dFBLjAf/L9KK1r
         C1zw==
X-Gm-Message-State: AOJu0YxivwE5c85LtOpTcCQXC73CY2aMCo0iRxHLFYiPM9iS+IpGYjNP
	gQNdPWPaaI5gR8Eu8FMJUSgtFKYew935rmvIr7rAOxoGP32T6CtNlHTprCE0rAeMtT8GWSgTBhy
	LjxiOdbO19OXi6glBe8McHwnoZIveqpijApSJYYGcw0nyy0CrHMJ8uCgkaQ==
X-Gm-Gg: AeBDievAHVMvqhJG7utcgC5qOrsBoXVTsnjMAKROtHI3DWYVl6uPAkceZwsqHryETPa
	GPhZDni2XCN32zLd3ow+jLRHN3zMNldxOzslSl8h+S/S0RWsnl4sf1F4G2IZh1GJ4zWGbSshFUI
	Tpzr/QWRfC4YxYSqHgNa4ymcahPTfa23K5bURZcqkgdyDOunffLGT4ikTbRil0xJWiBtStEpvO4
	Z0rpyVVbLBI1RwjyuUd1ci6PkMkP8/wibWSxE0gVeFKzVtotbFJeiNpdXVL4sIiAxDPXKiLEsKq
	Sb2zYKT6SmC36fovftjuSlbttmIGu0tI7e+KJMD1clcK5lwm5omZmnUiI+e6HhTcKInVPTnReLR
	rTe/ozN7ZN3nvpqySrAv6jwG3Q13Lf6Gxg8w7tTAk0dqizLoAE42yywXrEL+I2S/eiBs=
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48d03b401f5mr161071335e9.22.1777971555628;
        Tue, 05 May 2026 01:59:15 -0700 (PDT)
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48d03b401f5mr161070775e9.22.1777971555194;
        Tue, 05 May 2026 01:59:15 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d184ed3b0sm12329145e9.34.2026.05.05.01.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:59:14 -0700 (PDT)
Message-ID: <6324783e-b5c8-462d-8cf7-f6cc9c01ea89@redhat.com>
Date: Tue, 5 May 2026 10:59:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/15] net: enetc: add basic operations to the
 FDB table
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-5-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430024945.3413973-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C5B94C918F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284272-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]

On 4/30/26 4:49 AM, Wei Fang wrote:
> The FDB table is used for MAC learning lookups and MAC forwarding lookups.
> Each table entry includes information such as a FID and MAC address that
> may be unicast or multicast and a forwarding destination field containing
> a port bitmap identifying the associated port(s) with the MAC address.
> FDB table entries can be static or dynamic. Static entries are added from
> software whereby dynamic entries are added either by software or by the
> hardware as MAC addresses are learned in the datapath.
> 
> The FDB table can only be managed by the command BD ring using table
> management protocol version 2.0. Table management command operations Add,
> Delete, Update and Query are supported. And the FDB table supports three
> access methods: Entry ID, Exact Match Key Element and Search. This patch
> adds the following basic supports to the FDB table.
> 
> ntmp_fdbt_update_entry() - update the configuration element data of a
> specified FDB entry
> 
> ntmp_fdbt_delete_entry() - delete a specified FDB entry
> 
> ntmp_fdbt_add_entry() - add an entry into the FDB table
> 
> ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
> port based on RESUME_ENTRY_ID.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/ntmp.c   | 203 +++++++++++++++++-
>  .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
>  include/linux/fsl/ntmp.h                      |  44 +++-
>  3 files changed, 305 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> index c94a928622fd..4ed8d783a9a2 100644
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /*
>   * NETC NTMP (NETC Table Management Protocol) 2.0 Library
> - * Copyright 2025 NXP
> + * Copyright 2025-2026 NXP
>   */
>  
>  #include <linux/dma-mapping.h>
> @@ -21,11 +21,15 @@
>  /* Define NTMP Table ID */
>  #define NTMP_MAFT_ID			1
>  #define NTMP_RSST_ID			3
> +#define NTMP_FDBT_ID			15
>  
>  /* Generic Update Actions for most tables */
>  #define NTMP_GEN_UA_CFGEU		BIT(0)
>  #define NTMP_GEN_UA_STSEU		BIT(1)
>  
> +/* Query Action: 0: Full query, 1: Only query entry ID */
> +#define NTMP_QA_ENTRY_ID		1

Sashiko noted that the above comments looks inconsistent with the update
code, where NTMP_QA_ENTRY_ID apparently uses a full query, and 0 just
the entry ID.

If you have to repost for other reasons, please fix this. Note that you
should reply on the ML to sashiko reviews ruling out invalid comments.

Thanks,

Paolo


