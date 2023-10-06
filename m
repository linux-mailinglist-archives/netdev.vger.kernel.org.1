Return-Path: <netdev+bounces-38571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB37BB763
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CC3282285
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CEC1CF9A;
	Fri,  6 Oct 2023 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sswhgY8L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40081CABE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F328DC433C7;
	Fri,  6 Oct 2023 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696594425;
	bh=lCCWh4f6IaqpQgRiJ2QFH4TRyVDyZ0dvh7l68dHWWQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sswhgY8LCLD8W8konCq+UQpIaZcPSc+0bUD6ivQ2AMhfgWYTVf0Z/MZLQVVTSVE9V
	 4751BqhCmd16f1RnyVR0NTbkxD1fdO5RHj1LUMX9ZBzqUCjsi0reSJOkloGfUOJoEi
	 /78cbndpmgZpEAutOQQKJwAgMw9IPCkAczOyBfM17d+yIXlx/qFdoJkytSQCRTfTkg
	 Z7wWpfac0LRsTdU6UJD9Hc7/uGWi1XB5v/kaoN+xOD94+mKHOJPhFed1gEgjYsfmZF
	 9bJoDFgWLvTbw/5epeJfdZqgTQ5sYGzijSihZMRFUno03u1jFnJ0zjLonnFWMHmbEi
	 Nqi20yrad0nKg==
Date: Fri, 6 Oct 2023 14:13:41 +0200
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net] i40e: prevent crash on probe if hw registers have
 invalid values
Message-ID: <ZR/59YSFavmHAHC7@kernel.org>
References: <20231006111139.1560132-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006111139.1560132-1-mschmidt@redhat.com>

On Fri, Oct 06, 2023 at 01:11:39PM +0200, Michal Schmidt wrote:
> The hardware provides the indexes of the first and the last available
> queue and VF. From the indexes, the driver calculates the numbers of
> queues and VFs. In theory, a faulty device might say the last index is
> smaller than the first index. In that case, the driver's calculation
> would underflow, it would attempt to write to non-existent registers
> outside of the ioremapped range and crash.
> 
> I ran into this not by having a faulty device, but by an operator error.
> I accidentally ran a QE test meant for i40e devices on an ice device.
> The test used 'echo i40e > /sys/...ice PCI device.../driver_override',
> bound the driver to the device and crashed in one of the wr32 calls in
> i40e_clear_hw.
> 
> Add checks to prevent underflows in the calculations of num_queues and
> num_vfs. With this fix, the wrong device probing reports errors and
> returns a failure without crashing.
> 
> Fixes: 838d41d92a90 ("i40e: clear all queues and interrupts")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


