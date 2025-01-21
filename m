Return-Path: <netdev+bounces-160130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F47A1863A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 21:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CA116636D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AFA1F708E;
	Tue, 21 Jan 2025 20:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BF1F63CD;
	Tue, 21 Jan 2025 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492376; cv=none; b=HSVQRNxa7LGTwXILc2fEh1mPST5iDoeRQ0kfjTQWTS0CFIJ+H5MJfjJ1HvC0BwIEPA5uhe1ulwFoOCqg/X+dJHpsWWE28g2huRXRiyPRJoVLZSiib3p6ZpGNwKlVGeUNqZq9tTwnTsYFF9Z/bNiAcs1Xan6/1g6IFUzOvh/LZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492376; c=relaxed/simple;
	bh=jxaqIorORSIP4pvfvfqKdOFBjdh5S8kuFhao7raInQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMZ+LoRqzpyyqQxUczBtGd1Io8CBXOKcw6/qFAY+4dHGDN40/84iYjVTjqFLbcqvVL5aGrt90NRZfVnfLFRkZXc9OaGV+8gojVcQzEHk1wGdlVJASa/BPzEdqz0gR9PI1J7N2PZFSw7PCv3LaZ24DOJCAagXw9DCLArC9t34NII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87223C4CEDF;
	Tue, 21 Jan 2025 20:46:14 +0000 (UTC)
Date: Tue, 21 Jan 2025 20:46:12 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, Guo Weikang <guoweikang.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <Z5AHlDLU6I8zh71D@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org>
 <Z4uwbqAwKvR4_24t@arm.com>
 <Z45i4YT1YRccf4dH@arm.com>
 <20250120094547.202f4718@kernel.org>
 <Z4-AYDvWNaUo-ZQ7@arm.com>
 <20250121074218.52ce108b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121074218.52ce108b@kernel.org>

On Tue, Jan 21, 2025 at 07:42:18AM -0800, Jakub Kicinski wrote:
> On Tue, 21 Jan 2025 11:09:20 +0000 Catalin Marinas wrote:
> > > > Hmm, I don't think this would make any difference as kmemleak does scan
> > > > the memblock allocations as long as they have a correspondent VA in the
> > > > linear map.
> > > > 
> > > > BTW, is NUMA enabled or disabled in your .config?  
> > > 
> > > It's pretty much kernel/configs/debug.config, with virtme-ng, booted
> > > with 4 CPUs. LMK if you can't repro with that, I can provide exact
> > > cmdline.  
> > 
> > Please do. I haven't tried to reproduce it yet on x86 as I don't have
> > any non-arm hardware around. It did not trigger on arm64. I think
> > virtme-ng may work with qemu. Anyway, I'll be off from tomorrow until
> > the end of the week, so more likely to try it next week.
> 
> vng -b -f tools/testing/selftests/net/config -f kernel/configs/debug.config
> 
> vng -r arch/x86_64/boot/bzImage --cpus 4 --user root -v --network loop

Great, thanks. I managed to reproduce it (after hacking vng to allow
x86_64 as non-host architecture). I'll try to debug towards the end of
the week or next week.

-- 
Catalin

