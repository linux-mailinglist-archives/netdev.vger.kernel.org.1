Return-Path: <netdev+bounces-94344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EA8BF3C8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E2A1F22E4D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9FD38F;
	Wed,  8 May 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS+ZWWAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838C387
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128912; cv=none; b=Q29BgRSvKkNoswfHXeuGfFx2H3nXJoZ47GUSFvVQ/+CPiYBJ7dcvPNQvMLoPwTXkKY0eqCW83LP9n6Q39gca1Jw0xp/drOvwSkCvve17ELTkii8hHh8ORyxaVUYn6w9TOC3MJV5VTvN+sY4/CJInLS9UY09zAxajieoyAe8zHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128912; c=relaxed/simple;
	bh=nSgzNkhefaPXx9os5W6lvwSXgN69B9Mv7zaCXBCS1UA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTByeAHXHB95Uc3ybt7J42reIYC5W84J+noP2A6qs0Ixa+RN6zhZ0NBoq9WdgceYP/gkNLQ2UyPxOGTVyf814tbXTteyBGbpY2yVFMEZ4pEgOU2dyc3rMj3f6Yge6+ESn/qj8UuLSAYYPeIE2GmvebTXcnBkzfNk7Nl7yXCZm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS+ZWWAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E92FC3277B;
	Wed,  8 May 2024 00:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128912;
	bh=nSgzNkhefaPXx9os5W6lvwSXgN69B9Mv7zaCXBCS1UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XS+ZWWAvHEvNISJ57QTyotEENTuPDso31BbRwTDBoKlXxNdGmUYn/8ebT190g388p
	 eAMlTHddPW+GGpodoAcJYnQXSwWv/H1EIhyN31aFjB5OKTPy7gS+MY83/m1Fe7cCIt
	 4Sz18dcY5g2HecTKqd9141f3eMC9ZpNwAMZxEBt/xg9+nUWqmHarapGyJl0Wp0ezCg
	 kg8HNRzz4RGeaS5CwDbyCjYeQebO1sfl5U6/eVaAEelNdW/JKu+oXDMspPG7MMcrrS
	 0OnyEIJtqJnWxSfVmLhzECD3dQFH1h+9eCoqpwIHpKv7m0h3UJ8j0rdHhYWvOzhn9J
	 WmhwqEa2xcWXA==
Date: Tue, 7 May 2024 17:41:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Steve
 Glendinning <steve.glendinning@shawell.net>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: usb: smsc95xx: stop lying about
 skb->truesize
Message-ID: <20240507174151.477792ac@kernel.org>
In-Reply-To: <20240506142835.3665037-1-edumazet@google.com>
References: <20240506142835.3665037-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 14:28:35 +0000 Eric Dumazet wrote:
> -			ax_skb->len = size;
> -			ax_skb->data = packet;
> -			skb_set_tail_pointer(ax_skb, size);
> +			skb_put(ax_skb, size - 4);
> +			memcpy(ax_skb->data, packet, size - 4);
>  
>  			if (dev->net->features & NETIF_F_RXCSUM)
>  				smsc95xx_rx_csum_offload(ax_skb);
> -			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
> -			ax_skb->truesize = size + sizeof(struct sk_buff);

I think this one's off:

static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
{
     skb->csum = *(u16 *)(skb_tail_pointer(skb) - 2);
     skb->ip_summed = CHECKSUM_COMPLETE;
     skb_trim(skb, skb->len - 2);
}

