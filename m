Return-Path: <netdev+bounces-212547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776DB21324
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB33E3113
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2F2D3221;
	Mon, 11 Aug 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iaUXdOqB"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0B1F3FF8;
	Mon, 11 Aug 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933329; cv=none; b=dMoRcQQS8bAus4I2skYQ1XvkhqFMzm2kT9a8JYeyqLegDuGGtmKt4YxQOlhhrXruZwXiyVu3IKfUTgZMicnwzgFKK+zKxtVcyeNBAsl/0+MDrIkG4D5hdk/5D6WzSLGOrZTVoLRNdJrZVCkwl0d9+lX96dShow03OgSFzESioxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933329; c=relaxed/simple;
	bh=RPFcFE4EjC9KYsFIk0oZqJD9FwqQTkyfdIYsheVQ7dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c6te+xEQdfSCwkhLwjAoLRnzN4MwqTUHnLbK3vlPPGP7JsqQhDwTGWd/hNR/McougjOjeGZLfd+ts9TZEFWBk1JECy7gZpGS1Nnyd8039L2Q1dwv3NRU/pf8FgmlAH8Ry+EH95rv6kgkXwldtJaxCS6LJDwiWCXUtGxC/41YoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iaUXdOqB; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A8F4C40AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754933326; bh=RPFcFE4EjC9KYsFIk0oZqJD9FwqQTkyfdIYsheVQ7dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iaUXdOqBX6NARwSaVj/lNohmgcpyQuRPIIc3rKWM9IlCdHDkx4m52x4o3fF/sP8M5
	 CWgNzopgRSIClfb9ZWyDL8IStghlpX4UnzhAp7WJ9uY0P691gbGVRKX9Aj9RBSkDv7
	 E8/fa8xBuVMu6uuubmK4yjHIxVf/wunv2tcQVvo3DaAW6Hkjllfs/UWc/xO8G1ppWR
	 sVwsSl97i+uPvExtCpSjINMuQVMMvYgcqpzbqp33RB966xnWiFP9mw0s/GnJnkQJrt
	 zU3j4w3JBBKEdoZvjO7wDjiEuvE99kBw4CCM/m/e5Vewh+/+fViUw1xsPs5BM2uJLd
	 5sw4llWg9H/CQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A8F4C40AD2;
	Mon, 11 Aug 2025 17:28:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Message-ID :"
 <cover.1752076293.git.mchehab+huawei@kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>, Randy Dunlap
 <rdunlap@infradead.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v10 00/14] Don't generate netlink .rst files inside
 $(srctree)
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Date: Mon, 11 Aug 2025 11:28:45 -0600
Message-ID: <87ms85daya.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> That's the v10 version of the parser-yaml series, addressing a couple of
> issues raised by Donald.
>
> It should apply cleanly on the top of docs-next, as I just rebased on
> the top of docs/docs-next.
>
> Please merge it via your tree, as I have another patch series that will
> depend on this one.

I intend to do that shortly unless I hear objections; are the netdev
folks OK with this work going through docs-next?

Thanks,

jon

