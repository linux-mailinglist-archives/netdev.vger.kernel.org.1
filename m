Return-Path: <netdev+bounces-226143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDAB9CF6B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC342281D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DA2D8DA6;
	Thu, 25 Sep 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfmZGnZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946A7262D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761691; cv=none; b=baOQaUZUh10Nw0I9iSgj910cqh6x+niJzSXMi30T119yal9nT39oxuzUbh71iOtDc9BrXBSUPdAZOcRgaNNwl6BRc8FNACzWljbobFlSLuForh5JkAggnW64WOqdw8//4b1Gx+pPE/KLFnEJQUgChFnQ2ZyJeo2DL3kmiEJL1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761691; c=relaxed/simple;
	bh=Wo+ExzGD7y99w9KwqFXtuG0Du+5BfB/PlkbpjxqKNKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzydfcJnO25S44Vj6SGDQUkSYp4xuufwwFjhY1jysMPCnaWg9Ya6GrU5LbQTIzFrBSN4nwNlNP1Xshf7MlaB4OXkblrfKwKZ15Dg1gaQ8YufNfTgUgTvguLCgsKqK3i8oJtr+G/XFlNkVgmEeQM3JUXdSWgUgYFg2g0Rs+GFCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfmZGnZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C8AC4CEE7;
	Thu, 25 Sep 2025 00:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761691;
	bh=Wo+ExzGD7y99w9KwqFXtuG0Du+5BfB/PlkbpjxqKNKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfmZGnZDNgqzHtTT78TsUUF5Zmxf+GFYcwUCTHwtHTQlX3O/2XiDAdZYAAEOCX5Xv
	 89YK+2W35lL1xf7AGhqYb0+VaNAURqtoBWtN1YhNBNj/c/IdvfdKeup3RzYSF2MLZm
	 nyBYYzmlNV1aasm49buaVx0MGgRFEli2RwGevF7CD5kcWjFXN/tT0/QEkIi0ZwYNDx
	 hd1E0cPK3fbnkuMTNM8o+k+C1DjqWu+2qmUFd7ZhhzZVBiWWeq9GlPjcKIbJY2d0or
	 kPfl/bJ2ireVg+dfg/xilj2jD/FKR9C0Yf27uCyXjY/9sAkIsiCYjFa1ZnWNaBHn09
	 DYwZhyM1vT6bg==
Date: Wed, 24 Sep 2025 17:54:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: edumazet@google.com, kuniyu@google.com, kerneljasonxing@gmail.com,
 davem@davemloft.net, netdev@vger.kernel.org, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v5 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
Message-ID: <20250924175449.36b71e48@kernel.org>
In-Reply-To: <20250924015034.587056-2-xuanqiang.luo@linux.dev>
References: <20250924015034.587056-1-xuanqiang.luo@linux.dev>
	<20250924015034.587056-2-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 09:50:32 +0800 xuanqiang.luo@linux.dev wrote:
> Add two functions to atomically replace RCU-protected hlist_nulls entries.
> 
> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
> mentioned in the patch below:
> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
> rculist_nulls")
> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
> hlist_nulls")

You most definitely have to CC RCU maintainers on this patch.

