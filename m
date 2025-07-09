Return-Path: <netdev+bounces-205458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA0AFECF0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5017A7B843E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABEA2E8DF4;
	Wed,  9 Jul 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkmWWFWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00ED2E8DEB;
	Wed,  9 Jul 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073046; cv=none; b=XKQWoTq8V17MakAqvNsdvlzW2PJ0GjPHzL+Yb6Eq/6iD0Epca3mQodnW3RcxeP+ulCxkQYD7uYkF1dph1x8Qc41us2estozYCizEj1avnVFyNZX2/k8FStH2QPhGs3depOyvxqjDdcW0OQUjLp5tr52N7H6rBQXsW+ynCrvF5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073046; c=relaxed/simple;
	bh=kbecBcZxYSubrJVthCEsgsqMqr7hHQ9uuy4rHjiiCf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdzsO0XoBv+xuz6r9ck+Noar6WN4csdDl3ywYo0G29ZU9OMIiOjbBjoBubayxXa30ii5gJYbAuW9S72ojlORA1bjLTztiHn1rWT06ugrcboW+HTDpRid6hXjLNpeTbDyNWks4BzqkK/ccuQFSKdP26r1F8O9mN8iRM0rCBV1n10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkmWWFWg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d5d1feca18so646257385a.2;
        Wed, 09 Jul 2025 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752073044; x=1752677844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCWP6wZ7oB3Ul197jmONEcbIKoWf2w4iU3eywa9NkFQ=;
        b=KkmWWFWgwNhFljrHm5+23KBP9sTzHfhqL+CDpgdoJCQEIx6thwjq/+rSIXbmfK0jZH
         EHZP0liYp2KOE+DnA7KLbHiROTYdEsJReUaNFujjXpVM/k+OOE5LAJ/wNsYVxNKKWlOg
         0myYHfP4ANqh+984ZBEzOQq7TQ5VlzIzo6G1rUSW2is2HUNEC6CcJgu9fbQ02pJv13CW
         QmxZXlGRfUlY0DFDwE171gIcXPHibs6+BzKmuo0bPm0IeHilR8x9IxhYW1//EWuQzJP0
         YAS7XC0qpZEbsa90KawkWOgspy8Y8CTl270viIqupH1j1XFIZQerL1Gg8EoyinR2cps2
         Qi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073044; x=1752677844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCWP6wZ7oB3Ul197jmONEcbIKoWf2w4iU3eywa9NkFQ=;
        b=sRPPPRNgOcdlG6t5d7+VuCGpN4dN7HkV8sscpj44k2fIdpOqPiHSQAwSExuVowx7fT
         QOcjt4+BHbfwGeH5LDefsCCBEnPvLpJcSWEp8NzNqBsGi+mYqfVM+e8Z1r0CvzaX7MFt
         O46trFfhKCl5tM1hTUlwn2u96rMciJJxoX14DufJhmszkZb3PMQMvaX2I4ItatBnfODz
         XrSizbkx4tZVbdWtRqg2H1/CIdBaVzqWiE48edBhWpoYRqEJL+equjsd19Z7y04ADF6d
         EdH6/z/S3zjc9PyE4Q8geIX75Oeq2wsv5Q1bMFFKvrmJwmrJmTAbyezKJKCTZtry6N0k
         SO9A==
X-Forwarded-Encrypted: i=1; AJvYcCUhyQRPtHsiS/DTlxPHPCE5UfIutt0QE+6aFq+wSWrKjgxApJWFvsrNqLLLpxJDc6ozD0szqgVYu8BTZSk=@vger.kernel.org, AJvYcCXK647LcbVyCHNFPPwTAX95NOs1wHDyDjTWa+b3dPaci7tNZzykgMF1yIGMxd7Kz8SXYz3p429Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMK677hmvIB2Q6XLystBCHbIsiRTBEGzzrw4MSQbBeaiBlRA8
	Vk1un00TAGDOMGq7LuossV8PY+yZO256t8gPn4pNU8FBhGbaqO6WV3Rc
X-Gm-Gg: ASbGncuv0Sps4q5b3z1i6AxQnDywhgtGDCBSM2iYNMBVm7zfqopDHn/pX5s923VeXLH
	FOlBxNNiDMZvMFhKk+KPFidsMQnzzUaelVjo/aklytLSQECL+pJ4xjcEvHT6Fl3QWcPOZkYmVnd
	I0Twkrm8FTP3/qbjKAwk2H2PMrf5VosQPNJlTMx1gRv7SZm+d8wrokq94qWtKJXGmy4DdpwBGxK
	Iisd7ka4ZAUvY8kheVIKYKIRgD49n9jK9Z0A58UzuvyKVoFJFlyKD4snjj2SXhLfPWLLErQ0QsJ
	oF52lwjIDnbND+oQN5tO7FzcgA3t3Mw2VdBW8DUwCB85rb+9ZdW8jFswC5j9meliAptglIO/+us
	nz7MHYFhqEhu4+//3H8i7vl+osp98eBIf8njhxHhPDZ9z8CQwuwHz5VjEe32e4YY=
