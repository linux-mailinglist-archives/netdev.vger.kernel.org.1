Return-Path: <netdev+bounces-204419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9374AFA5C9
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594EE189305F
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5F2AD0B;
	Sun,  6 Jul 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qij0/zJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF06CA6F;
	Sun,  6 Jul 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751812222; cv=none; b=VtrVfBV6Jvb+Bh0RVSlYbQHeSE3sdEKW9hrWlr/dPN9eRoeEtra15uzWPxHSW0FFcMHhfvIyExSNXiU+sUtce0Uq/3BxHv4lH/HnQlkJHQwz2nNeq+prdQpMQBk9SCwwZDizCz+X6o1i4xXTchml9JAPvKi/9qDgi3PFIq1Ysuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751812222; c=relaxed/simple;
	bh=Os3p122TLkem1wFS19Yci4rOcV8RY/p5XKcAomC5zKk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S/z5H27Q2OrZCuiUnaimJArEN+zvZ9kkhiQyO2RouLsE8OCSbMghXvqOLEl5F1GKSRwuYMJGvPPl8/4UkjWe+pTguyzU3y0qYpeCP96EB0U0Xm0UE2Rc3tHbTxYBHvHnY83be9OLPjAG4cv0oq5Iq0APQ0kU63o5ASTfVBQDwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qij0/zJo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8259b783f6so1757296276.3;
        Sun, 06 Jul 2025 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751812219; x=1752417019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILk6V+IjCGdWOhQWfk6SrwBKe81/cN3kOICCBDFtPzw=;
        b=Qij0/zJotKtNvL0NFyrVDuBOhanG5L655xQWOAEGGEOnMUxHhNOOxB/wHbkx1MJjyy
         20zm+EN2Xo7KJ8n384QjGtKu77x5mPFg3VPh5pRiAH45heOBuCiRJ9Jqo0Nf93LAW5yu
         r9zHt6gfA6Z3RKsCZ22EQ/DBXIaEkrxRa1ovqZ1MHTWUfkqSuSjqZqokpod1wrk+RtCD
         yf/5fa1TGXbnooP6TvhJ22KbrGyOxU4JatR22PYUVMroS+c31NanUThBnru4FZLs+aqL
         AEfX1DIKeGQ9nlSTPja0paBENwkKRSSeKhfVrZutCIVeYx2q791fxuC2jMrezmh8J5nJ
         eD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751812219; x=1752417019;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILk6V+IjCGdWOhQWfk6SrwBKe81/cN3kOICCBDFtPzw=;
        b=tdFq5A2LXRfSQKT11V/1ZjJSys3cer6pBnh/K0ZF0mRRgFgibFwaqhQLE/6WS/9fGc
         lztNmH77Q72QmE/5lU+WBpxS6j6dU6Jk4EQDJAaie/gw4XJ2r7KkA0xIwBDfLN+Frh5O
         JQkR2bKXLG8+f5nL+kHWh8btXE/7kl3oBK/L7d4lpPOYg7Yd3C+DrPGmd8fDb7haPuEX
         /1R1k90XkPYbllyq6ONTlnJJQ5SAD5lqgiErgwErLkmfq7oWe/4gKNrjINAwveZRqe0v
         gm8dDuaavsWm94V1B8PoDs2WoUJ6Ih1owJyEf35WJahKEnrJO0GiPkY0yrBJDOUoiX21
         gEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCaQpRLqW9T7k2PuH3XZLmq3OxTW4n9Vl2yh4kSlXgBkKvBPoqfcemHMDK8L/W/xHtSoZflnIB@vger.kernel.org, AJvYcCWuqjA9TrQnZULVTSDXD4P+cVTTQHu7rKCN1inKbNpP3d51rdsEhLr4J23dvgaQp2Oh+mOO6PUE/0rIyTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+IceVEMkv9/TwvpojLFtusEB2hCyG/7DWTPrkdFX0KMcI8/c
	6Ae7hKauOJtT8KSHj7Z4Mo78VoDK2iFf1daYOQ2xvKbelQInT9o4UCGT
X-Gm-Gg: ASbGncupq2WdgzJN3/2lf8a0o7RUsPtg4BfjKk5As/zpkN7prVV+20l+tYcFXYb+blt
	FB6JlPeRYucLw8Zp/hwJOSp3KCD1hYD6BQQcRj/Hjn/qdk0Ar9PnAMGGs4GmSPKqYmUsOR9bHx8
	RoWeq9Y4vzjGQw8tMxbb7UfpaM5Sg8M2csYZZFTGBOGUsvIUSadsumQb5vUfjduVhI9qOWARdfY
	eOVKDqti9JyvFVLVU8X3ClOC5rYCadG45G9LYxJvDStsgjngYPYnW3sTFc4CbmBLCkQu+SAwEW4
	VGydidDTERQOTMm1qWYsMMe0N8Qx7CxNzgigqBkaRsZRhLw0NEBMfdip7UZPKWeE/j1fqIf1Q7o
	0mpx2eTC6yGMilx/A9RHtoq4PvKgo/FWaFDo05rA=
X-Google-Smtp-Source: AGHT+IEBmKQ51ZAVM2knwYxTBZrzCKTaZIBinugB6wBxG5OAXF22jsYHYXdSZcwqnMwbxhIIzKhdhg==
X-Received: by 2002:a05:690c:38a:b0:712:d946:788e with SMTP id 00721157ae682-7166b5f6d7emr106376527b3.14.1751812219293;
        Sun, 06 Jul 2025 07:30:19 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c440e7bsm2016366276.37.2025.07.06.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:30:18 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:30:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 Fengyuan Gong <gfengyuan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 toke@toke.dk, 
 edumazet@google.com, 
 "David S . Miller" <davem@davemloft.net>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Ahmed Zaki <ahmed.zaki@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 cake@lists.bufferbloat.net, 
 willemb@google.com
Message-ID: <686a887a34d5a_3ad0f3294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <aGdZFhGu40UD6UDU@pop-os.localdomain>
References: <20250702160741.1204919-1-gfengyuan@google.com>
 <aGdZFhGu40UD6UDU@pop-os.localdomain>
Subject: Re: [PATCH net-next] net: account for encap headers in qdisc pkt len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cong Wang wrote:
> On Wed, Jul 02, 2025 at 04:07:41PM +0000, Fengyuan Gong wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 11da1e272ec20..dfec541f68e3a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3944,7 +3944,10 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
> >  		unsigned int hdr_len;
> >  
> >  		/* mac layer + network layer */
> > -		hdr_len = skb_transport_offset(skb);
> > +		if (!skb->encapsulation)
> > +			hdr_len = skb_transport_offset(skb);
> > +		else
> > +			hdr_len = skb_inner_transport_offset(skb);
> 
> This pattern seems repeated in a few places, other than the two you are
> patching, I saw another one:
> 
> 2465 static netdev_features_t hns3_features_check(struct sk_buff *skb,
> 2466                                              struct net_device *dev,
> 2467                                              netdev_features_t features)
> 2468 {
> 2469 #define HNS3_MAX_HDR_LEN        480U
> 2470 #define HNS3_MAX_L4_HDR_LEN     60U
> 2471 
> 2472         size_t len;
> 2473 
> 2474         if (skb->ip_summed != CHECKSUM_PARTIAL)
> 2475                 return features;
> 2476 
> 2477         if (skb->encapsulation)
> 2478                 len = skb_inner_transport_offset(skb);
> 2479         else
> 2480                 len = skb_transport_offset(skb);

From a quick grep, this is the only other case, right?
 
> Maybe worth a helper now?

If only one more, I wouldn't respin for that.

