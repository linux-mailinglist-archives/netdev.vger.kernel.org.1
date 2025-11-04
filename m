Return-Path: <netdev+bounces-235522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87FC31E00
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D51D422C43
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A942FD1A1;
	Tue,  4 Nov 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWPfzR6i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exrtg4/y"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119D2EB5CD
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270483; cv=none; b=XLmhobrWVMNhNZy9yalYuaaxvTeKnEf7j0iYaecMqh9C6q3Ve2mTar+1QoOPmrilqAKs1URRgrUFC1c6tnlH9gnHdlVNqF8ys2c4cWWGIoq5llupRAUUUyUCitsAEXnWJ4Mr+OnM+f8F0OJFpnI5UMtkjlN2n/v9vdcS/1qWdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270483; c=relaxed/simple;
	bh=EySwQ2aJa/1OXqPXf2jBcsyoM+JXlvG1QywvDd1KZfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx+e7FdaXrz7M5x3lumt/bo3zl04mD3R6DTKQ5sjuXIjyFS+ohpiU9L8mVGIiWELxUdYPix1SP+EtVzhGjgiCPRSkRXjbvuDOqtcApQwto8HbXdu1yNURp611QrBV/ucQZeUXgoGzwnF/XiVd0RXLI9//TaOpSSEzh3HXdU8nI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWPfzR6i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=exrtg4/y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Nov 2025 16:34:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762270477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQEppDnHMPH5YJq1uT9VZmGPofKNVsb77C9HX3K1t2s=;
	b=FWPfzR6iGW33Dz0bgZePuohUu1WrL1eq72Y8eEAF2wgpN+7keigd4RPw4st2VPo9EM188Q
	YBHd7RVc6WIgT6R7g7B/cl9hWbdJ9jKq4PIiKJWex/C6F1rdd3+ReXL9iJWITEJYFABBp7
	miEQVNr3yyKNf9vHrcWZm60Ilz5bQxxFa/K6tMqsuPUQwsQWWQu1yrM62+fEmf/GBBberw
	kbOkOWCQgwgEJxPWOI5ySEoE3STlYlpk9dmg0uPArf3+rM1/6m+JDeg8Z+43Ir0W87Pbzl
	EyxkEfCrSJ9akLAP5k/tqLj7X9dS+EfKAWLHR8XfjuAAebBQbmVUVqU9Dq/VLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762270477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQEppDnHMPH5YJq1uT9VZmGPofKNVsb77C9HX3K1t2s=;
	b=exrtg4/y3hqOT1QmX7i/pqCGAmhQ+6odKrsikiun0bw2LIr8HmP/+B/voYydJ8xmP4+qGj
	J1Tew3wLzfw6xXDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH net v2] net: gro_cells: Reduce lock scope in gro_cell_poll
Message-ID: <20251104153435.ty88xDQt@linutronix.de>
References: <20251104111201.5eBxkOKb@linutronix.de>
 <20251104060533.57c1bb79@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251104060533.57c1bb79@kernel.org>

One GRO-cell device's NAPI callback can nest into the GRO-cell of
another device if the underlying device is also using GRO-cell.
This is the case for IPsec over vxlan.
These two GRO-cells are separate devices. From lockdep's point of view
it is the same because each device is sharing the same lock class and so
it reports a possible deadlock assuming one device is nesting into
itself.

Hold the bh_lock only while accessing gro_cell::napi_skbs in
gro_cell_poll(). This reduces the locking scope and avoids acquiring the
same lock class multiple times.

Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
Reported-by: Gal Pressman <gal@nvidia.com>
Closes: https://lore.kernel.org/all/66664116-edb8-48dc-ad72-d5223696dd19@nv=
idia.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Drop the lock and reacquire it again in gro_cell_poll() instead
    providing the lock class. The addition lock class needs to be
    registered and unregistered. The latter must not have from the RCU
    callback. This looks simpler.
    Reported by Jakub.

 net/core/gro_cells.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index fd57b845de333..a725d21159a6f 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -60,9 +60,10 @@ static int gro_cell_poll(struct napi_struct *napi, int b=
udget)
 	struct sk_buff *skb;
 	int work_done =3D 0;
=20
-	__local_lock_nested_bh(&cell->bh_lock);
 	while (work_done < budget) {
+		__local_lock_nested_bh(&cell->bh_lock);
 		skb =3D __skb_dequeue(&cell->napi_skbs);
+		__local_unlock_nested_bh(&cell->bh_lock);
 		if (!skb)
 			break;
 		napi_gro_receive(napi, skb);
@@ -71,7 +72,6 @@ static int gro_cell_poll(struct napi_struct *napi, int bu=
dget)
=20
 	if (work_done < budget)
 		napi_complete_done(napi, work_done);
-	__local_unlock_nested_bh(&cell->bh_lock);
 	return work_done;
 }
=20
--=20
2.51.0


