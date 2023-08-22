Return-Path: <netdev+bounces-29716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1678468C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC56F2810D4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E01DA5F;
	Tue, 22 Aug 2023 16:06:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD51CA1F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6261FC433C8;
	Tue, 22 Aug 2023 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692720415;
	bh=1V7w5fj4v1tLII5zZTBA1w3oKQjMiTF1veCGb3+VCYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hb9YUpXluU/qkdIVPn5jGONVx8yj//QL2hQAmzhL/mrITbjMYzNGxpMfnPNJT0cx2
	 CGGf8gpIM+m/XMN5QRgwTvQ+cBl5sx9lT19gBg0HDh2AhoVx8IwXGT3oHrCAzfmMba
	 3aEG1rDsvICZlWzzM7qhTdCh1ZC4Do0NFjSlOTfN8EgawbHqBP7Fxh6qi2RODTDHTe
	 afhS/CQNyTmtStFor5ABkoW2aED9KRNHUCeqk88n/wgaNesHNN1JWTv0iQSKUyJzLU
	 vzRN3Cu9T55sz6Cv5vwnTJUvFqs8yF+2fKwE84mBrkGQUyzTe4pkLx2m8j7KXQjND5
	 BCPGhuw1K1hnA==
Date: Tue, 22 Aug 2023 19:06:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
	Saeed Mahameed <saeedm@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
Message-ID: <20230822160651.GN6029@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal>
 <20230822070211.GH2711035@kernel.org>
 <20230822141348.GH6029@unreal>
 <f497dc97-76bb-7526-7d19-d6886a3f3a65@intel.com>
 <20230822154810.GM6029@unreal>
 <8a0e05ed-ae10-ba2f-5859-003cd02fba9c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a0e05ed-ae10-ba2f-5859-003cd02fba9c@intel.com>

On Tue, Aug 22, 2023 at 05:56:25PM +0200, Przemek Kitszel wrote:
> On 8/22/23 17:48, Leon Romanovsky wrote:
> > On Tue, Aug 22, 2023 at 04:44:29PM +0200, Przemek Kitszel wrote:
> > > On 8/22/23 16:13, Leon Romanovsky wrote:
> > > > On Tue, Aug 22, 2023 at 09:02:11AM +0200, Simon Horman wrote:
> > > > > On Sat, Aug 19, 2023 at 02:52:49PM +0300, Leon Romanovsky wrote:
> > > > > > On Thu, Aug 17, 2023 at 04:17:38PM +0200, Karol Kolacinski wrote:
> > > > > > > The ice_pf_src_tmr_owned() macro exists to check the function capability
> > > > > > > bit indicating if the current function owns the PTP hardware clock.
> > > > > > 
> > > > > > This is first patch in the series, but I can't find mentioned macro.
> > > > > > My net-next is based on 5b0a1414e0b0 ("Merge branch 'smc-features'")
> > > > > > ➜  kernel git:(net-next) git grep ice_pf_src_tmr_owned
> > > > > > shows nothing.
> > > > > > 
> > > > > > On which branch is it based?
> > > > > 
> > > > > Hi Leon,
> > > > > 
> > > > > My assumption is that it is based on the dev-queue branch of
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> > > > 
> > > > So should netdev readers review it or wait till Intel folks perform
> > > > first pass on it?
> > > 
> > > Most of the time Intel folks would be first to review, if only because of
> > > our pre-IWL processes or pure familiarity/interest in given piece.
> > > 
> > > For this particular series, it is about right "codewise" since v1, so you
> > > are welcome for an insightful look at v3
> > > (I didn't provided my RBs so far because of "metadata" issues :),
> > > will take a fresh look, but you don't need to wait).
> > > 
> > > 
> > > General idea for CC'ing netdev for IWL-targeted patches is to have open
> > > develompent process.
> > > Quality should be already as for netdev posting.
> > > Our VAL picks up patches for testing from here when Tony marks them so.
> > > 
> > > That's what I could say for review process.
> > > 
> > > "Maintainers stuff", I *guess*, is:
> > > after review&test Tony Requests netdev Maintainers to Pull
> > > (and throttles outgoing stuff by doing so to pace agreed upon).
> > > At that stage is a last moment for (late?) review, welcomed as always.
> > 
> > It means that we (netdev@... ) will see "same" patches twice, am I right?
> 
> That's true.

Can I suggest change in the process?
1. Perform validation before posting
2. Intel will post their patches to the netdev@ ML.
3. Tony will collect reviewed patches from netdev@
4. Tony will send clean PRs (without patches) from time to time to
netdev maintainers for acceptance.

It will allow to all of us (Intel, Nvidia e.t.c) to have same submission
flow without sacrificing open netdev@ review which will be done only once.

Jakub/Dave, is it possible?

Thanks

> 
> > 
> > Thanks
> > 
> > > 
> > > 
> > > 
> > > > 
> > > > Thanks
> > > > _______________________________________________
> > > > Intel-wired-lan mailing list
> > > > Intel-wired-lan@osuosl.org
> > > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> > > 
> > > 
> 

