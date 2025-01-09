Return-Path: <netdev+bounces-156757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E4A07CD1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D8F3A3A34
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D921A43B;
	Thu,  9 Jan 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bj46bxpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAE249E5
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438709; cv=none; b=WBEG+o6ZaZ572X7KQ57OaMC6sNJjASZOtUSfOlGLD4844OoiM/12XymTmrzbeIlKSE46p6qomSRKaDZ61fkke5yXpP3qYAV2IBRBY4aehbqU26BKZIOoMFigIkqWcF/qpd2cGoyzT5QmNl53GSonlfIzTCXrT46FUmYvcoGXZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438709; c=relaxed/simple;
	bh=LsWP0SuRBGWwfpNa2h5LVmDJwmO4sPjNHOwPIy40eAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJqwNqPPIZ8Q9dVxDJesoVGPtiYYGr5K6X2rRa2IwuQ8YeL0NQNhr7rg/x0N4vaIzRbyeQ01XSXOgqNYi1NK5UXdbGmYoN9wkhq04cEVcRTXtf8XUdfGBcv7SUZr5Pbn2L3CNBykrzmi1M1HNwzc+FJ0ot3QizgIuOJPfIPWQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bj46bxpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A342C4CED2;
	Thu,  9 Jan 2025 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438709;
	bh=LsWP0SuRBGWwfpNa2h5LVmDJwmO4sPjNHOwPIy40eAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bj46bxpfC2A7vh9U+0hKBzQApeAG/ANNNrhZnDcwW0C+5/HXjusCHqpiDAOOqxX0u
	 OYJEv5AC3U41n9fG/MN4ysVRSH9X7F241Vcav9qfjDhDIrkjyk5V8uXlsXXyaA5hdL
	 be571uGBbBGzQ8GH+A/yhpWdrosF4062hjL5y00Pzaoj61Q32VgOkq6y7KWTLTH4Kv
	 uo1m9TTbghn+yiIvRvCz/qtzMObBSyF01iUt6CxsfuEo1Ud11uxghNBdLzjIRLJDNg
	 KkJ+8KCT4RrM7iOiFsAHLdrCsh0aFgF0IWD6d3WxuQH148veN8DFyw88k/U0D/8DLu
	 qYFqPyKxL1wNw==
Date: Thu, 9 Jan 2025 08:05:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast
 addresses
Message-ID: <20250109080507.1ebb77b9@kernel.org>
In-Reply-To: <CADXeF1FxVt=xt+yk_SvLSYBYw07Vy6pssSfXqv8pOQuP7obPgg@mail.gmail.com>
References: <20250109072245.2928832-1-yuyanghuang@google.com>
	<361414dc-3d7b-4616-a15b-3e0cb3219846@redhat.com>
	<CADXeF1G1G8F4BK2YienEkVHVpGSmF2wQnOFnE+BwzaCBexv3SQ@mail.gmail.com>
	<CADXeF1FxVt=xt+yk_SvLSYBYw07Vy6pssSfXqv8pOQuP7obPgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 00:01:31 +0900 Yuyang Huang wrote:
> For this patch, my proposed steps for adding test are:
> 
> 1. Fix this patch and get it merged.
> 2. Update iproute2(`ip maddress`) to use netlink.
> 3. Write selftests using iproute2.

You don't have to wait for iproute2 changes to be merged.
Push them somewhere we can pull from, and when you post v5 
(with the self-test) just add a link to that iproute2 git repo
to the cover letter. 
We'll pull your changes to the iproute2 used by the CI image.

