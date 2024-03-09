Return-Path: <netdev+bounces-78897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A505876F00
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17861282528
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68832182;
	Sat,  9 Mar 2024 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib0K33nf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853A2E851
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956135; cv=none; b=OeCM22Y6SQiVixPiA8S6qdhr6qiCVh6j6SCMSiBKKRra4okubJz0+FiTLBPn2WBDxfh7vXbfQlVZhiqJMAoDjmEFE9kl7PwtohMMiuQB5icR1PZ9UlBeSp08VYic/OmfGB9ABUKosVTlo2tS81DyDJGe1qMKcJhiDs/pRvnrVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956135; c=relaxed/simple;
	bh=RhgqKMT0EzLTHDptxHpozVfD6zz12kooT4cSbWoN7Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5Hr3trrA15OxsXu+chJJ4wjVRY5fUUt4Sekg4YCziNxIYVlAkrYHE98mFsEiQunrxMnEndZ2CbRzCptloNXYkNBQYd+f2jJtNfJV4XJFoNBae7b/6xL7GE9sC0YuhFpk+n4JxVilzD6ZS09oFmAnu/9iwZfEvm0ivBAvjqBlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib0K33nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67ECC433F1;
	Sat,  9 Mar 2024 03:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956135;
	bh=RhgqKMT0EzLTHDptxHpozVfD6zz12kooT4cSbWoN7Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ib0K33nf17LfVUaqKnLO86LgWwtapOpy7Ie4k9E1d6ZxL90YIYSkAOHtTcytZdemF
	 Den20HLvXsLY+tRvLC5VtqEaVtyGVgn1cbhOnL07YJZsoc6hBighGutENoh0W4N+Y7
	 LRAGpVr2flEa/4u29NPI54N8WObTZin+nD9LuEo7+wQnmyKZRsMsZCdq3D0dSE0r9K
	 twIIZk4x8S5/xO2mNKUELaz5Uyo688jwyFdNXtz6qwfGX5vsrgPikMek7tUi7/zwlM
	 eAYQDGBmYdTE2ojKRmYgxTfggq12oeKDZY6XbAFdfV4lA4DOOK2F69q10V5AwK7EUG
	 VbS+QYwBxoaTg==
Date: Fri, 8 Mar 2024 19:48:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Message-ID: <20240308194853.7619538a@kernel.org>
In-Reply-To: <87sf10l5fy.fsf@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
	<2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
	<20240308090333.4d59fc49@kernel.org>
	<87sf10l5fy.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 23:31:57 +0100 Petr Machata wrote:
> > Are the iproute2 patches still on their way?
> > I can't find them and the test is getting skipped.  
> 
> I only just sent it. The code is here FWIW:
> 
>     https://github.com/pmachata/iproute2/commits/nh_stats

I tried but I'll need to also sync the kernel headers.
Maybe I'll wait until David applies :S
Will the test still skip, tho, when running on veth?

