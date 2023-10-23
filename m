Return-Path: <netdev+bounces-43661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B207D42E9
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB141C209E3
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC222337;
	Mon, 23 Oct 2023 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/ZQMPtf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D91B27E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 22:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158DAC433C7;
	Mon, 23 Oct 2023 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698101595;
	bh=2p2vYId+/XkAtr85GFeTQzGPwyHJushD8tZW2QZ/NCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/ZQMPtfTk56Ys0Dbu0IxS8q5MWeRF0Do42hnKDF2NObWX8rz3+qy4jA02r7dZ6Xs
	 w0v2g3rnNrL66Ak7jZAiSeLaUp0tpW3phpaF4ILKGez5gaX+Rd0c53i7omLjVFrwbb
	 PQGOQBtPpN7x6afTja9y8fQSUJ8kDRVZWJ8F+ralL99LM7rGZQLOGXP4UHg3i70IBg
	 75MbecLbZZdzpSYihBW7LYvjciHOYOvIH7gzoOpX9i/O5SzrJgi9NyhEgjO8JRbXJ5
	 PxpIAaA7cK/xzk1ANn6/sA39le33Uw+I3I31PO1uqLfZi77U4zeR3FUObDwgwbxOHM
	 RYeS2uXPXeL8g==
Date: Mon, 23 Oct 2023 15:53:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] tipc: Fix uninit-value access in
 tipc_nl_node_reset_link_stats()
Message-ID: <20231023155314.50b13861@kernel.org>
In-Reply-To: <20231020163415.2445440-1-syoshida@redhat.com>
References: <20231020163415.2445440-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 01:34:15 +0900 Shigeru Yoshida wrote:
> Link names must be null-terminated strings. If a link name which is not
> null-terminated is passed through netlink, strstr() and similar functions
> can cause buffer overrun. This causes the above issue.

If strings need to be null-terminated you should switch the policy here
https://elixir.bootlin.com/linux/v6.6-rc6/source/net/tipc/netlink.c#L91
from NLA_STRING to NLA_NUL_STRING, no?
-- 
pw-bot: cr

