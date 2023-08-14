Return-Path: <netdev+bounces-27309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735CE77B740
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D382281111
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535DBA2F;
	Mon, 14 Aug 2023 11:04:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46D8F77
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302AFC433C7;
	Mon, 14 Aug 2023 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692011059;
	bh=X4sVDlguYz5tjg9hwDCiyx+vB92yLKZdyBV6FcV6r7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4Lw6ZR8a7owfJBnUQ0WbiNRBfef3MPlV+X1+2WtxNb54bapktF08BEySVgh6/Xj+
	 nejnT6m94DsZ0B+2nABbZjwDSpLO/0yPc0rS6Ri/R+UH/KF3FSJo0u3XQPlwrysEMH
	 gqLyaY8YZsSiki2xDR4+jHTCwzwHTlRRA1fiBvQ0yaUa81jndGiHGqtJ61D/j0MLqt
	 BJe/ceXOQKKk6qgEZF/ceTewFiyQ3Ki7U3KBMA1N5M5XfuR0tWxYuEPjQV5Y3n9upd
	 +JPMoiLVUlaxxCHZlMgO5fUQeGjU2RUHTWGxBDoCQBCvE6Vrh5MZTmbqFX9JTJ2XP5
	 nR5zmPcxfUasQ==
From: James Hogan <jhogan@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Sasha Neftin <sasha.neftin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject:
 Re: [WIP v2] igc: fix deadlock caused by taking RTNL in RPM resume path
Date: Mon, 14 Aug 2023 12:04:15 +0100
Message-ID: <5962826.lOV4Wx5bFT@saruman>
In-Reply-To: <3329047.e9J7NaK4W3@saruman>
References:
 <20220811151342.19059-1-vinicius.gomes@intel.com>
 <3186253.aeNJFYEL58@saruman> <3329047.e9J7NaK4W3@saruman>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 2 October 2022 11:56:28 BST James Hogan wrote:
> On Monday, 29 August 2022 09:16:33 BST James Hogan wrote:
> > On Saturday, 13 August 2022 18:18:25 BST James Hogan wrote:
> > > On Saturday, 13 August 2022 01:05:41 BST Vinicius Costa Gomes wrote:
> > > > James Hogan <jhogan@kernel.org> writes:
> > > > > On Thursday, 11 August 2022 21:25:24 BST Vinicius Costa Gomes wrote:
> > > > >> It was reported a RTNL deadlock in the igc driver that was causing
> > > > >> problems during suspend/resume.
> > > > >> 
> > > > >> The solution is similar to commit ac8c58f5b535 ("igb: fix deadlock
> > > > >> caused by taking RTNL in RPM resume path").
> > > > >> 
> > > > >> Reported-by: James Hogan <jhogan@kernel.org>
> > > > >> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > > > >> ---
> > > > >> Sorry for the noise earlier, my kernel config didn't have runtime
> > > > >> PM
> > > > >> enabled.
> > > > > 
> > > > > Thanks for looking into this.
> > > > > 
> > > > > This is identical to the patch I've been running for the last week.
> > > > > The
> > > > > deadlock is avoided, however I now occasionally see an assertion
> > > > > from
> > > > > netif_set_real_num_tx_queues due to the lock not being taken in some
> > > > > cases
> > > > > via the runtime_resume path, and a suspicious
> > > > > rcu_dereference_protected()
> > > > > warning (presumably due to the same issue of the lock not being
> > > > > taken).
> > > > > See here for details:
> > > > > https://lore.kernel.org/netdev/4765029.31r3eYUQgx@saruman/
> > > > 
> > > > Oh, sorry. I missed the part that the rtnl assert splat was already
> > > > using similar/identical code to what I got/copied from igb.
> > > > 
> > > > So what this seems to be telling us is that the "fix" from igb is only
> > > > hiding the issue,
> > > 
> > > I suppose the patch just changes the assumption from "lock will never be
> > > held on runtime resume path" (incorrect, deadlock) to "lock will always
> > > be
> > > held on runtime resume path" (also incorrect, probably racy).
> > > 
> > > > and we would need to remove the need for taking the
> > > > RTNL for the suspend/resume paths in igc and igb? (as someone else
> > > > said
> > > > in that igb thread, iirc)
> > > 
> > > (I'll defer to others on this. I'm pretty unfamiliar with networking
> > > code
> > > and this particular lock.)
> > 
> > I'd be great to have this longstanding issue properly fixed rather than
> > having to carry a patch locally that may not be lock safe.
> > 
> > Also, any tips for diagnosing the issue of the network link not coming
> > back
> > up after resume? I sometimes have to unload and reload the driver module
> > to
> > get it back again.
> 
> Any thoughts on this from anybody?

Ping... I've been carrying this patch locally on archlinux for almost a year 
now. Every time I update my kernel and forget to rebuild with the patch it 
catches me out with deadlocks after resume, and even with the patch I 
frequently have to reload the igc module after resume to get the network to 
come up (which is preferable to deadlocks but still really sucks). I'd really 
appreciate if it could get some attention.

Many thanks
James



