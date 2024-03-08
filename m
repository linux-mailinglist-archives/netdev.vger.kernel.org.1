Return-Path: <netdev+bounces-78787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F17E876773
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07D81C216C7
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6B1EB5B;
	Fri,  8 Mar 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCv66hvw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A71DFDE
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911920; cv=none; b=Olkw31XnNcWdiWcmhooHlwSDulBAks+9TG2EE/ULjWA7QAOMGqu3CHbBJDZmzy9q19umoT8neBDwGeQGstvKO6lEfNn2b5KcMNN4eoz1uHrpscuC+wI5m83Gd8HrE9cSX32yTSlaT6Ro0pANTBbx9O2Xr2a87Pr6ZpMHz9oiaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911920; c=relaxed/simple;
	bh=p1EO7kVrg56+MwSgyZyPZie7DWCh7bb5MSs9kMAaez8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UyKehxedyk3sgAJoVRtyyIPWl5ajWtTitgRGAD1Sm5XDyviaoteRWJVKVas0RtdXy8TK1Ye5N2SxuUWKtPunbUthEvQG+x3SQFoPnBInOgGWeqg11/Z2GHgqyorTrVb3wGmobB+1rlgF8sk5D1Ucs+HiuSUGfdyk2G+T8/sU1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCv66hvw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709911918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CqJ8OyjV3bRv8zx+Stypoq4TfLAXAS+4CTsGsgxPUA=;
	b=DCv66hvwKs7IT0hlVv+o6u4SLvwXiEGqA7WMTqQFx+e83VaPt/XKPBfjKVIlKpWz1W4DZy
	vzp3/0l3RP2vkKQrZNVpgi+hHkzE/IpsfXYgnCszWlVMfk3s5CHURpYDiNqdaqqGZXAF2J
	JdAwoxEuGbkl5VoVolRLMIzuiT2kFHU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-iaB1TxLMMq6mrGeOkM4JeA-1; Fri, 08 Mar 2024 10:31:55 -0500
X-MC-Unique: iaB1TxLMMq6mrGeOkM4JeA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56734247b02so1069511a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 07:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709911914; x=1710516714;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CqJ8OyjV3bRv8zx+Stypoq4TfLAXAS+4CTsGsgxPUA=;
        b=ZUKjf0JNngtvOJZBPKiAid/UMBS9TwiMubB0fAGAyqKa78t9IAuwswfAe3O9h30tGf
         3frwrbyuKoZ7PvHOMCzjFwT4bAyjA+hc4oTN7euvxv+L0xSzj8JlJTLgm4OKa+5r0uob
         BMpLL9LmmWFvmFL2xdHK9suNfcelG7WMPB8lDXjgVuDnnLDhbfY3V4jP6+K///K1V1e8
         1bOhdAlqfVGw4s6q9CLim0UB9BVguZOuWJl1Myrz8gljNI+RXK4LtdE8VtcQiYi9zI7M
         pUNGb2Tztud/CCyCngk6n0fQOFTmnQ+iQaHWwoqS7mEYQYyyPwsJAuL175scayls0+wI
         uZVw==
X-Forwarded-Encrypted: i=1; AJvYcCWDFOhuNL/E7i/GhD3T/6jTbplmFeq6d/tRKnOPPHtzv+yoNhOCUJC1JtBkaAkHmCg8reW/Iusmr6IqCtSXipR/pZViNWRC
X-Gm-Message-State: AOJu0YzMwb9JgNNrA6zvbodbe5pitUqyuRsmf84drYvlbPmLDgg1bmL0
	HA8MBTflXq7O+0w7Qjv3AeH1sZDCXvPhBUKkXmKEu86Zt74d/YKJ14a0atbL5WAXwxFMQ+PEFki
	L01HXdq5g0FpCHOlKjFXo6lP7bWUDrT7h7+/MZTJN75qNoZgUyLbCYQ==
X-Received: by 2002:a50:a419:0:b0:566:981d:aef5 with SMTP id u25-20020a50a419000000b00566981daef5mr2165702edb.24.1709911914527;
        Fri, 08 Mar 2024 07:31:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL8kvpXqtJq4hcVEInZ6+w/P2h+DZ7MoaE+AVDWrTwqHEdFQsj/q0lkaal7tLxpcRt3CXGmw==
X-Received: by 2002:a50:a419:0:b0:566:981d:aef5 with SMTP id u25-20020a50a419000000b00566981daef5mr2165683edb.24.1709911914125;
        Fri, 08 Mar 2024 07:31:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g3-20020a056402180300b00566ea8e9f38sm7760865edy.40.2024.03.08.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 07:31:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 73617112F574; Fri,  8 Mar 2024 16:31:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
In-Reply-To: <20240304150914.11444-9-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-9-antonio@openvpn.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 08 Mar 2024 16:31:53 +0100
Message-ID: <87ttlgrb86.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Quartulli <antonio@openvpn.net> writes:

> +/* send skb to connected peer, if any */
> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb, struct ovpn_peer *peer)
> +{
> +	int ret;
> +
> +	if (likely(!peer))
> +		/* retrieve peer serving the destination IP of this packet */
> +		peer = ovpn_peer_lookup_by_dst(ovpn, skb);
> +	if (unlikely(!peer)) {
> +		net_dbg_ratelimited("%s: no peer to send data to\n", ovpn->dev->name);
> +		goto drop;
> +	}
> +
> +	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
> +	if (unlikely(ret < 0)) {
> +		net_err_ratelimited("%s: cannot queue packet to TX ring\n", peer->ovpn->dev->name);
> +		goto drop;
> +	}
> +
> +	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
> +		ovpn_peer_put(peer);
> +
> +	return;
> +drop:
> +	if (peer)
> +		ovpn_peer_put(peer);
> +	kfree_skb_list(skb);
> +}

So this puts packets on a per-peer 1024-packet FIFO queue with no
backpressure? That sounds like a pretty terrible bufferbloat situation.
Did you do any kind of latency-under-load testing of this, such as
running the RRUL test[0] through it?

-Toke

[0] https://flent.org/tests.html#the-realtime-response-under-load-rrul-test


