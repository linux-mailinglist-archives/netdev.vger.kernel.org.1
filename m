Return-Path: <netdev+bounces-31657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C2C78F6AE
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA54C1C20B0E
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47510FA;
	Fri,  1 Sep 2023 01:28:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE710E3
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 01:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0925BC433C7;
	Fri,  1 Sep 2023 01:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693531681;
	bh=wfKITlhsoQmivTcQnEhF6jPQbiuN6NmrSQ2Hh7h3Qw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gfZJ0y0KEMzMGUTLDIoB3W5mwXa9hIZHdwdg9OdFt+sno/Yf5W6BE/UnOr6hvslR0
	 Scu3llwRnQLLdEqu9EQSURsHaKa0kk3eoAA8cCF252uYas/CNVvE3nPLbPSA+TA6SN
	 9QCZpLzPmDKNVEgcgf+k2Us6hoJg7j/vSM9VzE5hPbWVxraMkLJ+1XlJmfJpee06P8
	 4vuhTF5bDQxalTeH1qg5NMCQQRD+QRbk8/uRVqpEK2BtduMRxigZUg2kaLL2e02BBS
	 84oPqXL0ZgDEEROP0xkruzCsXu0WScYKukNsTsB2+Z50ALNN/MgqQxrm4RjuNQ3aR5
	 iNq011wzXBEHA==
Date: Thu, 31 Aug 2023 18:28:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: joao@overdrivepizza.com
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 rkannoth@marvell.com, wojciech.drewek@intel.com,
 steen.hegenlund@microhip.com, keescook@chromium.org, Joao Moreira
 <joao.moreira@intel.com>
Subject: Re: [PATCH 0/2] Prevent potential write out of bounds
Message-ID: <20230831182800.25e5d4d9@kernel.org>
In-Reply-To: <20230901010437.126631-1-joao@overdrivepizza.com>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Aug 2023 18:04:35 -0700 joao@overdrivepizza.com wrote:
> The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
> unsigned int num_actions (line 10) and later traverses the actions in
> the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
> 
> Within the same file, the loop in the line 24 compares a signed int
> (i) to an unsigned int (num_actions), and then uses i as an array
> index. If an integer overflow happens, then the array within the loop
> is wrongly indexed, causing a write out of bounds.
> 
> After checking with maintainers, it seems that the front-end caps the
> maximum value of num_action, thus it is not possible to reach the given
> write out of bounds, yet, still, to prevent disasters it is better to
> fix the signedness here.

How did you find this? The commit messages should include info
about how the issue was discovered.
-- 
pw-bot: cr

