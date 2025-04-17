Return-Path: <netdev+bounces-183890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E2A92BB0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB73B322A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A161FFC53;
	Thu, 17 Apr 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i+Uc+ccw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1AA926;
	Thu, 17 Apr 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917875; cv=none; b=m2AJpyFCnWcnxRzq3RaLM8Vj8CAwXr/d79CkP2AKq8XCkVsVDsTVG5UY2MHu7N1cWud/CKLNG/wNL/MmshNzHhgDIXhaje/20r6NlfNkPzke6+FejiLupq7qjQmmZ3GLz8EPqBQw1lJ+mKt+UgJhgjIbEupL5z8fcPytJ0wNFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917875; c=relaxed/simple;
	bh=SNWSxf8+UlF6qnGNRfesiQGoFCIZZo4ApljuLAMLcQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIWuinBN1zeuPQ5UabHSWhAhMBGy4nKX6AzuxXDvpv1mAFSpssWWGp16ld9NpYevHIsj3COsVttm23O5sPnVGiBp4wL2Ku0MYQUDiIikQIGGTQmNJiZSBVLRp+pj9EgVTneMlpSmghVmluuUG+DDdibhpMnhmfanZMLD0key1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i+Uc+ccw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=40CklYnnrRZVmpvhHO08Vc7yIAqGP3b0osrBFdwWVvg=; b=i+Uc+ccwl1KbUAwE9Z18eOIA2Y
	wXJi72hUXv8FpUOdDoJr0W5mkZnTmj5/pTgws9Y0Q0pIKxijIcULOcUNw+8nkoG5rZorz2biCXsrs
	DQ9cy3jsaIc4epcEQvX3o5QiFDYC4ML30UfgB2g8fpLbFXx6IS1VkJF07+X5C4XdepV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5UqZ-009p6R-5u; Thu, 17 Apr 2025 21:24:27 +0200
Date: Thu, 17 Apr 2025 21:24:27 +0200
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
Subject: Re: [PATCH v3 2/8] ref_tracker: add a top level debugfs directory
 for ref_tracker
Message-ID: <10696fe0-0a9e-4304-951a-98af86a19add@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-2-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-2-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:05AM -0400, Jeff Layton wrote:
> Add a new "ref_tracker" directory in debugfs. Each individual refcount
> tracker can register files under there to display info about
> currently-held references.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

