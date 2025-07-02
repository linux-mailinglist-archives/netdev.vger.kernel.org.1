Return-Path: <netdev+bounces-203215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90490AF0CA4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC07D1C21B29
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C21223DC1;
	Wed,  2 Jul 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCx3ohmo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E31C32
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441538; cv=none; b=o3vLJkyOH4LIf0IPyVsqUFASUO0TJBxd2W09a63y5D8qX19O1WkRlNKSiOZ/Cde1gkPauGzkV86yJMcHzQpoz8o9gHjeDhRc0msfDzXn9DTaeR5Q1FLzDXTGjW0A3LpFRd31eimltLUdlUvFWqCa68o6b4X3443CAAhlgWaXfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441538; c=relaxed/simple;
	bh=uHVvYoDtIH350WD8OOWSSqSTNAIRfeuKCdAmxdjXRW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8uVdTOGOUeajSTaauWI4BhCa6HBkX2rGVg3eU11jCgnNTTVNYt3eSKza7m7V4046Yf4PJNzCbP69Q6/c07j/fsqnU1XudQuSibHUI/gVrhiRxTPZV0pTDQys6fNvl1CNdP9TvId78F2tp364cpktUNSIfBPU/aAAnj7NReeJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCx3ohmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDA6C4CEED;
	Wed,  2 Jul 2025 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751441538;
	bh=uHVvYoDtIH350WD8OOWSSqSTNAIRfeuKCdAmxdjXRW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCx3ohmo76QgxwPtNOuR4QnyAgN6snHwHiFmqLzE8j5IkVfxGxt+CDIYzvDjAgiYy
	 OeSMLuL34MEgol4yVENbXrxxnp1k/sygaIdrLdIFZ+uVDa7rlhF0cVRPysMe/kWpdE
	 OCTXJ52zGX3zejVnE7KMQkBhmu1ibJwVeFbzkeR4=
Date: Wed, 2 Jul 2025 09:32:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Message-ID: <2025070255-overdress-relight-21bf@gregkh>
References: <2025070231-unrented-sulfate-8b6f@gregkh>
 <20250702071818.10161-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702071818.10161-1-xmei5@asu.edu>

On Wed, Jul 02, 2025 at 12:18:18AM -0700, Xiang Mei wrote:
> To prevent a potential crash in agg_dequeue (net/sched/sch_qfq.c)
> when cl->qdisc->ops->peek(cl->qdisc) returns NULL, we check the return
> value before using it, similar to the existing approach in sch_hfsc.c.
> 
> To avoid code duplication, the following changes are made:
> 
> 1. Moved qdisc_warn_nonwc to include/net/sch_generic.h and removed
> its EXPORT_SYMBOL declaration, since all users include the header.
> 
> 2. Moved qdisc_peek_len from net/sched/sch_hfsc.c to
> include/net/sch_generic.h so that sch_qfq can reuse it.
> 
> 3. Applied qdisc_peek_len in agg_dequeue to avoid crashing.
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  include/net/sch_generic.h | 24 ++++++++++++++++++++++++
>  net/sched/sch_api.c       | 10 ----------
>  net/sched/sch_hfsc.c      | 16 ----------------
>  net/sched/sch_qfq.c       |  2 +-
>  4 files changed, 25 insertions(+), 27 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

