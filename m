Return-Path: <netdev+bounces-96502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693398C63D7
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962651C22A72
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E225916B;
	Wed, 15 May 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih6BVQNR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0C59155
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765847; cv=none; b=M6bY5n3SH3zwniCJGBjz7CVJQsokzY/BvSrig4Zx3pLIcRD2JyjrXyQdlOk4XfOU+uTxZrW0EpYfWaauT5CMzRmFkHfxOTMLqWISqTOejKuvwSpredDTDijcxL2MzbrNK9QTyWUgSD0zr+2iMoOVrBZwHy0REkMP/aR+0A4nEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765847; c=relaxed/simple;
	bh=rL5jMTiDnb5jjSpXW0gR2o+NoebryN5IT0s2xIEfXYc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j20nbf8Z7nblqwfmoqax1y42Zszj0EZevFPE9sXdCFTWz6gtsm4Fm29xRpG/8RgEYZ5DvnYYdhscrSuS/9fiBDhbg8tNjGe1XCEAt9oy+LBjsoxRqm8PI21FRqhZTGXKM6fjOmwEKeQiRAH5sobn9KjPX7LNJbmteTFp4lqRRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih6BVQNR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b432d0252cso1635819a91.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715765845; x=1716370645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+HBUktTN7oxu+GjJ+n+Y0Eo/t/C1NRi/FEC7xKjuyo=;
        b=ih6BVQNRUreExDVTrhGaODFmEkouo39yBc3rZL9zoDbnYNrJCDi0IE0PU+CRmW/BBP
         0WlpVZmxo4TOVAFlcZb0jJoB45wgFC9Ce6izKl6nVKV4zjspOJk8FDYz2/aYXrz/9SPA
         41NURIzVygrbzyTVXcfjvXbWKT3R1bvtYOw5j4uUVKEerD/VR+Z+94e+u/e2d6DXN1Xw
         PgN8qzMyPpKdVi8qpmg3UV/2Cu/xkwBOgvxh2f1QwiP6gyCSUdXJBIRUb20o2cx/8/OZ
         0RZSLl8T8/7oExQBVjWSq+YLkHwyu9KYu9BTjCHLOlaLBWyjlsgplF1PZxU7VBKix1FK
         O5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715765845; x=1716370645;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+HBUktTN7oxu+GjJ+n+Y0Eo/t/C1NRi/FEC7xKjuyo=;
        b=Orl7bLpzzZhH9JU3+z93yeVDWN7xWZJcPyp1mgHkrx4UwlU7lrOQ+yIP6FzP7WZL0K
         E/gIXeeZsZkZTh6iPTjO+vBmPsUJSQmSetcRdIxmfiXR6EPK1twwJUnQqZo9u1l1KDO2
         z7vf7FYbyXFR+1WEESMX/xbQ7cxUnqKYzxHSXMH2q6GdWCbVAwBrImtC2g40PS8ffVLp
         vEdEYrXo/GJZbHKeblEuFLqtJmprriE4tTtSWF61/B2yhl4ZjBRPAaJVP9xj+84GLRKN
         WYVa+O5AtKMK8vE3T9yJW7JqE2YuSKIdMAhFKArD5esyqAqs0zE0c2ExSVK1ehT9lpeJ
         LYMw==
X-Forwarded-Encrypted: i=1; AJvYcCVFAtwc5aZwzC7KicXvoTen2JCuhpwLGSaCmHRay3Q0LYIuWoettJSrgTABUdvojlUk6r61yYeFjI0p0SWgjBdIviH78BJI
X-Gm-Message-State: AOJu0YwNvfkjTgtikQMCX3Z8yU+lmOcV6CpQsxnIO+IuFfGUxPQX9DDL
	JcBm3pkcjhycnUUUPYfDHIGl3lRXhYZOrUiL3U+skjr2FLbct6ol
X-Google-Smtp-Source: AGHT+IG+ZyDZ+WUABpkXm8E7lwfC7AmQkgs7fTNu4j01lzw/vpE/RsLXWLAqMQtSvOGV/r61uMtF+A==
X-Received: by 2002:a05:6a20:3ca9:b0:1af:aeb7:7a10 with SMTP id adf61e73a8af0-1afde07d850mr19744433637.1.1715765845536;
        Wed, 15 May 2024 02:37:25 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2565b6sm113322495ad.295.2024.05.15.02.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 02:37:25 -0700 (PDT)
Date: Wed, 15 May 2024 18:37:19 +0900 (JST)
Message-Id: <20240515.183719.2094245718391165470.fujita.tomonori@gmail.com>
To: jdamato@fastly.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net
Subject: Re: [PATCH net-next v6 4/6] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZkJd55Y3MwsBFG2_@LQ3V64L9R2>
References: <20240512085611.79747-1-fujita.tomonori@gmail.com>
	<20240512085611.79747-5-fujita.tomonori@gmail.com>
	<ZkJd55Y3MwsBFG2_@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Thanks for reviewing the patch!

On Mon, 13 May 2024 11:37:27 -0700
Joe Damato <jdamato@fastly.com> wrote:

> On Sun, May 12, 2024 at 05:56:09PM +0900, FUJITA Tomonori wrote:
>> This patch adds basic Rx handling. The Rx logic uses three major data
>> structures; two ring buffers with NIC and one database. One ring
>> buffer is used to send information to NIC about memory to be stored
>> packets to be received. The other is used to get information from NIC
>> about received packets. The database is used to keep the information
>> about DMA mapping. After a packet arrived, the db is used to pass the
>> packet to the network stack.
> 
> I left one comment below, but had a higher level question unrelated to my
> comment below:
> 
> Have you considered using the page pool for allocating/recycling RX
> buffers? It might simplify your code significantly and reduce the amount of
> code that needs to be maintained. Several drivers are using the page pool
> already, so there are many examples.
> 
> My apologies if you answered this in an earlier version and I just missed
> it.

The page pool hasn't been mentioned before. I'll try it.


>> +static int tn40_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct tn40_priv *priv = container_of(napi, struct tn40_priv, napi);
>> +	int work_done;
>> +
>> +	tn40_tx_cleanup(priv);
>> +
>> +	if (!budget)
>> +		return 0;
>> +
>> +	work_done = tn40_rx_receive(priv, &priv->rxd_fifo0, budget);
>> +	if (work_done == budget)
>> +		return budget;
>> +
>> +	napi_complete_done(napi, work_done);
> 
> I believe the return value of napi_complete_done should be checked here and
> only if it returns true, should IRQs be re-enabled.
> 
> For example:
> 
>   if (napi_complete_done(napi, work_done))
>     tn40_enable_interrupts(priv); 
> 
>> +	tn40_enable_interrupts(priv);
>> +	return work_done;
>> +}

Ah, I messed up when I changed the poller to handle zero budget. I'll
fix in v7.

Thanks!

