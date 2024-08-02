Return-Path: <netdev+bounces-115430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B19465CA
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451A31C20F82
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A881ABEB5;
	Fri,  2 Aug 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9XhZ9tV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB96B67E
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722636081; cv=none; b=rd1h8FX14Et7f1dDgIntY4kzN8N/PBeAqMIyAgZ61ZVg1GSxdJ+3peJ5e1z+ewymtxdXEUxSSLs8gvdXiBJz3mDAUaE76oPMSmy+Aqpv//ZYWPTedz3F2D4pPOU7myjabZmxtwWCLKMgTspDPqFRWdGBoVK4WlMwZduDdsuugvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722636081; c=relaxed/simple;
	bh=G27UDolD1S5o2vZ/rMFzMAHo0IPbs/4ZJwyreb5h0Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKXnB6qqRwg5kKSqnXBiMGCSsgokeoIF8wG1CNURdPJm9BQdzGqc+fp6/7uTg+PBFjZUG5mTujGWIgQliL6GAXhSYSiLYopihypchmNmok8+B5FoSAFnkejc5tFlBF+SgcjWGWpv4fHJRpBLGkZtcgYXnITxzWz5fdmR1yTWK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9XhZ9tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A87C4AF09;
	Fri,  2 Aug 2024 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722636080;
	bh=G27UDolD1S5o2vZ/rMFzMAHo0IPbs/4ZJwyreb5h0Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t9XhZ9tVZmObRYX80SRmNra3Mz5y6DWgEpg0K4MOY2Wsi4dtWmlcJ+n3MBsr0XBrS
	 Q62Pa3Nemp/HS21+pJtEqhdS49da2R2b9vmhU4ya5ZlI+C/BNeQ3u11iCVXQu65KHo
	 /DWqGdr3uJbC8VzMgEvP2+HEKwL+qvJyRIrrjeXGokosUvL5f72UyRoVf1tZDszmzQ
	 ydG0d7L3hiyF+aCMzF2bN20MmleKZ++b/MttUWcKglwRs/fngmAhgvPM0drkh/DSqz
	 8PRo8lrZaV++pMpi7xFhd7xcVVymUjodUW5e+tXGJgtSe5Z2OzMzq6AZdBCh8qqgr6
	 uHUpg/xby3NKQ==
Date: Fri, 2 Aug 2024 15:01:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 04/12] net-shapers: implement NL set and delete
 operations
Message-ID: <20240802150119.512821d6@kernel.org>
In-Reply-To: <Zq0GJDGsfOt5MiAj@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
	<e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
	<20240801080012.3bf4a71c@kernel.org>
	<144865d1-d1ea-48b7-b4d6-18c4d30603a8@redhat.com>
	<20240801083924.708c00be@kernel.org>
	<Zq0GJDGsfOt5MiAj@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 18:15:32 +0200 Jiri Pirko wrote:
> Thu, Aug 01, 2024 at 05:39:24PM CEST, kuba@kernel.org wrote:
> >On Thu, 1 Aug 2024 17:25:50 +0200 Paolo Abeni wrote:  
> >> When deleting a queue-level shaper, the orchestrator is "returning" the 
> >> ownership of the queue from the container to the host. If the container   
> 
> What do you meam by "orchestrator" and "container" here? I'm missing
> these from the picture.

Container (as in docker) and orchestrator.

> >> wants to move the queue around e.g. from:
> >> 
> >> q1 ----- \
> >> q2 - \SP1/ RR1  
> 
> What "sp" and "rr" stand for. What are the "scopes" of these?

"scopes" I agree are confusing, but:

sp = strict priority
rr = round robin

> >> q3 - /        \
> >>      q4 - \ RR2 -> RR(root)
> >>      q5 - /    /
> >>      q6 - \ RR3
> >>      q7 - /
> >> 
> >> to:
> >> 
> >> q1 ----- \
> >> q2 ----- RR1
> >> q3 ---- /   \
> >>      q4 - \ RR2 -> RR(root)
> >>      q5 - /    /
> >>      q6 - \ RR3
> >>      q7 - /
> >> 
> >> It can do it with a group() operation:
> >> 
> >> group(inputs:[q2,q3],output:[RR1])  
> >
> >Isn't that a bit odd? The container was not supposed to know / care
> >about RR1's existence. We achieve this with group() by implicitly
> >inheriting the egress node if all grouped entities shared one.
> >
> >Delete IMO should act here like a "ungroup" operation, meaning that:
> > 1) we're deleting SP1, not q1, q2  
> 
> Does current code support removing SP1? I mean, if the scope is
> detached, I don't think so.

that's my reading too, fwiw

> > 2) inputs go "downstream" instead getting ejected into global level
> >
> >Also, in the first example from the cover letter we "set" a shaper on
> >the queue, it feels a little ambiguous whether "delete queue" is
> >purely clearing such per-queue shaping, or also has implications 
> >for the hierarchy.
> >
> >Coincidentally, others may disagree, but I'd point to tests in patch 
> >8 for examples of how the thing works, instead the cover letter samples.  
> 
> Examples in cover letter are generally beneficial. Don't remove them :)

They are beneficial, but if I was to order the following three forms of
documentation by priority:
 - ReST under Documentation/
 - clear selftests with comments
 - cover letter
I'm uncertain which will be first, but cover letter is definitely last
:(

With the examples in the cover letter its unclear what the expected
start and end state are. And where the values come from. I feel like
selftest would make it clearer.

But I don't feel strongly. Such newfangled ideas will take a while to
take root :)

