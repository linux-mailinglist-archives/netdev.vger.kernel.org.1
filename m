Return-Path: <netdev+bounces-206277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45293B02741
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE231C85A96
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285D21883C;
	Fri, 11 Jul 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjmv2Nma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEC1F8753
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274508; cv=none; b=Ik93wtNMuxS30MEI3CaZP2K4qOwX+M9piLmsys0BvqotC8ck/b8jG6L3gSxxjeamwrkGnMXpdLFaPZVK5y3SMhaxDKvHSft/vik7CzZnBPNWgozVpDGtU+jSi7/0wwJv2ktHKydN4mwNPL/btzxP4YgYqJifhqeeFSOA9JGQCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274508; c=relaxed/simple;
	bh=HEKZfpRkIsfMTw0VbZyXcU8BMmLR1OdTiN+k7zqLJcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAZkiSPc2iyXJPgdS1k20r4ovf0fHFV7havqK2MtnSDMUt0/dfbdb8FVUOZKhU/vSIPSZ3UZrh4+iniTW7GQkvL5cD8xQZtjHNDPUqGys8eS4FlUOyo3iilZ7lwa3u1w7Rfv1r+bWB0Zreed2Mmhd5w2GRiiJPZ9IXL3U5+C0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjmv2Nma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB6AC4CEED;
	Fri, 11 Jul 2025 22:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752274508;
	bh=HEKZfpRkIsfMTw0VbZyXcU8BMmLR1OdTiN+k7zqLJcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qjmv2NmaWdDa+l9pKK1wRneUpEEc/I98xiWx+Enx1jP5j6gc+Yho0GIZJecQtGG95
	 AIGjIEshD9imogqUIuD/zEpMQSNJ1i144cvm/dcMKcc/GdDtUHeolatiOdVdigLhay
	 SxXicVvdH6B+PmBhCPQjw1pU2lH6Yqlp4HwnRrrf+rqTMntlH3qwtMjeclgHZaF5ZV
	 9pSRrmQ0BTfOGTk7p/hpZHA3lSeVEzWMN2P3m37xuf1CrqqmZmOapHZ4wVUMw9a5jb
	 pcPkoPPzabmFJhvJl6GGUW04MJpz4e8RqJwXg58aPcqRBCUMXJExqHR00m947oO1un
	 wDylyDLww87pQ==
Date: Fri, 11 Jul 2025 15:55:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
 stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net v5 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <20250711155506.48bbb351@kernel.org>
In-Reply-To: <20250708164141.875402-1-will@willsroot.io>
References: <20250708164141.875402-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 16:43:26 +0000 William Liu wrote:
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue, as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.

We already had one regression scare this week, so given that Cong
is not relenting I'll do the unusual thing of parking this fix in
net-next. It will reach Linus during the merge window, hopefully
the <2 week delay is not a big deal given how long we've taken already.

