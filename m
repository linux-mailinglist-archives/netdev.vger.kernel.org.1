Return-Path: <netdev+bounces-211543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94246B1A026
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A003C188B168
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD253235044;
	Mon,  4 Aug 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO2MFAYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4A1F4617;
	Mon,  4 Aug 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305494; cv=none; b=N/z3Om6+xJGLP/tT3+f/sM37AHMpxT5QMoC05osjqCOxlxusorJmXA2YIBOCV3QciwZ4uMHHFCWFEnLpc7HSKbhXcl/Bb/dhLr7+6f+lwzeO4Ul0uMJzc4FvoTKoD3Xd4NWuCGK/t+OHT4qkL/s+yKWXpjg/6VXbtiMYKT8vcWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305494; c=relaxed/simple;
	bh=10/pLOWRPJU0Oo19q+XLlnWYwcpDO9ClEBFAyLV+LAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeiDAmTLv6dPxF80asCvgB4jbuazOBxtOKB0iZWutRze2X+SgACxYl52ZGVFsJg0mwbK/xoAw84PqBd6T5rUGH+G9Xq+a5jt+uZnou/sHyHNHfOhm87pE3KxHuPKJmh5Yqjb4x6wwWiQgQTrEaSZx+9K2sjQCAO98fiMtK+l6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO2MFAYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21BEC4CEE7;
	Mon,  4 Aug 2025 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754305494;
	bh=10/pLOWRPJU0Oo19q+XLlnWYwcpDO9ClEBFAyLV+LAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kO2MFAYsk4/xjtcF3GqL5dIwTnALyaQwMKXzrDvsKwjJWdNUmqreSPOcATqA1OhvQ
	 +V4QXY6Ay3R2cIWC1zAHoC2TauXHRpPCbIhF1QaQIws+C9o2CSg0Z3KfeYQ0mLodyE
	 0KQY9nY0hKICU5CyvSQ5zJDznGhH0LB4q39BqRHxdGnUh7aQKObcwW3ZKt5FMbU0Sr
	 yoQV3s924+/rOIAeaHK2H7JMJILDyhbC4ZhENESYPijCg7mkslK0FtIquZqa5WkJ8s
	 1/dmclEteBtf4OoaVtPYEJWD1yyywLApGYIwYlsaWP8CKlc50xfw+sKNRoaXWGqxxs
	 DW2N7+TB++HhA==
Date: Mon, 4 Aug 2025 12:04:49 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: maher azz <maherazz04@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	pabeni@redhat.com, Ferenc Fejes <fejes@inf.elte.hu>
Subject: Re: [PATCH v2 net] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
Message-ID: <20250804110449.GA46637@horms.kernel.org>
References: <CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com>
 <20250801150651.54969a4e@kernel.org>
 <CAFQ-Uc-15B7eiE9uFWFzPDhj1sfbuzwmWMEA61UXbumybJ=yzw@mail.gmail.com>
 <20250804104937.GR8494@horms.kernel.org>
 <20250804105046.mqllcspkookc7uu6@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804105046.mqllcspkookc7uu6@skbuf>

On Mon, Aug 04, 2025 at 01:50:46PM +0300, Vladimir Oltean wrote:
> On Mon, Aug 04, 2025 at 11:49:37AM +0100, Simon Horman wrote:
> > On Sat, Aug 02, 2025 at 12:25:24AM +0100, maher azz wrote:
> > > Can someone please do it instead of me just keep me as the reporter please?
> > > this is too complicated, it gets rejected even if im missing a space or a
> > > newline
> > > 
> > > Thanks for your help and time to review this.
> > 
> > Sure, will do.
> 
> Jakub already sent MessageID 20250802001857.2702497-1-kuba@kernel.org.

Thanks, I hadn't noticed that.

