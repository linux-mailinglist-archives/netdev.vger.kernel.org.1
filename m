Return-Path: <netdev+bounces-17275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA5750FDC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A341C211B2
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039420F9A;
	Wed, 12 Jul 2023 17:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADE20F88
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3482C433C7;
	Wed, 12 Jul 2023 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689183732;
	bh=wG8UUXNP3lOA9oLQq/E55c0IUNpqh5X988ZONVpNi1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h54a7qPL1C5+e+vdm81szDvXyNSBOWtx1CMu5QnsbncweaA9c6kZobdlNc0bbELxN
	 fYgezlmaI09gWuV2meXrEroaPdAGaDvrH6yBkz6/z1I6nX2k1v/oTEOkoSPnKN8MEB
	 e/Lb31yHKKIOrI7BX2UFWtHmal85yrJH+Qo2WgpA3QXENjfKIkyjYBRAnPm6NpipYM
	 +0x+KtnveYOY5d0Aet1N4/zUElyO26VYyBZ8gJNOCQkiNCnak4b24ZIH1Pky8DAUZe
	 59VIIshp7XG3aLKahSfkXgzQykXSwGyYENUswAiZHKibY0g10kqwce2SJ9sN27CUrn
	 jO+AielX9JudQ==
Date: Wed, 12 Jul 2023 10:42:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230712104210.3b86b779@kernel.org>
In-Reply-To: <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
	<20230711193612.22c9bc04@kernel.org>
	<CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote:
>   The issue with kfree_skb is not that it fires too frequently (not in
> the 6.x kernel now). Rather, it is unable to locate the socket info
> when a SYN is dropped due to the accept queue being full. The sk is
> stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
> tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
> socket lookup are used). A tracepoint with sk information will be more
> useful to monitor accurately which service/socket is involved.

No doubt that kfree_skb isn't going to solve all our needs, but I'd
really like you to clean up the unnecessary callers on your systems
first, before adding further tracepoints. That way we'll have a clear
picture of which points can be solved by kfree_skb and where we need
further work.

