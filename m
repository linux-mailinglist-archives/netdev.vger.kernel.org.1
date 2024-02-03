Return-Path: <netdev+bounces-68785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041A8483E3
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 06:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B027C281FD3
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA71097B;
	Sat,  3 Feb 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/fOgbu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECE10A01
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936912; cv=none; b=m/cBIYhSXzoV5Ig12Vb7+cDlw5uEt4TTeM3jIlixyr7V+wR7TB58+2nsrvWjieQEbRRLLk4zribIu8o23SwhFbKj6aybjJYbbxKIrh73nnanGiEz+aByM8oCNoCtLd1XT/jEL3NaULH/cDaT2u0vMCc4Bn+7cT2I8bjDz5lvMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936912; c=relaxed/simple;
	bh=0NaybivRwiZqVSOGyTbMmmihOJO8A2qECauCBBZ1R5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auOZsL3MSb3vYxmxrDevhkSGBeIpNzaJOg9OP7bNH0L8UpVwUPJanQyH5reUUjPBDQdbUNJ/fNWOCEFM3OlJIu2BLxzTQA5SRbq7EXjfHGne9noEYH4h8OfrDNBpSq5Fd3hKL4Y/5zr6DmLnYm4mpfcEI6OxDd37eAuHZkEHXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/fOgbu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7E5C433C7;
	Sat,  3 Feb 2024 05:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706936911;
	bh=0NaybivRwiZqVSOGyTbMmmihOJO8A2qECauCBBZ1R5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/fOgbu6j+CF44J4jR1O8qzL2vlLHkTsmmddXrqu1dPTM1O6tJssKnV118zJnBZVd
	 gCN+pWJ7Ep93OMB3suHiOf9uqWSZu7bljVQFg2i71zIR//C26DU2inAdaGaOTI7hh7
	 cq4ErTm4or1SBVjLZInvCB1UWc2V0RALbCe/A8rAfpwEaBgn9DdgnGGk+mkL8FcnBk
	 tJDNeHkGrFZ/SEczu+rWDK8Jzl565BCjJleQkZxrFkW3cgFxiofjcmKxWJdzJL1E0I
	 ysqM7klVsz5k3++c1U1g5sCtbZYnWASfQCgNcJkaDxn0VT+r3Gwp9GnfK2Qc/vAlmp
	 RC5l/eESCpGFQ==
Date: Fri, 2 Feb 2024 21:08:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Ilya Maximets
 <i.maximets@ovn.org>
Subject: Re: [PATCH net-next v2 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
Message-ID: <20240202210830.09103222@kernel.org>
In-Reply-To: <e58d5b6d8a091bb4f3beb4ffd43583d37ead4cfa.1706805548.git.dcaratti@redhat.com>
References: <cover.1706805548.git.dcaratti@redhat.com>
	<e58d5b6d8a091bb4f3beb4ffd43583d37ead4cfa.1706805548.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 17:51:44 +0100 Davide Caratti wrote:
> extend cls_flower to match flags belonging to 'TUNNEL_FLAGS_PRESENT' mask
> inside skb tunnel metadata.

sparse complains about bad endian somewhere in this..
-- 
pw-bot: cr

