Return-Path: <netdev+bounces-115932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D19486D7
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 03:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360C2284852
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761588F77;
	Tue,  6 Aug 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPcLEKr8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529408F62
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906119; cv=none; b=s3/g5HE3X2OLHY+JH0ZqX6sH2dArZaw9SRFSjIbM3rXSvWrI9faTtmnh96hppXVEqffamaeebDFhf1DPh6G/SHNFowxowtLXHBJAZrn6b0Kb34avSv28a1ousvH5DVnW5JWw/f7XV8Pz6zvVV5OGsTDSRdAw1KN3TVI7VnFxE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906119; c=relaxed/simple;
	bh=qTxGSVbgiyiaXipIZz9MBRcX5H1+S15LdEjJoBA63X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lclbrNx/uRuJ++i6ItMTlROiRfIk+UFZnNulB24A2Xa/LDHs1XdL7FFoJRpVRQCqMil605eCo/rYtJb9zGbnx0DKlle52CPK2nDnUkjYuMpTNI/dqum1w7Ry8v3Smk8JjqHosFKf2Z9xI2n0dXXAoOLHuFGLb3wx1en1HD2EfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPcLEKr8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722906116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTxGSVbgiyiaXipIZz9MBRcX5H1+S15LdEjJoBA63X0=;
	b=IPcLEKr8UbFnXEB9VDzhKYOcWSA3Ug9ZxI863P88iyPa4eD1UJe3FCRxS5q1kKusxscZNm
	q4NItGdAsFqO2Z4h5O8j3sGwAiqMCDR6rGBEiiGeJzkO07qOggbP3gZo2k1a5cQGpKB8Ra
	xm1TBW9ZfOaCCoQgk0ZN/J70M5NBlYg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-X4vm6ILfNom7QCrc8-U_ZQ-1; Mon, 05 Aug 2024 21:01:53 -0400
X-MC-Unique: X4vm6ILfNom7QCrc8-U_ZQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a37b858388so8504a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 18:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906112; x=1723510912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTxGSVbgiyiaXipIZz9MBRcX5H1+S15LdEjJoBA63X0=;
        b=GNK8quxanOtDSjP/X7JkVAfC5FZnOVTeoRXFvWadg1Pk+mt4qJdCqqZI3xt7vCmlmJ
         bvyH0zC1oXGPwVsOmxR4TfCjDnzTKeD9BcSrik/4u4EroYr/nokQ/CQ1lWo/IyEQ2gRs
         YyWmv7qW5PG+1rZoZNEvnqL7rq8MR/3JEACVp19SHjBZAHVZZg0Vt6l4h0OzZqsdHxZJ
         7UINSNk//QHEMIvkmIIfZtngMG6GXTL+8Zf/9KZJl6naK6dwcCGWNOgs6Dsl6p5lA9Us
         cOPRJ8K+/iN+hWw+Rm88fdGHksGzJ3zyXkQbpYBQNpZ+wbVOlw8MZcqAIGm52iqr2agf
         pB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV1MYf/KM7aUN+zrEOxFB678s5WY0DV6abBh+ejVEP9jWuAaW7FiOIFDZStB/QJSlEvx25Vkr+gucJX7ZWVvXPJ46t28Fu
X-Gm-Message-State: AOJu0YwfLSFt6Nb80Kpg//CyzRIPMU4nQfbNQ1FYgG9PKiaGdos8pgQU
	UWUiMr9WqW5kkxshcQ1WgiiMX9AsOwRUAfWkYD49y+JN/cPrUMt4OUDuk5MX3HhlaGLo0UuLJes
	N7+PmvetBIdl29nmSEJPtZCc+aSRsACqj9brZK48q+pNgBIIrHAQZSWCnt7luj1xMOB8XUH4Zi5
	1+0JjHJ7jS0OJI7c5ZTqtxpnGbVh2+
X-Received: by 2002:a17:907:968b:b0:a7d:c9c6:a692 with SMTP id a640c23a62f3a-a7dc9c6a8a1mr1079876166b.51.1722906111939;
        Mon, 05 Aug 2024 18:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCS+070//FntlKwTGaK5hUCETtQAofF2eG5Bcd+y4osVs63OeNK9ZqLrHX5n/FYiicIZxurJMhQLS+TMSS+R0=
X-Received: by 2002:a17:907:968b:b0:a7d:c9c6:a692 with SMTP id
 a640c23a62f3a-a7dc9c6a8a1mr1079873566b.51.1722906111375; Mon, 05 Aug 2024
 18:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731071406.1054655-1-lulu@redhat.com> <469ea3da-04d5-45fe-86a4-cf21de07b78e@gmail.com>
In-Reply-To: <469ea3da-04d5-45fe-86a4-cf21de07b78e@gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 6 Aug 2024 09:01:14 +0800
Message-ID: <CACLfguXqdBDXy7C=1JLJkvABHSF+vJwfZf6LTHaC6PZTReaGUg@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa: Add support for setting the MAC address and MTU
 in vDPA tool.
To: David Ahern <dsahern@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 23:32, David Ahern <dsahern@gmail.com> wrote:
>
> On 7/31/24 1:14 AM, Cindy Lu wrote:
> > Add a new function in vDPA tool to support set MAC address and MTU.
> > Currently, the kernel only supports setting the MAC address. MTU support
> > will be added to the kernel later.
> >
> > Update the man page to include usage for setting the MAC address. Usage
> > for setting the MTU will be added after the kernel supports MTU setting.
> >
>
> What's the status of the kernel patch? I do not see
> VDPA_CMD_DEV_ATTR_SET in net-next for 6.11.
>
hi David
The kernel patch has received ACK, but it hasn't been merged yet.

https://lore.kernel.org/netdev/20240731031653.1047692-1-lulu@redhat.com/T/
thanks
cindy


