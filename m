Return-Path: <netdev+bounces-101595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80D28FF86A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC44283AB3
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C5846F;
	Fri,  7 Jun 2024 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElpJvxyZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC58462
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718694; cv=none; b=kgtV4kykZvH3DghkXf22GITrDOowmwtP0P6WQJwWnrTTW35XnmTr+jBBYpFxCXxZt+cv97X6NOUcICHS0NBwnvmAtK7MA15GtEDL076IO5XCaC3TYJOalb8mExlofn2Q7zzAx7HdFp87LzY1g3CzI8EWYRED6pAfelY5EM+XvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718694; c=relaxed/simple;
	bh=8Fl2L/kX4WL2MobPsD8sNE8NAYpmnb7PbXqBWSEOu8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZ3gSBOeTYlprKdXXAuoTYI1uWoAOwV6gnwwWcK2E2uGfrV8+j/UE21lY1ZZYMmApKT8wBIy2euN0svV9D8nnb1+ZjFvX09hO7XsqNKzSvX0dM9v1LSOs8Y45xBlHBHtGvia+RXx1GDm1pqN7VBu/mG/InCJpHLNMwYYU+TQ4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElpJvxyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A02C32781;
	Fri,  7 Jun 2024 00:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717718694;
	bh=8Fl2L/kX4WL2MobPsD8sNE8NAYpmnb7PbXqBWSEOu8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ElpJvxyZWDY6p1sCKuwwdNsc6lPRooFmNca3jFJwHknC4iO3H0YDA9f9/DUrFZ0bJ
	 k7W3DDB/4KHGYRfLbamwCEyNmL2lFEt2Ak8H8BSHsK7yZB01SmO17D0sxfQ2Wchpp8
	 ufJMOpbDSo/CGRdb8+KotOGbBy+3/UshTTPK3UTozANhSeJNIhku3+fe6cPw6VYRO5
	 H2QfOd+G1qqQCyraD+j/F1eeNUXV4MEyx4JzOFQOxL4vCc+Ous5hih2Fbjt0F6y84i
	 FjM1k0rELcV+g50zkCRgTfWyihhOEoLRI1TBjDzLAORJoB3ByaaFQTHaJzNZObLrLa
	 BLo6b6IK7EZ9A==
Date: Thu, 6 Jun 2024 17:04:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <dsahern@gmail.com>, <edumazet@google.com>,
 <jiri@resnulli.us>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] rtnetlink: move rtnl_lock handling out of
 af_netlink
Message-ID: <20240606170453.53f20d5b@kernel.org>
In-Reply-To: <20240606233303.37245-1-kuniyu@amazon.com>
References: <20240606192906.1941189-2-kuba@kernel.org>
	<20240606233303.37245-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 16:33:03 -0700 Kuniyuki Iwashima wrote:
> > +	if (needs_lock)
> > +		rtnl_lock();
> >  	err = dumpit(skb, cb);
> > +	if (needs_lock)
> > +		rtnl_unlock();  
> 
> This calls netdev_run_todo() now, is this change intended ?

Nice catch / careful thinking, indeed we're moving from pure unlock to
run_todo. I don't really recall if I thought of this when writing the
change (it was few days back). My guess is that the fact we weren't
calling full rtnl_unlock() was unintentional / out of laziness in the
first place. It didn't matter since dumps are unlikely to changes /
unregister / free things. But still, someone may get caught off guard
as some point that we're holding rtnl but won't go via the usual unlock
path.

Would you like me to add a note to the commit message?

