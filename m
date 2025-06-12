Return-Path: <netdev+bounces-196818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A243BAD67CF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91853AD46E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47D213E98;
	Thu, 12 Jun 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu+7U/l/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09501F1538
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708820; cv=none; b=TquWShN7eziDLBUdQvhPxgV8VqlvUaEEPAGXW84UsEwXBXy+nJisiSlgiTePXyLG15tHu1R2CWCVlSWwhP4Uj31Cl+gYujqi02K7AMpqDaeYn+MWTsh7hLl3L/mD064Rl6vNJCDSSGWGCXwSN0Xo7QtEOm6WJne/10O1bBNeVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708820; c=relaxed/simple;
	bh=howSff6VWPDUG/8EwAo2gdsK+umwDc6lyF7pREy9114=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZQePVWPPCr2DKZ3IPCqWjhZzMcCaENt7Bs2c24p2tsp/JeNnn8hXML5xHmw8FW0jCkb2I8zvE7UMMpuip1DWdW6bbDf2J3xm0EkJCuuRv3V4QW4U6UqZ8UFjZRf/lBn7FPA+NvOVdFGVSdrj9CVHaPSXH8N/ClqXLkdPlickG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zu+7U/l/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749708815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/EyBBdquzcHxre0zmx4LK4Tl/qvbbDBPGbd2Tyb9e0=;
	b=Zu+7U/l/olKLEYMa9Zm2Acxq0YJG9hBvUQ9mi1Ia0nkTY5bbwH/d9rGIomG0CTxbwFWBK+
	F9w6T9KY1+usrfp/20ufavME0BctKZCoNFt0g9chYVribqBj2010JXDdCr4Fny6mwgTTIq
	St4lha5WMgVnmlFZNa8tB5XLkrS4G94=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-EzvwkceYMRufMBHy69E9Og-1; Thu, 12 Jun 2025 02:13:34 -0400
X-MC-Unique: EzvwkceYMRufMBHy69E9Og-1
X-Mimecast-MFC-AGG-ID: EzvwkceYMRufMBHy69E9Og_1749708813
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so603252a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 23:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708813; x=1750313613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/EyBBdquzcHxre0zmx4LK4Tl/qvbbDBPGbd2Tyb9e0=;
        b=czQIIUsMVw/GFvhoo3BHVmH0kW3L4bQEX5i/IV3s6uIOmzFQ1dAVhIXAPt2KfviO5H
         y4GQ9kz9sRH4otdUx+E472cfjgtfV+EIpfAY/KYGrVgDkk9jmzjGPpQfm3kX9Hc3iQEc
         /Vcr+EkD8TTrYT+kj/uN8fwc0Vnp9Wk3Qee6XZp/BH6vqLFlfQUGPd9xEGYN0tJW4Rya
         olVieGNFQiJAPxX1DZrve0XFr9Sz1ZiVNWg3GqNo7iewUXSZlEk4ksPoFWDgLxZo4JDS
         AsozAAbN6LKc22v5NSV4Z1E80uJa8lGddU2KKSvXqWMFqQvPKc0TwuAq3CgtsnmM1F3c
         WdZA==
X-Forwarded-Encrypted: i=1; AJvYcCV/jSTlIVAnjiWrtu2o4Up7mEHmlV9vECLB4eHmevm+vi7o2qUcxdPi+nkaBS6U6EVbBmZ07CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyofL1IEcoJKdoeGY8Y3nn9R4rYGF50upzHzjzlUeZNpHLwPaa4
	6Zo793eQNJM3fxFo3QlrY4YXIc0kJRo1jc0bmLZPCUMGSa2BTtE4psgkAmwhAP8xi+pueLsX9rE
	61g/uCmANRlSah54Xy0hxUtMqd/ysI6B20GRU04s0MhZkwKVn6EJowyORtIdEyMDKLvlKjLBrpc
	d0D46sPK8y7yy10BWgeIAZ/CY65wdXeBZw
X-Gm-Gg: ASbGncuQIFqWO/sVhRm1bl4vOIo6cOLS9DMcUrIZfdQ0jbZZSnHbriS2MeIW4LHVWru
	AAoM20WTydTHmLEZkuBzxZHPbfZk2IcYYJC4bP6LupxcTCtBH/KldDIT9X6fA7algniKKHbqgLe
	B6Hl7/
X-Received: by 2002:a17:90b:4a85:b0:311:f30b:c18 with SMTP id 98e67ed59e1d1-313af0f8588mr8593830a91.4.1749708813290;
        Wed, 11 Jun 2025 23:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRSfn+DFX99Kt8GYBgrMAVtWhiGSmX+yj9Fd1EztN/3C7R1B2uqWnhW/ZwV2Dfc16GV/gaDsxvGQ2v4NwVoR4=
X-Received: by 2002:a17:90b:4a85:b0:311:f30b:c18 with SMTP id
 98e67ed59e1d1-313af0f8588mr8593813a91.4.1749708812881; Wed, 11 Jun 2025
 23:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-4-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 14:13:19 +0800
X-Gm-Features: AX0GCFtAQ6KdmUMQlRn5ycdH_MpDkwuSBIM378dLZRqlkkpE6VbNRTu4Uei-gEI
Message-ID: <CACGkMEtB_8PRt1Ag0mXV7ycTv1KG_c2PT283hnYukRJrG6h2YQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] vhost: Add configuration controls for vhost
 worker's mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch introduces functionality to control the vhost worker mode:
>
> - Add two new IOCTLs:
>   * VHOST_SET_FORK_FROM_OWNER: Allows userspace to select between
>     task mode (fork_owner=3D1) and kthread mode (fork_owner=3D0)
>   * VHOST_GET_FORK_FROM_OWNER: Retrieves the current thread mode
>     setting
>
> - Expose module parameter 'fork_from_owner_default' to allow system
>   administrators to configure the default mode for vhost workers
>
> - Add KConfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL to
>   control the availability of these IOCTLs and parameter, allowing
>   distributions to disable them if not needed
>
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


