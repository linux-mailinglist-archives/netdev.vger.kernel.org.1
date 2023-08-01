Return-Path: <netdev+bounces-23413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F376BE4C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C55281B44
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6C253D1;
	Tue,  1 Aug 2023 20:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB54DC89
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9528C433C7;
	Tue,  1 Aug 2023 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690920708;
	bh=0gCBbS6tj9vwj7Q7yqVIWg0y6AxgBA6QkVD5cPt2Tag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q0P0AhH2PjRdCup+bz0QUvVga1KT6jxrbjnHmehAHcEAecETIY8mkdLDiLh4attCI
	 f9MB6WbvBXVtrN9yNnSjVcRxvXzJ8qX5nn9JliUSjkWTd4qwP5OAIHJLgZvVJqs5b1
	 6T0MXKzIV3sluCzHzpvLg1phbBgIEoU64tCRBH85OSqn/GRtZFYltvXqb0nptLgs1Y
	 0gsg6150EML3ukOwdel8kE768dD3xNyan8C/5trWJhXWeE1X8ZXo5AsjqPFPvtMHtT
	 mm51mQGwvuw/HsXP709M4K1j9RZM/bZEzYLqcLSJAYE71vveQeejwaSAKJ2GYPvhf9
	 cY422eqtPAdEg==
Date: Tue, 1 Aug 2023 13:11:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, yoshfuji@linux-ipv6.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 simon.horman@corigine.com
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <20230801131146.51a9aaf3@kernel.org>
In-Reply-To: <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
References: <20230801064318.34408-1-yuehaibing@huawei.com>
	<CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 09:51:29 +0200 Eric Dumazet wrote:
> > -               skb_push(skb, -skb_network_offset(pkt));
> > +               __skb_pull(skb, skb_network_offset(pkt));
> >
> >                 skb_push(skb, sizeof(*msg));
> >                 skb_reset_transport_header(skb);  
> 
> Presumably this code has never been tested :/

Could have been tested on 32bit, I wonder if there is more such bugs :S

