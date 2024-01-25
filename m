Return-Path: <netdev+bounces-66028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01E83CF93
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 23:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43691F23286
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF7111B6;
	Thu, 25 Jan 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5j5nBC6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD700111AD
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222943; cv=none; b=EeQj8o2RjCOGMPgG+iQAW3W41Z6P6ZiFCh3ic6CjRZZr9f49v3Vjb+c1Z3MLO0ls/PGqAZzOKWwIy2dfY4R9j5Zz+WBaJGG4yFiFwteWVFEO196aRV4w/WU1na4DUsnEE6OgeJdF/sy8CYwtX12cWAfSW1hz6fejo+hZqhWcHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222943; c=relaxed/simple;
	bh=CbmW/228GCi3mqE9tnHZSnzCJD3NGsjyla4RSnkrJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyFC4mcbZgzNWq+PVZlA5DpCEXecvC5vYGwFErxXmDcb+SxC5LDqQPGLUMm3joeqAqlTb5vwfMsIeY23PJQTgYHgf4/5QyTqEvORgiZzM9yLllZ+nDy0U4sIFiz5RiNNXifk07EXI4Ja0L4x7AwGtyw80E+HkUz8RAbs52SuWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5j5nBC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706222940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4Crka9/JgHcU0ey0pI+XUxXs9hF7aNw/5Jtdg8P4KE=;
	b=N5j5nBC6PXcvXuW5fmoXcfVAqqydqTzu0WTZvC7GiKxX2bjjFRtv95BcPeErdgn9Xp42nK
	0+Fey16/S+J+wwrcLklbVZL+Mewsru9eDEH9fh7IpLbxhRSoh7ngLcq8n7SHlK+fGA2hOc
	6S3sQ9AeJPz7NPY+iCpQO2I/pepaGf4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-m9Cd-PVqMwCk3YKC0OEPIw-1; Thu, 25 Jan 2024 17:48:59 -0500
X-MC-Unique: m9Cd-PVqMwCk3YKC0OEPIw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337a9795c5cso5196029f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 14:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222938; x=1706827738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Crka9/JgHcU0ey0pI+XUxXs9hF7aNw/5Jtdg8P4KE=;
        b=LAPQqBGmej/MdgxWQdkkXBgSoiHgE+SZgW6kuaU4b5ZtGIk0areSchisYLX4aZ7+bO
         hUQoOdKRZB7EG7uUYmt7sjzxQJM3lD6Hb7jUD29RS9zjvNPsHV/S34nIt6qJBtHVKXqM
         EUpvNujwKJ56ReME0GwCfU/4iTgsU8uBIfEN8yV08Pq1GI7JhmVzpk32eUMSnVy+lNU8
         pwQojMKPJlu+HW4rheYkqeo/0WC54DVBJnSnc9hxJk5vGPtkJJxkBX4cJ8YX5ZM2jwT7
         PPBLMSP4bMloW/MVGGV8GLw8SEmS0uobkrrjDJrusIhn9Wq9gtE0GIfnz/b3eFAoACXD
         w4dg==
X-Gm-Message-State: AOJu0Yxz58aETZkWfgMCPs5AI2jneYLsumkbM2cyODqABajxQZoa/AVR
	SVtYUz3VylXsLSscKObv3nt7kojbLy/6yH2tUhyknafKBBhGMk9aJ9huUvm1KBOfJEJJ4ON28b6
	UTNg1yDm6OC0p0cpb6AbNHBftrZ7Xbc4hdVVmnAATvXbSCmBj0/wpMA==
X-Received: by 2002:a5d:456f:0:b0:337:bfd4:8c1b with SMTP id a15-20020a5d456f000000b00337bfd48c1bmr209626wrc.23.1706222938147;
        Thu, 25 Jan 2024 14:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYwVPAR3CAgbGUu1SF1zj6JUO3aXtfnw/UqEkEi86zKYeiQ92JA4m9kDpOpg8QaBLVc0gbMg==
X-Received: by 2002:a5d:456f:0:b0:337:bfd4:8c1b with SMTP id a15-20020a5d456f000000b00337bfd48c1bmr209611wrc.23.1706222937744;
        Thu, 25 Jan 2024 14:48:57 -0800 (PST)
Received: from redhat.com ([2.52.130.36])
        by smtp.gmail.com with ESMTPSA id x1-20020adff641000000b0033922db3f74sm15876156wrp.116.2024.01.25.14.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:48:56 -0800 (PST)
Date: Thu, 25 Jan 2024 17:48:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1] vsock/test: print type for SOCK_SEQPACKET
Message-ID: <20240125174845-mutt-send-email-mst@kernel.org>
References: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124193255.3417803-1-avkrasnov@salutedevices.com>

On Wed, Jan 24, 2024 at 10:32:55PM +0300, Arseniy Krasnov wrote:
> SOCK_SEQPACKET is supported for virtio transport, so do not interpret
> such type of socket as unknown.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/vsock/vsock_diag_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
> index 5e6049226b77..17aeba7cbd14 100644
> --- a/tools/testing/vsock/vsock_diag_test.c
> +++ b/tools/testing/vsock/vsock_diag_test.c
> @@ -39,6 +39,8 @@ static const char *sock_type_str(int type)
>  		return "DGRAM";
>  	case SOCK_STREAM:
>  		return "STREAM";
> +	case SOCK_SEQPACKET:
> +		return "SEQPACKET";
>  	default:
>  		return "INVALID TYPE";
>  	}
> -- 
> 2.25.1


