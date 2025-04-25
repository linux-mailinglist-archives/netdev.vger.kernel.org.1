Return-Path: <netdev+bounces-185803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D59A9BC5F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12371BA0F4D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362B76026;
	Fri, 25 Apr 2025 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzZWW9FK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD3219FC;
	Fri, 25 Apr 2025 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544892; cv=none; b=aQNKiwQ9g+yd/OeCM3dMOoocArR2KHAQAFLPf0YwDO5Mg397JVzdufU/0qPv8wwQfqLADWpUFymXknXB7qc2lL+dNoOQJJiA2EdjIvwEj2X2zPuOIpRIauCtPpjOJ4kkE+0NNXuAkR1yJFnjYhnUllPQSRFbUtLfGyEGJwSG/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544892; c=relaxed/simple;
	bh=oOaYkaS/qZ/j69534YB4WXg9JzG1tuS4cM2YUrZRMcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsw5MonGdLZtQkTcaqULYczauGi+BscO+aTfNlaMve//+rxCXI67799WOEGkHm7Dl9qe5xrfNQgCENxqgm+0RBUmoIogE0aV/l3C7wj8uHXXiozPbB6wt+1moAPMV/nbEqUJEcViUpyIY2/PmK0BF9LK5NS7zHXyFaDcTCAwVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzZWW9FK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D5C4CEE3;
	Fri, 25 Apr 2025 01:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745544891;
	bh=oOaYkaS/qZ/j69534YB4WXg9JzG1tuS4cM2YUrZRMcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzZWW9FK50e+W99VufmV7I98NPvW/oafB2wEa01eq+9zbPbrqr9x69iW0lLSg8VPM
	 jBiV8e3KSZaPIQY/ZR1LhwuQp0f+GzoKX7XGtxbYslOvAKs53iF2MG3O5EMgnlqB4J
	 l/WxzqHzBt0/KAaSu2mqKB7G4c90VVOhVQQnsmGqHeq6RIWDiHUpoB/iUSpwbSlPsw
	 ISrQJJryQo/LOZt5iN0lazaXA1I5+WVIjqCJr8y0kNATq6MwSvnGDUeiiJMVVTeugM
	 7sdgH2GgUwQ7bsCoRpDtdnEj9MB8gYZIcXIke1J9TvB0/KufQDujgvE0gyI7uSNou+
	 WYVEXrs7Tda4Q==
Date: Thu, 24 Apr 2025 18:34:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing
 rx
Message-ID: <20250424183450.28f5d5fb@kernel.org>
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 17:47:13 +0700 Bui Quang Minh wrote:
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.

This conflicts with Joe's series slightly: 
https://lore.kernel.org/all/20250424002746.16891-1-jdamato@fastly.com/
Could you rebase on latest net-next and perhaps follow the comment 
I left on v4 ? 
-- 
pw-bot: cr

