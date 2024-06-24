Return-Path: <netdev+bounces-106253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3219157FC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71221F2229B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196061A08A6;
	Mon, 24 Jun 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agt+/9HC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8A1A08A3
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261041; cv=none; b=qONMal70MS3KdGEb9HRlkoelaYLHowpk/xyYzFuZPC0cVnZpAbjegJ9kPPVteN7weZno1gnV9RtEcC/Qai+aKISrasBh3wad+4TCcHn0LVOZQ+eH1MEV9laF1P78t3ANR8Sa9ytQC/Q8WBG7SRv3YGzVX/mnpUKwBoTFq14YKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261041; c=relaxed/simple;
	bh=zlGCJgmuRteJd8iDFvxEB/63Ubr5MAFPQ7VsVhXNcTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1fVVqWBnlojUdmM/Y4/LF0tlc2zPzEauGVyZG4wolVPYFc2Zerj+m8v6Ko7SsYPRkHN11XiKL5+SKcwOXkGQ4J9ibWOdlVGrKLMv2jYyPuHvTgzXH9sx/e38vYYkp70rpzqMyyoWPAXM2L3BBvIzHQuviF1onPzJoagsYA1Gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agt+/9HC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1830FC2BBFC;
	Mon, 24 Jun 2024 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719261040;
	bh=zlGCJgmuRteJd8iDFvxEB/63Ubr5MAFPQ7VsVhXNcTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=agt+/9HCct4u9Bpv7ProvvXU7V5sAN8q0Uj0GohXAqr8TCmAF1FGWzZqi8fJ0Rh+F
	 yfLe76t7W0ssznxd314ERCWKY1O+s40os+JY5RnZLbMcbw4sM7n65zoe3/6j9YtlH8
	 drfyu7svoRBsa3GoB0nS1sZs+hETVwgi/8s3jwTM9sOvtjxaMozMpPYLajZF3R6ZE/
	 5ISb7iacp4e0p42Gshe2rTR9W8EP2GvzhzxU6eM8AqbgM4AY4K65oteS6ya8AfSn4v
	 ei0iZ6Gg+o2ROvs6IajSFbqxFwk3Ubshqxu7wBduG7F3ZhBOTrtZL6sMk5fUn41rJl
	 CwfMzezVZSXWg==
Date: Mon, 24 Jun 2024 13:30:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/4] vrf: fix source address selection with route
 leak
Message-ID: <20240624133039.5b0eb17c@kernel.org>
In-Reply-To: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:07:52 +0200 Nicolas Dichtel wrote:
> For patch 1 and 2, I didn't find the exact commit that introduced this bug, but
> I suspect it has been here since the first version. I arbitrarily choose one.

I think this breaks fcnal:

https://netdev-3.bots.linux.dev/vmksft-net/results/654201/1-fcnal-test-sh/stdout
-- 
pw-bot: cr

