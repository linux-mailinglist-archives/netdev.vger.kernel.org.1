Return-Path: <netdev+bounces-208827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8389B0D4C7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8577A6D55
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1152BEFE8;
	Tue, 22 Jul 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1f7NY5C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90602D23BC
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173401; cv=none; b=W5zeNs95A09au2U6RcH4xJpkWM7cVkvKL/GU2zdyUiR+2reaGAiLDAoMe38gbwCmXpLyyu6jyY1nTY5kCsBuLy84K8z6PudclK5cWLKNxV3guo9KvOzOWgXs7tnTlAHqhC7bJONETzBSIqNn+w5rBB4VxyuyikwrGPFENht3uVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173401; c=relaxed/simple;
	bh=wNliSoTcua4ZI5Uh3yJ1tul76CVVgm+R8c7tgQHEW0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2ER3BTT9NHYTLfz6GXeE4eTxGDmpd3J7PPkm2j2cv+vhoSKP35sUIULTj5sbXKZTJ8dZa/HLz2h+j73Zs13Sky76dkcaaTPpsdzPALPoAMJ1fj0EiB9bT7VWU6/a7ZEiGpMBeFT6iu170zDQiRV715XYuC8QweaZgIhpIllBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1f7NY5C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753173396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7XQEQoPcNWIcIvp9Ofoqco5TAp1Io1j1Kf8hikrefc=;
	b=a1f7NY5C183nfxKcgjlorgHQ9hBnODCIE4NDo9oB5MWTVT7Kc8Y0fcWplkB/HEbq+jIhoE
	ELS6Tx8Gy4IxzeRu9sdCtSqokUr0cE5yuK9jPfURLVqZ7vXQdTFZWp8wRWWKrFWREqliuK
	x9qPOaWasN/s88ZfPWaembCC48bK3Fs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-L-P14zjSNkuFE0-cDLsHGw-1; Tue, 22 Jul 2025 04:36:35 -0400
X-MC-Unique: L-P14zjSNkuFE0-cDLsHGw-1
X-Mimecast-MFC-AGG-ID: L-P14zjSNkuFE0-cDLsHGw_1753173394
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so47837905e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753173394; x=1753778194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7XQEQoPcNWIcIvp9Ofoqco5TAp1Io1j1Kf8hikrefc=;
        b=ca/ZHG7ur/HA4j7epbJZIgufdp+s8BH7EXlb30xnVGktDBxaAl1GmKdLYBDE3A/ywt
         CtRIUzOdyqtpJt+f+tBOAl+KdzS8dGMkBhQ/getXa5gGAeB58aQ0HwyTXkpaCdVxY9Ew
         awfzQa9Z+bdLgqs7N94JXPeB5+t5P4K3CYhe5aPcQUIx8V8n57DRExPQEvojn6nVD1cV
         QwpWk7CWE+QF7K8oWX8CoscYNx6TIQMdFoar30PWCi4q4DiNJ26XteMcwBvsyGWR5YdV
         0c+dWIxN9BCGnB48fjH9Rnwv50PdvYT6tH4noIaMA5N0Edn3zEG1ueZA/2fC6C1dG74y
         IpRw==
X-Forwarded-Encrypted: i=1; AJvYcCXY0yJXaVKYq1aSzynFpZ4u1rkozkQBZ4a8OhVRfxI/VsaDT/pYvqvrjyyXishWRsKVkubBNqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGG2kqnweJFvEi8bToVkkQOaStsmsHPZmCYVz02ITchLCVVRr
	TaegNlZQEDeOtybdkjxBiL8C7et9LxdTD63o/S9WNqRE4wKRWNQzL8+fipN+RUdNReojF+4YVq1
	o9VARBnYFGMCk79bB+4QLpsyGsgfOR+AZDBrckSZ0boWu5GoYyCT6WPUdOQ==
