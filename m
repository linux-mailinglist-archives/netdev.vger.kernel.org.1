Return-Path: <netdev+bounces-44079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146F7D6043
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0E31C20BA3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CB2D628;
	Wed, 25 Oct 2023 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7YaO+4B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776C1360
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C00AC433C7;
	Wed, 25 Oct 2023 03:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698203398;
	bh=OzmPy1C6T+291hyLnx3VHovFCCN+YAOhe8WCF5ZkI4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c7YaO+4BXNSvIpfqVuUOIWoDdy4ZUef8TessDtqTPM03Pp2Lh8HYeQP/b/Dqo5EGe
	 nR7i1PsVAZ0ST/zClc4GhVbmx8W7qM+Kmy03t2Eps3SUACK7FAwzzmicpJ3jhW60Qn
	 OHwHyye9Kg0x2I8oRarU3rSDEZNR+75KLw29fdFvzxBAKzmNifpS6mBIp2JLBwCMRs
	 6MgtoZenq2PBKAoIFNeTcIvgBwINxw6git9Mqxiy+TK3TqXqlIpSTevm8p8hX5E39K
	 3OkHeMguGkSGK+uv/8L4wXURuv8Ir1uuAFxnCah0YxDgxw8UfAWRMqe2P6IDTBfCKu
	 XykQHa9egmUEA==
Message-ID: <fbf69318-74b0-48c8-9af8-9fb4aebf17ae@kernel.org>
Date: Tue, 24 Oct 2023 21:09:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 3/6] net-smnp: reorganize SNMP fast path
 variables
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231025012411.2096053-1-lixiaoyan@google.com>
 <20231025012411.2096053-4-lixiaoyan@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025012411.2096053-4-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 7:24 PM, Coco Li wrote:
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index b2b72886cb6d1..006c49e18a3f5 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -8,6 +8,13 @@
>  #ifndef _LINUX_SNMP_H
>  #define _LINUX_SNMP_H
>  
> +/* Enums in this file are exported by their name and by
> + * their values. User space binaries should ingest both
> + * of the above, and therefore ordering changes in this
> + * file does not break user space. For an exmample, please

s/exmample/example/


