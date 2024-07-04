Return-Path: <netdev+bounces-109194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0689274BE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDA1B2330C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525B17B410;
	Thu,  4 Jul 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhbadKvT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FE1AC22D
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091812; cv=none; b=b6uYD/cBfxuLgCuD2CLE+PG8v/aOndMRJFwKFD9B2q7rxSUQZZc0ZpXHqVA4yD1p8sB7Iy+lRkZXdP6nkPNxFjAKIjkITc7p+rnniUOp3p09HNTf3iPLrkTBjcYl9UVfz8LdekD9Vzgv1NFQexQ7cP28tZ4aoXZUQAwSMDvNB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091812; c=relaxed/simple;
	bh=85T1R6JJwy6+hvzGejUX0LKHjGQ1ggRvUSLiirsHCXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHMy541rlPRLxr8gtO0dvX9Jti/WdUQkFoGhEcsEQxBnIkxseomlA3ypYT/NFNtszetYWyR1hR4Zq6joSqvzDWkUs4viijdoe+DOh3iUKF8YLGrFPHVzKfMd/GXBrzNcgZvUW2R6j/HONF8ETOH5l75ky+alQkthRceTMbtlJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhbadKvT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720091810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oRt9blIl+3yhIy35VGcZy6bl8Uum2BhxQ7xjGQk9Tis=;
	b=fhbadKvTXqRQd36KYgInpNschq3k+ITqUGuB91FBzadfq6UVT9bAxCaqiTaS90I+84luNC
	18JTDotsJfXRoRp8WSymcfur1g0T3Gl4ant8hff0kIuT+IiYmj5DSnF4xF9jzW4+rMUZbp
	iP5y4Z6xb7LPdZQwE8495gVWXhDKxdo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-u2F_Qn53Pa6GOc1UDflOZw-1; Thu, 04 Jul 2024 07:16:49 -0400
X-MC-Unique: u2F_Qn53Pa6GOc1UDflOZw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367895ae92dso133097f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 04:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091808; x=1720696608;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRt9blIl+3yhIy35VGcZy6bl8Uum2BhxQ7xjGQk9Tis=;
        b=PYS89EJ2sUfIGGSy8FEZlqfkBkBkZAX4XX9eKRzgqpaptJXFgoNJs6TctOgv2MStyP
         UuI8bnTIoFyL+LQKoVvK4h9K+Cu1LSOMeqGR4Yah2MFShMxT/UPYu0vKBAY7FVPzHcmZ
         WWam4I8Zt8x+HQgDzurMlgGWStfIcJC8DqUAuGEPumiqnUmpD94lHgRRDtfqcSzIFo30
         j4VjvZuxdz206hDhemqtXUqOjKwdGkzwa0jfM+8aVopOYxEIkizF5e+m/UzxOgfs0Sbx
         6C6gh0PKGOOXYZSouXVMpb4CreLtQyF4BwTmCVr+dGYCTKgdx0dsmbWkdH17TSJd4uDl
         1tFw==
X-Forwarded-Encrypted: i=1; AJvYcCXEWxk+v004w2rZ22diI+/u2WDMgZEWgKul9mtrnhr1pU0Buf/mmKAXUZ1LYQffb8HhA5c4R9qJS/dsXnHEKzifb5ZC1AqK
X-Gm-Message-State: AOJu0Yy0lPP0GYuSB4Z4N2qy7hT+834jPVJFuLn6EWDw1ta7mTl15cxT
	Kpp2jdvYFCK2PoHgskvbNOUzlFpU9PBgKvArnk8ypOk2JHnlEOXOaCdfSqH6TQ2dkhU8j0rVRHu
	CZclHwgcNyQIbZFD8VLolcT3Y62CYf7LvGiKkCInxw13aw1QO5qTWjg==
X-Received: by 2002:a05:600c:45ca:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-4264a4285a5mr10144275e9.3.1720091807988;
        Thu, 04 Jul 2024 04:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiwO88ijemnXy6TMqrV383x0NHx5wvLZTkBrE4FFi9VjpywzSk/8EPLOzqo4xPnsqvRrGKEg==
X-Received: by 2002:a05:600c:45ca:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-4264a4285a5mr10144105e9.3.1720091807559;
        Thu, 04 Jul 2024 04:16:47 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510:dd78:6ccd:a776:5943])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e12fcsm18171835f8f.48.2024.07.04.04.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:16:47 -0700 (PDT)
Message-ID: <7c1264b94e70d591adfda405bf358ba1dfadafd5.camel@redhat.com>
Subject: Re: [PATCH v1 net] tcp: Don't drop SYN+ACK for simultaneous
 connect().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lawrence Brakmo <brakmo@fb.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
  netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>
Date: Thu, 04 Jul 2024 13:16:45 +0200
In-Reply-To: <20240704035703.95065-1-kuniyu@amazon.com>
References: <20240704035703.95065-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 20:57 -0700, Kuniyuki Iwashima wrote:
> RFC 9293 states that in the case of simultaneous connect(), the connectio=
n
> gets established when SYN+ACK is received. [0]
>=20
>       TCP Peer A                                       TCP Peer B
>=20
>   1.  CLOSED                                           CLOSED
>   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
>   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-SENT
>   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-RECEIV=
ED
>   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
>   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SYN-RECE=
IVED
>   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ESTABLIS=
HED
>=20
> However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such =
a
> SYN+ACK is dropped in tcp_validate_incoming() and responded with Challeng=
e
> ACK.
>=20
> For example, the write() syscall in the following packetdrill script fail=
s
> with -EAGAIN, and wrong SNMP stats get incremented.
>=20
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>=20
>   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
>   +0 < S  0:0(0) win 1000 <mss 1000>
>   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscal=
e 8>
>   +0 < S. 0:0(0) ack 1 win 1000
>=20
>   +0 write(3, ..., 100) =3D 100
>   +0 > P. 1:101(100) ack 1
>=20
>   --
>=20
>   # packetdrill cross-synack.pkt
>   cross-synack.pkt:13: runtime error in write call: Expected result 100 b=
ut got -1 with errno 11 (Resource temporarily unavailable)
>   # nstat
>   ...
>   TcpExtTCPChallengeACK           1                  0.0
>   TcpExtTCPSYNChallenge           1                  0.0
>=20
> That said, this is no big deal because the Challenge ACK finally let the
> connection state transition to TCP_ESTABLISHED in both directions.  If th=
e
> peer is not using Linux, there might be a small latency before ACK though=
.
>=20
> The problem is that bpf_skops_established() is triggered by the Challenge
> ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> check if the peer supports a TCP option that is expected to be exchanged
> in SYN and SYN+ACK.
>=20
> Let's accept a bare SYN+ACK for non-TFO TCP_SYN_RECV sockets to avoid suc=
h
> a situation.

Apparently this behavior change is causing TCP AO self-tests failures:

https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-2024-=
07-04--09-00
e.g.
https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/668061/22-self-co=
nnect-ipv4/stdout

Could you please have a look?

Thanks!

Paolo