X-Gm-Gg: ASbGncvCyQbWF8x2SHdSxQLvgUPEor/fGYX5iGJ7B9C2ALo5b96nWlUzBll8Zu/8YU6
	hE7RHP3UqE6zWkpkwmL46sedJlUzVIKO0KCaXGIElRHdCVJZ8/rVB8uiUvzNklU77KIKvhv0exf
	UR8bV6LATEK5T1RDun0tZ9YKUmmkFEf87CCKZJ1kulWpDkiwnxWmidjtR6lkB+IVkiv1Rucwnr8
	hqK1YbTWkwyi3EIgHgomgibLJokxuOBDWCq2T13CyH7EPXZhiUZWyyEuQU7z0BQxX/M9uSvddPC
	ArTYju4tDVgW6oc4IUZIHBUXhoQrkS37f2OVpQ0B/cND8J2yb6/5e5jhuCpyXWIkXcs9FW/wA4y
	dxEkT9zTVIwQ=
X-Received: by 2002:a05:600c:45ce:b0:456:2397:817 with SMTP id 5b1f17b1804b1-4562e2380b9mr237690785e9.13.1753173393902;
        Tue, 22 Jul 2025 01:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH74FWVoogxQd474DB1B8BF7hhbdi5L1dIVdTms3cbtnlf23yWty5IyX9qpejKuhm6BtyG6+Q==
X-Received: by 2002:a05:600c:45ce:b0:456:2397:817 with SMTP id 5b1f17b1804b1-4562e2380b9mr237690365e9.13.1753173393376;
        Tue, 22 Jul 2025 01:36:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm186536825e9.23.2025.07.22.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:36:32 -0700 (PDT)
Message-ID: <5f250beb-6a81-42b2-bf6f-da02c04cbf15@redhat.com>
Date: Tue, 22 Jul 2025 10:36:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250716081441.93088-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 10:14 AM, Felix Fietkau wrote:
> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
> +					 struct sk_buff *skb)
> +{
> +	const struct packet_offload *ptype;
> +	unsigned int hlen, off_pppoe;
> +	struct sk_buff *pp = NULL;
> +	struct pppoe_hdr *phdr;
> +	struct sk_buff *p;
> +	__be16 type;
> +	int flush = 1;

Minor nit: please respect the reverse christmas tree order above

> +	off_pppoe = skb_gro_offset(skb);
> +	hlen = off_pppoe + sizeof(*phdr) + 2;
> +	phdr = skb_gro_header(skb, hlen, off_pppoe);
> +	if (unlikely(!phdr))
> +		goto out;
> +
> +	/* ignore packets with padding or invalid length */
> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
> +		goto out;
> +
> +	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
> +
> +	type = pppoe_hdr_proto(phdr);
> +	if (!type)
> +		goto out;
> +
> +	ptype = gro_find_receive_by_type(type);
> +	if (!ptype)
> +		goto out;
> +
> +	flush = 0;
> +
> +	list_for_each_entry(p, head, list) {
> +		struct pppoe_hdr *phdr2;
> +
> +		if (!NAPI_GRO_CB(p)->same_flow)
> +			continue;
> +
> +		phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
> +		if (compare_pppoe_header(phdr, phdr2))
> +			NAPI_GRO_CB(p)->same_flow = 0;
> +	}
> +
> +	skb_gro_pull(skb, sizeof(*phdr) + 2);
> +	skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
> +
> +	pp = ptype->callbacks.gro_receive(head, skb);

Here you can use INDIRECT_CALL_INET()

> +
> +out:
> +	skb_gro_flush_final(skb, pp, flush);
> +
> +	return pp;
> +}
> +
> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
> +{
> +	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
> +	__be16 type = pppoe_hdr_proto(phdr);
> +	struct packet_offload *ptype;
> +	int err = -ENOENT;
> +
> +	ptype = gro_find_complete_by_type(type);
> +	if (ptype)
> +		err = ptype->callbacks.gro_complete(skb, nhoff +
> +						    sizeof(*phdr) + 2);

Possibly even here but it's less relevant.

> +
> +	return err;
> +}
> +
> +static struct packet_offload pppoe_packet_offload __read_mostly = {
> +	.type = cpu_to_be16(ETH_P_PPP_SES),
> +	.priority = 10,

The priority value should be IMHO greater then the exiting ones to avoid
possible regressions on other protocols. i.e. 20 should do.

Thanks,

Paolo


