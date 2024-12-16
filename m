Return-Path: <netdev+bounces-152320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311BD9F3707
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0F81884135
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750601FF7D4;
	Mon, 16 Dec 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="aFKLDH/w"
X-Original-To: netdev@vger.kernel.org
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9581ACA
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369011; cv=none; b=uluDkalZHXoQdxe7AMbIpM9hoCBns8ief5rShcplZdahiADF8c2tKzI1u9dxI5UzFxDrz1FcNqHqKp7SZuT9gAcISwfgYOg76L7hIhiIZnURLznm73lupoWUCG2zy6EJ4uTzV+0GeEHapvyfQi1yOCNFdOK7BpYCOsYBov5/Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369011; c=relaxed/simple;
	bh=fmT0hqHpUIBt4uXEP2MiSuL8zgNn4JyVW7RsOYOMM28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIbVhqqkdqItDyYv/ibBAEptJ+ftNi/HDiabA5XmbCScbg+3vdvuPuV7AXtdFKq65qKRSX7ZlJDzG3KXlu3QpiIVUBa6ni9ATnjQFz97jOlFstWca8cMUogF/L4cBHT5EN8Oarfy4r0JgAbOGfd3Ht6eYHJSzKnfe+doKh6MRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=aFKLDH/w; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 0BB1D181170
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 18:01:30 +0100 (CET)
Received: (qmail 28072 invoked by uid 990); 16 Dec 2024 17:01:29 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 16 Dec 2024 18:01:29 +0100
From: Florian Rommel <mail@florommel.de>
To: nils@nilsfuhler.de
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mail@florommel.de
Subject: Re: [PATCH v2] net: ip6: ndisc: fix incorrect forwarding of proxied ns packets
Date: Mon, 16 Dec 2024 18:01:29 +0100
Message-ID: <20241216170129.531313-1-mail@florommel.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <fcb4b7d9-08e1-4a8b-8218-a7301e6930f5@nilsfuhler.de>
References: <fcb4b7d9-08e1-4a8b-8218-a7301e6930f5@nilsfuhler.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-0.29483) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 1.105169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=fmT0hqHpUIBt4uXEP2MiSuL8zgNn4JyVW7RsOYOMM28=;
	b=aFKLDH/wDD9av/WruhUrMnSzFWklHRtU98Nu95babD6k/xTX4pb5enK41Jnhk+OvgM0B14NoCB
	5fFzoDhV54s4EfXa7cn9hz/aIF7o3IGiygjXItvPh9QyyIK221uMdIgZVfm+RK6btYLgVau2izMn
	ZsnccxOfrZzytpGUjqt5bjh3XRq4knYOio2zgyOIHlxVvk7pVnWnNSzTeGGtbYFuZ+FB6D8NoHGl
	AuxbtVR1yT+TkxAo7oV/7AMJtAtErEMAVnYUvcuQ5KqOCe/2TYe1gtBACAZkxgNK2AgdhUFAFm1e
	06LYJ9Nv806Fg0NykPqX1d42hDV9hT44aDVvjY7ncZVisdSJBu1hEgTP38KgRmrXqdghEuOZ6AsF
	g2iy2lBZo2+z3G+9A96oV7ryvSdKV6szeISAfslCVPvJNN209TTLUeIZDQz6zBTuR1TkCUjyX51l
	6PF9nBBJP8tGprbSVKhBIGfHph369rZdiIGumOG44ZLhI99TMvGVGT7zp3I8VvbxZVSmKRWpL9Pc
	GrC/7gxSfpxhBL677kBYfcjkpALPvxveL8Q6OC/IrP8fvbDf0hX7h/PgDCjH5X2Jy3VFckdk6M80
	m5T39UaP5NWVgbB1FVDP9L2PRzaoXo3Tx7HH9YpuQRbE+vDCvIqzGHq1Zlxb/5g9EzqWaYnJxHp7
	0=

What is the status of this? The proposed fix seems to work.

> > I have mixed feeling WRT this patch. It looks like a fix, but it's changing an established behaviour that is there since a lot of time.
> >
> > I think it could go via the net-next tree, without fixes
> > tag to avoid stable backports. As such I guess it deserves a self-test script validating the new behavior.
> >
> That is probably the best option.
> Although I'm not sure whether it would really break something. The
> forwarded packets have a hoplimit of 254 and are therefore not valid
> ndisc packets anymore.

I also can't imagine that anything depends on invalid packets being created?

