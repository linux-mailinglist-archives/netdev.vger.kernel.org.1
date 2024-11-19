Return-Path: <netdev+bounces-146073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4DE9D1E78
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29829283080
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10778C76;
	Tue, 19 Nov 2024 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7BrPrSv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAC28E3F;
	Tue, 19 Nov 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984805; cv=none; b=SpUUSelsiOVun0qOZjt1Bh83lJshTX6YjR5WDdqdlA3s9xcTYnjEGlCSpFWrXlVbWlZUmcu3SMUr7XMhSfFC8Ae+nCz/SeF7Fhm7e7ZVF7Uc62OOjEmZ9nt+u4CA2GCJHsgq3h1Nb4aISOHFJuluqegqFV1ksMbvaMDiodI6ptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984805; c=relaxed/simple;
	bh=gGlaLvbL+cKmnyYjm9c9go3bMbiw5DRVQTLOgYF/X+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyWAICkS1PE/HpHSfw0lOf6qt6bOiqjPACJFSlOx84HV7GMFwFcbel+/750Tn4w0aX06eKFxO04Ln1u4/o1vNoUqrvBumem7B8Th0HCvmNTAvPCbJdUGdmx/82lqQBCQnNp1QBBLEO9LwW4VIoB24zd3jPVWo6horg25DnIR7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7BrPrSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F8AC4CECC;
	Tue, 19 Nov 2024 02:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731984804;
	bh=gGlaLvbL+cKmnyYjm9c9go3bMbiw5DRVQTLOgYF/X+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7BrPrSvxjS72Xbow16WyqqJuBHw07MvK/xOKAz62renU/tP/WQ9lvdgU+Xtk8o84
	 XywbGBBGDbh7CL49lprAE3fcRm6iZSwnJw7eQyU3ef3eCdnK3e2mm6qadBQPLdUezT
	 j/WjHBaTT4zEsmMHscKP5Tx5598hw3HSy4rOBVIafS2jwi+zLpIcPzn9FpDKyAIi3n
	 fpCnziNlgfjYW8RqMerc1RaIWuvtSFkJuyY9UFU008VQheIkw/3yV424hFXeNsxguM
	 o6iEuWG1202uY3P6oXCHNv1ALp/irJS9hge0KRiB1nKAlQcCYUbeCfQUr/y5q+WxPe
	 VjEhhpezQkA+g==
Date: Mon, 18 Nov 2024 18:53:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: syzbot <syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 parav@nvidia.com, saeedm@nvidia.com, syzkaller-bugs@googlegroups.com,
 tariqt@nvidia.com
Subject: Re: [syzbot] [net?] general protection fault in dev_prep_valid_name
Message-ID: <20241118185323.37969bcd@kernel.org>
In-Reply-To: <CADUfDZqBUvm5vUgRHXKjvo=Kk4Ze8xU5tn-wG6J0wmUE6TTREA@mail.gmail.com>
References: <67383db1.050a0220.85a0.000e.GAE@google.com>
	<CADUfDZqBUvm5vUgRHXKjvo=Kk4Ze8xU5tn-wG6J0wmUE6TTREA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 18:19:23 -0800 Caleb Sander wrote:
> Hmm, it seems very unlikely that "mlx5/core: Schedule EQ comp tasklet
> only if necessary" could have caused this issue. The commit only
> touches the mlx5 driver. Does the test machine have ConnectX NICs? The
> commit itself simply moves where tasklet_schedule() is called for the
> mlx5_cq_tasklet_cb() tasklet, making it so the tasklet will only be
> scheduled to process userspace RDMA completions.
> Is it possible that the failure is not consistently reproducible and
> the bisection is landing on the wrong commit?

Yes, most likely bad bisection, I looked at the syzbot docs but I don't
see the command for invalidating the bisection results.

