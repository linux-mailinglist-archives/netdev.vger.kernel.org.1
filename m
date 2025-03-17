Return-Path: <netdev+bounces-175439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59FA65EEB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105BA189D457
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB719D89B;
	Mon, 17 Mar 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I608PoG+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DC46BF
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242791; cv=none; b=aI0f2+wNVAiwOZdMoyk04lVCVSjB0DJIqyOQ61hjqyz2Dw1K0A3h592WzgOnBzQ+C+uHKbcrSl44MKSDjRzY8LYizDPXGlPXy+Bybji89r0XkrkJKOxNAGu3ZI6G5IDTo0mSXJzEneUI6AqrcnCNV6tt8wm0F0AE5gIyFIfX7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242791; c=relaxed/simple;
	bh=ivdODirHIefP7K3JQvSnU9d91nziH5fKrip/ugHoTQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usVpYF1lGdpcG9JJ3diOW7Fy1tKfs/fUgcuDvuHz1BW+Od5+qF2RbubwONYtvFgKEg9qgYS4xBx4okz3g3egXDsdWrtIFe4bIpYHLrbIQEIHE1PRDygfUP5k94H5utNXZDEj1F6xTOjEpr09TiVrTjme2R2ymnY2T3atVgCkeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I608PoG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742242788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai+C6LMUFPCyv30DCRnMAovVCTCm4+s9c4WitChVBug=;
	b=I608PoG+25+BovVUSxbZnIEV1U+nx8gVtouSxlppwPEUxR8vUOoSU8Y7+8PfNcVQ+xEjUX
	42Xs0oAS1fW9dN1vCke+xXZ6j42bvx/q736Um6q12Hz109lya1lR+7pbqkyl9TroP3zxp2
	vAM+TJrquvR9LahOyHBIFQfPHgrLHSE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-arPzZIl-NzmeiCW-Qkexhg-1; Mon, 17 Mar 2025 16:19:47 -0400
X-MC-Unique: arPzZIl-NzmeiCW-Qkexhg-1
X-Mimecast-MFC-AGG-ID: arPzZIl-NzmeiCW-Qkexhg_1742242786
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947a0919aso17752605e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742242786; x=1742847586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai+C6LMUFPCyv30DCRnMAovVCTCm4+s9c4WitChVBug=;
        b=AfJy1OdCpCJpGRARGPdbmu8HJMKmKlbMO12PpB8meG37uyzvEKlZIWQ/Ki9XCXPck6
         oEZ630i9xr5e8VmmTRMo2XR5yyA66yrI92L8LfsrAv836WFU9PF7A4RPegtYiDe99xdO
         F8lgv6Wuou/gCv5MHksn50yDDika5onKtBmD8PjwipO7lvB2gUd9TNyedNCpDaRGAQwv
         EqHLIHBCu3Mn3Qcf+kAtsvW/o9rTz/Y4bRADm+8/QSHVOQBcnMcuT2S+pJCmOPEbOu4+
         GHB8gOpEj1GqL2gG/X1APqS/HYrvmKscpnqdA15vgkReq9s+GaqjHDA9d39dvGSvTK4D
         g+dw==
X-Forwarded-Encrypted: i=1; AJvYcCUh9PnYbTrFN16lo23hMKBgwK/CkOKStFXct0A7C7ryvpkkkNW1DbCB2KSgvjksFaHVkuq1VFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ90fY6RjDOw4wFUIAN+jQjYaFRzZjz6QzQe9Jriix9aD0TLFA
	KpnQug3Femh2RgcYShOcwFUuxuZwrGfH5Ynl2EDx67wVKN73oXNd5N2JDAdaoskASWoQmPTXLt+
	b++/rB/VFKKLp7dn0hTYr3FTRrQk+nkzdBY0/qF92vkJr8M3X9fU3jw==
X-Gm-Gg: ASbGnctQxB6+NS6oiakePPKuatM4uo5fO+01fOgQkxh8gHngVyVFtkNKvPp3cZ1TtZB
	k9uUkvRLTTtoN6hhos0ecGajUVzRflG5UXPYBE6tBRSKJsZpby1QlRTzLDsABrtomDMHbunojWi
	b2c5djM1rCJW6Mt9gHXdTM4VzMEq4qKohghHtNt9vCEqtIJn7XOQVy8At2YXr288eQ71LV6V07l
	hDZAg9zdJQHweV690/4UGwbsy8MfkaiEAr7RRL8ZovOsAu86P0W7NfbjmvGvph9B4JBn6XfZHM5
	c6SHQrkJNu6k3SIz0hFS5HADJRQ1bz/7qhXfG5nL49ng2Q==
