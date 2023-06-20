Return-Path: <netdev+bounces-12389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704A73746C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12858280D1C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75A19912;
	Tue, 20 Jun 2023 18:33:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6C1F931
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85364C433BC;
	Tue, 20 Jun 2023 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687286007;
	bh=fuvZu8TGHeYaRsGct7+ygST2f1DjIVWN0TC4J1++Nug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVGwdmySKN+LxbGYOpMaYc8Bt6LUP9K7oVGYJ1C+6IC4+ANVU8UzyMu+UfN8B0Rak
	 64/ANQCtQ59+gBO2dCXcQ3ykGLvUdb03wb/1KbqO7Y26YDtrXd0LpHGk3g1LzIha62
	 2SkBqQ6QVprwiligQ2sM49eR3DLJ+wKLQE2Ef3673UKyWnQwo5WbTlPoFLYxaga5Zm
	 yr3E63/UO7uioBbk66l4uubPFJy2N/loKQMoyfj92SIDEdimlfyJRbRl9aHzP+simm
	 ZuVpv9a6k/Rv8VFDM6dNCWQ2gGRJZVED8Df2Cuyooxw7XPxP17znuhzIUxO41FL91F
	 k3mlMQZpgGfhQ==
Date: Tue, 20 Jun 2023 11:33:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cambda Zhu <cambda@linux.alibaba.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Lu Wei
 <luwei32@huawei.com>, "t.feng" <fengtao40@huawei.com>, Xin Long
 <lucien.xin@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: [PATCH net v1] ipvlan: Fix return value of ipvlan_queue_xmit()
Message-ID: <20230620113325.3e9172e3@kernel.org>
In-Reply-To: <6A7B6A47-7453-4D30-938E-B4AEC55906CE@linux.alibaba.com>
References: <20230616063436.28760-1-cambda@linux.alibaba.com>
	<ZIwnVEiGlLgD1qcG@corigine.com>
	<6A7B6A47-7453-4D30-938E-B4AEC55906CE@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jun 2023 17:40:29 +0800 Cambda Zhu wrote:
> > ipvlan_rcv_frame can return two distinct values - RX_HANDLER_CONSUMED and
> > RX_HANDLER_ANOTHER. Is it correct to treat these both as NET_XMIT_SUCCESS
> > in the xmit path? If so, perhaps it would be useful to explain why
> > in the commit message.  
> 
> The ipvlan_rcv_frame() will only return RX_HANDLER_CONSUMED in
> ipvlan_xmit_mode_l2/l3() for local is true. It's equal to NET_XMIT_SUCCESS.
> The dev_forward_skb() can return NET_RX_SUCCESS and NET_RX_DROP, and
> returning NET_RX_DROP(NET_XMIT_DROP) will increase both ipvlan and
> ipvlan->phy_dev drops counter. I think the drops should belong to
> the rcv side, and the xmit side should return NET_XMIT_SUCCESS even
> if rcv failed. However, I'm not sure if my opinion is right.

Please add the explanation to the commit msg and CC Mahesh on the v2.

