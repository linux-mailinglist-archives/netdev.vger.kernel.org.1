Return-Path: <netdev+bounces-243958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF51CCAB893
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 701B73000B42
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF729BD91;
	Sun,  7 Dec 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BljaGoi4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006226CE11
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765130088; cv=none; b=P5Dd9EANpwhlE4h9urQEFCi8l0YvlH84JSKoez3py9aL0Zxi3SKqll68IUGIyYGLi0gQzy59zVJUp1gXAQhx6EikO91dfo9/LdtC19yIn3eXmWURcfwAagoB3H0+7CLY1qjSfTsoz/KUIjVpCKqnPJBYhX/ImSLZ0vXTC/GFHeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765130088; c=relaxed/simple;
	bh=xEEJXAtJe9X78jWpOkYTohDMLvcrTYMEEta0VPdEvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnKn1L+AwvT/IB/rguty0Eb3I0w8dUhGChGCR4L7G4XZJeIlkXt4ClFWGnt2Lar6QKvN+asN5sVEvBG7zoR5atMyryugTMlowZLtmBcC2pjcm5PfSV92ucd5faK6zeBZoAcRE0avHac/GrhhUe2gBA6vYezIcjUFS/++U27Z+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BljaGoi4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so47983485e9.2
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 09:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765130085; x=1765734885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5IiwUn1lybKPFH6W/FiUkJ16zhV31T2po6Ml8pZU2I=;
        b=BljaGoi4W9Ziqn7P+FY7IZO08qOiaQqQ9eLGil3TAEqYxP42PkSSSbl6+4SVm2/MmV
         4mlsiGTeDJw0hPoo2KSGS9eXAO9rhVveHxeYFdCLuGhXY3Dtfc+1bhX3oubsLCgEWL2b
         NxtTQAP3RPe5DXZljoB3GoinLOV+/NK4PaBWzPXQAyTAKVb/EvxVRx300uZUM4PVRB3F
         MU4ZdJiRJTjdd2XP9J/jXO0qJDkXxjHtMA4RMlz72c1TXs4MKQ4vYFzGj274B+KD3y61
         VnL6Hu9WjtRLKGzJ2X1Lny7hoXmHD780isGrRe/tzmcR+DtzWIhINoFlTij+9it2ncDB
         U0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765130085; x=1765734885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5IiwUn1lybKPFH6W/FiUkJ16zhV31T2po6Ml8pZU2I=;
        b=PeHT7/KUeyV2LKpXe/4BqpiMLLMXrRP+vPbrQpkNcWh054QDiDeZUf61d2fO6wo0IB
         DFkgXZp6BBRxL8DIaQrSNKoQ+L9PiPw9J4wJ1CZhLDyDacQV0Gc0dMlSeqCDBddlXko5
         gy3xfU/wJWPuaZ66QrJCS4QyY5bfP7LcWKB87Nyn1FOojqLbbeebkxL9G8jR1hJXZnwH
         mXW6qXfHBUXuBltAPU7NBaU7oZnd7EVJ6fwE0v84uwSsB0ZXjav661GU5IaYbTQOUiqS
         1bwArBWAQDrXPBu3tu7CekGxmPWPDkY2XGM2qOu/PzhNpbCdlWMKfbjRQF4A5iCpnlAk
         bNGg==
X-Gm-Message-State: AOJu0Yy6kuSOddVM53eEyWF6LPaJKkPxutT9BbBQbicOFK5iyJoMhpWU
	QnB+66a1R+FQ4UTcoLmSXogAuFzdp4zmmlW+NW4psrLyFPP3AixvSQjK
X-Gm-Gg: ASbGncuIjH8FWsa24Y7LtKgcN7MoopqweRRDKQqrWJSP+AVoqYUenuzQSXU1p0SYjQm
	4CmzdNMfnF1Q3XHcGgt8ItqtZ82IfDa6m8urFBXjNhQxlMC8UGnFNsnizwLTrZ5izsXS+2Wiz/n
	ca3Z4XWQwSmFMjWAaZlDLJexHL2go1h3Nk4ET5Taed/jpUs05Nr9YAqBKG2y9ydTzTN70DxCgoO
	bjyWyCXRnbCbahdnZb5f8mwfK4UyOYOH8bmOFcxY0PtV55RXfc1qjJw+CeSYA25sF423I6pJ6TK
	mfibbmaEHlS6rfvkateynyrHxEb3bzGOnYthQr/DbAI8H4mWiiHgZas3oCpzIaT/5yOTKF2pPtV
	C6L1oFGjY7VDAsQdBWlw0xjpL94rZpEeyiCYyHWSQHVuILdyayCMs8YX5dV4y3+EuUPlht3PaN1
	YxmA2LZpS71u+kD7Bl/wUCKMJhgdLIKIrUHMJ6hSxhfJ5/Hq8jI8oq
X-Google-Smtp-Source: AGHT+IHrv/hYUGxZMSSlurgo3lnaMNnCuyfLox3seq/JtZU3yrNnPnKqh/Rvzl2ya/Ag+0t1XekUDA==
X-Received: by 2002:a05:6000:2287:b0:42b:32f5:ad18 with SMTP id ffacd0b85a97d-42f89f0944cmr5066391f8f.9.1765130084697;
        Sun, 07 Dec 2025 09:54:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331a4fsm23321131f8f.33.2025.12.07.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 09:54:44 -0800 (PST)
Date: Sun, 7 Dec 2025 17:54:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
Cc: netdev@vger.kernel.org,
 syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com, Syed Tayyab Farooq
 <tayyabfarooq1997@outlook.com>
Subject: Re: [PATCH] memset skb to zero to avoid uninit value error from
 KMSAN
Message-ID: <20251207175442.7d5ea387@pumpkin>
In-Reply-To: <20251207162109.113159-1-tayyabfarooq1997@outlook.com>
References: <20251207162109.113159-1-tayyabfarooq1997@outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Dec 2025 00:20:52 +0800
Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com> wrote:

> Signed-off-by: Syed Tayyab Farooq <tayyabfarooq1997@outlook.com>
> ---
> 
> Hi syzbot,
> 
> Please test this patch.
> 
> #syz test: https://syzkaller.appspot.com/bug?extid=0e665e4b99cb925286a0
> 
> Thanks,
> Tayyab
> 
> 
>  net/phonet/af_phonet.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
> index a27efa4faa4e..9279decd680b 100644
> --- a/net/phonet/af_phonet.c
> +++ b/net/phonet/af_phonet.c
> @@ -208,6 +208,8 @@ static int pn_raw_send(const void *data, int len, struct net_device *dev,
>  	if (skb == NULL)
>  		return -ENOMEM;
>  
> +	memset(skb, 0, MAX_PHONET_HEADER + len);

That looks entirely broken.
Did you try running it?

	David


> +
>  	if (phonet_address_lookup(dev_net(dev), pn_addr(dst)) == 0)
>  		skb->pkt_type = PACKET_LOOPBACK;
>  


