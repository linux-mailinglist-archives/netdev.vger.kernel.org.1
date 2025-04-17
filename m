Return-Path: <netdev+bounces-183805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEBBA92150
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69AC19E6852
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5764253B5C;
	Thu, 17 Apr 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgK+23Lt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F0253B57;
	Thu, 17 Apr 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903318; cv=none; b=rKoPTOwIicb8tcY6ukUo85K01TtPZMYGEgS13MLITsXQQYS/Gb9hMP+IoHdbWps59lD7pguuyip5QjUSjTRDTxrtLrKlepfx9rDLEL/0wiIpJpj0qxvAhY8K2/1AQCOAekrb05sCaayDnSkSXXjVYdUPD6WQdkeMKuoTz1OpgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903318; c=relaxed/simple;
	bh=cTl/FNwNyU4uOfwGRjIHCxzcBYjmq1mf9Lx59yh315M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtkRkQHQD8YJmgaz+UAKi0WC0yQQp0eesnyX4VMXjDwNcH9sPMsSsypD4DMkMu111W6pXRu37s/mjH1z+SjFZT6dlqCelkXXahKeZwTFQ+AhzE2Myf9U/h++sNMaygG97RE761r70nfuQor8KjtIRguFuqHt3dQsWzItMKpU3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgK+23Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540BCC4CEED;
	Thu, 17 Apr 2025 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903317;
	bh=cTl/FNwNyU4uOfwGRjIHCxzcBYjmq1mf9Lx59yh315M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgK+23LtplkVsjB2QOUFXTggU9lAlk1d5uCGHvpmLVzVM/RBzXfNhnjkUOZW8Roae
	 IaMUxPvSeTQS1BcA3KqhP0RVR1py94WfLvfJvJeKLKzluznB5feUw0XwVDpBYv9tRy
	 RcQ4lbs6gZlJoji3Mi9V17xNo3oXO5foH2U/ZnfCcTjYIKNRtHuuBNQfhOuLTCI1oU
	 xd/ChxkYvnVhLId1wxptSBGfv/xIGK5WJBwYR2hJQoTPzWOWJk5Tj95YJegUyy9wUT
	 0TxKGBQcdp5ZsBm++T1hFXHNAT2Ssnxwkt7Y5Yo9sCIBoKZMk0+M2k2NKjYweQk2n9
	 q+lWjtkE+byEA==
Date: Thu, 17 Apr 2025 08:21:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net 4/4] pds_core: make wait_context part of q_info
Message-ID: <20250417082156.5eac67e8@kernel.org>
In-Reply-To: <20250415232931.59693-5-shannon.nelson@amd.com>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
	<20250415232931.59693-5-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 16:29:31 -0700 Shannon Nelson wrote:
> Make the wait_context a full part of the q_info struct rather
> than a stack variable that goes away after pdsc_adminq_post()
> is done so that the context is still available after the wait
> loop has given up.
> 
> There was a case where a slow development firmware caused
> the adminq request to time out, but then later the FW finally
> finished the request and sent the interrupt.  The handler tried
> to complete_all() the completion context that had been created
> on the stack in pdsc_adminq_post() but no longer existed.
> This caused bad pointer usage, kernel crashes, and much wailing
> and gnashing of teeth.

The patch will certainly redirect the access from the stack.
But since you're already processing the completions under a spin
lock, is it not possible to safely invalidate the completion
under the same lock on timeout?

Perhaps not I haven't looked very closely.

> +	wc = &pdsc->adminqcq.q.info[index].wc;
> +	wc->wait_completion = COMPLETION_INITIALIZER_ONSTACK(wc->wait_completion);

_ONSTACK you say? I don't think it's on the stack any more.

