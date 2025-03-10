Return-Path: <netdev+bounces-173403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFBEA58AD7
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7725F3A8E68
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12F1531E3;
	Mon, 10 Mar 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkUCkDBO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD731E492
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577445; cv=none; b=Jgu9oFlCwNxBMIz+D46wW+FKJY73uP/ufUr2GinjnKhXvx7eJYUXzsUZaQWbyz7QekopIvg1oSJY0Q2IRU7k+4PMzFfhZ4xbiDJDo5T9/Bj9iXLOPritnlmOcpxKlEA6X8zTvGlYShzX9N3jPaTHe9CnRdqkPV6SofYa2EanDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577445; c=relaxed/simple;
	bh=pBAVhAbOenmyBN7w2xTDDcGrUPzXOAm4iGeRGsPG8+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kHqbnoF6MxNHQETJX4Boj/IWjemlXW18WBYw9jCt6+taIG+vzbyx1WeiHpeImMeT0yR2nAOCnOugWMM8w4Hn9g4cq1x2g8vQWAtwngeBrQgsRvTdvQvjN6Xsw9zKqIjx+ytYcoK7CqUlGdbH6fwvkmXL51N00CGKwRFqaqPJ2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkUCkDBO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so33247946d6.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 20:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741577443; x=1742182243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTBP7mJpMAYnIIA+oGvbf7uMZ3kt8bSWJ2Fl4pnoJqY=;
        b=hkUCkDBOqIdpiN2rcAka7X2eDWVaaIbPtjLdE9q2q3XxlKFTqt4QlSqpEpyMFAl+QJ
         qm1n9HYUcF3dKFopLBkVPEthJWRwLdXBtGAs8Z4Fpx4o3C2pgZ3Fg7vDYxOdCi7WYbgw
         Oq7WA5ZeBsUuFD3Ch55NZ+ueK0PbRQAG7AgKN3BWfeRcQSKgU2Al6A7LDCscIVPl3sD6
         0J53GIDerdsLfnoTVOJS7eRuQPbhv98x1Bk6LDF2gPnvtQyrZ+2RCJJvigehDB9tURFa
         yVO4LentTCgL62eYzSmJDNr1QIwb9yBGc3rzS1F3gvguGuXdhdMh3FO+bcVYWaArIhw0
         rzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741577443; x=1742182243;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTBP7mJpMAYnIIA+oGvbf7uMZ3kt8bSWJ2Fl4pnoJqY=;
        b=EnpNZVzPdOIGQY/BBOI/6xkZiWcDoiNr8SBdr2Rqk5z1GQCJX3rjNHiXMzqAFWWv3B
         CFF/uRSWBJnYVYjj0Ok2DCOz57AesJndLYHtXTXnk+C2E2SZL6ZlIuZfBMUd1BrMNIjr
         bPthTj0sqHLffkuWswN18WXfCwMeBLOy5/DOft9NgGBFAxleI/4/rZlkYxUfo651lstJ
         fceDA1sQVRbV7DHF5OC9uMcrwAJKclxASbZqwltkCEli8j4pdgysbTkKI1yRmSz/1kgs
         RkMfGDI/o32Y9dWoMZ34wlqmpCOb8ZBjMCLeoIA5kqwA1ym2KlDtNbQwZFfa8fSEaNpM
         Qj+w==
X-Forwarded-Encrypted: i=1; AJvYcCW+0l8HNOf/ibIP/M4CIJylsQrrEqksCnOqFzGjRKo8wC8AQ5Yd0dv3X9S/nCnq5BOsVK3kaW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhC/rJP/P2z+C1pzbZ6qn2W8IGDtiEmbCdaf1WDDQwh/3lAwuD
	plGBp7CIf8pQBQJqRl2B5qqGQRX2aZJkjfW4AygKfEfAsp3Vjagh
X-Gm-Gg: ASbGnctwSORxhf62dhejW/+QFSwWtR1gKpkuQI7wU4HG6OZYhgStSFlXoXpXe4ux8kS
	k3KqROc6VuzgZloKPG4EHksnGpEzWIuEca4SP22JXVUw3xAfKBmc8Qp6Co/R5ivibwXYxfaYuwh
	AHYSwRWTgBj6LX76Dxyy5QTd07vtX31oNX0t1nVcRtf+rVVfUNGbXjorWm3+nftF/CWpknySqyw
	8a86Vfx7OAIm+duCnprej6t2CPR/lPG3Lw/U9LpDDUVSWhjTjXeWGWDzfcrLJlO3lSKk+VvlGbO
	8zEp3HMZQc5/bPEAI2IoI8f+8+9lm4ATzSGrRFYQB3pTAqbvOB81LR4Oy5TnZuMc/zY4+h8qyra
	CfF/rtfcKkXqBv9kcGZ+fQg==
X-Google-Smtp-Source: AGHT+IFVNksxr91cwaIdujsMDBCDU7YyU9mq7ou75f5ZyA1EcO4No2dTAjV4WU0PkxocT7iIFxsrUQ==
X-Received: by 2002:a05:6214:1d24:b0:6e8:fa33:2962 with SMTP id 6a1803df08f44-6e9005db84bmr130505566d6.10.1741577443088;
        Sun, 09 Mar 2025 20:30:43 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b718sm50733466d6.91.2025.03.09.20.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 20:30:42 -0700 (PDT)
Date: Sun, 09 Mar 2025 23:30:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67ce5ce1722a4_20941f294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <2dfd7292-901c-4155-9c80-954d2b0c7507@redhat.com>
References: <cover.1741338765.git.pabeni@redhat.com>
 <8c8263ab59b1e9366f245eec4dfdccd368496e3d.1741338765.git.pabeni@redhat.com>
 <67cc8f317e5e0_14b9f9294b5@willemb.c.googlers.com.notmuch>
 <2dfd7292-901c-4155-9c80-954d2b0c7507@redhat.com>
Subject: Re: [PATCH v2 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 3/8/25 7:40 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >> index 054d4d4a8927f..f06dd82d28562 100644
> >> --- a/net/ipv4/udp_offload.c
> >> +++ b/net/ipv4/udp_offload.c
> >> @@ -15,6 +15,39 @@
> >>  #include <net/udp_tunnel.h>
> >>  
> >>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> >> +
> >> +/*
> >> + * Dummy GRO tunnel callback; should never be invoked, exists
> >> + * mainly to avoid dangling/NULL values for the udp tunnel
> >> + * static call.
> >> + */
> >> +static struct sk_buff *dummy_gro_rcv(struct sock *sk,
> >> +				     struct list_head *head,
> >> +				     struct sk_buff *skb)
> >> +{
> >> +	WARN_ON_ONCE(1);
> >> +	NAPI_GRO_CB(skb)->flush = 1;
> >> +	return NULL;
> >> +}
> >> +
> >> +typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
> >> +						struct list_head *head,
> >> +						struct sk_buff *skb);
> >> +
> >> +struct udp_tunnel_type_entry {
> >> +	udp_tunnel_gro_rcv_t gro_receive;
> >> +	refcount_t count;
> >> +};
> >> +
> >> +#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
> >> +			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
> >> +			      IS_ENABLED(CONFIG_FOE) * 2)
> > 
> > CONFIG_BAREUDP
> 
> Why? AFAICS BAREUDP does not implement the gro_receive callback. UDP
> tunnel without such callback are irrelevant here.

You're right, of course. I looked at the wrong callback. Sorry.



