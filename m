Return-Path: <netdev+bounces-135379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23199DAA0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4627C1F231BD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629794A23;
	Tue, 15 Oct 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTEwcyuM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35593EC5;
	Tue, 15 Oct 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951720; cv=none; b=GRMKuz8tqIBX+Dq9AwlR7tsTahYWwikkKOYfu0YHN21tk5fd1P5vev/Ia7c/5MPyR83F2gmjV3Xt1McJD3QkCGFZ/3I/CNiYc5lSerHcvPy8znwAjpUqkIXfmUmksBfTkAqvuzDBfapFJqpB4SFT+0w+vyB33ylPIFW5dSoWnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951720; c=relaxed/simple;
	bh=F6LsR74Pcr4qDOMrQ5b832ATE5Z4Wc/E8kzsSK65LIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBwsXvFwlCuZxv42reaUmBGrccOl6lxZVMrngDCGmJD7MOsZQKywE8i9Z9GstMzkT851N9uGzR9K3gxFMasu8d+GR3nDvKh4vAhqmNeDz5t7Uj4byl9UE/n+LGX0yeJTB+S5pnxH2nurh68SiLTJqChgC2ZFIqpvsEeLJFXaLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTEwcyuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5059FC4CEC3;
	Tue, 15 Oct 2024 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728951720;
	bh=F6LsR74Pcr4qDOMrQ5b832ATE5Z4Wc/E8kzsSK65LIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTEwcyuM+ULdLslkrEqqvoYuJ/okzGGUqsdWuuvbeqaVJPcPIU+0G7DY6+DSLLBqM
	 y3Iq6OrI2Ke8MErvWFMdGE8CMrAVC3lwWuXSd51P0aMIOwDowwmNi+bYqh+vDOurg9
	 YUlIOja/P/HGOpHhZrzDqda4Fm4yFnrr+W2CiFtTGyqYgdUQrEKBF5zS4QAWYOMX7y
	 svn5SJqR/1BkSGrzCO3VrTaB0L7p2Ql0OkbVVrlF6qNSEpJF+sV3998Sq/rI+nw6CG
	 yvYKkDHPcdip98GxDrzxwrAoeLJzyOMfUnHYy+4w/K6th7q3qYPxQMyYOsrMkdVvJr
	 PdBi5OvL1ip8Q==
Date: Mon, 14 Oct 2024 17:21:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
 gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
 razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 00/12] net: vxlan: add skb drop reasons
 support
Message-ID: <20241014172158.382fb9c9@kernel.org>
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 10:28:18 +0800 Menglong Dong wrote:
> In this series, we add skb drop reasons support to VXLAN, and following
> new skb drop reasons are introduced:

Looks like DaveM already applied this (silently?)
so please *do* follow up on Ido's reviews but as incremental patches
rather than v8

