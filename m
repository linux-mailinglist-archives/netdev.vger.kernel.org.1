Return-Path: <netdev+bounces-202332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1BAED610
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F8D16A060
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54C3239E7F;
	Mon, 30 Jun 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+07wnDG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437A238178
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269641; cv=none; b=s0rLrzZ2v6Saw5c6Gvd0LenjS6dKlgBuZas+TPfm3Wuh1lNAOWxdc41KI2ybIJwdjXtdPZg8iRzPWhjHFcPiK87T4/jTJnGOXCyxDcJRnRR6tFZPqzO0SLho7LBQGLnaiWHTuYzI7nGSOcT9680/rYiwM+BJ0h4naNpl4cLombM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269641; c=relaxed/simple;
	bh=3WCJLLv4RhnKEvcl21V/JHUYDcouCFwoRzhLS4CQ9mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etmKKVa7WWL7KdUeHJtEvJjnIAHT7Gw0aWWO0VQT+yNP/wjXkHreftVjBE8F9HYIlpybfZqkXUKQfwxpoNX+ciTqtiJlH/6zkmJoZ8/NgT5bczcIjew4UvBSpMWZkgiP/LPI/nIBtlsDnHBTtDBu6iKV4gmpf2DCtGnabLNxD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+07wnDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751269638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ktNPhfijuEzODMwYTiQC+VuJwh6IE4+mAtetQ6pS/E=;
	b=Z+07wnDGYHQgJxeMEr4EXfJz1TH1ZAArOBZS62ZwOzxrlGlRh5inm5P2ggNcfYjz4E87IX
	Bf2on51Ldpem93qlp2Ag5kayZo++/5+7UUgALffPPusuNZRP3ZporDVEkdHaXl/Z2OZ9gc
	A3Zva7xxlNt0a3uslcadP7s3oKelciY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-eizU6xHlNxy0m5h3GdFn1Q-1; Mon, 30 Jun 2025 03:47:17 -0400
X-MC-Unique: eizU6xHlNxy0m5h3GdFn1Q-1
X-Mimecast-MFC-AGG-ID: eizU6xHlNxy0m5h3GdFn1Q_1751269636
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so1988103f8f.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 00:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269636; x=1751874436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ktNPhfijuEzODMwYTiQC+VuJwh6IE4+mAtetQ6pS/E=;
        b=QmmLaUb5LxoM95kK2xnV6vxFBPZwVkj4rBCfpY8UEaJO0J449l+SBMuB53OaBiL/BR
         hOWi5kukbjQR/i5QYkIfqcCna0AYbdoHkaeEW0PHWTvox3Mgka5Yed+HSC8aF37OjCfy
         hkpBhfyYb6+zNxdSmmixl8NQntHS8XgLJbMjKYfXZdZgiDpElgJhx+XoyR+nYgvtVmgf
         XaGOrAFnSF076DQp81VrEukQgF4CDmJw6fMsG7OIlL1IqoExQ/xZk0bZyv79/E7ENU8g
         JCXDQ8Gk/M1Lw2MW+uE82CUHUgo1+3M1dlpGs4uBzNQx0vfIJiH7RKXGVeA6LwtjtL2Q
         zPhw==
X-Forwarded-Encrypted: i=1; AJvYcCWsK1Qs8BiSjRu5z/9YqdS0UuXPJU+qfuiUsY/9FA2BODFl5A4Stgc0lEJSbANPRMihoqiN7vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQdAY0wc95IA7WY0vdlv2cvhbFUmCOUdUoTG9DpZxzpyPRqke
	J1sRzvvM39uWSX6nkJUmu9obDLMRJNsIWE6TPHgHQ2gmP4nqiL9K7+C06aTT1eujxmjOI7F7JgO
	SdNq+VspQB4R8cDPRmNRHuAeDfp2QizqMKIZ+Uep9Kmm5ECVL6dOsiqemoQ==
