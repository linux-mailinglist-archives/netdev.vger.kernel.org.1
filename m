Return-Path: <netdev+bounces-241589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFAC862E4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 409E43505E1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF27329E51;
	Tue, 25 Nov 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhLHZvb7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="esSiQknh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29911329399
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091141; cv=none; b=Q5K8nnb2V3uE7+vprji1kawunRA66AZ0xSWfcYKN+4IW8kKw23qwB2I4Xdc4VZkKw8Mp1PWgscBx1nZsY3xFe49jGgj980sXPl08FcZFJfECx/NTcUTwuyroLQlvEQ1zoaRhdzplu8UHdsIz2MHeE9clTjkLex5M6pp8zm2UaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091141; c=relaxed/simple;
	bh=ZPhuaik0VAApbpX38pTQnqYDsCZCeVuWDwCiA5Naac0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDwilpdvO/0g87QgEuHm65uLCEgrwQTUO15iAcQfgoffeyZvxfyv1S+P52V7ZeQbk+kt42UvqRHPKua3l1mGgNCsKyzVVO177WQAr/5uZGJ/MAccDVNJA4o8YXnpOYZmnEwU9jCIQor6Z0y7tkr96sYZTck9yo58l0x0ANSPt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhLHZvb7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=esSiQknh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764091139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTDXgrG1WH/0PGWngFbUewy7r2hDyrl7ob2LIaTylyw=;
	b=BhLHZvb7jOeixfrtVhmtDrcjLP9ebr2NrniJVF0R3Co9O+A/ERgZHCt3WKqbrxjB4ObXA3
	3hgV+Z9B+nm4BdUe7cjsYe2CiRr/MUgw2n+1gWMzn2VFjReb7qo3JtR7FpO4IXTr/Q/CbB
	buU+kJlhvO0mdGqHZTlZ6FExeoCqg/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-FL2Z6F-jN7eq2XdbPao0Uw-1; Tue, 25 Nov 2025 12:18:56 -0500
X-MC-Unique: FL2Z6F-jN7eq2XdbPao0Uw-1
X-Mimecast-MFC-AGG-ID: FL2Z6F-jN7eq2XdbPao0Uw_1764091136
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cbd8299cso2840462f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764091135; x=1764695935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTDXgrG1WH/0PGWngFbUewy7r2hDyrl7ob2LIaTylyw=;
        b=esSiQknhwwgSIxH9h576nP+e3IdyPqKvNk6TgDZ3TruRZLZAnBpjaedxhfIEn2EJRU
         ykeM4nzQQMjsPI+Uwb2Hb3gwJ+lLOfl67oXdL4sIhag4xwJiqBr/4XA+7zCeGUH7Lq4w
         utYileQ9cYRnvOsksG5PcTIi2EAIrRI8OE0xTYTWNGNFcyq+tuLD7eX4rg47qboDNEEz
         DA8ca9igTMgz0gyfDukrHjz/w8HU+pUugX10d+MqScE6JeFyz5BJbC1Vdkw2QPzP1ddc
         LzoiVS9JoVrFqgz4CVW6wM4PhwJo90uA09sW4RooldqP2vjzFce8Pdf3Gq0cyqdT8huh
         qdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764091135; x=1764695935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTDXgrG1WH/0PGWngFbUewy7r2hDyrl7ob2LIaTylyw=;
        b=E4xL1IZ1YKCdGUtyqnVo4OXmGsMXa19dl/C+xlQ/hegw/1QoShp43E5B+Dlgcw+fx7
         gzG5PkEvTg0f54BLdetogbQRJ9rBYBKJPOXD+WXLy07JLhICiPEZuTO1hut4qVPWqEU8
         NAQBiNOSHTYpY3iwWL8YjgvH+A8dllgX2I/ey8cNJO3kycbNLjrYJdBwHT8HCY/g227W
         oadeXdfRQXWG8uRGIDqoX80AnZOEQ9K0mfBHheqCTo7F0wYYBqOzxWwcYZxgdhqahOEk
         3bf6W7xJ9kmo9pIo0M2HH/5aLSkLhNiuphgkq3glNNlGo2IZg8jwpmeLryl+MmEdUHzo
         b/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZcikP1pJoRk1SOfk5q83JrUSAp27w10cUQM6J98K4t2z0V85M40uLV/P1QI2O0/ifDUigmws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNsXO131fY8nUk1NGTsNVj80REIojTMeSe0qHHVkJ7EB0rN1o
	wDiNk4WzeKalhnjRmDPld4qEUzRiQBEJXssUGs+dFSzifAB89RdlQT5tvCUVoG+h0xCQwVE7E5+
	2OARuLQZueYob29eKBg6wxAQ3wHs793RZqP8hTAwlSCymGXnjjZhIzHBSUA==
