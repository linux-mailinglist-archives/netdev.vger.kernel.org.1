Return-Path: <netdev+bounces-294858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HWDELTBnIGo/2wAAu9opvQ
	(envelope-from <netdev+bounces-294858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CA63A390
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:41:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Kb00RqRZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294858-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294858-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C5B53018F7B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3646374E79;
	Wed,  3 Jun 2026 17:34:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B825CC74;
	Wed,  3 Jun 2026 17:34:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508062; cv=none; b=I8JwaLvl6IzyDh605q/Xc3eUUbp4BKR7Yfgusqw+xBOaqvjduvnFH5W4Q3j84NWEI93WzNg9lO/02+7mTgeofOh4SOKUju0f23gd+GU5ckFk6SEuDeY7cU3yzOF61oa7DLAs7B/Z/PPsQBIY5Zvyc4ObsfhkRWdGtIXcI1NqYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508062; c=relaxed/simple;
	bh=cbK0bcECluYljgNp3tF5adZCke5B3YN24V6fRCK4LLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA8B7/djdeiC75t76lWxhXKjFKsA7ssc2+fGaDDEJT+D6tivZwB+o6MJG0Z9A80ecYuR4aLbFDjfO+ofnbkgR73mhEKLdgkAVTIJbiA6zYauFqhWwMaW4uN4CWZPImSc3fH+ddhD5zl+XeUJ6xJ5hTBopGa4BSWlnq5r/Y5qyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb00RqRZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141FD1F0089A;
	Wed,  3 Jun 2026 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780508060;
	bh=nMjXRltGnZkW5Hq9b/rwj4GJ5tj6xsxNMNPP7r5MWc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kb00RqRZRvD84OgxTj0qYjpqBfp5efG7UY4PGsfjX3NHAS+bTtyw3PRU+aYzU1FRQ
	 1U3AjtNzbhhLalNV2JLKHRD2gc0FYqS13upKp+BVLjBNVf1Y47I8tA/xkIYN1lwF0E
	 CbS+Y3EGBoAOEZGlc4Wa4+ABM//ib+6igDpN86s5pmDgd2r0ixoerZSutPkW9X5jdx
	 DLl67m7RHps8hDdPs7rQTB3CS8Ss4JLARedInOUvyn2E3DzSjUB79wEt5PrWOmFddQ
	 wiEq59xjeP4ereZPjP96QqnZ08vQUDSXxibNDEKHqri5pvpwORnreqBTe5t1L2T6pX
	 7qKJUOy/xbCOQ==
Date: Wed, 3 Jun 2026 10:34:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 stfomichev@gmail.com, kernel-team@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: bnxt_en: suspicious RCU usage in bnxt_fw_reset_task() qdisc
 path in 7.1-rc6
Message-ID: <20260603103419.6d5f373d@kernel.org>
In-Reply-To: <aiATI9qUfsL0jq1u@gmail.com>
References: <ah726OtFX-Qw3U-R@gmail.com>
	<20260602105451.18a7390f@kernel.org>
	<aiATI9qUfsL0jq1u@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,meta.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294858-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:stfomichev@gmail.com,m:kernel-team@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A34CA63A390

On Wed, 3 Jun 2026 04:43:01 -0700 Breno Leitao wrote:
> On Tue, Jun 02, 2026 at 10:54:51AM -0700, Jakub Kicinski wrote:
> > On Tue, 2 Jun 2026 08:33:31 -0700 Breno Leitao wrote:  
> > > This looks like a regression from:
> > > 
> > >   850d9248d2ea ("Revert "bnxt_en: bring back rtnl_lock() in the
> > >                   bnxt_open() path"")
> > > 
> > > That revert dropped rtnl_lock() from the bnxt_open() paths and left
> > > bnxt_fw_reset_task() holding only the instance lock around bnxt_open().
> > > 
> > > I can send a patch restoring rtnl_lock() around the bnxt_open() call in
> > > bnxt_fw_reset_task() (re-taking rtnl before the instance lock, matching the
> > > pre-revert code), but I wanted to report it first to make sure I am in the
> > > right direction.  
> > 
> > Yes, we need to revert the revert. Per my recent ethtool locking series
> > netif_set_num_tx_queues needs rtnl_lock for now.  
> 
> Ack and thanks for the direction. Do you want me to do it, or, is it
> someone is already taking care of?

I'll send it out and CC y'all. Stan points out that full revert may not
be necessary..

