Return-Path: <netdev+bounces-25551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6CB774A11
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC7D28175E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3A168DE;
	Tue,  8 Aug 2023 20:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEC8F69
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB76C433C8;
	Tue,  8 Aug 2023 20:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691525703;
	bh=TCtXrFHYEWA+RKLYi8IYJJORHPcATd/d5aAGTCm6TLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSrRV9oO8NGfiDpATgcD31qpSkWcOLlbIsgoKwgShZVT4lW1p8xTm+4VyqnCJXK/R
	 VezDqtgBiUH4Yb5hYWsiqISZ/+/M4EXQGaezRx7H6cSgcazUu95oOrOGz3QfzWCm4u
	 vsK+7JTiRoyfKIxH0bhpLurN85no4G22rDWcfJg8Oo1AXacDfpnJnDc6F2RjkgnATI
	 vGyqQ3rTXs6OsV4Gi/bxY50/t7EdZNcuFTIve/4Zk3BngTJ6hEAYGRkKqDx/8gNPC1
	 dmlnG2VEsiDqegCtN8Sh8XYKi0KGoBKW46YgGaFpSMoQaC48pn/XRMPmKOWSApjfzY
	 V+TXGoWNT9Pvg==
Date: Tue, 8 Aug 2023 22:14:59 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Piotr Gardocki <piotrx.gardocki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net] iavf: fix potential races for FDIR filters
Message-ID: <ZNKiQ9vcjNQRfieN@vergenet.net>
References: <20230807205011.3129224-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807205011.3129224-1-anthony.l.nguyen@intel.com>

On Mon, Aug 07, 2023 at 01:50:11PM -0700, Tony Nguyen wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> Add fdir_fltr_lock locking in unprotected places.
> 
> The change in iavf_fdir_is_dup_fltr adds a spinlock around a loop which
> iterates over all filters and looks for a duplicate. The filter can be
> removed from list and freed from memory at the same time it's being
> compared. All other places where filters are deleted are already
> protected with spinlock.
> 
> The remaining changes protect adapter->fdir_active_fltr variable so now
> all its uses are under a spinlock.
> 
> Fixes: 527691bf0682 ("iavf: Support IPv4 Flow Director filters")
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


