Return-Path: <netdev+bounces-162750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB9A27D65
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550061886C71
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529A2045B8;
	Tue,  4 Feb 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcVixGgJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CC1FAC5C;
	Tue,  4 Feb 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704628; cv=none; b=KtA0Ete58JZXL9TVvUVez0hqqLobfpLUVATEckyc2QVnGrfCdGHX8N0bdGgeL+PqprvSUqTI52VMpD2XZSmtUIyTnVWPKrZRlQz8oJko7W0TymWilhd7roNPEzjzXo83BQK2VZTBUzzkNWjTCnll8rWznOGPckfr3gVoX5dAqY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704628; c=relaxed/simple;
	bh=ESVDTDikgX36E3puC/UzgOSUNP0RP1BZrv2bU2oGWt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro1ocKtV1rxTWgPX0Jfa9b0p7xTFONqAFQYNjyFuN7oLV6Zpso9cZw4cjvs9vp+hVDELnbBC1HSYrVLWPogjGHOLhot1FxSGqjQc4pJEgcfDv3W+fI2rVui+MVH3C5u9vYuyvQ2NLoeKRpZxXD28LHHKtj+XpWBjpS5Lnt3dhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcVixGgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6E3C4CEDF;
	Tue,  4 Feb 2025 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738704627;
	bh=ESVDTDikgX36E3puC/UzgOSUNP0RP1BZrv2bU2oGWt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcVixGgJqft3wWqdB4u2kvxf0eVKB9GezUP5Mndsg77y8j7MSJHmmGi1S9LHDiN9x
	 LPV9iSv1ShI9c0GvozXR9yUQy1jOhfeWJu2+x0QLIP3Vd1UV8aF3CTd9HyBMLZjGco
	 TrpF+KhECFIfSZC1m0TSumbaBLpsf2m4AV6dm+sYCGyhwstbIsXX6UUrGpjM9Sz0cR
	 Y1jR2zzEfBL6W0kmi+9D4WcQjSC8lfPCk1lv3u8itoVmtTwviJv17ewKQ78QboexUj
	 rj4Zd8eFJizpRo4AmZDZDTbKaS/4z2tWIQETYTxVIp/YE9TBOGaaCIsCJBamyadqqE
	 iXQlZraG5fWNg==
Date: Tue, 4 Feb 2025 13:30:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman
 <horms@kernel.org>, eric.dumazet@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
Message-ID: <20250204133025.78c466ec@kernel.org>
In-Reply-To: <39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop>
References: <20250204132357.102354-1-edumazet@google.com>
	<20250204132357.102354-12-edumazet@google.com>
	<20250204120903.6c616fc8@kernel.org>
	<CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
	<20250204130025.33682a8d@kernel.org>
	<CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
	<39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 13:17:08 -0800 Paul E. McKenney wrote:
> > > TBH I'm slightly confused by this, and the previous warnings.
> > >
> > > The previous one was from a timer callback.
> > >
> > > This one is with BH disabled.
> > >
> > > I thought BH implies RCU protection. We certainly depend on that
> > > in NAPI for XDP. And threaded NAPI does the exact same thing as
> > > xfrm_trans_reinject(), a bare local_bh_disable().
> > >
> > > RCU folks, did something change or is just holes in my brain again?  
> > 
> > Nope, BH does not imply rcu_read_lock()  
> 
> You are both right?  ;-)
> 
> The synchronize_rcu() function will wait for all types of RCU readers,
> including BH-disabled regions of code.  However, lockdep can distinguish
> between the various sorts of readers.  So for example
> 
> 	lockdep_assert_in_rcu_read_lock_bh();
> 
> will complain unless you did rcu_read_lock_bh(), even if you did something
> like disable_bh().  If you don't want to distinguish and are happy with
> any type of RCU reader, you can use
> 
> 	lockdep_assert_in_rcu_reader();
> 
> I have been expecting that CONFIG_PREEMPT_RT=y kernels will break this
> any day now, but so far so good.  ;-)

Thanks Paul! So IIUC in this case we could:

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0f5eb9db0c62..58ec1eb9ae6a 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -401,7 +401,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 static inline struct net *read_pnet_rcu(possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
-	return rcu_dereference(pnet->net);
+	return rcu_dereference_check(pnet->net, rcu_read_lock_bh_held());
 #else
 	return &init_net;
 #endif

Sorry for the sideline, Eric, up to you how to proceed..
I'll try to remember the details better next time :)

