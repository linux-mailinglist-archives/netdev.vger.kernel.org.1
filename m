Return-Path: <netdev+bounces-158527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC45A12624
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB44188A4BF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABD78F41;
	Wed, 15 Jan 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI5/9tlQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D9041C6C
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951817; cv=none; b=aLVYJl+6nfxbs1Vko4mlF0l04uiNtJzWWLEEKe1OPIOcuCEZVugV+CrmNqLcYGjXU1aSvjouvZ0mbCHGXQRE/FFc58dyauneE8kweV5nDU+ukuSyKtDTbUMzvQ2x/Y4mqHww8iwBU49bW4LMI+2O15sznAHqwCe9D4RNRriFCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951817; c=relaxed/simple;
	bh=JtZR8moECWCaG7O9Whi1lIYRGydadbS+tU6TglBPyXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCZ8om7aNQmvUktEuTxGVxwVfguAJj2jYMPptQ5sxbD7iyXH2qr2svB6tpx5lyDMGTv6CsCvXUTbba0U6YfbFtnmPqbkPyg5NN93wdBGAQTVUMaggGA3Z8pPbn6ShUNp0AYPnYzaWCAXYNrlnlegM2VDi3jihE85Z01C4NN/GSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI5/9tlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3F2C4CED1;
	Wed, 15 Jan 2025 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736951816;
	bh=JtZR8moECWCaG7O9Whi1lIYRGydadbS+tU6TglBPyXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iI5/9tlQYnlMw5S67N13E8mB16h9v9gYqSAOkPqsy0n4cDHqW0xXtCVYOeGlfNeCo
	 KlUWR5B+ei2lT5vwSEPMsgZTuzkuEPDyTBE5SRCFY3U7bbrCc4gHfG9dS9Nh5CL1Lb
	 zdJn8QlvHE5aTSjVd9ydNp+sE7FKBbM7Od8yF2XGVRNMQEe0nTB6QnDBM+RuX8jHXd
	 sUlC+brAvKCHGgFELf/DvR67Qlnb4pU3HhKr/6LkHE5R4A1UT78LKW9Jy7Yi8eLneC
	 beSnPZ6fsQzdgIPBvwbtboGPKrynn2g6zgyV3HC9cWzYX2dgP52Rvq3MEcodMgjcC2
	 wOAqBBMn8sOLQ==
Date: Wed, 15 Jan 2025 06:36:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250115063655.21be5c74@kernel.org>
In-Reply-To: <CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
References: <20250111151455.75480-1-jhs@mojatatu.com>
	<20250114172620.7e7e97b4@kernel.org>
	<CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 09:15:31 -0500 Jamal Hadi Salim wrote:
> > On Sat, 11 Jan 2025 10:14:55 -0500 Jamal Hadi Salim wrote: =20
> > > The semantics of "replace" is for a del/add _on the same node_ and not
> > > a delete from one node(3:1) and add to another node (1:3) as in step1=
0.
> > > While we could "fix" with a more complex approach there could be
> > > consequences to expectations so the patch takes the preventive approa=
ch of
> > > "disallow such config". =20
> >
> > Your explanation reads like you want to prevent a qdisc changing
> > from one parent to another.
>=20
> Yes.

In the selftest with mq Victor updated I'd say we're not changing
the parent. We replace one child of mq with another.
TC noobs would say mq is the parent.

> > > +                             if (leaf_q && leaf_q->parent !=3D q->pa=
rent) {
> > > +                                     NL_SET_ERR_MSG(extack, "Invalid=
 Parent for operation");
> > > +                                     return -EINVAL;
> > > +                             } =20
> >
> > But this test looks at the full parent path, not the major.
> > So the only case you allow is replacing the node.. with itself?
> > =20
>=20
> Yes.
>=20
> > Did you mean to wrap these in TC_H_MAJ() || the parent comparison
> > is redundant || I misunderstand? =20
>=20
> I may be missing something - what does TC_H_MAJ() provide?
> The 3:1 and 1:3 in that example are both descendants of the same
> parent. It could have been 1:3 vs 1:2 and the same rules would apply.

Let me flip the question. What qdisc movement / grafts are you intending
to still support?

=46rom the report it sounds like we don't want to support _any_ movement=20
of existing qdiscs within the hierarchy. Only purpose of graft would=20
be to install a new / fresh qdisc as a child.

