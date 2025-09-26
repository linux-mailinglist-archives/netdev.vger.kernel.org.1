Return-Path: <netdev+bounces-226721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76767BA4717
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4178E1C03C04
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C620CCCA;
	Fri, 26 Sep 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv7JYZ70"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296519FA93
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900924; cv=none; b=Dm3iIbTgrS7FS6knY5QIly5a/MbqIbGXSSrVb9nlcjfBeaAW7l51cl8qPT2k2gL7sXczFPx51xytqHYPt2RJFbNMZbyq7N3c0aVB5hugbOyiHe0DgheqqB1hmUANdiJLPctZWiGzjtJpQa6Ysbaksvm5MVo5/Y3RlxwaHGM3m4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900924; c=relaxed/simple;
	bh=Zq5omB0u0zCdw/NcOWWSho/+ncN/7CvpjdpsFuys8yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrn5Jm440NdOEZ2mrjtR/YoB55WfuW5+erbd4IOtsk0pj/MQyYilZ6LCj33+pQUmb6tcQHgoQGtDDtLjaic1PE/LoWg1Oj46FuGaiEtQdQJMtJXDo0riIBCE0k66Uy/S84noKg6o7ZohmqwGvpOTkUNi0qtR+5lr4Cmb4XCA8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv7JYZ70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5F1C4CEF4;
	Fri, 26 Sep 2025 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758900924;
	bh=Zq5omB0u0zCdw/NcOWWSho/+ncN/7CvpjdpsFuys8yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qv7JYZ70JsiNWo9P32ZoL/G60dNtj/r6DgCeJ2VcZwRWJQQlQvse+ODiMfvU/+srt
	 zphfs+lYzvEKUdZWdj4skfjA1wdyupkJeyDYxyLFkvGh0aIjJcLe1U3sqh5Qyn+lYU
	 6Mldaa7R270WfP5sYK+nh2/D9dbIZgJdTogPf7RD26XTcbPiPxyNGgPgONu0mC2G0D
	 0t8ybmbbtOJ972Xpn7cDDOTc4ZhMBkQ3PW2vvHWiBg0sQ1rY5er1SKwryc+lyUqOPY
	 f4ieOq+7Oo+r3opxXKW6o4YIfaEOYcpqgrpzOu2btWk6m+IQ5HKD7wIiFkTWihhrRU
	 8/q8pysl/I99w==
Date: Fri, 26 Sep 2025 16:35:19 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>, Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] netdevsim: a basic test PSP implementation
Message-ID: <aNayt5IBiX1Vegbr@horms.kernel.org>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
 <20250924194959.2845473-2-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924194959.2845473-2-daniel.zahka@gmail.com>

On Wed, Sep 24, 2025 at 12:49:47PM -0700, Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Provide a PSP implementation for netdevsim.
> 
> Use psp_dev_encapsulate() and psp_dev_rcv() to do actual encapsulation
> and decapsulation on skbs, but perform no encryption or decryption. In
> order to make encryption with a bad key result in a drop on the peer's
> rx side, we stash our psd's generation number in the first byte of each
> key before handing to the peer.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

...

> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> new file mode 100644
> index 000000000000..cb568f89eb3e
> --- /dev/null
> +++ b/drivers/net/netdevsim/psp.c
> @@ -0,0 +1,218 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/ip.h>
> +#include <linux/skbuff.h>
> +#include <net/ip6_checksum.h>
> +#include <net/psp.h>
> +#include <net/sock.h>
> +
> +#include "netdevsim.h"
> +
> +enum skb_drop_reason
> +nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
> +	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
> +{

...

> +	} else {
> +		struct ipv6hdr *ip6h;
> +		struct iphdr *iph;
> +		struct udphdr *uh;
> +		__wsum csum;
> +
> +		/* Do not decapsulate. Receive the skb with the udp and psp
> +		 * headers still there as if this is a normal udp packet.
> +		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
> +		 * provide a valid checksum here, so the skb isn't dropped.
> +		 */
> +		uh = udp_hdr(skb);
> +		csum = skb_checksum(skb, skb_transport_offset(skb),
> +				    ntohs(uh->len), 0);
> +
> +		switch (skb->protocol) {
> +		case htons(ETH_P_IP):
> +			iph = ip_hdr(skb);
> +			uh->check = udp_v4_check(ntohs(uh->len), iph->saddr,
> +						 iph->daddr, csum);
> +			break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +		case htons(ETH_P_IPV6):
> +			ip6h = ipv6_hdr(skb);

ip6h is only used here. Which means that if CONFIG_IPV6 is not set then
compilers - e.g GCC 15.2.0 and Clang 21.1.1 - will warn when run with
-Wunused-variable.

Maybe no one cares. But if the scope of ip6h was reduced to here,
say by making this a block (using {}) and declaring iph6 inside it,
or using a helper, then things might be a bit cleaner.

> +			uh->check = udp_v6_check(ntohs(uh->len), &ip6h->saddr,
> +						 &ip6h->daddr, csum);
> +			break;
> +#endif
> +		}
> +
> +		uh->check	= uh->check ?: CSUM_MANGLED_0;
> +		skb->ip_summed	= CHECKSUM_NONE;
> +	}
> +
> +out_unlock:
> +	rcu_read_unlock();
> +	return rc;
> +}

...

