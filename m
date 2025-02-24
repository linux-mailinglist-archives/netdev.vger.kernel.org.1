Return-Path: <netdev+bounces-169218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71494A42FDD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF4E1789F1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C101C84D3;
	Mon, 24 Feb 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB5kyk4E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E51C84CC
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435439; cv=none; b=fi6qxV3WfTffG42cuNgVl0d+nrLMzi3tDm5rwg9sixL0hDhE3U2avyTbyFlWEDDyGNC0trIBR1dXxMADv+8d8kCVKQBXFI4bmWYacFaI/cjfattP7of7qwHMhA5lmY6n00lbsnASqpvaFYBswqgKbZdEZ+ET1Ek/GfomxJTrMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435439; c=relaxed/simple;
	bh=6I6gIpt3bVko5RjvZ4H9eDX59jqR3+rvBA+wsQTJsQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB1G0t+lpjC9DdbfgXHfwPlTHNLcfZcqXaqNlS5kGRJfbrZoddAzfuq0EHHOlQwb/5Pj26iZcJKRhIZawprZO3uVqn0LT7yUc9qGVTWJu3havD+T3/zIvuffsq1OG3u34R8QRAGn/EstIr5ZFYsJu8/rFWaxBlSSdq20qE/fgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RB5kyk4E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740435436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VO3ESmQirbqY5so2iTZIj7nmzxGwm5/ayAG9pogSbb0=;
	b=RB5kyk4ERtoCDiuZrGE1+S+xq21V8DHswACsJEwkHIjfMe6x+1tLZurC/+SEDbXzzWncoG
	bdJkaGfki4JMfVzTCy7b1ScyRvicHB7c51zwfv4LuN1pIa+NQKYoixlJxKAVCH5xKD6EUj
	/DpM/4XpE3nq1co7RS/1r5wZyOuMFqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-5xQJlxJtPjG07fMfcPAs2A-1; Mon, 24 Feb 2025 17:17:13 -0500
X-MC-Unique: 5xQJlxJtPjG07fMfcPAs2A-1
X-Mimecast-MFC-AGG-ID: 5xQJlxJtPjG07fMfcPAs2A_1740435433
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f42f21f54so1872989f8f.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 14:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740435432; x=1741040232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO3ESmQirbqY5so2iTZIj7nmzxGwm5/ayAG9pogSbb0=;
        b=qYkWI5TnllMjn76qTb/VdF71LF6RCN3zrxlvqfgL3p2QvWi18GW8QKZ/TfGI0paFVI
         3YMsDMeeNBCJM9YQMF12Pk1i0up6QegE9e7ADW5EhQptC8/mldEZmI5sfmzMh1YnCOTs
         arpGKPFICoiL3uqEzemjp96i6h4epX9VSr65XiWAkWKEOjgQHADeDzSiLSetmWiXMZll
         nrQDJiDCH65wydpX0Iy6I9HySWTNgavfr8IDyc2Zo+5nfbdv9QaoBn1A+hZkiqr7GfY7
         9yKqG5QXVTiftYqR2bYTfUyymdVdJLKLuJg4j2WC3AMVgmqUK8ZuVFeQ1DRBrl3OaG8Y
         4/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWu5nAiVZiWHaQEreygtu55TNPOsOW3wTX4nhoubYgqSsYyNztwq+ROsPcR4/zu9CbC86aYceA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmnDTvi4twn2dGEZ5WJdut3zJy2YS+lHm/op08gXMvy9qOBwS
	90fVWawAIJ67qKbSKe5i99HojJ+zHZZEj5aXCRz4rlI5WIqEQEa2oFEm1ozxuLgja8N2FGICRke
	thz4KDY0Zvc2JRVRgnpSsCv15lHewsBwia6255xKc+1Nls7d+dKsjtw==
X-Gm-Gg: ASbGncs1M3PZqVXuH7JNa0k1ApDnQTIjgcvipt34fIM8P+2c/LOWgPrMc706dUOUsGL
	m3wGEZkgDpVR9J2wtrP7mkgvBML8sa5tdMmZU+SAIVbv2ReVfjmUhj6EiItc/X1gDYUSeMl2T05
	/hTSKetPc3DSaZfiggwGvKOfn1NDd+jIEfvC+gEVT0N67dL9kBVx15q7Aixzv79BL4INGMpZtV2
	014TKP2WFAfobgv5+p9nHCSUp5427ms89ClG5IXW/edzPjXfNwtN/JH443qnUE5WQTrjCDJxzGD
	2Tz90z3zfcgFI8/qVVNITR7TwZbQQfo85YxNow+Eu3o=
