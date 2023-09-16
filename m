Return-Path: <netdev+bounces-34217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473477A2D9A
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 05:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7EC1C208BD
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EFC5691;
	Sat, 16 Sep 2023 03:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92963C3
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 03:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547F3C433C8;
	Sat, 16 Sep 2023 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694834245;
	bh=WUTQYOhk2nQJkkhnJxIye0eKiqgrLuR36ii6Dot0pzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L0skBR5X8Q2VvpIH3OPfeXc0Ix3Iejn78DtgBkNc+xHq/WljJui+79QkBFyPbkvs9
	 Eg2sznJxRj00f2DDLD/O+3xp3ClEEw/ne34qAqFiHWbiG2JwbVvSpeMCIX7ZbaiDp8
	 bO+MDXloOE8Huuu2WYQslQGGeHFYgZNo7RgRcjmwzQbFGw5OcaDQf0ker3XGryLv0K
	 FG4y00pG0WWJ4z1MbdBj7ie6J1RoO/6qRGINcG/QF/P5y6ntJAtMnFgCzB75cIL7Ax
	 tbW1BqvViD12FklH/ryAwlSOEX49NKM1miwT3COeG0ETq4iMgaPuAL1CFplrSSeLsj
	 BuUe2S43NX7Xg==
Message-ID: <ed8b0bbd-e2db-e899-d3e8-8a6e98072a57@kernel.org>
Date: Fri, 15 Sep 2023 21:17:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 net-next 5/5] tcp: reorganize tcp_sock fast path
 variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-6-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230916010625.2771731-6-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/23 7:06 PM, Coco Li wrote:
> The variables are organized according to the following way:
> 
> - TX read-mostly hotpath cache lines
> - TXRX read-mostly hotpath cache lines
> - RX read-mostly hotpath cache lines
> - TX read-write hotpath cache line
> - TXRX read-write hotpath cache line
> - RX read-write hotpath cache line
> 
> Fastpath cachelines end after rcvq_space.
> 
> Cache line boundaries are enfored only between read-mostly and
> read-write. That is, if read-mostly tx cachelines bleed into 
> read-mostly txrx cachelines, we do not care. We care about the
> boundaries between read and write cachelines because we want
> to prevent false sharing.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 8
> 
> Tested:
> Built and installed.
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> ---
>  include/linux/tcp.h | 233 ++++++++++++++++++++++----------------------
>  1 file changed, 119 insertions(+), 114 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



