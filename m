Return-Path: <netdev+bounces-209067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE66B0E263
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC88567E22
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987FB27E7EE;
	Tue, 22 Jul 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk3Q1bUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D0264626;
	Tue, 22 Jul 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204065; cv=none; b=e3SVTMnhIgVBufa2iKDylEDsVODmx04y470xYf9n96X2NWb9kG/iH5EldjuMMZidLOmlg7wWXU0Ejk8phlVYSTqEL6wpHvzbzvlVJHgcDI2GsNiOVnB7bIBQZ2nfkEkJ0jzA+Xb+OtPzw5ANv5SeWISxveLvQdXXht0z9NE1z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204065; c=relaxed/simple;
	bh=9aXZLNdoq6M8JmLaGIfS91NLKIBB8FHHZC40bsxu5PM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIHTpjLsL6dCC7W0rrl21ngc1eZmdQyyfKhLQ/CG3aMezC9oDT5yKsxyXAXOupxHJkGxi2H1DTpCNTQmjccAmY0XZebKCXaiDEmI8W6AYWtfS34fEVM9MFAy3V2LJlki/RQYDwf5AxsKrL66XafSKceOf0Hw20K9a4zTfvwmIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk3Q1bUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569FFC4CEEB;
	Tue, 22 Jul 2025 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204065;
	bh=9aXZLNdoq6M8JmLaGIfS91NLKIBB8FHHZC40bsxu5PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yk3Q1bUpESJ2+waB7K5MYcWzbaXtMYHRdlhieOV+d32gee4czt+IGvNMA5y84HrUP
	 ySCFkkwkfr8x/lBuWkBP3KmVNZaSeKyceYyznupo8xWlb7E4LVnXovhpwMT+dr5bhk
	 rpbea3UTAuunjnlYhUO5QXhEO/rbBxNE805OHKsK0nDDy+wb5Srf7KPl+o7zwy8Gpd
	 Atxf1ifkkWQ9rCSKsOpeeRBEgxkWlZDXcogmZbqJLxTyOqadukhaC5T1ahtsiDcHpR
	 AYY3sXwD3YF+vdLmH2a6jTz8jlbiEhydSgxHXtRCbUkKyHlZ9S6mqiBZsy8ItH4H4D
	 NFFOAPfw5zEAQ==
Date: Tue, 22 Jul 2025 10:07:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot ci <syzbot+ci9865e4960193441a@syzkaller.appspotmail.com>,
 <20250722071508.12497-1-suchitkarunakaran@gmail.com>,
 aleksander.lobakin@intel.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kuniyu@google.com,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 skhan@linuxfoundation.org, suchitkarunakaran@gmail.com,
 xiyou.wangcong@gmail.com, syzbot@lists.linux.dev
Subject: Re: [syzbot ci] Re: net: Revert tx queue length on partial failure
 in dev_qdisc_change_tx_queue_len()
Message-ID: <20250722100743.38914e9a@kernel.org>
In-Reply-To: <687fbeff.a70a0220.21b99c.0011.GAE@google.com>
References: <687fbeff.a70a0220.21b99c.0011.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 09:40:31 -0700 syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
> https://lore.kernel.org/all/<20250722071508.12497-1-suchitkarunakaran@gmail.com>
> * [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
> 
> and found the following issue:
> BUG: unable to handle kernel paging request in dev_qdisc_change_tx_queue_len
> 
> Full report is available here:
> https://ci.syzbot.org/series/75b0a15e-cca4-4e46-8bf9-595c0dd34915

I think this email is missing a References: header ?
It doesn't get threaded properly.

