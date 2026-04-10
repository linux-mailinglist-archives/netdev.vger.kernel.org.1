Return-Path: <netdev+bounces-277596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCspBLtx2WkqpwgAu9opvQ
	(envelope-from <netdev+bounces-277596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:55:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BEF3DD0FD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DF53008A5D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449F3D9DD6;
	Fri, 10 Apr 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDZagmWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3643A75B6;
	Fri, 10 Apr 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858090; cv=none; b=jnNj/9Du1reBzaOKXnn66uIi/hwDWA58q2gHPyiNRxaRiQ+4QBBX9ky8txObpDgdHb4Si14RJanISPUhlK1sHd6CHgiYMtTU3rGLhhjFAt8Yv1AFwH2Wco3exnIFHRIvnlGVexg9p2AtCmVWejIgJKa6n8cUDhnD2lWicMg2ycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858090; c=relaxed/simple;
	bh=X5q6z5H3y9WtQ8e9BvApszu5+3oTNauKE1NviLWyRx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME38Nc6TUOcczf/fqra5AbqS/OVcae0qG+nx9JZO7vvMpaHMrewxA7m+kqgn2xuifpvLEXxtSp2bBjQVonhqziY0m/KzmFuIJgikKpq8jk+NY2Pc16s+rluJnu5DbLd8oSaFm5a8iz1wl3evCST07ofD7xowBTeD2/z5fF2FypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDZagmWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B6CC19421;
	Fri, 10 Apr 2026 21:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858090;
	bh=X5q6z5H3y9WtQ8e9BvApszu5+3oTNauKE1NviLWyRx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDZagmWGncye94QHcmv5bn8sAWZonPeQYtjrep0KwwC6BnmbtGGBHgCGWCmKHySjq
	 yTBEO/wIMegET6YOOxPWUWz3uK5txFaOPE2ZSb4VR/xBGH75T+4s4/JqAJHe4Y3OJO
	 uEQKwASj4bZcEKp8Jut1YtN3aMSTzUGBQdHee5YKsPX6nrnUQaQjU3v9L4Nv99KToM
	 POdDTWdkrcIVCFcz6052ioGnx1ccepJ6hKxJlKC1Wsi1PZZc1sPtaAwfI+H1lwfNrg
	 VnBYFAkp6K9sDKkwv31i+KgXiC1WB+5BgUks+G09T+8kvFoKKC9RQ6fwvTn7iKuktX
	 uY3NRKSMv4LHg==
Date: Fri, 10 Apr 2026 14:54:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>, stable
 <stable@kernel.org>, workflows@vger.kernel.org
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260410145448.38253e3c@kernel.org>
In-Reply-To: <20260410143042.1d4436de@kernel.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
	<20260409190328.GS469338@kernel.org>
	<20260409203235.6b9329f0@kernel.org>
	<2026041026-excuse-slashing-c4ee@gregkh>
	<20260410143042.1d4436de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277596-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 61BEF3DD0FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> > On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:  
> > > Or for simplicity we could also be testing against skb_headlen()
> > > since we don't expect any legit non-linear frames here? Dunno.    
> > 
> > I'll be glad to change this either way, your call.  Given that this is
> > an obsolete protocol that seems to only be a target for drive-by fuzzers
> > to attack, whatever the simplest thing to do to quiet them up I'll be
> > glad to implement.
> > 
> > Or can we just delete this stuff entirely?  :)  
> 
> Yes.
> 
> My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
> Create GH repos which provide them as OOT modules.
> Hopefully we can convince any existing users to switch to that.
> 
> The only thing stopping me is the concern that this is just the softest
> target and the LLMs will find something else to focus on which we can't
> delete. I suspect any PCIe driver can be flooded with "aren't you
> trusting the HW to provide valid responses here?" bullshit.
> 
> But hey, let's try. I'll post a patch nuking all of hamradio later
> today.

Well, either we "expunge" this code to OOT repos, or we mark it 
as broken and tell everyone that we don't take security fixes
for anything that depends on BROKEN. I'd personally rather expunge.

cc: workflows, we can't be the only ones still nursing Linux 2.2 code

