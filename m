Return-Path: <netdev+bounces-116655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFA94B519
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E271C21303
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5ED26D;
	Thu,  8 Aug 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF2OA+3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E482CA7
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084434; cv=none; b=ck5zKUp597qdENMBge0ZNf/MJ9JvR11BX+z6TMHSXAzXagfS+bqWE37jrJ6UcvWvl5UfYxGCm2tfZOgLf0AL7Pf/TbSAEH0znp6uJpvwaVr7LMldeTv95Mufdg3oNHYV7bWXzDIh9tDoBWkWRsBofRGtPQkZonph7/lDr65ghss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084434; c=relaxed/simple;
	bh=NF0LnwxNuK9i5xXJHkPbw9xzBDM4Uzc1qfT/CulcVQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS6eaqRWNJ6kCiDZSlo9HeruZ4XTqnpfDzV1cu+p/p9DU2H/hx3se+5VBfTaONle4MxcQinyrZykY6iOlfev2uE5osJwd2WI7n5MZYoxwjr8bmXw8IHe+GSrVRDeOAJYNevKPXljJHBL3Mk+gtbWInZ0g1cUqGYBqh/PGE1egyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF2OA+3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9E6C4AF0B;
	Thu,  8 Aug 2024 02:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723084433;
	bh=NF0LnwxNuK9i5xXJHkPbw9xzBDM4Uzc1qfT/CulcVQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HF2OA+3pqa3ejl2hHlCDucwSYeW4ElI5irZX7iDkpAizTqcXUZjUO3ML6iH1rmDLu
	 22XDeJK+u8C7S+MltVTbRUw+dlc01zo+zt/cWF61OTa71C9r9ZwNr9rfgKH1QMk2nv
	 NYRvW2KS6fU+6NdmmCjhQp3eG0Wj4YEVQgpu5hg6p7z06DtWsldgrUCRDwj96q0iHm
	 EO4L3ybgsV6UYgHzmfHq/p141T+A/1gAmAnL7+ZBpIIcj5v+dfDycCTj43lX/NHAvK
	 tiBE3OgY/1E9MALXjvnCkiPUFZ1RNQRhWjf/kWNdZr0uY9AaGAPAC5YcXE9AKfAtol
	 tF1n2vKX1QwXg==
Date: Wed, 7 Aug 2024 19:33:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/3] net: sched: fix use-after-free in taprio_change()
Message-ID: <20240807193352.66ceaab8@kernel.org>
In-Reply-To: <20240807103943.1633950-1-dmantipov@yandex.ru>
References: <20240807103943.1633950-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 13:39:41 +0300 Dmitry Antipov wrote:
> In 'taprio_change()', 'admin' pointer may become dangling due to sched
> switch / removal caused by 'advance_sched()', and critical section
> protected by 'q->current_entry_lock' is too small to prevent from such
> a scenario (which causes use-after-free detected by KASAN). Fix this
> by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
> 'admin' immediately before an attempt to schedule freeing.
> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

No need to repost (yet?) but quick process note, please err on the side
of incrementing patch versions, this should be a v2 even if only diff 
is that there are new patches. The version is for the _series_.

https://lore.kernel.org/all/20240805135145.37604-1-dmantipov@yandex.ru/

