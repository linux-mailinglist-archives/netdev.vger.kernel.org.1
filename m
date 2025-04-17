Return-Path: <netdev+bounces-183941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B2A92CDC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AB81B65BB1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D720DD4D;
	Thu, 17 Apr 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uuVjjB9C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778D18D63E;
	Thu, 17 Apr 2025 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926911; cv=none; b=bogDlofYNOomUxvq59GWSovwl7f8bDBdr4bF8RmzWlF5DV26gm46JqqTpuur/XSDH1osI5UVu1Lc1chOzVN67R4qzQwRG/Yh0smmQvRjlK1/IRRAhn/sj9IPMXwcqJa6cLRuonW/AoiZ8HB+oePRnzLGyf8EvpDJuQAAM9UZ7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926911; c=relaxed/simple;
	bh=ByPpYENxlIZaec+r3yhyrtXdmtS7Tm69rsr9RCqlPJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA6cY9idM6OiaWq8yAXO3GBckkQ5AlRsNYGm/J9pKQgV+cZwy3b4GendWedzKGZWaG0vxt74xK0fYI74aKDB4c3UaDh0vowPZ/zjUatLu4o5rADi1IJpbYipHyurD6GE52eY0CleFDlW9GsEGbYg9hButH8o+2USHQ5MAO45fhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uuVjjB9C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AoxkqaP/iwiaCH2PRcdctSE2Zygsq/ejG5zO2o7rnKo=; b=uuVjjB9CvUsob4jkYbsqVZ2TLI
	/celJbqQ6R3m7vQHTBKsdpjzssBVF5969/s54JUV9Ka3oBrQJ9bVAuuplzU5x2GJAWz69dlLfK07b
	rG6+9Gf04ehG9YFSa8n//p2rpgIet/eO08ubHtGzQ+uADs922cAn0hasjREqlFBjzX/g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5XCF-009pub-7D; Thu, 17 Apr 2025 23:54:59 +0200
Date: Thu, 17 Apr 2025 23:54:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/8] ref_tracker: widen the ref_tracker_dir.name field
Message-ID: <09b53a5a-60af-4f4b-b69f-b92baca740ef@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-6-c3159428c8fb@kernel.org>
 <6ad1f1ae-a912-43ec-aac5-de49e344e9ff@lunn.ch>
 <c635c6024a18e9a3bd1f3832521f1976377fe314.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c635c6024a18e9a3bd1f3832521f1976377fe314.camel@kernel.org>

On Thu, Apr 17, 2025 at 05:27:05PM -0400, Jeff Layton wrote:
> On Thu, 2025-04-17 at 21:29 +0200, Andrew Lunn wrote:
> > On Thu, Apr 17, 2025 at 09:11:09AM -0400, Jeff Layton wrote:
> > > Currently it's 32 bytes, but with the need to move to unique names for
> > > debugfs files, that won't be enough. Move to a 64 byte name field.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > 
> 
> 
> Thanks for the review!
> 
> It occurs to me that we don't technically need this patch, since
> ref_tracker_dir_debugfs() doesn't overwrite dir->name in this version.

I had not noticed that. I don't know if that is good or bad. Two
different names for the same thing. Nice thing is, this is debugfs, so
we are not setting an ABI. We can change this any time we want.

> Perhaps we should drop this patch, or I could define the
> REF_TRACKER_NAMESZ constant and just leave it at 32?

Having the constant might make future changes easier to make, avoid
having to find the hard coded 32.

	Andrew

