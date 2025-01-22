Return-Path: <netdev+bounces-160260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546AA190D5
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D4D7A1476
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083391BDA99;
	Wed, 22 Jan 2025 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/WZnmc/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A17211488
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546328; cv=none; b=IYWEr4x1nwpDvhXRUoLw1QdaEWYe56XBRWdhLRE1iB/mx9fr3Mt0StX0TwtCNY2fsaxQUz+qJ1qHRMaZGYruf2LcYuhFY497uAEfRLTylet7vs9kg4qzDYSnJSc9ZR6BRXX8Nmuc4VjPYClDlN0zKRjELfBUkHBKWEyzynxG1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546328; c=relaxed/simple;
	bh=X2SiPsyfMirWfRHX5GF2g3/YdQID3GYfvpMSdIHPQyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8sJy+G3KdmBF18aJ0oeLAYrygOj8SVtEx3uESg7fY0uDvPlUe/Mo9hsYzfUDDscK0DueR85fXY9foS8vMAYKtlaqJG6JcPBclvkTNoxVR+YPVu0ozGrsVU4433nOuC93JNV99g13X7tlVbgJ3lp2UUSbyaahBGF10HGDWBsx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/WZnmc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737546326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4XR+yrGa/wmvA8Csi++peVQzkFW1gDYwqkez/5Wf6I=;
	b=h/WZnmc/iCXeS/AN13kAsyT4DDI0U/K3QjT/LcgTmPzf2U4jp+JU5xId2xC9w6Q3yds2kO
	ou12QxOr1cYDnjPF3cs44n4u+UGYEBHhtIk2TeQuz551r758b2aZNb8rJOliLuoO4DIjJF
	jkmmXnFPPeLukKYyVFGCnJtSVlNgHpI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-bcInkei0OAWJxA1P9o7A0A-1; Wed, 22 Jan 2025 06:45:25 -0500
X-MC-Unique: bcInkei0OAWJxA1P9o7A0A-1
X-Mimecast-MFC-AGG-ID: bcInkei0OAWJxA1P9o7A0A
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab2e44dc9b8so87634466b.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 03:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546324; x=1738151124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4XR+yrGa/wmvA8Csi++peVQzkFW1gDYwqkez/5Wf6I=;
        b=MygEjMavnLXS6dyvGnbX8JxNC8IwzbO+ZWqi6AGrdRPDL8hyA8OAOL6V7KJcpIFwhw
         J5RJlKdzVFJJvL8olmUj7F//gW44lPuGlO1NdyUuPXHeP5wN9SUpbmv+eViG9Ub0YBRP
         /rAk5REJFCwzKXNnNXI2+z7nWB6MJ3U1GPRo4gb4LC5iLLlTNSTiqt9D35KhH+1C5IA3
         FUxEyoeIwEkRuFxOqd7jji63YtvFaSFaMaHPYrlIUOcFmCS4QMcRpN62AYpLh8wNrVI9
         CuSNqlvyJoaCPG+stlumRADUj5uMsP3roCUlsmcdkuwDVc02o1wv0fSkybHxQZvIlURn
         zRqA==
X-Forwarded-Encrypted: i=1; AJvYcCUKIv68d4AlOxDxybBU2CjXa6UVqOJRZEY6y7lIPDzGKKuHWrQaAqfJSZ7iu2GW9c2TDiQ1Tl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00MnOOHnVEmXOfC3yDPaJQKQcrPGM8meqa7LNPsqgEhtUbHYa
	YzzynyvTpvvB5ifuij7tTVW5XMOtiAXx2Dlhg3QWQgO4MUO7oEx7q3WB0BBNk1I11ccNGC0b6ln
	6MROfBxXVw7LvjQvgcv/103d2Wl3YlcRWlBCtJyDfo4COdE5t+15AsQ==
X-Gm-Gg: ASbGncvAeuei6BrWOF3A3uro9chTa7/Azz5Fwfg5S4rc2xur8I7T7e5PhpVPSJhJr8o
	9E8eQKqTnbW5k5+Fi2jmS+QR/tGW/GchIKqO+Ir/oWrfDBy3anj7yVDV2sOBvAqnakfupOBPW8b
	m7ksI/wrNwptnHpN6o1Oi/WpAKS5IUkdTrbmxJX5sgIM8teckZlxMuVO5jjAyT36wBU3LCIUw24
	qsYF1Pg33EYuOVuVJaVzZ7OI3plH1b5/Oybn+tufhE8dEqnlvbnBWrLCaX+HtQCjQ7hjrBNRsy6
	eH3s1/ClZ82QJ1aXf+40ecI0zM57jFP2fGMdDO5Trak+Og==
X-Received: by 2002:a17:907:2d9f:b0:aa6:8764:8738 with SMTP id a640c23a62f3a-ab38cd638a0mr1859175066b.23.1737546323771;
        Wed, 22 Jan 2025 03:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE25rdyBKEXakyNEx/Jvhg85RQPsWguBlmch40XNRDNLVArMaWPkZIDycwIQzjjJLKXI2RpkA==
X-Received: by 2002:a17:907:2d9f:b0:aa6:8764:8738 with SMTP id a640c23a62f3a-ab38cd638a0mr1859171866b.23.1737546323045;
        Wed, 22 Jan 2025 03:45:23 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2caf0sm892625566b.80.2025.01.22.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:45:22 -0800 (PST)
Date: Wed, 22 Jan 2025 12:45:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
Message-ID: <kxipc432xhur74ygdjw3ybcmg7amg6mnt2k4op3d4cb5d3com6@jsv3jzic5nrw>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>

On Tue, Jan 21, 2025 at 03:44:01PM +0100, Michal Luczaj wrote:
>Series deals with two issues:
>- socket reference count imbalance due to an unforgiving transport release
>  (triggered by transport reassignment);
>- unintentional API feature, a failing connect() making the socket
>  impossible to use for any subsequent connect() attempts.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v2:
>- Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
>  collect Reviewed-by (Stefano)
>- Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co

Thanks for sorting out my comments, I've reviewed it all and got it
running, it seems to be going well!

Stefano

>
>---
>Michal Luczaj (6):
>      vsock: Keep the binding until socket destruction
>      vsock: Allow retrying on connect() failure
>      vsock/test: Introduce vsock_bind()
>      vsock/test: Introduce vsock_connect_fd()
>      vsock/test: Add test for UAF due to socket unbinding
>      vsock/test: Add test for connect() retries
>
> net/vmw_vsock/af_vsock.c         |  13 ++++-
> tools/testing/vsock/util.c       |  87 +++++++++++-----------------
> tools/testing/vsock/util.h       |   2 +
> tools/testing/vsock/vsock_test.c | 122 ++++++++++++++++++++++++++++++++++-----
> 4 files changed, 152 insertions(+), 72 deletions(-)
>---
>base-commit: d640627663bfe7d8963c7615316d7d4ef60f3b0b
>change-id: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


