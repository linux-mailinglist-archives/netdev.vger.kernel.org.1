Return-Path: <netdev+bounces-21117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0B7627E5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CC81C21075
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836010E7;
	Wed, 26 Jul 2023 00:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388E7C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA44C433C8;
	Wed, 26 Jul 2023 00:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690332964;
	bh=MfN5M/tY60PJ14OPyEhgNIux/Xkd/vPmzSLxg/p70fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AgGTqXEER/shTu5cZzMDJmO1Pc3ny8CQ+SVv+x9ojrnv7PkR6vBo3yh50DCZpKgiB
	 5tIiamMaZjgqH9vDoJxt7Y/LL+9IStA/z/qv4dWMb4eTnTK67UkPFn0rdPuABB0eSU
	 2Ol7/j7SWRa3w/nyj6AN7jJHZj0pXjUU8jD41YRGoGMXvZQP6WVLbj4mF759EJszB8
	 4qzbpmu3WzvACYmQ4+HZqbnoHU0oIXgXUuEv3h3IvAWlTOQganGRB/lR7q0ZRdA/Nw
	 myn6KdqnAZd3rdrZ4KF7+O3jzeq/WRIssyA2vd+TXmju9Pd+oKoj19WsqJYfntzUIc
	 zNSeWvgJCUyJA==
Date: Tue, 25 Jul 2023 17:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
Message-ID: <20230725175602.53e0a1f4@kernel.org>
In-Reply-To: <CAKgT0Udz74tvTL9TfT4boajCFpAog4juJjW83pxEvQ7RNMFGDw@mail.gmail.com>
References: <20230720161323.2025379-1-kuba@kernel.org>
	<c429298e279bd549de923deba09952e7540e534a.camel@gmail.com>
	<20230725115528.596b5305@kernel.org>
	<CAKgT0UdKWmogiFD_Gip3TCi8-ydy+CVjwca1hPTYBRQQZ8_mGQ@mail.gmail.com>
	<20230725134122.1684a2f1@kernel.org>
	<CAKgT0Udz74tvTL9TfT4boajCFpAog4juJjW83pxEvQ7RNMFGDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 17:02:42 -0700 Alexander Duyck wrote:
> So looking at it more I realized the way we are getting around the
> issue is that the skbuffs are ALWAYS freed in softirq context.
> Basically we hand them off to dev_consume_skb_any, which will hand
> them off to dev_kfree_skb_irq_reason, and it is queueing them up to be
> processed in the net_tx_action handler.

SG.

> As far as the page pool pages themselves I wonder if we couldn't just
> look at modifying __page_pool_put_page() so that it had something
> similar to dev_consume_skb_any_reason() so if we are in a hardirq or
> IRQs are disabled we just force the page to be freed.

Yup (same for the bulk API). I think that Olek was trying to implement
this somehow nicely, not sure how far he got.

