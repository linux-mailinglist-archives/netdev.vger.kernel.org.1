Return-Path: <netdev+bounces-203275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033DAF115D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBACC1C24E03
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AFD24A064;
	Wed,  2 Jul 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB1L180q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4ADF42
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451152; cv=none; b=Bym6mzsU+Rad/6/wp3pVLAWKUDZFvNcqu5voKendSc2EiDF4b/54zNE89vFjOEEWDFfgZC6xV/IjgvDWX5py6lYU+8y+WhJuJPqhgNy6wbiMknU2NFFCWs0FNsdlqe/USzJEZz2O5h3BM9lv938xuVZGghNFTdKpiYCuxkd9rAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451152; c=relaxed/simple;
	bh=f7+FI0iNSUmIxIMhPsNF0+U4GL6/zYxqVsQivBG+ev4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qntJSu49Z7dBHhuhgYfM7YvMpXX4IkCM2yEO15Ps/rtA09lXSu+UtejsCTF/0DMer9PpBdaYuyyUvMdpzZknpTjdI4Iqf/gVRvy/RjSukoYuj8n8o0KnlMDUcBUEUyij7opgCktKorIt4nkGHagcq5mxlvFtXImU/L53CgZd+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB1L180q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751451149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rW/ve4fITH+t2k4lpIjQkl/5ZS7BQkmYLbS75wlyfu0=;
	b=VB1L180qDtcMnQhNOKTJ71xUarqivNvxJ/3nv1dA9XZHQ0DWHULFRQ725gtmdDFos2ynna
	mVUwng6lZjhKELSnKX4OObUsho+mU8hZwQGT1CykD+srz/9V9IwroJ2vH9cu8OqPd2Ayi5
	PzysrmQVRg67ZBEIKvTqGI2ip494kWE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-TURemWyWM4eZ98yUZVrkFg-1; Wed, 02 Jul 2025 06:12:27 -0400
X-MC-Unique: TURemWyWM4eZ98yUZVrkFg-1
X-Mimecast-MFC-AGG-ID: TURemWyWM4eZ98yUZVrkFg_1751451146
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4535ee06160so32078025e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451145; x=1752055945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW/ve4fITH+t2k4lpIjQkl/5ZS7BQkmYLbS75wlyfu0=;
        b=Z+hkbhh6aqoe35h73NMhfHeHHsSDChekYbRUrDNMJ5GdyWfQH5nWuUu52E0+zH0UNK
         5xqIaCe4aaankiOiGKnttkDmCI2ZiSw55408sDVtOLdeN4WIPXDDmBOcpIXLW5HYvUYH
         AAjPpNNobh0Od7RgMrT3zVsh5soR0XeRrORZja9S/6bLmgYwotQq75LXlREcA6G1dJzD
         j6RQa+PeghUzSmHy55eJ80lUO3Y0Cwm89LT+SSNWtJPl6+GHbu7gGn2S50KHv7HR2YNZ
         rMtOFpvootjcZsJIxz5KQ6ltw0BLvhDRzgHoK0sGhAU0aG6oqUy4deBF8D06597r+qAZ
         oJTQ==
X-Gm-Message-State: AOJu0YwaMxySXn34QlY9hxmxrhExAjNAS1JgfQkvrDHF1BFgpNDbLFpc
	QER4GFFFTFaLxmF+lomc6JiXJb7lX3X0yA/Jroog7rlhTLiB2rMrdInO00LOTv63j0Kd6aZmNGV
	dhg4p9G5gvbRAiV1Nc0+ngmT7kNUt2GDHegvdzoFke6WEYT6iwQpF7xI89N7lsi1/Tg==
X-Gm-Gg: ASbGncsWmCUO84M3hIRzwS81tXFtXxgzBR3IWb2rNGOk/x9uxB2TTccEtkEdsZdZl/k
	i+Mc+rVqTZx5vyuwkeGPEK8MGB9hSuYVQhKSrsIBu+y+hPCLXT4rffA6ff72udvBwS3Tnq2CJnT
	iUNh1/nU1G+OgeIp38AXaS/UDVhU7qN+t7wzAsxe96hTSjLZLM47aJge3JXMoKiOvX0CH58C6C2
	PJnH9TiEb1kjeCZFyUGIYMeFdAZoMgEFSK1D7YM8Bbv7e2TPkftDTA2w+BU27kly9+n78DjOz8d
	nf5cY1vjttHOmtuI8MHi6p9grthQi5/lgZResO/z+GOMCSLULcLVac0ZYzWds6E5AhaOfmMLIsq
	YAQ==
X-Received: by 2002:a05:600c:a105:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-454a370c077mr22090245e9.17.1751451145409;
        Wed, 02 Jul 2025 03:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOgvufspVbwhR7emxYMBzfljMqsW9U9kwM7nHO45T9yM3Xq82gPk8KUgWPuyy9a/J1a1AZlw==
X-Received: by 2002:a05:600c:a105:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-454a370c077mr22090005e9.17.1751451145054;
        Wed, 02 Jul 2025 03:12:25 -0700 (PDT)
Received: from debian (2a01cb058d23d600e5b568f376de6917.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e5b5:68f3:76de:6917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm228086305e9.28.2025.07.02.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:12:24 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:12:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>, Aiden Yang <ling@moedove.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, MoeDove NOC <noc@moedove.com>
Subject: Re: [BUG] net: gre: IPv6 link-local multicast is silently dropped
 (Regression)
Message-ID: <aGUGBjVZZPBWcRlA@debian>
References: <CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com>
 <aGFSgDRR8kLc1GxP@shredder>
 <aGJ7EvpKRWVzPm4Y@debian>
 <aGO0whOGhE4LmVo2@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGO0whOGhE4LmVo2@shredder>

On Tue, Jul 01, 2025 at 01:13:22PM +0300, Ido Schimmel wrote:
> Makes sense. So you will submit it to net and extend gre_ipv6_lladdr.sh
> to test for the presence of a multicast route?

Yes. I'd just like to have a confirmation from Aiden first.

Aiden, can you confirm that the following patch fixes the issue on your
side?

---- >8 ----

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..870a0bd6c2ba 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3525,11 +3525,9 @@ static void addrconf_gre_config(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev)) {
-		pr_debug("%s: add_dev failed\n", __func__);
+	idev = addrconf_add_dev(dev);
+	if (IS_ERR(idev))
 		return;
-	}
 
 	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
 	 * unless we have an IPv4 GRE device not bound to an IP address and
@@ -3543,9 +3541,6 @@ static void addrconf_gre_config(struct net_device *dev)
 	}
 
 	add_v4_addrs(idev);
-
-	if (dev->flags & IFF_POINTOPOINT)
-		addrconf_add_mroute(dev);
 }
 #endif
 


