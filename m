Return-Path: <netdev+bounces-51641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F07FB90E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20D6282C16
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C74F1E4;
	Tue, 28 Nov 2023 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD5C0D45;
	Tue, 28 Nov 2023 03:10:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B019C15;
	Tue, 28 Nov 2023 03:11:22 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431303F73F;
	Tue, 28 Nov 2023 03:10:33 -0800 (PST)
Date: Tue, 28 Nov 2023 11:10:28 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bill Wendling <morbo@google.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct
 neighbour
Message-ID: <20231128111028.GA2382233@e124191.cambridge.arm.com>
References: <ZWJoRsJGnCPdJ3+2@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWJoRsJGnCPdJ3+2@work>

Hi,

On Sat, Nov 25, 2023 at 03:33:58PM -0600, Gustavo A. R. Silva wrote:
> Previously, one-element and zero-length arrays were treated as true
> flexible arrays, even though they are actually "fake" flex arrays.
> The __randomize_layout would leave them untouched at the end of the
> struct, similarly to proper C99 flex-array members.
> 
> However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
> randstruct: Only warn about true flexible arrays"). Now, only C99
> flexible-array members will remain untouched at the end of the struct,
> while one-element and zero-length arrays will be subject to randomization.
> 
> Fix a `__randomize_layout` crash in `struct neighbour` by transforming
> zero-length array `primary_key` into a proper C99 flexible-array member.
> 
> Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
> Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/net/neighbour.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 07022bb0d44d..0d28172193fa 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -162,7 +162,7 @@ struct neighbour {
>  	struct rcu_head		rcu;
>  	struct net_device	*dev;
>  	netdevice_tracker	dev_tracker;
> -	u8			primary_key[0];
> +	u8			primary_key[];
>  } __randomize_layout;
>  
>  struct neigh_ops {

Fixes the crash for me!

Tested-by: Joey Gouly <joey.gouly@arm.com>

