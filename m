Return-Path: <netdev+bounces-282235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEZZK1CN8WkaiAEAu9opvQ
	(envelope-from <netdev+bounces-282235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:47:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B82C48F3C2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E0E9301022B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E314884C;
	Wed, 29 Apr 2026 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZzo1Z/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AB75809
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777438027; cv=none; b=JG4ptk2noj1Vw/NW0mfDISI00RPEGleekX976fFTg2cCiO4/I2lB5ISeZ5d4Nw1EKOXAECsCRmqJaVCH/nO5iIYbfdZ09ryuUb0i/E/PSoiuuMb4BleJoFl171vAeix0c3H7ByOPfZvNUgWy0aCfJlDe4W/C5n48lXTZbMO6bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777438027; c=relaxed/simple;
	bh=k3eE/UeoCnTj/xYCtWaA5SEja01S69y72LQD0pLWvGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzTevboVJKcnU4hJIOR1gAfHqHXG2ZuAQaZ9Eoc3FLIYivRtJhvV+FpgOMA5n48yWSZFjgAHEdoxv4V8nWDkNY7/euuM1KXVuGTDSu6P8NJl6CVuHW0bp0pCGqDhnp2sFJg1vzcCSBk2UYD8HiuVPDgysjYQ9qDR3CmqAFDjGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZzo1Z/t; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777438026; x=1808974026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3eE/UeoCnTj/xYCtWaA5SEja01S69y72LQD0pLWvGo=;
  b=gZzo1Z/tt8QAExBv8ZpTPseqOhn7CfnqB9Xt8W0I5VR8MvqARnfICyV2
   WdUwf65zYIFVJ6I0LIAJU7qfOOZ1bFP28bubrGrJVGuJads8NhQr5gKx0
   yCh3zUYEhu/gmXf5WTPtEFh2yGbGCvtOLYb2Sgt0RTfwAr2Yjgfevylgp
   HG71m8KC1IpKQ1tvcs50NnWFupd9puWtlyIdcYJyvO/ga8vx33OUcgjU0
   sSegZ7y1x6KY5raJUFudwTJYnt4RHw0HPyg+ylINB2hSMN429wbsnwv/k
   z//ePAQNtg2O795SqVC5uUd2YdoP9Nqqp+PF+cOleXfzv0AGPIfuoEXst
   g==;
X-CSE-ConnectionGUID: 4O7+J1FCRlGkCHC/cxh3QA==
X-CSE-MsgGUID: +FxxHjSITqqcua0G9Sb/Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78344040"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78344040"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 21:47:06 -0700
X-CSE-ConnectionGUID: BR+0NMb+SDmCD8rOINrD2w==
X-CSE-MsgGUID: 3FPqqbKLRNCYIX61PKykjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="238126899"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 28 Apr 2026 21:47:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F287D95; Wed, 29 Apr 2026 06:47:01 +0200 (CEST)
Date: Wed, 29 Apr 2026 06:47:01 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH 2/2] net: thunderbolt: Fix lockdep issue during tunnel
 tear down
Message-ID: <20260429044701.GY557136@black.igk.intel.com>
References: <20260427081623.2338179-2-mika.westerberg@linux.intel.com>
 <20260429011226.1505821-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429011226.1505821-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 8B82C48F3C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-282235-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim]

On Tue, Apr 28, 2026 at 06:12:26PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>     net: thunderbolt: Fix lockdep issue during tunnel tear down
> 
> This commit attempts to fix a circular locking dependency warning in
> tbnet_tear_down() by dropping the connection lock earlier and returning if the
> connection isn't fully established.
> 
> > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > index 631af237998d..d8fcf18fc55c 100644
> > --- a/drivers/net/thunderbolt/main.c
> > +++ b/drivers/net/thunderbolt/main.c
> [ ... ]
> > @@ -372,48 +372,47 @@ static void tbnet_free_buffers(struct tbnet_ring *ring)
> >  
> >  static void tbnet_tear_down(struct tbnet *net, bool send_logout)
> >  {
> > +	int ret, retries = TBNET_LOGOUT_RETRIES;
> > +
> >  	netif_carrier_off(net->dev);
> >  	netif_stop_queue(net->dev);
> >  
> >  	stop_login(net);
> >  
> >  	mutex_lock(&net->connection_lock);
> > +	if (!net->login_sent || !net->login_received) {
> > +		mutex_unlock(&net->connection_lock);
> > +		return;
> > +	}
> 
> If the connection is in a partially established state (e.g. login_sent is
> true, but login_received is false), this early return skips clearing the
> connection states.
> 
> Could this stall the connection if a new TBIP_LOGIN arrives later?
> tbnet_handle_packet() would see net->login_sent as true and might fail to
> queue the login_work to reply.

I don't think that matters because tbnet_tear_down() is actually tearing
down the connection so after this we do not expect the connection to be
established until start_login() is called again (this happens when the
interface is brought up again or on resume).

> > +	net->login_sent = false;
> > +	net->login_received = false;
> > +	mutex_unlock(&net->connection_lock);
> 
> By releasing net->connection_lock here, the rest of the teardown process runs
> without mutual exclusion. Since the network interface is still running, is it
> possible for tbnet_handle_packet() to receive a new TBIP_LOGIN request right
> after this lock is dropped?
> 
> If tbnet_handle_packet() acquires the lock, updates net->remote_transmit_path
> and brings up a new connection concurrently:
> 
> CPU1
> tbnet_tear_down()
>    mutex_unlock(&net->connection_lock);
> 
> CPU2
> tbnet_handle_packet()
>    mutex_lock(&net->connection_lock);
>    net->remote_transmit_path = pkg->transmit_path;
>    mutex_unlock(&net->connection_lock);
> 
> CPU1
>    tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
> 
> Would CPU1 then erroneously release the newly established connection's hopid
> and free active buffers?

Oh, this one definitely can happen.

> >  
> > -	if (net->login_sent && net->login_received) {
> > -		int ret, retries = TBNET_LOGOUT_RETRIES;
> [ ... ]
> > -		tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
> > -		net->remote_transmit_path = 0;
> > -	}
> > +	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
> > +	net->remote_transmit_path = 0;
> >  
> > -	net->login_retries = 0;
> 
> With the unconditional clearing of net->login_retries removed, does the
> login_retries counter keep accumulating if tbnet_tear_down() returns early
> above?
> 
> If it exceeds TBNET_LOGIN_RETRIES, could it permanently prevent new
> connections until the module is reloaded?

Indeed, that's an accidental removal.

Okay let me try to figure out better fix for this lockdep issue.

