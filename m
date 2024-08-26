Return-Path: <netdev+bounces-122054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D345495FBC5
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38282B22049
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6019ADA8;
	Mon, 26 Aug 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn1Jk7c1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8619ADA3;
	Mon, 26 Aug 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708148; cv=none; b=O9sTgILQWfkx10F/DO7HAd834Tl56Hsov79FDexT25MT2M2HHfGm3WU/nSxBd50GaQPJHoUkZJWfpo9vGXeL7KjjNmtWr0w9mpUjrdGo/9+xokTryuA5BDX5CwrElDxctJuA93uihm2k/TJF4zBIJHvk1IVNFwY+nDH0nvNYO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708148; c=relaxed/simple;
	bh=B0lY7JXO7/K86cTfpzQwZAFYbZ1YOJWckC489Vcx160=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoQG19jJcUP9NeUFYbAGNIh40RsbYheGKIBTT7v1ADBFaz2b0iahAC+LXMik9zZ16fHXuUtXF9b5OPemZ/Z6/BQL1WJuA9tKOMEhMZRaGbb1i99aNLRtVaDQ3FSGE/HpEGGCBQFeOfiLg9jFYlSxh0y1C5V7f7RHyj+etWZB1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn1Jk7c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8AEC8B7BB;
	Mon, 26 Aug 2024 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708148;
	bh=B0lY7JXO7/K86cTfpzQwZAFYbZ1YOJWckC489Vcx160=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vn1Jk7c1QdFLGX+ungEU2HZI4dw2dl1VFfhj0V1/1my3FpIuUR6b9CrAhuv5dOQLK
	 Tup4E4ftyXEissecXuSylOQ82b5/ht3g2K5nUUOFACh6q2+0RTuG58C8LuWfJCKhgJ
	 ZkBnSJUsLaniVctABzrKT6nWFBVEgVmi/OQCfPdA8JWfuy8BBUFUbQ5ELeaDaYW42p
	 RCQkPmZrSgpvkxPar3IsmgyfdZs99rIHNn7dEe/pNHktZWHJeC3FAUTz3LV4hkYDG1
	 RWTbiGLipKC60O8yPeMz4TQPf3kQZD8JBoHIIlBRYcp+3EpUJSrEwNnxHTlTaD8YOa
	 ancrPt9TYqQYQ==
Date: Mon, 26 Aug 2024 14:35:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Message-ID: <20240826143546.77669b47@kernel.org>
In-Reply-To: <20240824215130.2134153-2-max@kutsevol.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
	<20240824215130.2134153-2-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 14:50:24 -0700 Maksym Kutsevol wrote:
> Enhance observability of netconsole. UDP sends can fail. Start tracking at

nit: "UDP sends" sounds a bit too much like it's using sockets
maybe "packet sends"?

> least two failure possibilities: ENOMEM and NET_XMIT_DROP for every target.
> Stats are exposed via an additional attribute in CONFIGFS.

Please provide a reference to another configfs user in the kernel which
exposes stats. To help reviewers validate it's a legit use case.

> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +struct netconsole_target_stats  {
> +	size_t xmit_drop_count;
> +	size_t enomem_count;
> +};
> +#endif

Don't hide types under ifdefs
In fact I'm not sure if hiding stats if DYNAMIC isn't enabled makes
sense. They don't take up much space.

> +static ssize_t stats_show(struct config_item *item, char *buf)
> +{
> +	struct netconsole_target *nt = to_target(item);
> +
> +	return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
> +		nt->stats.xmit_drop_count, nt->stats.enomem_count);

does configfs require value per file like sysfs or this is okay?

>  /**
>   * send_ext_msg_udp - send extended log message to target
>   * @nt: target to send message to
> @@ -1063,7 +1102,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  					     "%s", userdata);
>  
>  		msg_ready = buf;
> -		netpoll_send_udp(&nt->np, msg_ready, msg_len);
> +		count_udp_send_stats(nt, netpoll_send_udp(&nt->np,
> +							  msg_ready,
> +							  msg_len));

Please add a wrapper which calls netpoll_send_udp() and counts the
stats. This sort of nested function calls are unlikely to meet kernel
coding requirements.
-- 
pw-bot: cr

