Return-Path: <netdev+bounces-293068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJseOHBgGWpevwgAu9opvQ
	(envelope-from <netdev+bounces-293068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:46:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E66A6002A1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BB93055DCB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6A3C3C1E;
	Fri, 29 May 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dnar5NhW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sQdxD3mJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FD3BF667
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047781; cv=none; b=auVrFwIQMpuyyc5fCw51ZuzYTNVOe5DEfQneuPQFnGy7kST6jVhfirYg7fbWGlYT8A9iS/zN2wSkEKn3fyAC5wb4J1MYosGjI9UhDNOoRitYHR2gzn0n+n9LTBcI0RNuji0DH4OkRtt9exVVFbWidcezit6Y+/abrUOaQElQAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047781; c=relaxed/simple;
	bh=8i5kslBP4UkVIDkpzXWUkO4oDalssyVZFJ0q0C8PHxc=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=EQmKvVKarp671tKCvqMZibLMMCBQbyk52KImrAd6iAZue6sydj1eYDOzCUfOjrHVecuvsGW+yCLuFzkT4fn4AsZHa5WCWNdmBPWV5qB0E1gNdecbvoS6rH6s4CIkuZV896w7IipzDjtXQQXk/wT0sXc2MxpTBlUBtpm/wQWx/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dnar5NhW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sQdxD3mJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780047777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EbJwg6UPsr1q8ilCkgLnamP733UEvzVj8vn7lhyNGU=;
	b=Dnar5NhWYKZcexX4sSe+LEvhuLcqxRNi+sGMoXDkBX2OJSymcEzbBulg8OGqIk1yz4hHnx
	0mnqZewoPq8QjD0LSw2I+B4BICmkmA5xQFE+mFYrbcTTsTX1O3tyUKTfh8oYeRmtxHE8pm
	fXFOqWv7bUNb7gg4mXb4xdqRYKnh+N8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-8xIIFEQJOrCAlkkzSQIJyw-1; Fri, 29 May 2026 05:42:55 -0400
X-MC-Unique: 8xIIFEQJOrCAlkkzSQIJyw-1
X-Mimecast-MFC-AGG-ID: 8xIIFEQJOrCAlkkzSQIJyw_1780047775
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ea19f2564so8204952f8f.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780047774; x=1780652574; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EbJwg6UPsr1q8ilCkgLnamP733UEvzVj8vn7lhyNGU=;
        b=sQdxD3mJpk2NZEzgauePioP2Tm92U7zTQSCHAeBwU4oFKEKWqG9dwH6nRGRFuUfLQP
         EC8inltnplhbPezjPSpct32x4NCm48zOvK/H+UClmzl7ELthg2g1rnTRew4oTISpeBOe
         iWZQ2IxwL+2ln6kpHavB9lGUQSR4mhILnr1knYAcosVkM1d3+K4U0CBjnegFgkVSWOt1
         WbhfaReDBy4LJJiBlxn8EjQdYc9vg3GHE/QTS3a7P53KgqG1MoExGxbGS/pZKxclEAtl
         s79h0LKxofXMiz7lcV8X53zdJ9Ul8Ej+yAxIV0HIlksm4MhBqOo7LmFkFW/S+UgE1IMA
         WGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780047774; x=1780652574;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EbJwg6UPsr1q8ilCkgLnamP733UEvzVj8vn7lhyNGU=;
        b=KZrjNDj/Yme6CHVwgyj9x0zsxVfBaObjHxst+ccpZsj3FqmcKG9J3C6dS/Hz3nIQAb
         GM0DGD8k+i2Igsz89KCsVvZoLNSF/bx5s12bGkAjaJvlXRT8WuZqTrpTVh3oX0kly/pr
         G8wndu/ccOHGK6+CGFglP8ZKW4y/ZMJJhjZpMWAFPmlnFg0e6/zvJSRr3YU2BOXz7gdw
         7AO4zCV1BVGwI9k2hW2OfKanv2/9qkhiO7ts6Bs8zzd1low7rHkjIpPVXQ0pOXrEUBrY
         TSqiLWgc63XMwc9XwLPHLLwXXjPw7DrMrwzjR/6cC9z3O6k1m7xyYwZm+PxbB8NUrbdw
         WENQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/BYzKER9UnQCkv4Y+aEVwWYSLfwu4A9Vj2We5qVJoO/qrL2RVtdVgIwwcaep+PZtImFYBfvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsJ8MmUkrXspJsHwHIG+gsTorDXbJ8D/oA6snOpKY44NJbJbg
	+Y+ogXFd1hdsOkwMEAM4aTZmK+PM8RqBObl3YaOrOWnLs4R1h6VcijVAF+X4z3KUhUm5eX7C/dP
	NLKeEu/248Wstkuwokd2hZH11LGXTyS7z7vSN7GRKjrFnU8dknacLbft+WA==
X-Gm-Gg: Acq92OEheQ1vo9F/AhfNshvCEj5tbNqzQAnt0DkRCH4zV84N6Gu44gIzKS9tuXH/AB1
	uZ8h6oi4wK6FkmjuMpta7YjEyTcyaVgZ8awsIMuCAUJBZNM3XeW3QgMeFXz516ZJTyci2vThWNn
	8RS0mYoh1Dp1OzuLDy2Nql0YOWuxTqHPa6269cCKWsWybF9roqY9NV0S3ucbIPMwQR1PqwIg4Vj
	ZUNMV5vDr/piG/hOXD26HOZ1P68M/Mo1ogOng9pcOXaww4VyUFFgtvVFexBiVElrijEEjRlY8zO
	AQN+aQTUaFsYOvKzIREXmJPbVtUZP53UWdLizwlOS0PWq+HJ4rSynaiJOMedPMmf7wlimbAt6QB
	XHZRtGcGVfVbDaaze2ikz7YjecQF8yPJLZ0JA04UhMS2Y0NM15+SvGztRqjUC
X-Received: by 2002:a05:600c:2d0c:b0:490:388f:1c0d with SMTP id 5b1f17b1804b1-4909c079375mr22908975e9.5.1780047774329;
        Fri, 29 May 2026 02:42:54 -0700 (PDT)
X-Received: by 2002:a05:600c:2d0c:b0:490:388f:1c0d with SMTP id 5b1f17b1804b1-4909c079375mr22908515e9.5.1780047773644;
        Fri, 29 May 2026 02:42:53 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c123406sm13320755e9.5.2026.05.29.02.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:42:53 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Lunn <andrew@lunn.ch>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Fernando Fernandez Mancera <fmancera@suse.de>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>,
 ihuguet@redhat.com, Linux kernel regressions list
 <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260529114216.2e42c4dd@elisabeth>
In-Reply-To: <ahkar8tE5M6u0_zZ@zatzit>
References: <20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
	<20260528073849.759da84a@elisabeth>
	<baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
	<20260528131250.1352ab48@elisabeth>
	<b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
	<bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
	<20260528153202.14900687@elisabeth>
	<178a1a95-65bd-475b-a035-c4ebdc5ec325@lunn.ch>
	<20260528171710.1a5f6b6b@elisabeth>
	<ahkar8tE5M6u0_zZ@zatzit>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 29 May 2026 11:42:52 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-293068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dropbear.id.au:email]
