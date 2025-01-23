Return-Path: <netdev+bounces-160484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A93A19E12
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 06:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE4C7A0396
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9E1ADC75;
	Thu, 23 Jan 2025 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0PVzCal"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B0C2FD
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611323; cv=none; b=kqxk1jtT/2MMcrHihDAUXsTuJfsTnlsK9ga/E7HpAtyPYODbWP7mc2d/hORc8Gwh28CdrpKHzxXQbONWVAAusxxuzvGqFSND6JH9eXoY4aJdc1vzd7XUm3ZLTs9tH2Nhxug2go5bhGNjs1BNoVVltEWKcg2bYP54g2gMafuNC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611323; c=relaxed/simple;
	bh=kEvoazzEBBRD5gZ07meCmNxt26LbtQKPNXbF1ZZ4GoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juqgVZdagF6xGsyAIoXjY7kwPcLhtGPch7QQ4NWyaqP8juZmYQXjHYKqQzrdDL7lPMbKhDEtGwxxlhsz3FXcFsoLURvfkFyge18NZAtqL1WEzbeXaVQ65VVoe4AUb0Bxp1QF+Ouo3ZVjfI9YibnP33ls/ZXDxL385yOatoAFzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0PVzCal; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso2864605e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 21:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737611319; x=1738216119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5FNxfeI0Gjs1UJg9SIXn0hbte3FEgt2gJ2X+tR1nrY=;
        b=v0PVzCalTWCZFF553s86ykxC8POmBZQbi+82Q4cBy6zdCfPomnwIuudkqeAzW9gq75
         gD0kvXuONCVJguqllZEeXhdtYwpaJJBNNZ/oaotM/K5FGowjGzkOjn41rhe68euTIR4J
         NO0ioOE+WWag16hjERQXuyRrS1fZHVrQqcCFbJOoSV/MqrfQZBAW4MAdeRFLhT3ZL+Iy
         +1ey8+EsYJs9sZsRP+eZk3DdtGeryKr/eXQ8Vd18kjJUepQZov7pwGplMOIPv4QpImMf
         xisI9pfczIV6DQBMyr5wILpPGYUUU0p8qc0dYgTj215Gy8v+E+uTZ8NBGlaKkyvZMsni
         MG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737611319; x=1738216119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5FNxfeI0Gjs1UJg9SIXn0hbte3FEgt2gJ2X+tR1nrY=;
        b=JxeJHxRhZRNKAuaO+D+y3uLE0cpDzpVH90Wp9HKRBEE598Mela+qtB/9UjWqcT1Oyp
         ZJFAkgidmuUIRX+u/44FMxGrSNUORWxLGuHoN4091ZLv66KTklqvhK4Mxr+GZMSvmBNY
         tXjFZdGrQxWev7JvnV106+//LJZZiMxgA09tqqfOmcOss6ULCNr1B4qaCxIBT6JyMuHL
         s42kZwjVmLrQN2aQ67JhzQ7b1Tnjhr3A8W4HDUgDUDOTbPl8wvikbGZZDY1k0j1VQDoM
         khU7QQX4NyQtL8HGL3+1MN4Y8M+0brhqIh1XRv7DHSuUCtvoCKkXhdqP8/Bv5wzoN++l
         F4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVe6EJoMveH4iSwGo1FRADdVU6uLXcTD1/wNIGQK48ZUmtXBQX+FxitnouGrPWgN4NKxeoboU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCh9oHVTyFgC8jAGwbrucU7d22dpHZ+xN53Artxy0gTNHjiriw
	9lCPF1fGrc4g53Cv8KJeSPMcHegjsXmQvS3qSJBaZfDi9natiVyguRYhb53r0geCnk2p3Aof17w
	e
X-Gm-Gg: ASbGncuPyCFGWBjaYWhDmY03Dyv58NvPpjfWKFVl5tXACTlTl8EApOsNW/vfz0JJWJe
	vnV1KQ5cV87eiQ1KE8kDYomh3bI17ef+pMvJZjo/5iGG49pF1QT11zO7v7+Z8zjr8jroaLnREes
	ObTngKysoX0G90jNEsMKWXVuX+DcAEFkquTLBxWx6O1NwNtb02aGZn0ZmH3yOfwq1eyAzNv4JbH
	/AaIee0V8YAlS2J2CBe/JGsMmQ7G43aXQ/cL9Y/ODeakGgLd5I5Cx5G7L3cLise07x6aNMnjHg/
	QT6dERcs8Q==
X-Google-Smtp-Source: AGHT+IELH+bBqrR/DNdgG5xv1+tVHzYnjMiPoKdiDc9L/i/0lW5ZPH1QuoM9q8QfCwS7dKz0mFT1kw==
X-Received: by 2002:a05:600c:5486:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-438913cae48mr206468175e9.9.1737611319450;
        Wed, 22 Jan 2025 21:48:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318aae1sm50769655e9.1.2025.01.22.21.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 21:48:38 -0800 (PST)
Date: Thu, 23 Jan 2025 08:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Thomas Graf <tgraf@suug.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: netlink: prevent potential integer overflow in
 nlmsg_new()
Message-ID: <c428890e-1ad1-4602-9919-ba720546b821@stanley.mountain>
References: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
 <62af8b0f-7361-4099-ae20-f5a55e9cffb5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62af8b0f-7361-4099-ae20-f5a55e9cffb5@intel.com>

On Wed, Jan 22, 2025 at 02:52:39PM +0100, Przemek Kitszel wrote:
> On 1/22/25 14:49, Dan Carpenter wrote:
> > The "payload" variable is type size_t, however the nlmsg_total_size()
> > function will a few bytes to it and then truncate the result to type
> > int.  That means that if "payload" is more than UINT_MAX the alloc_skb()
> 
> In the code it's INT_MAX, would be best to have the same used in both
> places (or explain it so it's obvious)
> 

Yeah.  It's not probably not obvious.

I don't like using UINT_MAX as a limit because why push so close to the
edge?  Normal allocation functions are capped at INT_MAX to avoid
integer overflows.  You'd have to use vmalloc() to allocate more than
2GB of RAM.  So it's not like we gain anything by using a higher, riskier
number.

The nlmsg_total_size() function adds potentially 19 bytes to the
payload.

INT_MAX plus anything less than 2 million number can't overflow to zero.
It could overflow to negative but you can't allocate negative bytes so
that's fine.

The vfs_read/write() functions use MAX_RW_COUNT to avoid integer
overflows.  That's basically INT_MAX - PAGE_SIZE.  There are quite
a few places like this in the kernel which assume small numbers like
sizeof() are generally going to return less than PAGE_SIZE.  Would
that be better to do this.  Then it couldn't overflow to negative.

regards,
dan carpenter

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e015ffbed819..ceeea04fae4a 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1015,6 +1015,9 @@ static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
  */
 static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
 {
+	/* Prevent integer overflow */
+	if (payload > INT_MAX - PAGE_SIZE)
+		return NULL;
 	return alloc_skb(nlmsg_total_size(payload), flags);
 }
 

