Return-Path: <netdev+bounces-93472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCFE8BC0AD
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E4CB20FF9
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CEC20B0E;
	Sun,  5 May 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFIEUiAM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42E1D556;
	Sun,  5 May 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918255; cv=none; b=MWPb6o8QlBDyTWt87VRihjNreTbcwpHuq0soJmyuYXWSzC++wBNNvO9v/UDxHPfxXqAUe1s9w8/beQsZjmYitSxOn1UPIb6+cwBWvDgub1OPedEOU6gwfQW1q2ZftHrqcRox5ts3yGubVfA+oEagTU+lP+vFauqU9APgloRKBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918255; c=relaxed/simple;
	bh=l+QfcIw/W4/Qc2ykMKKcLoG2Ca5/57nuM2Klcz8YbDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TesLaXj/Lj2peJN0GpDQrqcrezNzy5cOSiDHTDw6sWfN3u0xz2vNuGGScVYsU+MiaOA+zjVjz8R6qlG+Z8bfF0NLJIslcyoOfsJy47whzpOm7Q/kut78PCt+tw2V/PiNXbs4aR1B3FtJ2VlNbHxw+/l9CPpEd/hBjkmdm5NyJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFIEUiAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8097C113CC;
	Sun,  5 May 2024 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714918255;
	bh=l+QfcIw/W4/Qc2ykMKKcLoG2Ca5/57nuM2Klcz8YbDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AFIEUiAM/BjVulzegPCT7NbxWJx5GRxjCvUwSxRsgBrGPZ+pVPWSdLEdJuHgSBEi2
	 b9oKv09rOUN6X+lfKSHwSzbnaEcFGBd1hGykFtI3uk9+nbYpY4S0wGO1v1FXZkUvKK
	 ZoQ26I5Zj1VJRwt2tcwtZS4SjO0vNA+U5Jmg6nO3dTltebWw18Ydi6K+gJutbehFK8
	 5zKaXtEb/beNmzI/flyoeXssFZOepZIcYk2Abz24RPV41odGYpQIdhs5ntkToqT0P1
	 TSGLsm49gGd7b9Qxc2aTpZOMCBhS0o4EfmorLY9Q6PZRl/GZ7PeBaGp8CgRzl1kivB
	 15VDKyMyr0KjQ==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240503111333.552360-1-leitao@debian.org>
References: <20240503111333.552360-1-leitao@debian.org>
Subject: Re: [PATCH net-next 1/2] IB/hfi1: Do not use custom stat allocator
Message-Id: <171491825157.204646.10648523184290579853.b4-ty@kernel.org>
Date: Sun, 05 May 2024 17:10:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 03 May 2024 04:13:31 -0700, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Applied, thanks!

[1/2] IB/hfi1: Do not use custom stat allocator
      https://git.kernel.org/rdma/rdma/c/5194947e6a3966
[2/2] IB/hfi1: Remove generic .ndo_get_stats64
      https://git.kernel.org/rdma/rdma/c/f483f6a29d4d70

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


