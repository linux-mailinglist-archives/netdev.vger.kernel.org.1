Return-Path: <netdev+bounces-139725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C588E9B3E88
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F2C1F232C8
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371791F4297;
	Mon, 28 Oct 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eARBvlbQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D871925B3
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158557; cv=none; b=bKcH0rAmqSU7Bvi2zMizHlXZYgdFrDTa9xbIxEDStHhSggJW6roxy7y+73Mf4X3WDppMB+oRfSyRoPuPsdnIOlLWtF6JAxKrBxV1eSaVaaHMfHo7RYPJgPZvVcmp8LhROcsP69G2/foFgCrH2eZCpKpXn0os+Cfaq7o+MNm0ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158557; c=relaxed/simple;
	bh=fkLMbkIxAejWolRuV1tnlNKnWWmQN/5nlOolceYpGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbXZB3IK7YcSV9dNPCQI/HxDiEQRShAIQg6UOQVBJv5LU53joVx+ebYdfXllYbCU/n1JOf9nohR5/JlC1cpDDaSJrN9Xbxe+BS3n2gMblw4DmM9VAR8LpubEV5Hxd9vDGw/n7Xwm91buxJFZHkKAbUYA++Hih8OxOZG6NeX7k68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eARBvlbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F148AC4CEC3;
	Mon, 28 Oct 2024 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158556;
	bh=fkLMbkIxAejWolRuV1tnlNKnWWmQN/5nlOolceYpGuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eARBvlbQbmiHnLKPcsC6o4Wn26OZd0KfV7B9LSH4cRi7ntd2wfYgBz6KPVujOxd0y
	 GkpIMQxNa2o9bccy4Z6z82cVXFKmvFFKX+kkW4hyFpXEQuVsW+zM4AqoFe5+qzWX1f
	 edOxyhlB6pU36KitT5cN4DvOrqUpDM7QiZGhirtN7BBRRfkAsUKAVq0Py6/Ktil3j1
	 32owmWN34e7kRtQ+rFwvkDoSSScEaJ1buzbcCbZ7l7p2LaNQYSKgvfTEj+mnyxWuaa
	 8I/ovJ3jVBv4czWX4sCxnrH4Q96+tnmbvhJNcIsopE0cssVA/DvAwA+qWXgRl8/OBN
	 qtuE+Ah2asw5g==
Date: Mon, 28 Oct 2024 16:35:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <alexanderduyck@fb.com>, <andrew@lunn.ch>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <kernel-team@meta.com>, <sanmanpradhan@meta.com>, <sdf@fomichev.me>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <20241028163554.7dddff8b@kernel.org>
In-Reply-To: <5a640b00-2ab2-472f-b713-1bb97ceac6ca@intel.com>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
	<5a640b00-2ab2-472f-b713-1bb97ceac6ca@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 17:19:03 +0200 Alexander Lobakin wrote:
> > +static void fbnic_clear_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx)
> > +{
> > +	int i;
> > +
> > +	/* Invalidate entry and clear addr state info */
> > +	for (i = 0; i <= FBNIC_TCE_TCAM_WORD_LEN; i++)  
> 
> Please declare loop iterators right in loop declarations, we're GNU11
> for a couple years already.
> 
> 	for (u32 i = 0; ...

Why?

Please avoid giving people subjective stylistic feedback, especially
when none of the maintainers have given such feedback in the past.

> (+ don't use signed when it can't be < 0)

Again, why. int is the most basic type in C, why is using a fixed side
kernel type necessary here?