X-Received: by 2002:a05:600c:4f8a:b0:43c:fbe2:df3c with SMTP id 5b1f17b1804b1-43d1ecee010mr130382815e9.26.1742242786060;
        Mon, 17 Mar 2025 13:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl53cQgFEVNAA1Wvg3DYpTx8FlNK9oNP5IOyrAIYCUnVTg4ijZdBPacUNBx3+z9qQvSwWMaQ==
X-Received: by 2002:a05:600c:4f8a:b0:43c:fbe2:df3c with SMTP id 5b1f17b1804b1-43d1ecee010mr130382685e9.26.1742242785667;
        Mon, 17 Mar 2025 13:19:45 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b69eesm16138552f8f.34.2025.03.17.13.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 13:19:45 -0700 (PDT)
Message-ID: <f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
Date: Mon, 17 Mar 2025 21:19:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250310072329.222123-1-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 8:23 AM, Gal Pressman wrote:
> Symmetric RSS hash requires that:
> * No other fields besides IP src/dst and/or L4 src/dst
> * If src is set, dst must also be set
> 
> This restriction was only enforced when RXNFC was configured after
> symmetric hash was enabled. In the opposite order of operations (RXNFC
> then symmetric enablement) the check was not performed.
> 
> Perform the sanity check on set_rxfh as well, by iterating over all flow
> types hash fields and making sure they are all symmetric.
> 
> Introduce a function that returns whether a flow type is hashable (not
> spec only) and needs to be iterated over. To make sure that no one
> forgets to update the list of hashable flow types when adding new flow
> types, a static assert is added to draw the developer's attention.
> 
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  include/uapi/linux/ethtool.h | 124 ++++++++++++++++++-----------------
>  net/ethtool/ioctl.c          |  99 +++++++++++++++++++++++++---
>  2 files changed, 153 insertions(+), 70 deletions(-)
> 
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 84833cca29fe..d36f8f4e3eef 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -2295,71 +2295,75 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>  #define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
>  #define	RXH_XFRM_NO_CHANGE	0xff
>  
> -/* L2-L4 network traffic flow types */
> -#define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
> -#define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
> -#define	SCTP_V4_FLOW	0x03	/* hash or spec (sctp_ip4_spec) */
> -#define	AH_ESP_V4_FLOW	0x04	/* hash only */
> -#define	TCP_V6_FLOW	0x05	/* hash or spec (tcp_ip6_spec; nfc only) */
> -#define	UDP_V6_FLOW	0x06	/* hash or spec (udp_ip6_spec; nfc only) */
> -#define	SCTP_V6_FLOW	0x07	/* hash or spec (sctp_ip6_spec; nfc only) */
> -#define	AH_ESP_V6_FLOW	0x08	/* hash only */
> -#define	AH_V4_FLOW	0x09	/* hash or spec (ah_ip4_spec) */
> -#define	ESP_V4_FLOW	0x0a	/* hash or spec (esp_ip4_spec) */
> -#define	AH_V6_FLOW	0x0b	/* hash or spec (ah_ip6_spec; nfc only) */
> -#define	ESP_V6_FLOW	0x0c	/* hash or spec (esp_ip6_spec; nfc only) */
> -#define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
> -#define	IP_USER_FLOW	IPV4_USER_FLOW
> -#define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
> -#define	IPV4_FLOW	0x10	/* hash only */
> -#define	IPV6_FLOW	0x11	/* hash only */
> -#define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
> +enum {
> +	/* L2-L4 network traffic flow types */
> +	TCP_V4_FLOW = 0x01, /* hash or spec (tcp_ip4_spec) */
> +	UDP_V4_FLOW = 0x02, /* hash or spec (udp_ip4_spec) */
> +	SCTP_V4_FLOW = 0x03, /* hash or spec (sctp_ip4_spec) */
> +	AH_ESP_V4_FLOW = 0x04, /* hash only */
> +	TCP_V6_FLOW = 0x05, /* hash or spec (tcp_ip6_spec; nfc only) */
> +	UDP_V6_FLOW = 0x06, /* hash or spec (udp_ip6_spec; nfc only) */
> +	SCTP_V6_FLOW = 0x07, /* hash or spec (sctp_ip6_spec; nfc only) */
> +	AH_ESP_V6_FLOW = 0x08, /* hash only */
> +	AH_V4_FLOW = 0x09, /* hash or spec (ah_ip4_spec) */
> +	ESP_V4_FLOW = 0x0a, /* hash or spec (esp_ip4_spec) */
> +	AH_V6_FLOW = 0x0b, /* hash or spec (ah_ip6_spec; nfc only) */
> +	ESP_V6_FLOW = 0x0c, /* hash or spec (esp_ip6_spec; nfc only) */
> +	IPV4_USER_FLOW = 0x0d, /* spec only (usr_ip4_spec) */
> +	IP_USER_FLOW = IPV4_USER_FLOW,
> +	IPV6_USER_FLOW = 0x0e, /* spec only (usr_ip6_spec; nfc only) */
> +	IPV4_FLOW = 0x10, /* hash only */
> +	IPV6_FLOW = 0x11, /* hash only */
> +	ETHER_FLOW = 0x12, /* spec only (ether_spec) */
>  
> -/* Used for GTP-U IPv4 and IPv6.
> - * The format of GTP packets only includes
> - * elements such as TEID and GTP version.
> - * It is primarily intended for data communication of the UE.
> - */
> -#define GTPU_V4_FLOW 0x13	/* hash only */
> -#define GTPU_V6_FLOW 0x14	/* hash only */
> +	/* Used for GTP-U IPv4 and IPv6.
> +	 * The format of GTP packets only includes
> +	 * elements such as TEID and GTP version.
> +	 * It is primarily intended for data communication of the UE.
> +	 */
> +	GTPU_V4_FLOW = 0x13, /* hash only */
> +	GTPU_V6_FLOW = 0x14, /* hash only */
>  
> -/* Use for GTP-C IPv4 and v6.
> - * The format of these GTP packets does not include TEID.
> - * Primarily expected to be used for communication
> - * to create sessions for UE data communication,
> - * commonly referred to as CSR (Create Session Request).
> - */
> -#define GTPC_V4_FLOW 0x15	/* hash only */
> -#define GTPC_V6_FLOW 0x16	/* hash only */
> +	/* Use for GTP-C IPv4 and v6.
> +	 * The format of these GTP packets does not include TEID.
> +	 * Primarily expected to be used for communication
> +	 * to create sessions for UE data communication,
> +	 * commonly referred to as CSR (Create Session Request).
> +	 */
> +	GTPC_V4_FLOW = 0x15, /* hash only */
> +	GTPC_V6_FLOW = 0x16, /* hash only */
>  
> -/* Use for GTP-C IPv4 and v6.
> - * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
> - * After session creation, it becomes this packet.
> - * This is mainly used for requests to realize UE handover.
> - */
> -#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
> -#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
> +	/* Use for GTP-C IPv4 and v6.
> +	 * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
> +	 * After session creation, it becomes this packet.
> +	 * This is mainly used for requests to realize UE handover.
> +	 */
> +	GTPC_TEID_V4_FLOW = 0x17, /* hash only */
> +	GTPC_TEID_V6_FLOW = 0x18, /* hash only */
>  
> -/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
> - * The format of these GTP packets includes TEID and QFI.
> - * In 5G communication using UPF (User Plane Function),
> - * data communication with this extended header is performed.
> - */
> -#define GTPU_EH_V4_FLOW 0x19	/* hash only */
> -#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
> +	/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
> +	 * The format of these GTP packets includes TEID and QFI.
> +	 * In 5G communication using UPF (User Plane Function),
> +	 * data communication with this extended header is performed.
> +	 */
> +	GTPU_EH_V4_FLOW = 0x19, /* hash only */
> +	GTPU_EH_V6_FLOW = 0x1a, /* hash only */
>  
> -/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
> - * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
> - * UL/DL included in the PSC.
> - * There are differences in the data included based on Downlink/Uplink,
> - * and can be used to distinguish packets.
> - * The functions described so far are useful when you want to
> - * handle communication from the mobile network in UPF, PGW, etc.
> - */
> -#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
> -#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
> -#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
> -#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
> +	/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
> +	 * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
> +	 * UL/DL included in the PSC.
> +	 * There are differences in the data included based on Downlink/Uplink,
> +	 * and can be used to distinguish packets.
> +	 * The functions described so far are useful when you want to
> +	 * handle communication from the mobile network in UPF, PGW, etc.
> +	 */
> +	GTPU_UL_V4_FLOW = 0x1b, /* hash only */
> +	GTPU_UL_V6_FLOW = 0x1c, /* hash only */
> +	GTPU_DL_V4_FLOW = 0x1d, /* hash only */
> +	GTPU_DL_V6_FLOW = 0x1e, /* hash only */
> +
> +	FLOW_TYPE_MAX,
> +};

I fear we can't replace macros with enum in uAPI: existing application
could do weird thing leveraging the macro defintion and would break with
this change.

I think you could simply add:

#define FLOW_TYPE_MAX 0x1f

Thank,

Paolo


