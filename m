Return-Path: <netdev+bounces-203926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425CEAF8181
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC18D4E6F2A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5782929992A;
	Thu,  3 Jul 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="XN2JNls4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLovwVc8"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49C2DE6EE
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571776; cv=none; b=IpePzMDa0ZpmR2o3DCc/xmd7eheC9YMbfxwDOVBCO23bocEWpKqd7W9M+nXbc7Iwb6n3UcNbnovMfq9nNfPjpd4ThyjtIxlsW1tFFvsIhAwWC7NJXXMM58qcVfhxMldSGigJJl1VkKZ3qQ+Wz9X3zUMpaQFpz5kU667tpCGQFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571776; c=relaxed/simple;
	bh=DnjOHLtbsP3NF+0HS8FTcwvRjC6f0OrDc4abePr5EAw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=cg7M6Uff+M9B9isnMRvj6Nq4Gyovk0yrAyx5YadZ5JxFLnRdVjHy9W4H77ynMqdDQ1OFao9Itf1z+CDvzcxu43bE5U4XHKc4n+F2Ogd4sXsYP/KktotUaBQVvAQPo6z0hsO2uWM9SA2FlWi8SX64TGoGCU+wjvhf6af9bcg6zOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=XN2JNls4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLovwVc8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 69C331D00173;
	Thu,  3 Jul 2025 15:42:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 03 Jul 2025 15:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751571772; x=
	1751658172; bh=dAohGufPzAxf4sbHl1/b/ZDYTz2tsxoEUdNCBz+D0ZA=; b=X
	N2JNls4BjUdwwi0s1xMKNj+458kaBuluC8Xq5lNCtdkYgVp2h0Ubjjcud1FWNHhf
	f/SnfGn61X6yXZ7KfvSL8sgjfu8uXP2Ov0zl7ds0KkqLnd7zgRmFJ6SjZ8N6umKJ
	MXsobjC6VE7d37/gboMTRlEiH6U2n7lxuFrvGeMTnSz53h0ptjjmgpX/ZqgktFr3
	06Cjlr0XC2Jm3azefGYFtlLjQppEtIJqRAZMyaTh1SG53TJW3nHx5txcKfkuqJJi
	R5gcfq3kkK9swIetEG5e9A2+xL0MHpKpm5Ai7D+ccrfAwY76aljupflmObg82Znz
	Mmt0M4333f1G8kfkoi5Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751571772; x=1751658172; bh=d
	AohGufPzAxf4sbHl1/b/ZDYTz2tsxoEUdNCBz+D0ZA=; b=JLovwVc83x0s1ZrDb
	jwEZFbTPCOgxsItC/I2yEmG7bwKCKdUdvVFEn2zu0gSlrbNJWoRgEkRhYtHjZdKL
	C893ZAu/N9Is4VBs5hEM4/s2/h+DOc+AvNtPJkT7uL5KDmP4dwwOiuweXIAOg91c
	l0PNoZVMmu1hArIGxJ3yHFjoW7fscxm9MSDQ6HSKaW8/eSxNf5f9ttb+1ZpWuiIC
	zVnOLzwoD/6/jTga1X6kZeq5QNyp8acXDsF094zmR4mMaClSaBZfJRprlwPPf69M
	/V7Pl0P7YjQaGG73WTjTo/BTyGWcocj+qMrqOU9Z5wn9JBjlZTb75fFKnE9NcAGq
	wkKMw==
X-ME-Sender: <xms:O91maNu7i7cpPaTMmy4-N1qlbyIOt5z38fbQuzoPcPvQmzAJFr3_Og>
    <xme:O91maGfaHxHrRSWELHL-LHPTTZ2gW3dphh7h9qruMIWCrsOU9NFs3koCF3MMp2OQR
    8iX4j0Yn8AYnU7cOi4>
