Return-Path: <netdev+bounces-134320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FAE998D2C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1D0B21CA0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FC1CEEA1;
	Thu, 10 Oct 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfIEkr5D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6C1CEE97
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575761; cv=none; b=fDilFB8yP5rDYGMcljPF8dD5Fj+dGeNV+f+VE8fYg08tDTzE6L9aBV30/jv85F0UwTxDaHX03uYtPmCz95YYRt6LnH1e9Sh+wsmbguVix3JbydSOMTlHPE+jMnfKRdxGo+EADwVgEnPEBRg4j+yurjJs4IJkp8wAswywZNP7N/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575761; c=relaxed/simple;
	bh=1i6VwhKRP+RPdE0J7al15vAclQ+hjJ24MDC5H/cRbdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWDwSA2SpTfoDzYGcb5gpep6cs7ARAK5srro3cs8UbQW3YXZtxZ4bPM6zprPmKxrGSYBcvFO/Qab7VOo6eeSVD4+pGlq7nKMfAW8gxpqe4Kp6SG/y3TK9HzbX3ifElu5OnRdr+j4pp3+FDiaI7UkrYWS2JgtzSEA4xqsRHk4Jtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfIEkr5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E29C4CED0;
	Thu, 10 Oct 2024 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728575761;
	bh=1i6VwhKRP+RPdE0J7al15vAclQ+hjJ24MDC5H/cRbdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MfIEkr5Dfvz/gKmQgpF/UYNosi7XNEPxxyANxF3SNOGpT2QDyqt/Il6VEP7uZ9MuY
	 ia6xablrufdKiQeipeQruzLaeMzIqpTfaKHKlCdhDgKE3WZbn6t5hXlEgq+VcTgwjk
	 b89dC2wi2QZQjShYkfZZtfoQHQXmMv2+gUhvXK+jMp29DvHCfY9R4+CwJH5Cl8xcZv
	 bSRfzYsdTgJWvEl/KPu4pjAl+9XxXYDOrL5dk2gb16t1bFO64ukLos+maBu9QBzF6F
	 vvq4RA/R8EnNMM3DbfsSP80Ocl54wiwq1s5GPXE1T4VWKtQ2FjEs99TmqVHjneWx2V
	 GTqBSYrQOYrIA==
Date: Thu, 10 Oct 2024 08:55:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/2] net: do not rely on rtnl in
 netdev_nl_napi_get_xxx()
Message-ID: <20241010085559.36725e69@kernel.org>
In-Reply-To: <20241009232728.107604-1-edumazet@google.com>
References: <20241009232728.107604-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 23:27:25 +0000 Eric Dumazet wrote:
> With upcoming per netns RTNL, rtnl use in netdev_nl_napi_get_doit()
> and netdev_nl_napi_get_dumpit() is a bit problematic.
> 
> They can be changed to only rely on RCU.

Oh, you already posted this.

I was hoping we can start moving NAPIs and queues under dev->lock,
gradually move all local netdev state under that lock. RCU only
gets us so far when we have to cross reference objects (e.g. link
queue to NAPI). Even with NAPI SET not sure if RCU will work given
the writes have to happen into the instance and the "config struct".

