Return-Path: <netdev+bounces-152335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4A9F376C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C69188265A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF8206281;
	Mon, 16 Dec 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD9y3Y+N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E820627A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369709; cv=none; b=ST9Hmh1JtwLcTc2Fye72obdaAn92lLPSednKgciTN0r3c0JfFffBsN2MWqG/9TSSToVHhg28A88UkSqG8fe+mHI+Pbc0I7ACHRuiumnUEPftOMSfs9g2xYJNcKKmZ1G1ucts9c4jBHD3r3BhQo1D6r+/bbTCyZNtV4Xa2jmEQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369709; c=relaxed/simple;
	bh=zxsxA2ApOrSUmr3BpETplYk7dPA9HZ+3JGISt43sDec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TQJWiSmr5EdW3nC/NA+JBp0vnUEDqPwlHOdmE4CktwXX8M4RYDLcwnRNbUdtVJiAYNKOmpQHlm07dFmODOlHrB36Pu965RHV46P2dj+iZuK3g8NdDoaJMDUdI6NMUgULffpO0xsahAQoh31gNv4MRZafg4fDYF3eaTl4tM1LuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AD9y3Y+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734369706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zXCao8j0jRQX9jdQHAKjsUf+37ATYztcfkZqBz8hO8M=;
	b=AD9y3Y+NkBI/7JeeqaSGYVtKItentFcNPhNtlTOoe4Pg8FVtQFVLYgz3nYVqvoCVJp3s9p
	Omb3WCv0EcyQcMXpb6VN0AXI3kCQY8bXMys6D3Dbhvobyv9XZ7jS+5NL4746YiLMqdgJc3
	snKU8CAWPNZPk2FN9TRpnyoTjWZ6omY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-rJOrvP0BPQa7P3icufj04g-1; Mon, 16 Dec 2024 12:21:44 -0500
X-MC-Unique: rJOrvP0BPQa7P3icufj04g-1
X-Mimecast-MFC-AGG-ID: rJOrvP0BPQa7P3icufj04g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436289a570eso35132235e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 09:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369702; x=1734974502;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXCao8j0jRQX9jdQHAKjsUf+37ATYztcfkZqBz8hO8M=;
        b=iMud6/w+TKZ0xbGZRlkGG/5m4B17CVBLK+uU5dWtJibpkKai+jfVlviB+YqqWgL+lc
         LzvM0Ix6RifUX6kCgTP5WvteDgYwnwm0E3HjfTCElyUqkeASzzr530SHxs8S6RgH4NFs
         McIP28zw0PtgSLTYrpG7xDHcsUQiAqngVSMKYGBu4RFpKka06Jvl9tu8BEPjksrHqJsW
         OT1AJo6an9ta4V4iz/uX/zS6knMMMlqMW5a6GfUfH/MI9fJq8YPdkdp85HEZyihqtot3
         beMZ0Vi9u2knp/F9QW8XUQu6nIpm/d0s+3ek0yUcWyYyiJf/plcwjJ44c760VNgpvZXP
         agbQ==
X-Gm-Message-State: AOJu0YxUdVBCG3g6BmW/dyq0T00ck9Q8j2+L7VwparHDhKPJ6Ep5bzBm
	/XfbMbVbkti7l+6hpvDXsDLZu3H8GUev5fMbZjIL1oOjTWA0QlAGy3CjAMYOOdNZLT8DNInqGgu
	V4vz6qr1zuwScgqtZdiCCWyFXk4kGvUvUS6CQTvtmLa96rE9xEkdk+Q==
X-Gm-Gg: ASbGncuGtZZ3Fzi4IoVA0z28XOGR0+Pqliszr25P5FDJhQ+Sco28O4sG29qNTzF/6Ne
	8LmyxN6FqQ8+G3vqVOsMVHvP7S0k7Sh3SL4CmTUR9Ezx/9NdDhSadLecpPMdVFWmZJTucdi1x/3
	wi/FFHoodr+FRMVisrSRkOF3DVDK2tBxo8vTzFS6YPmMn+DEZiQLqTP25UkJnNbfXPC0ogm/u+b
	el9nTpfTuqWW1QQiDEMl2ptVzKPtIoPwwOsZ3IH2kmNJ3hj63Z0Ltf6lUTlYPm72kLJeIz8VcYQ
	Vw6Cajx4kFWR1D8HFYeN1CA/SBoGjLVhL0Hw
X-Received: by 2002:a5d:64eb:0:b0:385:e877:c037 with SMTP id ffacd0b85a97d-3888e0b86cfmr9511778f8f.42.1734369702684;
        Mon, 16 Dec 2024 09:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNezKsevhJxnXiHN5glJgjSRkkA2V2wnHNgAZPKLPZX6gnRhqo2oPUVwxHJRlSlkTtAhmUwQ==
X-Received: by 2002:a5d:64eb:0:b0:385:e877:c037 with SMTP id ffacd0b85a97d-3888e0b86cfmr9511758f8f.42.1734369702335;
        Mon, 16 Dec 2024 09:21:42 -0800 (PST)
Received: from debian (2a01cb058d23d600c2f0ae4aed6d33eb.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:c2f0:ae4a:ed6d:33eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c7fac5bbsm9006334f8f.0.2024.12.16.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:21:41 -0800 (PST)
Date: Mon, 16 Dec 2024 18:21:40 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>
Subject: [PATCH net-next 0/5] ipv4: Consolidate route lookups from IPv4
 sockets.
Message-ID: <cover.1734357769.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Create inet_sk_init_flowi4() so that the different IPv4 code paths that
need to do a route lookup based on an IPv4 socket don't need to
reimplement that logic.

Guillaume Nault (5):
  ipv4: Define inet_sk_init_flowi4() and use it in
    inet_sk_rebuild_header().
  ipv4: Use inet_sk_init_flowi4() in ip4_datagram_release_cb().
  ipv4: Use inet_sk_init_flowi4() in inet_csk_rebuild_route().
  ipv4: Use inet_sk_init_flowi4() in __ip_queue_xmit().
  l2tp: Use inet_sk_init_flowi4() in l2tp_ip_sendmsg().

 include/net/route.h             | 28 ++++++++++++++++++++++++++++
 net/ipv4/af_inet.c              | 14 ++------------
 net/ipv4/datagram.c             | 11 ++---------
 net/ipv4/inet_connection_sock.c | 11 ++---------
 net/ipv4/ip_output.c            | 16 ++++------------
 net/l2tp/l2tp_ip.c              | 19 ++++++-------------
 6 files changed, 44 insertions(+), 55 deletions(-)

-- 
2.39.2


