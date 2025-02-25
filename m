Return-Path: <netdev+bounces-169535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2DA44821
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8173E881BB3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D821CEAB2;
	Tue, 25 Feb 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L1vTeP35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95031ACEAF
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503743; cv=none; b=fpyiAuCCpsHotDK1SXkKU2NXCE23O/0IpCPuZC+areH/Jo/AZ0ZMT+qcwfjNp/off//iZRG+isJxcTbkEc8UT45zM4v1weksmmpARJz97f2GG83wTT2CiGl2Pvv8GLEiElNL/k0V06aIgtJioBixLKx/jokk0EjmLQ6CtqaY1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503743; c=relaxed/simple;
	bh=Oh9qveDpeBPDX0ueo5LHz8ALEQAwoHubq74zvNvq0Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZwIP5a7Dlw71dGqR/NuMrn/yNPc9TmJa8j/j6DWBraZ56aaGQ1f2WWT7wdQb2ha6kyIrhgXO7slWrhxsRcFJl9NoUo7hMaFVamHlqfqmss74gvwN0LYs0FdYA4SZpyRYnrwPUolKsMrkIVbxDRld6Cy8E7I5ibXhgHg72Jd/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L1vTeP35; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0b9f35dc7so805308585a.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740503739; x=1741108539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHwme8z9NyvuWB96tQ4/sbcP2cpvgnoKbgrkSHDJ9xM=;
        b=L1vTeP35woKZzs3BbmzZ9d8Y5O7XG42mAa2WKb0JaVGtPmNJbtQixLK6cM7iFlpNWy
         pW9zfRgX5KOKBXVRMSszDkmZc9xMKAJeTibBopJNQIflBk9b+exdZXj1cphILAfvdBsZ
         G86qyaSvB10K6BlDqrDbbZuNRY04sCTL9kCB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503739; x=1741108539;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHwme8z9NyvuWB96tQ4/sbcP2cpvgnoKbgrkSHDJ9xM=;
        b=d10bq9KxacL1KdBKoUbZN8yfkOvUCBwXdWGN1MaOvZFiOKNbATkv0njb92sfvfhmyo
         fPzx9l3iFzmRDSfxbMnKs9QarcmmaSdLTiL1Fzj5kxs3WscdRtuOk3ZClm668riULeV0
         eqimMpN03Wbet3Kgd0nIVZE8NRffWqBO51tao+0Re6wb1+aN9f69d4Ld+i8NRh9oBfuL
         zhaHeTqyQyV/J7A4xFmPeGvTh1LPxEWvL43PhNhnjTqCiBgkM8fo2dOFRBNLQEGBzHN8
         oYDxxeaRoa6rFkEOB72jHuh33309uFh6f/DD/cOPWcIS/oS1S+Lsi/EMF0Pha+MW1QLJ
         HAvA==
X-Forwarded-Encrypted: i=1; AJvYcCUrgBSrcktaOXchLtCYtqLjrVUso3LmNG0DttWZjQvGoBV8a8v+SC2ug/NVBKp2dMdD3Hiey0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytkh7Meb3RKr3dzNUVGTkvX8zxosmWUP4FJ0JSxG75hT4+Jz4J
	XvKg98muBQVxHh9NOIYxoMvbNw8T12RIngGRFvPi6V/9NDCWZ2BvkNPC/FlVF4I=
X-Gm-Gg: ASbGncvM7e//4/9vZido5vXxKRle7+fVKyZGwQWFdgeLu3MhnHoNqKZfVp9LXY/I2P7
	lRx5OcCILer1lpbZR/EKbNwMRMtdH5Mls8bBMGQzTSNdTi2tm1gjoBga5fDBxQqzWkCSQ/95RTM
	XEi+XChSRCqBFloG7Z64n2d+fof9p7/in2yJODJDZvIrualiva284B6VuLyJ3uSCGm1GqvX+Nfx
	PSz/1cyz8jQXuFaGqtxIMRvtHGloPFkRNBXxITdYss2aiwG2xrtKQssP5kkJRmCGJ+xUHt7PIGk
	Ud70Q/X/0eAXm/E2U+dgw1YeSlTu0Cis+DBwbkDLPlT/umHBmkDZS3tiMAyuRlSx
X-Google-Smtp-Source: AGHT+IFWlVJmoMZ25g6N9xuV0RLPTyXIrhhERls7nYMLq+zcOGSsrN4oqa6rpBC2voUQE0/HZI07kw==
X-Received: by 2002:a05:620a:404a:b0:7c0:808b:1c78 with SMTP id af79cd13be357-7c247fcb611mr27877085a.36.1740503739473;
        Tue, 25 Feb 2025 09:15:39 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c34f633sm128901785a.117.2025.02.25.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:15:39 -0800 (PST)
Date: Tue, 25 Feb 2025 12:15:36 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	alexanderduyck@fb.com
Subject: Re: [PATCH net-next v3] eth: fbnic: support TCP segmentation offload
Message-ID: <Z736uO_DiO1fkn53@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, alexanderduyck@fb.com
References: <20250216174109.2808351-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216174109.2808351-1-kuba@kernel.org>

On Sun, Feb 16, 2025 at 09:41:09AM -0800, Jakub Kicinski wrote:
> Add TSO support to the driver. Device can handle unencapsulated or
> IPv6-in-IPv6 packets. Any other tunnel stacks are handled with
> GSO partial.
> 
> Validate that the packet can be offloaded in ndo_features_check.
> Main thing we need to check for is that the header geometry can
> be expressed in the decriptor fields (offsets aren't too large).
> 
> Report number of TSO super-packets via the qstat API.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>  - add missing feature clearing in ndo_features_check
> v2: https://lore.kernel.org/20250214235207.2312352-1-kuba@kernel.org
>  - checkpatch -> whitespace
> v1: https://lore.kernel.org/20250213005540.1345735-1-kuba@kernel.org
> 
> CC: alexanderduyck@fb.com
> CC: jdamato@fastly.com
> ---
>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   1 +
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  25 ++-
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 146 +++++++++++++++++-
>  4 files changed, 163 insertions(+), 12 deletions(-)

Scanned through this change a few times and nothing obvious stood
out to me, but I'm not super familiar with this driver (despite
being CC'd :P):

Acked-by: Joe Damato <jdamato@fastly.com>

