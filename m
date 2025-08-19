Return-Path: <netdev+bounces-214934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C45B2BFF2
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE431BC1E3C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434B326D66;
	Tue, 19 Aug 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCnZUzT9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366A326D5B
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601976; cv=none; b=DUdWMxaOZbuzQoNHfPhqVjfCq0am5rXHekvHwYwZl206LSLeT6gI0j4QxKjNgdLoXoCqNXMImu15q1fAMoMoJMGTTzuMGX552Vw1k995rFpLOAJse3FtOkM/VrcfvgEiL+dLbGfehNx7iwa2S6QdmX7BU7cinvJItfXlld/+mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601976; c=relaxed/simple;
	bh=KPRuQ4WAAeo3vRtFpuFdkkdL0MiYgm8EWUFk0JOscqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifnpGkN1WI4SsGaaiKtPSAoOGTXPyyDH5Lr6OzCDDFAoz82/fjo36ZKVtWkr9zcEOXjdxumh4dgcjtnlXT13dxETAShlBZC3WO2TCPNXG6Xmyp0CdeXtgnNo3cHDHUVNCk66+ON+GjEdq3sFz5XyxDVnx6jDLPzue0SNaS0wDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCnZUzT9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755601974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwiysIJN+lj5NXCn81q0LCDHU+2Tt8hxnK1g8vZiVas=;
	b=gCnZUzT9q7gQ9ESnd7pxUYpBmbObqWSmMS3Nuw9kjv0ZZN3YXWPvkwr+ipzewi8QaqzfdY
	vmC7GA+j1OejMHuXu6lVTFbQbXN1mpmkKtO5ab23chWDJL/HTO2Ua66L77CpyWT/bizQCY
	gfTP6Yt9g/+L/6D43tuUNi3qdeQdyds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-g7vYdka-M5er6Ak8xe9lEg-1; Tue, 19 Aug 2025 07:12:52 -0400
X-MC-Unique: g7vYdka-M5er6Ak8xe9lEg-1
X-Mimecast-MFC-AGG-ID: g7vYdka-M5er6Ak8xe9lEg_1755601971
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b04f817so18381925e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 04:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601971; x=1756206771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwiysIJN+lj5NXCn81q0LCDHU+2Tt8hxnK1g8vZiVas=;
        b=d0cKAtmHazp8hkLHRu7qn83T4MfRfhPTbkZoJad2EszoTcfniZuxIX4bEYvWsSG/GT
         0kdRi4zr9E6cVAW61egkAT2Z0DRY+SxdD6Tn/PaR6s7W0DmfJh/21p7eeAoxTmCT4r9G
         AmbvhGTBtWTXXZQUkNoSrDqSK3AuhbN3+7NdnTxqFa7yeCO/QsQ2SQeuMJukAj71SMLt
         EiRinH6Mduhn5R65GOeYJKURDvf35tlXb8rrN69jX72AB+0ERMJ6ixGt4kPcmAP2HGX1
         IwsHC4IP+Tb7jy7Y3FjvUZeQpVgRnKLPQTJAveqg+AjCKftRqVBwJ42+xmjIG1UspgTT
         w3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWMM8ZaDYZ10t/4Q+91KEIsXmqhLxeE1zws7UC+wn60qEip95kDnz/RVWJJe1dIgy7Oa6lKV1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4LaH4+UlzvYKfnnNPoNUnQekezFodKf7q09Plymx2oyMffiw
	913KtkMYRIxEe1vGjxZ3cvS7SzNhRv3vEN+WKPGWUQEOL0Yf4gFbZbjE+QbJjNgqqa2rtmNAjrX
	0sq8pi05XAlZ7OThsd8m+A1Az1w6w6cqYCDrnizzNAuL+JvJCynt6FTduEg==
X-Gm-Gg: ASbGncuaYcYVevG0p04ZIMdderwhl66HUzUVXmD+Ycqs+t3wqRhMTNBM3M9Orga/8J2
	MOnWC94O1xItb+PKhqel3AbWayDm/ZcdiGVO4FmVhJmg2DLZjENMARR9EeoLUgrzkP9hDHpJLov
	5Lmbiij65e5XLYz9FBjD1ES/Sv+bAtrM21LMg/SUFQZ7mztuQjAiAKnyNPcigx/e4/+i2nCScu9
	hydUyjKtzmq8qe8qsMrEHVuiWBLX/6xCXvBohEKK2Hpd4olUVL+OcnE6o586jVbPA2tUjnI257A
	9yepCUTAE/tBsL/nvrTP15gojo9B/in7
X-Received: by 2002:a05:600c:4f0a:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b4602acfcmr8598745e9.3.1755601971351;
        Tue, 19 Aug 2025 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsW3Tv+6q61sN/85hX28Egss5FzOAF8rmCmjNaTCZprfcs4Nki01Y6mv2kY7kjtPxcgy+NXw==
X-Received: by 2002:a05:600c:4f0a:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b4602acfcmr8598475e9.3.1755601970920;
        Tue, 19 Aug 2025 04:12:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1677sm3355109f8f.39.2025.08.19.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:12:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/2] Fix vsock error-handling regression introduced in
 v6.17-rc1
Message-ID: <20250819071234-mutt-send-email-mst@kernel.org>
References: <20250818180355.29275-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818180355.29275-1-will@kernel.org>

On Mon, Aug 18, 2025 at 07:03:53PM +0100, Will Deacon wrote:
> Hi all,
> 
> Here are a couple of patches fixing the vsock error-handling regression
> found by syzbot [1] that I introduced during the recent merge window.
> 
> Cheers,
> 
> Will
> 
> [1] https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com/

Acked-by: Michael S. Tsirkin <mst@redhat.com>





> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> 
> --->8
> 
> Will Deacon (2):
>   net: Introduce skb_copy_datagram_from_iter_full()
>   vsock/virtio: Fix message iterator handling on transmit path
> 
>  include/linux/skbuff.h                  |  2 ++
>  net/core/datagram.c                     | 14 ++++++++++++++
>  net/vmw_vsock/virtio_transport_common.c |  8 +++++---
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog


