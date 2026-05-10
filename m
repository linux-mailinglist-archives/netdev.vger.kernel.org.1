Return-Path: <netdev+bounces-286343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNnCBn25AGqmLwEAu9opvQ
	(envelope-from <netdev+bounces-286343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:59:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5550540D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C7383002324
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657638F251;
	Sun, 10 May 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7H5FKeT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3345CA4E
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432378; cv=none; b=cyw34jykFnhmfBJ0zAReYsjwrMnRtSYWTPXQUZeet8m5rg66EdC/4+T9FDJYDHiQC+EsvJb9lu+VV1emPBb9eC2xmAHFxUH6YL3dx5Eobvq/GBzUDlO+72eK5YpilfjQ8kOO61774mBDEtFMcemG9RtZPs5OHYvlo9xnCC6XQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432378; c=relaxed/simple;
	bh=fIQOVwyFDN/lNdqwQ2/bx2neU4BDjRNiQ+i1IEnnFow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXiTYdvHApWfn5sPvCoX0qab1j44d+7B0PcHH8bKWL+O8jnn/2B4qEmzrS1METYbOg+ZH7kGbNbpbYRS0uhbGMFzS8H+OArt+H27jRULv5O6xmzUUEThUI/980waxS3cw144KuGXLDjyRnz7kVAaYtKLwff5nTBL7aPITGJD7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7H5FKeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D21C2BCB8;
	Sun, 10 May 2026 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778432378;
	bh=fIQOVwyFDN/lNdqwQ2/bx2neU4BDjRNiQ+i1IEnnFow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7H5FKeT7sXDD6t2Hdv7KwkhIq/pQjdZ2ko/s+z0oNX2baBEFQpsU3pi9w0XfYUqI
	 S7CxiAuQTtWJKwskmQoDB1icFeYTLJwkVFmzEQQZo8fMDwxgeNohn4NkSO25GYvX6w
	 Lb99zdUJEFcU82JUmrqLmZORSh7e19LZPK/Op2290orz8Bsle7nzg0N9cgzenn9PQt
	 cD/qN/fWnWHhHPCAlFvUqlC8BK2yZ3Fmp2M4lrspAv3MpQJ1U/Tp+A1rl1nJuIvjgA
	 KogansAf3HL9pXQbIaBHC82Cn5ItF/2+H6hPGvuKu0fa2LZF+8rYItq+h2PKTYIDYY
	 MRzjYRSCGUWSg==
Date: Sun, 10 May 2026 09:59:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260510095937.598c27a6@kernel.org>
In-Reply-To: <agCtGqWLK53TWCaS@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
	<20260510082509.1530a1a3@kernel.org>
	<agCtGqWLK53TWCaS@Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B2D5550540D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 00:06:50 +0800 Weiming Shi wrote:
> > Barriers are between things. What are the release / acquire barriers
> > synchronizing.  
> 
> The handler function pointer against the mode_priv state it operates
> on.  On setup, init() writes mode_priv, then smp_store_release()
> publishes the real handler - the paired smp_load_acquire() in the
> reader ensures the handler sees that state.  On teardown,
> smp_store_release() publishes the dummy before synchronize_net()
> drains readers, so exit_op() won't tear down state under an
> in-flight reader.

Still does not make sense to me. You already add sync_net().
And if it's possible to switch from dummy to non-dummy mode
the ordering is inverted.

> > Why is AF_PACKET relevant here??
> >   
> 
> Not specific to the bug, just a reproducer detail.  Dropped.
> 
> Sending v3 with the updated changelog shortly.

Please don't rush new versions out.

