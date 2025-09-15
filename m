Return-Path: <netdev+bounces-223120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5AB58030
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1163B1010
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8323191AB;
	Mon, 15 Sep 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlpgRoWg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15130E0F2
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949402; cv=none; b=TXGrOWnRD017m/RKtxa4lo62zVCHt6MlnZIPl782YIKpb/BIJDmztsiNEWHsW2h0HlgqCh4nJlIZ9yWjlShr1oeI1mbuwv2d9sm3BGyybdxSZDYTob1L6+mBFDWvTfmQo1WgPUT6t7sIJFbkyRaNY0NC4yuNensfyigphCAaFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949402; c=relaxed/simple;
	bh=LuKYQMCnP1LS/CAJAZl9A9uSSLXK7wO2ORBieue52UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWTybyOTMcH31D3+b/mx/q3LMu/aaFEc7zHDdcXinrJco+Zz5hntaXkFotaOkHa8cZmWsEeBVTZn04SEozhXrVoJny8Le5zRmsWcspyqq9+ubuGo7W/TAKPPUbFSioJFNc0FfxQ7FIqhn45u3uVZ5itdczJgqTmOpmJzmmL2/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlpgRoWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D45C4CEF1;
	Mon, 15 Sep 2025 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949401;
	bh=LuKYQMCnP1LS/CAJAZl9A9uSSLXK7wO2ORBieue52UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DlpgRoWgU+IqMxuDjVrGu1xTj3hHA8S+OFw/CTXE35Z0m/d3a/ex4d+WQVZjlT+oA
	 tomoLFjK/1jZVvB14JMzKCJm+vHv5zv6J4sq02kJp7XdRiKkJjjNIMDRR2lAtrqGrQ
	 c8LheYdY362WF0il5E9NQPxNm9g4LcYkiUaulFbZdaOyTKX617Gnv1o+e4BUxGsu7U
	 p5SsMudL+Oah2djJvcudxjMTbSFNJAYUASq0AO4uyoVRxem9JUuVuquqfoirkPuYem
	 4CcQzm42orb48YEjZ6jkGfrd4NMkcgbDE5izua7pivzWIrfZSgXMh7G3fjjnUVv4Lc
	 /zdX308senOOg==
Date: Mon, 15 Sep 2025 08:16:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
 jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 2/9] eth: fbnic: use fw uptime to detect fw
 crashes
Message-ID: <20250915081640.6d86ff6f@kernel.org>
In-Reply-To: <20250915095846.GO224143@horms.kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
	<20250912201428.566190-3-kuba@kernel.org>
	<20250915095846.GO224143@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 10:58:46 +0100 Simon Horman wrote:
> On Fri, Sep 12, 2025 at 01:14:21PM -0700, Jakub Kicinski wrote:
> > Currently we only detect FW crashes when it stops responding
> > to heartbeat messages. FW has a watchdog which will reset it
> > in case of crashes. Use FW uptime sent in the heartbeat messages
> > to detect that the watchdog has fired.  
> 
> I see that the time sent in heartbeat messages is critical to this check.
> But the time sent in ownership messages is also used, right?

Fair, will add. I wasn't sure how to concisely include this.
Ownership is kinda like the 0-th heartbeat in my mind..

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > index 6e580654493c..72f750eea055 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > @@ -495,6 +495,11 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
> >  
> >  	fbd->last_heartbeat_request = req_time;
> >  
> > +	/* Set prev_firmware_time to 0 to avoid triggering firmware crash
> > +	 * detection now that we received a response from firmware.
> > +	 */  
> 
> I'm having a bit of trouble understanding this comment.
> Here we are sending an ownership message.
> Have we (also) received a response from firmware?

Yes, sorry..

> > +	fbd->prev_firmware_time = 0;
> > +
> >  	/* Set heartbeat detection based on if we are taking ownership */
> >  	fbd->fw_heartbeat_enabled = take_ownership;
> >  
> > @@ -671,6 +676,9 @@ static int fbnic_fw_parse_ownership_resp(void *opaque,
> >  	/* Count the ownership response as a heartbeat reply */
> >  	fbd->last_heartbeat_response = jiffies;
> >  
> > +	/* Capture firmware time for logging and firmware crash check */
> > +	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);  
> 
> Maybe FBNIC_FW_OWNERSHIP_UPTIME?

ack!

Thanks for reviews!

