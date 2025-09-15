Return-Path: <netdev+bounces-223196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66AB583F0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A53D1AA6300
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2512836A3;
	Mon, 15 Sep 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIJ4mkxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49479274FE8
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958504; cv=none; b=m4YzhqAly7icty+KywqwO8b36WQDZPRvL44ZUP8cX7yvJDaghSK2pE1KuWk0QAdA98XUJQFgnjTCOWAltg9aj2tcNjCirlkgh7N7RauIxqixvfVkKMqpI4+RpqcNtrJUbTv42DSS86poshYjd5nopa2G+ZPjAbZ/Wly6B3x0x6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958504; c=relaxed/simple;
	bh=PAh165AFiMR2Gs/st7Hch24LUettGMBXS5jaLJ6OD3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPDGkTcUSxuSE51mspj9W8GL8R5Ho/nMUT0UxvhvaKPaYHbaAWAZP1XoC9dgiLbWFlBTErk9Ovk61SN2P5sqRX4EBajy2U5uPOm+7yps6P7JZnlKVgnc3LjnHtjlfLYdEwUk6SCagft9dRH+J0gZjaMK0UJ5MVOet5milxBeeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIJ4mkxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6A5C4CEF1;
	Mon, 15 Sep 2025 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757958503;
	bh=PAh165AFiMR2Gs/st7Hch24LUettGMBXS5jaLJ6OD3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIJ4mkxjy44XlrL7tM16idAngdvnj2mKWfLBBX3oOwJ4+/CN9exJfq8kC2S5Tekq6
	 m9x1tnq+x4QvpO42cEOTBBswWP00hNqsUxJEVCQbLlYrEWUUsNgofNMuTH+IXCan3x
	 OF+/pQxZvkdN3h2NL0sp1ywQMCDHAgMz1SJ2ufTFs/uj3hfHdfAbsjXY87WcUVGjjM
	 G05VPH5v9bl5wuhxG4Z/s7LapKfPN6kq5hSGspoX9pmqfYZ2wK1sb2+13hgspuERef
	 pJwHVBeFDcjtknRPSqpZLF5Z7gseHM1sw6KS0BY3jtyaf9dciXNyGRCpmE19HZYrul
	 Og0kjcO5+2Wtw==
Date: Mon, 15 Sep 2025 18:48:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 2/9] eth: fbnic: use fw uptime to detect fw
 crashes
Message-ID: <20250915174819.GA320514@horms.kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
 <20250912201428.566190-3-kuba@kernel.org>
 <20250915095846.GO224143@horms.kernel.org>
 <20250915081640.6d86ff6f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915081640.6d86ff6f@kernel.org>

On Mon, Sep 15, 2025 at 08:16:40AM -0700, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 10:58:46 +0100 Simon Horman wrote:
> > On Fri, Sep 12, 2025 at 01:14:21PM -0700, Jakub Kicinski wrote:
> > > Currently we only detect FW crashes when it stops responding
> > > to heartbeat messages. FW has a watchdog which will reset it
> > > in case of crashes. Use FW uptime sent in the heartbeat messages
> > > to detect that the watchdog has fired.  
> > 
> > I see that the time sent in heartbeat messages is critical to this check.
> > But the time sent in ownership messages is also used, right?
> 
> Fair, will add. I wasn't sure how to concisely include this.
> Ownership is kinda like the 0-th heartbeat in my mind..

Yeah, it was a bit of a nit pick.

> 
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > > index 6e580654493c..72f750eea055 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > > @@ -495,6 +495,11 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
> > >  
> > >  	fbd->last_heartbeat_request = req_time;
> > >  
> > > +	/* Set prev_firmware_time to 0 to avoid triggering firmware crash
> > > +	 * detection now that we received a response from firmware.
> > > +	 */  
> > 
> > I'm having a bit of trouble understanding this comment.
> > Here we are sending an ownership message.
> > Have we (also) received a response from firmware?
> 
> Yes, sorry..
> 
> > > +	fbd->prev_firmware_time = 0;
> > > +
> > >  	/* Set heartbeat detection based on if we are taking ownership */
> > >  	fbd->fw_heartbeat_enabled = take_ownership;
> > >  
> > > @@ -671,6 +676,9 @@ static int fbnic_fw_parse_ownership_resp(void *opaque,
> > >  	/* Count the ownership response as a heartbeat reply */
> > >  	fbd->last_heartbeat_response = jiffies;
> > >  
> > > +	/* Capture firmware time for logging and firmware crash check */
> > > +	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);  
> > 
> > Maybe FBNIC_FW_OWNERSHIP_UPTIME?
> 
> ack!
> 
> Thanks for reviews!

Thanks. I did look over the rest of the series, and it looked good do me.
I'll plan to look over v2 too.

