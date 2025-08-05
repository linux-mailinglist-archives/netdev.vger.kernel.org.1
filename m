Return-Path: <netdev+bounces-211656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C41B1AF4B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA88189BECF
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 07:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AE239E61;
	Tue,  5 Aug 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9eLQCdT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D622D4C0
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378544; cv=none; b=M/EBdt/q/Znkkg+AuMsKRHA94Y7vFIgnGJ7hnZYxolfp631xHT3pk8tfGj3gwALrMoI8fu/sKnHmx+0L/Td6OeBWW2uh/PL7977zSWhjR1YMDnT4nOX8PQ1lZ5kMdGaqHGCR+aH7lOY22AdB6f/fq+m7RzDOkmlyR+9qVXuoTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378544; c=relaxed/simple;
	bh=Rk0SHI+PWqhqEbwPZy9Q1SRiwPsOpKQ9ER7M3n76sCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p20S92lR0dPIBaq6XkEdqyG+t0HD1pY86leBSRoU+r5Cs4rq887zC0vk5XXffXhmKq3pVg/GRbhmOgnM7NG0caf/8FuFgU19TwLiwg88ywOIBRnTXUg7U4QFnVXLylbKGdPPJppYQFg58n2W5JGkL6zAm6CoC2aPHAyM96phqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9eLQCdT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754378541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxjW/XUa/Tox1i570xeV1gDkoladwDp8K5HU/5Xe5bM=;
	b=e9eLQCdTl9VMlMeMi5EBs8DCdN5Q4CVlEgD/DG2/wL3UeoStEsgF1v2rn1Ta+3LHqkl8XE
	NQTgWsaMLE5Y0YD8SynBz4NZ/3IazAG/jz4UIIDw5YQr0DtZ8SwSfvbgHYKdeCIhDuezzx
	kYh2jP1jyfJm9e+gP9TUAxFm37UAoxw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-6KaT8YiuP8O14WFv8JIAKw-1; Tue, 05 Aug 2025 03:22:20 -0400
X-MC-Unique: 6KaT8YiuP8O14WFv8JIAKw-1
X-Mimecast-MFC-AGG-ID: 6KaT8YiuP8O14WFv8JIAKw_1754378539
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4aedcff08fdso85389651cf.2
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 00:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754378539; x=1754983339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxjW/XUa/Tox1i570xeV1gDkoladwDp8K5HU/5Xe5bM=;
        b=Ota2ve7FNDKUf/KqxZMZGef/z9dCuE+t/cAP80PK9YA+Gx0/zbsBrw5b56sxGuJkFm
         L/3nfN903d+dnM7/Do7XTQRRBOG1pT0xbNOyxyOjiIFnVG3byiQF63VDZ2erDdgWM0Ic
         zCa/WmdDagymSAWuf8fBZrn6p85AKaHGZclQzPmCgHB1nfM7z8bP46/q3hbV+OVgKjn4
         ygi/NWefLCmLLAkSxWlrbEBMZuFfdqNmfnSbDwM8XtiJP6/xwM/68PlKEk1u+kurOhgU
         OkujJqtW6tKx45WPc6c1RvwgkD7PLkv1qToFRP2ceKJ24IahEjeALxSVPaKG+wiGkYyA
         8BNg==
X-Forwarded-Encrypted: i=1; AJvYcCVgh4P2J91qaB6mBq/ZnqLJ0VMjvwVDxfImRjyKfYTpWmP7iaLSckrtUegufTOiffoQaVZ+S3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbFtlh0Cq8a92Eq8/OSrOtLgblIkBR1qWDdjiDnGJVu7KUU6S
	Oe2p4afAhsisgBy7Q+NlKhmHqhrbEyZDZgMdhuJHaqiEEu1wigm2bzCcRp/bHME+AGI7EGkNRIQ
	SPDFrz8aQrHdrIKuFN80E5YD2T47b3o6Z3rh7htQ0awLmQE6xEiLNRmz3GQ==
