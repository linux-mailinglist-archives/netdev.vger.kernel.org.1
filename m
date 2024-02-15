Return-Path: <netdev+bounces-72060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C5A856615
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4519D280D04
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C8132466;
	Thu, 15 Feb 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slBAaG87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204C131E4F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007836; cv=none; b=Btc4JdevmjFddgeDeyHpPOazQQ+kox3n9Yw7HVpbWtolc/KRMmgBYj0s+5YHJLDC6sel5PCdIIlci7X0+VHo+/2F0T5o9kYKY/Gth1Q9se7SRWDKtYQW++nJ+AAE9wmpD1eWIH925L2P9hOd25QSGM/vxySWZWEOyBDhb44aJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007836; c=relaxed/simple;
	bh=dRxR4ww0qWgRpP1dBz384YDK+R9rUMSg5weZN3vvZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9SdX3A1qevTljwDtUit0lGm5XxT1YGxp5ItURHUUuWIIceR2aUQQP4yCnSgpYhN9Qzs4kRXeOSELy4tSBaB7OMVeLGma8age8OP0gs53bKsBdy1LOTKf+gl8K2hJiZczW4NWefu1BxPxq+risTt+BqTiJZdBvipA0UN0/Axyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slBAaG87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC85C433C7;
	Thu, 15 Feb 2024 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007836;
	bh=dRxR4ww0qWgRpP1dBz384YDK+R9rUMSg5weZN3vvZxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slBAaG8750Ztwtq6jMH2Kv/Kt6f7MsbEYSuP+RNcVJhcHm9XuXcxnAV9fUg2DonaM
	 0BJsEF9ta4JHIkt1NJe7HAVmUrLdtVZIHwgmQ/Am8zAuWz1J2ik9+88qPvvsyZt0Xc
	 BOr8nQJEcwjfK1k8e1JblNHe33yOR5rpMgG6GbCzx8AvQU15zGPLrXabClRDbv0WKP
	 Ci4uduQ/XOkIcQcBBX4LVFzifD4BOP7B2gvzHu6942GqyrfTxEaB+n8TeLnxAOlkHZ
	 hpxbpDlUfVz7bKt1KSb5bNZT+Wk/OLZ0iipbPi3XUc8OHiK0URHJ4ba2S23sq6TVgS
	 I0kUlpMPxDIJQ==
Date: Thu, 15 Feb 2024 06:37:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Davide Caratti <dcaratti@redhat.com>,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, shmulik.ladkani@gmail.com
Subject: Re: [PATCH net v2 1/2] net/sched: act_mirred: use the backlog for
 mirred ingress
Message-ID: <20240215063714.58fd742a@kernel.org>
In-Reply-To: <789d5cc3c38b320d61867290115acafb060ca752.camel@redhat.com>
References: <20240214033848.981211-1-kuba@kernel.org>
	<Zcx-9HkcmhDR5_r1@nanopsycho>
	<20240214070449.21bc01db@kernel.org>
	<789d5cc3c38b320d61867290115acafb060ca752.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 13:56:12 +0100 Paolo Abeni wrote:
> > Sorry I'm not sure what you're asking.
> > 
> > We can't redirect traffic back to ourselves because we can end up
> > trying to take the socket lock for a socket that is generating
> > the packet.
> > 
> > Or are you asking how we can get the stats from the packet
> > asynchronously? We could build a local async scheme but I'd rather
> > not go there unless someone actually cares about these stats.  
> 
> I *guess* Jiri is suggesting to expand the commit message describing
> how the fix implemented by this patch works.

The irony... ;]

v3 with more words:
https://lore.kernel.org/all/20240215143346.1715054-1-kuba@kernel.org/

