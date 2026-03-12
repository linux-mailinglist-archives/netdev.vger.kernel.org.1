Return-Path: <netdev+bounces-266815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fMK8A2gOsmkNIQAAu9opvQ
	(envelope-from <netdev+bounces-266815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:52:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479626BC31
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71CD3059F26
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848C32E757;
	Thu, 12 Mar 2026 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFnRTeTZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6393290C4;
	Thu, 12 Mar 2026 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276772; cv=none; b=ENNmiG3oD5ho8jZIsxcEbtvDgWvtj1+cxyIzhUmDqlGePx8wi6XF9eihJ8NOw8aPOjmRlrt3ZELKJTDcEU3pM8tC2GDCnc4CNkV1EXKdUmS/UTMH17rLykqBEOlGca4+VyHQEYd1ffBNS7BMNF2RZe1NM4bnFV7tD3ZiPsvDUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276772; c=relaxed/simple;
	bh=bqYhXUVKtMnpwSfb5VjFCKpDiEO+SZibSajQCbZjd80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/qSuSETn1cgNJQ9+7ZWkmVypYHdR8sH54MtpzAXctKIeRehJkbRmfkIgNN4IsnDv9fg4ADbpLzvAVAXgNE0v0kdbQJjuSH2j4r1skZXb7v75jLy5uYzDG0mHip7hmuAaI7HD5wafAHfo+Jr9JkJvTUjIyHyMeQ65KmxsSmi0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFnRTeTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5BAC19421;
	Thu, 12 Mar 2026 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773276772;
	bh=bqYhXUVKtMnpwSfb5VjFCKpDiEO+SZibSajQCbZjd80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CFnRTeTZpIby2YIOzDhK8yDtPk2bCI51J/w2wCRpKYXguZfLICyqfyK/dec6X1Eay
	 5QHVPNl76H+XG8Q14uAEKCha+d/3zbbIxPtlQPWyIsHgSJst75mLHnUFYPLQLuIZRx
	 Lvdu87uS6REVQNA5DJuW7XUcK71EWxigCSTa7TKPJEjIY/MlJ5NcLd2Dh23oBXItcz
	 x2fL8xTI0QLUA9i+570Fnl5ehXDGXmEn7hwLR425lmJHomkOsboKQGPVnTMJvkk3Hl
	 5CfSoqT59zH6iJ7nuk9fEvGPFJq+eew2oHTYOdIL2N48GntgBZLYj/Cizw75zvQXiF
	 Rn4Hlnabyvz+A==
Date: Wed, 11 Mar 2026 17:52:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk,
 vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com,
 cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com,
 km.kim1503@gmail.com, security@kernel.org, Victor Nogueira
 <victor@mojatatu.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot
 delete
Message-ID: <20260311175249.54abe1b6@kernel.org>
In-Reply-To: <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
References: <20260307212058.169511-1-jhs@mojatatu.com>
	<20260310184713.7e810431@kernel.org>
	<CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5479626BC31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 12:22:41 -0400 Jamal Hadi Salim wrote:
> > On Sat,  7 Mar 2026 16:20:58 -0500 Jamal Hadi Salim wrote:  
> > > Note: We tried a couple of different approaches that had smaller code
> > > footprint but were a bit fugly. The first approach was to use recursion
> > > on the qdisc hash table to iterate the descendants of the qdisc; however,
> > > the challenge here is if the graph depth is "high" - we may overflow the
> > > stack. The second approach was to use a breadth first search to achieve
> > > the same goal; the challenge here was it was a quadratic algorithm.  
> >
> > Lots of complexity when realistically only ingress/clsact support
> > the unlocked operations. Can we not just take rtnl before the
> > references and not bother all the real qdiscs with this @#%$ ?
> > (diff just to illustrate the point not even compiled)
> 
> Two of the several (I think 4!) patches we had took a similar path. I
> am trying to remember at least one variant was bad for performance and
> the other was unstable. Let's see if we can revive it and take a
> closer look. BTW - none were pretty, it was maybe half the lines of
> code but touched many things.

FWIW / of course, we have to apply similar change to all(?) callers of
__tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty long.
And it's not going to help the already spaghetti-looking locking. But
even if it's more LoC I quite like the idea of containing the poopy
code to where problems originate which is the lockless filter handling.
Fingers crossed..

