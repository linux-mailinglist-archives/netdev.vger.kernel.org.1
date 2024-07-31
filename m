Return-Path: <netdev+bounces-114381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB7942505
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 05:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7822E282738
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C129CF4;
	Wed, 31 Jul 2024 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUKq3CBn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370117C60
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396094; cv=none; b=doxP7JXUg+izSv+LePx8JV1fQaiJXvxBZM4nI7fGsuZyRC/UUk6G8ahdAaysInwrhqpMYoXWnhCnU+kA6Ozl2EOJhvrYMkxy7MADnyFgWydxdbRD99BtgyL5GjGVF7FaRJRgMH8Uz6aBmMC//7dOqPraGbWwAlNNU2BZlLBOJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396094; c=relaxed/simple;
	bh=8+9z5mMlcdAWMW3cReFctIogTSgAXib8SXPR/OCNbSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn6ub5jXUy0DQc0+jgO2VPZgCVgCuH6RTwDqbynShT+vDTh/wPW6DT7IZXAr3NCC+FCOV6cT8l2FoDscjxYsrSbXAbpaz4WpSWhd4O7/FIbhWiNyL+WhnJnjJlYb9V8LF/uhpxehnsAK6zc4hVLJ0aiuXCeb3r+q+NNi+Y7gRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUKq3CBn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+9z5mMlcdAWMW3cReFctIogTSgAXib8SXPR/OCNbSU=;
	b=DUKq3CBnyDd2OTq6jxGz+DTy4/QZv2N7yADUcNbEMM39qcMV3q04FZT692rkL0Qxc1z7tL
	JxYc8SppCOg8JRMRnzn/RRDaKVNOk7K7i13rpNdzFQzEMNz4itwpq/33nvoBDYc1dC/Cnb
	nbhVbpoxlUzsoyTdvRgzKjoKUBjW4K8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-gjGW1nnGPruy7d5iuphAdQ-1; Tue, 30 Jul 2024 23:21:30 -0400
X-MC-Unique: gjGW1nnGPruy7d5iuphAdQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7163489149fso5306027a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396089; x=1723000889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+9z5mMlcdAWMW3cReFctIogTSgAXib8SXPR/OCNbSU=;
        b=lskJApY22Iv4dOMqj4YiOMyZSxOTqzT/WDK9aJAV4Qbb8Xm4gU6O1FU2/r3LURyQhG
         C9obHt+bEnxt81ukaFRJDDhYKzGTrd3Yn0tPKjiVzICxn3znrL87MnsSL0NglI+KLIQ5
         CVOn9cIsAXg/FpKAIHVh/yAzrji5Jo9+TejHmuNAJlHpXX4K3OUUsdhFz2uIDxPmtYu0
         3jI/Ay9/yqd9shAoXip8AuU7vtTVxZvsOA2U/uzdc0fzBLBU99qBlWs0JOr0RB6iAzFH
         VE5M4foK46g6RAjUVBcKvVenPuBqRAFoLxeBzijkfXXPyBTmBdAifCLHLQQmLxenGDQb
         hvSA==
X-Forwarded-Encrypted: i=1; AJvYcCV4KqByQuClWJWZOjm5E8kbSxrodCm9XhDbH4aBXI/t4EuFeni5Uo9R8KRYYEUHqzQvLz0VQy1PciEdgC14z+LodGMn5iis
X-Gm-Message-State: AOJu0YwVY4JI2w7FioBSmM5EdcTfo6biWPwoD+MVWGM693PApBCSknEd
	wBeVUHCaxnxZ/7aYxMkBWPAolvqx01Dw+5ueCgC0+/fQVNhkgoHaFI6ivJIWVbToQdAXHjNelLi
	xxoVWavYehviam0N+i0vMVUXsl8VHS7yJb1vZZSb2hFQvGSC4FqOAlXFc0+z86b/YXG2CuT9+nh
	k/3FTfGvB/WPiKpkk74TTt4A4UOH7y
X-Received: by 2002:a05:6a20:431e:b0:1c4:8650:d6da with SMTP id adf61e73a8af0-1c4a1184098mr18137298637.1.1722396088966;
        Tue, 30 Jul 2024 20:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHyW4udyXgOynWPU6sFEx+eYkhyApxZ3M3JsIfoMTHydwIbe/BHy5bvZP7PulcbNJ8nlYxgYYxKYiSilfMjmE=
X-Received: by 2002:a05:6a20:431e:b0:1c4:8650:d6da with SMTP id
 adf61e73a8af0-1c4a1184098mr18137275637.1.1722396088530; Tue, 30 Jul 2024
 20:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-4-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:21:17 +0800
Message-ID: <CACGkMEs9T17z2oBk2dYZnqt+FX_wr=hWUAbXaG__s5qo3XQtVQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


