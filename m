Return-Path: <netdev+bounces-213646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD196B26156
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C746A26741
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAF2EACE7;
	Thu, 14 Aug 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4OwP0Fj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5502E8E1A
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164392; cv=none; b=fLWFjCL/8zoMuOxyUVdp0sjYmRh+s63cwMnanNDOIRBCvfUVVSa6cRHN+U/6sxi/P/HP4pUQe/jCQ98d2y8SI0RYPlkniwJEp/wmzIu/iVR14Ln2QeBth5rfvJoSl9y1PpzCAAHDT/RBqyvY5sIq/AJwhJqzOt5+8KbmcbLSJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164392; c=relaxed/simple;
	bh=FRRUfXI/ueu8DUzYG3Pmy8P6iL6jtRJqIvtumIS4VDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOBqu7WPF6yyf5B6di8A68OSrmIoLFuRec86WBwrDC3SDqvROo3o01SUoUJiR6UACVn6mKwxOzMm9cLFAn+7ZlGCe7bQ6EUfpAMSkt2izamz4Q4wf5BueeWzfKSBHx57I+K3xWbi54thvNARuX/pmnnJkfRrebeTUm4emf6+t5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4OwP0Fj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755164389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRRUfXI/ueu8DUzYG3Pmy8P6iL6jtRJqIvtumIS4VDE=;
	b=a4OwP0Fjmo6wlmj+XnXav7zChPvSHxDVHjZ8X8c/C0x8ljiqBt/bBLwb4PRuW4Zcf9WdEw
	oJJx/VUw9EaJeVPD8WEECKqyjOGGjuiSwUzNdxq8yjnQ87/z38SArvxVdnhMGb5DpnrlYi
	Ii3VpSIro1ecWJ7qbEt6sjAGhGHp1Js=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-e1MOtI-SNIyPSv6PVdeSng-1; Thu, 14 Aug 2025 05:39:45 -0400
X-MC-Unique: e1MOtI-SNIyPSv6PVdeSng-1
X-Mimecast-MFC-AGG-ID: e1MOtI-SNIyPSv6PVdeSng_1755164385
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8705feefaso201125885a.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755164385; x=1755769185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRRUfXI/ueu8DUzYG3Pmy8P6iL6jtRJqIvtumIS4VDE=;
        b=BbLuBeEN4F+PsvrGuIsmpfmTKjI6Uuq8oiMKJcKNPVH5aa/bYgsRSIc2jXjm3/XEQy
         91LUoPc4hOX9PmrUJL9gl/rUa0IAk6dj3Z0pObQbXFWnfeP2iyo4apSe1n+r7qgn/RlA
         1YfhNEnT2giUfC+pEHsA78qR7160oRFxymjrBkCwdxYHhkB5aBUHOt8Ysl/FaG4opfT3
         NO011hfG9gcK2t1lnt99lIvixG7E5f2TzUFcN9YuuBadGyfXaeKhVb1/jNELBl/9qHQK
         HQCLI1BnniL2Nppuj/Cp7IANbWCGazW7lYd7hvppnRpOJeX+RK3lQ1e0vXYFgqFf4RBa
         WpkQ==
X-Gm-Message-State: AOJu0YzNKCr5CySAhn1rVaS8JuNTDNaK3F71X7Rrcn7REjfaTmbnM8Wb
	b5EVEuvIbF0OkH8XlItDFLOwjqJ5sODDQvGFCM4zwse8btbwfhdXJAEYR3IsksdQgB/rjUTGX5C
	ZhI9R32TRcaz4gjpZCVeI5TMAZ7fQJlH07JdoAdm5+EvjJevRSP5X8P0+sWXHkZfoNw==
X-Gm-Gg: ASbGncssRYvfYt8a1QJZoOzRBuNmL6FibPRCnfUwAwti/b3ssA4zHOy/Owqyn7kf22Z
	jbPwaIh7FDkdhz++c/0AEc4FEDyG+vVG17B1SMRf8mjbqtpaiM4UvDyBYXp2z42QHWF5awtMiZD
	kFECw52rhzm77boobqlZj2/2KKPk+nn+ip2TI7CdBLkXIZFfRewBbGKxFSF7GKfXIj42vwahf/2
	oS484Eswprd1o8hqTvm7dP6WI2jjG7BXFl14iHAPvK+9hEqE2hJe+78haZseORbXtF0pQML0YtX
	Hnsrr3A80Cpu0Rn4aQpKVgKx9tu7zwkWD/bhSS0g6oIUNJJAOBQK3zNsinr8lGahERKei+Kt7T5
	dWkFBVpfDceg=
X-Received: by 2002:a05:620a:569:b0:7e8:3e5d:7c93 with SMTP id af79cd13be357-7e8705fcabbmr241868985a.61.1755164385055;
        Thu, 14 Aug 2025 02:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ7LR39BHceCda8+X8nSy1OtO1P6Oe3f4RnMMm1ycBMpkj2Qt420T+bKui8QDQ085w3FuURQ==
X-Received: by 2002:a05:620a:569:b0:7e8:3e5d:7c93 with SMTP id af79cd13be357-7e8705fcabbmr241866385a.61.1755164384644;
        Thu, 14 Aug 2025 02:39:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82aa29328sm1151256185a.33.2025.08.14.02.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:39:43 -0700 (PDT)
Message-ID: <0277b2b5-b3f4-41da-8c18-e6131f908fd3@redhat.com>
Date: Thu, 14 Aug 2025 11:39:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/4] net: ethtool: support including Flow
 Label in the flow hash for RSS
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
 ecree.xilinx@gmail.com, andrew@lunn.ch
References: <20250811234212.580748-1-kuba@kernel.org>
 <20250811234212.580748-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250811234212.580748-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 1:42 AM, Jakub Kicinski wrote:
> It is expected that the hash communicated to the host
> may change if the Flow Label changes. This may be surprising
> to some host software, but I don't expect the devices
> can compute two Toeplitz hashes, one with the Flow Label
> for queue selection and one without for the rx hash
> communicated to the host. Besides, changing the hash
> may potentially help to change the path thru host queues.
> User can disable NETIF_F_RXHASH if they require a stable
> flow hash.

FWIW, my understanding is that the S/W computed RX hash includes by
default the flow label, as skb_get_hash()/__skb_get_hash_net() dissect
with FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL and the latter force the
flowlabel inclusion when available.

AFAICS enabling RXH_IP6_FL will make the H/W and S/W hashing consistent.

/P


