Return-Path: <netdev+bounces-290182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKnsBexZDmo4+AUAu9opvQ
	(envelope-from <netdev+bounces-290182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3859D7D9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FC5301A91A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E942BDC28;
	Thu, 21 May 2026 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcep2LPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58C299927
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325254; cv=none; b=J6RT8xUmr3ltAvcWMajIdfHrJ2Ey7UV8I+0a2o5iJKUll8whh+L83I88L0Fj6bBZ7a9tbLweZSUH9whkXorIKewMYcH0M5m6c2kBiRfy/ZYxwz4psuWlalgS+UVjIiHbjgTWaY0Ih2kbawuwL9VtA/Ofj3vHh4Fz6ktb9uNDQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325254; c=relaxed/simple;
	bh=gYz3O1vuHNoTH6x1iJHYpHRFsKDz5PHtFSYQNp0gJVI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H89cgFdZD1t3Klz0C6+x631XBTjn2MOxTJBIiJTprWsR09rcNnMo9mtTungkRElPs3sdnhTVBcBUIbsAof/cbqeIlHlPZ/fe1bMMo2hRsNIgGOBS6ojYuPh5duZEOmHO5NR8SJx7COB2iG1ye8ATolU68wb388VA6Wq5cGdyrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcep2LPt; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65db820588aso4683162d50.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325252; x=1779930052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12Ue1CIvIzK5F/0hQpm+nil1dsKwec2E+34lJdJRYok=;
        b=pcep2LPtlyDvlyCzJPL+DQYBYzhY4SHPLH9OOQ+nn3u+W3WVSwGLWay+mS4BAfYsXn
         R0Evecth5fGa0pNirfYF1Vr6KaQ1BhMY4CQ9kDr51aS+KA1W33mDEyNj14XRa2Un4+k+
         bSY9+Iy+0QJE+dWwj95esB3KgWVFZxFOBEgrnz9eGFJFDlM2gY9cV2ksQWFyMnP/+9y6
         huoujp52RVQMQEFslRfh90Kkrv/l8ay7qAN+PsE01N9mNGIYjURVkZiEdAfVl3aOE1oz
         WKeDCI7r41+kQRrem4MvwGHx/plzrbti7Qmw5Ips4OZCAVI+20o7tehOxYtUbAOCcVMn
         4Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325252; x=1779930052;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12Ue1CIvIzK5F/0hQpm+nil1dsKwec2E+34lJdJRYok=;
        b=OMrCsZpK7NUbPoaavLen7kC8XXJEoh8QVazJCx/tmHbbHbVxJUcXj54qU1XxH938Ou
         /E/srM7JE/0IXYw/zijvt5yyMh1AFnfnXM5OAj4UK64SVsRFgRkdCYutAgdTS+RKoxpT
         LP4/sfChAU7e5/XTvBIpoVATJY+RTYQvleNBBy2SWV1JZMtwkyJt33szCcATT2KGeKe+
         Opj/3Wa9nYtPPQEN0o0fYFXegosJWmVeH+mxVyVq4SJnAmwCqJ1wlTwD/80KbKOZqJoU
         6aQUBM5msgYiPFSJ93w8Ca6tJq7raXUdHqeCEwmqA0ekwNA34eGRKGKAzzRMHNRdGbwP
         6jLg==
X-Forwarded-Encrypted: i=1; AFNElJ9digxFi/Zqg80LABz/0NHApvQRIkFZ01PVnmVD2noCmEJ4yvuhRB01F3xEcidoisItGGZsrG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEEqLc7Pr3oU9+KUrbbQdyiCx1Dm9azkN4BD34OInUalBq3HP
	13GM2EiN1jsGJMKHQEZ+i385L3GLcMH3eJjWwlbugGGnum9E5IU7VjJd
X-Gm-Gg: Acq92OFER2tcJenPycNFEvGIz4iECof2ZHCFkd3rQd5hXWSYZYHFJIzoKaq1hCxpQnc
	2bgUt4njjoYs2TJCJzK3hpY2gHBIcucjFAO4+f9CYH1pnx/onHLd8qG+kLZHDXWiVSZPhDaB/an
	NNiwDVlYS6Xh2uuxnyHdOP+8FifaEfoesD5RxV+OYE/53c6x64AYAky+k6Ys6M5f1iO4dcttqU5
	rmyLeeC7SyjeYgnSspcX7LFOpn/3p9evrTHi9n8lSnEyVbp/dWGuNvgG4PZQkgF+BFsS/X8m8Gm
	ocSFa4n6DkBtUc0T/Fag58juQef+771o/u4dBauDJ1cU22yhhw9KuZfVRX7b2Q2QVSGJdfDaNjL
	otUVIoViDxzTmnduBpmjg6TVWuGFSxl+cc1fTHFAozTesRftw5cR0KGQICC3aaPJCZR8l4BR5X9
	6r0H+tCg3MdLatZy5jzJ+tdgXL/cg+/unhpEwpubsrCGxGYe1CV+3phvTwUy0Idt1Dyu+W4htIU
	n/a0No63VCn/Rw=
X-Received: by 2002:a05:690e:4191:b0:65e:43a2:82ad with SMTP id 956f58d0204a3-65eae3151bdmr469149d50.48.1779325251681;
        Wed, 20 May 2026 18:00:51 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b124sm10021529d50.6.2026.05.20.18.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:00:51 -0700 (PDT)
Date: Wed, 20 May 2026 21:00:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, 
 Huzaifa Sidhpurwala <huzaifas@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <willemdebruijn.kernel.2c61f390b462@gmail.com>
In-Reply-To: <willemdebruijn.kernel.8bb6e9bd9a42@gmail.com>
References: <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
 <willemdebruijn.kernel.8bb6e9bd9a42@gmail.com>
Subject: Re: [PATCH net v3] net: gro: don't merge zcopy skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290182-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,queasysnail.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Queue-Id: 91F3859D7D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Sabrina Dubroca wrote:
> > skb_gro_receive() can currently copy frags between the source and GRO
> > skb, without checking the zerocopy status, and in particular the
> > SKBFL_MANAGED_FRAG_REFS flag.
> > 
> > When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> > on the pages in shinfo->frags. Appending those frags to another skb's
> > frags without fixing up the page refcount can lead to UAF.
> > 
> > When either the last skb in the GRO chain (the one we would append
> > frags to) or the source skb is zerocopy, don't merge the skbs.
> > 
> > Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> > Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
> > Assisted-by: Claude:claude-mythos-preview
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> >  net/core/gro.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > Huzaifa has found this to be exploitable to overwrite the page cache
> > 
> > v3: maybe no stupid mistake this time. sorry again.
> > v2: as Eric suggested, don't merge those skbs
> >     https://lore.kernel.org/netdev/9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net/
> > v1: https://lore.kernel.org/netdev/4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net/
> > 
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 31d21de5b15a..bae89062a053 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
> >  	if (p->pp_recycle != skb->pp_recycle)
> >  		return -ETOOMANYREFS;
> >  
> > +	if (skb_zcopy(p) || skb_zcopy(skb))
> > +		return -ETOOMANYREFS;
> > +
> 
> As Pavel pointed out in a previous version, MSG_ZEROCOPY skbs are not
> looped onto the receive path. From that PoV it's fine to add this
> check as it will not match them.
> 
> What is the path that leads to managed frag skbs in the receive path?
> I can believe that it exists, e.g., a page pool. But since Pavel also
> brought up this question and knows the managed frag use much better
> than I do.

The key is in skb_gro_receive. That can get called earlier in the rx
path than the skb_orphan_frags_rx check in __netif_receive_skb_core.

Not coalescing them LGTM. Thanks.

Reviewed-by: Willem de Bruijn <willemb@google.com>

