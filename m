Return-Path: <netdev+bounces-45221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052A7DB8F4
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8717A2815B3
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025F12E6E;
	Mon, 30 Oct 2023 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Cud3WNc7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD6111A7
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:30:11 +0000 (UTC)
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 04:30:08 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA3A6
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 04:30:08 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231030112904427d264545686c8308
        for <netdev@vger.kernel.org>;
        Mon, 30 Oct 2023 12:29:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nxDix7s9zg3oDdnuN0DQJLG7/HAaXgtm+NEMR+vLIX0=;
 b=Cud3WNc7+n9kDFdjzvmJo9BwclA4AYepm9RIU+3YPXTCVTIFpJPyMPAV4WdIB5ngHfcgHr
 zDBTwms5B5DdK430ea93EAFqsasmipHXrfHzgsswaK/DXSNYGFsXSoTSfuvgInR9SikLhVH3
 8z9mOcJXashHSih0jZdC/+wFPDkZo=;
Message-ID: <fc7fb885df3a52d076bb71191afa786d19d79cd5.camel@siemens.com>
Subject: Re: [PATCH net-next] net/core: Enable socket busy polling on -RT
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  jan.kiszka@siemens.com, vivek.behera@siemens.com
Date: Mon, 30 Oct 2023 12:29:02 +0100
In-Reply-To: <87zg033vox.fsf@kurt>
References: <20230523111518.21512-1-kurt@linutronix.de>
	 <d085757ed5607e82b1cd09d10d4c9f73bbdf3154.camel@siemens.com>
	 <87zg033vox.fsf@kurt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Kurt,

On Sat, 2023-10-28 at 12:09 +0200, Kurt Kanzenbach wrote:
> Hi Florian,
>=20
> On Fri Oct 27 2023, Florian Bezdeka wrote:
> > On Tue, 2023-05-23 at 13:15 +0200, Kurt Kanzenbach wrote:
> > > Busy polling is currently not allowed on PREEMPT_RT, because it disab=
les
> > > preemption while invoking the NAPI callback. It is not possible to ac=
quire
> > > sleeping locks with disabled preemption. For details see commit
> > > 20ab39d13e2e ("net/core: disable NET_RX_BUSY_POLL on PREEMPT_RT").
> >=20
> > Is that something that we could consider as Bug-Fix for 6.1 and request
> > a backport, or would you consider that as new feature?
>=20
> IMO it is in category "never worked". Hence it is not stable material.
>=20
> >=20
> > >=20
> > > However, strict cyclic and/or low latency network applications may pr=
efer busy
> > > polling e.g., using AF_XDP instead of interrupt driven communication.
> > >=20
> > > The preempt_disable() is used in order to prevent the poll_owner and =
NAPI owner
> > > to be preempted while owning the resource to ensure progress. Netpoll=
 performs
> > > busy polling in order to acquire the lock. NAPI is locked by setting =
the
> > > NAPIF_STATE_SCHED flag. There is no busy polling if the flag is set a=
nd the
> > > "owner" is preempted. Worst case is that the task owning NAPI gets pr=
eempted and
> > > NAPI processing stalls.  This is can be prevented by properly priorit=
ising the
> > > tasks within the system.
> > >=20
> > > Allow RX_BUSY_POLL on PREEMPT_RT if NETPOLL is disabled. Don't disabl=
e
> > > preemption on PREEMPT_RT within the busy poll loop.

Sorry, I need one more information here: We try to re-use the kernel
and its configuration from Debian whenever possible. NETPOLL/NETCONSOLE
is build as module there.

Will this limitation be addressed in the future? Is someone already
working on that? Is that maybe on the radar for the ongoing printk()
work? (Assuming printk() with NETCONSOLE enabled is the underlying
problem)

We don't use NETPOLL/NETCONSOLE during runtime but it is enabled at
build time. Sadly we can not use busy polling mode in combination with
XDP now. (Ignoring the fact that we could adjust the kernel
configuration, build on our own, ...)

Would love to hear your thoughts about that. Thanks a lot!

> > >=20
> > > Tested on x86 hardware with v6.1-RT and v6.3-RT on Intel i225 (igc) w=
ith
> > > AF_XDP/ZC sockets configured to run in busy polling mode.
> >=20
> > That is exactly our use case as well and we would like to have it in
> > 6.1. Any (technical) reasons that prevent a backport?
>=20
> There is no technical reason which prevents a backport to v6.1. In fact,
> we're using this with v6.1-RT LTS.
>=20
> Thanks,
> Kurt


