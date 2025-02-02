Return-Path: <netdev+bounces-161995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A7A2503D
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6273A2165
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 22:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC82144D6;
	Sun,  2 Feb 2025 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tAxAwQ7f"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2732144CD;
	Sun,  2 Feb 2025 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738534014; cv=none; b=B7jLkZcpnlThDPopFt9Avow+brUNHuS4kzW32PGu2c8GJJmU+X99JhxuuI0Ix748o5OXzGGKJvyDr3hOiPPWt+IwB4O9wgkp/3Al85jJ4sn3z95jb2xYd30RQWgnSacQWLEuXKKiUPXaLS8dvsFaVGENuYgKMpgKVWvP8fLbRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738534014; c=relaxed/simple;
	bh=B6pVQHC6N9nhZrljHJ8MLPEgnZqulSbw9MenwPSvrSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJRNzBTUf+FrvbywWSA46YSKPJi6pTAb6f8R4OZImpfth6SoGbbv5vVnXCkmGAXab9CdSK9FrQqI8E4SThx0y2qjVuZ2Cxs8Vq7dQG7ymiUdX5afUliboEx07hUy9X9cUre8whfAIjsRKZoDnA829T5BZtvDUtjYWM9hyKQo7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tAxAwQ7f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=28AmWbhIQ3UGJuXTTzNuIC9DDsHHl6ngoKmde+J/sY0=; b=tAxAwQ7f+vB7h1Bd9xGVWNcHE4
	W8KGQYhKgXx7ZTTwnU7DNiWIzbZw8e+Aam64jTGIl8n+2WkvRL2wv5hiC5Z005PzpU5T87oj7qLJ+
	As8luIGAMRmuPdrCflDlfYrLlQ1cKHcTdx26gbuhpH7nz2qPEZtc744yWlN227Yr+Y8k9KB06kxBL
	BnDZg0eBxzcwnd3B9DQAT423S+83U2XdauN8px2QIzSnS50iI89Ki0LhyfmW94heo/112C9zn/pL3
	ggp1Y5nB9cD18lN+DOTybb6up+D6RhAGZDOHkXOkBedjzyJifoGfBj533BIy/vplcp013Sd8NdHJG
	sVSCAj3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tei6v-0000000HXSE-0btS;
	Sun, 02 Feb 2025 22:06:37 +0000
Date: Sun, 2 Feb 2025 22:06:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, ebiederm@xmission.com,
	oleg@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/6] pid: drop irq disablement around pidmap_lock
Message-ID: <Z5_sbCrE6ouqP8Uh@casper.infradead.org>
References: <20250201163106.28912-1-mjguzik@gmail.com>
 <20250201163106.28912-7-mjguzik@gmail.com>
 <20250201181933.07a3e7e2@pumpkin>
 <CAGudoHFHzEQhkaJCB3z6qCfDtSRq+zZew3fDkAKG-AEjpMq8Nw@mail.gmail.com>
 <20250201215105.55c0319a@pumpkin>
 <Z56ZZpmAbRCIeI7D@casper.infradead.org>
 <20250202135503.4e377fb0@pumpkin>
 <CAGudoHED5-oPqb62embitG39P1Rf7EtEVODY38WB25G21-GGyQ@mail.gmail.com>
 <20250202204449.77cab5e5@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202204449.77cab5e5@pumpkin>

On Sun, Feb 02, 2025 at 08:44:49PM +0000, David Laight wrote:
> I really commented because you were changing one lock which could
> easily be 'hot' enough for there to be side effects, without even
> a comment about any pitfalls.

No such comment is needed.  This is standard practice.  You're the one
arguing for changing stuff.  Have a different conversation separate from
this patch.

