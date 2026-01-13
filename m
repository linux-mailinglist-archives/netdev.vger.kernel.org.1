Return-Path: <netdev+bounces-249542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DAD1ACA0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446D430433D5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F52FD660;
	Tue, 13 Jan 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuUiaski";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAs3hAQD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0480287516
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327545; cv=none; b=LdWUEcylwCKdzQyjgsUb9hu0bgUD75VbSnIGiRpN/F2zvOcoZ7mByDyT11wYaJtU2O7bpO1E0ssXMfC6OE4OOdVMWvh5rQewmziO+7OI5LILozWhh0r+vb6tpT56W9FBhdD7wwAE1lF2pwRmzp35JdoncAPzCGtzo3JE9eQn2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327545; c=relaxed/simple;
	bh=kDcutUv7aJWCyIO8UR7LdBNvzrb9hA26dEL2hHvbg7o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KQPZ+7uIG6rEhvKZDf8kyr/hAUo0L/Mc1ODbIehAJSo+h133/hkqk2Z+6xjwHwe0yrm0L81o9zGi0xuX30xk8KJOf89fuV983upcTKcX9EgNiX7IQGS9UxuDIi9G+lvwD4AffH0el2iQOd0v5TdeM7+d3nOvSz4yz7Qtvknw7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuUiaski; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAs3hAQD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768327542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxL2HkSMC0C5tMevLp4wu8EtMnlPBJAnMlfItJKvzso=;
	b=UuUiaskiU2qLjamscz4wJVKpJQgKuIcya4ml7R/ypPlilDl12lKYiYXwMww7Fd5n4l+aq8
	6r2sHi0WrJckF+OSvX3vY/Gg2owRQ50NNKn+BmrKk16TeJrlpNMDkl6QabUvhXdxkN/UmE
	84BXChUYoKU9E38KRwTAV6HEtWVXOqU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-m-fsLFvGM9qvw7AdN6F0hg-1; Tue, 13 Jan 2026 13:05:41 -0500
X-MC-Unique: m-fsLFvGM9qvw7AdN6F0hg-1
X-Mimecast-MFC-AGG-ID: m-fsLFvGM9qvw7AdN6F0hg_1768327541
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78fc5b493c8so103259527b3.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768327541; x=1768932341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxL2HkSMC0C5tMevLp4wu8EtMnlPBJAnMlfItJKvzso=;
        b=PAs3hAQD3xs/BloqXEKztwPdp7Z0r2B8b5DQ0Rog93AYpi3puhlwQRE4+GBl3G0S/3
         NNWGD9TSm6b4bK0pQ2GqYirXEGPVvcvsM9MqXB4aDDL5p4Nd2Ds20HQmtGbxlUit7vXO
         x8cbrfxyb32uSplUC2/VvsNI9DCOWnFsrbz4OjOG+NohX9+IIe7//Z6kXmGCxrbkn6qu
         DHDJKqhneyqKMVuPQHJIOYcVtc1dN3woIjNkB+Lh2PmDUYEv3P6gv3XPy8hNtj1oiTGG
         hoOgvtNK4/j+ofUtamhMNcsioSC+edLz3PR0Th+gxL41LO0xfkM2mXG1p1Bgo0npmLxf
         OlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327541; x=1768932341;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxL2HkSMC0C5tMevLp4wu8EtMnlPBJAnMlfItJKvzso=;
        b=uKmTR9+Is/2+6dXVD5iqwQsVRtiGZhlOn8T/RBEsCanKjGzOHipsq9IBkKMFn57r0P
         6uWeOzFJbJADWZvPDDc5+i1LzRstCNltAR1EpFAf97IZtkC4waRQUw3rskvQwtztTymB
         qWbsDIQ4vYV0z7Wka8eNTt65HFGqHQl00mWk78jOnVXGLKspllPoi5URD063IRD4BQL3
         c7qcAVKQBeWa8QQrD8HmBY4zvPP/B2FOu5YBOeYt6z5RXx+VqQz6/UQXDARFpRoyXcma
         l65P5n+j2Cc0Tu1ISRAxfszBAEvhrRB8Kxb7l6AnBg1Vf0uu2sOFCHbMFEezTVfy5WUF
         04Sg==
X-Gm-Message-State: AOJu0YxnGcpUNC/KCrhse87NBPHgjDRs3qXWnYGNvlGX8zJGa+dcY+Br
	MHPIFJdCRI62YDHxJo6iLM9YAUD9AbVP+DcNfMRBX3QLq1VfY2X/5vhz3vo0RkhB9uP0VXprEbR
	D9D9ahonRVJkBD3t7of3PTRfagJs4//xX3k2f3X8SKuBADrVPreXZu+Bu9qYvPXJhMxLFtld6a2
	9BurxqfVnLa2RYPkV97jyvLPWNUzG8GAts7BFL5oM=
