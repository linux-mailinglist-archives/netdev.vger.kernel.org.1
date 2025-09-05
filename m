Return-Path: <netdev+bounces-220190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7DB44B5C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FFB7B4EA3
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F91DC1AB;
	Fri,  5 Sep 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxvNidCT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F4B661;
	Fri,  5 Sep 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037163; cv=none; b=Zch6WNoOO8p8qwXrZnnuG1XnwhqdL6Px6rv0IAfnKg6pxtZALTdRCFJz9x09uL8VGOCpJ28xVsOMDMtwyTvhUEwCFLqeV3yYpO8e0DQGXreRe39u0aGddTFwdcyzuG1ojMn24N+EcEvE+D/9gapmbxNZaVfO5280NwhlPtYPIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037163; c=relaxed/simple;
	bh=TnBhCsXeLzqVyIFIJMgUEK2kSXCGuLd5NI1z1elnFRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj5gI5neW6F8hgxEScG30omhQ+N7IiwYnjfNHeRnxMjX7Dfba/QBFIBS1T7npv0gGqWFrGuUREDIsQUD4ljAEaxbGBOpxGy+e4ZsMQ6ittsl3l6Nw6c7iHbkeTjMxSQOY4AAARz8bABa3TdlXqDQpRscAVh1osQxp/DKaB5ZyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxvNidCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692F0C4CEF0;
	Fri,  5 Sep 2025 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757037163;
	bh=TnBhCsXeLzqVyIFIJMgUEK2kSXCGuLd5NI1z1elnFRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OxvNidCTmtbyCGLjmkUwhNidr9WqvV4gVras5WcF7oMpJQgp84mcoL1c9vADmKRvk
	 m8TgrlM7wf02Y4R3G4Lxu13N8mGDkR6ZWktO/MCkDyxJV8Y1miLWbV90xIcTsJCTFJ
	 NbFafER0NxOVKyFp1DlFKLvAegMHzQdPzxrtpDr4fHSZ+7i2EX3rUVBus8eAtxD2xq
	 IAaKrdM3mdt8wcaH4xiH5PTSAZPDaAZphIJ235UctkqpAC3LJr1bF/jqSzJghDL2vV
	 DaotVNZm6UdH0KRQdTdYlD/qiaY7VoQ7V/eHm5mCm3e84H+K0qylZEBd+pR3avPjqU
	 qvu5sdFI8597A==
Date: Thu, 4 Sep 2025 18:52:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: Nimrod Oren <noren@nvidia.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com, Dragos Tatulea
 <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [RFC bpf-next v1 2/7] bpf: Allow bpf_xdp_shrink_data to shrink
 a frag from head and tail
Message-ID: <20250904185241.607552f7@kernel.org>
In-Reply-To: <CAMB2axOZW_t1y8_wQN=e-vx1LHWLA-CKnYDjVo_g6FcY9NQ5uA@mail.gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<20250825193918.3445531-3-ameryhung@gmail.com>
	<f35db6aa-ac4c-4690-bb54-4bbd5d4a3970@nvidia.com>
	<CAMB2axOZW_t1y8_wQN=e-vx1LHWLA-CKnYDjVo_g6FcY9NQ5uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Sep 2025 15:19:28 -0700 Amery Hung wrote:
> On Thu, Aug 28, 2025 at 6:44=E2=80=AFAM Nimrod Oren <noren@nvidia.com> wr=
ote:
> > On 25/08/2025 22:39, Amery Hung wrote: =20
> > > Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
> > > functionality to be able to shrink an xdp fragment from both head and
> > > tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
> > > xdp fragment from head. =20
> > I had assumed that XDP multi-buffer frags must always be the same size,
> > except for the last one. If that=E2=80=99s the case, shrinking from the=
 head
> > seems to break this rule. =20
>=20
> I am not aware of the assumption in the code. Is this documented somewher=
e?

There's no such rule. Perhaps conflating frags with segments after TSO.

