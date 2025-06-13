Return-Path: <netdev+bounces-197300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7CAAD8089
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91BD17DB85
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4CE1DEFC5;
	Fri, 13 Jun 2025 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxX/k8GD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D42F4317;
	Fri, 13 Jun 2025 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779493; cv=none; b=KjGAUc8iBZPhLWR29ZgIY9XxteiRi2PbKE8Yo9eRUfJ3E7/2AnYjcWx941U2HsZDSbxosNQRcSJ8ZRU/vj7Kg0GwyEt6gsDwVS1gPggEY6+gBGwkhwg0waqK584aGe8m3ttLIZoIbYVg505d/NofyGC8QbtE8MCrzUCWTee2jdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779493; c=relaxed/simple;
	bh=WerzmcePogAhOAEUQKyKl7DNHF7nIdPv2rjso8/0Jxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWRVSO0yDT8DA/i0Dkx0j6r8eI2wq8V6pK35uXCSH3Ot68yAdYFe+1fhnDQXX3CTBmtQKYZfY54ePQoiKHL1gq2Xds2QYtghQVhTs3TcPRRit2NbJbmDuvE+pwUq0l02zIvRC6oGLIEkzfNK2LjI+zPni8+78giJnD6w3PlhVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxX/k8GD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFF6C4CEEA;
	Fri, 13 Jun 2025 01:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749779492;
	bh=WerzmcePogAhOAEUQKyKl7DNHF7nIdPv2rjso8/0Jxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FxX/k8GDCQTidgCSb0fHWD2KanNqCxoSUADDHy6bhDpjgglsYeVdhhsifLy57hJ1O
	 Pz2UiAPZC30S4WsLOBk0LT4Nsy/cFdtLddYh+RtQmxfLB+fI1vUb2s/CbuyZSTh2WA
	 KRSKqvvOKm4GBzaJf8tXY/OG/zKrqxJOFKuoyIhCO9RQqNRunugPvV6F2Fvjxix68B
	 6mz/cQuEhtIOXqtlM22I8TSbOVaQic4OjalUu1wHtTSfe7qDIJ4gx3aVuff3c2AS53
	 mD5vWoinai5rtOO0n+DASr1UIthz2I479L582gVGT1Owe8ld9m+O6aVy6JmFkXeR9n
	 ZOcpQDrj1mFlA==
Date: Thu, 12 Jun 2025 18:51:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jun Miao <jun.miao@intel.com>
Cc: oneukum@suse.com, sbhatta@marvell.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Message-ID: <20250612185131.2dc7218a@kernel.org>
In-Reply-To: <20250610145403.2289375-1-jun.miao@intel.com>
References: <20250610145403.2289375-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 22:54:03 +0800 Jun Miao wrote:
> -			if (rx_alloc_submit(dev, GFP_ATOMIC) == -ENOLINK)
> +			if (rx_alloc_submit(dev, GFP_NOIO) == -ENOLINK)

Sorry, I think Subbaraya mislead you. v1 was fine.
If we want to change the flags (which Im not sure is correct) it should
be a separate commit. Could you repost v1? There is no need to attribute
reviewers with Suggested-by tags. They can send their review tags if
they so wish.
-- 
pw-bot: cr

