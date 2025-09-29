Return-Path: <netdev+bounces-227200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E85BA9FEF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12913C2FB9
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA830C117;
	Mon, 29 Sep 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTo96j4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B366308F35
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162622; cv=none; b=CfHevhA6Rqqh26tOzpmlzamX9m+2S//6VDsdTRZ5bosl7WWq1qIo4yR6VE+Ru7Z4LoRbSPV5CqxkZtFqjzug6tljJnC6dikZoqzZ9amK3RAIWEB68ZCJ1R9UN2Vc0Xs6jgrlwDKoEZeLA3pRrv+z7noILtG/nazAb4SiIkl5cZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162622; c=relaxed/simple;
	bh=qq5Q8e7Te10C8Wo9eDCpNyBThP8X8+Pc+4FkCD7R3Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBPnqII5ow/sbJHwxqnN2TJgTgujE/JsEPDVVuEcFnV2isJV8tW0KagdK5mOaUIzJVkuc+fYJWDqPUIKD7lB1DRYehFcNYDPo713IZ5VIiRjci5IXq+r7vLa3CT/oi2TMxN8taAwzd5pef7hrGpHlnN1fsncUAGorTI1PM+IvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTo96j4D; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-749399349ddso60347617b3.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759162620; x=1759767420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKzIOAQG3VSXuePCJFysarRmV4K2U53AVIYmuNypgnQ=;
        b=kTo96j4DFA7uLW1dNpzrSrUjcx5ffqcP5RZjeACYzjLZwWSSw7Mj6BDJHtW36/BZbv
         f5+f2mn0yxwapQvW0O0CNpv9LFfU7UhCkuX3X0nIeh3tSR23sBpdchwDYcFun/dQs2KZ
         2iT28Lx6mAS8UjDVF2bPNZnAdg6+IJTIO33TCMs6INKsO7Reh65Vs9IVfeH30QWjM77j
         sDo44HguQkpTVE2bQkkYTf0HqIuOWjqOUq1Hy0aQzPuGPHh/F8+VaEX3d9iHEeUoKkV3
         GL5SanhpnuhwplHiJmx+5aCIb2skDi2KW5LaS2NPcB2svlz+9DUncNuvJsmER7cIh84N
         Kwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162620; x=1759767420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKzIOAQG3VSXuePCJFysarRmV4K2U53AVIYmuNypgnQ=;
        b=HVWw+PFbX/JwiQ1VrDePKnusAiBxfnzp0+gS6EkrJh4oUkIIAgLLx24R+r3uZZXGZ1
         3eO5KAMyKAyBwG7dLtXSnqARz4mmBA5hrFKbxGu7BtEv1EIF0HB0kjZqOJpOzoX0g/ED
         E+cVjxj2pmXDNcsZK9RfuA4hW9je+ROT3r7jStCVjow66gSXV5yzQx6P/g+EdaP0FqbH
         VcYuXn2d9LtMeHHMPg/zI8G0lM2pOKKIdwNNILp9SG8eKVuPAGlpBs4FTIVfkUsMMTgT
         PDyuztkjvrCX/sxQoIlK44Htskv/4i7boGoqlkohMOYYfus6Cx+7qlMdAmHVAvFRGC6T
         Q9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXLwzABOUT8ez3kviuoQxyGAKopQXUKbEdgBfSqpMfo8ha+nAxiXn6G3FTlP0KYq125MAKEel4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTi0d1y3R9sLJW0doZG7SreY4yA9aAqFlilXD1GL/4giEBQSJX
	Nk6ULaHxiBMuqxhl2itS6KXzX08Gz2ag+fjw+R6cazQzw52A9WJs13Fk
X-Gm-Gg: ASbGncvdc9EWOZUH8lGeflUTKP4oBW9Q0oojFMZuYDC8Zlrn//B/Wyp1xlHWwSC5Kp9
	FfePhLGc/25SCJs2TB9wEjPM1t3sU6dExfr0bmmowtQ/PT9xVxDG0ygSn5c+JCbcJ0qezSwGyjW
	ieBnWJVDPUkvz3JeVfdTYafPj0TqVkX2jPJjoCff+S/RkjExbnOgHL3YZQ6Y0i/7/LuSLIuD6o+
	ggJcxSnyKT96zOgaU0rDmm4d5004EEN7adkZ0rVA1o2bJZ4w51M0fX6EtGL/D16R+KWFZZ1oyfq
	vAMZ2jzesa6yzaNn+VDxRGpGZQJWA+YCwj+P23K30mxMTZ1P31y8+B0AEMhIUHsDRP73XJg66vd
	LFitDG5NpjLi1V/avTPRieKBhlysKkpktuhMaYGo88YkoRqouEEeB8ztcQ3dHkyvSMw==
X-Google-Smtp-Source: AGHT+IHu+j81jqxT8WdCqypyIMYi8bUERDK1Od/FPtKQre70kkWgVYXAP03ywVWVYKUxZcJ1PFX0Dw==
X-Received: by 2002:a05:690e:23d5:b0:633:adac:db35 with SMTP id 956f58d0204a3-6361a72af2fmr13975034d50.3.1759162611159;
        Mon, 29 Sep 2025 09:16:51 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d847sm2712547d50.9.2025.09.29.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:16:50 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:16:48 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 2/2] net: devmem: use niov array for token
 management
Message-ID: <aNqw8CAVjas0vvGm@devvm11784.nha0.facebook.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
 <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>
 <20250926162245.5bc89cfa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926162245.5bc89cfa@kernel.org>

On Fri, Sep 26, 2025 at 04:22:45PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Sep 2025 09:31:34 -0700 Bobby Eshleman wrote:
> > @@ -2530,8 +2466,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >  		 */
> >  		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >  			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> > +			struct net_devmem_dmabuf_binding *binding;
> >  			struct net_iov *niov;
> >  			u64 frag_offset;
> > +			size_t size;
> > +			size_t len;
> 
> unused variables here
> 

Got it, will update after window opens.

Best,
Bobby

