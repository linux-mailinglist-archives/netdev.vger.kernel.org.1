Return-Path: <netdev+bounces-179007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F241A79F98
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670D6188EE27
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471624293C;
	Thu,  3 Apr 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvWveUsv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC86242905
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670984; cv=none; b=MB4e/u/3TXn8ZVXxliEGGMaBubneUZy8zYipKX+Uq0Kf9WxjF7uS0VmLpjIFNdAfEmAwpJWP2H2lVtoP97SyoRSdZvkfOHq64Hk2ycabXA/j0O5tTHs59ZNEnCM9eJOiB8lOzvLac7uwMxx8UUFTb5GYCbPbLf8HBmjTdSxbuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670984; c=relaxed/simple;
	bh=IwK4MS54DGo6gvAsVzAvQAS/lf1ea4a/KXUdR+O2tjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1ATNVRq7Hovieuu8hRoA2Gv33DhlWY6+nZMISpt7TtMIJVJw07+AKwnT2yuHzIOQHbAbM7nov3wzf5zHxaR04IigW9pniu8+OVxrVdxu5zZm+ntuXO623derhhN/7ez4Pws+6xvfiHSKn087K0ksgyEvrLjgDTfv1BxmoF+phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvWveUsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C0DC4CEE3;
	Thu,  3 Apr 2025 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743670984;
	bh=IwK4MS54DGo6gvAsVzAvQAS/lf1ea4a/KXUdR+O2tjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvWveUsvqd7+3A+FhNbJYzBOPeKcwOV1GA/2gFXDk+etyXebZNzlz9Iwwyy07nKkq
	 tUjrZao93aTa4tnW+O1vHlLMu0B9MOyWUaT7WDlad93TwO+AGH+iZV4NhIpo7tC9pO
	 gulZA7xsofa+nNEqtMNjIebdSluNNk+C63nqhKloF4hrku15glX+nPW3isHesw9BJ6
	 dZ12N6+hiHV4PcIMN3/e6jawSO9PiPKlaHQzayKuH/bpf9iJpXZpGxOytUeDq5hV54
	 TuEE2lJxBOsC1bD7I78C7Nj7gVkxw7MujK7V7yTLhKVJe2C3B2BZ6T4UE7x+L8qnw+
	 dVAN68q62fkow==
Date: Thu, 3 Apr 2025 10:02:59 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	danieller@nvidia.com, damodharam.ammepalli@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 1/2] ethtool: cmis_cdb: use correct rpl size in
 ethtool_cmis_module_poll()
Message-ID: <20250403090259.GA214849@horms.kernel.org>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402183123.321036-2-michael.chan@broadcom.com>

On Wed, Apr 02, 2025 at 11:31:22AM -0700, Michael Chan wrote:
> From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> 
> rpl is passed as a pointer to ethtool_cmis_module_poll(), so the correct
> size of rpl is sizeof(*rpl) which should be just 1 byte.  Using the
> pointer size instead can cause stack corruption:
> 
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ethtool_cmis_wait_for_cond+0xf4/0x100
> CPU: 72 UID: 0 PID: 4440 Comm: kworker/72:2 Kdump: loaded Tainted: G           OE      6.11.0 #24
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: Dell Inc. PowerEdge R760/04GWWM, BIOS 1.6.6 09/20/2023
> Workqueue: events module_flash_fw_work
> Call Trace:
>  <TASK>
>  panic+0x339/0x360
>  ? ethtool_cmis_wait_for_cond+0xf4/0x100
>  ? __pfx_status_success+0x10/0x10
>  ? __pfx_status_fail+0x10/0x10
>  __stack_chk_fail+0x10/0x10
>  ethtool_cmis_wait_for_cond+0xf4/0x100
>  ethtool_cmis_cdb_execute_cmd+0x1fc/0x330
>  ? __pfx_status_fail+0x10/0x10
>  cmis_cdb_module_features_get+0x6d/0xd0
>  ethtool_cmis_cdb_init+0x8a/0xd0
>  ethtool_cmis_fw_update+0x46/0x1d0
>  module_flash_fw_work+0x17/0xa0
>  process_one_work+0x179/0x390
>  worker_thread+0x239/0x340
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xcc/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Hi Damodharam, all,

I don't think there is any need to resend for this, but I think
there is a '"' missing towards the end of the Fixes tag above.
That is, I think it should look like this:

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")

Other than the nit above this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

