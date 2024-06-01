Return-Path: <netdev+bounces-99933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE48D71F7
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0095C1F21C3B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1C18026;
	Sat,  1 Jun 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV4Pdvda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B620DF7
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277129; cv=none; b=FZaMD28ei9xnWmZnFdBC4Gv8w2AR4/y6AyZMNAvxVZoFG8JBnO/VTFlQTBz2/HSK8kZB7kmBdJ9wWv9NL1SrsMX4L5NPJb9WfmelLmjz8bBDEKLM9tCUsAlcIIvL/uwHq9+3gWzoK9M5lXLK4dO82fWqCqXc2gieQJhl9TE6wqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277129; c=relaxed/simple;
	bh=KMaMgeFXXbKIv6ndBtrCXzZg4DweZ7lEPxfnkedGPe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivYsRGUwZ6YpXI+VwrFyeOmIDl95QUOf7RSuhI98s5bvwUdkqFoM3K5uZtA2Uj3DPHr8qiDhrpN9oV3D2LHWd8nP32QQppMKBwhy78mjmf7QTh9/g33tAIAqDTQN44+lpqC+V0DBEYaQchojJYuy0orkrIMhG1DIz7W2LpGQc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV4Pdvda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BBEC116B1;
	Sat,  1 Jun 2024 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717277129;
	bh=KMaMgeFXXbKIv6ndBtrCXzZg4DweZ7lEPxfnkedGPe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bV4PdvdaKpED4kz7HXmH34t727RqAMdBHpIsEFxmWggLRxB5kDVYRsIGNVKVyno8k
	 ijdkjfOBcWhubOycii03S3JYi2cR01uU8IRyLWuSqvFxngrxIeaPuTR/ktCkxi2Uew
	 GIHh8FsnD77Yaf3HCoAlQQLnJ48lTwHLsJShbHqRWVM/O9Vw7H2Qa5YHkVxkvpfylb
	 JpgjuO6D89lES4L8LBaYTjQbG7I3mh8sFs/BeuTes3waRPqlIch1FSF9RJwie37NkY
	 jiGJMJZOVvjIhLjV6QoXQIhpIz5j3ISON7TOwVgfNP+S0d43cFZwpIOZkvp5vUrBH7
	 m3ON8fC3oFn1A==
Date: Sat, 1 Jun 2024 14:25:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
Message-ID: <20240601142527.475cdc0f@kernel.org>
In-Reply-To: <CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
	<20240530173324.378acb1f@kernel.org>
	<CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
	<20240531142607.5123c3f0@kernel.org>
	<CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 08:51:47 +0200 Jaroslav Pulchart wrote:
> > > I tried it and it did not help, the issue is still there.  
> >
> > Hm. Could you strace it ? I wonder if I misread something it doing
> > multiple dumps and now its hanging on a different one..  
> 
> sure, here it is:

Ugh, same thing, I didn't test properly.
I tested now and sent a full patch.

