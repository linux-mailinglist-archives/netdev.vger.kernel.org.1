Return-Path: <netdev+bounces-183896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6146AA92BCB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0219F1B667E5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5615202988;
	Thu, 17 Apr 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B04kaKX/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F71F585C;
	Thu, 17 Apr 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918187; cv=none; b=ckBUXfYDQqKqD3wgXIPaIh7wI8NgXdD3QtiiHPOXzvnVbJA1ro/juegDy4cqbpqaUP6Gf5dpiLo+391qRvKSblQONnZ7sQ9bVDbVRXEYiMA7kWuFQeRtmr+PRyH9G3nMNOiZucLCy94aLbIwbt8A8bbNP90BzniYq+v8I3XARNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918187; c=relaxed/simple;
	bh=BJlGURHE6MemQVjXFAMKrZK6cLY/Pa9rDV0Y3yE9/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtkMBp80rEdG+YK/kQGtAwgrAnBYWfiOdwc4TpJvqjMCnS0PJkqmicz2xgMaISGXb4UB6rneF6WwVMd+SQg98Ggod4OgqmIjh0YPaJR91i0y91iyCrm9lQufUkuw+5hcAUzu4i1yxo8QeTjDlttrcIFWk3yb7FZpqYawQ9LFduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B04kaKX/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YYni3/1yasHUrwTdeLkDnxWGmeI3BeQA9igCHa2A0qg=; b=B04kaKX/7xRwyxbgdMBzBGab8j
	Al3S4pwhaYRPg1+2ag8hWiVJW9j+iisbiiF+yJ36IzIUKsVgppCNYrw0g1lwwdOjIRabNRa2aDBmP
	KZu7bV/foVoVI3/RfKUfn6lX/4MiIhRG7BZPq2e94tD9dADbibeo6zXWxSzbEVC8eBvE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Uva-009p9t-8F; Thu, 17 Apr 2025 21:29:38 +0200
Date: Thu, 17 Apr 2025 21:29:38 +0200
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
Message-ID: <6ad1f1ae-a912-43ec-aac5-de49e344e9ff@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-6-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-6-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:09AM -0400, Jeff Layton wrote:
> Currently it's 32 bytes, but with the need to move to unique names for
> debugfs files, that won't be enough. Move to a 64 byte name field.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

