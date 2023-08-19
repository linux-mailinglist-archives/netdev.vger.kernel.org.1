Return-Path: <netdev+bounces-29020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68B7816A7
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995541C20C6F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E207815;
	Sat, 19 Aug 2023 02:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDF634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF89C433C8;
	Sat, 19 Aug 2023 02:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692412131;
	bh=Xa6E2Zy6L8R0PJ2/IhJeFfkHSKMWJHyXBNK8XDLmz7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IdTdrjINPtOCH/S+GhAhAIXxZi/Zp/Et3WTKV2/1iAer45BE4hhAeZcxoWRY55rfh
	 XNndSqZHIJKUoXs+dsOmTEECqYB5OVN+l4P1hFhy+gKy8RJURFKvTYMZTc8EeIlye7
	 d9FxER+WJzv6GIa3jaiA/VMURfDwejZ+Vy2mGuqxcoT5qOafV7lkhEFHvaCap5X8uy
	 ZSuDmahoo9fVl/JqjMfbzsOrEztil7bDJdsdVfSrbpHyFiAbdOYvn78ZPslGO9mit7
	 n7YdbR2agWETrjeXwfbL1DJwBHHMsg90IyX5SRS9J9rqeSPKcy6zvWZTc7Sam5Z4Ez
	 0BNlmyGb47d4A==
Date: Fri, 18 Aug 2023 19:28:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: annotate data-races around
 sk->sk_lingertime
Message-ID: <20230818192850.123e8331@kernel.org>
In-Reply-To: <20230818021132.2796092-1-edumazet@google.com>
References: <20230818021132.2796092-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 02:11:32 +0000 Eric Dumazet wrote:
> Remove preprocessor logic using BITS_PER_LONG, compilers
> are smart enough to figure this by themselves.

clang does complain that we're basically comparing an in to a MAX_LONG:

net/core/sock.c:1238:14: warning: result of comparison of constant 36893488147419103 with expression of type 'unsigned int' is always false [-Wtautological-constant-out-of-range-compare]
                        if (t_sec >= MAX_SCHEDULE_TIMEOUT / HZ)
                            ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~

Can we shut this up somehow? Or don't care?

