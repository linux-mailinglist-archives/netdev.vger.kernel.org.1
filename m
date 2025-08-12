Return-Path: <netdev+bounces-213103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA15B23AA9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006A97ACB7D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFD2D6619;
	Tue, 12 Aug 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QvzZh0vM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671521BD9C9
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033960; cv=none; b=CfN46Wb8uzMIfo19hyk7UhVxEQHydM+24T89zcGq9GWtKRoY4qG/z7ThR/lkyEBSUrIGoxb2Yy5VIvW0pH/cUgnmfXjcKVYrRoQb2NC1StUJTCA+pP063tEY3oNDjbpOfPR9SePYDPBfZF5U7I2gSKmEBpA/zf00JzKXzvAm3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033960; c=relaxed/simple;
	bh=fPIMzHLer4nJddhI8O2E62WmHD18ttDAio0FuA1iDwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUed0WdpKQRTbvwKiaXaiTJgWkputyxWfsqj0COD3sbKjPur0PcuLgjk7APICRXoPpb3lWSPnoKQBYWBMZXUCO7R+f4D4Qlfk6HKMXBYA+OAh2xyZah51iI7n795fFbrxoszOI/YhUNfOktY7iz1RsZ5s2i0YDWiFg4ewGYGvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QvzZh0vM; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-741b8c26e70so1286383a34.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755033958; x=1755638758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzVKlrjH7GZhPoKZH5j7IJVrAFAPLHvGjSArjf8ipGg=;
        b=QvzZh0vMIj77h3P1IFH97P2zpMVAcOuQ/VOP3ZE+sgARMnDwqJjKVbFsaxoJ0ps85i
         L8Rg9qmsP2qKl5f9W2Fx1ELDugx5xFnDgjcUKSE7vWD43s/E/Y30rNpFkrTbflljF8DO
         YAC0lCYopjo6kl5btDqXLAVEnwEh+bYy28UMi6MojQulzCsMAwOpaWJzoXCngzyvG2X8
         /xRnXjSMXtMDl2CybX9IJLdWu6d26ZHJ0ioZ7cFpmP6+zBK2AGKKctrjp/5Nb0NdRD3N
         YPhbwTGJmWthUDhYVy4KGH+5LJ/P0Ss9lXmKWkpTM527jP1cFji2hO+s2UPC/yafGFUz
         O6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755033958; x=1755638758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzVKlrjH7GZhPoKZH5j7IJVrAFAPLHvGjSArjf8ipGg=;
        b=Ss4q00Of/L2oCITWKLvjev+6MaRQnkL9WLAy7vXk7pvgog9NPVSpyl+23KNyxnQeR0
         oB7DksjW6qxSMPtr9rum+aUjR2D2HL+8C0wvwDytJa/WzbNF5hTfyT7cEhoRpbtMGgc/
         L1eNVDq2mxjRMpnyu0sZCdJkPnuzr0K0wLMdHNA4F/4KML6N3bG/ucyEYm97a82ySY8D
         r5C7Jb4ZTntVxOAVBUxW1v2aNbOaDsHpW+8j5zUPKftUlxy/TRocFnBylapwG0Pbs9kM
         T27F1/QgcEPwC5AT/pTqVw/aqLIyCy4BZRlvGTkTVMRv8juWSQIeKGaRKrYWH9aNsp8d
         1UDg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Kp7Z37XiuLT848Ajc3jY/wtAFm+fLGJ0An4acOMRvRWl2Xm6i5/3wgoW3kiDPjUON3R7CYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUi2NRYDb4ReMHWy3DwljZu9+drpu+oKah2V9GkLu23zpkxL9
	J1uzdQQup8d0SV9NdPJ5TsBZkvzyv0kZ6gU+uIIQP143fAyUWL+UVWZqQUHFqH/Qidg=
X-Gm-Gg: ASbGncv6W7OIASxTRu8wociFC5M8IRL9L4G78KDlBqe0fnogB9cp98eNqv+mz/FfyTt
	soHBV8RIsVc+8elhfoLtKfgoG/NHpVjuKgrDdUL3OwrXKRftm81XVy4Lupg/Dh53gqIcJB+1RL+
	3iWu/ytzspoVoAFQXSh58YMyBuEaaZt4arOyL9Ha3HurpEC93Bc8VGxi8yW8Pz7CcM8jnYMC+kS
	8IbJzfOTwV1UZ3o0lP2/ldw/VlwaHml4KD73aMKkUz/Deh7DjehodGvqfP9k61pWohqJQ45fMtD
	IXD1k8i1kGODNRfjKyXPeq94Qvhg9+4xMUHuzwgs9TaBawAVWRf8S92jvXuoy+bkuAgp7f7Zpyh
	H9sKJ
X-Google-Smtp-Source: AGHT+IEI6WAmPo7ACQ/prb8y5Dd2U9go7IlR7TqDOjCTMklTzPK+dWeidueQvi8kfcWBnDxs2yyJig==
X-Received: by 2002:a05:6830:91a:b0:741:3929:31a with SMTP id 46e09a7af769-74375419b96mr715600a34.12.1755033958340;
        Tue, 12 Aug 2025 14:25:58 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::3ce:f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f99337esm460391a34.49.2025.08.12.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:25:57 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:25:55 -0500
From: Chris Arges <carges@cloudflare.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com,
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Rzeznik <arzeznik@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <aJuxY9oTtxSn4qZP@861G6M3>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
 <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>

On 2025-08-12 20:19:30, Dragos Tatulea wrote:
> On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> > On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> > 
> > > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > > index 482d284a1553..484216c7454d 100644
> > > --- a/kernel/bpf/devmap.c
> > > +++ b/kernel/bpf/devmap.c
> > > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> > >          /* If not all frames have been transmitted, it is our
> > >           * responsibility to free them
> > >           */
> > > +       xdp_set_return_frame_no_direct();
> > >          for (i = sent; unlikely(i < to_send); i++)
> > >                  xdp_return_frame_rx_napi(bq->q[i]);
> > > +       xdp_clear_return_frame_no_direct();
> > 
> > Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> > "no_direct" fussing?
> > 
> > Wouldn't this be the safest way for this function to call frame completion?
> > It seems like presuming the calling context is napi is wrong?
> >
> It would be better indeed. Thanks for removing my horse glasses!
> 
> Once Chris verifies that this works for him I can prepare a fix patch.
>
Working on that now, I'm testing a kernel with the following change:

---

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3aa002a47..ef86d9e06 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -409,7 +409,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
         * responsibility to free them
         */
        for (i = sent; unlikely(i < to_send); i++)
-               xdp_return_frame_rx_napi(bq->q[i]);
+               xdp_return_frame(bq->q[i]);
 
 out:
        bq->count = 0;

