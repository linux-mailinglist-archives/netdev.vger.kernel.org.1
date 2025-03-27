Return-Path: <netdev+bounces-177998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93915A73E5D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B5E173369
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1331C2443;
	Thu, 27 Mar 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akcHX5AF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A41AC882
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102502; cv=none; b=ZHf4sKK3WWmSvauUC3ITHGCUpZleDG9u1kNFEcddEfa0w3kiWBqjoyOjIAwPe0Oe2QtSP8yt9bnNN4VCiDBPgN5qw1QLOG9c4sLgIDhDiXV1YczqqwWMAIIjS6U3dDaZHmv/ZUplAyXlCeGlNeMiEbS/k28yZeGWs9b/0lMHZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102502; c=relaxed/simple;
	bh=SJyY6h1qeZwdjqv4MMak5ZqJGeD1vHVj2GVP2XZLR4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjKvebwrMsDM0QjWrYdjrgINNmAC1vI9t4WmMgUVD1fMYVO/XH98hfJwlKA4BT3ULu1y2YsJoAXRyHAr1NgOniID+fplG1zx7P23w/eTSf6z+iMvutWZSR07YeMxIRW/tbz11ZtJx//uFsak0asiUPQXVibXEB/xnRJYPuofEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akcHX5AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56628C4CEE5;
	Thu, 27 Mar 2025 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102502;
	bh=SJyY6h1qeZwdjqv4MMak5ZqJGeD1vHVj2GVP2XZLR4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akcHX5AFW/GvDtDtU+BmdinTcCzO3PJfwp3XRDjhRZtEly20pSGbtVcLpXOOTQ2iv
	 46YmJpgsbO0UOSch8s1U6blXObcC7DYdtMk9I8Rxtda2GRGdEFIGFYQ+BnwI/k54eu
	 rxg/2Fd5o30VDVg1srSbGJ7HeWCsHA/Xm7n2Xk8DXRVssChF8CKCJdrFCzxphZWELW
	 RmNo46hxWAKVxH6gPH0ahs1H5UbJIgbngWZlK51ajlLVdcM9dik+mnY3qNXTsQCysF
	 p2eyqjCWfYlT1rNzu850avWsVk55ANyFHxAeKN3jD9Xl/801ptx85AbIFrS+C2aIR7
	 Tv+Jz7WdpEojg==
Date: Thu, 27 Mar 2025 12:08:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 05/11] net/mlx5e: use netdev_lockdep_set_classes
Message-ID: <20250327120821.1706c0e3@kernel.org>
In-Reply-To: <20250327135659.2057487-6-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-6-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:53 -0700 Stanislav Fomichev wrote:
> Cosmin reports a potential recursive lock warning in [0]. mlx5 is
> using register_netdevice_notifier_dev_net which might result in
> iteration over entire netns which triggers lock ordering issues.
> We know that lower devices are independent, so it's save to
> suppress the lockdep.

But mlx5 does not use instance locking, yet, so lets defer this one?

