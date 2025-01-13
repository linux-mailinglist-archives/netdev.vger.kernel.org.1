Return-Path: <netdev+bounces-157917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB688A0C4CD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016EF188D1C6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B171F942D;
	Mon, 13 Jan 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvbXXGes"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0721EBFE8;
	Mon, 13 Jan 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807540; cv=none; b=VjsbIq7Gkhhpd0DOJdBdoIyZ++d76NcVQnTkk128zcbG++seoeevQ/ch3BmEqP/V3pM0TFO9owPUGc1PmG8s073C6pk3ewCdGKe7y++GnsO+IOfh5ZHcKYd7iGr58fN4BdQodGD3PRxPrBTwWsFnbChELOVXn7BGCHcUKIkX0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807540; c=relaxed/simple;
	bh=x88EzDw3NJRj/aIEKD9illgKlUUXFrhPe8z423CWFEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCz/dDN5+EY92C85wMeOTZHTIum/4bzqU41/GuHF1sh234t9uxV+C96/WrjfXQ8Bu3HO/dymV5flwcJic9/RPCImfK9p2b6XvMWNxmCs5KGDoQTYJQUoan1lmhQWbPvts5XE1x2zZ3jUDcrImmS49G1/1FJoCmJM3SZVnoJH1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvbXXGes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC63C4CED6;
	Mon, 13 Jan 2025 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736807540;
	bh=x88EzDw3NJRj/aIEKD9illgKlUUXFrhPe8z423CWFEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WvbXXGesTB6yvhHWWQcq1psNBnVrf+lL7ZOkuB6m7RvZxHxwmyzbyEuazjXaGghM9
	 s+0BQOL2T1ySEtu5teyiOe4byds73bkC6J7JchEandJ7EtNoW3/FeU9kggJaHK9O41
	 1aTRm0+nkgaXcdDI3ZmABf1+UV+wIQcFxk2kIJElFCgZZYZslyvo9OuA+Tw3E9Opnq
	 nydJhWOnswxEiuVbG2RPDK497JByQlQp+dYbfpX0Er1z+RwtTZ8AJplqXrHTlzxOUC
	 +AudtAXbAdQBF6xmWqwQq0EcZi3b1UYye8hxCtQjPShPbGnNxxWOOuSIAR4n0D2QtX
	 84z5rIu7X77gA==
Date: Mon, 13 Jan 2025 14:32:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Message-ID: <20250113143218.68c75f88@kernel.org>
In-Reply-To: <Z4WSfER6O6n3hxXh@LQ3V64L9R2>
References: <20250110202605.429475-1-jdamato@fastly.com>
	<20250110202605.429475-4-jdamato@fastly.com>
	<CACGkMEtjERF72zkLzDn2OKz3OGkJOQ+FCJS3MRscJqakEz9FYA@mail.gmail.com>
	<Z4VNrAI794LixEXt@LQ3V64L9R2>
	<20250113140446.12d7b7d3@kernel.org>
	<Z4WSfER6O6n3hxXh@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 14:23:56 -0800 Joe Damato wrote:
> Please CC me on that series so I can take a look and I'll adjust the
> v2 of this series to avoid the locking once your series is merged.

Will do! I'll send the first chunk as soon as Comcast restores 
the internet at my home :|

