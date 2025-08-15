Return-Path: <netdev+bounces-213969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C1B27896
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 07:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34116A0138C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4326A1D0;
	Fri, 15 Aug 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgVYaE/W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A972253E1
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236319; cv=none; b=tcgD/mTkg81sN7tekdDbVk6L8oQM/6mxhwrFm+8w1WzPKtYUM+FeUoa8z8Ik9fE1lmWCTEpavSV2rFHA7uEpNgPTkxjq7KG5Mw3/B1pJoems2Ur7U6PdTem5x5M44rpE26TJ/SKc/dDemucoxYaH2djFNLNufYkeIl3wpdbIFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236319; c=relaxed/simple;
	bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DC7Q8uHAiJzABn45OJrFkEMraKuiDMyTB+R2HrHtVEa5i5za6l7RqJq4tchopNpNHcbOwJNzTkqQHJmT5uOMURjacZ5gPo95BGI62E4WOvTwPBmmdK7kBbni+NUJkrSw6P4B4vqcwzHW435TJEclTxDJjUlaD2e6eNXefv2ci9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgVYaE/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755236316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
	b=XgVYaE/Wu4SrOZLjy55Y8/kA3eJslhXSD4DpONp1z4ji4NwGwnExG81DOEAWho7K36IysO
	A+CVjvD9jOb8y95dNvUc0UHBWI/E4HVzW3XKmW7pRvrwnO8nDpMlB2DaM34WjaDTvafztr
	CPNWnn5qWM9rq2Z4tstOsFpKKLjhnQs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-In8CNv8eNs6i_5As43N6UQ-1; Fri, 15 Aug 2025 01:38:35 -0400
X-MC-Unique: In8CNv8eNs6i_5As43N6UQ-1
X-Mimecast-MFC-AGG-ID: In8CNv8eNs6i_5As43N6UQ_1755236314
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47174b1ae5so1205973a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 22:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755236314; x=1755841114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
        b=gV3pUciaqPe+gRu/I1W7Gc23sqTIuN7rPLpzF5cm0p73WeMajPiuYCWRD1gNoUHbF9
         bjWQit1ZMXV4UOZCJ2Z0fhC4gAt17OjPPYj6kqSqnJOHdnTKHlOUzi2Espx2p9O3eS5K
         8B5KKSNkSD07PWzpfV7nc8lB2YclT5ZF5221qjEMCaosX30TsYje+tEgCQF/8tw6Tabc
         NYAFhqGqO+qo/nqRkAOZ5BuS/N9se5vRL1RefXTD8/rYsOrkkcMj29RSW3kkY+sl2if0
         mKkhpn7t+QYaP4PVYXXgPEsEmLmeknDqFDKwWrdrPuK+FC4IL8bCa7Sx1OmURZVu51gk
         GMkA==
X-Forwarded-Encrypted: i=1; AJvYcCWLn06/mvnc7LpWjmKFUzDS8wxEO0damCprjfnK1yzdieriWqWaqCANj/X3naPPkvZTnXGO7P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tUz1pJWqpfHYEKw06+AwvswOnjqCyZZfUiG9KJsEK75lEr0J
	ZKm7hFiU8CXxl1JR9ese69/VVXBbKohhlUYXsJ/ST//WW95XjTHCLqI7PpNDy+86tWug/GQY07l
	S5vZMogqOJrC9vjXze49dYKPeS9sm3IYpY44sbjqIfboU1+cxY+nbfMNeOjUcADMlT4SFTR6GkM
	4TZ//2dpyCR9An5GErxYimc/j7eMHKX4tF
X-Gm-Gg: ASbGnctByPu+Tr3jWPS/3QT5jrS2i7nr/Xk5hiqRyb4JKlvg/7GnfrL8ODmQSwdynfU
	ZHiSv9vMPMxIjXxCVrrg/kCDGeguX7YCUA5coOJaj7dylslYlAXfyKi7I4Z/0ZXRzCdmvs2q3E5
	JztlvVY70N4lpPB6B2XxtBsA==
X-Received: by 2002:a17:902:ce84:b0:240:5549:708e with SMTP id d9443c01a7336-2446d8ef2dcmr14828065ad.46.1755236313904;
        Thu, 14 Aug 2025 22:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNF8ixWW+K/UQ+wsBh6Kk+3CTYVr9Miz4ZwB26y/XjbpOCpnb8qBRzSIZa7K8FyWNx9BMFUAKlBAn4MxP1R4w=
X-Received: by 2002:a17:902:ce84:b0:240:5549:708e with SMTP id
 d9443c01a7336-2446d8ef2dcmr14827585ad.46.1755236313492; Thu, 14 Aug 2025
 22:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e@epcas5p3.samsung.com>
 <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com> <20250815022308.2783786-1-junnan01.wu@samsung.com>
In-Reply-To: <20250815022308.2783786-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 13:38:21 +0800
X-Gm-Features: Ac12FXx0bLK4_QgLg7PMFy71tElM2n26_1WoRrHpv6PfQj0ttolriEFKlqdwaoQ
Message-ID: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:24=E2=80=AFAM Junnan Wu <junnan01.wu@samsung.com=
> wrote:
>
> Sorry, I basically mean that the tx napi which caused by userspace will n=
ot be scheduled during suspend,
> others can not be guaranteed, such as unfinished packets already in tx vq=
 etc.
>
> But after this patch, once `virtnet_close` completes,
> both tx and rq napi will be disabled which guarantee their napi will not =
be scheduled in future.
> And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `ne=
tif_device_detach`.

Ok, so the commit mentioned by fix tag is incorrect.

Thanks

>
> Thanks.
>


