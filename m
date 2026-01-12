Return-Path: <netdev+bounces-249218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88124D15C8C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA474300EE5C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2B344036;
	Mon, 12 Jan 2026 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnwgFz9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D4342526
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260081; cv=none; b=rm6g6rnTpGyQNkAAV4s7DrgBVEB346TdTFbvqs20w//aBUtcOO0qkrB/5U9shObjsZmmF9rmszriKitbzAuxCFCXGACnFAZmRdtwEdHsZbqJrpAeA9sjYtEuNXX7ND78IU79CwyahRWygsZDPZKJ4YQimNPTB+G/sbCHGEAvE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260081; c=relaxed/simple;
	bh=7L4AuwoQwpFDKJ+QfvB8n+UzDOCrhQdo2yK39qUc8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syN8arqzky0+LRXJv8aYQ+sM+RPcpzVko8KbeF6pNMP2GanXpLP7Kx8hNaRUd9hus4SooxURRaNprkx9rVBxpnMSSQtkeqx/IyPRd3aRt+//bEYWwZa2eO7taDYuAG82pDY4BZsKZ07WCl8FVJ09Rsbv3e/KkvP8naNnIeIBVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnwgFz9v; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso6178148d50.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768260072; x=1768864872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtoLeYJaY/2ODhxZmDU22B5G0cJLjLhdpG7Ly3b1Aek=;
        b=bnwgFz9vs89U9SsRGckgS2XN4MyfrbVDR1dCDH2HClRdZmlUE/XHYWgUfKlFFk7trh
         J6XZTAZzoGBhvbI4xJTxV1ZlAMe+gZD9TUlsc8FDEJ2e3lcvL9OJUz77cb2dS3dm08lk
         u2qddLyeSNf5u8ER8dCX9RfiSxdfKnFtX6LXWI7j8N7Ip7FzH0EzzstIx9pBLXXLaat8
         CwVf2+Tygfn26guy/NAElPnU5Tm1t/yJV0FtgnTQZkSP1AA0vKKOyoiEpcxQL7ci4jjb
         r8vFDHLO21Kg9zpMwL6+pmEgfPFF0R8ICp5V8V0pN0p4BaEx7BisktOLUi7hv8LBlYKq
         HO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260072; x=1768864872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtoLeYJaY/2ODhxZmDU22B5G0cJLjLhdpG7Ly3b1Aek=;
        b=V8yNMEdJc3OFR6yB9Wheo6ye59zff3FkXuzch98myWNtZtxnb7hCFxI4+aHJvTsR26
         TFwEVZcufWSY6Y/oVNny1LOITCFArsrdupR4fqBSALk9jzYtAxEgTnYzxEshjuQeKzXz
         3jXUiyIBlYNWP3rX48V+CwvVqvUVOAKiSJ4BVcaC5/vayH4cpv/7XoUHNABVYBIA90dP
         dzJGnlwBaSdJfI2Fif0atlqzy75jsobUkNwvDDvwE3iEmUPiecIKp2dyDZkTTVV45jO5
         7w6piLFL1ZGqvi3Wtx6YlnjfYLvn7HdjlZEgXJULZAuYRlw6MMUDBSZB6sRYMZc8hdzM
         gP8g==
X-Forwarded-Encrypted: i=1; AJvYcCXq0S0Ugcb6MYXe+gq6qfTMpxI1LktwUFGScRBJQwvgdzmo5AG3xfdRZMxmeQgxRTfB1o5j+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVteDz9yYipBG+ijDb1PC8QZDwC2cc/9v/C7mTRe5slWkAod+
	YZgdDphxPWRnPI9gOb673tT+jcwV3cnR3YDIJR+3hsS5NyXS9ukkBP9x
X-Gm-Gg: AY/fxX5TyitVEZkt+i0d3JyWtcdfbl/1jkLHURoMURwOphfQhIrXwhL3FCCS33it72+
	HtmnM7jWq/ztSc07Zzp+AdSKCUIiiz4qvKnLgzeSRyMYEpySrEIxhkw6jFb0eUxgxXCcx9ss00Z
	X53JmN8RBMkotXoYTMif60Nv6fHLTXkDM3yT8B0qBS2P4GB27ijPbJyHbh4uCv8/ot0fZ6T1ISn
	P1xpVRENCK/aUNkcEt8BLrX3fi73EDtAH4xDebLyfBIfPrv6jFONB8mp/z4vroEU+sj7dgFMCEP
	XJwQ9JjdMOHinYM4EvOYjxumUpCJ1WYdPT2ZoNSNgvrTTFkHTG8ajCyac+Y6smuGt1Tw/PIheVP
	MVvfiCkY92CTXF7mFvEpwaVcco3UDe7bRJTwyLbi7FNkA6W40Hym/XXyhoyYBjL+RYoSxDOVlty
	owyd5IALsuiIS3ciTVWYp5hxYyABTCRAiwhw==
X-Google-Smtp-Source: AGHT+IGPR3yHTofTNuLsmIGRF/vxUZuNpadx2Jh/erk6LsyOgtC+kyjO5yp6nCVt3XNr+Y0sCRmwIQ==
X-Received: by 2002:a05:690e:4085:b0:645:5297:3e65 with SMTP id 956f58d0204a3-64716b35ea6mr16989024d50.11.1768260071815;
        Mon, 12 Jan 2026 15:21:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm74065287b3.53.2026.01.12.15.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:21:11 -0800 (PST)
Date: Mon, 12 Jan 2026 15:21:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <aWWB5bvx677ep317@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
 <20260111014500-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111014500-mutt-send-email-mst@kernel.org>

On Sun, Jan 11, 2026 at 01:46:43AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 04:28:37PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Associate reply packets with the sending socket. When vsock must reply
> > with an RST packet and there exists a sending socket (e.g., for
> > loopback), setting the skb owner to the socket correctly handles
> > reference counting between the skb and sk (i.e., the sk stays alive
> > until the skb is freed).
> > 
> > This allows the net namespace to be used for socket lookups for the
> > duration of the reply skb's lifetime, preventing race conditions between
> > the namespace lifecycle and vsock socket search using the namespace
> > pointer.
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v11:
> > - move before adding to netns support (Stefano)
> 
> can you explain about the revert please?
> I looked at feedback from Stefano and all he said
> aparently was not to break bisect.

The patch that brings support into vsock_loopback depends on this one to
avoid a introducing a race condition, so it should come before that one.

Best,
Bobby

