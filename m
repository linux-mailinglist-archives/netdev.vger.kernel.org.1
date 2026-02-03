Return-Path: <netdev+bounces-256213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJLFAFu9gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:18:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56226D6B3E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C423010DB5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD0392C3C;
	Tue,  3 Feb 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXpO7yXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291762C08D1
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110295; cv=none; b=cf58pw/de/JBuwAX8FOncBuYob+84+z2fsUNAnj41h0wEqAYEqtZ33QDnRdE/avZr3LvU6ejLkauFxQT7wxY0/qRvoYaxUNWoR/V4X2xqvMOPCYxefi1qbEtX37EFQyhWs6z2JD7gCLwHzNKzmJMcN10ELc88LgiT7MJe63x+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110295; c=relaxed/simple;
	bh=ZzIjBnf+ti8VPOFeSeWlDuWYqWNkAmOz0xMBA/LoqKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvdWGQt2Cf4N04+pVjmI2IsjkASNXWnfOyAWz4Xh1kXFOVOQj3ozoWDmjCveTNK1FFCzCX9DJP6Edqb2N8u8n/1hMg3aow4nP5RRuu4INegJCRKoYUmJ7P/vygao3gmkxLv3dE5u90nXqL+0OtRgzDPUPy2vzP2PRZdT5UBXw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXpO7yXp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso4903515e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 01:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770110292; x=1770715092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2K0n61IVxE799olq2osB5P7SgqUu0HpI0Bg4ulH97g=;
        b=AXpO7yXpRBV3xzBOEYgqnQCjXLeuYcXOum5BrgaEi1kq8KUZ98bXk70+HcD+EBVUQl
         zsGDRjGR+yzAAv+5Kcg+bR1g2NBxWSEXJiUDMNoVdQiyAC9ZaTA/5KHV0jIdH8E+lZc4
         J/2T/sU6HdomltLd3nTwsdXuDeaGaGWLroJh7hCb45qgTNbox7PBXkKAA+ngLrlPHbZ7
         LZ40gN1+dzpvbsU0j/AL6N4lZfxJtOKqxj5KaK6eGpnQgkUjYSWBcz1bv8FZ4kbBkP8U
         mmtLchuaYua7gz1sDwNN6HgZq8kVZATdEBjuhYhS+jrKcxgHzoD4wB5fGGC2tiHP18LK
         p6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110292; x=1770715092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2K0n61IVxE799olq2osB5P7SgqUu0HpI0Bg4ulH97g=;
        b=BOAg7HPxejXEpll9segvz3LcDuwmRPzvAdD6tKxBY6h97sxyouqgr0Rxw/r2ls3eK5
         ilTu9Ic5eT3qpZLzjutyJZROTWM3YVqbJFRjwz5ukg8d7X2xeFh+E9Eckyh6ObyClLmY
         /+TUrV+i0laEpyxuHhmcLO920J6dq9TGdl5wUbYcMG8w1g4syvOLx5t/zHvKUVaayrxs
         16YdjfYuRz0pIsE8oJqQGg3GAGQ/Mc6FCiZvLfX18aW4YII83fClwre8l3C8zJV3qT6Q
         O7LlvZ4Fat6gtL6lYjgOPuqiWrAG4NL44M8mLlRQ42UQxHFfLb34EVIB8IXH5Qg9CkXt
         Cnxg==
X-Gm-Message-State: AOJu0Yx6ouhS+mRbhRDRDPEDGGAXjFMWCxIAzJxFCf0sIffSM2rmxgz3
	UMjwgoRUY/CpTSrxm0EAH8Kb+SS5E9FkAoeaFJSpVxwviqPR0ANEPnlth/Pz2g==
X-Gm-Gg: AZuq6aJ0BZZdjV8+bTRHZ0iTwzTpZw7vGCAN7joLJr4QgOYQ0fbYGT+dlE8z5t1Gfn7
	7wihGH356usQKEL9foiwrc4qsVSESMRS47HFci1x4v7uZ+NS50CCFs/Ow74LATkSjbq1f5fqUY4
	yx9sjUddSKXSpn5izkdh/NJ5NWVl7ySCZCahcxGfNTx1ymOw+R1beQ70YH0MQnUkhT86p+wXX1N
	8tSxkFB5BZQ1+It2zusAVaOgPDfUtSe9zhv7zb/cRw00zjfpeZdlZY68pKzbDRskXVbGtLPTSBW
	cg+d/05NYme/yOZ09gH80HRg/jmV2oip/AelySET7Ji4IK/aPoJgGWwlqM86ZX+I1oUDANrarVj
	lYIl1dhT6kV/osi6/ySf0cVOW9/PnzUMfT25wq0uBj1itBYDmSPiyqZREvbRP9SyZl1J7swt4rY
	IlVw==
X-Received: by 2002:a05:600c:a00a:b0:477:9fa8:bc99 with SMTP id 5b1f17b1804b1-482db492192mr115238265e9.4.1770110292363;
        Tue, 03 Feb 2026 01:18:12 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:618:ce2e:8316:5a68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbcf9c3fsm134465165e9.4.2026.02.03.01.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:18:11 -0800 (PST)
Date: Tue, 3 Feb 2026 11:18:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: sync dsa_mall_policer_tc_entry
 with FLOW_ACTION_POLICE
Message-ID: <20260203091809.jpkgpagtodu63eqp@skbuf>
References: <20260131045821.3451873-1-mmyangfl@gmail.com>
 <20260202105218.sx5k6ksy5ycpfyxf@skbuf>
 <CAAXyoMOiLBcS3E8kRFGpxPzhXEtq+BhZRkQNbvcNiG96+LRQqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMOiLBcS3E8kRFGpxPzhXEtq+BhZRkQNbvcNiG96+LRQqw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 56226D6B3E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:40:02AM +0800, David Yang wrote:
> On Mon, Feb 2, 2026 at 6:52 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > On Sat, Jan 31, 2026 at 12:58:16PM +0800, David Yang wrote:
> > > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > > index f59d66f0975d..2a209b83c701 100644
> > > --- a/net/dsa/user.c
> > > +++ b/net/dsa/user.c
> > > @@ -1497,8 +1497,19 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
> > >       mall_tc_entry->cookie = cls->cookie;
> > >       mall_tc_entry->type = DSA_PORT_MALL_POLICER;
> > >       policer = &mall_tc_entry->policer;
> > > +     /* until they export the type of act->police in flow_offload.h ... */
> >
> > There is no "us" and "them", it's a single git tree. Just submit a patch
> > to whomever ./scripts/get_maintainer.pl says to.
> >
> > Have you tried something like the patch attached (just compile-tested)?
> 
> Yes, but I was afraid it would be kind of inconsistent not exposing
> other struct flow_action_*. Nicer and better approach, though.

Since it doesn't affect existing users of struct flow_action_entry,
I don't think it's that big a deal. You can take this patch and submit a
v3 with it if it helps.

