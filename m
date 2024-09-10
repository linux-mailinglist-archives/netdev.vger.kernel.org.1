Return-Path: <netdev+bounces-127144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F9C974504
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C088028408B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383D1A2561;
	Tue, 10 Sep 2024 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzZuIufR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9A16C854;
	Tue, 10 Sep 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004960; cv=none; b=UDxuZm7ZXOb4wejeEqPkNbPFUV8YqBGEm8FtmPc4PagZanUQssu1ilWfo0ehPeJ1ULQ5IEgUCt/v0smrGQ/Idul2STK44ykJpkoUCqmD3+JmJgAM/o0HTlC7E9k2adRSKB05++HfaExams14TMSeHSykDbpZ+KHsMM/juQWJuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004960; c=relaxed/simple;
	bh=EvADvw8mUOwNYA0LCJpOD0WlIwk5CTNOn/FGlIFjEY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lq6Sjn2/trSpYQ5uYn36rbeE5pjvkHX+rGtyrGZ+c6uaRp0xOQG63OUbenkjmMBI0ucOY3jmmtg7YNwmIrURjBFQGE96G+70dHn39YaR4BfMNd1o169JNEaJHV2pBiwLEBJ7nri7GLJj2BbJBG7TuX5P+AjSIO8I6R9SSADPSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzZuIufR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7B5C4CEC3;
	Tue, 10 Sep 2024 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726004959;
	bh=EvADvw8mUOwNYA0LCJpOD0WlIwk5CTNOn/FGlIFjEY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzZuIufRqQiFZ2ayu5DOhV8nyN7KbKbtyBCE+A0eVrf6er907lv8GLHi0hVlrzR9J
	 UJW/VdhjeOp0WuZnDkttb0GFn/o8wBlFmtLqA9PF01ku9C1dxfw2kKH+n2A7kZfNU4
	 YJUWzVzbk25X9ueNX+pkovRrCwh6iUh/rgr5Og3IHqALRFB7oK+UfgRXAWvYFvYA+w
	 PD6ZTGXjaKQjk7q5gPsD6Lj2bMpJyD2dfjqid2AUpxPPfd+pnkUsxhRwW/7PVT+Krz
	 8pYuyB2rwuEQ0N/lUI8xuVwX4hfrb/4d5BY3NqlgGSVlwwRjs7kbtgvlsaSSQN+/A9
	 TWvTc77d92ezA==
Date: Tue, 10 Sep 2024 14:49:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <justin.iurman@uliege.be>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, <aahringo@redhat.com>,
 <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv6: rpl: free skb
Message-ID: <20240910144918.29c6be74@kernel.org>
In-Reply-To: <20240910204010.96400-1-kuniyu@amazon.com>
References: <20240910100032.18168-1-justin.iurman@uliege.be>
	<20240910204010.96400-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 13:40:10 -0700 Kuniyuki Iwashima wrote:
> > Note: if you think it should be a fix and target "net" instead, let me
> > know.  
> 
> Please do so.

Just to be clear - with a Fixes tag present.

