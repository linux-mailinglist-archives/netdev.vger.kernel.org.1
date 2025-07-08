Return-Path: <netdev+bounces-205059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F776AFD003
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE46164B72
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F742E2650;
	Tue,  8 Jul 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3xid32c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2E2E1C7E;
	Tue,  8 Jul 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990590; cv=none; b=NymJnvpu6l/NzffA6PFlpQgwtsB1/1xYfWj7zX0LpXEuzUHrcGOOoI1s3j1ylAwJ8k4Vf0w+qPGsZzNQNbZ4cFF1tWaz8D9CyRg/JfpA4Q9XT9w+vMexvF4ZCmLEb9HUi77lQGn+vdycvtGDhgMkuUEYjufqA4hLqQlSXzrqpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990590; c=relaxed/simple;
	bh=EoC6yc7OO0VBA0GCnQuBY+oXVovM8qW1gfXIRRCWGi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qjn0vmTs6NrAWwhrrKRmA33SHAgMHgiE9Lz4nHS2Ugo/AuytuegL47hqIUSdzDL02jpZQyxba76ernXAh10C+3g+3EQ4d2ms31/BbRksTrtoNhQpqxfxUL/XTcqRR8s6+xsHRo1MxVY0OV4H8Z5mt7tWo+pIPqjmZUPEaZfwC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3xid32c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DEBC4CEED;
	Tue,  8 Jul 2025 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990589;
	bh=EoC6yc7OO0VBA0GCnQuBY+oXVovM8qW1gfXIRRCWGi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3xid32c+HhmW2tnCkqdq+dPKTq+eBvRBSKIEtMgevMDDR33dLNI2+D+rBVWm3wix
	 NPDdmBtIyF+80qNdcCcMWW07TGOiZ7yvTd5g1Gq5vBGTHBg8jiFAuTvXOpA40Iw9j3
	 r0HrakaYltXjW7ccFBobEMl7zLlg937FgWJhOMsk6LgE/ZC64mBYVzkQPMIacpBbBF
	 P6mvzD0GeCFUXKmu9sl8BEcT7xtldo/STHXHqX2gSL4Z6Ywgndf2S2J9Ejl+LImpER
	 fPNgdmLYxuNQw1OlvwRDPVZjzgLp9rNxMoktOpXT+hwrxXTgpFzsDbkgyUKTgyAwgx
	 MIdkp6Uejjdqw==
Date: Tue, 8 Jul 2025 17:03:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: Fixes for TX ring sizing and resize error
 reporting
Message-ID: <20250708160305.GP452973@horms.kernel.org>
References: <20250521092236.661410-1-lvivier@redhat.com>
 <7974cae6-d4d9-41cc-bc71-ffbc9ce6e593@redhat.com>
 <20250703053042-mutt-send-email-mst@kernel.org>
 <c7eb3517-2fc3-4d91-8fa3-e5c870acece1@redhat.com>
 <20250707172909.49d40a92@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707172909.49d40a92@kernel.org>

On Mon, Jul 07, 2025 at 05:29:09PM -0700, Jakub Kicinski wrote:
> On Thu, 3 Jul 2025 11:34:55 +0200 Paolo Abeni wrote:
> > On 7/3/25 11:31 AM, Michael S. Tsirkin wrote:
> > > On Wed, May 28, 2025 at 08:24:32AM +0200, Paolo Abeni wrote:  
> > >> @Michael: it's not clear to me if you prefer take this series via your
> > >> tree or if it should go via net. Please LMK, thanks!
> > > 
> > > I take it back: given I am still not fully operational, I'd like it
> > > to be merged through net please. Does it have to be resubmitted for
> > > this?
> > > 
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>  
> > 
> > I just resurrected the series in PW, so no need to repost it.
> 
> This was merged by Paolo as b0727b0ccd907a in net/main.
> 
> No reply from pw-bot I presume because patchwork is aggressively
> marking this series as Archived before the bot can get to it.

The bots are fighting again :(