X-Gm-Gg: ASbGncvDdxW+pQtoDgOsDpbIkJuZCIFXbPFKyknx1XcbAYgThl0Aif4mduSp8bGADUl
	v/PwLEcX+T+H9R4txf6gLjFeXEDm7fl8VnbUbhYdk9EDgvfmz5FSNIbFEzM47QndDzgVT6MnoME
	ZUFbCdVT/7kncQKT1kXANrXFELUYvfSNLeuSQl/laD0xPdVCbO4xYq18cvIViY1kgGkGRa3Oqm+
	qIeAa2yy8cbZQ0u8JoZ8kso4cS8mN6yG8uzKi/CDWyVyNSmmVOq50k/tpLobSuB7sDrPJdnon5p
	C9cJziz4kOQZLc3ulOClf+LmbrhLf3bFp3upG35twtllsCb4mBPh7gss80vJZQAIN5VZJQ83Spy
	TOBNFzdbgZdETZ6M=
X-Received: by 2002:ac8:598c:0:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b07298225dmr65010501cf.51.1754378539393;
        Tue, 05 Aug 2025 00:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFGbWbc/7vsrqHQg02yIUPn2Mkudvs+7LqNqnEBlCgK40SEkxmxEpp0vQ/78kK5UTY0baeg==
X-Received: by 2002:ac8:598c:0:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b07298225dmr65010161cf.51.1754378538873;
        Tue, 05 Aug 2025 00:22:18 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06f790834sm19298781cf.60.2025.08.05.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:22:18 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:22:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bsdhenrymartin@gmail.com, huntazhang@tencent.com, jitxie@tencent.com, 
	landonsun@tencent.com, bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, Henry Martin <bsdhenryma@tencent.com>, 
	TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH] VSOCK: fix Integer Overflow in
 vmci_transport_recv_dgram_cb()
Message-ID: <bpm2jqi4qv5mkzikcazchdpzb2ztqhwldpyi6wyfowqsqsaobj@pltf2mfrbf7a>
References: <20250805041748.1728098-1-tcs_kernel@tencent.com>
 <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>

On Tue, Aug 05, 2025 at 03:07:38PM +0800, Wang Liang wrote:
>
>在 2025/8/5 12:17, bsdhenrymartin@gmail.com 写道:
>>From: Henry Martin <bsdhenryma@tencent.com>
>>
>>The vulnerability is triggered when processing a malicious VMCI datagram
>>with an extremely large `payload_size` value. The attack path is:
>>
>>1. Attacker crafts a malicious `vmci_datagram` with `payload_size` set
>>    to a value near `SIZE_MAX` (e.g., `SIZE_MAX - offsetof(struct
>>    vmci_datagram, payload) + 1`)
>>2. The function calculates: `size = VMCI_DG_SIZE(dg)` Where
>>    `VMCI_DG_SIZE(dg)` expands to `offsetof(struct vmci_datagram,
>>    payload) + dg->payload_size`
>>3. Integer overflow occurs during this addition, making `size` smaller
>>    than the actual datagram size
>>
>>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>Reported-by: TCS Robot <tcs_robot@tencent.com>
>>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>>---
>>  net/vmw_vsock/vmci_transport.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>>index 7eccd6708d66..07079669dd09 100644
>>--- a/net/vmw_vsock/vmci_transport.c
>>+++ b/net/vmw_vsock/vmci_transport.c
>>@@ -630,6 +630,10 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
>>  	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
>>  		return VMCI_ERROR_NO_ACCESS;
>>+	/* Validate payload size to prevent integer overflow */
>>+	if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
>>+		return VMCI_ERROR_INVALID_ARGS;
>>+
>
>
>The struct vmci_datagram has no member 'payload'. Your patch may 
>trigger compile error.

@Wang thanks for the highlight!

mmm, so this is the 3rd no-sense patch from the same author!

Last advice for the author, please fix your bot and try your patches 
before submitting it!

Stefano

>
>>  	size = VMCI_DG_SIZE(dg);
>>  	/* Attach the packet to the socket's receive queue as an sk_buff. */
>