X-Rspamd-Queue-Id: 3E66A6002A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 14:48:47 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 28, 2026 at 05:17:11PM +0200, Stefano Brivio wrote:
> > On Thu, 28 May 2026 16:34:02 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > > Actually, an eventually fixed version of NetworkManager doesn't need to
> > > > know the behaviour of the kernel: it can just order addresses by
> > > > timestamps instead, as Fernando mentioned.    
> > > 
> > > Can pasta also use this scheme to order the addresses? Is there a way
> > > pasta can be independent of the order?  
> > 
> > pasta itself doesn't even care, it just inserts (copies) addresses one
> > by one as returned. The kernel cares, because it preferentially picks
> > the first one, as stored, within a given scope.
> > 
> > The problem is that they are inserted in the opposite order than one
> > would expect (that is, opposite to what's used by the kernel to select
> > them, and opposite to what's done for IPv4).
> > 
> > This (with an older kernel version) is quite "funny" (pasta by default
> > copies everything it finds to the inner namespace):  
> 
> Fwiw, a hypothetical tool which copied network configuration from one
> namespace to an independent one - or which saved network configuration
> to restore it later - would likely hit the same issue.

It's not even hypothetical: iproute2 has that functionality (ip address
save / restore) and addresses are restored in the wrong order on kernel
versions without this change:

# ip a a ::2 dev x && ip a a ::3 dev x
# ip a s x
2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether c2:72:d1:7b:ac:26 brd ff:ff:ff:ff:ff:ff
    inet6 ::3/128 scope global tentative 
       valid_lft forever preferred_lft forever
    inet6 ::2/128 scope global tentative 
       valid_lft forever preferred_lft forever

# ip -6 a save dev x > dump
# ip a f x

# ip a restore < dump
# ip a s x
2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether c2:72:d1:7b:ac:26 brd ff:ff:ff:ff:ff:ff
    inet6 ::2/128 scope global tentative 
       valid_lft forever preferred_lft forever
    inet6 ::3/128 scope global tentative 
       valid_lft forever preferred_lft forever

So scripts using this are anyway broken (well, they would get the order
right on every other save/restore, which makes the breakage even more
subtle).

-- 
Stefano