X-Google-Smtp-Source: AGHT+IH5ULuF5ETNQZL2OW5slQQdjZLvfaPlD6OkOsoK5m9NxtwxcZbZNQ7i0Hptnhy7LHKI/o4kZg==
X-Received: by 2002:a05:620a:6081:b0:7cd:4c58:7589 with SMTP id af79cd13be357-7db7db7a5c2mr401327885a.56.1752073043594;
        Wed, 09 Jul 2025 07:57:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd964f9sm945273585a.1.2025.07.09.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:57:23 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B909F40067;
	Wed,  9 Jul 2025 10:57:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 09 Jul 2025 10:57:22 -0400
X-ME-Sender: <xms:UYNuaJZ2v9lLku_fcFPKTuWKAbCIFa7QhNdzoSAWmTZfz_bv1PKvOQ>
    <xme:UYNuaO7JwkAjD9eYaLf4e-KsgZUM7Tf91k-AP88fnDTOqFivklEZw7xpBP48Wd8bE
    VIDybsFSV8ayfWDGg>
X-ME-Received: <xmr:UYNuaHcN4r0SakOPy4gdtZeQXpOjKuGKhO9pXDyqCAJCGh6ffDk0dQpw2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhlohhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhgvihhtrghose
    guvggsihgrnhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhope
    ifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggvhhesmhgvthgrrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:UYNuaBw5iG8pGmmjo7x2j6Dv2mr-OlpK_KAormf0w0Jf2YKA2_ZJdg>
    <xmx:UYNuaNr4_w7Z35tvdvYPjUCUX0mt8DHNj-86mGenZcgOnD47peSMiw>
    <xmx:UYNuaPxhRBRtDB4UTuOMZjikSDLXpl3h4cXdInnMWW28BlaTW6vOIA>
    <xmx:UYNuaBo1q3T2zWxxaxr3PzQRwYRyBazfJhHUje41-OdzXaqam4oSIQ>
    <xmx:UYNuaPeXWatALPxcZ7vBIfo7LIOzHs0LFTrdWOroXoCOrHYD6C2E4k-K>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 10:57:21 -0400 (EDT)
Date: Wed, 9 Jul 2025 07:57:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <aG6DT-nWb0w4MooA@Mac.home>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <aG49yaIcCPML9GsC@gmail.com>
 <798d0707-8f05-4ffd-9ee5-7d3945276ee8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798d0707-8f05-4ffd-9ee5-7d3945276ee8@redhat.com>

On Wed, Jul 09, 2025 at 09:57:44AM -0400, Waiman Long wrote:
> On 7/9/25 6:00 AM, Breno Leitao wrote:
> > Hello Waiman, Boqun,
> > 
> > On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
> > > lockdep_unregister_key() is called from critical code paths, including
> > > sections where rtnl_lock() is held. For example, when replacing a qdisc
> > > in a network device, network egress traffic is disabled while
> > > __qdisc_destroy() is called for every network queue.
> > > 
> > > If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
> > > which gets blocked waiting for synchronize_rcu() to complete.
> > > 
> > > For example, a simple tc command to replace a qdisc could take 13
> > > seconds:
> > > 
> > >    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> > >      real    0m13.195s
> > >      user    0m0.001s
> > >      sys     0m2.746s
> > > 
> > > During this time, network egress is completely frozen while waiting for
> > > RCU synchronization.
> > > 
> > > Use synchronize_rcu_expedited() instead to minimize the impact on
> > > critical operations like network connectivity changes.
> > > 
> > > This improves 10x the function call to tc, when replacing the qdisc for
> > > a network card.
> > > 
> > >     # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> > >       real     0m1.789s
> > >       user     0m0.000s
> > >       sys      0m1.613s
> > Can I have this landed as a workaround for the problem above, while
> > hazard pointers doesn't get merged?
> > 
> > This is affecting some systems that runs the Linus' upstream kernel with
> > some debug flags enabled, and I would like to have they unblocked.
> > 
> > Once hazard pointer lands, this will be reverted. Is this a fair
> > approach?
> > 
> > Thanks for your help,
> > --breno
> 
> I am fine with this patch going in as a temporary workaround. Boqun, what do
> you think?
> 

Seems good to me. We can add a "// TODO" comment to call out it's a
temporary workaround and should be replaced. Although, I believe Peter
had some some concern about IPI, I would like to get his opinion on
using synchronize_rcu_expedited() as a temporary solution. Peter?

Regards,
Boqun

> Cheers,
> Longman
> 

