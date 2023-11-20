Return-Path: <netdev+bounces-49312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C17F19B8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C32F1C20EC7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6D208B0;
	Mon, 20 Nov 2023 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icfGi8h2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3A2033D
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BD4C433C8;
	Mon, 20 Nov 2023 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700500805;
	bh=fh/Fnb3D79vkiKSIQU25iYNbWPO/hVFQYUlVkr0RMJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icfGi8h23q6UoVe8KFbD0E+5CODEOmcSs2tgxZlWz8Gy51Duf/gOw82CopoU6gxdi
	 lrglh1QIuJxxYmHftI+sSG+nkgsPMrR38nTbgpGdADPxPRhZC7Dk3hHRZ4rAqle8Wn
	 ofzZEBIYsKg/9Q6XFBY0WUjsp+qf4fbykY07GHUdX5BYqakPJ+eO6rDyy2u/ZLbECK
	 Z0yXO8s8BmznRA0xfd7sbbmM728TVoqj0Wi92vgWC9co6b4KKARESJmwDof5BpGjtM
	 mG9bBNyc5GysXcXNd8echybCBoKI3+kTaR5Auz4I5zp8MsHTpVnv9J1wGbXaSbPJj6
	 mzk/9hgERBa3w==
Date: Mon, 20 Nov 2023 17:19:59 +0000
From: Simon Horman <horms@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
	Pradeep Nemavat <pnemavat@google.com>
Subject: Re: [PATCH v7 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
Message-ID: <20231120171959.GC245676@kernel.org>
References: <20231113233301.1020992-1-lixiaoyan@google.com>
 <20231113233301.1020992-2-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113233301.1020992-2-lixiaoyan@google.com>

On Mon, Nov 13, 2023 at 11:32:57PM +0000, Coco Li wrote:
> Analyzed a few structs in the networking stack by looking at variables
> within them that are used in the TCP/IP fast path.
> 
> Fast path is defined as TCP path where data is transferred from sender to
> receiver unidirectionally. It doesn't include phases other than
> TCP_ESTABLISHED, nor does it look at error paths.
> 
> We hope to re-organizing variables that span many cachelines whose fast
> path variables are also spread out, and this document can help future
> developers keep networking fast path cachelines small.
> 
> Optimized_cacheline field is computed as
> (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> results (see patches to come for these).
> 
> Investigation is done on 6.5
> 
> Name	                Struct_Cachelines  Cur_fastpath_cache Fastpath_Bytes Optimized_cacheline
> tcp_sock	        42 (2664 Bytes)	   12   		396		8
> net_device	        39 (2240 bytes)	   12			234		4
> inet_sock	        15 (960 bytes)	   14			922		14
> Inet_connection_sock	22 (1368 bytes)	   18			1166		18
> Netns_ipv4 (sysctls)	12 (768 bytes)     4			77		2
> linux_mib	        16 (1060)	   6			104		2
> 
> Note how there isn't much improvement space for inet_sock and
> Inet_connection_sock because sk and icsk_inet respectively takes up so
> much of the struct that rest of the variables become a small portion of
> the struct size.
> 
> So, we decided to reorganize tcp_sock, net_device, Netns_ipv4, linux_mib
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>

...

> diff --git a/Documentation/networking/net_cachelines/index.rst b/Documentation/networking/net_cachelines/index.rst
> new file mode 100644
> index 0000000000000..92a6fbe93af35
> --- /dev/null
> +++ b/Documentation/networking/net_cachelines/index.rst
> @@ -0,0 +1,13 @@

Hi Coco,

A minor nit from my side: an SPDX header is probably appropriate at the top
of each .rst file

 
> +===================================
> +Common Networking Struct Cachelines
> +===================================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   inet_connection_sock
> +   inet_sock
> +   net_device
> +   netns_ipv4_sysctl
> +   snmp
> +   tcp_sock

...

