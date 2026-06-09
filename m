Return-Path: <netdev+bounces-297149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OAW2L5g9KGprAwMAu9opvQ
	(envelope-from <netdev+bounces-297149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:21:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D46624E4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:21:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hLALQtbr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297149-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297149-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C567A3054C30
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9254949FF;
	Tue,  9 Jun 2026 15:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A348C8B9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:49:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020180; cv=none; b=c+JOT8KVhIgyy1LFHnb5ZfOQ5ePx0wGwaW4kepXwiO2tscaH0G2ETwfXTEMIhr7hl0pBXFrdGtvTSQIWj8ebguznU2IXK02WFWqnFoc1IAR7z7J4JUNJnzJap8c6BGy0ZueRyJbjkzYta8MHhDgym1ZgzCjGHdmk3ENgp/ktdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020180; c=relaxed/simple;
	bh=Qwr/hZqRzkH9ex60NmaJsc8uWz0tZ5CnDSIKQlRcmTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izUPl1mXQpwpLcyYZ382qh3sRMlMsydKgcvJcc9vWM4wx2fDoXN+u1DwzT61ekwLRcllQpu9SqmHYJA92FDCi1pFgazWm5xYvGGXf1TijE/uxyvamEFobU5FwkYyLKfOnaOpl5Evj8RxiYthw24vwHXLA3kH15a0ec3wvyvxwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLALQtbr; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso41019435ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020178; x=1781624978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4HBzS3VR7L/xCwloqp54fznT7ikswGBTr+YHTCIylU=;
        b=hLALQtbrHrqwMRCXh6lLkNzAnIivRek3TF2nK+cp1ZwWd9WCcpMi+a8V90Ns15ihKh
         9EDOXDQbcqvEM7wkEZydVM2tV7XsKYuShqxqzBa4wYH0V7uwr2Q6NPQsgY/LyX445Om6
         suR7RscDb3WQlPkkPU4yhXkTHVr5sFIctlzIlQlO1rRBHZ61Ssnhj5f8+tGpH3Y9NwsF
         AB3YwcPgbAyJSO07JfjJPdHv/62H9Mmo4U37Ja949ptv604tMBYvT93b6zuEnVwGvVwc
         aHDVG8iriPR4wY7BI/YybDj1tqrqpj08HCGovLpSIeiI2v+XbMDRgChSIeLFNF6bq4cn
         aGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020178; x=1781624978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4HBzS3VR7L/xCwloqp54fznT7ikswGBTr+YHTCIylU=;
        b=lEICIOUYRVRi0jahvox9Ql86vHBYbhjFKN5UvaP4YMO9W2jCPfC6xkNVfYDHaXg/Dj
         VZAJyxuY0eGb5JAH3ODuHlNAQhLAMUN/TwpW+AzMwcsEMfIyBh5kCknxEKV3YShl0KKz
         KqkAj8wMHzB8rSfFQTSCtPntvyGGFg2wDS/ALRkj3t+r+mT/gEpPMgkWp7+JoX5aKJUe
         swQbZi0/Hbx36ZsxkBbTvT4MY18uouPiT11Ih3m/VGiEklSxkjOWk2tM8fjAWS26VChp
         83urDH6+N0dAkamqGqY0AtFhkvEBwr2zrg3uLZR6tsaloru0oPdOH0iRVp9C38XhOZqa
         0ckw==
X-Forwarded-Encrypted: i=1; AFNElJ9LPhgfOpgD99bcccSO9hg6shzjAM9LQRK/WNtYWhUVZwUo55snRbH3AyL4EdY2joWm9XTZLNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRD+B30UY+sVo55NvGMA7HMBSC+O1Ymb5W05RS9MIbqLAQy/9J
	b7+eBpDf1tIz0M5f8DNOxLNrHLjgZpnvOzN+pcSz3BZ29PKsQDV/nF+x
X-Gm-Gg: Acq92OH4jHJcMvZC01VVwQFbh+e1e8BkLTtAyeCWd/+h3JxB+5/QpsQYra0gAgTYhDb
	bzcZJa069jHbp1RCgJNGBqtulXneukb+TtcFxmW9KMThDteZ73XdhljaAohCcE7aFjYTRU1evRE
	kNLMHUXofq9qIQAm5grSb0pokDOqVUSP4THxzqE+WqXD3cE8vP3JyywBdZtBes7fo78BJyPZgnn
	sxozd9us6+lmd4zDOhpj6ARMH5QU7GDwMyM4h/86VanRnIZM3qHiX1Ul57MLCGEpishqfCcicBA
	Rbm5tn32sVCnG2WJqp40Vuv4jzmqqCXigbDBo+6KHNH45uEL1wKGDnPBUQQYQ2A5wSEAYjOXdl1
	bUO4zG4QIGdkFiZZAtg8ccDSO6/bx4Hj+9WQ2WobSihMhuih/YIuvJWsFWgikZKz5DO9GlTlU3u
	uKsSwzCJJ3mK6jW3FMkduwzwIP+rMvDUHhqvoQ2Vd73nH+IMnpm+gA9vjK10r22g==
X-Received: by 2002:a17:903:1b08:b0:2c0:f807:56b2 with SMTP id d9443c01a7336-2c1e8955cd3mr211063515ad.34.1781020177577;
        Tue, 09 Jun 2026 08:49:37 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm207270485ad.4.2026.06.09.08.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:49:37 -0700 (PDT)
Date: Tue, 9 Jun 2026 23:49:31 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: 3chas3@gmail.com, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, horms@kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] net: atm: fix use-after-free in sigd_put_skb()
Message-ID: <aigrk5B3VzaWgKIF@Air.local>
References: <20260604164916.2681964-2-bestswngs@gmail.com>
 <20260609110615.196819-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609110615.196819-1-pabeni@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com,lists.sourceforge.net,asu.edu];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:3chas3@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 227D46624E4