X-Received: by 2002:a05:6000:1a85:b0:38d:d759:3dea with SMTP id ffacd0b85a97d-38f707a6294mr9861690f8f.26.1740435432622;
        Mon, 24 Feb 2025 14:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHze0RjPiJrFADXDrPBaNgZTI7fMEu+LsHBcBEYc2raJkpNyOBmQ+s2HpPi82cXscdyWHaANg==
X-Received: by 2002:a05:6000:1a85:b0:38d:d759:3dea with SMTP id ffacd0b85a97d-38f707a6294mr9861672f8f.26.1740435432233;
        Mon, 24 Feb 2025 14:17:12 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1532f20sm4391425e9.8.2025.02.24.14.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:17:11 -0800 (PST)
Message-ID: <3dc42e5c-2944-47d9-9082-9dc347a70802@redhat.com>
Date: Mon, 24 Feb 2025 23:17:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND,PATCH net-next v7 7/8] net: txgbe: Add netdev features
 support
To: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Alexander Duyck <alexander.duyck@gmail.com>
Cc: jiawenwu@trustnetic.com, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemb@google.com>
References: <20230530022632.17938-1-mengyuanlou@net-swift.com>
 <20230530022632.17938-8-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20230530022632.17938-8-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I just stumbled upon the following while working on something slightly
related. Adding a bunch of people hopefully interested.

On 5/30/23 4:26 AM, Mengyuan Lou wrote:
> Add features and hw_features that ngbe can support.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
> @@ -596,11 +597,25 @@ static int txgbe_probe(struct pci_dev *pdev,
>  		goto err_free_mac_table;
>  	}
>  
> -	netdev->features |= NETIF_F_HIGHDMA;
> -	netdev->features = NETIF_F_SG;
> -
> +	netdev->features = NETIF_F_SG |
> +			   NETIF_F_TSO |
> +			   NETIF_F_TSO6 |
> +			   NETIF_F_RXHASH |
> +			   NETIF_F_RXCSUM |
> +			   NETIF_F_HW_CSUM;
> +
> +	netdev->gso_partial_features =  NETIF_F_GSO_ENCAP_ALL;
> +	netdev->features |= netdev->gso_partial_features;
> +	netdev->features |= NETIF_F_SCTP_CRC;
> +	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
> +	netdev->hw_enc_features |= netdev->vlan_features;

This driver does not implement the .ndo_features_check callback, meaning
it will happily accept TSO_V4 over any IP tunnel, even when ID mangling
is explicitly not allowed.

The above in turn looks inconsistent. If the device is able to update
the (outer) IP (and IP csum) while performing TSO, than it should be
able to fully offload NETIF_F_GSO_GRE: such offload should not be
included in the partial ones.

Otherwise, if the device is not able to perform the mentioned tasks, the
driver should implement a suitable ndo_features_check op, stripping
NETIF_F_TSO for tunneled packet that could be potentially fragmented,
that is, when `features` lacks the `NETIF_F_TSO_MANGLEID` bit.

Alike what several intel drivers (ixgbe, igc, etc.) do.

Assuming I did not misread something relevant, and the above is somewhat
correct, I'm wondering if we should move the mentioned check into the
core; preventing future similar errors and avoiding some driver code
duplication.

Something alike the following, completely untested:
---
diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318e..2fdfcddf9c3b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3668,15 +3668,6 @@ static netdev_features_t gso_features_check(const
struct sk_buff *skb,
 		return features & ~NETIF_F_GSO_MASK;
 	}

-	/* Support for GSO partial features requires software
-	 * intervention before we can actually process the packets
-	 * so we need to strip support for any partial features now
-	 * and we can pull them back in after we have partially
-	 * segmented the frame.
-	 */
-	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
-		features &= ~dev->gso_partial_features;
-
 	/* Make sure to clear the IPv4 ID mangling feature if the
 	 * IPv4 header has the potential to be fragmented.
 	 */
@@ -3684,10 +3675,24 @@ static netdev_features_t
gso_features_check(const struct sk_buff *skb,
 		struct iphdr *iph = skb->encapsulation ?
 				    inner_ip_hdr(skb) : ip_hdr(skb);

-		if (!(iph->frag_off & htons(IP_DF)))
+		if (!(iph->frag_off & htons(IP_DF))) {
 			features &= ~NETIF_F_TSO_MANGLEID;
+			if (features & dev->gso_partial_features &
+			    (NETIF_F_GSO_GRE | NETIF_F_GSO_IPXIP4 |
+			     NETIF_F_GSO_IPXIP6 | NETIF_F_GSO_UDP_TUNNEL))
+				features &= ~NETIF_F_TSO;
+		}
 	}

+	/* Support for GSO partial features requires software
+	 * intervention before we can actually process the packets
+	 * so we need to strip support for any partial features now
+	 * and we can pull them back in after we have partially
+	 * segmented the frame.
+	 */
+	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
+		features &= ~dev->gso_partial_features;
+
 	return features;
 }


