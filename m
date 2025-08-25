Return-Path: <netdev+bounces-216552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC1B34755
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EAA1B235BB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732424467E;
	Mon, 25 Aug 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvTEXT+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B617332C
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139433; cv=none; b=gB/qlLZNKGj/JKuS3yjEuXZi0U+YJk1mIXZaGK6Hp4eyFwYwmZOWEaFKFh6BqT9zL+9a3tM1czmd0Att5GSRZLgM+Ix0dBDblxex8aolNL7r7JQp5e3Q8m5EUSx9heiSpa7DUQaJZSeoinTuyItyKPSbI1/fQW6yrQaf6P736rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139433; c=relaxed/simple;
	bh=69OB5O5TtFbE9pcYaO4AXdRETXaifQSH1UoAB4M/SUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFjqG8gcfnMtMGWkBT0/jbQz/St3ByfS1xTUgQ0Y6JoTN1lS3O7e30V3noLjm2CrZvFNCxED2gyYWgg36QQTp1Mbp8mQezjXh8p2Jx8Vq4ThkJf5A4SpcD7BjT9qtPilfoaQHoy04rZNGDdGju9jYR8sZQGhZI1E9mDHAOf8JkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvTEXT+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3539BC4CEED;
	Mon, 25 Aug 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139432;
	bh=69OB5O5TtFbE9pcYaO4AXdRETXaifQSH1UoAB4M/SUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lvTEXT+yxHv4POj7X8c6cqvrGFJcVI7vqqbxvhEt+NnMBZ5gnZfuNpPD7mHdq88qR
	 rT8c3Tl/V7jcTWecpRYpmtWs78cqJl7xjFg72WN2G7YM4gclG3hAy0Y33vcigh/Y3Z
	 Q5XdomC8GHn5lo4BTCwQ5qDBhkcPovb6fomMnbf/gtfO/Nmraj4oL2PDgB1/KmhNiI
	 zThPEDdd2rEzLzXY8EoEsZmHOra4kYu0fwzDh68sTToQishQY/ajikriGKbBWMt40h
	 HybLjHypeEHnY5XtYIhoRSiPUYaxmL+vr+MLjbMvCS22MM7PFEEsYJqaQzu8VUtulL
	 Qal2LoMHoD2og==
Date: Mon, 25 Aug 2025 09:30:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca, Joe
 Damato <joe@dama.to>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/2] selftests: Add napi threaded busy poll
 test in `busy_poller`
Message-ID: <20250825093031.67adf328@kernel.org>
In-Reply-To: <20250824215418.257588-3-skhawaja@google.com>
References: <20250824215418.257588-1-skhawaja@google.com>
	<20250824215418.257588-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 21:54:18 +0000 Samiullah Khawaja wrote:
> +static enum netdev_napi_threaded cfg_napi_threaded_poll = NETDEV_NAPI_THREADED_DISABLE;

This doesn't build:

DISABLE*D*

