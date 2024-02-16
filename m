Return-Path: <netdev+bounces-72318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAF85789E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD0C1C20D8E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADDA19BBA;
	Fri, 16 Feb 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLtk1VeE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7C1BC23
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074886; cv=none; b=bMpGGIVg4aqyDn/kbwJq6X5ZMSXCy5yaMPGlT+zCEWx3vC9G+0DF9a8TKqgeE7lcLBFZN2eqGbJfFeRy8/jGWA1j40YMlec/llUPU2KtRI097lJHkZO78EEZjqJ7SG+E+Yc+qUVqCGhrZOT5ZvY/6Q9hj3LEdS+4oHomGEAcaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074886; c=relaxed/simple;
	bh=zmFT/1Az6fnJxyKjipgHZImKfj4yn+FiwLaF9qG09BU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RAwLqVrmwIJlMHV1J2ah9sua4OBB0vzwWmjEixLsHwEMbNfjW63F7WFKc+52TbX8WGtr51R8jESL4Pvigi4+6xZ3stjbG1zLWUyLdaX0VfekywIfH7dc2SOO5NUEyKZY4HLJjMrWOhpOlH3Jop1AHxQugHe3yptInaaeZwgGSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLtk1VeE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708074883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7kgqAsAFIfE8DhFVU3oR5UKeDnB57As+Gq2juWY9v64=;
	b=eLtk1VeE9DmVIhH8clbGo7uMXN+dTiDXlOFcKM0VnOrV2G+3rrNuXRgwiGRvA4YCainKYC
	5KUlrrfLur4j1IWJZ16f66H274nM6JoYol2CR1PdWwjXjOG9yr8Z5JLX6Bvp/zxYzUeDGA
	/2x9NBJ4xl1WGn7CttShUqZv1tiQSfM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-usBZ9fKtO3W-8K9Nlsg1uA-1; Fri, 16 Feb 2024 04:14:42 -0500
X-MC-Unique: usBZ9fKtO3W-8K9Nlsg1uA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33b226e710dso118140f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074881; x=1708679681;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kgqAsAFIfE8DhFVU3oR5UKeDnB57As+Gq2juWY9v64=;
        b=HmWnQCeypnIUjylD0bCc1ckT7Ii14id4CdqjDHf7p56O7esv+/frY4Y39MePdSQn0L
         8i2T40FwTUQXZJTlOujVEyUNVpzpm9811VHkHl1zm7+ZTbeYgdIwPlDAFWtH48mQJ2P1
         Ex2qKxqqRtQHCmx1ud1dGCmU/ypReNLo/xZLlkxBjM/Jl0ZxAkm0tYSo02AsmBtek5HV
         BJKfJja88IBv/lq6r9y1tXrnMw4YQb2GcUKnGZwKCzeCftQWvsfKxQv4NiTCPyIeLA4x
         R0Ry0xkNmrsaY2vCPP2yo68SR4j1NQRG6RsH8+vO1mHYimQso8ws2VHr8eKKag0i26/z
         voyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+W1b3y9gmfUjc3vahBONSLVzcOwmF6f0YteSN3Dw5upfZp7xrh4zjA37WVYfp6uqU+uqawAZ7n6uz6ZJnk6+VcnOmSOZw
X-Gm-Message-State: AOJu0YxVA3mI1cLJ5/Oy3h0hh/bW/+g0eXYAsocicjvwL+OZvCjitSot
	jxtrRMO2C/19CkK7lqA9fnn83Gb0LDAdt2bd04vNtmPkchGsWrO3NXpQuezMElxGToYFo6VluBR
	GQlV5CeA4qA29BRyaGS70oSxVDza8ABf3Aq5jKwvpKoF3fhfQYY6v8Q==
X-Received: by 2002:a5d:6f0e:0:b0:33d:2270:89f5 with SMTP id ay14-20020a5d6f0e000000b0033d227089f5mr240618wrb.3.1708074880937;
        Fri, 16 Feb 2024 01:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxsuF0Vn1bTsbRz9oL1Tw8TdiH4baw9wTtYRKRmUQ4HdYrvyG5r0D7FSumcX8TXWe7/SDS7g==
X-Received: by 2002:a5d:6f0e:0:b0:33d:2270:89f5 with SMTP id ay14-20020a5d6f0e000000b0033d227089f5mr240605wrb.3.1708074880571;
        Fri, 16 Feb 2024 01:14:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id x11-20020adff64b000000b0033d157bb26esm1620399wrp.32.2024.02.16.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:14:40 -0800 (PST)
