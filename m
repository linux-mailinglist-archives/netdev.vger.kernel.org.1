Return-Path: <netdev+bounces-258313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPJpEXe0jGmMsQAAu9opvQ
	(envelope-from <netdev+bounces-258313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:55:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5A1265A8
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85574300E3FA
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3733F8C2;
	Wed, 11 Feb 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBmVHonf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3C33858B;
	Wed, 11 Feb 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828916; cv=none; b=fHDjhKaE4P9ka3DOJxi4UOs0qxS+1gJ73hBp3+5ms8J2LtIHzJHdaOxyLzlN0TVUBmnchqMHTto+LF/jBpRhqcQxyp1fj11DFUxaMt2hpmEJg/5EJJitgudQXTNe45DDcJvZWBbl/UjobWtY4ND5DOvE62Grz7oqVzlTCTGW/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828916; c=relaxed/simple;
	bh=Y2PMXtu0GUoeJQBtrN8qTIfP5aBOdJ67NuNqMm93nig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps1rWCYfSp33StoydlAmXYuDwmqz5aEPoTVdqgx80jIhMkjkCg+YSWUzi0IXdrIUiqvg08kTTcsNADSqtF/huTyE4i+BXA2kN2L/viqYF75hUaV1vEpkkD7C3ZN3AYxVMX/JA+r37hfl/zeBucnDs7zSZUJ1ogF3dJJbTt8PWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBmVHonf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B38C19423;
	Wed, 11 Feb 2026 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770828916;
	bh=Y2PMXtu0GUoeJQBtrN8qTIfP5aBOdJ67NuNqMm93nig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBmVHonfozf0qNA1KZRnZv5nazyltUBrZWehImhE5oWdXfp/BUa9ds9e0ZCBmtzpR
	 x8voQl46A8SQcPmCzfRhmiUDRzFy8fEbWYbPi29J+n3bLPtQx4n7k90v9PH2C+6Z+m
	 GiEZ8oNUv/u+DADD2QwZzEnDBfh8S4XAn3UKgngvM4jlonOesVRUVDblL7YdBBh5Eh
	 eoy0UO4f0QZ57q0J2gI1hVMmmPCjs7ZwSetLgj15ngeIksYA9GO0W5RiVWeJqQxk3q
	 U7Pt9dRDAKCCEhCGkWLk2epPvlbTMlo9gjMy8HVCI7P5nC2EJgYVfZoncZLTBtOSoe
	 E5pKDnC81/NXw==
Date: Wed, 11 Feb 2026 08:55:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
 <sdf@fomichev.me>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <sx.rinitha@intel.com>, <horms@kernel.org>, <yury.norov@gmail.com>,
 <john.fastabend@gmail.com>, <kohei@enjuk.jp>,
 <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
 <alexander.nowlin@intel.com>, <daniel@iogearbox.net>,
 <maciej.fijalkowski@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
 <edumazet@google.com>, <aleksandr.loktionov@intel.com>,
 <marcin.szycik@linux.intel.com>, <hawk@kernel.org>,
 <jacob.e.keller@intel.com>, <magnus.karlsson@intel.com>,
 <pmenzel@molgen.mpg.de>, <pabeni@redhat.com>, <bpf@vger.kernel.org>,
 <davem@davemloft.net>, <andriy.shevchenko@linux.intel.com>
Subject: Re: [net-next,3/9] ice: migrate to netdev ops lock
Message-ID: <20260211085514.428236b7@kernel.org>
In-Reply-To: <2a300bf0-3975-4f79-a3e0-5cb9b8159d62@intel.com>
References: <20260206174910.4066255-4-anthony.l.nguyen@intel.com>
	<20260211042458.555701-1-kuba@kernel.org>
	<2a300bf0-3975-4f79-a3e0-5cb9b8159d62@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258313-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,fomichev.me,lunn.ch,kernel.org,gmail.com,enjuk.jp,iogearbox.net,google.com,linux.intel.com,molgen.mpg.de,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7A5A1265A8
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 14:51:56 +0100 Alexander Lobakin wrote:
> >> +free_coalesce:
> >> +	kfree(coalesce);
> >> +decfg:
> >> +	if (ret)
> >> +		ice_vsi_decfg(vsi);  
> > 
> > Should this be ice_vsi_decfg_locked(vsi)?
> > 
> > ice_vsi_rebuild_locked() is called with the netdev lock already held
> > (either by the ice_vsi_rebuild() wrapper or by callers like
> > ice_vsi_recfg_qs()). The error path at label 'decfg:' calls ice_vsi_decfg()
> > which tries to acquire the lock again:
> > 
> > ice_vsi_rebuild_locked() [netdev lock held]  
> >   -> ice_vsi_decfg()
> >      -> netdev_lock(dev)  /* deadlock - already held */  
> > 
> > This would deadlock when an error occurs after ice_vsi_cfg_def_locked()
> > succeeds but a later operation fails.  
> 
> Tony also fed the series to AI, two times, and each time he got a
> different answer.
> The series was on iwl-next for 1.5 months and only one bug was reported,
> which I fixed immediately.
> 
> I can take a look into this, but wouldn't be better if we take the
> series now and then have 2 months to fix bugs if any appears?

I understand the frustration, but unless the review is a false positive
I don't see how we can ignore it.

Looking at the PR rate from Intel I suspect you may be better off
pointing your frustration at the internal process? There seems to 
be a net-next PR every 2 weeks in 2026. It's not like the 1.5 mo 
was spent waiting on upstream?

