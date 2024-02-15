Return-Path: <netdev+bounces-71890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB785584F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0750A28D7AB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217E623;
	Thu, 15 Feb 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWXfgN/o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B8383
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957094; cv=none; b=bP6nC9StKDFYDUgnw7B9AE2aP2QaGRlJ3bklKWAZFuX8aXLCGHTOtqwElmbpBZL7BNdLdVAnZrbae7CJkJYld5JUVwQCYo6RT/W+hxm0r8yKBjb0XFvNaInRpKTTZu7yYe+/GP8DCyDml4wP9/aM0JzGdZFG2hAR0snCgaYG+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957094; c=relaxed/simple;
	bh=V+ajUQlKttqSUAO4XdYZG1Wuj6aV00As8gCKQxC4HQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQPGMX1aBRhayxb2s8xnsxiqJqXLX0DkTvESvF4wde/p8Ear7/AYo4lLd0PgsoRPcdZ3T7Lyg4MlgXMZg99ExuXs8b/H7P96rSfixV+mG29NPoNyRBzGrkvqclzJd+Neo57IRow+MjJwO/msO1tnwtI1jgMugPN5490AcXcD0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWXfgN/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FE9C433F1;
	Thu, 15 Feb 2024 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707957093;
	bh=V+ajUQlKttqSUAO4XdYZG1Wuj6aV00As8gCKQxC4HQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWXfgN/oD8EHW7W0xaIcjwLMRGaneqyxlnzi36tkXYI/ViKKQLG6fxCyXjiGTeXX2
	 rLu8jRoqOuYypuogGv+XaYcgQSU6udp2pdwIzBEvhzBUXQYB9Tv6YgDwXRM/qflZ0W
	 SiLm469o17k3CL885ZFAcW0cs3I/Lxi9TYWvDVAJFs3yMJJ/g+fnSiI/87XVsy5pca
	 V6/O+2+zl10pHB23JvX6tkbdKaOFTVWfLg2la4GE/KfDI658O1zi/wGxNCaQsgcCqH
	 duroCbdwBMmMdiLCZSjw4X600IpgZt49JjO//aJiW+uFpheb95hzNE8cQWoMIg1iM7
	 jk8znNm9+dW/Q==
Date: Wed, 14 Feb 2024 16:31:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shmulik.ladkani@gmail.com
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred
 ingress
Message-ID: <20240214163132.54fd74bc@kernel.org>
In-Reply-To: <Zczl_QQ200PvyzH5@dcaratti.users.ipa.redhat.com>
References: <20240209235413.3717039-1-kuba@kernel.org>
	<CAM0EoMmXrLv4aPo1btG2_oi4fTX=gZzO90jyHQzWvM26ZUFbww@mail.gmail.com>
	<CAM0EoM=sUpX1yOL7yO5Z4UGOakxw1+GK97yqs4U5WyOy7U+SxQ@mail.gmail.com>
	<Zczl_QQ200PvyzH5@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 17:10:37 +0100 Davide Caratti wrote:
> > So tests pass - but on the list i only see one patch and the other is
> > on lore, not sure how to ACK something that is not on email, but FWIW:
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > 
> > The second patch avoids the recursion issue (which was the root cause)
> > and the first patch is really undoing ca22da2fbd693  
> 
> If I well read, Jakub's patch [1] uses the backlog for egress->ingress
> regardless of the "nest level": no more calls to netif_receive_skb():
> It's the same as my initial proposal for fixing the OVS soft-lockup [2],
> the code is different because now we have tcf_mirred_to_dev().

FWIW feel free to add your Sob or Co-dev+Sob!
It is very much the same solution as what you posted at some stage.

