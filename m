Return-Path: <netdev+bounces-124634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41696A445
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7641C23ACD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BA18BBA7;
	Tue,  3 Sep 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPb9eX8V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0E18BB99
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380956; cv=none; b=oNAZKxqFeZi9oXs5vUB2rP8akHnNMVzXtk6ODW9C3li+IX9OILTSGL+qsQe5npd5euuCtdBnoonf6b8BdXbeK+zqqZwdPq0phDm76rgIff5a/umKtxqvpxbJrAhYd4TtyJwrDtBh3nDR5M+vXPZ30AKx1IPSHMDl+JuUPafpmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380956; c=relaxed/simple;
	bh=zYtlk+5sfQncdxRHQdTsxikt0082PiHmmUZg7TTvIvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Bd20CDfCpNlx08v2/N1MKvUizFvuFq6fG8PhmzvL6LWX7DC7gMdV+sCWhORQBWrWbesNYKsZcrjHx5GYdEJm3ixWEMP4sQrOsheONxrFszxAUQQ/fCP/LD2aDbSHrPZjIk/26LbzHuskFEkLNdtTrLu5fn5WC+dmra7cZLHvY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPb9eX8V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725380954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zrnaqsww4jvYqG6LWOK9qSkVY3XeoG7b3xEfRlLXIuA=;
	b=GPb9eX8V6KrTUWWkgg3GcbJuSzN+gC2Lm1KKFJ4SM1x2bRBVlkEAc4zT0wuwSQmw1aYh7o
	Q/0mDQseefE06bLPYLZ0GZQQEqDvn2l0L2fCjZblkiAiLoWotd41duJIsipd6gozPxwtaL
	dtzE+3j4WGoebGfuRUYy53EuZcZj2fk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Oxy42L8HNia9TzHsm-04XQ-1; Tue, 03 Sep 2024 12:29:13 -0400
X-MC-Unique: Oxy42L8HNia9TzHsm-04XQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7cd7614d826so4894489a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 09:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380952; x=1725985752;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrnaqsww4jvYqG6LWOK9qSkVY3XeoG7b3xEfRlLXIuA=;
        b=dW0jcmqzcxyTyeIt6OO5cBR6ON6ATu+KHjLgFsDe2eXTqw5Y6gvvztC60Fvbn3BAbt
         BhpIeuOeJ9S3zPrsndRDXNEdPcCXszbNanL+a/NI3xsojdP8V+Gny3O9bggT9ybrOfIJ
         uDq9jM8nAgKpCa37SBJwwcTBGbSmThJYTFb+os7WpwnT/dw8OnlvluJukcrr50Z6nb9q
         mvOIDvPh5wHJmjqGemDCRSivW8SVy/UdX6rPZL0jDi6G6nACzntgAJrA3oz7LwZmBfmT
         6OuyfvzuMXFopRPMCdHlBB94RyTQgCwpbjiXfTvksXeAl7Xqv+XS4yEbyE6mfqjxzHTW
         OOPw==
X-Forwarded-Encrypted: i=1; AJvYcCWSHts5oijH54k+3qK6jeZjQ8DlPrVfnKPa/L1K32oOFx2bYmIDcEBToR8+ORPMuckPYy4ySJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1rs1Z49/xu+zUvNFCnGnqoFtQbapiwg+AuEqSOJah2gN0ofKp
	VtRydEX0IOcYHq934mbPgJv+LdAZxy5u2OhKbYj5iPgd1ijX/ExgXmdo9ejIpi9049bgNK+bmYs
	pNYfdRZ+irmpr+BSJsY98w/BweWyMxJrGpF/5+6TwnqSWCocbZrSWcQ==
X-Received: by 2002:a17:902:cecc:b0:205:7b03:ec3f with SMTP id d9443c01a7336-2057b03ee0amr99540605ad.19.1725380951878;
        Tue, 03 Sep 2024 09:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFB7YsrYOLHMUBhndqah1OUkE6FYlc2YhqiVhS0lNKY7Sh/DddLuJw4Mh3nlZdjBuyYPz4vg==
X-Received: by 2002:a17:902:cecc:b0:205:7b03:ec3f with SMTP id d9443c01a7336-2057b03ee0amr99540215ad.19.1725380951200;
        Tue, 03 Sep 2024 09:29:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:179b:467b:fbc5:3354:8591])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9525d6sm550515ad.111.2024.09.03.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:29:10 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com,
	horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Date: Tue,  3 Sep 2024 13:28:50 -0300
Message-ID: <Ztc5QllkqaKZsaoN@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZpUHEszCj16rNoGy@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org> <20240714033803-mutt-send-email-mst@kernel.org> <ZpUHEszCj16rNoGy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 04:25:06AM -0700, Breno Leitao wrote:
> Hello Michael,
> 
> On Sun, Jul 14, 2024 at 03:38:42AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 04:53:25AM -0700, Breno Leitao wrote:
> > > After the commit bdacf3e34945 ("net: Use nested-BH locking for
> > > napi_alloc_cache.") was merged, the following warning began to appear:
> > > 
> > > 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> > > 
> > > 	  __warn+0x12f/0x340
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  report_bug+0x165/0x370
> > > 	  handle_bug+0x3d/0x80
> > > 	  exc_invalid_op+0x1a/0x50
> > > 	  asm_exc_invalid_op+0x1a/0x20
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  __pfx___free_old_xmit+0x10/0x10
> > > 
> > > The issue arises because virtio is assuming it's running in NAPI context
> > > even when it's not, such as in the netpoll case.
> > > 
> > > To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> > > is available. Same for virtnet_poll_cleantx(), which always assumed that
> > > it was in a NAPI context.
> > > 
> > > Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > though I'm not sure I understand the connection with bdacf3e34945.
> 
> The warning above appeared after bdacf3e34945 landed.

Hi Breno,
Thanks for fixing this!

I think the confusion is around the fact that the commit on Fixes 
(df133f3f9625) tag is different from the commit in the commit message
(bdacf3e34945).

Please help me check if the following is correct:
###
Any tree which includes df133f3f9625 ("virtio_net: bulk free tx skbs") 
should also include your patch, since it fixes stuff in there.

The fact that the warning was only made visible in 
bdacf3e34945 ("net: Use nested-BH locking for napi_alloc_cache.")
does not change the fact that it was already present before.

Also, having bdacf3e34945 is not necessary for the backport, since
it only made the bug visible.
###

Are above statements right?

It's important to make it clear since this helps the backporting process.

Thanks!
Leo