On 26-06-09 13:06, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> net: atm: fix use-after-free in sigd_put_skb()
> 
> This commit addresses a use-after-free in sigd_put_skb() by pinning the
> socket with find_get_vcc() and checking if it is marked SOCK_DEAD under
> the callback lock.
> 
> > diff --git a/net/atm/signaling.c b/net/atm/signaling.c
> > index b991d937205af..3dbe8e0fdc9af 100644
> > --- a/net/atm/signaling.c
> > +++ b/net/atm/signaling.c
> > @@ -54,14 +54,31 @@ static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
> >  
> >  static void sigd_put_skb(struct sk_buff *skb)
> >  {
> > -	if (!sigd) {
> > +	struct atm_vcc *vcc;
> > +	struct sock *sk;
> > +
> > +	vcc = find_get_vcc(READ_ONCE(sigd));
> 
> [Severity: Critical]
> Does this introduce a regression where an ABA vulnerability allows a KASLR
> bypass if the daemon socket is freed and reallocated?
> 
> If the signaling daemon is closed, sigd is cleared and the socket freed, but
> an unprivileged thread in sigd_put_skb() might have already latched the old
> sigd pointer.
> 
> If an unprivileged user subsequently creates a new ATM socket, couldn't the
> slab allocator reuse the exact same memory address? In this case, find_get_vcc()
> would match the raw pointer and return the attacker's new socket.
> 
> Since the attacker's socket isn't marked SOCK_DEAD, sigd_put_skb() would blindly
> enqueue the signaling message to the attacker's receive queue.
> 
> Because the message contains literal kernel pointers (vcc, listen_vcc),
> wouldn't this allow an unprivileged KASLR bypass and message injection?
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but does sigd_send() leak memory when queuing
> SKBs to a closing listening socket?
> 
> When processing an as_indicate message, sigd_send() resolves the listening
> socket via msg->listen_vcc, acquires lock_sock(), and appends an SKB:
> 
> net/atm/signaling.c:sigd_send() {
>     ...
>     lock_sock(sk);
>     if (sk_acceptq_is_full(sk)) {
>         ...
>     }
>     sk_acceptq_added(sk);
>     skb_queue_tail(&sk->sk_receive_queue, skb);
>     ...
> }
> 
> Does this code blindly queue an SKB without checking if the socket has been
> marked closed (ATM_VF_CLOSE) and already purged?
> 
> If the listening socket is concurrently closed, vcc_release() will lock the
> socket, purge its receive queue, mark it closed, and release the lock.
> 
> Could sigd_send() then acquire the lock and append the new SKB to the dead
> socket's receive queue? Since sk_free() expects an empty queue and does not
> purge it during memory free, would this permanently leak the SKB and allow
> an attacker to exhaust kernel memory?
> -- 
> This is an AI-generated review.
> 

Thanks. The find_get_vcc() issue will be fixed in v2; the sigd_send()
leak will be sent as a separate patch.



