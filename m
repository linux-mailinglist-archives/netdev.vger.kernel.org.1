Return-Path: <netdev+bounces-30796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791B789212
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EEB2816CE
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34D198AA;
	Fri, 25 Aug 2023 22:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FF174E6
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 22:56:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68946199F
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693004165; x=1724540165;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=AM7Wr8GMP/Lwm+AcnMkKhXcNzAIBo/oiIO65fhZLqXo=;
  b=FOhnrJNTeFhfjb1lZvvAPD93LdRgVZyWdZZO5a3IJ1kfxbnSMjXwLFsR
   eqPUOQyacG/dbi6ansOoSqkjSL77rPpOdLm8STFpECkAjnoafcGXsliWs
   Fklbx2HKzqwM1X1aJJ3k73kHVf7Tk7u1fEIVXg/P/n11CGm751yPAQz5j
   1ttNKiPnhBPGbfMLN/iR6PsRgdAL+OxR08gGpcq3nUl+mlEQVNXXyp2oo
   jRnB7wNAAQLLRwKMc3Gvo7hkA5vxeu9qAwLXzYmMoztg1bV0eetHIjeCR
   rOzr6wV+Oyk9CxHsOQJVhQYCbdNbukwPtoAx8NdIpUCqzu/APdmWJzvnJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="441165852"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="441165852"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 15:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="803109867"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="803109867"
Received: from rtallon-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.111.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 15:56:03 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Ferenc Fejes <ferenc.fejes@ericsson.com>, "jesse.brandeburg@intel.com"
 <jesse.brandeburg@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "sasha.neftin@intel.com"
 <sasha.neftin@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "anthony.l.nguyen@intel.com"
 <anthony.l.nguyen@intel.com>
Cc: "hawk@kernel.org" <hawk@kernel.org>
Subject: Re: BUG(?): igc link up and XDP program init fails
In-Reply-To: <0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com>
References: <0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com>
Date: Fri, 25 Aug 2023 15:56:01 -0700
Message-ID: <87ttsmohoe.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ferenc,

Ferenc Fejes <ferenc.fejes@ericsson.com> writes:

> Dear igc Maintainers!
>
> I noticed that ip link set dev up fails with igc (Intel i225) driver
> when XDP program is attached to it. More precisely, only when we have
> incoming traffic and the incoming packet rate is too fast (like 100
> packets per-sec).
>
> I don't have a very smart reproducer, so 4 i225 cards are needed to
> trigger it. My setup (enp3s0 and enp4s0 directly connected with a
> cable, similarly enp6s0 and enp7s0).
>
> veth0 ----> veth1 --redir---> enp3s0 ~~~~~~~ enp4s0
> 			=C2=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +-> enp6s0 ~~~~~~~ enp7s0
>
> ip link add dev type veth
> ip nei change 1.2.3.4 lladdr aa:aa:aa:aa:aa:aa dev veth0
> xdp-bench redirect-multi veth1 enp3s0 enp6s0	#in terminal 1
> xdpdump -i enp4s0				#in terminal 2
> ping -I veth0 1.2.3.4 -i 0.5 #slow packet rate=C2=A0 #in terminal 3
>

I was just able to reproduce this issue, with a different setup:=20

|             System A                 |   System B   |=20
veth0 ----> veth1 --redir---> "enp3s0" ~~~~~~~ "enp4s0"

And running xdp-bench like this:

$ xdp-bench redirect-multi veth1 enp3s0

Also I am running a different traffic generator.

> Now in a separate terminal do a "ip link set dev enp4s0 down" and "ip
> link set dev enp4s0 up". After a while, xdpdump will see the incoming
> packets.
>

It seems that anything that triggers a reset of the adapter would
trigger the bug: I am able to trigger the bug when I run 'xdp-bench'
last (after "ping"/traffic generator), no need for 'link down/link up'.

> Now in terminal 3, change the ping to a faster rate:
> ping -I veth0 1.2.3.4 -i 0.01
>
> And do the ip link down/up again. In my setup, I no longer see incoming
> packets. With bpftrace I see the driver keep trying to initialize
> itself in an endless loop.
>
> Now stop the ping, wait about 4-5 seconds, and start the ping again.
> This is enough time for the driver to initialize properly, and packets
> are visible in xdpdump again.
>
> If anyone has an idea what is wrong with my setup I would be happy to
> hear it, and I can help with testing fixes if this is indeed a bug.
> I have replicated the setup with veths and it looks fine.
>

I don't think there's anything wrong with your setup.

I am considering this a bug, I don't have any patches from the top of my
head for you to try, but taking a look.

Anyway, thanks for the report.


Cheers,
--=20
Vinicius

