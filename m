Return-Path: <netdev+bounces-35592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22E7A9D7D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD92DB214A3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E71805D;
	Thu, 21 Sep 2023 19:38:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62F1773A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4FEC433C9;
	Thu, 21 Sep 2023 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695325080;
	bh=h6ntLt3ODQ3IcdTcxeP/qJhgaNEguGgexBL9xBopyKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=boswhxiGoYhfLUFjZWiYCYkJHPGTW2RAF2paXqDNm1mERJn+FDOTqyUWnOAy3r4wN
	 SLyicoWLwYiABQ5dBTZoqOHyreKrZTTLE38bi+8xMqzECBexkRTFoUo/hj7j/4L23C
	 pTU/Pv7kCAtjECloEpaRcWOpZxzu/a1PmZPPq1G3qvdYIt/qYUZejhHZKXnTFOOdg+
	 mC/BkDgC7zaU1qe8jLciASpJ9f5R+rm+jYtZW+jAB69dtagvoVZHpqDubVJvEZxvK5
	 2EDuk4EdGPHtzcI5fQxREhzzvL/CNFQQJcZ0NLGCSBrrkjTuH3g5ypb4FKO5R9L4V1
	 d+2YNTIAPYUFQ==
Message-ID: <121d8e5b-1471-6252-219b-6ec4abf872f0@kernel.org>
Date: Thu, 21 Sep 2023 13:37:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] neighbour: fix data-races around n->output
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921092713.1488792-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921092713.1488792-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 3:27 AM, Eric Dumazet wrote:
> n->output field can be read locklessly, while a writer
> might change the pointer concurrently.
> 
> Add missing annotations to prevent load-store tearing.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/neighbour.h         |  2 +-
>  net/bridge/br_netfilter_hooks.c |  2 +-
>  net/core/neighbour.c            | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


WRITE_ONCE is needed for net/atm/clip.c

