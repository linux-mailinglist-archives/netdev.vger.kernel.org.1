Return-Path: <netdev+bounces-38706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BC7BC2E8
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FC4281F0A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78F45F7A;
	Fri,  6 Oct 2023 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezPcYymp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC0ED5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7EAC433C8;
	Fri,  6 Oct 2023 23:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696634916;
	bh=f5eweFB5hd+xL6C7jrCKOvGvrLEavAJkP3G3+xCH9sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezPcYympZev/th+LBy9uF0GsqZCUFNQFiJNcub94b15mhHWP52Xg7V0T//Is3MdmH
	 BT+Vvlp1nD8n/r64ZriB5nWBsRgM765u/CjF+9vw/pSHqtR5XGo1Xw09c9IcZ7FgU8
	 7W0rU/TBUnn2XY1ftVOC5Or4gevTjWzpO0vTYqAtZ2YfPzoLSsyVoGfwq3GB1HTXAr
	 txpi2BajhHUjRK00GC/6iya7g9zdK2X8fddu+CRtfsMqqw4CvYflbo7qf/m/hViSMj
	 u/j7hfiGHUdJn5hTZXD+T4LVkVFv3fLCFWFbDq5zigGGamxv+A7mLHYJR75Nhldjpf
	 WfwoB2K+N2geA==
Date: Fri, 6 Oct 2023 16:28:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: 3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock
Message-ID: <20231006162835.79484017@kernel.org>
In-Reply-To: <20231005074858.65082-1-dg573847474@gmail.com>
References: <20231005074858.65082-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 07:48:58 +0000 Chengfeng Ye wrote:
> As &card->cli_queue_lock is acquired under softirq context along the

you say softirq here

> following call chain from solos_bh(), other acquisition of the same
> lock inside process context should disable at least bh to avoid double
> lock.
> 
> <deadlock #1>
> console_show()
> --> spin_lock(&card->cli_queue_lock)  
> <interrupt>
>    --> solos_bh()
>    --> spin_lock(&card->cli_queue_lock)  
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on the card->cli_queue_lock under process context code consistently
> to prevent the possible deadlock scenario.

and irqsave here. I think you're right that it's just softirq (== bh)
that may deadlock, so no need to take the irqsave() version in process
context.
-- 
pw-bot: cr

