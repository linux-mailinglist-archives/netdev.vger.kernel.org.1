Return-Path: <netdev+bounces-28675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064C7803BF
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D262821BB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3B64E;
	Fri, 18 Aug 2023 02:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A322398
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E53DC433C8;
	Fri, 18 Aug 2023 02:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692325106;
	bh=jg9PCZFEO/EbHzNEzSo1Zkc7QUTIqz+kOlAheDVPUTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sYHtC3vuDGTQtiueKdicqJw+hX4YsAZkSD2X8vj3n4TkvRCgbgj8+xv2SUbp5B4/+
	 4bZSb6C/h73+kNiXP1D3mB3g2yKC1Z12Q4/EryvSfHu560lzdpBDULS8kB1nMzFTtb
	 TcrBjPBJg4DkRgeBGEAdj7DMcJDlo2mqHw74ZcTxvBDLhyt1MFKZ94dm618v26u4gS
	 RksqMg+mZmUeXecLL5wbjV5HP6ezubO4+NPGoQJBa/BALs5ZLhMgJ6Z7CDY8vrJN8S
	 DC6Q23hwJxuULHRq5kmOaI3GIQ9pFyX55Dv50X/zgmMzd7H2j5WXmYwrSozAB2+0Tk
	 Xwo9XAOH3dQ0Q==
Date: Thu, 17 Aug 2023 19:18:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, Naama
 Meir <naamax.meir@linux.intel.com>, Sasha Neftin <sasha.neftin@intel.com>,
 Simon Horman <simon.horman@corigine.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [PATCH net-next v2] e1000e: Use PME poll to circumvent
 unreliable ACPI wake
Message-ID: <20230817191825.18711c80@kernel.org>
In-Reply-To: <20230815170111.2789869-1-anthony.l.nguyen@intel.com>
References: <20230815170111.2789869-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 10:01:11 -0700 Tony Nguyen wrote:
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> On some I219 devices, ethernet cable plugging detection only works once
> from PCI D3 state. Subsequent cable plugging does set PME bit correctly,
> but device still doesn't get woken up.
> 
> Since I219 connects to the root complex directly, it relies on platform
> firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
> works for first cable plugging but fails to notify the driver for
> subsequent plugging events.
> 
> The issue was originally found on CNP, but the same issue can be found
> on ADL too. So workaround the issue by continuing use PME poll after
> first ACPI wake. As PME poll is always used, the runtime suspend
> restriction for CNP can also be removed.

Applied, thanks!

I'm curious - why not treat it as a fix?

