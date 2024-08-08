Return-Path: <netdev+bounces-116906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3994C06B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B82875FF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62D18C93B;
	Thu,  8 Aug 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYkPZ2nl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7918C906
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129187; cv=none; b=L9iVPcuOC7/8ADPNuDAGrS4CLZuhHya6NBCmbjUTyXnlj91S6K9FJ2pCm79J0SnS3zAPMfG4XchJXtNQ1R1UhrXk1wsFem3LYDPsZ8W6X4CCRBlR5uWExo0ToOtFeI2vUsbFEB0PE2WfrfLqC/mc5Ehwr64obqVXnsWsgvwJgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129187; c=relaxed/simple;
	bh=0Kk5LxWe0q+WDUIJ3nthuIoYttKENM2HgYwW+l8XooY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Owi+qagEFiD/8B4CPGhR2V7ogcLB9XT5lZ7ge9vF5eJscXcccp7BwOLYd0fX8vk+etmBFcTuNkVDh5iz5tBZ2slP+nytXBih+78tVhzynqhLSo0ANqL0v/m110J7m2FuvXt+6PhohoqBxxb11bluhFT36jsLsDpiiRlzCHSDht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYkPZ2nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD2DC32782;
	Thu,  8 Aug 2024 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723129186;
	bh=0Kk5LxWe0q+WDUIJ3nthuIoYttKENM2HgYwW+l8XooY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYkPZ2nll4zT2qKcJ71H01yWl9WJGjeiSGwFH835orklGXNtsxFRR+VEmOj2B+uLU
	 sY8iDLghC4EDZ2bgzUPckEedCPhyrFrdGLcucFC7J1MTZpl2yIxwtA0z605GyT4qBh
	 o36jqBCH2qGRiscID/ZFpsVT60/4mnkYA6Lj6FPC4EnXyOv5HYQgrdv+aIEZ8dpAL8
	 pMztWiC+dHZqI0uc4RxGFYvQQbUvCIKhdZZaJQhV1yi9kgFMq+GDc/YKWQH/xgC8vN
	 oagSIX8iOwhsiAylx/ZwdcgHjeXC8JPD6DPYVTqb6nhUwhRrEszV/3R6pabV59d8oT
	 nxXjch1wyY3OA==
Date: Thu, 8 Aug 2024 07:59:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Duan Jiong <djduanjiong@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] veth: Drop MTU check when forwarding packets
Message-ID: <20240808075944.0f9ea2e1@kernel.org>
In-Reply-To: <CALttK1QuYdki3pcd_kVe=feb-XKTSfgxyZCA18DrTBmYN3v9=Q@mail.gmail.com>
References: <CALttK1TYZURJo8AKtGQFcKKMvzssy3mF=iG9rODqvEiPw_qqpg@mail.gmail.com>
	<CALttK1QuYdki3pcd_kVe=feb-XKTSfgxyZCA18DrTBmYN3v9=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 13:23:56 +0800 Duan Jiong wrote:
> There's a problem with the patch formatting, so ignore it and send the
> v2 version later.

Kindly, please read the documentation before you send more patches:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