X-ME-Received: <xmr:O91maAzgHInEBSAFB0bNMlNMUiyhoGJMyv_SsBwJdApE5MrDThoP4bckuT186UZCC78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvuddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtfffksehttdertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epjedvgffhteevvddufedvjeegleetveekveegtdfhudekveeijeeuheekgeffjedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvh
    hoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    eplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgii
    vghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphht
    thhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirhhisehrvg
    hsnhhulhhlihdruhhspdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:O91maEOZiYr9ZTrCviSZr9reoBmG169uLRKS3PHPx8K7Hoh0rAYvGg>
    <xmx:O91maN83UDwElXH3pQ_2f_8BNEi7QosjiFHdxDD5T3eW6gkO-S3R3Q>
    <xmx:O91maEXA1CTtHtMdhptF0yBc5ATxJ6Jrqye1bDgcZgjGACrzUVIYaA>
    <xmx:O91maOdsjVsy5lCdZudKUxNKRq-2u7m4QLh53kxAegMWmLwkGGPHww>
    <xmx:PN1maLM4hS2H1cZudEBsn06Vi8rXh2Vag72-P5lthZkVHf6T6kVe_vgp>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 15:42:51 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 440D81C00C7; Thu,  3 Jul 2025 21:42:50 +0200 (CEST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 4338A1C0081;
	Thu,  3 Jul 2025 12:42:50 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
    netdev@vger.kernel.org
Subject: Re: [Bonding Draft Proposal] Add lacp_prio Support for ad_select?
In-reply-to: <aGTjXpYYXIMfl9N6@fedora>
References: <aFpLXdT4_zbqvUTd@fedora> <2627546.1750980515@famine> <aF4fEGySN8Pwpnab@fedora> <2946319.1751389736@famine> <aGTjXpYYXIMfl9N6@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 02 Jul 2025 07:44:30 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2163292.1751571770.1@vermin>
Date: Thu, 03 Jul 2025 12:42:50 -0700
Message-ID: <2163293.1751571770@vermin>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>On Tue, Jul 01, 2025 at 10:08:56AM -0700, Jay Vosburgh wrote:
>> 	It looks like lacp_find_new_agg_lead() runs though all of the
>> ports in all of the aggregators and chooses the aggregator with the
>> "best" port of all.
>
>Yes, based on the ad_select policy.
>
>> 
>> 	One downside if we were to adapt this logic or something similar
>> to bonding is that there's currently no way to set the Port Priority of
>> interfaces in the bond.  There is a "prio" that can be set via ip set
>> ... type bond_slave prio X, which is IFLA_BOND_SLAVE_PRIO, but that's a
>> failover priority, not the LACP Port Priority.
>
>How about adding a similar parameter, e.g., ad_actor_port_prio?
>Currently, the actor port priority is initialized directly as 0xFF.
>We could introduce a per-port ad_actor_port_prio to be used in the
>ad_select policy.

	This is an easy choice, we should be able to adjust the Port
Priority on a per-interface basis.  At the moment, we don't use it for
anything, but that may change.

>I understand that, according to the IEEE standard, port priority is used to
>select the best port among multiple ports within a single aggregator.
>However, since the IEEE standard doesn't define how to select between two
>aggregators, we could repurpose this value similarly to how the bandwidth
>and count options work in the current ad_select policy.

	Well, one specific use is in Annex C.3 (of 802.1AX-2014), for
use in cases where an aggregator can accomodate N active ports, but
there are N+X ports that are available to that aggregator.  In this
case, the Port Priority can be used to select the "best" subset of the
available ports.  I recall there's some more detailed verbiage along
these same lines somewhere else in the standard, but it's eluding me at
the moment.

	But, yes, we could in principle say something like "the best
aggregator is the one with the higher total sum of Port Priorities
across its active ports."  I'm not sure right offhand if that's the best
algorithm, but I'm fairly sure it's legal from the standard's point of
view.

	-J

>> 
>> 	So right now, if the above logic were put into bonding, the
>> local selection criteria would end up based entirely on the port number,
>> which isn't configurable, and so doesn't seem especially better than
>> what we have now.
>
>[...]
>> 
>> 	From the above, I suspect we'll have to add some additional
>> configuration parameters somewhere.  It would be nice if the System
>> Priority were configurable on a per-aggregator basis, but that seems
>> complicated from a UI perspective (other than something like a mapping
>> of agg ID to system prio).
>
>Thanks
>Hangbin

---
	-Jay Vosburgh, jv@jvosburgh.net