Message-ID: <9cb12376da3f6cd316320b29f294cc84eaba6cfa.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
From: Paolo Abeni <pabeni@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com, netdev@vger.kernel.org,
 davem@davemloft.net
Date: Fri, 16 Feb 2024 10:14:38 +0100
In-Reply-To: <89f263be-3403-8404-69ed-313539d59669@redhat.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
	 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
	 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
	 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
	 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
	 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
	 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
	 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
	 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
	 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com>
	 <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
	 <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
	 <89f263be-3403-8404-69ed-313539d59669@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 17:24 -0500, Jon Maloy wrote:
>=20
> On 2024-02-15 12:46, Eric Dumazet wrote:
> > On Thu, Feb 15, 2024 at 6:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > Note: please send text-only email to netdev.
> > >=20
> > > On Thu, 2024-02-15 at 10:11 -0500, Jon Maloy wrote:
> > > > I wonder if the following could be acceptable:
> > > >=20
> > > >   if (flags & MSG_PEEK)
> > > >          sk_peek_offset_fwd(sk, used);
> > > >   else if (peek_offset > 0)
> > > >         sk_peek_offset_bwd(sk, used);
> > > >=20
> > > >   peek_offset is already present in the data cache, and if it has t=
he value
> > > >   zero it means either that that sk->sk_peek_off is unused (-1) or =
actually is zero.
> > > >   Either way, no rewind is needed in that case.
> > > I agree the above should avoid touching cold cachelines in the
> > > fastpath, and looks functionally correct to me.
> > >=20
> > > The last word is up to Eric :)
> > >=20
> > An actual patch seems needed.
> >=20
> > In the current form, local variable peek_offset is 0 when !MSG_PEEK.
> >=20
> > So the "else if (peek_offset > 0)" would always be false.
> >=20
> Yes, of course. This wouldn't work unless we read sk->sk_peek_off at the=
=20
> beginning of the function.
> I will look at the other suggestions.

I *think* that moving sk_peek_off this way:

---
diff --git a/include/net/sock.h b/include/net/sock.h
index a9d99a9c583f..576a6a6abb03 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -413,7 +413,7 @@ struct sock {
 	unsigned int		sk_napi_id;
 #endif
 	int			sk_rcvbuf;
-	int			sk_disconnects;
+	int			sk_peek_off;
=20
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -439,7 +439,7 @@ struct sock {
 		struct rb_root	tcp_rtx_queue;
 	};
 	struct sk_buff_head	sk_write_queue;
-	__s32			sk_peek_off;
+	int			sk_disconnects;
 	int			sk_write_pending;
 	__u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
---

should avoid problematic accesses,

The relevant cachelines layout is as follow:

	                /* --- cacheline 4 boundary (256 bytes) --- */
                struct sk_buff *   tail;                 /*   256     8 */
        } sk_backlog;                                    /*   240    24 */
        int                        sk_forward_alloc;     /*   264     4 */
        u32                        sk_reserved_mem;      /*   268     4 */
        unsigned int               sk_ll_usec;           /*   272     4 */
        unsigned int               sk_napi_id;           /*   276     4 */
        int                        sk_rcvbuf;            /*   280     4 */
        int                        sk_disconnects;       /*   284     4 */
				// will become sk_peek_off
        struct sk_filter *         sk_filter;            /*   288     8 */
        union {
                struct socket_wq * sk_wq;                /*   296     8 */
                struct socket_wq * sk_wq_raw;            /*   296     8 */
        };                                               /*   296     8 */
        struct xfrm_policy *       sk_policy[2];         /*   304    16 */
        /* --- cacheline 5 boundary (320 bytes) --- */

	//  ...
=09
        /* --- cacheline 6 boundary (384 bytes) --- */
        __s32                      sk_peek_off;          /*   384     4 */
				// will become sk_diconnects
        int                        sk_write_pending;     /*   388     4 */
        __u32                      sk_dst_pending_confirm; /*   392     4 *=
/
        u32                        sk_pacing_status;     /*   396     4 */
        long int                   sk_sndtimeo;          /*   400     8 */
        struct timer_list          sk_timer;             /*   408    40 */

        /* XXX last struct has 4 bytes of padding */

        /* --- cacheline 7 boundary (448 bytes) --- */

sk_peek_off will be in the same cachline of sk_forward_alloc /
sk_reserved_mem / backlog tail, that are already touched by the
tcp_recvmsg_locked() main loop.

WDYT?

thanks!

Paolo


