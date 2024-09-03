Return-Path: <netdev+bounces-124690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DA96A742
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D56CB236E5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC51922D3;
	Tue,  3 Sep 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJVrD/Ln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD017CA1F
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391182; cv=none; b=gEakCZQfAtjxbznsj8s9t5dHyAAoPoB6xgLabzecarE8IvAzgcL+nG58tRRBk4HVwBXDjYKaqnjSQnzVJ0FZfdWBTiRbx3UxfPbO/ixlKvLKkcegb+S4QiH66XYb5qlv6DilO9iwrV+n5k2cfNlAzmYRwAqDHhk014jyiFvtM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391182; c=relaxed/simple;
	bh=WNCilwwoB/xUWavGNCoCerqBHbXqQqYLDd7KXhJx6OE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrNVFrL8RX5mepD2f1GdiCfojQo3JxxRnKe5CKhIID7QZqGHekDEjanarKRYV5/iTw1LbnOVrz5mL4wYlaMsPK63pwHKCyDKsJxR6VEu4ZNSSYBpGiWGlV60+SGdc0yDm9P+ODqeXKqprzMtxOSXM9AcO9vD0XWljVAMnAPbzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJVrD/Ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C318C4CEC4;
	Tue,  3 Sep 2024 19:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391182;
	bh=WNCilwwoB/xUWavGNCoCerqBHbXqQqYLDd7KXhJx6OE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJVrD/LnhspqXrZaS5r6UeiKHZQUC9anuvuEX9o0qCbRQLk+aYF/yCZpEiso4HpPx
	 aJ+6fzmPKw9hNViv0qDDF6gkea5hCiFUO+bALS6HR1puQaIlSwPGZtrv9RQ7wpMa/C
	 W0EvEakOI5/LuivLfpMgBXkWhPDqDUlE4P5w09F7Oie5F7u7QIUJ6dbGp1/5t2s/mQ
	 NnEaiMjNcOWOcvbTwYl/XCaZt4YeBWCAvVJGt2Ec0+7Lt0GVs7z+EgwPZtlbwuIJiI
	 /AFq3YTXliXHcM5iFwCFA785lVIoaq4+7hm2h+7IYvnH7nidwnod0DrWp+3xCApRiy
	 halC+aHbMUxHg==
Date: Tue, 3 Sep 2024 12:19:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: willemb@google.com
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
Message-ID: <20240903121940.6390b958@kernel.org>
In-Reply-To: <20240830153751.86895-2-kerneljasonxing@gmail.com>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
	<20240830153751.86895-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 23:37:50 +0800 Jason Xing wrote:
> +	if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> +	    val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> +		return -EINVAL;


> -		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
> +		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +		    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)))
>  			has_timestamping = true;
>  		else
>  			tss->ts[0] = (struct timespec64) {0};
>  	}

>  	memset(&tss, 0, sizeof(tss));
>  	tsflags = READ_ONCE(sk->sk_tsflags);
> -	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> +	     skb_is_err_queue(skb) ||
> +	     !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &&

Willem, do you prefer to keep the:

	tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
	!(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)

conditions?IIUC we prevent both from being set at once. So 

	!(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)

is sufficient (and, subjectively, more intuitive).

Question #2 -- why are we only doing this for SW stamps?
HW stamps for TCP are also all or nothing.