X-Gm-Gg: ASbGncvZO8Dia+58tkV9h0QSXnUFeD7yZPqzHuFP2dr8NAdzOCVOfXBBlJXPob9HkxA
	Hhi/PWw/5L+5aMIb0VaxmeM5L+G6Kj/0gRWvykytUO+AfmOzseazX8P3xUCBF8tu0MSTGp4kpbQ
	iaE8qZDkkFd/QSFyTcZWF4gIibgqMq96JAY49OIdtwHp98qn3D5iZPdEWaL8U6PQYYsta9hNUfv
	Xv1LIlReuRLY80ugAOsm41zUT/gEv5D/kwaQuH+o7t9Sli3u9mxiUaHeYMzIzYFqm2GpJDjTpgU
	fiADWbeLTsWb4qW4URr2Ix9z32VTqFp6SEzgfEQp+JjMfQtHOmtInTINhCo7x8bYmEdmv+4Kq2+
	LMD+FTkQyFXfv3yQ=
X-Received: by 2002:a05:6000:1863:b0:42b:4267:83c2 with SMTP id ffacd0b85a97d-42cc1cbd18dmr16972091f8f.16.1764091135220;
        Tue, 25 Nov 2025 09:18:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDwBcpmQPbHfHTQwxxY5Q+qsOpgYiD3CvZ3WNNO7Ii75RTIrUMAIH9/jzA1J2eiQuQn7dHrw==
X-Received: by 2002:a05:6000:1863:b0:42b:4267:83c2 with SMTP id ffacd0b85a97d-42cc1cbd18dmr16972058f8f.16.1764091134693;
        Tue, 25 Nov 2025 09:18:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm34039004f8f.21.2025.11.25.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:18:54 -0800 (PST)
Date: Tue, 25 Nov 2025 12:18:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 2/8] ptr_ring: add helper to check if consume
 created space
Message-ID: <20251125120122-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
 <20251125095650-mutt-send-email-mst@kernel.org>
 <ce371d19-e69a-4d8e-a9a0-f3e20439a094@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce371d19-e69a-4d8e-a9a0-f3e20439a094@tu-dortmund.de>

On Tue, Nov 25, 2025 at 05:12:35PM +0100, Simon Schippers wrote:
> On 11/25/25 16:01, Michael S. Tsirkin wrote:
> > On Thu, Nov 20, 2025 at 04:29:07PM +0100, Simon Schippers wrote:
> >> Add __ptr_ring_consume_created_space() to check whether the previous
> >> __ptr_ring_consume() call successfully consumed an element and created
> >> space in the ring buffer. This enables callers to conditionally notify
> >> producers when space becomes available.
> >>
> >> The function is only valid immediately after a single consume operation
> >> and should not be used after calling __ptr_ring_consume_batched().
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Co-developed by: Jon Kohler <jon@nutanix.com>
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  include/linux/ptr_ring.h | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> >> index da141cc8b075..76d6840b45a3 100644
> >> --- a/include/linux/ptr_ring.h
> >> +++ b/include/linux/ptr_ring.h
> >> @@ -453,6 +453,23 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
> >>  	return ret;
> >>  }
> >>  
> >> +/*
> >> + * Check if the previous consume operation created space
> > 
> > space?
> > 
> > what does this mean?
> > 
> >> + *
> >> + * Returns true if the last call to __ptr_ring_consume() has created
> >> + * space in the ring buffer (i.e., an element was consumed).
> >> + *
> >> + * Note: This function is only valid immediately after a single call to
> >> + * __ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
> >> + * been made, this check must be performed after each call individually.
> >> + * Likewise, do not use this function after calling
> >> + * __ptr_ring_consume_batched().
> > 
> > API-wise, it is a really weird function.  So is 
> > 
> > {
> > 	p = __ptr_ring_consume
> > 
> > 	return !!p
> > }
> > 
> > guaranteed to be equivalent to 
> > 
> > {
> > 	p = __ptr_ring_consume
> > 
> > 	return !!__ptr_ring_consume_created_space
> > }
> 
> I am a bit confused. You were the one recommending this function to me,
> see [1].
> 
> Maybe the comments need rework here, but the function should be fine.
> 
> Thanks
> 
> [1] Link: https://lore.kernel.org/netdev/20250922221553.47802-1-simon.schippers@tu-dortmund.de/T/#mb722e8ae4ceb5df24f74305c6145561883d4e987


I see, (an element was consumed) part confused, instead of clarifying.
That is not the question - it was consumed.



Let me try:

Returns true if the last call to __ptr_ring_consume() has created
space in the ring buffer (i.e., a new element can be produced).


Note: Because of batching, a successful call to __ptr_ring_consume
does not guarantee that the next call to __ptr_ring_produce
will succeed.

Note2: This function is only valid immediately after a single call to
__ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
been made, and you want to know whether any of them created space,
it is not enough to call this after the last __ptr_ring_consume -
instead, this check must be performed after each call individually.
Likewise, do not use this function after calling
__ptr_ring_consume_batched().




> > 
> > 
> > 
> >> + */
> >> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r)
> >> +{
> >> +	return r->consumer_tail >= r->consumer_head;
> >> +}
> >> +
> >>  /* Cast to structure type and call a function without discarding from FIFO.
> >>   * Function must return a value.
> >>   * Callers must take consumer_lock.
> >> -- 
> >> 2.43.0
> > 


