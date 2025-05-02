Return-Path: <netdev+bounces-187400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11AAA6E3A
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F55A4A08A7
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6B231821;
	Fri,  2 May 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkWn2BuL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30362230BF0;
	Fri,  2 May 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178579; cv=none; b=ai7MH7/rhu98Uls+lscjWkwwqtJmidbaHFzo7o8H7AbQwR6krgUE3pyUIk8RMhOMhzgVRRESu9KNUjKrHpYBARnSz6fUHugEh5zaJhNHF8z+t+xGO1iTa5XiAjqP7LP6QevPegllFWfEPL/TgrYiQd9q+tA84PXNLCD0EPmRr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178579; c=relaxed/simple;
	bh=nNsPW6XIz1dfXDGedIBWReECqLV2gSOT1oJoe6xzPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8TeDDX1Pxquwroazs3lwjA3GLHg6m2gLNhIxY37rc2ChD+JrMZZ8a1Nean9i8ms3WogU9WsQEgAEZHi/j42bTtG8LkYlp9H9tOGRgvo54XWVwdKAMILQNGm2KlZ7G3/nbkzGD/vTF9P3dYKCJoURlyPp9uLyHuqFaOG0D5Lbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkWn2BuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF07C4CEE4;
	Fri,  2 May 2025 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746178577;
	bh=nNsPW6XIz1dfXDGedIBWReECqLV2gSOT1oJoe6xzPy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkWn2BuLyal3lMk+03qVPnGB4YzEZb/iTNj8WHzyeTeRjRaQY6H1mgAM8Vy+fKaQ6
	 PGnuHlP7uy5OJqhnBE919YK/fkOdJEfdWOymkh/J2ToOIFTk2tVfhJnzK5hOmlGbpG
	 SLH8uG4SnafT8Ys0wGFYUTcq8fiOWNsLyghLw92N6l+bQkzQA6RqZAsV1r9S+Fbsa5
	 t1VUXX656s3deliP0xdGbc2ISD29RUesIuAn/hm6LoXnQ+sCwwAyTks99Pliwd9nv5
	 IIpJJW1qtkRZsC906bV5eoWzbTkhdk8ORB9DmrF2kzI+mf/f13RqCXE3B+koh80/OC
	 i17ZgFJitjoqQ==
Date: Fri, 2 May 2025 10:36:10 +0100
From: Simon Horman <horms@kernel.org>
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	David Decotigny <decot@google.com>,
	Anjali Singhai <anjali.singhai@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	emil.s.tantilov@intel.com, Josh Hay <joshua.a.hay@intel.com>,
	Luigi Rizzo <lrizzo@google.com>
Subject: Re: [iwl-net PATCH v2] idpf: fix a race in txq wakeup
Message-ID: <20250502093610.GE3339421@horms.kernel.org>
References: <20250428195532.1590892-1-brianvv@google.com>
 <20250501151616.GA3339421@horms.kernel.org>
 <CAMzD94SNJe3QcLgNCPtVqDa69B7qcghcBkSOPWzV43d_XAeYuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzD94SNJe3QcLgNCPtVqDa69B7qcghcBkSOPWzV43d_XAeYuQ@mail.gmail.com>

On Thu, May 01, 2025 at 12:51:48PM -0400, Brian Vazquez wrote:
> On Thu, May 1, 2025 at 11:16 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Apr 28, 2025 at 07:55:32PM +0000, Brian Vazquez wrote:
> > > Add a helper function to correctly handle the lockless
> > > synchronization when the sender needs to block. The paradigm is
> > >
> > >         if (no_resources()) {
> > >                 stop_queue();
> > >                 barrier();
> > >                 if (!no_resources())
> > >                         restart_queue();
> > >         }
> > >
> > > netif_subqueue_maybe_stop already handles the paradigm correctly, but
> > > the code split the check for resources in three parts, the first one
> > > (descriptors) followed the protocol, but the other two (completions and
> > > tx_buf) were only doing the first part and so race prone.
> > >
> > > Luckily netif_subqueue_maybe_stop macro already allows you to use a
> > > function to evaluate the start/stop conditions so the fix only requires
> > > the right helper function to evaluate all the conditions at once.
> > >
> > > The patch removes idpf_tx_maybe_stop_common since it's no longer needed
> > > and instead adjusts separately the conditions for singleq and splitq.
> > >
> > > Note that idpf_rx_buf_hw_update doesn't need to check for resources
> > > since that will be covered in idpf_tx_splitq_frame.
> >
> > Should the above read idpf_tx_buf_hw_update() rather than
> > idpf_rx_buf_hw_update()?
> 
> Nice catch, that's a typo indeed.

Thanks. I only noticed because on reading the above I was looking
at idpf_rx_buf_hw_update(). Which turned out to not be very useful
in the context of reviewing this patch.

> > If so, I see that this is true when idpf_tx_buf_hw_update() is called from
> > idpf_tx_singleq_frame(). But is a check required in the case where
> > idpf_rx_buf_hw_update() is called by idpf_tx_singleq_map()?
> 
> No, the check is not required. The call is at the end of
> idpf_tx_singleq_map at that point you already checked for resources
> and you're about to send the pkt.

Thanks for the clarification.
In that case this patch looks good to me.
(But please do fix the typo.)

Reviewed-by: Simon Horman <horms@kernel.org>

