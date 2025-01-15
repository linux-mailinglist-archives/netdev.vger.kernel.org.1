Return-Path: <netdev+bounces-158349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA731A11751
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131AB188781E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951022DC29;
	Wed, 15 Jan 2025 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbDwDP2P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA24502F;
	Wed, 15 Jan 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908455; cv=none; b=JjTi2L8UktxCFmwMO+HmtqURzw4tC0OF7i8v/cJ/oH1VJSYb+X03sda8ykZ7Dn8pAFPVYVOdSjlpgte4uzhxJtzE+0mfQqYjqjV438oL//5dVQl8g+XzGXnnH1OxfXCXsDaFCuSpV7K8n9Qv2QZMrB0g5sAo7R0O3GOdOEFMdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908455; c=relaxed/simple;
	bh=0GduT77PTmTFltREJ10LStJ4FI+1pB1H1AcBSh3sd1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY/edgpVAa8VV2pF1R42kLiU3wwKNV5HpF3aapqsX88AyBv8ZR4F6Lu97Ma3/BFfxHJCYg6QRo74bUrhV401ZW6X1vIIOvUqhUlCUgVYVJDC42B1qR8x2gPSOVWdvZbMqNWCQRCxiOuyuI36AQX531JJ7SfX7qPFILArqzHsCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbDwDP2P; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so10281396a91.0;
        Tue, 14 Jan 2025 18:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736908451; x=1737513251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRcnAFzvXdlWc4UHhAzH7Qrj8PlVITjNIxD+h/EtYRI=;
        b=kbDwDP2PiNFAQHlPYI/NkKaMJkgpQ30CvI4Ig4slZrsZfKiAMP2dwCfkb3mvtLsD2f
         cr+SjxYrf+xC0CuryU32XPj8Gg9jelapkXsgw4G2y76Q51M82eRCnjctztp7ohPzxYE9
         ZBS7M7IyVf8iHqQVFraMuPD+PkcmCskFkvz+Pi39hA1NWvdncges0k40Lu7Yja5Z2fNL
         FHGr7nSluTMaurUzHd69/U6BRGCm3lNVFD87UayiusRveKIud6FokJN0A3ZJh83YiSZ2
         hvuma1HFpmEb6nTT58Qr2oB+GttqrMqNrsnB2/gMwsvyNufH10kvPxJGpqBDvWisXChv
         /c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908451; x=1737513251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRcnAFzvXdlWc4UHhAzH7Qrj8PlVITjNIxD+h/EtYRI=;
        b=FGOAa2w5rmmRfE5RAGJCHsMYSsCtd8PO+0jt638ypUoN+prkIKNDT5hVw3OXRa8PoQ
         rlOpJDk38QK1R+PyDFNLt7hlb+1tM66rh9cCyh5rc9BTRFlVx1U21YxEoLjGTfhqDZ30
         VknlRvmURuoTIvwYirnZ6PmCsI7L1h2KNzgar8QlPCAkjLc84jGKuKY4uKMnohFvUCOx
         HrZqXtizBxqzBC6cNrisThqbtM1Mw9XW70CIa+hz7SC+TsJEM0M2rKn7A503GQtjU0Oj
         AZP3nYfo5eB7nStQVteU+ifWJk9j7zGKQ6kkVDrvRbGiWt3B+ontiRa/hkIwlPq1+AJ0
         yRyw==
X-Forwarded-Encrypted: i=1; AJvYcCWGLdFZQBcKRcLeewg2IVjqfZBlEhmZwv15gQjo7S6mSPg7aa1942I1+ITOrQ4pE5ceVAOqfgfz+Iuqv8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUe9db400DLhcj/IMWZOor4zmxwntTU7joJ46pFXxp8WqAzhxe
	BMZpduEI7gRn7HzomVjHylmq04PDAyqgwCvcyCkWeYFdES26pHtJ1pyORg==
X-Gm-Gg: ASbGncvcvoaIAbYaU0/PK93liCEmX60Oo8NnevLtz/E5Awac7mI8+IYQoyDm74WM+9U
	2InFfQRoYUfSUdvJhqPxZnqCGaR617Bb8Ad9959WXzTXQbKVg1gGdUaGvahOSBwUPBLGegmd5TT
	diuQckzNyEMdHbWgo4SISsL7ReS3dWTRiEBM1WRJEK3NG4enYpqcffNKtuHv5f9tYV1X+fdYe7l
	OYZKLHCzY2BVX8R8GJXtXrZ8JSeDDDeLRhql4zZJdDUOytez+BY2g==
X-Google-Smtp-Source: AGHT+IFb183ByNSb0J0nzR81UMTSxQR60wvthDYKiKHQfrnq8srKLOSDrRHT8CLMHYY7rlkQn7gsPA==
X-Received: by 2002:a17:90b:3cd0:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-2f548f09e88mr36058871a91.5.1736908450551;
        Tue, 14 Jan 2025 18:34:10 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c151cbfsm247347a91.6.2025.01.14.18.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 18:34:10 -0800 (PST)
Date: Wed, 15 Jan 2025 10:33:58 +0800
From: Furong Xu <0x1207@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Optimize cache prefetch in
 RX path
Message-ID: <20250115103358.00005b57@gmail.com>
In-Reply-To: <Z4bzuToquRAMfvvu@LQ3V64L9R2>
References: <cover.1736777576.git.0x1207@gmail.com>
	<668cfa117e41a0f1325593c94f6bb739c3bb38da.1736777576.git.0x1207@gmail.com>
	<Z4bzuToquRAMfvvu@LQ3V64L9R2>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 15:31:05 -0800, Joe Damato <jdamato@fastly.com> wrote:

> On Mon, Jan 13, 2025 at 10:20:31PM +0800, Furong Xu wrote:
> > Current code prefetches cache lines for the received frame first, and
> > then dma_sync_single_for_cpu() against this frame, this is wrong.
> > Cache prefetch should be triggered after dma_sync_single_for_cpu().
> > 
> > This patch brings ~2.8% driver performance improvement in a TCP RX
> > throughput test with iPerf tool on a single isolated Cortex-A65 CPU
> > core, 2.84 Gbits/sec increased to 2.92 Gbits/sec.
> > 
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index ca340fd8c937..b60f2f27140c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5500,10 +5500,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> >  
> >  		/* Buffer is good. Go on. */
> >  
> > -		prefetch(page_address(buf->page) + buf->page_offset);
> > -		if (buf->sec_page)
> > -			prefetch(page_address(buf->sec_page));
> > -
> >  		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
> >  		len += buf1_len;
> >  		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
> > @@ -5525,6 +5521,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> >  
> >  			dma_sync_single_for_cpu(priv->device, buf->addr,
> >  						buf1_len, dma_dir);
> > +			prefetch(page_address(buf->page) + buf->page_offset);  
> 
> Minor nit: I've seen in other drivers authors using net_prefetch.
> Probably not worth a re-roll just for something this minor.

After switch to net_prefetch(), I get another 4.5% throughput improvement :)
Thanks! This definitely worth a v3 of this series.

pw-bot: changes-requested

