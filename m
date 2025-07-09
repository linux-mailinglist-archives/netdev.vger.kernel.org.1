Return-Path: <netdev+bounces-205518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA27AFF0AB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DDB1C41B1F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFAA239E68;
	Wed,  9 Jul 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXJF45xC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9023959D;
	Wed,  9 Jul 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084879; cv=none; b=TNqdPszJWhyKmYW8IkqVYM0IeufOFuYdUxNio9dq+1tT0yEIEhWhthUpIyZ2qwr6xW5W76Y7Y3yvO+e3mCuFI29jydFLpyDm2Ag5dntX5KuwtLui3WX+WwpYuoIElSXO06EILySr9UdoJ/sO2AAhglY4GkBCiJZWpN2RRhQhL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084879; c=relaxed/simple;
	bh=PejlkFjXEHBs3IdChw/dzr5yIfRM7ueQw8w1U7Pzs0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtlRqat7y0F0IbAOEc5JacwZQHENzxWqQpfmDuDN7Sb7QGVjWT5TXKhj/tKCrYKuSRGiEOJmgaVcKqqH+2s23rmFQ6vYx3CFGEIdeb5Abh6hkOw4AJ2H66dI1jxucfkvRfk2/zoCw6t/24GAnGDAXsW2AxqKIAnSEyd/9pq6dR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXJF45xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2839BC4CEF0;
	Wed,  9 Jul 2025 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084878;
	bh=PejlkFjXEHBs3IdChw/dzr5yIfRM7ueQw8w1U7Pzs0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXJF45xCHrZ9V9R9ZveG5Q5eLRjEWasBIb3KVfLCg9afJTgxlFAKJW0vtMiRxhP4s
	 7KUBMeHIb8Q5EpyB3mujhJgc1yKgs13Y0j6+GcMlhp46m0xFX60hhs+r7rXnMEd2ZN
	 5Fyro4BztjPeGuFLqZnXIqVGltwd7SnF+w3DWADtXSmashQ0l09QfRMJvNH/SUfzEr
	 v+XWRzo+/RsuoKF9zwjpJqb/w8IpsZsLPWABuyRzuPmUv25bBsP4EA3JGHgPpx0pRK
	 RQNG9Vw9qQYapAL/m7rnu0aAxcnRwMw//+dp5xb5pVlUko4Zb1O+jlc55bcT8N9of9
	 vg7adFDNoAZOA==
Date: Wed, 9 Jul 2025 19:14:34 +0100
From: Simon Horman <horms@kernel.org>
To: Yun Lu <luyun_611@163.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
Message-ID: <20250709181434.GH721198@horms.kernel.org>
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-3-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709095653.62469-3-luyun_611@163.com>

On Wed, Jul 09, 2025 at 05:56:53PM +0800, Yun Lu wrote:

...

> @@ -2943,14 +2953,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		}
>  		packet_increment_head(&po->tx_ring);
>  		len_sum += tp_len;
> -	} while (likely((ph != NULL) ||
> -		/* Note: packet_read_pending() might be slow if we have
> -		 * to call it as it's per_cpu variable, but in fast-path
> -		 * we already short-circuit the loop with the first
> -		 * condition, and luckily don't have to go that path
> -		 * anyway.
> -		 */
> -		 (need_wait && packet_read_pending(&po->tx_ring))));
> +	} while (likely(ph != NULL))

A semicolon is needed at the end of the line above.

>  
>  	err = len_sum;
>  	goto out_put;

-- 
pw-bot: changes-requested

