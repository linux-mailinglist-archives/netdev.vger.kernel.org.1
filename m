Return-Path: <netdev+bounces-229058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D43BD79B8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384F34E3072
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AA202F70;
	Tue, 14 Oct 2025 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRzH/8lx"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3D2BB1D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424372; cv=none; b=ZZdRmqh/aBIJCffvKU13sBCP8pxBG2KR7cEtA1QqX+74B/o/LcZWsS0qgwjEZJtfLnfCRrugEpdXmo13mISbFM4TQvD7rAIpoq9/0yopz/l2M8dH06ZzW3I7MJtLxRZXt8z3pIjSy8fTPU2D4mbI0EINhCDPAlkMt8gTx1yrIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424372; c=relaxed/simple;
	bh=ohz8Tp4v0/lrnEd+9mGsXLrwrebGuBH76M9NVHGl2Ms=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fZnbi9jkM2ZKJUVT4mUHwbI6LglilYbkRuq7vdpPDe0f79pXZag1ip3oFjCwMOzg+cCETKdRIPsomasNE8mI5YXyW55hPflsbkujH8cgD+oG+HlPyUdslmm2wfFIP0rLGHE7kicu2kuquCSYmEWz/b9Kn87/s8qZUvbYwmqYNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRzH/8lx; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760424362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgYFJTw1Cm/fgBwndC3gjQ6shrvcQTGxcItRZa5Jgww=;
	b=qRzH/8lx92dse3+KBnM3so4XMEDFmS1EJ4F+u26UMw3ThrMcb8Q8bsddD8rG9Wl3pGcDIo
	kkgBzg4GDeO8Vc+B/XlRqlYRe5zwZgzMAi/4/0eiZ3DSC/ZVp8lytcnUqmzhmatsrP0aEN
	LxXi/D4LXols+4wJbluHcTvf/d+iku4=
Date: Tue, 14 Oct 2025 06:46:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <be003347ec43dba9fbe70d549da45610e1edd399@linux.dev>
TLS-Required: No
Subject: Re: [RESEND PATCH net-next v7 2/3] inet: Avoid ehash lookup race in
 inet_ehash_insert()
To: xuanqiang.luo@linux.dev, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, "Xuanqiang Luo"
 <luoxuanqiang@kylinos.cn>
In-Reply-To: <20251014022703.1387794-3-xuanqiang.luo@linux.dev>
References: <20251014022703.1387794-1-xuanqiang.luo@linux.dev>
 <20251014022703.1387794-3-xuanqiang.luo@linux.dev>
X-Migadu-Flow: FLOW_OUT

October 14, 2025 at 10:27, xuanqiang.luo@linux.dev mailto:xuanqiang.luo@l=
inux.dev  wrote:


>=20
>=20From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
>=20Since ehash lookups are lockless, if one CPU performs a lookup while
> another concurrently deletes and inserts (removing reqsk and inserting =
sk),
> the lookup may fail to find the socket, an RST may be sent.
>=20
>=20The call trace map is drawn as follows:
>  CPU 0 CPU 1
>  ----- -----
>  inet_ehash_insert()
>  spin_lock()
>  sk_nulls_del_node_init_rcu(osk)
> __inet_lookup_established()
>  (lookup failed)
>  __sk_nulls_add_node_rcu(sk, list)
>  spin_unlock()
>=20
>=20As both deletion and insertion operate on the same ehash chain, this =
patch
> introduces a new sk_nulls_replace_node_init_rcu() helper functions to
> implement atomic replacement.
>=20
>=20Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessio=
ns")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

