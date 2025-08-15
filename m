Return-Path: <netdev+bounces-214085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD11B28305
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195DFAE8500
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E31302CB7;
	Fri, 15 Aug 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdjEynv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A230277B;
	Fri, 15 Aug 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272157; cv=none; b=CI1715yQUtwH4nKwuiE4HVRh6wb7YtLv8L1JjXRdKdt9eAr1OGtwqMQpzABmiriIuPNznisVLlYzZ9XbLR+mhDWYpGp3s+Ty15A+nuUNDC+vz+EtRRY/C0yQgYgXQG+jPW+5TPFSaMvEZIRTwvgDSYtw9ZTr+ZDElia1XtKXyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272157; c=relaxed/simple;
	bh=FlF2US4rsEJYg2ZBuZxi12UiGfIbY4thhuVo0jjaL/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuT+7yTR+hnLrXJlyoavlCAUMUsBWAuPFTYwKzDEIphDSktTD3NmrzTixMq7KtUGAM36Bji77wE31itX1/rhdX49CjSIRO0hgHytBZOiKH8/bTNW/H6CM0hQ74wgvTrXnk6L1eMWX/8fZy22uuXMF4e7rJtD3PXtv44LcqOV5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdjEynv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64719C4CEF4;
	Fri, 15 Aug 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755272156;
	bh=FlF2US4rsEJYg2ZBuZxi12UiGfIbY4thhuVo0jjaL/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdjEynv8LLvUi9xFftCeCIkzln4bNUIOGp3TTOFiYRL6gBrRvfZjsTRpW4pTb+TNJ
	 xkT28sCnCGpxUfP930MJUZqnH7t+ZVQkVl5McU+i1Gzjp2scwlmF7sHDeg/eqnbs5t
	 aJ1A6K9utjphZ0xZlhccmmEo7k0t7CAjPUSJfDz9wR2BqD+LyiZuWi6pI8j9tG/JdL
	 i+DHOVc44yz+U5Olu0DY+UIhAvheD1SHErjPpM7NyTijUBiNtvhIKr15w9qm32q11/
	 kUQdhVg8scX8hM3vUM2tsA9SCsxeDiF4qV8lA5r0wjX7IA4OB2EAF8MK2IU8nkIlvP
	 REG8Zby0aXvXg==
Date: Fri, 15 Aug 2025 08:35:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>, <jasowang@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tim Gebauer
 <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
Message-ID: <20250815083555.0bc82c09@kernel.org>
In-Reply-To: <f16b67e6-8279-4e52-82ca-f2ea68753f70@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
	<20250813080128.5c024489@hermes.local>
	<4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
	<689dfc02cf665_18aa6c29427@willemb.c.googlers.com.notmuch>
	<f16b67e6-8279-4e52-82ca-f2ea68753f70@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 18:23:56 +0200 Simon Schippers wrote:
> Important note: The information included in this e-mail is confidential. 

You really need to try to get rid of this footer if you want to talk
to an open source community.