X-Gm-Gg: AY/fxX46W2S0n6AH7KL9nGDIB/aQsAsW00OgBffAtBAnJ27mZWJM3Pj/PAnVcaTzc45
	IZYXHMJKQa/v0yZtxsOmgfl9wCSPvNmZa9gCzaBKSZKOjQxrpH6n7OyZBkelMavI2A+Qg3zFvP3
	XGSzxYbYwjv3uC/AyCMW/BDR6Tm3aILrLG4CO0cANZtTn3DwJ3RYhyReJSB+JCLUd3kkcKG7L4f
	+5m5jQM0Izelg5V3B+rzg6x3pfollk6B/09PBho1U+f/saDjq0jTGZK9pUSdf4yz/ErS6Lef9XN
	HMF2HYPs0jshgxylWG4IoHaaT0RGR6GpUBYjxX2VNV3nBo6CG2xoYZ/cv9kE9eS2mDzcRvgwbsU
	neI9fqyIDdM2n
X-Received: by 2002:a05:690e:bcb:b0:644:7933:ae89 with SMTP id 956f58d0204a3-64901b2d245mr63979d50.89.1768327540694;
        Tue, 13 Jan 2026 10:05:40 -0800 (PST)
X-Received: by 2002:a05:690e:bcb:b0:644:7933:ae89 with SMTP id 956f58d0204a3-64901b2d245mr63937d50.89.1768327540151;
        Tue, 13 Jan 2026 10:05:40 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d607sm9552428d50.12.2026.01.13.10.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 10:05:39 -0800 (PST)
Message-ID: <12266a40-cbf9-4a55-bf9f-625e38be90c1@redhat.com>
Date: Tue, 13 Jan 2026 19:05:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 00/10] geneve: introduce double tunnel GSO/GRO
 support
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1768250796.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cover.1768250796.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 9:50 PM, Paolo Abeni wrote:
> This is the [belated] incarnation of topic discussed in the last Neconf
> [1].
> 
> In container orchestration in virtual environments there is a consistent
> usage of double UDP tunneling - specifically geneve. Such setup lack
> support of GRO and GSO for inter VM traffic.
> 
> After commit b430f6c38da6 ("Merge branch 'virtio_udp_tunnel_08_07_2025'
> of https://github.com/pabeni/linux-devel") and the qemu cunter-part, VMs
> are able to send/receive GSO over UDP aggregated packets.
> 
> This series introduces the missing bit for full end-to-end aggregation
> in the above mentioned scenario. Specifically:
> 
> - introduces a new netdev feature set to generalize existing per device
> driver GSO admission check.1
> - adds GSO partial support for the geneve and vxlan drivers
> - introduces and use a geneve option to assist double tunnel GRO
> - adds some simple functional tests for the above.
> 
> The new device features set is not strictly needed for the following
> work, but avoids the introduction of trivial `ndo_features_check` to
> support GSO partial and thus possible performance regression due to the
> additional indirect call. Such feature set could be leveraged by a
> number of existing drivers (intel, meta and possibly wangxun) to avoid
> duplicate code/tests. Such part has been omitted here to keep the series
> small.
> 
> Both GSO partial support and double GRO support have some downsides.
> With the first in place, GSO partial packets will traverse the network
> stack 'downstream' the outer geneve UDP tunnel and will be visible by
> the udp/IP/IPv6 and by netfilter. Currently only H/W NICs implement GSO
> partial support and such packets are visible only via software taps.
> 
> Double UDP tunnel GRO will cook 'GSO partial' like aggregate packets,
> i.e. the inner UDP encapsulation headers set will still carry the
> wire-level lengths and csum, so that segmentation considering such
> headers parts of a giant, constant encapsulation header will yield the
> correct result.
> 
> The correct GSO packet layout is applied when the packet traverse the
> outermost geneve encapsulation.
> 
> Both GSO partial and double UDP encap are disabled by default and must
> be explicitly enabled via, respectively ethtool and geneve device
> configuration.
> 
> Finally note that the GSO partial feature could potentially be applied
> to all the other UDP tunnels, but this series limits its usage to geneve
> and vxlan devices.
> 
> Link: https://netdev.bots.linux.dev/netconf/2024/paolo.pdf [1]

The AI reported concerns look valid, and I'll take care of them in the
next revision.

/P


