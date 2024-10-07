Return-Path: <netdev+bounces-132720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC9992E43
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C51C22ED2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A601D47C8;
	Mon,  7 Oct 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h02O71oi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB221D4159;
	Mon,  7 Oct 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309916; cv=none; b=MT5F/aRVw/RYuo3CK8mHbgt8r3QVNSs7dYfrd66huqJjgeRX+rrnQ/u0yMuV34aiGNJNH5wR9dUcKC9UJY6Vyi37Ygo5LJ8k+LtDpXf7iPt1BKdv0kO/y5DBwW4VfagW/VN2RWFwnJrt04X6olit4Tjne7iDl9HX2yERX1HkNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309916; c=relaxed/simple;
	bh=P0n/3590GbJGBAjfPkSlxpmGPbRbqNRvCyX1abCKZOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA+DIclIG0COG0k0QuVhOeN04eRdlkQfbIsooDxLcKT2LOKC+EdUBfbYUgwuRofoVfzhzFeisWyHjb8dCU1qrtJffB2dIdjhjFVC7UqaHoVqeiUenZJMROpLHFT2XFty4NL8t7+EJ1vbHhmOEt8hHmV6DuCKmj3e/FF726v9rK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h02O71oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570CBC4CEC6;
	Mon,  7 Oct 2024 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309915;
	bh=P0n/3590GbJGBAjfPkSlxpmGPbRbqNRvCyX1abCKZOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h02O71oicZ+rGzpYOFZQJQ1I0gMxPJp067CsX+/EqCc8WjlofMjith1/Vncmqf4tf
	 CcxJ3RlK5IQ0wRAbO1GoDeKTDtsThgyYlB/9yklYJ/26xAk8e+56GvcBUwTTBnlBzD
	 PgYgvQ+Rr4miMGNU6ii064G6C1WEOzL0hqXCWmFsVlAJz3YyQkhC70WRUN0qrNP7g5
	 49vs9SuJYHuTS6BnK3gDxiw/Y5x6Ae3ZMZP85kPPTWyXjewv53MLOm7zEKcPGoElr4
	 s2IkdyyszD1hdc5rhHZxlEpV33ZqpuArXhjqLfSHtDW5GFlpaCXt3Fo3tHWYvkdUuC
	 MJgEptVQNtWug==
Date: Mon, 7 Oct 2024 07:05:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 17/17] net: ibm: emac: mal: move dcr map
 down
Message-ID: <20241007070514.4439425d@kernel.org>
In-Reply-To: <CAKxU2N-F+Gcv_LVvH5uB+x5gGABwzFsvxZOg+ApQ-DAHaFz3iw@mail.gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-18-rosenp@gmail.com>
	<20241004163613.553b8abe@kernel.org>
	<CAKxU2N-F+Gcv_LVvH5uB+x5gGABwzFsvxZOg+ApQ-DAHaFz3iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 16:43:48 -0700 Rosen Penev wrote:
> > On Wed,  2 Oct 2024 19:11:35 -0700 Rosen Penev wrote:  
> > > There's actually a bug above where it returns instead of calling goto.
> > > Instead of calling goto, move dcr_map and friends down as they're used
> > > right after the spinlock in mal_reset.  
> >
> > Not a fix?  
> It's a fix for a prior commit, yes. 6d3ba097ee81d if I'm using git
> blame correctly.

Hm, I don't have this hash in my local tree.
What I'm getting at is that if it's a fix for a patch already in
networking trees the patch needs to have a Fixes tag. And if the 
bug is present in net - the patch needs to go to net rather than
net-next.

