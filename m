Return-Path: <netdev+bounces-227515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F3BB1B1D
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380B516F7B0
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F427F010;
	Wed,  1 Oct 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJyAZdEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901178F54
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350639; cv=none; b=M28xTd7AsLGW3l5Yn4yDPPOHcxA0jh0tZWU0SFfSvGcLsz6v4U4QQ16eQFvtnpDBmvmycHe0m6K0qsI4R5AjexfzoWTa7fNQWljJTnr3TBvdlCbVWCRAeQFBxll/Zr1G6bYkqTUqnG5Lfr2NDTx5dRVzFIk8wHsPp1X4feUcLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350639; c=relaxed/simple;
	bh=lZxKbMnqJYRayTwyqEvuQyl1l+ac79n4DxAadQnyRsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB1gs0wlEg5qb9gag5S3rLeRTd9n/PbxtMmCEazG1d2tqS2PU2bgZJ0KUTtjPMRDpqsA1Gc3d/NyFpzXQ+i5yrTmtLkU9rIUAGTYYa0JVy7bFiKwfculfgtRqqLxhiwEGxSp8NV2S8bYmYhaQYl0xgDSe8XIxntfTKhwU1aWCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJyAZdEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78914C4CEF1;
	Wed,  1 Oct 2025 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759350638;
	bh=lZxKbMnqJYRayTwyqEvuQyl1l+ac79n4DxAadQnyRsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OJyAZdEtMeMUyePm4UJ7+r6/jzAMQDrD8ddgaKao2i9oh6IYLjnFCZNxIxPvLuac7
	 be7tCiDP73L8vquVtwvjighdqLZQ5xHymh2V2/S/vIy2So/+i/N47OwV+0pCc7CVY5
	 bwLnvDW7/hAv7l0nBPhRNCMTHuWSvsEkcrSv3CFcK49efkWnnP8xgQmfhz0lKCuZHQ
	 teQOyr+UKO6/ycQ2p+zgAaqLVqJ3HbTkz+V8v7LDo96SVjikyJD5IFQVj9l3Mhk5TR
	 Ctg6JcsAyGBcoFpKW43AcGm1RrtHGR17iTVmxSetThWfoGVmwC/SNTO+MwVqBAXBny
	 cPx695gLf3dqQ==
Date: Wed, 1 Oct 2025 13:30:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com,
 fw@strlen.de, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: deadlocks on pernet_ops_rwsem
Message-ID: <20251001133037.0ab6952c@kernel.org>
In-Reply-To: <CA+FuTSfnOzbZrztVYX26M6xAd5Y-hP0=Ek7svJpDUSLKApK0aQ@mail.gmail.com>
References: <20251001102223.1b8e9702@kernel.org>
	<20251001185310.33321-1-kuniyu@google.com>
	<20251001122618.4cf31f3b@kernel.org>
	<CA+FuTSfnOzbZrztVYX26M6xAd5Y-hP0=Ek7svJpDUSLKApK0aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Oct 2025 15:33:56 -0400 Willem de Bruijn wrote:
> > > Was there any update on packages (especially qemu?) used by
> > > CI around 2025-09-18 ?  
> >
> > No updates according to the logs. First hit was on Thursday so I thought
> > maybe it came from Linus. But looking at the branches we fast forwarded
> > 2025-09-18--21-00 and there were 2 hits earlier that day (2025-09-18--03-00,
> > 2025-09-18--15-00)  
> 
> Is there a good SHA1 around the time of the earliest report?
> 
> There do not seem to be any recent changes to rwsem, let alone
> specifically to pernet_ops_rwsem.

The first time it triggered when net-next was at 152ba35c04ad
and net at 09847108971a, CI branch contents:
https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-2025-09-18--03-00.html

The previous one (so the branch before the first time it triggered)
had base commits of 6b957c0a36f5 09847108971a.

If you click on the link above you can go back / forward in the branch
contents.

