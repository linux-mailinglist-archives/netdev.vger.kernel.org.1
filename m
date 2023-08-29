Return-Path: <netdev+bounces-31131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCB78BC8C
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 03:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2231C20988
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE297FF;
	Tue, 29 Aug 2023 01:58:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8CA2A
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 01:58:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3179194
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693274330; x=1724810330;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=e2Ig3o1OA0kayp4cVYbjNkTKB/JXTgUcugSMWn1Mw+U=;
  b=IcgHFehvm7z1+jf0u9wj/3iVGU2Z9lMFXO43/qiuZdu1Q/67+TQGysn1
   zF+ZmHbpkPXxR2/14tH2hteTffJ+o/yZ5ZeLu2us2QWM1Ryd7mWkns++d
   SezcoXo94whac8P7M8Wkrj4b4puS2ssJilJFpG80cRCk95SEo+uFRQ1Qf
   oJLOkaEK+cd2nHsWnHCexpYs8OOpmsTVOCPOw26gsGmGBBhT+53j4aFW1
   Sj+AbpDivi4Bp2MUeeIlf/11F5bqaSK6sviTtOE+TvaJRtYDAIdSkjMjg
   DtoGMTL1fHmLQWBcZZRWf6XbJcxovPUlGOKm+tr1TRGwVOAFJTTyp5aEG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="375220029"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="375220029"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 18:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="808496024"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="808496024"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 18:58:42 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: James Hogan <jhogan@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Sasha Neftin <sasha.neftin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, "Neftin, Sasha"
 <sasha.neftin@intel.com>
Subject: Re: [WIP v2] igc: fix deadlock caused by taking RTNL in RPM resume
 path
In-Reply-To: <5962826.lOV4Wx5bFT@saruman>
References: <20220811151342.19059-1-vinicius.gomes@intel.com>
 <3186253.aeNJFYEL58@saruman> <3329047.e9J7NaK4W3@saruman>
 <5962826.lOV4Wx5bFT@saruman>
Date: Mon, 28 Aug 2023 18:58:42 -0700
Message-ID: <87zg2alict.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi James,

James Hogan <jhogan@kernel.org> writes:

> On Sunday, 2 October 2022 11:56:28 BST James Hogan wrote:
>> On Monday, 29 August 2022 09:16:33 BST James Hogan wrote:
>> > On Saturday, 13 August 2022 18:18:25 BST James Hogan wrote:
>> > > On Saturday, 13 August 2022 01:05:41 BST Vinicius Costa Gomes wrote:
>> > > > James Hogan <jhogan@kernel.org> writes:
>> > > > > On Thursday, 11 August 2022 21:25:24 BST Vinicius Costa Gomes wrote:
>> > > > >> It was reported a RTNL deadlock in the igc driver that was causing
>> > > > >> problems during suspend/resume.
>> > > > >> 
>> > > > >> The solution is similar to commit ac8c58f5b535 ("igb: fix deadlock
>> > > > >> caused by taking RTNL in RPM resume path").
>> > > > >> 
>> > > > >> Reported-by: James Hogan <jhogan@kernel.org>
>> > > > >> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> > > > >> ---
>> > > > >> Sorry for the noise earlier, my kernel config didn't have runtime
>> > > > >> PM
>> > > > >> enabled.
>> > > > > 
>> > > > > Thanks for looking into this.
>> > > > > 
>> > > > > This is identical to the patch I've been running for the last week.
>> > > > > The
>> > > > > deadlock is avoided, however I now occasionally see an assertion
>> > > > > from
>> > > > > netif_set_real_num_tx_queues due to the lock not being taken in some
>> > > > > cases
>> > > > > via the runtime_resume path, and a suspicious
>> > > > > rcu_dereference_protected()
>> > > > > warning (presumably due to the same issue of the lock not being
>> > > > > taken).
>> > > > > See here for details:
>> > > > > https://lore.kernel.org/netdev/4765029.31r3eYUQgx@saruman/
>> > > > 
>> > > > Oh, sorry. I missed the part that the rtnl assert splat was already
>> > > > using similar/identical code to what I got/copied from igb.
>> > > > 
>> > > > So what this seems to be telling us is that the "fix" from igb is only
>> > > > hiding the issue,
>> > > 
>> > > I suppose the patch just changes the assumption from "lock will never be
>> > > held on runtime resume path" (incorrect, deadlock) to "lock will always
>> > > be
>> > > held on runtime resume path" (also incorrect, probably racy).
>> > > 
>> > > > and we would need to remove the need for taking the
>> > > > RTNL for the suspend/resume paths in igc and igb? (as someone else
>> > > > said
>> > > > in that igb thread, iirc)
>> > > 
>> > > (I'll defer to others on this. I'm pretty unfamiliar with networking
>> > > code
>> > > and this particular lock.)
>> > 
>> > I'd be great to have this longstanding issue properly fixed rather than
>> > having to carry a patch locally that may not be lock safe.
>> > 
>> > Also, any tips for diagnosing the issue of the network link not coming
>> > back
>> > up after resume? I sometimes have to unload and reload the driver module
>> > to
>> > get it back again.
>> 
>> Any thoughts on this from anybody?
>
> Ping... I've been carrying this patch locally on archlinux for almost a year 
> now. Every time I update my kernel and forget to rebuild with the patch it 
> catches me out with deadlocks after resume, and even with the patch I 
> frequently have to reload the igc module after resume to get the network to 
> come up (which is preferable to deadlocks but still really sucks). I'd really 
> appreciate if it could get some attention.

I am setting up my test systems to reproduce the deadlocks, then let's
see what ideas happen about removing the need for those locks.

About the link failures, are there any error messages in the kernel
logs? (also, if you could share those logs, can be off-list, it would
help) I am trying to think what could be happening, and how to further
debug this.


Cheers,
-- 
Vinicius

