Return-Path: <netdev+bounces-168360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA61A3EA53
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC19189644A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463F192D96;
	Fri, 21 Feb 2025 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UfyUmBCf"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663D4A04
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102527; cv=none; b=ZD/uPX3xWdNHz2nxlJUIOh248WTVdrNYe7ttMl109au+Jt11W4CJgg7IUV9T903RAu7farXrSum0KyxEdKj8ZCs/dWvFZ+ZZL+qXH3eeAKHfPLUh2tCmMFRViqckpR1wtKwNcQcjE3MUmhtCXHqbPshI7hHv317cNJhG/GPF6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102527; c=relaxed/simple;
	bh=+mH6qsjv0PgMpoMCWn7agHkRQWgo1Ruu1E9D6tZDKGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXZ+mgUDacKiwH2roHqFPpIxAQ3uyxgabvczJmELpy2dTaXAOAJTu9xgAZJMi2RHy1uXMfo+hsJd3NclleyHzhcifiDQ4YB+XyWPqkPvNI7wwG0INXzKwnBzX9nqW4L1ifLgLMr7ybsr/3+v02t/9FOQZtjG873exUpQB5h67/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UfyUmBCf; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 09:48:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740102521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+euQk0QJrQhZN36BYVigsHr4hALLIbY8ZqkpFyXn1l4=;
	b=UfyUmBCfIQagcIW2UlpUG9jDmNebUMVi3aiPb0LHSybtmEb8QnzOeqxorn5TBWXds4Topg
	o3dQJ875Yx6ZfgsF66+evcb0UmRY8Nb14aWgI1+LCHxlgRP8fYODZhM/Nw6RDHngrXSjCT
	qWyV0BPeSLSfvfySj5r7I3CK8WFzee0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ricardo@marliere.net, viro@zeniv.linux.org.uk, dmantipov@yandex.ru, 
	aleksander.lobakin@intel.com, linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mrpre@163.com, syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v1 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <rqdpj4pdxkiad7amqp7qzsrdtgy3i5beqpz7gsrjy4dwkmwg2x@3bsn7svbawic>
References: <20250218133145.265313-1-jiayuan.chen@linux.dev>
 <20250218133145.265313-2-jiayuan.chen@linux.dev>
 <20250220152703.619bf1c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220152703.619bf1c9@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 03:27:03PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 21:31:44 +0800 Jiayuan Chen wrote:
> > -		*(u8 *)skb_push(skb, 2) = 1;
> > +		*(u16 *)skb_push(skb, 2) = 1;
> 
> This will write the 1 to a different byte now, on big endian machines.
> Probably doesn't matter but I doubt it's intentional?
> -- 
> pw-bot: cr
You are correct that I assigned the value in a way that produces different
data on big-endian and little-endian systems, although it doesn't cause
any issues.
I think it's better to assign it correctly according to the corresponding
header and add more comments to avoid confusion for other developers in
the future.

