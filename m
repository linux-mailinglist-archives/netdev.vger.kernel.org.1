Return-Path: <netdev+bounces-62342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B8826B7B
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936661F23335
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CD134BC;
	Mon,  8 Jan 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnKs5Wfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7113AC7
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 10:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A34C433C7;
	Mon,  8 Jan 2024 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704709169;
	bh=RC/4Rzl9yyzT26ww+hvWkvndAuZUIarzXNlB/yck2l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnKs5Wfr5E824LwK5rJmKltzxIhzUE5kMyIUuvasjcuf8A1Zgfs0cU66Zq2U3CHG2
	 RKbuAAsxcjQ3Bgf39NaOdhEgkgVNO/DrgaEGVvfzarMa4cO89lFO+OBLwf7ZdtzIZM
	 GwqEHPVEZc4gWqKJzwM8p1Mv3fzord4Hjf1ov8F039O0IzY1COkolTzpWFjLCzR2+V
	 C5/5bGfBOg6OT/Wz0gdRfiUC47ZpiXVHxwHAF3So+nGAx7j84L2BpwmdTm86/BQn9/
	 myYO990RGr8BfgwafSPvfomcEPhTWHV/Hios8UUF8sJqMIEuptvE++UkLmdP8Y0rRL
	 rSK1zDv35y+Ng==
Date: Mon, 8 Jan 2024 10:19:25 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 3/3] bnxt_en: Fix RCU locking for ntuple filters
 in bnxt_rx_flow_steer()
Message-ID: <20240108101925.GC132648@kernel.org>
References: <20240105235439.28282-1-michael.chan@broadcom.com>
 <20240105235439.28282-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105235439.28282-4-michael.chan@broadcom.com>

On Fri, Jan 05, 2024 at 03:54:39PM -0800, Michael Chan wrote:
> Similar to the previous patch, RCU locking was released too early
> in bnxt_rx_flow_steer().  Fix it to unlock after reading fltr->base.sw_id
> to guarantee that fltr won't be freed while we are still reading it.
> 
> Fixes: cb5bdd292dc0 ("bnxt_en: Add bnxt_lookup_ntp_filter_from_idx() function")
> Reported-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/netdev/20231225165653.GH5962@kernel.org/
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Thanks Michael,

I agree that this addresses the issue flagged at the Link above.
That it is a bug-fix, and should have a Fixes tag.
And that as the cited commit has not propagated beyond net-next
it is appropriate to target this patch at net-next.

Reviewed-by: Simon Horman <horms@kernel.org>



