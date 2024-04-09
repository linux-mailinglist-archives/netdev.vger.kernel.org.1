Return-Path: <netdev+bounces-86309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804089E5D4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25F21F22722
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A2158D8D;
	Tue,  9 Apr 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2keEnzR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A4158A3D
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703549; cv=none; b=NiMO0DJzLUwXo4cOJoc8aDIiZRVVZ41fGgQVoHT/B+K2JM1Xpj+l1XTU4RoQgHexUrdpLUYiP67smVRSxVfsa5fKYOIUDVXvIHlaJUxvtsP23vqgA8I9668ZDq4YjwCNm9L3sCWc8G6sF9oMQ9l73iybKLL9y1Hd3rRyGfAQSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703549; c=relaxed/simple;
	bh=SBcb1ap0n3wfkMdktfctqcMOmOejsMT/AbczyTGbBrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZxN58mANEDWsTLXXr0tSd/Ebdcx5rGDl5DF9d29i9YmiASBidPMX4Qgu5M1DkY/HaAwmHgsjc2ZMoKLnvu3REKO9CAvNLFtMTXIDQxnThfxT55EvRiPQS4NQWuIgTng8UirFL92SqjCl73Smk1we0nZSL0tAmSeVUiIzAykZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2keEnzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51146C433C7;
	Tue,  9 Apr 2024 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712703549;
	bh=SBcb1ap0n3wfkMdktfctqcMOmOejsMT/AbczyTGbBrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2keEnzRu99yug9bKZaijm8nYqHMUA8VLsCxuIVhp0guqhswHUoBAeWhVJSIQwV4A
	 nxsYAQXjdHWTQp1RFR8mqYbnGvzgxCPSZh5/Z0SYqeOckLBFnKHN9c4KfiMZxXOoAK
	 kIy1uNhonwnG/FrBgOF9ukXOHofrZqEQDRDG0bHbjRxzYd103v8PmGW/BDaEpDZJN7
	 xN1FJ6o6SNb7mpRxxWs2TK3NqigNGp1A/sPUJLzIyatZptMLMfx94HehudtQkqyeLf
	 elLCRKenVBJ77wIH0oJq6eCCN+qTImdEHKfB0nPGLYMZRPTe1CH8hgGRLGf9dAI0RD
	 eqD4MFFZv48Fg==
Date: Tue, 9 Apr 2024 15:59:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de"
 <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com"
 <axboe@fb.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, Shai Malin
 <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or
 Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Message-ID: <20240409155907.2726de60@kernel.org>
In-Reply-To: <838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
	<20240405224504.4cb620de@kernel.org>
	<1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
	<838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 22:35:51 +0000 Chaitanya Kulkarni wrote:
> blktests seems to be the right framework to add all the testcases to=20
> cover the targeted subsystem(s) for this patchset. Daniel from Suse has=20
> already posted an RFC (see [1]) to add support for blktests so we can=C2=
=A0=20
> use real controllers for better test coverage. We will be discussing=C2=
=A0=20
> that at LSFMM session this year in detail.

No preference on the framework or where the tests live, FWIW.

> With this support in the blktest framework, we can definitely generate=C2=
=A0=20
> right test-coverage for the tcp-offload that can be run by anyone who=C2=
=A0=20
> has this H/W. Just like I run NVMe tests on the code going from NVMe=C2=
=A0=20
> tree to block tree for every pull request, we are planning to run new=C2=
=A0=20
> nvme tcp offload specific tests regularly on NVMe tree. We will be happy=
=20
> to provide the H/W to distros=C2=A0who are supporting this feature in ord=
er=20
> to make testing easier for=C2=A0others as well.

You're not sending these patches to the distros, you're sending them
to the upstream Linux kernel. And unfortunately we don't have a test
lab where we could put your HW, so it's on you. To be clear all you
need to do is periodically build and test certain upstream branches=20
and report results. By "report" all I mean is put a JSON file with the
result somewhere we can HTTP GET. KernelCI has been around for a while,
I don't think this is a crazy ask.

