Return-Path: <netdev+bounces-262986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMX4KFc+pmkZNAAAu9opvQ
	(envelope-from <netdev+bounces-262986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA091E7D3A
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F8273018683
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF7367F3E;
	Tue,  3 Mar 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwCrvh8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07D364EA5
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502611; cv=none; b=YLxD3TJJ6wKQRulNWsCu2Ecj5bx5lmcIRqwMBuYBIVD+EZZDoKIlPd+4fseByDHwu0w/I/eg+X6HM77Hw6Nh5NJ20VaxE/+fB+/7onim2RNl6xKuC+mo2ExGIkLTSrA7nVrF6VHMHZFYlNGrtZ2btcxCPZqAFq6RzPKK1wHrps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502611; c=relaxed/simple;
	bh=GOgVdgaugaSYTdKQkTePw7dBPKfs8RzPY6Q+kk3T9XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIiiFBqKKXtpx5KTAUdmRf3+7fl6z5U2Sbf2Ysq3JljlWgZw4CffriA+tPJ5359OLPY1CWEKiPJiIuPYeCy+yWKvF+DF35lBlfuzLMaLTNrNfPObiTAZSEOd12/yDv3r5rX7/9gYHdzlAjkWfEs6crcWU2lIBf3S8D6V+JuI+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwCrvh8s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso7581155ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 17:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772502610; x=1773107410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXh/kyemn7MPM4Z4xwUgwqFgvyljW0z+X/Y2/IQ0g2k=;
        b=NwCrvh8s3xJiFWmBrCwZk5tqxGGEDfyYyqQ+GA/rSQCuuCwwtfYV41Ka0Iki8vMqQB
         FxQelVUd6WhtLsxqVB5MeqtStEFkx13Gr9/omUu/VNDZ2FQK0yoPmLbMWeu3Oky/IE7s
         7vkPdy+aiTGqK/Tby7TrLxHOdZDT0S3Us86TI2mx4sgAQdxLaxGG/zSmU0e7UhbqyqdX
         ep/OGpZnjl1mwh+ou5wV4Zd4wEprdpjIBH8dGn6NXDAjB+AV5Pvqizd+G9nAUv3F/XsL
         H81wMhX979op0pZuT+O7kn3IOAS5tqaQuh3lLFPAqmf/7xaWscgBjs+7vGFxZ6xXKyao
         CLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502610; x=1773107410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXh/kyemn7MPM4Z4xwUgwqFgvyljW0z+X/Y2/IQ0g2k=;
        b=j8sgbOzLV7ih/KSQ21l/7ohpddCZ/QARoGc+En78rcIAnjunto6IVYaJ+HsbBuPnz+
         671z0+ZPyoNEauAvyCPvKfNEAbZLfFe7w+iqUkuEFp4ZT3vZz8q/hoA3s38+A4SU7VlN
         tIQoqi7BVW8AoVBJ16uGo3ZqzDX7IsPCLFrIym9/8rO2+xRl+V02l2HBvpPnoYpiVYyl
         DpNjOUG85Nz8iCF+ls6tbnwzte3QelU3IOiBnoYo3mIN1VeRIiUbisroNs0okd1MVS2t
         7wR80iO+H3Ezvz58XObcAca6GjoIGyvTVPLkwhnwEvJZxVJUinAYyYYvSOZ9/FzKoAOQ
         Hnjg==
X-Forwarded-Encrypted: i=1; AJvYcCW05kM6L/H/mfNIVZYeYDgNH+RYDqpDdumuYq4ajq864fdauK/faJaBter47ImEwMrr15BOCRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWzNIm0CyY2GtyHylXLHfTD4k0jhl8udsRMnKNXxuwNh7vo5D
	y5ZGuQ2EG5Vn8mzz3m2VGDJbQNpIV7j+GNXasH+GCkFdR5DDhDJeth7o
X-Gm-Gg: ATEYQzzIWy7WYnQDM41l8XG6unCbr+NGCPztRlVwSeWk23U628wmqX2kcqmknZZXPID
	Fq+xvpQyAAWQPU15LNEfsZ+FlrsNYSzqrm/1y/HRUo4ltgy+0n9rydfatcbdFpFo0GQ/qBoW5RO
	U6Dn8eHF9+P9HJtusEPRrTRGkWCLGgIPj4VlS2X5yEx8qDDxz0B+XtYEYtBEO/19mxmXzTLOnox
	ScIMe+w0L4AiB/faPpnq3RaJJNYkeZzd/O2pfWsoOLvYuZ5ltlDz+VYKxapTGAe/D59x+YLSlT3
	3OkJpRaVPP2CMbBlsf1Tf+YbfLVMamyAOUvvA3RaBO74VER1gTaWhAOr8MrJSX3vGzFyU9VshtY
	9/8dnrzjUg2nffCTjvlbwR0xsomB3/PgdaXHq5sjxIc1EkmIBE9+yHU4vNK30ISjmx68Go3oShL
	iUwzw1BsH+8S1PsAgZdiOw3jnSSTHCdcjWbPIOqBrx2Q==
X-Received: by 2002:a17:903:2ac6:b0:2ae:5435:1941 with SMTP id d9443c01a7336-2ae54352283mr42915795ad.51.1772502609778;
        Mon, 02 Mar 2026 17:50:09 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f3436sm220982125ad.88.2026.03.02.17.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:50:09 -0800 (PST)
Date: Tue, 3 Mar 2026 10:50:05 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaY-TbPsNxo6toSr@v4bel>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaYY6UiXSppOig9Q@krikkit>
X-Rspamd-Queue-Id: 4CA091E7D3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262986-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,inria.fr,treblig.org,garmin.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > This issue was discovered during a code audit.
> > > > 
> > > > When strp_stop() and strp_done() are called without holding lock_sock(), 
> > > > they can race with worker-scheduling paths such as the Delayed ACK handler 
> > > > and ksoftirqd.
> > > > Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
> > > > invoked from strp_done(), the workers may still be scheduled.
> > > > As a result, the workers may dereference freed objects.
> > > > 
> > > > The following is a simple race scenario:
> > > > 
> > > >           cpu0                      cpu1
> > > > 
> > > > espintcp_close()
> > > >                            espintcp_data_ready()
> > > >                              strp_data_ready()
> > > >                                if (unlikely(strp->stopped)) return;
> > > >   strp_stop()
> > > >     strp->stopped = 1;
> > > >   strp_done()
> > > >     cancel_delayed_work_sync(&strp->msg_timer_work);
> > > >                                strp_read_sock()
> > > >                                  tcp_read_sock()
> > > >                                    __tcp_read_sock()
> > > >                                      strp_recv()
> > > >                                        __strp_recv()
> > > >                                          strp_start_timer()
> > > >                                            mod_delayed_work(&strp->msg_timer_work);
> > > > 
> > > > To prevent these races, the cancellation APIs are replaced with 
> > > > worker-disabling APIs.
> > > 
> > > I'm still not totally convinced by this patch. The comment for
> > > strp_done says the function expects to be called at a time when
> > > strp_recv cannot happen in parallel:
> > > 
> > >     strp must already be stopped so that strp_recv will no longer be called
> > 
> > OK, I understand.
> > More specifically, it seems that an issue could occur if strp->skb_head is 
> > accessed under the following scenario.
> 
> Yes.
> 
> > ```
> >                  cpu0                                cpu1
> > 
> > espintcp_close()
> >                                          espintcp_data_ready()
> >                                            strp_data_ready()
> >                                              if (unlikely(strp->stopped)) return;
> >   strp_stop()
> >     strp->stopped = 1;
> >   strp_done()
> >     disable_delayed_work_sync(&strp->msg_timer_work);
> >     kfree_skb(strp->skb_head);
> >                                              strp_read_sock()
> >                                                tcp_read_sock()
> >                                                  __tcp_read_sock()
> >                                                    strp_recv()
> >                                                      __strp_recv()
> >                                                        head = strp->skb_head;
> >                                                        ...
> > ```
> > 
> > > 
> > > "strp stopped" is not really enough, I think we'd also need to reset
> > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > ->sk_data_ready has completed. This is what kcm does, at least.
> > 
> > It seems that this is not something that should be handled inside strp itself, 
> > but rather something that each caller of strp_stop() is expected to take care 
> > of individually. Would that be the right direction?
> 
> Agree.
> 
> > It also appears that ovpn and kcm handle this by implementing their own callback 
> > restoration logic.
> 
> Right. I tried to look at skmsg/psock (the other user of strp), but
> didn't get far enough to verify if it's handling this correctly.
> 
> > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > 
> > From the espintcp perspective, how about applying a patch along the following lines?
> 
> This is what I was thinking about, yes.

In my opinion, it might be cleaner to split the espintcp callback restoration work into 
a separate patch, rather than merging it into the strparser v3 patch. What do you think?

It seems that the two changes address slightly different kinds of issues.

If you agree, I can prepare and submit the espintcp callback restoration patch 
separately shortly.


Best regards,
Hyunwoo Kim

