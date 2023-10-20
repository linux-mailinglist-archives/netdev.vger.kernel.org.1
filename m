Return-Path: <netdev+bounces-43155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57887D19B6
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AFF1C21003
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52235516;
	Fri, 20 Oct 2023 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHd3rG2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7A35507
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 23:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F09C433C7;
	Fri, 20 Oct 2023 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697845887;
	bh=+C8SywAtuLWun+lQt8i6BXrJYmp4V7Mb9eDL4qkunag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VHd3rG2mrnIorHLZ1G5bIu6pahJAxOiT2fRlK4v7pl7I/FtTqkGgYUWTp4/x43tzW
	 WmSJ/qfTp1osFWFvb7aRsO7UvfcM4KdYl+zqUZNM71/5qIbcqhKVfoJ9krwH6JAsYF
	 0dEFmrW+ViI6CqjjW0kWh92g8pVWgtK46LBpO9awVBEoAs5ZH13aNJxU9I3eRAozkv
	 FPss69aoDuphPJPtoWMZSefhTymKzcu4aB6usigfOKpWzfMdDFT/q7qamwLCmfEYeR
	 0ZiVKtU0a/rOoKvoUMJrom9aYBnVNLdd/SlSSbcO5rq9KYOglmIgXZxqeoVIrnnc94
	 Yjignuqtgi/TQ==
Date: Fri, 20 Oct 2023 16:51:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Sudheer Mogilappagari
 <sudheer.mogilappagari@intel.com>, Jeff Kirsher
 <jeffrey.t.kirsher@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net] iavf: initialize waitqueues before starting
 watchdog_task
Message-ID: <20231020165126.03bb9eff@kernel.org>
In-Reply-To: <20231019071346.55949-1-mschmidt@redhat.com>
References: <20231019071346.55949-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 09:13:46 +0200 Michal Schmidt wrote:
> It is not safe to initialize the waitqueues after queueing the
> watchdog_task. It will be using them.
> 
> The chance of this causing a real problem is very small, because
> there will be some sleeping before any of the waitqueues get used.
> I got a crash only after inserting an artificial sleep in iavf_probe.
> 
> Queue the watchdog_task as the last step in iavf_probe. Add a comment to
> prevent repeating the mistake.

Applied as 7db31110438 in net, thanks!

