Return-Path: <netdev+bounces-133399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75825995CE9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3332F2821DD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CFF1F947;
	Wed,  9 Oct 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyX8NKAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73111D69E;
	Wed,  9 Oct 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437000; cv=none; b=Ng/qXHdmOR7Il2ZjPyfciLct6Xyiq3XD0At3ZMc0+69+8Y0FR9Ks5LpNpVClfHGEXN3tNVFCgIrQvRRNQKMx9/ZG5xtrZnhLpLoTXm36NoocS1hBtuhy/dUUndJLhWRwLOcpl1npibMLNo4kqwWI8F2M2dAOerNycqB2c0xF8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437000; c=relaxed/simple;
	bh=wTCYdKXrgiQ4lcB+fld8z2feFjjA0DF0+kpsDIKbrD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2FjXc8/51E778e1NtEmYuFn8zd32bCqqtdUzogEkkxoTMHqRLiRGM0oInkirL6j15cSh3BuVRE1tbHw2jrlwGExpEMd+d4VKI+HUm0XaAgSOVsY0F2CYEuEilpc4VgRWhgkPEy0vKOLVQOCYrrs3rgqf5qEN6CX3ZsDzL4dAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyX8NKAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D7EC4CEC7;
	Wed,  9 Oct 2024 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728437000;
	bh=wTCYdKXrgiQ4lcB+fld8z2feFjjA0DF0+kpsDIKbrD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyX8NKAifQyJI/fQbBRliIl7CI8rjLJgM2ba06M+lUToiTCeDOgbAFSqwkop74sP0
	 odZjCIjb7JhJ3H6iaMJfZn2gctiPWXV66DntlQakHuoPC1ptcFtcw3+vkV5jMpjNUk
	 H58oyH/tWaU4EEYt8XRut8lZAvIfYFz6uvTGzqdisC+59Tc1cGQMMMPKkoR0jgoDaB
	 CyTL4+28sitHf7kvbH8qRAElzj/OLHsCoERXIw4+y91x71IuduPRBLD3wu09GQz0pH
	 jJy6Uh1cq1OZ5DcpwhgKLnrJj1GqvgBUhofH0bQNH3G4l/TkVKAQWaQMabH66Ua+Dw
	 A2hcLykvZzGbQ==
Date: Tue, 8 Oct 2024 18:23:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH net] pktgen: Avoid out-of-range in get_imix_entries
Message-ID: <20241008182319.0a6fe8ad@kernel.org>
In-Reply-To: <20241006221221.3744995-1-artem.chernyshev@red-soft.ru>
References: <20241006221221.3744995-1-artem.chernyshev@red-soft.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 01:12:20 +0300 Artem Chernyshev wrote:
> In get_imit_enries() pkt_dev->n_imix_entries = MAX_IMIX_ENTRIES 
> leads to oob for pkt_dev->imix_entries array.

I don't think so, at least not exactly. It's legal to fill the array
completely. It's not legal to try to _add_ to an already full array.

AFAICT the fix needs more work.
-- 
pw-bot: cr

