Return-Path: <netdev+bounces-189400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD63AB2024
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA08B7B9121
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290C239E8F;
	Fri,  9 May 2025 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcFRwd55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94751372;
	Fri,  9 May 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746831639; cv=none; b=FCbyiq8BpWxEQQcR87O63rulTMtMy5y8QwspYH0BzW6EfAPEYUl8SsTcad+9cmjEPSZGo9BqlibFt6OssBJ/3jgnre8OcdTpAiFC9qwnFh/NFMYfBoS5T+q56+88ttQ8hxROZ4XQyZ7w6CcWj9xZ6cn9eO0vMBgjDw8+DHUoCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746831639; c=relaxed/simple;
	bh=l1b0hhH0EUld+vdPUV/LGnnuFlGIRsgXz3uXBFxHD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM8e1ufUv7LWqZq333Kmq6WzfIrP9qzM/8rS1E5QQ9bVYfWveuFiy9ZGi0RlU27+c0rgK42gyZvlFQbOARLLgzqFU0qi3TZikwh1SspcgXagCv5WfnDqD4xDvbSNYZJi442bLXtpasReIXyjP1XsPXgvijUW9OVFQ1FZ5Tr9LV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcFRwd55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E500C4CEE4;
	Fri,  9 May 2025 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746831638;
	bh=l1b0hhH0EUld+vdPUV/LGnnuFlGIRsgXz3uXBFxHD4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcFRwd55yeYXX36OuTVZ+BcvfXXKRbfWm9AZhozhiJ37pke8B1fpPAl1ZnmQaoDpH
	 rt+kLeH0DFbTA8stPvgp/7G/kA1j1LdwAhxkheGYKyClF3Egg6q2rpMjCnRZxVw6kJ
	 RhdHOI+Ci2a6WIFwGp4hq4c8hOfDsw5gGCbBrBrzHndKCskoq0zErWwK/V63+4Ghlc
	 /WPK0e6zgEw280Hq62opyXw1AyNq3vbZoCQAPCUAIvCnbFRRFf3w8nrTzpU6tWv7Tf
	 W/NI5KSCHb82TXaeYXuRn1SCXE82KCcBHSjzFP8UwpuWqX+d1FIIOO8Xwja/Su7DPv
	 WsCowc11iv4TA==
Date: Fri, 9 May 2025 16:00:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>, Jani Nikula
 <jani.nikula@intel.com>
Subject: Re: [PATCH v9 00/10] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <20250509160036.50d629f9@kernel.org>
In-Reply-To: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
References: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 May 2025 11:53:36 -0400 Jeff Layton wrote:
> This one just fixes a typo in the ref_tracker_dir_init() kerneldoc
> header. I'm only resending so the CI will pick it up.

We got a bunch of:

[    0.457561][    T0] ref_tracker: ref_tracker: unable to create debugfs file for net_refcnt@ffffffff92da4870: -ENOENT
[    0.457561][    T0] ref_tracker: ref_tracker: unable to create debugfs file for net_notrefcnt@ffffffff92da48f8: -ENOENT

[    0.973191][    T1] ref_tracker: ref_tracker: unable to create debugfs file for netdev@ffff888004d0c5a8: -ENOENT

[    1.150784][    T1] ref_tracker: ref_tracker: unable to create debugfs file for netdev@ffff8880053fc5a8: -ENOENT

[    1.660680][    T1] ref_tracker: ref_tracker: unable to create debugfs file for netdev@ffff8880085f95a8: -ENOENT

in the CI at boot. Presumably init_net and loopback.

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/113741/vm-start-thr0-0/stdout

