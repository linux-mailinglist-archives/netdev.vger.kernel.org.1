Return-Path: <netdev+bounces-44043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F027D5EC2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B43B21064
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DAE47362;
	Tue, 24 Oct 2023 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJcuZwZu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A1749D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1BEC433C7;
	Tue, 24 Oct 2023 23:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698190956;
	bh=aiYhbmrlIuol8YL/9R71QSQsHGBEbtI8zzJuBSvMuDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJcuZwZu3hmX5ZhHGFZKbc2lufST7gGLGTh5TA5QomuJZof645g6oAmLpR5+s88Vl
	 Bojr6AzEFv0kqzv90J2PALnjeRNqSBu1ZZnrXKKiFfbUmq4TUnWV2EXZQFOTxl7C6Y
	 69o7FAELjchbXMKmPdYAd1bFApFdkD11bBs2A6T6OLPcEJmCCaGO+1liCJgZwlb+Rl
	 3UU0QBFI3Dr5sPke6LTrCNcbD1kZVO4ZJY3ohQUpai/Iseyh8BCb8gHmWrc/Shz10S
	 7VHe3VKQ7+rVs9RfyM8ICX8RRAT2SzhJvUNtAIwSs+NEK5EH7y92zJx65Gow+g7zqs
	 4p7sAK1BCLhrA==
Date: Tue, 24 Oct 2023 16:42:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, Michal
 Schmidt <mschmidt@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 4/9] iavf: in iavf_down, disable queues when
 removing the driver
Message-ID: <20231024164234.46e9bb5f@kernel.org>
In-Reply-To: <20231023230826.531858-6-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
	<20231023230826.531858-6-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 16:08:21 -0700 Jacob Keller wrote:
> From: Michal Schmidt <mschmidt@redhat.com>
> 
> In iavf_down, we're skipping the scheduling of certain operations if
> the driver is being removed. However, the IAVF_FLAG_AQ_DISABLE_QUEUES
> request must not be skipped in this case, because iavf_close waits
> for the transition to the __IAVF_DOWN state, which happens in
> iavf_virtchnl_completion after the queues are released.
> 
> Without this fix, "rmmod iavf" takes half a second per interface that's
> up and prints the "Device resources not yet released" warning.
> 
> Fixes: c8de44b577eb ("iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set")

This looks like a 6.6 regression, why send it for net-next?

