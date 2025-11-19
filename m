Return-Path: <netdev+bounces-239788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10060C6C6F8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9D564E9CB4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A772C21E1;
	Wed, 19 Nov 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPtzsA3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F628C2DD;
	Wed, 19 Nov 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520535; cv=none; b=twQNbo9FEP8w3x50xIaLjdPrXXI/aHvRjSrYXYb6G5qXVMYVgoVGZFhpdA3daUYBp8/nT4+FYePXgb0mUby6rTexb+rrxW55oPHur3dBckDAeGhSSMCE2hQRUw/uKWitqCxvWWCLsqG5Ro2UIVDhA231a/lvxNEja2qmX4pB+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520535; c=relaxed/simple;
	bh=UzR+D2r5Tf/NMJV7Pdd89HkiknvyfNwrgoZJRhBYlTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5MIntJiQC+SUczqqGMd1BeSXpY6Rl5MO2OdJ8auvhfLk0aQMm3wpgp+Ic3rFukCg7JDOToGKPcn5eaw7I/+hXc3n1NnMIKoeJbTblIlRTN84vT54mXpa1jDq580B7lHyKqHBETbRbL/RktnMIIgOYC1dMss0oIxvFSddp87GZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPtzsA3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB412C2BCB0;
	Wed, 19 Nov 2025 02:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520534;
	bh=UzR+D2r5Tf/NMJV7Pdd89HkiknvyfNwrgoZJRhBYlTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uPtzsA3bj+RJ4iXsXgs/v75RYb8MDA6CzPXlfd/l2gyeM3HcfpU2UeYokip/jYhdb
	 KV3oHoY/IFnUw/wTiTiVUm4gPBMKK6He5iuiNh/o9yf15FCDd/84vRpYMn/D0eBZbJ
	 ihdiKzc6NBcNRkyBWb/itOwqN660VLn35+5/JHkoz174Wya+5QTRMUtFWnySK1nqNd
	 0wrE/0bx6OzUEOjpOny7ToS7s3HrZUd8oUrLEL1IW0qa6Q6X9BiP3mTMsIjo0QbtJS
	 OQsS3HZrJK0cPxkWL95kdkhB9TqGBX9/MQajYjfJ0sE4gJycEjcNC+hyU7tVlqVoNg
	 g10TxtYFnhFPQ==
Date: Tue, 18 Nov 2025 18:48:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 ziy@nvidia.com, willy@infradead.org, toke@redhat.com,
 asml.silence@gmail.com, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mohsin.bashr@gmail.com, almasrymina@google.com, jdamato@fastly.com
Subject: Re: [RFC net-next] eth: fbnic: use ring->page_pool instead of
 page->pp in fbnic_clean_twq1()
Message-ID: <20251118184850.068273c5@kernel.org>
In-Reply-To: <20251119024546.GA18344@system.software.com>
References: <20251119011146.27493-1-byungchul@sk.com>
	<20251118173216.6b584dcb@kernel.org>
	<20251119024546.GA18344@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 11:45:46 +0900 Byungchul Park wrote:
> > @ring in this context is the Tx ring, but it's the Rx ring that has the
> > page_pool pointer. Each Rx+Tx queue pair has 6 rings in total. You need
> > the sub0/sub1 ring of the Rx queue from which the page came here.  
> 
> Thank you for the explanation.  I'd better make it in the following way
> rather than modifying the unfamiliar code.  Looks fine?

Yes, I think that's fine. Just please wrap the long lines at 80 chars
in networking.

