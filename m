Return-Path: <netdev+bounces-225752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC7B97F33
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C4E2A3E6E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D81E5201;
	Wed, 24 Sep 2025 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMdhE9w5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822501C6FF4
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675267; cv=none; b=DaT/0iIK6bf+h4h8uHpE7iAVxm0JaUEUcXN7PeiI9/NiwliexzuvMKfrueFCtzUD/V9Fmar4u/ixxh7uETIh9v+PlBq2c9mYihBxu3w3A0Aw9aRfVnM7Yczkqq5I6wA8PhgI7U0D/WIwbuInHsIYYRCUkpDa+TLlTPt2SIPsrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675267; c=relaxed/simple;
	bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzwyfQdD1gExvxKEw3AX0Iae/3jgHKDa7T+ZnR08nKxV3cBwKJKqjCzTF7Sz74a6fO8MSBFPtIhobulXliRmw/Bt+NXFWiEk3NvDTID7p6ejAEVLg8dVLsRl+Se3FD8tEqtZtvit7uBG7mG6CyTHj7OLSwqmp8ocN2HdZv/EjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMdhE9w5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
	b=XMdhE9w5Efjgyd1eea580BE7gvBLpgXkeEqI1bi4w7dFVDRmKNqMztlt0Ijtb98oymTpkX
	OtbaUh1Xpc02ErSA+Q0p59UYJ0GffJY0MslaW1jHRbs5HjRJZGBNUU6qIOTVTTVJhbR5Vi
	1PbtNqU8pffes56fTLnA4aa4b7w/J80=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-22Jn5vKkPECB2PzP89cXyg-1; Tue, 23 Sep 2025 20:54:22 -0400
X-MC-Unique: 22Jn5vKkPECB2PzP89cXyg-1
X-Mimecast-MFC-AGG-ID: 22Jn5vKkPECB2PzP89cXyg_1758675261
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eaeba9abaso8538487a91.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675261; x=1759280061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4t0XEY19ig96vtXWrbtL/pFwHwKfnwuWWleF5TfQQQ=;
        b=xJ2GLr6fuO+rEu35Ts2uSgEP9Hrc5QKMiRZogewECVfJCSfboeo6tczn8X8Vdu6EpE
         vcGGjMm/qwoFgowSRqWm4iOgraK1OlFFIr+lnidiLVDPNYigzdNZxlGu6D+nlenXOQhv
         y1nWs6e0/smquHFYMJnzqWVKKgRTRIosqg6LsJQTiScZowa0WQ+ZVRy+aJHB9ptFPnTF
         /K/M1fBRvWlHH3l0qPSu6cfaNlfhN87xRts0cmgFAsI7UT7m4A9He2bWOwvEyuueSMKY
         04PyVqukv9yzBil01M3mWlp0w/tYHBQ8BYvUFgsJYH3FpPVUa06HPruW0jgODgmWYQvK
         qkHA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfoGF8yppFaR0Y0YzAlpQhr/WcKdOOR8q5ucg9nscvL/U2dTwzk6cdai/JFbs3rBqvPP53to=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuTT20b0L3ztPvTZjrgcBRQLqbNMzdjGDq0xJNDu5l/EZzg2ce
	m/J4u8EgE/eSJLxMatV5mRtuSR8sY2TC00o8Y1O05p5+unXm5V9V1+7yLUNhHkHZm+HQ9723VmZ
	g0uwLwwR5/B7QfBXT2Ic6wMoUVg6PpQ4URSSjb1x6mehiOUtrAdEEkGngWg+qEu5uyFW29GejIb
	p3sH2yrPryZwPrlor6sx+QipsWUakAUpxl
X-Gm-Gg: ASbGnct3TLYbjZ93Fxo9AVWwr1t8+eIdhupB0QreqjthSeCpvRtWkRK6HSqR5CxtqAF
	4EhW31/VgXOE7nsrJbuYtx02nGJ5cEjMy/PjXtZhRLxHv3HmCjL9dUWT8yAFhacxgrUKtpu3zx1
	t+4ger4bhhNIg5NWJmKA==
X-Received: by 2002:a17:90b:1343:b0:32d:f352:f75c with SMTP id 98e67ed59e1d1-332a9535640mr5034841a91.13.1758675261415;
        Tue, 23 Sep 2025 17:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEfQasazQYrAqwbi0RG98kEq9UrRRqH3IBMDr3ithyqZtr8231pYip07BOxHuYxpr8+ga/tswXckGmozrzyuk=
X-Received: by 2002:a17:90b:1343:b0:32d:f352:f75c with SMTP id
 98e67ed59e1d1-332a9535640mr5034815a91.13.1758675260992; Tue, 23 Sep 2025
 17:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
In-Reply-To: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:54:09 +0800
X-Gm-Features: AS18NWDvb7ormS481il9vCXSYhrezOtK7Oc0syIfP-2dUJUzReMkhidld3UC0C0
Message-ID: <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Fix copy_to_iter return value check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, zhang jiao <zhangjiao2@cmss.chinamobile.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> The return value of copy_to_iter can't be negative, check whether the
> copied length is equal to the requested length instead of checking for
> negative values.
>
> Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.c=
hinamobile.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


