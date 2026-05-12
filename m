Return-Path: <netdev+bounces-287071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFJpGgIBA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49951E8FF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F52D3028B7E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27F8349CC5;
	Tue, 12 May 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UK16U9CY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E42BEC2C;
	Tue, 12 May 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581697; cv=none; b=KimJba78sThbg7czJadytGfn8/wt4W6uXoSQDbYnw8Wg8/UG6P9JYg969BUBPUhPV/Qm9GHwDL4/LJ7vi9KqY1ordiF05vdUswOIW4KsZxga9Ld9awbdwjbGnOo4z5M6tDOnHktUQREf1lGUT99t5sB4xCZiFDAQT8mRCZZzPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581697; c=relaxed/simple;
	bh=GjoC7EiQzlvj6IxLbTc6WxOX+ytuXxe+Cd2iXbI7CfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ6FzSXcE4wF3niDtQEj12KL05aRNFEf8rmFHD3HaIvuiFQ99FfdFWywsJ12tI9507SFAeF6K+n9DAIrm9dW3XSxwlHv9M9HH47WfAbspZaZ+SWToKKFfsDXiQ2l1qbORN5TdENw/ghcNI1PcikDsVH/SXWULB91GRCazEhzSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UK16U9CY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778581696; x=1810117696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GjoC7EiQzlvj6IxLbTc6WxOX+ytuXxe+Cd2iXbI7CfU=;
  b=UK16U9CYa9WjK1pwYxwhbKrOIENsyKczXM3PEQwxlsV1t23pknMbcwEj
   uceb9kqK9wKF18MlL3VvfLDEBZ1leICtAHWNn+r/l5jeMBON6uqmc5EWw
   l1sMEosQXVOlOdp0EiNB1ng/9jTeh7BeUKVeCpcw+IC7wEqMtLUQPkyuO
   90BL5mQ3GVsSggkWlHHlUsuGUvEDaVbDZwHME1fVxu/ZEBS3jCV2aibol
   gfhUIvgoiZEqkRbBMLJa0zPP9UtMAn02iem5Ns7f5wUrW1Xq3tYRLCi7Y
   HMCNsuGFoAlEijy5qwdgWASxr/TOOGUy0Klqw95U6HF30ATFRrGrlGjnD
   Q==;
X-CSE-ConnectionGUID: /lc5+Jl+Qi6IuXhkmU5kLg==
X-CSE-MsgGUID: z3GyqZJyTB6v8qSN25BTEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83340168"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83340168"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:28:15 -0700
X-CSE-ConnectionGUID: 2IiUsZW1RVCJItKj4M+oYQ==
X-CSE-MsgGUID: JcNILs/lR/eet94rc1oIUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="239561173"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 12 May 2026 03:28:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4181498; Tue, 12 May 2026 12:28:11 +0200 (CEST)
Date: Tue, 12 May 2026 12:28:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [RFC PATCH net-next 3/5] net: thunderbolt: Move long delayed
 work on system_dfl_long_wq
Message-ID: <20260512102811.GB84797@black.igk.intel.com>
References: <20260511092846.120141-1-marco.crivellari@suse.com>
 <20260511092846.120141-4-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511092846.120141-4-marco.crivellari@suse.com>
X-Rspamd-Queue-Id: BE49951E8FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-287071-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:28:38AM +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
> 
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
> 
> Cc: Mika Westerberg <westeri@kernel.org>

No objections from me,

Acked-by: Mika Westerberg <westeri@kernel.org>

