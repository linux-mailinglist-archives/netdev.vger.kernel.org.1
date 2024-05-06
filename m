Return-Path: <netdev+bounces-93719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DBA8BCF38
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 15:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C51F21281
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDF7EEF8;
	Mon,  6 May 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRqzGrau"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF897E590
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002574; cv=none; b=R+3f4C5u2z+pYi6TXoAG7ApcB6tLBLYqEat4+xQsfUxZLEIUEUqYT/eGDPpm1HnZIqvM3r+DkXDM+95q7/0MsIm5Vfmu1SvXjvSvgRa2NT2Piny3dbQHEG4NqYmDBig+fHYuKYv2rEoUTpAAbz2LTDVL84yXTo/Y6SetUZjinyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002574; c=relaxed/simple;
	bh=qEg5tsw7oCUciHu1UxEwn56v4YTjb6SllqsPYR1I3jA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkUft6AAiyMcB1IR18HLBfcUSNMv1DU4npgo78A4spKECJjiCzoOJkG4XMGV8idw9oboJqqsDUJQXfuhfFPtiKfKgIY8TAhYBr0ZhzB7nnHtJ67cdrBotQK9MWt7timKqzYmCU9hj5c/GK/XSlncgA7/fKuVH+5GKiZn3wrOm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRqzGrau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0DBC3277B;
	Mon,  6 May 2024 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002574;
	bh=qEg5tsw7oCUciHu1UxEwn56v4YTjb6SllqsPYR1I3jA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oRqzGraua8+4zOjxJQU0u2nRIb4P9awyVFI3ovo6evNcNLXbGKEG1o8hNzYQP9708
	 yE/ylfeDsUVIulB6+kA2bBuD7osg4ewdGU5lelU0ChxJ/f55M2a40R4r07uphVWnWF
	 87eBtYVrN3KT7MrQIqPoyXNcdKLgg7e9uvWVaNGd5t8+sf1yxJCBbc2CfTN78np5MW
	 187pXq8xctrFxDUUhYX10cn9xIUNfCRtRw7i5zWXrcJ44raBhMjISV05Qyqz1P/6Sj
	 BcenS642/0+7jMJb0gjVvJJz1HA30hUSG0cQDDZCTOY+MtLgeoblfwTWc0snWX1Exk
	 ziPlWY2i65KlQ==
Date: Mon, 6 May 2024 06:36:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <razor@blackwall.org>
Subject: Re: [PATCH net] selftests: test_bridge_neigh_suppress.sh: Try to
 stabilize test
Message-ID: <20240506063613.15568681@kernel.org>
In-Reply-To: <20240505145412.1235257-1-idosch@nvidia.com>
References: <20240505145412.1235257-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 May 2024 17:54:12 +0300 Ido Schimmel wrote:
> I'm unable to reproduce these failures locally. 

:(

Maybe version of the tools makes a difference somehow?

ndisc6$ git log --oneline -1
92e5d1c (HEAD -> master, tag: v1.0.8) Resync PO files
iputils$ git log --oneline -1
1c08152 (HEAD -> master) ping: Refactor socket mark failure handling

