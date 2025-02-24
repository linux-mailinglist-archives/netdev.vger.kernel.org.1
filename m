Return-Path: <netdev+bounces-168870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D463FA412AF
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB59718947A4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512121624CD;
	Mon, 24 Feb 2025 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCMhpl96"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A61509BD
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361003; cv=none; b=aA2RtgsxQoNPu8WCeSK+f01I15sewa8WjL/o6rlWzaGZt73AFbTuYMiYajFwGf0PPaLE8/ofzmfApgvO6CfT1vg9m8gExsBIIHmxBmNtFhs35x5ARcodIleuIGty9ik7sO9d+cHrwHVACf4Khia/onFbLifq/QEz4LjnOe4T7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361003; c=relaxed/simple;
	bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd2MZoAc62kYsA9qp+zA/M9S2i3i7sdSccAeL52a64wnN8XHiuBsargt53IS8/nO7R91VrnzUOQ5Qwwz5DzlMOd0CRl6rLSiU9VKcBdm7N6Nj0/K5SyVbHqy3NPOM/4yHn06HNvkv16tbUCn+eLoA9YDfSiY+Mo73srVjRBGtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCMhpl96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740360997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
	b=eCMhpl96XYYmBqFtOOMWx/TVZJ/XkFtPUbEXK+sehs7VKFdD91C4ktxJNOHcRAun2DzgYX
	FBLMAV4zOizHUTRiGdpCK3UnuzNzUKXuGOBH1hyO0G8iwhhl5Ro5AyZTg+V61vXT/vdXG6
	6ANUN9CQPkIaxcH72ZeoBuNdsKyIF+E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-L3nUEQMhN_W2uikYzYT7HQ-1; Sun, 23 Feb 2025 20:36:35 -0500
X-MC-Unique: L3nUEQMhN_W2uikYzYT7HQ-1
X-Mimecast-MFC-AGG-ID: L3nUEQMhN_W2uikYzYT7HQ_1740360994
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fbfa786aa4so7864940a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 17:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360993; x=1740965793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
        b=MRLxx3aQhZsPYQJjQJ1HlhWcrzDysU4ldLh5mxQu6J8EZi80rkWZqoQoZMYEwWzM8z
         GcF4qNvuPgjHzZAi26RyMG8HHRPSRWMZmIp03y6Je54Ps1jh32YQbWCqcFfprD77u/2a
         L+rZBF/kOSkYWGuei7y+UARmDpY4cRf10TCq8E2PSImKUoKXy8LUQTYQujVpGr4xSGLo
         uAScqWDyZgfX5HMca6irgDkSxU4Q6UK9sr2rcqWrkD+nwdiv3+0Ohp0XFQJn+ZbrB/mE
         52IFeQhM1DyRmDh5DmcImQ5MjXyY2KfKwdtleWnQdmc9h7qU8lvEEWiL+cz6CzS2K2Wm
         3LJg==
X-Forwarded-Encrypted: i=1; AJvYcCWXrUoDTVgDLnM4g0syrb/n7PASrfZmwTm4qnxjROHhR0Z8/FqJSKQ+8ZMB2ZpeqxStU0Ge0gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTQYYJGUvFN8SGNYtfxn1PFyKMg5u996vkucrVF3aZrWzm7If
	5DrgLMC4wiyo+RZ4+H3dfrXDI46JdBK/whjVpD0XQxi2qgqs7KES0TSjbWft/MNKtqUyQHVZfvg
	R18x2pH7lwT0k4Ke0WzzVToH1XJc3YVSTwtwTIvEKjj1KTMDCbaDPA39C1hoP23aPZ1JNTfUyKF
	NpMC89aVxXOIM4g/fRI/cCZBmgE/oy
X-Gm-Gg: ASbGncvlzwQ422M7Q65GYYRznEtChmW07Gpo9HIKkzJOtp4zNYBylJQrOEvesBi2mZ1
	mu7oaG3cFpaOAqN3Ezxoru/wQSpp1r95vHoZ2cYxZrsa/NmGTJHBbIoP7OlLMlZBS5B53THezWg
	==
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2fccc97a25bmr26776708a91.11.1740360993720;
        Sun, 23 Feb 2025 17:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdpEZuC2ughhZHzH398Wnf911hWUS3XNFhm3aiYtLUwM/DJUati7wFDAoaJ6jggj1FoQ8gleBOESVt4o4W74c=
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2fccc97a25bmr26776675a91.11.1740360993337; Sun, 23 Feb 2025
 17:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-2-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:36:22 +0800
X-Gm-Features: AWEUYZkkWiq9RM5OoXawlOjb8hi-Xzqh0EdRsTvUVm2UbTIaH-IMbmewVYe9VzM
Message-ID: <CACGkMEtRQguy5dg9X_8AYj=88DC_yn+HXPx0Lu_=e1JK02PhtA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:40=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles,it confuses some legac=
y
> userspace app, Therefore, we are reintroducing kthread API support.
>
> Introduce a new parameter to enable users to choose between
> kthread and task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


