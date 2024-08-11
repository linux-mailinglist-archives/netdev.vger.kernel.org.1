Return-Path: <netdev+bounces-117542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0394E3B9
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16260B220AB
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836018E06;
	Sun, 11 Aug 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEty8xaO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F315C127
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416064; cv=none; b=T4vuNVHSW6kfmSCLMli4pQn9u1u/HJ7pYalWhrPAgcb8w7AB85Cbks/M5JuJ5IY6GINrnEOnCV/6mNuL+DPZpw9UDw99HZcfahkZQd9CUr5ymEWOrAm8+v5PQHBQql6eJ+IpW0ly0MFHWunuinvmWVD1BE99N4iJfre0D2ZjofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416064; c=relaxed/simple;
	bh=RXfXSB4WM2aiauSe4F1zqzV2spK0jhOuhLYiavZvCcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afhc3JhNzyEkFTtrYINodbor3kwb8Rbf7hTuvKsR55XxVKM9hV+6qktgwGGT8GdmpH42KvYZg2bTatFIeikbBkMydLDmcGdz7DG5N3R7qXED8twJl2JUGBwudg0CImkfx4ytaLkCIGgmWRT0ndnyzf9AoALZYM4xFt2eeZxF1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEty8xaO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso3423327b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723416062; x=1724020862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNAUKUJxX03tLh1OSAUSKIigIQfHyl/gyLNN7uU6piY=;
        b=hEty8xaOeOTua/naUvKgGuuq8W0yUWW1cVskT8EDqUplxHrICRIjd0YTpUlgdSpDr0
         WcWKhbWIuYyv6Ex6S+L84YyT5dGiLY9es5PxigEZgm0RxksvVwsAB77K3B/f5q0kLamy
         tmt066rzSflSGKctSQ4As+1qnUBUGeGBqJwv5pWd78Og8JkemZtcrLlZWT3xzMAkIf3H
         tb/5pULnoz12xKtE8zGTyFJHJPw1cxgT4/4qqyDWMLXsCPnjEqxCSkQhNWeZvd+XawmU
         dogqtqnQaumGvmjAoA1yYPyBgJUDB6uHhCPX31QtN84HJSF85hK/1LwrDRc6YGe9yiHr
         VBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416062; x=1724020862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNAUKUJxX03tLh1OSAUSKIigIQfHyl/gyLNN7uU6piY=;
        b=JKrAF1b0GFldX3wWNDM3MkeFC0NLlZPIcXKisZXIKH6B8l4ltB47jnNb3g+4RqIiNt
         HpUflkUMDlng+sKsHCl+kmTOlEBRNV1XdvaRYdhyIwWWQSY1mlu9UCHpAXPxcF2WuR98
         i3Pt6++f+FDXv455W+sNZnSEjdoZ8fJp7at72XDU5a1IJOg4YEdpeingpGusxIQen0pN
         4w4sIDJA3etFN+8EH/I7DE/sgZkYYKKuBnsSsVyFNMToMzIGzQXNPsPgJAq1EH+QiWvR
         tqp6dM3QXxrtHzIfYIaMfNQ3CTXAKFi84KfNYtfkCzS2CBvbagbBYYxJH5mQS0ktqHrl
         zKhQ==
X-Gm-Message-State: AOJu0YwmddVfQSU+zwQu2hHtmUMWC0cYnC8ObUd42BRqEYkRHA1uVxqU
	xC88PyDKt7v/WWWHlENFwg4yVfzOqPWB9amVi4ImW4vCrLsCq6y3
X-Google-Smtp-Source: AGHT+IEfjLpfGzTBhAkwxxXCAZO6LjxIVS0pMjIW5csJL1z+5rNZkvA6qdYUxPo6xhqOLkXDsZacIQ==
X-Received: by 2002:a05:6a00:218c:b0:705:6a0a:de14 with SMTP id d2e1a72fcca58-710dc62e2fcmr10556186b3a.1.1723416061985;
        Sun, 11 Aug 2024 15:41:01 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:686a:8915:7ca4:6f13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ae0d3sm2799257b3a.84.2024.08.11.15.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 15:41:01 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:40:59 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [PATCH net-next 03/15] l2tp: have l2tp_ip_destroy_sock use
 ip_flush_pending_frames
Message-ID: <Zrk9+7a0doax82Kd@pop-os.localdomain>
References: <cover.1722265212.git.jchapman@katalix.com>
 <8491d89e8ae68206971f35c572190ac8b7882c1d.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8491d89e8ae68206971f35c572190ac8b7882c1d.1722265212.git.jchapman@katalix.com>

On Mon, Jul 29, 2024 at 04:38:02PM +0100, James Chapman wrote:
> Use the recently exported ip_flush_pending_frames instead of a
> free-coded version and lock the socket while we call it.

Hmm? Isn't skb_queue_purge() closer to the original code?

This is clearly not a trivial cleanup, so what are you trying to fix?

> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>
> ---
>  net/l2tp/l2tp_ip.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
> index 78243f993cda..f21dcbf3efd5 100644
> --- a/net/l2tp/l2tp_ip.c
> +++ b/net/l2tp/l2tp_ip.c
> @@ -236,10 +236,10 @@ static void l2tp_ip_close(struct sock *sk, long timeout)
>  static void l2tp_ip_destroy_sock(struct sock *sk)
>  {
>  	struct l2tp_tunnel *tunnel;
> -	struct sk_buff *skb;
>  
> -	while ((skb = __skb_dequeue_tail(&sk->sk_write_queue)) != NULL)
> -		kfree_skb(skb);
> +	lock_sock(sk);


Are you sure you really want this sock lock?

> +	ip_flush_pending_frames(sk);

So who sets inet_sk(sk)->cork.base for l2tp socket?

Thanks.

