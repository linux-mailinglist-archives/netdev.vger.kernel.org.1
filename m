Return-Path: <netdev+bounces-188537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9588AAD43E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70031BA82ED
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8718B46E;
	Wed,  7 May 2025 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NhEEKCNW"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162F610D
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589713; cv=none; b=l5l3wxbwZGeiHNKp8sWwQnA8417sYveOWhuaMotwn80S/CGi3gSQGwisP9/uPHwcipZoMn1x2Iecpr4B9HBuRG/RgkvvA5kXMJMAIKOsB/VVFK0TG9RK4DKNCzxHb7DoyfuBf17cTPWCwyxi1K/i+42dG2WEETqtUkG8wGlltK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589713; c=relaxed/simple;
	bh=qn8NqRy39GWBZU7FmrVnseKqxZV6gPnEB+Yipj+ql1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mwcl79uj8bmPLk7YU13F8VZZl67d0YJgkNrTx5OYCgfom0tx0H/c1Ka8gnDh70g/RNz9QfZ3xnt51ltfqbQ5i+hnZ9S/HfQmacgCgVK3jvGOKv6fWBNNuzWYNyZR/LYyad/BFtII2oD0eemSc+NVYh8uqYw2piYSQjFRn7syCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NhEEKCNW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746589709;
	bh=DOQTtgBzqbaK3D57XQbiGVyNWVlHZv8CmS3gBN8yxE4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NhEEKCNWjGULqQzm6jZgGuwi2BhFUIl14YFmtk+gIplldNHyBVclguGD1fyVMJVjF
	 x07hjS9TRwW+Pt/8QUf3Q2OsebjUuSnuOkb+5IwUm0Tx/H8b6nRUR2et7H7hO6pjRu
	 JItvQ+zl/xyPLrPmejzN4S+CV7ZqJsgaJ4scU4n5HlJWd0iyRq8MIe4UEDyzVGmLCd
	 VhfSYKGt8HSDhTuPiq6fTzPh6Vieamiw9PIyqmzWTNUVENXrYRtmo61w9spvKrCma3
	 6wlx8j6qy30eeH2q7PA8RmJbrfmtqDlHRWQaGfHW9+Nejf2TTkIvnBTn+A+3Ta9fVB
	 BcwVTToq+qMjA==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 672A364473;
	Wed,  7 May 2025 11:48:28 +0800 (AWST)
Message-ID: <eca4d35dc5aa150547317f805633abc70ae994ca.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, 
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com, 
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Date: Wed, 07 May 2025 11:48:28 +0800
In-Reply-To: <20250506192030.7228fcc9@kernel.org>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
	 <20250506180630.148c6ada@kernel.org>
	 <84b6bdceff61d495661dcf3500fd4bf19cf4e7be.camel@codeconstruct.com.au>
	 <20250506184124.57700932@kernel.org>
	 <0decca5d2af88ccbe51b7e9c88a258bd8cc6c6e8.camel@codeconstruct.com.au>
	 <20250506192030.7228fcc9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-06 at 19:20 -0700, Jakub Kicinski wrote:
> On Wed, 07 May 2025 10:13:19 +0800 Matt Johnston wrote:
> > > I see your point. And existing user space may expect filtering
> > > even if !cb->strict_check but family is set to AF_MCTP? =20
> >=20
> > Yes, given mctp_dump_addrinfo() has always applied a filter, mctp-speci=
fic
> > programs likely expect that behaviour.
>=20
> Okay, so would this make all known user space happy?
>=20
> 	if (!msg short) {
> 		ifindex =3D ifm->ifa_index
> 	} else {
> 		if (cb->strict_check)
> 			return error
> 	}

I think that would work well. Some old non-mctp programs might send a full
header but garbage ifa_index (the original reason for strict_check), but th=
at
would just filter out some interfaces which should be OK - that userspace
wouldn't be handling AF_MCTP responses anyway. I'll give it some testing an=
d
get a v2. Thanks for the review.

I'll have a look at nlmsg_payload() for later.=20

Cheers,
Matt

