Return-Path: <netdev+bounces-44080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695FD7D6047
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546801C20CCC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436821360;
	Wed, 25 Oct 2023 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1MeECYB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DC1FBF
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D57C433C8;
	Wed, 25 Oct 2023 03:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698203450;
	bh=/yAyEb6iepUcGg89tL8uKCR2xw8w1lZmknftTp5N70I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u1MeECYBM99L8i8Olc96YZosbCPCNYPhxdj7DdGZsm6JhnUOFk23QVRWgwL+7CSvD
	 qS5b5iN0tOWeTEsSDxZF9r3IaQT1WPZlI6pL6u9NuaMgqBVZcIPSWpmG/NwAxlpsfr
	 pg6/oETldik10+pbSGYeiFsMD4RPtK3NjVEiMTNZbH7Rd0jrGQPibLoPX5JekOsrjh
	 hiuSsgY+nKsZ5qkBfh4gLpr0azw9jeHWGWFMQfoxxavyzIPJ28oo6Y5q5baDtawV58
	 wCat8SwMU+z6xHP6r8hV2DADmiAdt6WUkJ4C8Uppw4xtSbsP4z0w3ZrlIkBaleNj6N
	 y5MTcCxL1CnWg==
Message-ID: <250f5cd8-fe14-4edb-a282-111a041146bb@kernel.org>
Date: Tue, 24 Oct 2023 21:10:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 4/6] netns-ipv4: reorganize netns_ipv4 fast
 path variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231025012411.2096053-1-lixiaoyan@google.com>
 <20231025012411.2096053-5-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025012411.2096053-5-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 7:24 PM, Coco Li wrote:
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h index
> 73f43f6991999..03821b73ece70 100644 --- a/include/net/netns/ipv4.h +++
> b/include/net/netns/ipv4.h @@ -42,6 +42,34 @@ struct
> inet_timewait_death_row { struct tcp_fastopen_context; struct netns_ipv4
> { + /* Caacheline organization can be found documented in

s/Caacheline/Cacheline/

