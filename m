Return-Path: <netdev+bounces-119271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61507955071
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2153B2292D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B94145A17;
	Fri, 16 Aug 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN/Mooy9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CCF817
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831248; cv=none; b=LCzLtSxWBrRqeqJxFJP/5yYRi7m7JpE3VPuShepiRx64boeJpMO+gLbQRAjxjqOEatIZCrpGXki93iNVpEKdeqPbhJl26FhBazclv59fHJxluKR/WkeDI2QI4X/O3xHoQhJmKn9tq9OVXP6doA8mldSxByiLJ7+BuW8gmTvrVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831248; c=relaxed/simple;
	bh=VDMfZZRcDwUagonBK8/wRbCoC67c/V9wMwdbiVs+S38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj3B5Ts3el7yLHTyH1r3trxOYYUTtt/JqRQ5x7rbkQH3ddwVI4TVvAZabLWAk/Cb2ZgbONVXFLDnk6pr1RYAtAlmXO6ZIWkxHDxwQoQXDcr9JRWBDl/yVuR8kJ2Nvwbv5BIbW2ZWs3uSJ87OCwFwD5X4ITcZzBEaBogcMWUDIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uN/Mooy9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so26155051fa.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723831244; x=1724436044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GiDsqoi2Q0TC45/632c6NzMYP3efVuzD7ZaIUUq5gQE=;
        b=uN/Mooy9gAPJqfMjSEGGzDgUKANRJmuAAxuV1/bAEh2cDVHBcoeubZoP+FDbNR8SQF
         kBdsJeSP2e9xgp8G4v7O6h/XMkubtgJfxVteqAgUCiqUQMcOqowazdYoCR4lfUSaotV3
         Mn5I4t8bGbBvgXUJabSuCGCBpzsZw181FlbTrUxHRiYyXHkuwh80xVHdrIhwGRF1lLTP
         VgcaQdUtPFetfkRBcOgQn3qcMnzH4X/Xkd2ioUm3lrDKwVSMHCcsqbC0XpLka0E61zlU
         F/9Zipu+9HxKVhw7Kwq/J0N78qUw8nTred7QINhnxo7Rbd7ZnPEpWCZRtznIKhbsxiAc
         b9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831244; x=1724436044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiDsqoi2Q0TC45/632c6NzMYP3efVuzD7ZaIUUq5gQE=;
        b=nIs7P5by52JQiiJ4IRqCieFs1xkrAJ5HtlIrlUgyYeIvJHLX/aUM/Gv5979F3z7UAy
         7E5SHSHb6sb8KPeu/ItfqBqW9EW5Mod7utFWQIGKZ52T4fk9OXlWw1iiEPrrIsxYAjM/
         911gNxf43mfOh6WUqz22gwFYLzSAYxdCaKtoFfTWkdnBubCrKKnGULFzx5QMr/1q5uSk
         hKJHSaO91m+yEu7uQmayLx8VvFXDw9r1PB0FFwawwzj0GLmxJsOuxrowI7g/x4nA6utH
         X3E7NeHTnlopkhRHcEO+/Im+rbYfCly3EXAfc57T8FUc7K8krbXiEwg3l0inHG9AbNpD
         mEwg==
X-Gm-Message-State: AOJu0YzKQYB0FpnLFVOF6jPEZK370WIjjEfhT78vYzSpz9Q2n2KeXWsj
	XE+SVK71eUNn5F+OiTWpzYjz66DmPmgstXW1aIhSoXaLbOAe1hTTNcs7ZGu7n34=
X-Google-Smtp-Source: AGHT+IFfuDaUNRYXxJdAMhNk91UbKqDz3+dCN66kqFe1+eaEQwrnvLx3NaKbY3A7MQDo4ecPM/N8tQ==
X-Received: by 2002:a2e:3017:0:b0:2ef:3093:e2c3 with SMTP id 38308e7fff4ca-2f3c8f25c07mr1965111fa.31.1723831243956;
        Fri, 16 Aug 2024 11:00:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed794640sm28228595e9.41.2024.08.16.11.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:00:43 -0700 (PDT)
