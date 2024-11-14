Return-Path: <netdev+bounces-144625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949899C7F4E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F821F232F0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4392F46;
	Thu, 14 Nov 2024 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOaJgYaW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD551A95C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543574; cv=none; b=t6UljR9o0/dczWqeg28tZfUUIvkSWgqFiKY1sH9/Ef/wq87tYjK5/6izC+QUVLho3/MjtyTW+AMWp53OGpwk9s3eSHm6ALc8dWSOOT035PwNc3UM6bR1lMdzy/+v+0j179d/KyxUzXcY41hAkInkzT+XdFrR8qBJAbh16a4oe6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543574; c=relaxed/simple;
	bh=wcTsk2mVkM+r7LsGJm4puGmmXyvFM3Y8N0uW+fmzclQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQobPIDyH8ePe3DWCBaIrYym2YI6M1fUBnm4+34HDZXKclNFIwu5v1tzaEC0eYX0Bj+bQoHXnwio1PhFlxYTevBYQlx8IrPQM7kQ/gIcZB0FWEibTASqQBVordY//JpcSMwpPotf+iSrD0N+JC4pkN0E3ir32ICDw4tAIf+hdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOaJgYaW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731543571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vYNALOT6DNGlmEtNWgxZMEKRhF8lG4UkCDFtAuM+6U=;
	b=ZOaJgYaWnyoUVFZ22oABWDCHx3ZV+s+7zIDpmXjLtLctAGdTGWHD98xxSYplxB/GT6mFAe
	Ioymo6BRqMMzvEmXRYX50uk8S8DZyzJBPk/DoZ5+j4Ll2+0AzEGicCMnWfZQE07ak7iWM2
	7zz6u8l1WnCWahqpHOud7z606+P49hI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-FzTjUe5COG6LYHa0TabANw-1; Wed, 13 Nov 2024 19:19:30 -0500
X-MC-Unique: FzTjUe5COG6LYHa0TabANw-1
X-Mimecast-MFC-AGG-ID: FzTjUe5COG6LYHa0TabANw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-381d07c377cso49370f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 16:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731543569; x=1732148369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vYNALOT6DNGlmEtNWgxZMEKRhF8lG4UkCDFtAuM+6U=;
        b=EaU+ycI1h8P4pqO3/SM6VfeIoNLmi/cWiSyZ0GPotyQy4CKR6voDm3ySpvNhfqoCuv
         MTaLm5KTprlHJgPRt5dMY8tWrW//PMINvr8zk8Q/GM8EIGKvZh9C8V95QKByAAM/Trjk
         0B/VHoMsu6Gdq3LAJKqR0pukiTZAm8BJtjxVF/5oFmTbsU+AV0+YGISYyizF1XDzZnLl
         dmi0d1g/JoxGjxw1+3DRT3puQ8YvzFtp1iT58NN7kaO7uPgUDV9cXHigMe4dOYUXw++k
         VWRdaYWYqm8VBBqhCPHvGYGRATPVM6GBZ2wgG8XS+n4NtLdZeZXX7pRGqBNhvNMdX6lt
         x+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk/mMEpEITzROhoZkM36RAQYAMwVRmvPBOR/KQHKChxMZwR/eAFPVlNi/5/N7bexBs/9Vin1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysik+XDkrIBbBS+Awh4/3cKAYiD9RZQYYti+Vo9qha3d2NIS1b
	M9sYINM1RqX8OZCkzDMQgnRUF338CbQ04IL4W7F5URNMoVHt/UltrKQ+KUiAfANdP9nf1Yg/T1d
	xCHNGyHTq5W3TE7pjUE7fJ03FiChhYmQAVdFFFX1o+Lc60Vhj8yfErg==
X-Received: by 2002:a05:6000:1787:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-3821851d4b3mr124870f8f.30.1731543569351;
        Wed, 13 Nov 2024 16:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHla6u9cLVl1Wqs52W5Mfvd5j65qZLmBa44jl8fJ5Gw0Gn/CPj8Fjn/+LKoJOkV6nFVRLDqOw==
X-Received: by 2002:a05:6000:1787:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-3821851d4b3mr124859f8f.30.1731543569024;
        Wed, 13 Nov 2024 16:19:29 -0800 (PST)
Received: from debian (2a01cb058d23d600736cb2b04c893998.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:736c:b2b0:4c89:3998])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298760sm3619415e9.37.2024.11.13.16.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 16:19:28 -0800 (PST)
Date: Thu, 14 Nov 2024 01:19:25 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>, Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net-next v3 0/2] net: ethernet: ti: am65-cpsw: enable
 DSCP to priority map for RX
Message-ID: <ZzVCDZR8a/xchDU6@debian>
References: <20241109-am65-cpsw-multi-rx-dscp-v3-0-1cfb76928490@kernel.org>
 <20241112140833.GP4507@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112140833.GP4507@kernel.org>

On Tue, Nov 12, 2024 at 02:08:33PM +0000, Simon Horman wrote:
> + Ido and Guilliame
> 
> On Sat, Nov 09, 2024 at 01:00:06PM +0200, Roger Quadros wrote:
> > Configure DSCP to Priority mapping registers so that IP precedence
> > field (top 3 bits of DSCP) map it to one of the 8 priority queues
> > for RX traffic.
> >     
> > Also update Priority to Thread maping to be compliant with
> > IEEE802.1Q-2014. Priority Code Point (PCP) 2 is higher priority than
> > PCP 0 (Best Effort). PCP 1 (Background) is lower priority than
> > PCP 0 (Best Effort).
> > 
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> Hi Ido and Guilliame,
> 
> I am wondering if you could find time to review this series.

I don't have the IEEE802.1Q-2014 spec at hand, so I focused on
patch 2/2.

> > ---
> > Changes in v3:
> > - Added Reviewed-by tag to patch 1
> > - Added macros for DSCP PRI field size and DSCP PRI per register
> > - Drop unnecessary readl() in am65_cpsw_port_set_dscp_map()
> > - Link to v2: https://lore.kernel.org/r/20241107-am65-cpsw-multi-rx-dscp-v2-0-9e9cd1920035@kernel.org
> > 
> > Changes in v2:
> > - Updated references to more recent standard IEEE802.1Q-2014.
> > - Dropped reference to web link which might change in the future.
> > - Typo fix in commit log.
> > - Link to v1: https://lore.kernel.org/r/20241105-am65-cpsw-multi-rx-dscp-v1-0-38db85333c88@kernel.org
> > 
> > ---
> > Roger Quadros (2):
> >       net: ethernet: ti: am65-cpsw: update pri_thread_map as per IEEE802.1Q-2014
> >       net: ethernet: ti: am65-cpsw: enable DSCP to priority map for RX
> > 
> >  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 54 ++++++++++++++++++++++++++++++++
> >  drivers/net/ethernet/ti/cpsw_ale.c       | 36 ++++++++++++---------
> >  2 files changed, 76 insertions(+), 14 deletions(-)
> > ---
> > base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> > change-id: 20241101-am65-cpsw-multi-rx-dscp-000b2c4af6d0
> > 
> > Best regards,
> > -- 
> > Roger Quadros <rogerq@kernel.org>
> > 
> 


