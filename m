Return-Path: <netdev+bounces-127852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E951976E0B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2564F283E3E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4951B9845;
	Thu, 12 Sep 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6gSNx66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D221B4C3F;
	Thu, 12 Sep 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155803; cv=none; b=d1SS53GlYATPHGXd2bJ2BTzT8IBPzviIwpXRLPUNOll9JmKkh+cAILgOmymJEtfYsiKpocQKxfkcstzhArIpagddC70hl5yiOpbkBeYn7sSxeD9EoCAj7hEVBgWQEjpqCkYEl4+xcO7Y8Q7Fh4DfSXQ0Il6/L0AxoS++WN9hfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155803; c=relaxed/simple;
	bh=1dnbxympOIF+tngqPF0O0fLCSge+TV8u1h+YESuf8L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV0VxFIYwswiy7UV0WzwMkhqmFV43vLOMTxuoeSRkh38dpc8gc8AMWsX9W7y645jSK5p2ReuaqWfLdWh0hgu+GS54EDHNHw7cydAscdWG5JIMHrGIRn21bMXDEeGtd9CG9YZ1gjUrZA5eVzjJrrdT/aFmj1LXllpelQJ+N9qwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6gSNx66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79B2C4CEC3;
	Thu, 12 Sep 2024 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155803;
	bh=1dnbxympOIF+tngqPF0O0fLCSge+TV8u1h+YESuf8L8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c6gSNx66ZtiCGKPeWBEK1gPF/M7S0N5qgX6eTl0bNeWlDraCBsHufu+4tgFVCQcYV
	 jiPt2hPqzPvXHdAB3BgVVV7xNApprZOxbyJJ/flNIw70Y1/qJzukVU1yuLx1eFWygL
	 f/D+0ogiquU4pxfA/8Se57xjSvIYBueXlLJl9tJEUGK9ZnV0dlkDIgooceOxy+T0Mw
	 JTYyEDc12bxRsT0g/yNaNBPnyS5R3NfMWn/ndB9hIqlTF2geDrlTqCKJAxGa3gWN/r
	 LNAKQQpV6iGI2L5Mr80jdpLTbodEFmlv6kX35kXky3QygIk5JmiNLbVpLnJy2AemBr
	 gEMv1S+KWHbcg==
Date: Thu, 12 Sep 2024 08:43:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Robert Hancock
 <robert.hancock@calian.com>, linux-kernel@vger.kernel.org, Michal Simek
 <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: xilinx: axienet: Schedule NAPI in two steps
Message-ID: <20240912084322.148d7fb2@kernel.org>
In-Reply-To: <f63bf0ad-2846-4108-9a3f-9ea113959af0@linux.dev>
References: <20240909231904.1322387-1-sean.anderson@linux.dev>
	<20240910185801.42b7c17f@kernel.org>
	<f63bf0ad-2846-4108-9a3f-9ea113959af0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:23:06 -0400 Sean Anderson wrote:
> __napi_schedule_irqoff selects between __napi_schedule and
> ____napi_schedule based on whether PREEMPT_RT is enabled. Is there some
> other way to force IRQ threading?

I think so, IIRC threadirqs= kernel boot option lets you do it.
I don't remember all the details now :( LMK if I'm wrong

