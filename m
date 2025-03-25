Return-Path: <netdev+bounces-177466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F8A70451
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96923A81A7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4025A34E;
	Tue, 25 Mar 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApmRnb3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D225A33A
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914367; cv=none; b=L5g47xiqALwLw/0+9Qz1e7OyYnd9sSDWhxvdF3SVCQ1xBjMDZ7GEtmmm29+3APrlGscnbNBYTL4jhh+TBMNlk4hX61TDpRarYk7Qcz4ceMW0AjpRZgI98F0i5YrNYLBVLQfw6+AE5q4PHQqtyNvNsn2ozPocjpeNm7iVkjbwP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914367; c=relaxed/simple;
	bh=WNvniegKB5ebyROpjTWuKs5PqfIO1x2aCrY/vzmhQEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYgmT7kTfdRa4qMEohImGCyxMZ48yff+c+GRMhuiv42seumxwd+J9eZo5yZXDFrOJOj6oBOT6TFA+xSEPrZmcjGhYS0YLfctC3ffn0bMOcziujmJ8OI6Ra9ImIuv9yk2aUSxXxA2TJiPofmy2CS8t6ePlDmoalZnAX9H/Jyt6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApmRnb3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9468C4CEE4;
	Tue, 25 Mar 2025 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914367;
	bh=WNvniegKB5ebyROpjTWuKs5PqfIO1x2aCrY/vzmhQEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApmRnb3OwFY+vkLU0a4lGTIBy+82seTaubj4XnhpQJvzB+8LghCMg0HiMpqPKP34d
	 XhyF9m4wr7RnJMBquQancGy3JE31WZ5taON/drbdB/wmHGwN3MZ+wrQm5NRUvmsRZH
	 gfA8CIgxdEd/RBh36BxkG9z1NqDB2ot9kF+2mjpd/60hsRON9v3EunE+3uxrQq+il+
	 Oz2VLFN2ZN/7VU4hqED1rR1V3hI2EDLa4JBmszeHjDHmNYugp4/EDYjuLGmZewkftd
	 rwS+tV2uPslBRun/3d87ZQwOzAyqNiHwTL1LjEOQEBgYpMUmV41N4CJFNYkp3I89Ls
	 y9XnXlJ0W4ebA==
Date: Tue, 25 Mar 2025 07:52:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <20250325075239.5e0124a9@kernel.org>
In-Reply-To: <20250321021521.849856-2-skhawaja@google.com>
References: <20250321021521.849856-1-skhawaja@google.com>
	<20250321021521.849856-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 02:15:18 +0000 Samiullah Khawaja wrote:
> +/*
> + * napi_set_threaded - set napi threaded state
> + * @napi: NAPI context
> + * @threaded: whether this napi does threaded polling
> + *
> + * Return 0 on success and negative errno on failure.

Please make this a real kdoc (staring with /**) or delete it

> + */
> +int napi_set_threaded(struct napi_struct *napi, bool threaded);
-- 
pw-bot: cr

