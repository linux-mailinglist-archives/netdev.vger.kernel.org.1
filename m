Return-Path: <netdev+bounces-247089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0194CF4608
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C98300AFF9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81507339B43;
	Mon,  5 Jan 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZmu4A/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7731AF36
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626656; cv=none; b=b5pf+Z7HzHxkn2DRZuXdGLSAz2TIAZ5E6JBtvLF6X9KqaWxae6WP4SJlKAzrpymmS83PIt1wF7mqovm09LGh+dfRL+Eguc6YSbmfnIriG8ahc7l9De3EteBA9dQc5ea01+hgKhEl0/AIGwheTxleSwb08PcS8J4gsxNSSpu+dtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626656; c=relaxed/simple;
	bh=GltqLpIfO33b5EX0LYOhzXuxLHkxr13S1gdQw2RYE28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liQoLPxwutZhGvE1HiJN+BsX+odsWPMSoLE7rFRpMNKE1QIZ3cFyCE5ZE+agxiAtcQ8FywMh+GuZTlZhkISl7MfaURfzjWD2QHdbLXC5jmhkAo2TkKx4f5+k+IhlHKWdctopK+F8C5MiKB7c8ZWBt5dfh/PkPqO7Dw6wUkUrQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZmu4A/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C564C116D0;
	Mon,  5 Jan 2026 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767626655;
	bh=GltqLpIfO33b5EX0LYOhzXuxLHkxr13S1gdQw2RYE28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZmu4A/SnDUWnWxZpzemhyTpMQ6i+hGRtmGiJYle3Yb8p3oRao3mq7JeVI59acc5W
	 9ulXrIneX2srKs5O7VprJu20m/8+vd/e9Tw1YhZ7kkn2UppTcPBBdEJ89Jf3enEGhy
	 b6+Rd7Xhi4lSxna32ySMlKM4Elvg530nVi2hdzAXlJdtoaIvIAre7iG1vsUhSZRuk/
	 8ojwCTcOdKL713Au3BIhxEeiqMc7pGpBEhycyg0qlaEfHutA6t0w+kmjSUYlF00n2k
	 Vm8XJDRrL+cxQnUaabId7LgjrnDHg16clGvBNDhJtscF3CoBGagdwMvTGrFINonTWa
	 ALtZI+CbZO6UQ==
Date: Mon, 5 Jan 2026 07:24:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonas =?UTF-8?B?S8O2cHBlbGVy?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/6] Multi-queue aware sch_cake
Message-ID: <20260105072414.50f4537e@kernel.org>
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 05 Jan 2026 13:50:25 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> A patch to iproute2 to make it aware of the cake_mq qdisc will be
> submitted separately.

Could you send it out? I think we need to apply it to TDC to make the
test pass.

