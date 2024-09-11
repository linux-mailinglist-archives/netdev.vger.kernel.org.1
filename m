Return-Path: <netdev+bounces-127182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65CF9747FF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC3F1F27471
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B4224EF;
	Wed, 11 Sep 2024 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzMCClfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6E282EE;
	Wed, 11 Sep 2024 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019883; cv=none; b=hX56KOczYJG4GnqYG6obcmDCiXESI1iyVmFtrq8wE1vvSkkgueWtxpfksVb4eaiUsXjy4hBonweJH/rsDgeSvsQus5knXUcPDECzu4eWnVpk3ue9G6i4oukymIH6yHJXmOd8BrUG61l+SPDX/Io7emE4aJbHPXMkk06X4Ocbhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019883; c=relaxed/simple;
	bh=zkdw2rH+TkLEzbIu1yQDGVOw/xkWDfXnjb56Nw2onZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvhrFiJ4YV0B7tyF48uzn8RIimFEh7M+gzVxWbHMvj4yAH1Makt4kpa84YTYwHMnEEsXX/s3pvqvtRVKQTYI58sG0VNpp7nhZsOmvtYv8IiEIPet7hB2puVhB4bIMMMXBSgVdt80otXtAHIap1lybt73PIc4U8X7N725mvVgDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzMCClfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037FDC4CEC3;
	Wed, 11 Sep 2024 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726019883;
	bh=zkdw2rH+TkLEzbIu1yQDGVOw/xkWDfXnjb56Nw2onZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzMCClfAAlELgdZ3S3PJjAKBn0cPA5Pi6yy8hF0jcKIb3RwWk2doKOWnHTuAJpah2
	 Z6fmYFAgcpQ+CGha9uG4vFKmEPX6BXvjAfCtUNEsa+AmO99KfnbcLD+8Y0MR9oII6L
	 lAR0R7pFhS9v2kdkJu8YYrEA5g8ffgvAGbXf2rSLoU2jtTeHF/Kt40cJVlmTih9LGI
	 QeGac2Etm3Ed3apGcfU8/2Lj+xKg4FUXIwDlbwW3UoZPvHH+1/kJjSgVzwFD8yDGsr
	 9hZ94KEp/u/R1/r7OhIWvdo+Ky7Hx9IW5iUcPo11KeOYet2RB1k0mFjCHys7M7Pxxq
	 Kdsy2aWYuNhyA==
Date: Tue, 10 Sep 2024 18:58:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Robert Hancock
 <robert.hancock@calian.com>, linux-kernel@vger.kernel.org, Michal Simek
 <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: xilinx: axienet: Schedule NAPI in two steps
Message-ID: <20240910185801.42b7c17f@kernel.org>
In-Reply-To: <20240909231904.1322387-1-sean.anderson@linux.dev>
References: <20240909231904.1322387-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 19:19:04 -0400 Sean Anderson wrote:
> Additionally, since we are running
> in an IRQ context we can use the irqoff variant as well.

The _irqoff variant is a bit of a minefield. It causes issues if kernel
is built with forced IRQ threading. With datacenter NICs forced
threading is never used so we look the other way. Since this is a fix
and driver is embedded I reckon we should stick to __napi_schedule().
-- 
pw-bot: cr

