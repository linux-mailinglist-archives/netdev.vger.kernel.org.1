Return-Path: <netdev+bounces-228711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A29BD2E8F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 657D54E446C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEC426CE2C;
	Mon, 13 Oct 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj3cdaJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF3231832
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357312; cv=none; b=RWxPIbc0K2pbjmMFwnpzc3ePDm7EkhninD9Rm2vuFxARwU5aWZYkeBSTyDBLT7Mn6mWaaQ18I7B4f4aumPv4GeBdAApgQvZQeyjYDHlpkgTmOqUQSGfvbHtaN/RTWXcWrbjng/MpyTek/PDEDfWyw8/7cHWKLFMGhwYwIXtlzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357312; c=relaxed/simple;
	bh=tcsXh5JauTahTEkpcNeAVyZhXtG2K93V43QkKfW9rh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il8XrR+IRhaa4/SBr3InPB5lOo9OY3rxSJ3DCmpz36+61eeFBgL6Tw1psfAPDJXKW0aZ7TKlilrraRo2g81YPfg+/44p+T27SmPTqdQKpuFqDjRE4GyzZZ+5qclCdqRgLPmaeZvUtnXhxlnkR/aUg+QOyg/fmDMznYmOf6NoCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj3cdaJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4A2C4CEE7;
	Mon, 13 Oct 2025 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357311;
	bh=tcsXh5JauTahTEkpcNeAVyZhXtG2K93V43QkKfW9rh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sj3cdaJfvZ1p/oy3RgDCdKbF4z1GQMYSq/PnbW2+yPjo5zRHtqj3jx/TYmLPQIhan
	 /mo4+VhsBZej9kXC9VM65VNS69DSEOqduGA8Hjqo+LS69fH7vdM/TvodgoaykgGROc
	 A8ogbNbN/Px7ZDZ7O/RHD/LZkliWbXmDTvthZ2jJDAmyIs/vhiUNgQBjpOUDiAPSjQ
	 a+GbBmBKikcagodHHXViZfBfRyOUvao3WzN3zIu1LZ3dszxnTfgAFwc2doDwBlUGfv
	 7pt1UTDEAbwptYrC/1pMxAGGtP3UhPfYkyAeBCCgLR23EowuwEFuwzlwRifHyIL3SW
	 8dWBsEWdpS6TA==
Date: Mon, 13 Oct 2025 13:08:26 +0100
From: Simon Horman <horms@kernel.org>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, kuniyu@google.com,
	"Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
Message-ID: <aOzrup9K8AE_dV28@horms.kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
 <zus4r4dgghmcyyj2bcjiprad4w666u4paqo3c5jgamr5apceje@zzdlbm75h5m5>
 <CAL+tcoBy+8RvKXDB2V0mcJ3pOFsrXEsaNYM_o21bk2Q1cLiNSA@mail.gmail.com>
 <71de19ef-6f63-47f5-b5ed-9eaef932439c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71de19ef-6f63-47f5-b5ed-9eaef932439c@linux.dev>

On Mon, Oct 13, 2025 at 03:04:34PM +0800, luoxuanqiang wrote:
> 
> 在 2025/10/13 14:26, Jason Xing 写道:
> > On Mon, Oct 13, 2025 at 1:36 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> > > On Tue, Sep 30, 2025 at 11:16:00AM +0800, Paolo Abeni wrote:
> > > > On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
> > > > > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > > > > 
> > > > > Add two functions to atomically replace RCU-protected hlist_nulls entries.
> > > [...]
> > > > > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > > > This deserves explicit ack from RCU maintainers.
> > > > 
> > > > Since we are finalizing the net-next PR, I suggest to defer this series
> > > > to the next cycle, to avoid rushing such request.
> > > > 
> > > > Thanks,
> > > > 
> > > > Paolo
> > > Hi maintainers,
> > > 
> > > This patch was previously held off due to the merge window.
> > > 
> > > Now that the merge net-next has open and no further changes are required,
> > > could we please consider merging it directly?
> > > 
> > > Apologies for the slight push, but I'm hoping we can get a formal
> > > commit backported to our production branch.
> > I suppose a new version that needs to be rebased is necessary.
> > 
> > Thanks,
> > Jason
> 
> I’ve rebased the series of patches onto the latest codebase locally and
> didn’t encounter any errors.
> 
> If there’s anything else I can do to help get these patches merged, just
> let me know.

Hi,

The patch-set has been marked as "Deffered" in Patchwork.
Presumably by Paolo in conjunction with his response above.
As such the patch-set needs to be (rebased and) reposted in
order for it to be considered by the maintainers again.

I think the best practice is for this to happen _after_ one
of the maintainers has sent an "ANN" email announcing that
net-next has re-opened. I don't believe that has happened yet.

Thanks!

