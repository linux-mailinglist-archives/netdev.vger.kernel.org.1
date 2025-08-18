Return-Path: <netdev+bounces-214578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCEB2A6C0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E023B9CE5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BE32274C;
	Mon, 18 Aug 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9onoS1z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058A322754
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523942; cv=none; b=gIl+U20ouwMyc+R8GxMDqe3ZcQ8PTYCOBHX28nCeBM9Hpp4/EtkzHYVcnFQukBk5hhUHCNs79hyyVs2UbDv3v9RrWxPj29csZA1cbA38RXyXmiZaTQ0S+0upDTTRy6M/OgApIyuGJO4sU9xNik6cztNF2Uai6Sfsh4PsEmFJtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523942; c=relaxed/simple;
	bh=8vlKA+dcviPrsXU57sLpk2P5dw7gjdUCEVS6SARsUNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdNhX85FeryHfs44C032qHC4cXVF8y3a7gVT/Ky3WRlhQjlcas1iC8eS5a0U4b2L5MqHm0BMXHqi6rEtb76GelmQt9h9SHwIVT4pLc+C3hVDnYma22onFVXPQS5whUBdqIA4cZsc+6D5FoM/b4UDHWEfZZSnBYJUfS6oAyHs57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9onoS1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755523940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHJcFf2Y6ZyqR1ZSSODvNaNMnsW89gcxseOuT/E1tl8=;
	b=d9onoS1z1/0gtScdHGDOYJF2AS5IHV/UANiLw4FLCB99LBsz4hWes893FgQ2IKCJJXFs+s
	NKgfyt/wMlP6KO1191qVOxG2h7+L5DwbgEIdPHhRbfknr0X6X6X8a7elDkMEWKu/SvbVoY
	uEUmFMSNfhkvyGow1WGzis1lBaURr3g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-5ceCnI4bPKOGh-AD5_oUpQ-1; Mon, 18 Aug 2025 09:32:19 -0400
X-MC-Unique: 5ceCnI4bPKOGh-AD5_oUpQ-1
X-Mimecast-MFC-AGG-ID: 5ceCnI4bPKOGh-AD5_oUpQ_1755523938
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso14477735e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 06:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523938; x=1756128738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHJcFf2Y6ZyqR1ZSSODvNaNMnsW89gcxseOuT/E1tl8=;
        b=JdwRVLEYzL5I7E8qNP+MKd9l/ZyCEf2MQ9PX7/xqvlatd+CvItXvA+Iz+e+z50/y9K
         hhdOjLI6yRJAc4NsldLLqcK6ZmjZOX23+HrY4woBIImO6XQU9VtrxvZU1OVB1fHptEi7
         Yo9Ii1Oabu3bUKf3e0zz5BKZFzScWGTqBJSJqCD0P2gv1yzWhbB6zLmoP4WOvvXSonii
         P3CN3u6HrsZDla6TYVTbkEGCkIKjSB1XYHCkMkMTsZEf5JvFVpfexebqZePhZ/c8QEjc
         YqrOG3yqqtxmacYFdNFVpU95cHrZrzxP6AdZUZwjnbMsWr7KZdcL/aq8UglW4fMPLLxS
         R/qA==
X-Forwarded-Encrypted: i=1; AJvYcCWZL/xQIUOIGwy5twZSM87x1BRk508GlWJjEncZ1XYuOagWX2Wr9qE1kAp9pIkGDqWXIXifVrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXG/lRHd/s1WWKV2AGLGVtAzkA9AnuY64CIUl2F+8ARXUHsuKW
	3zJ3xmuA3a9Eshjkb4uzdIEWSbXV4R/vFiAQ0NkKogkhlUBSvQ+KaHQRsuvRAG2nOJsYWWJaH2y
	OFMHJQEwUFHnEc3wEoOhocwERWyhDuy46H6GMI9aAAbDMUVDNe4FCDy2Myw==
X-Gm-Gg: ASbGncvYkYFDMHJiSxRALSFnosBFU/3u9fR9b58EtTBMd0uRNFYQWU9KuBuu8iLVR/6
	k2kxiFyQeqhOQZhYTqoQY3VsmblCQ0vh3CxIFtiODn3HfFDJ9iremi9G0K3+HRSpH4XURXdlNK5
	9j3cNmqZ0kj/u9BpIFwGXRGrCrULzkNGzqSSqZeWWbKfA3DT/XhN78eRKdqNmgNw7T0DonYgfyy
	XbD0ihYFwLB2R3q3pQ2BZ5n5CrrYFWPAmuFWw5BWBrHrUoBlF+zYOwOQuIpz346A+o2u2ffd+ZS
	vNdZGEGebiMNfIzAWWBfMU+ALD8pk8xNRwNeetQ6rnRxSE7VZVBFgMsMP3AAgYC9OveVSbiD8YZ
	nQeCj331xMTE=
X-Received: by 2002:a05:600c:630e:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45b3e827f65mr34765375e9.9.1755523937718;
        Mon, 18 Aug 2025 06:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF28LQi8EXpK6GtLZmDlWAKDzWIyH4QqdI25znCZbn3ey1wMn/xlNBCcuW65C03wDNqKZyrpg==
X-Received: by 2002:a05:600c:630e:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45b3e827f65mr34765135e9.9.1755523937296;
        Mon, 18 Aug 2025 06:32:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a8f972sm289275e9.20.2025.08.18.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:32:16 -0700 (PDT)
Message-ID: <38c4355b-4570-401e-b520-7ec698b62dd8@redhat.com>
Date: Mon, 18 Aug 2025 15:32:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
To: Richard Gobert <richardbgobert@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250811095734.71019-1-nbd@nbd.name>
 <68be885c-f3ea-48aa-91c9-673f9c67fe28@gmail.com>
 <b5bd82bb-b625-4824-9d45-4d1f41c100ad@nbd.name>
 <e01a463b-c52c-4f8a-9477-fd413286e41a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e01a463b-c52c-4f8a-9477-fd413286e41a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:22 PM, Richard Gobert wrote:
> Felix Fietkau wrote:
>> On 14.08.25 16:30, Richard Gobert wrote:
>>> I don't think this will be called for PPPoE over GRE packets,
>>> since gre_gso_segment skips everything up to the network header.
>>
>> What's a good solution to this issue? Use the outer network header instead of the inner one when the protocol is PPPoE?
>>
>> - Felix
> 
> I don't really have a good solution for this. You could explicitly check
> if the protocol is PPPoE in gre_gso_segment, but that wouldn't be very
> elegant or future-proof.
>  
> I think setting skb->inner_network_header in pppoe_gro_complete
> (while not resetting it in inet_gro_complete) wouldn't work since other
> functions assume that skb->inner_network_header is an IP header.

Is PPPoE over GRE really a thing? IOW do we need to care at the GRO
level? FTR, my biased answers are "no" and "no" ;)

/P


