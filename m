Return-Path: <netdev+bounces-109732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41176929C9C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7210B20BAF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E414267;
	Mon,  8 Jul 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLBzB4nA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799818EAB
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421900; cv=none; b=fCh1wItC2T0Bc+e5BE3cN3d5jGqVjkb+BY6ob6G2FRB2zX3ORbPjkeowcuO0C0HYgZFlpp+8pWOrC9S2M+bFok5vpSvLIMdAZJl0Oza8ol5WyKjs0+tQNtHaIDV0oD+urWEDHFiekXeelLdnlKPBSYZCj12jf8RXyyTyd6lvqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421900; c=relaxed/simple;
	bh=u+R4nqKeSHVCRuwl7qu1FjyqOwxgvSGHex2gDMv05ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPDwxj8i6m+AZB5+GooRWfne2rO2tV+3oed3nJogKB35odWdx6dBWq6JUFrIeWY2xtG/CuyRe3bu3EYRFi+oJogZIVLg3qP6POB8yRmJdGWr7kT5Z+XaTbUN+w+n9J09xH9BK3n13Wry1YuVt/UCrJvYax+DW02tgFONDdZUiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLBzB4nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D697C4AF0A;
	Mon,  8 Jul 2024 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720421899;
	bh=u+R4nqKeSHVCRuwl7qu1FjyqOwxgvSGHex2gDMv05ck=;
	h=From:To:Cc:Subject:Date:From;
	b=mLBzB4nArIfh8zIfKEE91mrpxLAfvCZ81/PXEbiqLWph5Ewwn88AsBhLnOJPUEGuW
	 KagumFZCbpz1qPLZWKfg2GSEZTN/XbwBoTEcCcUxKz4bhysv0y4kH9B4OUBe0EoY89
	 +cRPD36cpXcZ+JOOdmf9hck19/pVgsYTkKLnhVSXXhYaaVReC4qtf+IEyrPtS6j6/Y
	 DBXhcequ+vghNCQJIYyaz364O0FNJSkQZbjbrfnFXUT/0tFiF5G4bLASfUhZxddADi
	 fTzloLXoeSkzZBU+ydcHBu6+HLTWjO5dUyeHi7PY2H30ZvJJXqkLuP1HSNwTZDhW5s
	 zY/pwGruyAZrA==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jianbo Liu <jianbol@nvidia.com>,
	netdev@vger.kernel.org,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec 0/2] Two small fixes to XFRM offload
Date: Mon,  8 Jul 2024 09:58:10 +0300
Message-ID: <cover.1720421559.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series contains two small fixes for XFRM offload.

Thanks

Jianbo Liu (2):
  xfrm: fix netdev reference count imbalance
  xfrm: call xfrm_dev_policy_delete when kill policy

 net/xfrm/xfrm_policy.c | 5 ++---
 net/xfrm/xfrm_state.c  | 3 +--
 net/xfrm/xfrm_user.c   | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.45.2


