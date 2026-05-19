Return-Path: <netdev+bounces-289333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIzeBZskDGroXAUAu9opvQ
	(envelope-from <netdev+bounces-289333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:51:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7283F57A874
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32D7B3012C47
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0563E834A;
	Tue, 19 May 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYyNsvhC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D53590C3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180696; cv=none; b=CHdM02bm8AiDIAI4lPCFzTF4wamDtE+wIn3Qd1qbKiSklzRDVGiwY3a+4JsWqeMB9RncIkzlBb8wKTmK1Yz+wp3xIfWJjiQKDC8M9rNX78YiHOi0BB3hUahz9tdWOmY7e+Ss/WtAhikvzCvHYE0kJAtR0oWztLU1aLYP1FF7068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180696; c=relaxed/simple;
	bh=ShXYyTq6XRYDv0NW5GQ6tZPIHQT/abm6bnt8jn1jQvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgJB9FoLSzxxckEj7XCoE0IztbHwMambFOALYpcppPnO3h5slPCFS3TQbB3C96QPyB9WiakYFOVXRnF1ge+KcI794ZPGORPup6lQSiGzFNg+Qcn7dYEK6xkwtqau0cVMJrTqjljSYW8gfbnKCFTLArHBChyFqOU24jhaRv/7HmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYyNsvhC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bccb978bd9so25062875ad.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779180694; x=1779785494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SJtW4aJl8cf/mrCTLtiDDHrsvycOscx3Mi7viUyAdI=;
        b=dYyNsvhCNbOYVhl2dR2MflQVDumYBrfUC5SfN4+/vkauqphiL1urZmXLb4U8V1nGeL
         qSNpgUYRlqreO29CGXDXrMw7I52Qwc2G6gYuH6xutGrfqUSt8/tXHHnGfRUEyeBB/9M5
         2M7HTZLlfjbAAWzz6jbsuXVPjFIKhQ+1ETmidUKHJprpYkRjckqKlk/nd5LNw4ncIDAd
         h9QNnFp62wMgjzAJS2wgnp2Kb4HRl8ETGxZSRKe60qESCaShM0PYMmT0UdsjmTgT5frr
         cAUKr3YSH0oZX0j/NDrqcea2MkLcJRnKbhCt6ez0sQUp2IwE8zobsbkXfWCS7nBbcGXZ
         Sn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180694; x=1779785494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SJtW4aJl8cf/mrCTLtiDDHrsvycOscx3Mi7viUyAdI=;
        b=ZeW2UFJpvGjCZtT+Tx86EeCDaXEAiDDzyk2R+jp6b8QTaEi6U1izMlxy8OvcvSfJXi
         aj7DCSoTaAZJrMVj2IP53xhclhc6U+gBpzk3hnrC5gwxArzEAKQ8s+Wc87qg97wZAh7e
         fAT5JRPLU+AXkvt9D/DWdZro6t/BCjwnuS7h00lG47VpVknYb15dBqNgo6yGtf2EBE1R
         SmP3gGlL+x1ISFzdV6Fxsv5CU90bD1M3aTpKeus/gMzTopW/rhUGgnPaWgst2XI2qELV
         1cQEQz5Zi9pD1Uc6jpHDbcn1w2M4IgoXVZcMx8rZp91wy5evfClkxR868gLtrT9FBWlN
         AL+A==
X-Forwarded-Encrypted: i=1; AFNElJ9dx72+aZ+/E6GeLYxCMX3Hmnkbi02smUMg3gvqS6C3KTbzKMiYVnJKgEMs4LDw4KoLnF2BxTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHnJzqNF88xbD2XcmsAnK8OghN6t/rgvL5d4bKsD9k/qM4WndG
	dFhUh1cL8T1e9SqdtjvQgzJfCEbjoVEMIvGL/5FDEELMjFfgaxgg7K3l0eCPHyrY5Mk=
X-Gm-Gg: Acq92OEphcrz5URfOiVG750aQ39mKch/UMEakQPHe5g17QafLqQW9r8YgBpPgk/FoOf
	Ijg+1Numzvb0jFDV6HBxsc5LhHZ5NrNVeTqMgmeum3QzSTYYC6pThrHuXCb03DSBJTqcuywB8mV
	eqgWtC3rFnksfRvfzDtH/IDDIz3cVFF7q1ayXA8g5/4XkmqEFNTqh5u1cOSqeN2gyqhgfOJdhUP
	mcIYAQKZA3BkwOpKSfYRZz9VZFy4fRyN7q7NS4Hytza9Z5vBN4dCLHyLoKOucZ2iJZCJpihUBqR
	1pD4LTpNs59Ibi74lP4DU8DypQc5pLqDsnUoxn+ILdDkQvZ3Vvoel6zI0MRSMyf8SE8pNroLXE7
	9OCMbp6t0+T6a+d9uPaUNnXM2RMmENwn/OOhSWQzqYtMngC+DJoe+r1B+NuoXQor0mrmkRkyVJf
	i/0vxnhngPLD9yaM3OsOg7OFfSaI7exu6sNVqtYKQGyJ6YTUL/spg=
X-Received: by 2002:a17:902:f545:b0:2bd:4bc3:2995 with SMTP id d9443c01a7336-2bd5281ff47mr192532385ad.22.1779180694243;
        Tue, 19 May 2026 01:51:34 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c26355csm177354465ad.35.2026.05.19.01.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:51:33 -0700 (PDT)
Date: Tue, 19 May 2026 16:51:28 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <agwJNX-q0NmmrMpy@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
 <20260510082509.1530a1a3@kernel.org>
 <agCtGqWLK53TWCaS@Air.local>
 <20260510095937.598c27a6@kernel.org>
 <agrdjt6CjpJo3AYF@Air.local>
 <20260518142230.4403b3ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518142230.4403b3ce@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289333-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Air.local:mid]
