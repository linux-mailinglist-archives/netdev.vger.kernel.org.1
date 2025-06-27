Return-Path: <netdev+bounces-202064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61050AEC263
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3016E4BCC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8828A414;
	Fri, 27 Jun 2025 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avc4YdJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F82512DD
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751061492; cv=none; b=dZkpL9gGjnfG4qpF1NPNGeSjhAGYUa5olzL/bfTOfc8VN0XPPdppZ1VyT08YJL0UI95BmMWCTZn+MUPuuF4PY9bdJDq4HmCz/c5mwB2d7QhYVsZf/6rQnYfGv0MORqgB1MIGaTrGjArDRCF0cfrLXdFkQZeIvtdE/fENui+ZQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751061492; c=relaxed/simple;
	bh=Lk7K8Cjos8izNznI59LBq9rNve/HmFHOM6GgHMHmVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm/w7+QMk3fv2KWuY1rMxWkUQdaAMf8KxFZ2TQdbvVviHOakm3binKmy9FuMVrTkbe3a6mJqrAEiVNbjlZS9Thh78seXmGgReJkNmCC0lGWhDbKMZ+Q6qAihpmP6a7lLv4l4PdyRviNcB2ZcsGG8T8dVFRgRQ7XwqXINumyMW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avc4YdJn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so503045a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751061488; x=1751666288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnyE0d8bplTQsvauL5/oOHs++CmgvFfzWaZY4to+au4=;
        b=Avc4YdJn2g2F/fOqYh6r5NAakC7vSqlO7kluf9w0U1gcVWPD6rwzAfRs/AviryVwry
         LsvLVx1pvkSp7zEoIGsU/gqEC2HUnbTtc9lalVXjXeWGKmgK2fa8Lwn+vdQu6eSLNVca
         reg+ZrJdhAB132KipC9k/8dyAvgz4rOAlvdbvrjCVfQ10HAG+kZxBUY1IEKAgSRgNoEv
         tbg9HSSIpJQpU/UFwO77Q5n85ulzdRKs5pt4YO0im7xLYVMbwYy5lvEMVbuKdwNrcaD0
         6crsxevc7vgOHoNSOlU49pHS00/z1u1UQsQbjybmN2JODDcMdsznvkjcn1Ol3yxxMgtq
         y2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751061488; x=1751666288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnyE0d8bplTQsvauL5/oOHs++CmgvFfzWaZY4to+au4=;
        b=FO/GE0BRIgdETsRWz/NIxdU0JCuem/kaDk3A2LFkJ3Qe6cmnCXuOTJgwhmvRV+2Xm6
         aMGS/0XD9H0koI5Vu33YBQWQL3mUm5baHmPJ00LEBUuldd5UtZ+MRlTIvaANeX85UXdf
         X4amf+s7i5RDLQNsJPLzTjG0AhtmMrG8bgUibyaK/QuTbRQlE6zx0JpwtHwJRLskKCfz
         460axAuSDapnvFELXqU0hvqjdiBPnfqLAzV6HOQiBFdcGVc2tw7d2pvZPFXhaubWecXZ
         YF2V4+qhxLeCu7/wqN25PVtLM8Sj+3K6wCep3ZRzq6pS+lcEkmv4KejyJztHlD47PvnY
         NEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU+Q9TbQ6yVQKGt4Aid2ZxTODSLhAaUv9w4AzXcRP2QMupQYLRuH1rqIoLV8x5Y6NPD+iZo+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUKxfWVAdkM2XaAYrAvbe0qmqmTua8aYNnlILG10XGsAfZlUY
	AlegDMQxPSdbXisU3a9jIrE6f/2+ODMg5At4Q91+X0BbU/1rGJnV+Jpx
X-Gm-Gg: ASbGnctMHkkBRKv261K8oVC5YnRsA/OzdM9TVM70WWGuk8bzWwai93FgFiSaPQWEykM
	2wYhYuEZguLUv9NEVQYwvpV9RpRJh9XxIxk1vjAiZXCsprCxwvYa59U+BjxVOIpdNjzN7OmmApg
	1uYZMTaNepMvOBY52wtSGgKTfxIOivOf6Tw+PrehXA/EWZzbZVza4dMHe15NzISXO/QVqQBYzm0
	quhvcFGOt80h3xfQzEWIKXs8yqJq87zsrV4bPJ6HSpAVFnhigR23lrDJXMUIOCqPHFHUqpVl8I8
	BKiN5gF6InPS+9fqzE7xyCpS9zwGtZbw14c1lWH9MI4vgaOA1J4aE2I=
X-Google-Smtp-Source: AGHT+IG3tf3pSgpEI8Pki5QB7w1Q4H8YCgNonTzacvhx9But/zGzXR4IIBADME6OMHGAuC6+iNlJGQ==
X-Received: by 2002:a05:6402:13cb:b0:609:d55e:8a88 with SMTP id 4fb4d7f45d1cf-60ca3e0e6c3mr182760a12.10.1751061488214;
        Fri, 27 Jun 2025 14:58:08 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d708:da00:600e:de2e:c239:8ace])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8290978csm2056354a12.27.2025.06.27.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 14:58:06 -0700 (PDT)
Date: Sat, 28 Jun 2025 00:58:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Tristram.Ha@microchip.com, Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <20250627215804.mcqsav2x6gbngkib@skbuf>
References: <20250616172501.00ea80c4@wsk>
 <aFD8VDUgRaZ3OZZd@pengutronix.de>
 <b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
 <aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
 <aFJcP74s0xprhWLz@pengutronix.de>
 <20250626233325.559e48a6@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626233325.559e48a6@wsk>

On Thu, Jun 26, 2025 at 11:33:25PM +0200, Lukasz Majewski wrote:
> The second problem which I've found after some debugging:
> - One device is selected as grandmaster clock. Another one tries to
>   synchronize (for the simpler setup I've used two the same boards with
>   identical kernel and KSZ9477 setup).
> 
> - tshark from host on which we do have grandmaster running:
>   IEEEI&MS_00:00:00 PTPv2 58 Sync Message
>   LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
>   IEEEI&MS_00:00:00 PTPv2 58 Sync Message
>   LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
> 
> So the SYNC is send, then the "slave" responds correctly with
> Peer_Delay_Req_Message.

Peer delay measurement is an independent process, not a response to Sync
messages.

> But then the "grandmaster" is NOT replying with PER_DELAY_RESPONSE.
> 
> After some digging into the code it turned out that
> dsa_skb_defer_rx_timestamp() (from net/dsa/tag.c) calls
> ptp_classify_raw(skb), which is a bpf program.
> 
> Instead of returning 0x42 I do receive "PTP_CLASS_NONE" and the frame is
> dropped.
> 
> That is why grandmaster cannot send reply and finish the PTP clock
> adjustment process.
> 
> The CONFIG_NET_PTP_CLASSIFY=y.
> 
> Any hints on how to proceed? If this would help - I'm using linux
> kernel with PREEMPT_RT applied to it.

Which frame is classified as PTP_CLASS_NONE? The peer delay request?
That doesn't sound convincing, can you place a call to skb_dump() and
show the contents of the PTP packets that don't pass this BPF filter?
Notably, the filter matches for event messages and doesn't match for
general messages, maybe that confused your debugging process in some way.

