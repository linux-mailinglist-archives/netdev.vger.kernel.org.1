Return-Path: <netdev+bounces-249565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759AD1AFBB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7AAC3009850
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B335CB93;
	Tue, 13 Jan 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZd4apTj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8D2NXRr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636233F361
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331647; cv=none; b=sOUB0smGU4Dji7EheXkwuvGuPZJJWh5q6lpG+59xw6Y90EZEHlhLW5wHEhL7j8S9J2P3DDY7QeWOcI0XtZu4Ii5Msj92ENs/PTvU1bzUMzIM/4HN/lby1GjrvSP36ypen0y0KQKqWf430c7Zhm7/p+0eNAiVIX1HAlcDWDnGMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331647; c=relaxed/simple;
	bh=LMSAKnqmAYg0gUQhq4taiKtUI2w1I8db/VTnRKLg+8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMPBYYDHrL5eABkD+z/yQvXZ3cJlTseXZZBbbb7reyXbp3JHLyu9BQ2duvYiLlgpPE40LhKPsA+i/3bllvsN6Hieh/H3n1DDFSC1MkO55jXyIsQV5reAI+6NwZ3G5zJsWdhi2XU9/PuZl8TCqXuItr66bKEqw7hs+7G27obptas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZd4apTj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8D2NXRr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768331645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt8mwEPnCyfAi5XHqE/76i8N92H9kw+T/67S2vMLtu0=;
	b=QZd4apTj/mWMyhlNshHw1N1Y1VEugjgyMABzYm1m3m9D5LIZGmWsmppcFWgo5VjE7s/9xV
	y3FpAUyHkeM8skIOIFW/RHZBdh7THlq6gWK1+HczF56JD26kPRMHCrJihyKJI/kEpNbhI1
	Akxb36z88FrzUSCo5hhsQJgOJ1NmYLE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-U2lUXgeyMSeQER0VREWJWA-1; Tue, 13 Jan 2026 14:14:03 -0500
X-MC-Unique: U2lUXgeyMSeQER0VREWJWA-1
X-Mimecast-MFC-AGG-ID: U2lUXgeyMSeQER0VREWJWA_1768331642
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so54152595e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768331642; x=1768936442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt8mwEPnCyfAi5XHqE/76i8N92H9kw+T/67S2vMLtu0=;
        b=c8D2NXRrvlt24PbJO6wnLL4rzy/Px9Lk68mLblSG/JE/kB9zEsWlKj8ra3dxvx1VL5
         G0/gSVEY9m/Uq+Y+EqU8htD5CcO7/FZ3wVrqADexpaNSHwB4Mmlo0XVNdcpsaw+urSCx
         xGenju6jN1r0gXEXGiERbTKir1N/22VfiAaZd6Ux6Odw9UVhWSvkOt1wgmi+bPESbhlH
         C+WAyNunOnBVYNvCEjEerndwyC0IyMu50Ojuwf5zS5x73ZQu6/5ZcfFnL0G/c76FhDxJ
         av+dWdPzLGRWC4LTyZC1wa3DvDfzfDh5wrNPZ4oh6jHqEi7rX+hdU9UK0nwgyy1pwMmK
         T5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331642; x=1768936442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt8mwEPnCyfAi5XHqE/76i8N92H9kw+T/67S2vMLtu0=;
        b=DvxqmVOzdfuTGwQoU0W5CS8hSplNfBbzwDp/kswTsQ5FmwjZvgfW7hrn2/mTO7NqDA
         yWM/ver0RSkRcD5JB8pXbLl3RIP7LgPm7l2KrJE3SfYmRHyz9JAgdb+z1yptYLfNBRtd
         vZI//hNtKXs8N4IHOaXnENxduN/HObkQUC3LV7FJmQbx1wXOI7vzQVZqMB83f4feqh+0
         2vWaopZlbf1E9deooTRLg8/HOsMGk1mG4grgMG9I9pINSe7zpluV3kUGanoshTt5okQW
         dn8zu50lpmzQnD4Px5Gdy7SGsJq2g7eEpCNa8aE8fiH6dijHcG4FGzmmCFLbLWZOTUMk
         i4YA==
X-Forwarded-Encrypted: i=1; AJvYcCXm5DsLBRX2W3SgWUbuTEHGQs9o61a5KBYh0eyT9CGM8lGzCgibxCwUpRiqoKUZL5n6x4F8T/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHksQrDuYxfr+q2hA6xZtLKoW0fRHlYRN/BUVUlJd3O3R3OyE
	//E1y4akUDu9myFTkMBZ9rjcj95bptY80BFTfRKYR8ruk/VxlbMp3cVi72rlJIUt4jpn5ZbN+zz
	1tKRHAujysu5rVDaCeO+9ZiLV/aSOu/4OrYdpgv93njtR2VbROSfqXuS3Dg==
X-Gm-Gg: AY/fxX6kgtFYx9WkoYNyFT84E4n1z51XVoNNeckHF63G3p37fDpUCbMZQwMdwI3aHo8
	GmJ3FHwUg+ZjoWuvBssosk8R7Bny6Gh4X+Pz4L5kMbRDSJhX9qa2g4oLzXDa/od65NdFNRSp5IV
	+dNRxB6GAPthSIwK7Ri9IyC9RAT93RwSK3Cb4X2WGdo4BrEcsEys+Ug8YRGcY1F3RxQLLXU2Ofx
	Ai1FKEtC/GEDO5gG/HIV3FjR73k49kHszL8PEpeWt3Th/xhpqsiYfrJ8BNfg//mu3QTbOXi/dPP
	Djl8rgno3QErzEHOGgoB3YDfCBx0Bs4Up55t9m1C3f+gyFdktu+vXbz4Tvx7OtX6x+R+Rcvadzg
	oay/bdYqbowJoA/xbgDwjw641cSpe4FlUqpwrd8cTxqYfJNl8qC2L3NSUjOjNlgux
X-Received: by 2002:a05:600c:a013:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47ee3394823mr2704445e9.23.1768331641697;
        Tue, 13 Jan 2026 11:14:01 -0800 (PST)
X-Received: by 2002:a05:600c:a013:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-47ee3394823mr2704235e9.23.1768331641314;
        Tue, 13 Jan 2026 11:14:01 -0800 (PST)
Received: from debian (2a01cb05923c9a00a0d1d6054a0ac1cf.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:a0d1:d605:4a0a:c1cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm416843605e9.1.2026.01.13.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:14:00 -0800 (PST)
Date: Tue, 13 Jan 2026 20:13:58 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+2c42ea4485b29beb0643@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] l2tp: Fix memleak in l2tp_udp_encap_recv().
Message-ID: <aWaZdj7VcRCOK869@debian>
References: <20260113185446.2533333-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113185446.2533333-1-kuniyu@google.com>

On Tue, Jan 13, 2026 at 06:54:44PM +0000, Kuniyuki Iwashima wrote:
> syzbot reported memleak of struct l2tp_session, l2tp_tunnel,
> sock, etc. [0]
> 
> The cited commit moved down the validation of the protocol
> version in l2tp_udp_encap_recv().
> 
> The new place requires an extra error handling to avoid the
> memleak.
> 
> Let's call l2tp_session_put() there.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


