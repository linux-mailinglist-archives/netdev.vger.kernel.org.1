Return-Path: <netdev+bounces-249368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30600D17575
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C41E3046426
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAC37FF62;
	Tue, 13 Jan 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6viJSGs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOBASqT3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADF192B75
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293627; cv=none; b=HicKhM3z1qVZ9qIwdWifnc59JP8U4Iki+WRG55m2w46urXErO9cLdlfVynobi3+Nw9uKggrBdYuSfwPBpoMj0B7OqiB0evRII3/ZynZhjXTmNSWWXWo0DqGlkfY3e4OXLxHD0QoPa5H9zFGi10E0xs8Ni9ehsXr/Ft4IlhDJ/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293627; c=relaxed/simple;
	bh=5d+Aj25+Wy2MF4TmrP6n9RSDTIyAAa0UhQnWMQPCzl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rwJn7eoN4WiOUrQ1PcHV4jDTd3uoHwGQOJJMF45nrcU8vk0tXT7742rzuL9eb1QIHBVT0JcaCrx3U0OznDoSB7HhM5qNFhphYwyNPpbHr8ZaS6mLzbkgWSczEZYozUNOrDZ1LW6VVcgts9gASDEAd3Sp40stKf+3fczoVucEFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6viJSGs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOBASqT3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768293625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHjif2oseQDGo7ug5NpF3GFGVdnlKLG7ITtzjPbnaog=;
	b=G6viJSGs+8iB6P2EjipVFSJPq9exjvzaAO/NgKmgqr7rU8ArMdgj3OjjScSGMd6bL8UK0J
	t/xRVTJEJ5TV3H41T+1/JXpINuzu4H+kMpX9FQ4KF1KV5I0DmtkhsDUzk4+KPc4cboaFmu
	FHyhVIuajkrtmlrD5ip71WS20DRfqWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-G2Aj-4xxPYCw3rgMHASFBw-1; Tue, 13 Jan 2026 03:40:24 -0500
X-MC-Unique: G2Aj-4xxPYCw3rgMHASFBw-1
X-Mimecast-MFC-AGG-ID: G2Aj-4xxPYCw3rgMHASFBw_1768293623
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432c05971c6so3784088f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 00:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768293623; x=1768898423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHjif2oseQDGo7ug5NpF3GFGVdnlKLG7ITtzjPbnaog=;
        b=JOBASqT3oSJzxTVe8aCAWo1vtyH1azTCxR1KKZCTIqZfwlWkXTBN1Vkcq+9dPP6ixZ
         yD0bKgwK4ub73VmoM97pa87G53nmvYLFnydVdqMpftJ+g5qDqw42Z4m3k9kF6Pn0L3QR
         iYO+gq6WjlwGWXZt2R+bGtI1teO4dqu438yylpVVYX8eEd2hmFIyFhpNogN43HVgtkpH
         DX6XctRdw0NnJqU+G0hmk03TTKt0cPxDuJYmR5LSogZe36CO7q2pf76qY6D9YGB5x2Bu
         F100G25WwoSIad8OatNdhDPgcOVLSqD4ztoXgAvzWPuEbii4EPC2npGol4ChCmBBdEfv
         O1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293623; x=1768898423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHjif2oseQDGo7ug5NpF3GFGVdnlKLG7ITtzjPbnaog=;
        b=hLjlz2vhS9RUDvmhFjTACIlshOUqUNCiMErBXRlZ3NZE3yr2iefc6LFuz1CJUCvW1X
         U0ntUavMipUW3L5yD0CSA8YTaPAkufwNo2FZeOGQ9nFYjqOyKGDhPd4kx1jGGs6BH2xm
         +z2b/VfA0uJ8sN3bNhqxshN1anXTpfdxihuiP0HCeACkAklMwHi7+RzVh06iAR/8xX6Y
         xI+oVuJh9TWNUsf2c+ScSIPyrbDXU8HBl91pSDDy/eP4OAkS0xmt8SD8jhSGAlzpcwQE
         7YyLTAVZaTfWe8c6E+9U3Q0aaS23QaNhY4EsrMtQ1aIyOCfyyKS3Kx2/tRQY181ptAaG
         5flw==
