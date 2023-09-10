Return-Path: <netdev+bounces-32729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772A799EA4
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFEA1C20850
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722087484;
	Sun, 10 Sep 2023 14:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA32586
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 14:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2363AC433C8;
	Sun, 10 Sep 2023 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694355861;
	bh=TBS4jjVKj31VWrF/oBXKhtvtrtiG5o+BNyPunPTFvmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpojpTMqg9l1uHIi9VfwG6NZqwPS9z1jin5cN0syCzbdo2FZoV6crGKBQOnkL23Ki
	 QTZ3uAclB4kD/aI46/VJXtkZN5njGFcvwV7WADdO68ulJyBBDVe0neNrW/+++wvg5R
	 LRNPOrKWxXmr1Y12bAqyNRldo53DFlJXRW+R88Y9VvQY1WMcYz0mN9EEppodIWqeEq
	 yqcb7zCZ53/BTprrtSP8LnZDwLIlcyA3wjXwwGjaGRk8LMGGN4ZQqM6JkzVUWqpMPI
	 FJzZ+thgB7TyB9h7Ez8alJs3IiKJNKhNq0GC9nMIdnMLw+q7qaMjFMip+ZVZahIslF
	 3LQdJusQ+zURw==
Date: Sun, 10 Sep 2023 16:24:16 +0200
From: Simon Horman <horms@kernel.org>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc: intel-wired-lan@osuosl.org, sasha.neftin@intel.com, bcreeley@amd.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	naamax.meir@linux.intel.com, anthony.l.nguyen@intel.com,
	husainizulkifli@gmail.com
Subject: Re: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
Message-ID: <20230910142416.GD775887@kernel.org>
References: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>

On Fri, Sep 08, 2023 at 04:17:34PM +0800, Muhammad Husaini Zulkifli wrote:
> When users attempt to obtain the coalesce setting using the
> ethtool command, current code always returns 0 for tx-usecs.
> This is because I225/6 always uses a queue pair setting, hence
> tx_coalesce_usecs does not return a value during the
> igc_ethtool_get_coalesce() callback process. The pair queue
> condition checking in igc_ethtool_get_coalesce() is removed by
> this patch so that the user gets information of the value of tx-usecs.
> 
> Even if i225/6 is using queue pair setting, there is no harm in
> notifying the user of the tx-usecs. The implementation of the current
> code may have previously been a copy of the legacy code i210.
> Since I225 has the queue pair setting enabled, tx-usecs will always adhere
> to the user-set rx-usecs value. An error message will appear when the user
> attempts to set the tx-usecs value for the input parameters because,
> by default, they should only set the rx-usecs value.

Hi Muhammad,

Most likely I'm misunderstanding things. And even if that is not the
case perhaps this is as good as it gets. But my reading is that
an error will not be raised if a user provides an input value for
tx-usecs that matches the current value of tx-usecs, even if a different
value is provided for rx-usecs (which will also be applied to tx-usecs).

e.g. (untested!)

  # ethool -c <interface>
  ...
  rx-usecs: 3
  ...
  tx-usecs: 3
  ...

  # ethool -C <interface> tx-usecs 3 rx-usecs 4

  # ethool -c <interface>
  ...
  rx-usecs: 4
  ...
  tx-usecs: 4
  ...

...

