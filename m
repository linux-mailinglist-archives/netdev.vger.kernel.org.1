Return-Path: <netdev+bounces-193802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20286AC5ECE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35049E2F69
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7B136672;
	Wed, 28 May 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMWjjY35"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177488C0E;
	Wed, 28 May 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395831; cv=none; b=ueBcw1RSkIO+LyPDyovaIvbEf+ZdBb9zN8NQJxrVAGayKIyEP4aLUFfp2bibwJT2kOBJ4AtJkp9J7JeGaW8Czru2mYzCx0s3XE9uJhe7uOxDENTsG2Fj7SyoGLttPDvZOik6nffdnHA+uMvxFUVuBXyLd8TnjNENOVExGEmQhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395831; c=relaxed/simple;
	bh=xmLIszYoDwjBy4Ya5Nrjwz37sz09hLjWrnjs4tzoxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMqYFhX80Hr+ZS8u8VWuXMamCgu/k0H2W1Cid3gFdTGvhayV4B2DTAde2XLctoAJ9MkgDMlYyqDloJO2iYFTG6ehzx8OmwKnQ+mNF7qrHcRQI+lmyVeBLp6U6PZBSZeLoa+TuyyVz8yO0rG0NNEktrSheW1twmVgAKEp+VbdtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMWjjY35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DE2C4CEE9;
	Wed, 28 May 2025 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395830;
	bh=xmLIszYoDwjBy4Ya5Nrjwz37sz09hLjWrnjs4tzoxAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMWjjY351iYisgqOnXpI2b+8vAgBGVDwAsa7g/yeAnnvajZqpeJPpPnIZFxIMnZgI
	 SCcQrtJCqkPJ7S7kEdA+U9RhJXQeOE1adTXC8laWgwKbiaXB38vSdEXe1CeZto8vi5
	 tY/p7vphnb2BFuZVae89rvHjT+FNl6OwlKPEjvrGuPXQg5SxdiSfaP2FB2zHRpygSk
	 +x/9hx5OAmDnPy27r8IvjO9bMXTkvi+SRVSop2scLXIVUmx2ugwpzJ/jqGaEEWK3Nf
	 wDaIC6cIUXWraesI8E0dczB1iEHYZk+ipEUFsH/jy4ue9Z73pjvt1YQ4daT5kwBpWd
	 ywLL8PdZYHRJA==
Date: Tue, 27 May 2025 18:30:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org,
 andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me,
 willemb@google.com, asml.silence@gmail.com, almasrymina@google.com,
 jdamato@fastly.com, kaiyuanz@google.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: devmem: support single IOV with
 sendmsg
Message-ID: <20250527183028.37e62c56@kernel.org>
In-Reply-To: <20250520203044.2689904-1-stfomichev@gmail.com>
References: <20250520203044.2689904-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 13:30:42 -0700 Stanislav Fomichev wrote:
> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> iovs becomes ITER_IOVEC. iter_iov_len does not return correct
> value for UBUF, so teach to treat UBUF differently.

Looks like this has been merged (silently), thanks!