Date: Fri, 16 Aug 2024 21:00:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rao Shoaib <rao.shoaib@oracle.com>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] af_unix: Add OOB support
Message-ID: <f2f90f1f-f231-42ad-b94e-6960ef248a20@stanley.mountain>
References: <44c91443-3ac0-4e67-8a56-57ae9e21d7db@stanley.mountain>
 <6c3c2b2e-4fd4-498c-8347-1a82b0b770a6@oracle.com>
 <883c86d2-49b0-4d5e-a360-286865890180@stanley.mountain>
 <07256914-a5c7-4aee-9880-6066c7dcceb0@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07256914-a5c7-4aee-9880-6066c7dcceb0@oracle.com>

On Fri, Aug 16, 2024 at 10:28:14AM -0700, Rao Shoaib wrote:
> 
> 
> On 8/16/24 10:10, Dan Carpenter wrote:
> > On Fri, Aug 16, 2024 at 09:50:56AM -0700, Rao Shoaib wrote:
> >>
> >>
> >> On 8/16/24 07:22, Dan Carpenter wrote:
> >>> Hello Rao Shoaib,
> >>>
> >>> Commit 314001f0bf92 ("af_unix: Add OOB support") from Aug 1, 2021
> >>> (linux-next), leads to the following Smatch static checker warning:
> >>>
> >>> 	net/unix/af_unix.c:2718 manage_oob()
> >>> 	warn: 'skb' was already freed. (line 2699)
> >>>
> >>> net/unix/af_unix.c
> >>>     2665 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >>>     2666                                   int flags, int copied)
> >>>     2667 {
> >>>     2668         struct unix_sock *u = unix_sk(sk);
> >>>     2669 
> >>>     2670         if (!unix_skb_len(skb)) {
> >>>     2671                 struct sk_buff *unlinked_skb = NULL;
> >>>     2672 
> >>>     2673                 spin_lock(&sk->sk_receive_queue.lock);
> >>>     2674 
> >>>     2675                 if (copied && (!u->oob_skb || skb == u->oob_skb)) {
> >>>     2676                         skb = NULL;
> >>>     2677                 } else if (flags & MSG_PEEK) {
> >>>     2678                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >>>     2679                 } else {
> >>>     2680                         unlinked_skb = skb;
> >>>     2681                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >>>     2682                         __skb_unlink(unlinked_skb, &sk->sk_receive_queue);
> >>>     2683                 }
> >>>     2684 
> >>>     2685                 spin_unlock(&sk->sk_receive_queue.lock);
> >>>     2686 
> >>>     2687                 consume_skb(unlinked_skb);
> >>>     2688         } else {
> >>>     2689                 struct sk_buff *unlinked_skb = NULL;
> >>>     2690 
> >>>     2691                 spin_lock(&sk->sk_receive_queue.lock);
> >>>     2692 
> >>>     2693                 if (skb == u->oob_skb) {
> >>>     2694                         if (copied) {
> >>>     2695                                 skb = NULL;
> >>>     2696                         } else if (!(flags & MSG_PEEK)) {
> >>>     2697                                 if (sock_flag(sk, SOCK_URGINLINE)) {
> >>>     2698                                         WRITE_ONCE(u->oob_skb, NULL);
> >>>     2699                                         consume_skb(skb);
> >>>
> >>> Why are we returning this freed skb?  It feels like we should return NULL.
> >>
> >> Hi Dan,
> >>
> >> manage_oob is called from the following code segment
> >>
> >> #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >>                 if (skb) {
> >>                         skb = manage_oob(skb, sk, flags, copied);
> >>                         if (!skb && copied) {
> >>                                 unix_state_unlock(sk);
> >>                                 break;
> >>                         }
> >>                 }
> >> #endif
> >>
> >> So skb can not be NULL when manage_oob is called. The code that you
> >> pointed out may free the skb (if the refcnts were incorrect) but skb
> >> would not be NULL. It seems to me that the checker is incorrect or maybe
> >> there is a way that skb maybe NULL and I am just not seeing it.
> >>
> >> If you can explain to me how skb can be NULL, I will be happy to fix the
> >> issue.
> >>
> > 
> > No, I was suggesting maybe we *should* return NULL.  The question is why are we
> > returning a freed skb pointer?
> > 
> > regards,
> > dan carpenter
> 
> We are not returning a freed skb pointer. The refcnt's protect the skb
> from being freed. Now if somehow the refcnts are wrong and the skb gets
> freed, that is a different issue and is a bug.
> 

Ah ok.  Thanks!

regards,
dan carpenter




