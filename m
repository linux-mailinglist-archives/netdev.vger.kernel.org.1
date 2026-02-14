Return-Path: <netdev+bounces-258722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ufNbBY+8kGntcgEAu9opvQ
	(envelope-from <netdev+bounces-258722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 19:18:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64513CCB1
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 19:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A46301465C
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91B2D5A19;
	Sat, 14 Feb 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo9DZrym";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qdIvS4YA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4588277029
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093130; cv=none; b=c1dCkdDZGQMbZESWBpZ/zF1ZoOAW5TjGLvo8fDo6VB2qXM385RixxmsPB/of/aOc0FVTmgxVnNJcLnUYa8zRSFuDymRUwJ2zxgeH1+TTFM/N3xoRZ6Tl9KQOJWTNZW2zRl154sfLZdfMnNTGheDymxweoK4qIZfpDdbobtTJf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093130; c=relaxed/simple;
	bh=yEelQuIDmS5A4nF6l+/HEJSY7JzkT8eOu+50RPHRcm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncsljQ0ZyXTjeOU4/Jj7sg28pxuibKub5Z3FEAp1dlSbx2YoL0X5s1Ku1FG3IND1NLiIifhVTbuYHrDi5N88m4vcSFiQiJ8saoeQY0hU0IeBhk2xWpzlsmKRoC9JYdvhLyqOq9KP+i4j7+gK2oY9++tn22OtifmerFc65p4yH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo9DZrym; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qdIvS4YA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771093127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGvEkNLWiFwc7xvXmNfeTPVLJWvbXxlHncgYSGzv/5o=;
	b=Vo9DZrymcApH6zTFCb14CAigQ435Eu7rpwULe8eBeZhvuXMc1dK/jpQ2bJEdCqqm3IMxJF
	0IN05htTHQ+lG5e5FME4DIr8qQoWvRRjvvwNw6N89rGqxpAmygASWZHAKWXVKvUOTs9SvQ
	f1nxi9i5d/Db0XLMgjE59KKsOrgpM6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-EvnQkPjTPs6KK1bZhX5POA-1; Sat, 14 Feb 2026 13:18:46 -0500
X-MC-Unique: EvnQkPjTPs6KK1bZhX5POA-1
X-Mimecast-MFC-AGG-ID: EvnQkPjTPs6KK1bZhX5POA_1771093125
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48372facfedso16317705e9.0
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771093125; x=1771697925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGvEkNLWiFwc7xvXmNfeTPVLJWvbXxlHncgYSGzv/5o=;
        b=qdIvS4YAkVnmIoOstaP/B0Uq5mvZXin2Kw/oE0qZ+AGOlpqQB5S4kzO5UtIXmqdzJq
         MjttFGFrX2hq7X9X/7ixu8LObFTlMs91edNW1hO1yHD5mRlOAbQorfkVKf7JZZW7Zofn
         HBb9U/2tqy8BSCugSz4FaJN1b/eEg5vAgWWjMDymZimEZOwAO00wbMcCgKrLyC2Ow+dB
         9TkbDswNKZtB+X3T2CGTufhi/NCrgNXvpmBUCMnd/BUjSOzoXwX8wNyhQSHZEFux1Ofg
         dSjQd2hQTwEgLEUI4DoBwTQqDkftSCz3DAO6h3J+78Zq2EqUloMK2m7wyRTwhjZnP56O
         QyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093125; x=1771697925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGvEkNLWiFwc7xvXmNfeTPVLJWvbXxlHncgYSGzv/5o=;
        b=VZKyqFCRx1cLFQxUk3ykqn/6I+S52BTT1DhZg0CRbpCUrMooDqqa1vynep/a9vieRT
         QlDDN9RX1aX52W1N+cKWIW4Y5rnGiA6oJ1woWc17WK98FEGDfSbXu/rWVlUTlUR1zxcX
         7UfuYxjHk2A1RlHunH4+yGJ2ehTnw0Xn0FPbOovXmOMintmWk+vx+aFJc7477eXae8x2
         do9Dd+Gl1CZtF10OJM/uHHtYzX/6ouYFS3sfS2GQsV9+Mx8ZazSwa2ACSQwMKW8009WY
         W9EhhGTDbuZD7zWLuQVHy4+2yS+nfBwlnOMOFhIkEgzKZlnQBwFlXa72r1ug6jX0BtMj
         BruA==
X-Forwarded-Encrypted: i=1; AJvYcCX98w/uNysCfybxv5Gac4HjrDJGqa3gUFKlPWVygD7cswwvFPpB2b5jcJrNscetMlMAzB8a9Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZg3fInEKcHggUb+2kNsiY6KLkztkgCFVumdtACVt0if5YoCo
	NCSB7fM3oRouKmeDBRyMGbrh/JDMvyfAUe+CF/H/vRAMlIjcpMXVBpxvARMiJvd/RqKmhcrFAh7
	IQgTaOwK0xvof3C8NH7THWQ9WIIvuby1SdJY/2zO+jsGF+S8jlc3jtCfuKw==
X-Gm-Gg: AZuq6aJfRtswQ0UQo/UwRIhGYiH2krf297e6R3aEFTsneZC6/BavQxQ6widKjYuXcUX
	z9ji2FfQeb7y0IuaAgmwi7OPRYOhIiFfUaXfLrfEvYSgWFekse64A/o5g64nLJJ3NixVc0QC8H0
	p7ksRqBBnACgYd4UIpdZQBM68k4lgN5YzUlnN15BtSN0Y7gVyQPgg+raiI96tnTdRAKby47uqy3
	kDmCxW43HKsOhKUmabQpkWZcEyFNBVvJwjW9v33riNQGyXR0SCJJ9Zj2XmsmDU4vwq5tbx5hlmy
	vbFcLlNkp7psGnnNE+UTQni3IH3DgJFBZ4TGBT14Uqa7GDKZD1+EmRTjA6OGnsfNVL22BCTvxx+
	K5pJBiKQB41HBjnnR7w==
X-Received: by 2002:a05:600c:40c4:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48378f062b0mr48481415e9.4.1771093125061;
        Sat, 14 Feb 2026 10:18:45 -0800 (PST)
X-Received: by 2002:a05:600c:40c4:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48378f062b0mr48481055e9.4.1771093124647;
        Sat, 14 Feb 2026 10:18:44 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm65320555e9.10.2026.02.14.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:18:44 -0800 (PST)
Date: Sat, 14 Feb 2026 13:18:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260214131703-mutt-send-email-mst@kernel.org>
References: <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
 <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
 <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
 <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
 <CACGkMEtRikexX=cJz8zmuvW7mcO7uCFdG7AoHQLOezrsb5nbgQ@mail.gmail.com>
 <59529fd2-2a08-4a89-a853-27198b76f842@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59529fd2-2a08-4a89-a853-27198b76f842@tu-dortmund.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258722-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A64513CCB1
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 06:13:14PM +0100, Simon Schippers wrote:

...

> Patched: Waking on __ptr_ring_produce_created_space() is too early. The
>          stop/wake cycle occurs too frequently which slows down
>          performance as can be seen for TAP.
> 
> Wake on empty variant: Waking on __ptr_ring_empty() is (slightly) too
>                        late. The consumer starves because the producer
>                        first has to produce packets again. This slows
>                        down performance aswell as can be seen for TAP
> 		       and TAP+vhost-net (both down ~30-40Kpps).
> 
> I think something inbetween should be used.
> The wake should be done as late as possible to have as few
> NET_TX_SOFTIRQs as possible but early enough that there are still
> consumable packets remaining to not starve the consumer.
> 
> However, I can not think of a proper way to implement this right now.
> 
> Thanks!

What is the difficulty?

Your patches check __ptr_ring_consume_created_space(..., 1).

How about __ptr_ring_consume_created_space(..., 8) then? 16?

-- 
MST


