Return-Path: <netdev+bounces-191671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6CABCAEC
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9957A3AD398
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F121421E;
	Mon, 19 May 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcKwpDN5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BC1552E0;
	Mon, 19 May 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693941; cv=none; b=H6XvxMAXkXaRg+bqPUdCvm885g6Pm3HxDTEIVwDN6/FuAlnk86O/nRY+DgRO9l4dzX2gwYkRKXQo0iQAiBOCWLAdUh9UszXukQ7oaX+h9z9KLTyUUI7MVIqWpabsaq/JUWNi0umU5fChZnmX/Wv2usWgIgfxjPy48boU3RgOntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693941; c=relaxed/simple;
	bh=f+aDsi5nQxMjBuoSfVRq6tUp/DSW4cYb8aljWJ0ym6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC3aWVDeXmOXA4UBBDVTgBwEi+uV/6JJyZpO94zLPOcigYEkohVYcL1jTUn6jWtk7IuziPZE5q7eyW24CPqNo/4lPwiJpJQAOk8BqsRf8sQaWH9IsvWrjUQI0dA/3Zrya3GLAvXk3S1JAe6Fncm+e6nGJDOB2Moq8Dx9wdRf1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcKwpDN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B739C4CEE4;
	Mon, 19 May 2025 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747693940;
	bh=f+aDsi5nQxMjBuoSfVRq6tUp/DSW4cYb8aljWJ0ym6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HcKwpDN5pSqEpc1JDU5LgFD6dwjWy0jk5bhdvlRj0sj1KxWAJStKeEbYkVbQlDUHk
	 kGDYQdplPstCVzRophZ2LrDUVCpK/p7qjugJeP7iNC0GvnVBAk88iZuztp9KeVxbP2
	 4gHG1OXNvZ7U9SAXIgpkVL1+iJqrxWmh7JJa7ed9IhrVXkE/++lr+bkZInYyqnBflU
	 nZ77oHiWE8o+HIkkY7jwYzChHGHa+Y3F1t9BE+LZcy947UWmgm2uU4QZhPbF34WdSm
	 MzEfdTMyb0vPJsO+IFczgAO9iww8cJruzM9IXeyGWcLbMTdIWmU4wXGOpfymv+ip++
	 EX6akFGAeLTpw==
Date: Mon, 19 May 2025 15:32:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
 <horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
 <larry.chiu@realtek.com>, Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2] rtase: Use min() instead of min_t()
Message-ID: <20250519153218.0036db7f@kernel.org>
In-Reply-To: <bb78d791abe34d9cbac30e75e7bec373@realtek.com>
References: <20250425063429.29742-1-justinlai0215@realtek.com>
	<bb78d791abe34d9cbac30e75e7bec373@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 12:16:11 +0000 Justin Lai wrote:
> I apologize for the interruption, I would like to ask why this patch is
> rejected on patchwork.

Hm, unclear, sorry about that.