X-Rspamd-Queue-Id: 7283F57A874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-05-18 14:22, Jakub Kicinski wrote:
> On Mon, 18 May 2026 17:51:54 +0800 Weiming Shi wrote:
> > On 26-05-10 09:59, Jakub Kicinski wrote:
> > > On Mon, 11 May 2026 00:06:50 +0800 Weiming Shi wrote:  
> > > > The handler function pointer against the mode_priv state it operates
> > > > on.  On setup, init() writes mode_priv, then smp_store_release()
> > > > publishes the real handler - the paired smp_load_acquire() in the
> > > > reader ensures the handler sees that state.  On teardown,
> > > > smp_store_release() publishes the dummy before synchronize_net()
> > > > drains readers, so exit_op() won't tear down state under an
> > > > in-flight reader.  
> > > 
> > > Still does not make sense to me. You already add sync_net().
> > > And if it's possible to switch from dummy to non-dummy mode
> > > the ordering is inverted.
> > >   
> > > > Not specific to the bug, just a reproducer detail.  Dropped.
> > > > 
> > > > Sending v3 with the updated changelog shortly.  
> > > 
> > > Please don't rush new versions out.  
> > 
> > Hi Jakub,
> > 
> > Apologies for the late reply and for rushing v3.
> > 
> > I was muddling two things. On teardown synchronize_net() is the protection,
> > the release/acquire is for the setup path where init() writes
> > mode_priv before team_adjust_ops() publishes the handler.
> > 
> > If that makes sense I'll send v4 with the corrected commit message.
> 
> Can you provide more details for the init() path race?
> What's the sequence of events?

With loadbalance mode:
 
  lb_init() stores select_tx_port_func (team_mode_loadbalance.c:595).
  When a port is later enabled, team_adjust_ops() publishes
  lb_transmit with a plain store (team_core.c:539).

Without the release/acquire, a concurrent team_xmit() on a weakly-ordered 
arch can see lb_transmit but not the select_tx_port_func store, and lb_transmit 
dereferences it at line 227.

I'll send a PoC in the next mail so you can reproduce it.

 