X-Gm-Gg: ASbGncvP45atoJKilVuoMMNtxuA4zbBe+V2Gj/O72/w4t6ePQU7vS3gMF1HPumNLwlO
	2Sh32jkCFc7uSBpe2DLtaE8ForOAc42Sk2PxFp5thBS3Rf6M5C0tWEyzVdrTC0zZY4TyIhTu9eN
	wrCz6VzRsvaCVZFAebOzufxEevllNKEi8i+gOhQyX+ljTb7UxewUxEEjk+z2WHNWXLbgY2Oofol
	6rmd+UTeJToGq67BDQdtgWEU6oD0B4jCvqbOUErAKMiAKAq7SiIaK12fJah2mI516zOyELqLs0Y
	E0uiBCakV1kNIp0QXRRNAP84Cc74
X-Received: by 2002:a05:6000:418a:b0:3a4:f70d:aff0 with SMTP id ffacd0b85a97d-3a6f312df2bmr9022666f8f.14.1751269635646;
        Mon, 30 Jun 2025 00:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxPyEI4vtDCAHmMrt9Bgdg2700Ez6oVkN9Z1NlWqAtZ1aXzxk700hjPBCX6uj4jbe2vAmlKg==
X-Received: by 2002:a05:6000:418a:b0:3a4:f70d:aff0 with SMTP id ffacd0b85a97d-3a6f312df2bmr9022638f8f.14.1751269635049;
        Mon, 30 Jun 2025 00:47:15 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453814a6275sm105907065e9.1.2025.06.30.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:47:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:47:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, decui@microsoft.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v4 0/3] vsock: Introduce SIOCINQ ioctl support
Message-ID: <gv5ovr6b4jsesqkrojp7xqd6ihgnxdycmohydbndligdjfrotz@bdauudix7zoq>
References: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>

On Mon, Jun 30, 2025 at 03:38:24PM +0800, Xuewei Niu wrote:
>Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
>bytes.

I think something went wrong with this version of the series, because I 
don't see the patch introducing support for SIOCINQ ioctl in af_vsock.c, 
or did I miss something?

Thanks,
Stefano

>
>Similar with SIOCOUTQ ioctl, the information is transport-dependent.
>
>The first patch adds SIOCINQ ioctl support in AF_VSOCK.
>
>Thanks to @dexuan, the second patch is to fix the issue where hyper-v
>`hvs_stream_has_data()` doesn't return the readable bytes.
>
>The third patch wraps the ioctl into `ioctl_int()`, which implements a
>retry mechanism to prevent immediate failure.
>
>The last one adds two test cases to check the functionality. The changes
>have been tested, and the results are as expected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>
>--
>
>v1->v2:
>https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
>- Use net-next tree.
>- Reuse `rx_bytes` to count unread bytes.
>- Wrap ioctl syscall with an int pointer argument to implement a retry
>  mechanism.
>
>v2->v3:
>https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
>- Update commit messages following the guidelines
>- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
>- Move the tests to the end of array
>- Split the refactoring patch
>- Include <sys/ioctl.h> in the util.c
>
>v3->v4:
>https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
>- Hyper-v `hvs_stream_has_data()` returns the readable bytes
>- Skip testing the null value for `actual` (int pointer)
>- Rename `ioctl_int()` to `vsock_ioctl_int()`
>- Fix a typo and a format issue in comments
>- Remove the `RECEIVED` barrier.
>- The return type of `vsock_ioctl_int()` has been changed to bool
>
>Xuewei Niu (3):
>  hv_sock: Return the readable bytes in hvs_stream_has_data()
>  test/vsock: Add retry mechanism to ioctl wrapper
>  test/vsock: Add ioctl SIOCINQ tests
>
> net/vmw_vsock/hyperv_transport.c | 16 +++++--
> tools/testing/vsock/util.c       | 32 +++++++++----
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> 4 files changed, 117 insertions(+), 12 deletions(-)
>
>-- 
>2.34.1
>


