Return-Path: <netdev+bounces-230622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C746BEC057
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D55144E8D86
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114930CD9F;
	Fri, 17 Oct 2025 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHYS+HK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF4305E2B;
	Fri, 17 Oct 2025 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744338; cv=none; b=QDrH6tmYLiLuq+8t+TXlrvJT29K4z/MEDX/jjP5i3DHDkYNTxtp07d1EW06tELtt8XzYIZEz4hCFGA/zdkBQLku+qECZj8aBp3sLg5y/pzY45tsscP5lEiNCXMfdcNxihF9QD1jfpz3m/8HV/foWImsLgrDVFBlbcuF3Enz3nnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744338; c=relaxed/simple;
	bh=yWJBGnRHcN5jHpeMnCgodPUBcGd5S5BDDyMZx5cTyxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvKzT2jvcot2s3sa9LiFftFaCGUFYyjdIfwgLipSMpWrkEomvF5cWvVrksAu3mdiJOsC5JbDEHSzeNLhH3ADd/F2QCsBSvi+KlsyOwwhTHRNiXPLYziVWZHwjRaH6e8NKs/WD3ifPlnvga+302Han8iTo0JtfGjdHOoDoRpAvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHYS+HK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75366C4CEE7;
	Fri, 17 Oct 2025 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760744337;
	bh=yWJBGnRHcN5jHpeMnCgodPUBcGd5S5BDDyMZx5cTyxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JHYS+HK+LQRtZYB6/7XUx9FWdPJGOPoQ37NLbVYkppMcYShLk8I7pZxTNwK0pGquw
	 iNoc51lSZYuD0RQnnouvIZVpZ3rJCva4H7k6+DNGt4VvRoogpGqjiLGh2gJ0gjlrgY
	 GD/6SBtKbTUCS5N8KBBSalgntFFZWGKgZAlOFkqotDFcmi9AiAcFFFbjg2gwjjurPE
	 K5Xseyo6rKS1h2XpM5D2em95beme2tc64eHuzaKhUFW6JfnH8WRdVfZdz4PI5YYoTP
	 ++XMLz1ElOB+ZT28uiyHm9Q2eIu5zXVjAtyGu/3d1XUKlg8rdO0u3N5a4s0W4HW6sb
	 KzB7saizgBSSg==
Date: Fri, 17 Oct 2025 16:38:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Wen Xin <w_xin@apple.com>, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: fix header access in big_packets mode
Message-ID: <20251017163856.4c554cc8@kernel.org>
In-Reply-To: <1760662656.1338146-1-xuanzhuo@linux.alibaba.com>
References: <20251016223305.51435-1-w_xin@apple.com>
	<1760662656.1338146-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 08:57:36 +0800 Xuan Zhuo wrote:
> http://lore.kernel.org/all/20251013020629.73902-1-xuanzhuo@linux.alibaba.com
> 
> do the same thing.

Could you repost that? looks like there were some questions,
but nobody sent review tags even tho they were answered..

