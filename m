Return-Path: <netdev+bounces-171139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54592A4BAC7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428781889581
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792931F0E3A;
	Mon,  3 Mar 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdhlIxQ+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376A1F03C0
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994177; cv=none; b=pmxvk+arnf9WJ2Be70MHzfvqAw8d52nYoLs9NE2BT/yhPMTnBVZrd8n/Tz5oedUYAzy/nen/1dK6Pa9TvKdYkC45rY5EzAEpN5Kk40lHTWK+QvlM9ivCFJ9MAHWFqF8cuPwAOaWDu/nIFPt3ANLygka9eFJp5fSG/YbanD7/7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994177; c=relaxed/simple;
	bh=hO/1w0WIreFcCNOGOIiuvQHBGfGmx0RKyWkuiZ5OENQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/9rldAhKnRgUZKPedmtdETE4op8oXQ808cnwP54/sKHi04gMISqCfYJ/BwRFIxkmxWZuLNFEgfMfPAUVjfreEBaWGa4jZe65xMuj0B96w4rq5LDU8y+wOzJSv0nOB9qamIb1KgN4IW1yyPJ3PxDyEs6u3OIC/Ji040c1IjA4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdhlIxQ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740994174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dm+Ad9vtaxKH6b/jFWjk7lOEkc1nxwN4lmuVSAb6Ah0=;
	b=bdhlIxQ+fjll9LbqpU7NQS6QgIISeDczyHOHsERwPUYy7zo6FFCQpmIX++GEa6bFte5IzC
	990mvIFsNyaD6fhBfuSrP01LH11fp6XVNPFaxP4Rvv8iC0QPKDY3qascTVltloejJodAZq
	e/v2kLme4sp5TiOG/FBR0/J/pJSv50o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-O6JS6H1pMEWogYSTpdpHuw-1; Mon, 03 Mar 2025 04:29:16 -0500
X-MC-Unique: O6JS6H1pMEWogYSTpdpHuw-1
X-Mimecast-MFC-AGG-ID: O6JS6H1pMEWogYSTpdpHuw_1740994155
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22367f4e9b9so53172905ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 01:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994155; x=1741598955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm+Ad9vtaxKH6b/jFWjk7lOEkc1nxwN4lmuVSAb6Ah0=;
        b=wT6P+dUKrRV7UQVcDGV84cWaOwpVSqRCiYx5xNUGO2pplsntBjpWwumTwlmJoUe3f8
         RSR1lrsu3I3E/4GGTpcOHhiZxcTK54AgIRqJw50nReLKk1cpSbS5toScGyI6aH7FASVL
         HsVsctDEFeghATNkRTWtrs37m9xeuEvivQnLA9+zoDJ6Ty5m2e/97gZ6sf3GZ7/T+aok
         jR9c3YRdAdS+49w5OwxmdkQo+ooi4V5B64QeEmG3DhWaxcZx2fQ0MxrW3rg+0vvvRnfL
         yj3VCw+xk5geLL83uE3PfxqIYoIbbH36zmoaJs//qKYFVXFpNLHYvkv9nc1RF2DTu7MD
         1ovQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuZm9OU7eJN4XQjVLbI6/bNBqmMY4SZy+JSqDVeghVzoHgtOrtHKcu8umDm+KBE2jY9zZLh/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTx9lo4AwppIaoHsK2aigqE2FMd7EVBAWpzkf8f+hk+Hp42MW
	0jGRt/YHgI3DMh5ffN7l/tgWv0mQXI/tfiTeb3PaqCAW8GqERtWKzZk9z6I0QQrq0pRTSJoesmR
	RnBScrs8LH4gan2C6wKjX9gaDYUg9kIvgwve6Bo6xYrjYnJ6NCPQ1XWiwqD53EJzr40zsIDX2Qc
	4fcFC0VtXDynFLalFkrLmqA3IyaX7pZKoB0DGe84M=
X-Gm-Gg: ASbGnctoaKrlxXcUAg1RlVK4spl0nB8vNZ5lLqnIJYOmm/A4nAMvKoBh1LLYA72MyDL
	X0zXSoZh2pfd4xN/IzpL+WU+2O4Syc++24S5UiGOIxN7MVHYMaYRnaALhOsif2FzpkrK4T3g=
X-Received: by 2002:a17:902:f547:b0:220:f7bb:842 with SMTP id d9443c01a7336-22369255811mr196196085ad.42.1740994154028;
        Mon, 03 Mar 2025 01:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeh8T/Isef6u47m5QPpp9NHgJMkJl3dnUE8Ylea44Ny6EY1sjUVU9fZMYGnxlnkM9rFe7Jpp6zS4k5VEsVFKw=
X-Received: by 2002:a17:902:f547:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22369255811mr196195835ad.42.1740994153774; Mon, 03 Mar 2025
 01:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303085237.19990-1-sgarzare@redhat.com>
In-Reply-To: <20250303085237.19990-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 3 Mar 2025 10:28:37 +0100
X-Gm-Features: AQ5f1JpYz8RUYj9eXvkfBI5yoVaRYAPygFZFSo69WGk-H92b36v2eBIN9Cg-xmM
Message-ID: <CAJaqyWfNieVxJu0pGCcjRc++wRnRpyHqfkuYpAqnKCLUjbW6Xw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix VHOST_*_OWNER documentation
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
>
> To avoid confusion, let's use the right names in the documentation.
> No change to the API, only the documentation is involved.
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..d4b3e2ae1314 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -28,10 +28,10 @@
>
>  /* Set current process as the (exclusive) owner of this file descriptor.=
  This
>   * must be called before any other vhost command.  Further calls to
> - * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
> + * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
>  #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
>  /* Give up ownership, and reset the device to default values.
> - * Allows subsequent call to VHOST_OWNER_SET to succeed. */
> + * Allows subsequent call to VHOST_SET_OWNER to succeed. */
>  #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
>
>  /* Set up/modify memory layout */
> --
> 2.48.1
>


