Return-Path: <netdev+bounces-73806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2E85E75A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A042859F0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993D85C52;
	Wed, 21 Feb 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeG1Lzrm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED882D9B;
	Wed, 21 Feb 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544143; cv=none; b=nGhRB3nzBsK4pZO8lH0cAuwmaApB2EfcFeTGTDU5WgeQPgdP+rbLl6F/oPrvdtGbIHGjk32jGz6hc+KCFKpvkelba2gvxnbWoZrnVEmbNyV3olJTD42MPYidFCD8hRYsPu3jaO4Q9Xt+ZNAVnMi1zxxORSJMLl1TCJBw3dyiIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544143; c=relaxed/simple;
	bh=34D8p3NDBVFvyPZL9n0vCvEP4YzGyWGNIB1azgAxsuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgRB0ZbbCTZBq2Xyr1Ukg/54mt/FsMsUCvNmn/FG/7mDHMzeQqKSBNb/v/qfFY+43LvrQRp5MclaQY2YmS6NTKyjt1QjvX+d720E4OmzVH+Thx6m9AJ/qYvLfUhxvcKAoSHDWhcbeOjI6sh0Eu1Hrx57YXIMAaE9TnZQeNcil8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeG1Lzrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2372C433C7;
	Wed, 21 Feb 2024 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544142;
	bh=34D8p3NDBVFvyPZL9n0vCvEP4YzGyWGNIB1azgAxsuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YeG1LzrmN9Pv6OJZJg6Tu5LfnBEQC49LhtcibhWBEaxBL6JcOWxfATbZ0euCzN6zp
	 GA4PRaBmlwUiAJk+Ik6r0le7NhaGHdrq+eABxD9i7JGO1kudwewDcTAxRAU2s498Uy
	 M8t6YYeriUCqvrxqFRZyOdXvkiQjxmhzVTs6RK8zMZdj8XI7ONx/16+rI6GUyDwJFu
	 +thlIZJJJQqbfy+raMYPWjtgJNoLy09Zhi2SwSXDeV5ybcD2wnBzbx3W67uDYUqw4j
	 l1tPqJDlnyHutC2skxTEqCEPnmdj1vIPdGrpYgQDU4zf37Ao1Blr2VgUepaeh5ibcQ
	 B/mNgTTrxsmVA==
Date: Wed, 21 Feb 2024 11:35:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, John Garry
 <john.g.garry@oracle.com>
Subject: Re: [PATCH] net: ethtool: avoid rebuilds on UTS_RELEASE change
Message-ID: <20240221113541.76161ac3@kernel.org>
In-Reply-To: <CAG48ez2tr8k0BqM_Lq4VAMRfrEdYhWudK1Fx6HwOEb0TBPDd-g@mail.gmail.com>
References: <20240220194244.2056384-1-jannh@google.com>
	<20240221112309.7d526047@kernel.org>
	<CAG48ez2tr8k0BqM_Lq4VAMRfrEdYhWudK1Fx6HwOEb0TBPDd-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 20:25:00 +0100 Jann Horn wrote:
> > Is this related to John's work from:
> > https://lore.kernel.org/all/20240131104851.2311358-1-john.g.garry@oracle.com/
> > ?  
> 
> Ah, I didn't see his patch, but that seems like he had the same idea
> (but implemented it less sloppily). You can drop this one then...

No preference on my side, just wanted to make sure we don't have 
to decide within netdev which approach is better, not really our 
wheelhouse :)

