Return-Path: <netdev+bounces-290993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKv/C/H6EGrHgAYAu9opvQ
	(envelope-from <netdev+bounces-290993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:55:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E155BC391
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8984F3008095
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DA1214813;
	Sat, 23 May 2026 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlC0jsd/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E962F851
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779497710; cv=none; b=diFgLYDALkOyeHee20NMyKcA89jv/Mo2awAIvZrWeX1CYdAVA8RgQ60qcY2JcUwPulJafZl3Zv3HEg00gBtsxd+jmjaHKO2xdPqbQKt6QS+MmMTwyu2v/0a8FSD+YmmXvqSVXuFkXj1rRcPTeQzTSormyrVon4Qi7n6WqafH/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779497710; c=relaxed/simple;
	bh=LotI6VUGcOmu6tofMf+PH7eXPCpn/ujXO2Ax6sKLlTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJKU3AepbQAoVpDjLm0JTcIiEgVUzg9/HGcTcSYuzugeBPmPq+U8syrEJ4qC9u0G45x/XzZDvMGk14OUeBWvZO8aXSN8uHbnIOJZSLCNA/uD8iKE/VdDTdU+cBg4SAFyLFpr5tSYsH2ygpf+hQDSYVEKTiYiWJ6SVZYEh9fVuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlC0jsd/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A71F000E9;
	Sat, 23 May 2026 00:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779497709;
	bh=ZfG8u3L5rRrwqByXFr3fJzGxx+EK5ubjIrDVTRKy46Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mlC0jsd/vVlPmUQndeRRebPlNvC75e3M3/xgejf4omk+thW2L3M7xNhgDqPCXOqIE
	 8+OHZACI4feFchYv1vz3JHU6mcowbXIiNJwoPREreQqbkBWeLUWhtWzowlw8GnRjg8
	 nXXLFnb8hKn6KfSzWNXwo2b8ZGqXnQxwDO6IClds0Twv9NFys7Mt1QfZJN1IyOPxCG
	 AfTMYVmjYV/BxoLDSYGBdVEGFEcX6MFWovV476kPBwVkVIqkLLG5OZ8zd8Yp3kFg4J
	 LDj+YM0vqvVtbA69w9g64ggFxR39SyITUXuOJAcubCwAC1fhTZc92c3k7+jrfHSCJY
	 azWxPC1FthURg==
Date: Fri, 22 May 2026 17:55:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260522175507.02b4fe83@kernel.org>
In-Reply-To: <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
	<20260521084640.683c1ee6@kernel.org>
	<CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
	<20260522084611.390fd0a6@kernel.org>
	<CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
	<CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-290993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6E155BC391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 13:01:49 -0400 Jamal Hadi Salim wrote:
> > > I must be missing something. What's the problem with changing the patch
> > > to pull headers instead? I mean - if we agree that this is where we'll
> > > end up - we should just do it now. It's the long standing kernel policy
> > > to "fix things right" instead of creating temporary fixes which then
> > > have to be reworked in -next  
> >
> > I may be the one missing things. You main concern is with this:
> > +       /*
> > +        * If the skb has shared frags the user is likely using zero-copy
> > +        * (e.g. sendfile).  Those page frags may point to page-cache pages;
> > +        * writing into them would silently corrupt the page cache.
> > +        * Linearize so pedit operates on a private copy.
> > +        * TL;DR: if you want zero-copy, don't use pedit.
> > +        */
> > +       if (skb_has_shared_frag(skb)) {
> > +               if (__skb_linearize(skb))
> > +                       goto bad;
> > +       }
> > +
> >
> > i.e you want that gone, correct?
> > And my concern was whether removing this still exposes things to
> > exploit even if temporarily.
> > Likely it wont. I have time, let me test the exploit with that code
> > ifdef'ed out.  
> 
> Ok, it fixes the issue even i ifdef that out.
> We still need the little patchlet i sent ...

More and more I feel like I'm completely missing the plot but 
for the portion of the problem that's "we are writing to frags"
the fix I was trying to describe is:

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..3a74cef58e17 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -414,7 +414,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
+		u32 *ptr;
 		u32 val;
 		int rc;
 
@@ -456,10 +456,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
-					 sizeof(hdata), &hdata);
-		if (!ptr)
+		if (!pskb_may_pull(skb, hoffset + offset + sizeof(*ptr)))
 			goto bad;
+		ptr = (u32 *)(skb->data + hoffset + offset);
 		/* just do it, baby */
 		switch (cmd) {
 		case TCA_PEDIT_KEY_EX_CMD_SET:
@@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 		}
 
 		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
 	}
 
 	goto done;

