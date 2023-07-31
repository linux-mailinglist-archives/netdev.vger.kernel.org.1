Return-Path: <netdev+bounces-22891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E6769C83
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C828163B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F32918C16;
	Mon, 31 Jul 2023 16:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270A19BD8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBDAC433C7;
	Mon, 31 Jul 2023 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690821061;
	bh=KAsyPQEGy6Z/bBlXO17Vfwfry3I9OYRD8CJVoXJ2qqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzgn2zD/rBDgFeT/2Ydh7vlAuqNqBsm34ECdurZaWHp5OTFRj3uN/bB0dzE95eKzG
	 3j3vwGiAe8IyCcFF0tHwbzRE/yiptf5T/GHVNPBYI1WZ28nGvwGPb3zL1XMLt8+qkK
	 0SmgqhekCPQEOTs6EHOxOf7s32cOlFOSMHclmWzufGLH66LDNrvcctkst6MRkARCtj
	 zrCBF8YCSOisDhEavXJKMXp5kNAg+CvXpaxXFV8zZKn5c/HVDRwG3bWRUvVL0k5/UD
	 6pnXyiWYpTbsWolDYWAzMNWuIChwguu7fVq+OCsbygZCEClE1HQtOvEwuD8h8h3Klj
	 EPTrDxlrcb0UA==
Date: Mon, 31 Jul 2023 18:30:58 +0200
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Subject: Re: [PATCH iwl-next v3] i40e: Clear stats after deleting tc
Message-ID: <ZMfhwh03CYvRuybr@kernel.org>
References: <20230731135218.10051-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731135218.10051-1-jedrzej.jagielski@intel.com>

On Mon, Jul 31, 2023 at 03:52:18PM +0200, Jedrzej Jagielski wrote:
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> There was an issue with ethtool stats that have not been cleared after tc
> had been deleted. Stats printed by ethtool -S remained the same despite
> qdisc had been removed, what is an unexpected behavior.
> Stats should be reset once the qdisc is removed.
> 
> Fix this by resetting stats after deleting tc by calling
> i40e_vsi_reset_stats() function after destroying qdisc.
> 
> Steps to reproduce:
> 
> 1) Add ingress rule
> tc qdisc add dev <ethX> ingress
> 
> 2) Create qdisc and filter
> tc qdisc add dev <ethX> root mqprio num_tc 4 map 0 0 0 0 1 2 2 3 queues 2@0 2@2 1@4 1@5 hw 1 mode channel
> tc filter add dev <ethX> protocol ip parent ffff: prio 3 flower dst_ip <ip> ip_proto tcp dst_port 8300 skip_sw hw_tc 2
> 
> 3) Run iperf between client and SUT
> iperf3 -s -p 8300
> iperf3 -c <ip> -p 8300
> 
> 4) Check the ethtool stats
> ethtool -S <ethX> | grep packets | column
> 
> 5) Delete filter and qdisc
> tc filter del dev <ethX> parent ffff:
> tc qdisc del dev <ethX> root
> 
> 6) Check the ethtool stats and see that they didn't change
> ethtool -S <ethX> | grep packets | column
> 
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


