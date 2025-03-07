Return-Path: <netdev+bounces-173109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F24A57628
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC53D176995
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573D20D4FC;
	Fri,  7 Mar 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHWoqqxH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3531DC99A;
	Fri,  7 Mar 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390498; cv=none; b=bZL2xlzxFEoy5GA6a53ejgOIp5dZWmUsxCUHM87hfAJYUL0OS9iMxyTnnjrPEpO/BAv9ew/hGm/+WldCmISSgaRlH2TJ/Q1stDKkg7QxP7qaJho5nUBSqGW4n56sKyf3doyEa9Nd4ejm0zP9jyB/S78V2F6C4KTOd2d3tuhVW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390498; c=relaxed/simple;
	bh=a1YQ9cOh75u3hhehPsn7rsUns7nbPJ2h8AZWjHl/VNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0oF/7j60IufMeEpm6PuESKlbilRc8r1V9uCMdASfh86Wd0MbFszJyeozP1dnSvXtkYvYAC6dn90Gn2nzITT7WocO+6raQQnMxVPSMMTiR7H8fJtihscC2v3d6cN+zSykbltbuB5sOqnF1tiXs9A2aBjJTdpzknnNixpvK6rRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHWoqqxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C05BC4CED1;
	Fri,  7 Mar 2025 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390497;
	bh=a1YQ9cOh75u3hhehPsn7rsUns7nbPJ2h8AZWjHl/VNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHWoqqxHsbCCQetrMiNj0qPKSyAtjw6psSQWIrwG0VG+SbUYjWyvV7N5zGpKmSa5q
	 JwPtglQcUvOPojZhaz1AYm3rMnS+PNmqyqoZzHn9pUlOgvdp8y6h7IZ3IMR9oznrGh
	 B1pLxIzzkJR//9liOZnzgzU7YUVnNf85q5IAPgV1eLIf+WjSC9Td+/Dnkrta1YPKSy
	 bYkMxgj6MY3ZFAyFxJvlfdC3p45n7Xp1XHie1NISVjv5guTllQcrKi1b788DEWLonx
	 DgIHy9AB+TS6RggrO66jY9GlLvsk3dMKqm3RLd0QMwuU9JFcxteS7t6L1CaOX0qofG
	 Trr6Oix1Xq0GA==
Date: Fri, 7 Mar 2025 15:34:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 xuanzhuo@linux.alibaba.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
Message-ID: <20250307153456.7c698a1a@kernel.org>
In-Reply-To: <20250307155725.219009-4-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
	<20250307155725.219009-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a219be90c739..8acdeeae24e7 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_genlmsg_free;
>  	}
>  
> +	mutex_lock(&priv->lock);
>  	rtnl_lock();
>  
>  	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	net_devmem_unbind_dmabuf(binding);
>  err_unlock:
>  	rtnl_unlock();
> +	mutex_unlock(&priv->lock);
>  err_genlmsg_free:
>  	nlmsg_free(rsp);
>  	return err;

I think you're missing an unlock before successful return here no?

