Return-Path: <netdev+bounces-163506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F42A2A75B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331B8163145
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA92288D6;
	Thu,  6 Feb 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mnx7MDVe"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19C215179
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840955; cv=none; b=dm6tS5P51B4xaZ7zJgF8Rx8VIU6pf66ohkuYx9VjhhiVIgMgMYPt4QxCcDq7mI3G7PedHBsr2f5KRFok1KXVpqu271WSuK/NejTtYowKd+Ei/TK7cOhSHTOkmw2YJe392S2s2+lZl0avWnCjE58im30DyuYOUKsAW3ph8LfyD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840955; c=relaxed/simple;
	bh=XrvCwPSnd/rH3SNA+aUhe4MCsplEHhhf4RlZJKaGfHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljUwEIR4j3bmfh+9Bh8vTC5w2RbZCLNQ/sYLPPn1AW2biAY5W5uXPHJoi4LypHxxsgG2SOJuGlSVJyNA2o9dNhtECZ3+kqrJvpKePpVQrIT6VHWo2N+Rr0c3xGE0mucIWba+jCckIkdlNXAsbkBuRsV/TDr0mhdGSgajiliiGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mnx7MDVe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29ECA11401BD;
	Thu,  6 Feb 2025 06:22:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 06:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738840952; x=
	1738927352; bh=PfnB9adDhIB8MQojqiDsQ7zGdx5/aD6m1qxg2h6/M9k=; b=m
	nx7MDVe4vll/zVxkT7S55pvNQ4z/pEqW4Y8pCgodvz05qgx/eAOsnsnQ6DHaLuri
	3hIWZKm5maU4H2BrhQLdDXyvysSSxeXI5uQmib2KoLcwWghCAqebR5QpfNT4L6Yn
	71gYlsfYAYgQ46oxt+9vqrhF5MNVwOmNT9OiF3NtX+XreUrwMTa43Z1/LF0raCtD
	sd50q5FQs69/3MBPJiVE0cvewmQel47GQgB4Nx0j0zq2OYnnPK1I2XAjMjf6riNd
	CbLbTTnr9fBDuC8GufhGyLUZzOVvr6t1KjynuH9w2PmVT3eGvT9NMi0eDjoXIWuU
	9VvNLqp4JRkgyYWQ+5TuA==
X-ME-Sender: <xms:d5ukZw5t9jiobGpmw56gggSe0vRr7nV5HFGDHvReLSIr1URbSHiMEQ>
    <xme:d5ukZx4fxZtVujqbVeu2Ooya62YTf1U5Y4zRyUMVlkDYnjReI7fhsiwWkBohorkQg
    3uGAIDuALTnr7o>
X-ME-Received: <xmr:d5ukZ_eL6xeEL9Ta_zKXS2k_98cxWYmRhE7ANZ-yZ3-VEjUsTsbbiofjgCiGLXSnuvqNkwavNUMkDFCpvQLrtc7ZxWthHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepkeeggfeghfeuvdegtedtgedvuedvhfdujedv
    vdejteelvdeutdehheellefhhfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhunhhihihusegrmh
    griihonhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    hhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhunhhiudekgedtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:d5ukZ1LuoU2DcihDVnqqNgk1GDjOgIa9OflXbiQtdO9RTQQHOzBfWA>
    <xmx:d5ukZ0Lp65WZAj4g3TIPjnhO58ntTtP1iuyR3IdPXQCvBR-G-kZtpQ>
    <xmx:d5ukZ2w5wo4f9pICDwu5o8juMTNY43JJE6HNpWvyBokbzkQgYTOoxA>
    <xmx:d5ukZ4IMd1KgOlg9_EsfLlbWSN2wkjL8kmzhgdixJmZxmPv81rVvRQ>
    <xmx:eJukZ9qsTGPsWc2pVDpYPwM4JcqSXRcoTSFAPOoTMjyYz6aa2kUSocHF>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 06:22:31 -0500 (EST)
Date: Thu, 6 Feb 2025 13:22:28 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, davem@davemloft.net, horms@kernel.org,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v1 net-next 6/6] fib: rules: Convert RTM_DELRULE to
 per-netns RTNL.
Message-ID: <Z6SbdEENQ9Qku6av@shredder>
References: <CANn89iLhtzeM+0oO_SQuK5sbj_ueVk63wE37qhS84wPdc-jbzw@mail.gmail.com>
 <20250206095221.24542-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206095221.24542-1-kuniyu@amazon.com>

On Thu, Feb 06, 2025 at 06:52:21PM +0900, Kuniyuki Iwashima wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 6 Feb 2025 10:41:12 +0100
> > On Thu, Feb 6, 2025 at 9:49 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > >
> > > fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
> > > 1;95;0cfrom vrf_newlink() in case something fails in vrf_add_fib_rules().
> > >
> > > In the latter case, RTNL is already held and the 3rd arg extack is NULL.
> > >
> > > Let's hold per-netns RTNL in fib_nl_delrule() if extack is NULL.
> > >
> > > Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().
> > >
> > > While at it, fib_rule r is moved to the suitable scope.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/core/fib_rules.c | 29 +++++++++++++++++++----------
> > >  1 file changed, 19 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> > > index cc26c762fa9e..3430d026134d 100644
> > > --- a/net/core/fib_rules.c
> > > +++ b/net/core/fib_rules.c
> > > @@ -371,7 +371,8 @@ static int call_fib_rule_notifiers(struct net *net,
> > >                 .rule = rule,
> > >         };
> > >
> > > -       ASSERT_RTNL();
> > > +       ASSERT_RTNL_NET(net);
> > 
> > This warning will then fire in the vrf case, because vrf_fib_rule() is
> > only holding the real RTNL,
> > but not yet the net->rtnl_mutex ?
> 
> As it's RTM_NEWLINK, dev_net(net)'s per-netns RTNL is held here and
> vrf_fib_rule() sets skb->sk = dev_net(dev)->rtnl, so I think it won't fire.

Yes, I believe you're correct. I ran fib_rule_tests.sh with a debug
config and CONFIG_DEBUG_NET_SMALL_RTNL=y and didn't see any splats.

BTW, did you consider adding this config option to
kernel/configs/debug.config under "Networking Debugging"?

