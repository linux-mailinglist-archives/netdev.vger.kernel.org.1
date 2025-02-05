Return-Path: <netdev+bounces-162918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90525A286ED
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EEA7A2270
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2502288CA;
	Wed,  5 Feb 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o3clrBoZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZvhY/BN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90F21A452
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748906; cv=none; b=DEKRr6+40hR9LJ8J3osGZe8PLbSJEE/0/RxJinfplEhyXbGU7qgtqkFjLQuajCptzULiwJ/d1kFFjoSv9iBKpfyj5cNjcYvY9a8hLxnRwYubskv5QGc/vEbaHM/qkbisGy4YEYXtlKSwEBG8crGkeEwYR/8eJ4TYGy3cHj8JwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748906; c=relaxed/simple;
	bh=PAdXESz9pmvYiQESa/oih1b9ovwi1JoeIpZLrYiWciI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4nYg8Uuus6kMFbBuufIqNH6Wy52N/bFXKoCLBWm4C5NaulUw0RBLuW5dndIAlQe553X4GYlfgOAwoV5Pgnw3UZTsXFvDEkRkBo6I/0vaizIBut0gq0bgjq1ZmOw5XmZ5Q/KMnYrNLQIEPHzKSOYTyMGiDcmOSMTWDsYE71Y9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o3clrBoZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZvhY/BN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Feb 2025 10:48:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738748899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXt+Kvv82sa86yePbVkqorUGZQjbwbinHQ7/z88ldXk=;
	b=o3clrBoZ3DCjVRMK/HaaGj9KzInl+AxivL8IcGVkyyHg2i9ZiRikL83+0OCmJu02yIbP+h
	nZ2zGWlsMPoD3J7HhN/z/JBwV5pFNG95OsvYSW1v5xH1djpjFnAg4NazA0ynRUpq0Ptlag
	6P1kC/9M13kwMLwGKrplUAaHckPZbP9GAnRht0aQ0OiPXxXv7hVr3gr5dOBusdV2LmrNsw
	0WkPmNmpSGdHx+0gvEM1xNeq7C4osb2J1ocLaf2ODhdq1Q9D2PEqezp1zYYXDFMMwz83ZS
	9+6rp8wjqyOffH6qW11ryk9jcR4TereXM9cqZ/vW97B5zRTI8E2bcAWvIkZkNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738748899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXt+Kvv82sa86yePbVkqorUGZQjbwbinHQ7/z88ldXk=;
	b=vZvhY/BN2cjgdhl+HbKxSGcfqfVzhxXShXBm/IfLYUVqpH22dF7KEJcsTbbgmn4AKlaZeQ
	sUYXEoce4frsKgBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	wander@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250205094818.I-Jl44AK@linutronix.de>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250204175243.810189-1-anthony.l.nguyen@intel.com>

On 2025-02-04 09:52:36 [-0800], Tony Nguyen wrote:
> Wander Lairson Costa says:
>=20
> This is the second attempt at fixing the behavior of igb_msix_other()
> for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> concerns raised by Sebastian [3].

I still prefer a solution where we don't have the ifdef in the driver. I
was presented two traces but I didn't get why it works in once case but
not in the other. Maybe it was too obvious.
In the mean time:

igb_msg_task_irq_safe()
-> vfs_raw_spin_lock_irqsave() // raw_spinlock_t
-> igb_vf_reset_event()
  -> igb_vf_reset()
    -> igb_set_rx_mode()
      -> igb_write_mc_addr_list()
         -> mta_list =3D kcalloc(netdev_mc_count(netdev), 6, GFP_ATOMIC); /=
/ kaboom?

By explicitly disabling preemption or using a raw_spinlock_t you need to
pay attention not to do anything that might lead to unbounded loops
(like iterating over many lists, polling on a bit for ages, =E2=80=A6) and
paying attention that the whole API underneath that it is not doing that
is allowed to.

Sebastian

