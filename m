Return-Path: <netdev+bounces-125303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE896CB7D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E11F22C79
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D51C32;
	Thu,  5 Sep 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoxFWij9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CB1C27
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494427; cv=none; b=WurIfKsloO2KRDnhc521rTUFka/PDayFfNR0TtefX8WCx8e/iLPDx3uA8p1k3rSN3Vc5AK49L4kDlr1OAjMpOFr97EZzLmMqtxbFzWUB888+KU30HuhX+Jfu+qXQ8ZJ7+kxDwrqDskgg045oUmL7ToC2As5mntXm6/I1YzSEvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494427; c=relaxed/simple;
	bh=8M2GX1/CObipolUaONfrEby9wm4+JIx+oP8chnVE2P4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHmSbzZz7Z1YUsm41B3O5Vx16wqcmaK+eVcivk7dHJVDLO6VxOdQPFpoMJuIS4oOSVs+q7mkUa0RFkycLMMw3CeDklpwFaF+jfC3aBPblZsJ8zhC938nctTp0GZqPtUPbn8EUGRUhXzXUScT7n+gQBtdFt0F5VEeVH7CB/hZ6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoxFWij9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A368FC4CEC2;
	Thu,  5 Sep 2024 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494427;
	bh=8M2GX1/CObipolUaONfrEby9wm4+JIx+oP8chnVE2P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoxFWij920Rlqc3Rx78pnCF/HarYudLIZi5MPWWvNEZJKsG3mob6moeTopd3q7oJ0
	 ArNkDW1IbFVFp3vfMXli3tiwGoisLW0pvQUDshbNAqh3mD1Rp+x98IAjIQftIMBRy/
	 t0X2eP5oU7MO6Sh6FggIFJYg+Kjdum4sb5abql3+N8vTI47IfdUhR0f7Pn20e4kbyk
	 r5qtdGr+n2xz8VS3IYJFmxZd4IkuQN2EFLKNPeKW5ml4l8ImOLV3iqhaUH/kwQk3P0
	 7kPmXaJZ+5AHpddQDbHxqIXqwHiaW98XO0PDVugRMNtjLbpc+r9EwydIi9PceMnNtx
	 K7h8wjR9eVlfw==
Date: Wed, 4 Sep 2024 17:00:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brett Creeley <bcreeley@amd.com>, Li Zetao <lizetao1@huawei.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next] ionic: Remove redundant null pointer checks in
 ionic_debugfs_add_qcq()
Message-ID: <20240904170025.6f785e30@kernel.org>
In-Reply-To: <36f30b18-36e2-4e7c-a801-47fac932b1ed@amd.com>
References: <20240903143149.2004530-1-lizetao1@huawei.com>
	<36f30b18-36e2-4e7c-a801-47fac932b1ed@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 09:36:22 -0700 Brett Creeley wrote:
> For the patch contents this LGTM.
> 
> However, the patch subject prefix should be "[PATCH net-next]" for the 
> first version. Specifically, replace "-next" with "net-next".

That's right, Li Zetao please follow this advice going forward.
Since it looks like CI guessed the tree correctly I'll apply v1.
-- 
pv-bot: tree

