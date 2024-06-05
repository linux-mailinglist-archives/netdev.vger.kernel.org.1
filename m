Return-Path: <netdev+bounces-100877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 985DF8FC6F6
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA71F25789
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AB5812F;
	Wed,  5 Jun 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqSu7qyf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iwFAB6Dr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C04149C7E
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577475; cv=none; b=uhWia9zF+Q+d/AiJ99kGb2tA1i9GJdeLLMNlPJmRLkQDp2eSzEq6jDdSB1Gxa/03cgFLURMC9jS4s+3tEtBSWiFnXQrNFOyjTqEyKonWqjHLeb/om4TSZGq1FK1fzbkacZ3/iQdC4O1UEKsJfUPTvDO81pdqJVteJgj5Zi+wZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577475; c=relaxed/simple;
	bh=ESb3dwlj8tgBm+hnDEEmDhiL61kDeDwSaP1sFfGu7oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWRPlnW4DxMFnhDZBXR80r7tbGdVlA1KbGqFr8nKZEgrrnHoMvCXQIZJ80Tuvzaz9ovZg71pe4CetmBWX21ISsayiSVw5ZtHQvphXynRjghb6FRBSlLGcuY9uHeBbVy2y1QMlUFu5M14KNFbSTFPKK96Qp9v4wQPnjUQD8nnL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqSu7qyf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iwFAB6Dr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Jun 2024 10:51:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717577472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+L6o/re+9gWv2/FjqoQvMEvB92FJr+7TcrpHzksQdE=;
	b=rqSu7qyfmt9Y8V6rH4BVHv/sa00JUv9nA/lSIf60MqSFgSAE/8kqdHXGlbjkLG7HuCuyAr
	mctdRvaU8FALinm7FSSISaXoKTdcNp/KE3jQ3aEQapl04usSokHCi8EimZGjeheSgs7BHY
	nZG87k1glk6Gg8Zy0F41/1QfaUmDzr2SHMS/07DEryQ5K0z6BmoAKQycKI3z2xp7qOa1Lt
	KcnlEBSPCc7wA/rm0az+K64944SzM4Y1sikp590QuefLr+nwCvvoKkTwh6o96zfSseU5GI
	fUR6EtSndDPRHcSIgeWVGiqIQPTCVvt4Gth0wfjs9hkAZGZgyvG/a75SmeMDDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717577472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+L6o/re+9gWv2/FjqoQvMEvB92FJr+7TcrpHzksQdE=;
	b=iwFAB6DrNWvirMcA1BLvbH1hqGNU4aWySi2sNT0xvXrjGsmyzOA3jav+5RWDPJqdVq7tWw
	8vzo+lsDaRpiEYCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com,
	tglozar@redhat.com
Subject: Re: [PATCH net-next v7 2/3] net: tcp: un-pin the tw_timer
Message-ID: <20240605085110.Udh71e7A@linutronix.de>
References: <20240604140903.31939-1-fw@strlen.de>
 <20240604140903.31939-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604140903.31939-3-fw@strlen.de>

On 2024-06-04 16:08:48 [+0200], Florian Westphal wrote:
> After previous patch, even if timer fires immediately on another CPU,
> context that schedules the timer now holds the ehash spinlock, so timer
> cannot reap tw socket until ehash lock is released.

The two callers of inet_twsk_hashdance_schedule() have the comment:
| /* tw_timer is pinned, so we need to make sure BH are disabled
|  * in following section, otherwise timer handler could run before
|  * we complete the initialization.
|  */

This isn't accurate anymore. I would suggest to simply remove the
comment. The only reason for local_bh_disable() is (are) the lock(s).

> Signed-off-by: Florian Westphal <fw@strlen.de>

Sebastian