X-Forwarded-Encrypted: i=1; AJvYcCXEZbOowkiO3fpYZIXuBu3tazUzAiV3dQtUN/paEfLaj+5ijSPSgZ3RQMmG+FN1vA1DwEPRhPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvhkzn73ESwJcgenSIc6R1hRJm5631BvbbnhG+pfoSTg5uxh1O
	d05SmfG1MgvvgzBitBkl9OOYt32T8adSQ5d1Ki8DEoey7MRUWoMHrIO/wygO17e4C9//hXHQ5F7
	xyO87yiAEGyP9wJPU6gCgaUWY1EXsYCJMOxhC5l4f41JzZ1ZKos70oyEJjchj2qJfMA==
X-Gm-Gg: AY/fxX5SNKpX/KQ1d33rng/KT0z71owHDDy8RdKt5Dk9HpWLJJVC7+A/PaWcapVKffS
	ZIhMkbPCQLijDFeRbVHfguprhU8ATSkUtCBB+nL0JWCJOGtOJv4AjQOmWHtSWC3sdzukSBkyKlV
	2jfcN5G2+6OlBKvwRlxPZ9vPlpuJRTZJ7DA8+tKxQgAcDaiGb0y6S54ZCVl1B7qj+9Mp78RuJgF
	R6IOVtW6VcSIQh7pwMHxHqPeNyieUccZpMbZNoKpapstLk7O1tfhn/Kej2eaRCwf+VWraPllfPK
	NNTU4GbF75qSNlAtvk7RdqWSaBMm008yPMJBI0zTB6ATZhXVgazIVaBJF6RqPWGw8OdWOtkih0U
	ftK6Ip4/k2M+z
X-Received: by 2002:adf:fe88:0:b0:429:ca7f:8d6f with SMTP id ffacd0b85a97d-43423e85ee2mr2411458f8f.15.1768293623024;
        Tue, 13 Jan 2026 00:40:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk7yRVGOvPWgqFM7nh65H8YTuIBt3gIdcaiheePtsBA4Ith3KNqhyBQU540bDN6V7F+wYHVA==
X-Received: by 2002:adf:fe88:0:b0:429:ca7f:8d6f with SMTP id ffacd0b85a97d-43423e85ee2mr2411430f8f.15.1768293622645;
        Tue, 13 Jan 2026 00:40:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm43668352f8f.43.2026.01.13.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:21 -0800 (PST)
Message-ID: <a9dcc27d-521e-44b0-b399-c353ef50077a@redhat.com>
Date: Tue, 13 Jan 2026 09:40:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
 <20260106095243.15105-2-maklimek97@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260106095243.15105-2-maklimek97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 10:52 AM, Mariusz Klimek wrote:
> @@ -177,8 +178,13 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
>   */
>  static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>  {
> -	unsigned int hdr_len = skb_transport_header(skb) -
> -			       skb_network_header(skb);
> +	unsigned int off = skb_network_offset(skb) + sizeof(struct ipv6hdr);
> +	unsigned int hdr_len = skb_network_header_len(skb);
> +
> +	/* Jumbogram HBH header is removed upon segmentation. */
> +	if (skb_protocol(skb, true) == htons(ETH_P_IPV6) &&
> +	    skb->len - off > IPV6_MAXPLEN)
> +		hdr_len -= sizeof(struct hop_jumbo_hdr);

IIRC there is some ongoing discussion about introducing big tcp support
for virtio. Perhaps a DEBUG_NET_WARN_ON_ONCE(SKB_GSO_DODGY) could help
keeping this check updated at due time?

@Jason: could you please double check if I'm off WRT virtio support for
big TCP?

/P


