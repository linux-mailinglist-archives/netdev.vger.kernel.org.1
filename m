Return-Path: <netdev+bounces-183238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3AA8B701
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC734456D8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C297235345;
	Wed, 16 Apr 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jt9td+Y+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265EE233718
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800119; cv=none; b=KuLi3H7NpCd0kMVxo/hj/Ye56+i6Brsgl1Bgc8CzvEmsb/4ryUiULEY4gBvwXaM9C8yWEs5mSMgotYgEbvRJevUKZyBvL29XyO/P1ULhemFN96ngcZqKkjpBA4MOTKAi1TWOexahLIf/37bY9iZ3H5Wa1g96atENewSkiOVDBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800119; c=relaxed/simple;
	bh=h68xXKINGGyp2Zd1XCK0EQjYEAkncB1gRD1F116+4l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Br157NJ163Yl+gppv+jyeVOg8HzVRxl/UZf9BER9qRckkd1bdbABuBrwvujbGkj44ogTV5iLgMCRKNzab5Q3hGo+neM9BV7gMoRIiO9eFaoZN2IB6/IZkGCNOlxi34WkMIKZe48AUwu+zH/jv3R9K5jYvN6bXhye94N70IAK31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jt9td+Y+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so36566055e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744800116; x=1745404916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6A0OYhXVyrvwG53WhJNazsiQLTbwvjRH95oKmIwbVlI=;
        b=jt9td+Y+apu6TXIz01nW6c96+L5WUIovnfFfBwtgml8TdpjVyfVQS4uOHDXUFKvvC6
         iDKzj1NiX1+ij31K4llByHishKFt3azDHSUYscVRthZD5wrVziPyZXdxcHDl0+8rBCw2
         Md7jVRvyVXgw95U1Jc8inUwYwR/h+GVQvwSXy+x4ZU8gTsSMo8O9H/vRqlRzXiwPCicz
         eWInKGNTTsi3pjUU0xiT7ae82eRbbqGMgcGsCf4uVHn7rEZJ7vwfcVU6QSSOnBfa1W27
         aHsXyg4W0XQqcsKQHfsfhKiv9UCsklOUidjzlXXRZOz9H3EN3x8sME7TNLA/QmnZlyRX
         HHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800116; x=1745404916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A0OYhXVyrvwG53WhJNazsiQLTbwvjRH95oKmIwbVlI=;
        b=DDEPCDNWJ7oJifhg//Xln4vypIktkLHAcniwZf0PUQLiU/q7twxPRsVdhGhoNs1nCR
         NLcnsCqn+Taoa6HlqY7JB9OzjLQ2t6z5eubn4V9XtnYzXfy3omNzBzLKLbz9LylgM72M
         iEk+maRMttIEMGQsaMl0WJqcrePwwHR0DGjSVFicnn1BW/Oq1IeUCHvwkLReM0Q+SYrC
         JRfLBX1/BZGodk8EBuq4Ntn5vhZFvawzHHTTjwp01x8fZbPyEGvOLfTvBR4+SdJV6a0/
         BwcyFc7O530ArS+VuwMv0uBlA+5Zlx4GYNp4RcmmX693M+lQkfhwjhP2MiGCtkTQCyPE
         sHtA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIhCm8gi4jxvSr5OzcAvo2eb4O38+NRzNq3Qa3U/GuoGn+BfaQSMjuJDbPIAkkVhX6T79b8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBvmxqc8r5hIsdcLBSd/SIr+IusCfLxhC5Hz4P09nAts9o0dV
	kBvHV7lHRgPkDoyIEKJYAM80+TQ5dBRF0Cbgnqz3ZhC9/ydID4B90rXEeC+yshEwIN08nJmOZ+z
	CUysiILRkzAxq8w==
X-Google-Smtp-Source: AGHT+IHbOUuiD9l/lD/r2xNmdxsnmZyj3rRN9YGE8HEdjxjnJL08f4wrTj4agiOUIECbnHkcWVNjdQwPnigBcfM=
X-Received: from wmql6.prod.google.com ([2002:a05:600c:4f06:b0:440:5d62:5112])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0f:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-4405d6372e0mr14227725e9.17.1744800116579;
 Wed, 16 Apr 2025 03:41:56 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:41:54 +0000
In-Reply-To: <20250415071017.3261009-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250415071017.3261009-1-dualli@chromium.org>
Message-ID: <Z_-Jcv-GN68zILvH@google.com>
Subject: Re: [PATCH v17 0/3] binder: report txn errors via generic netlink
From: Alice Ryhl <aliceryhl@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"

On Tue, Apr 15, 2025 at 12:10:14AM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> It's a known issue that neither the frozen processes nor the system
> administration process of the OS can correctly deal with failed binder
> transactions. The reason is that there's no reliable way for the user
> space administration process to fetch the binder errors from the kernel
> binder driver.
> 
> Android is such an OS suffering from this issue. Since cgroup freezer
> was used to freeze user applications to save battery, innocent frozen
> apps have to be killed when they receive sync binder transactions or
> when their async binder buffer is running out.
> 
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactiions.

I'm a bit confused about this series. Why is [PATCH] binder: add
setup_report permission a reply to [PATCH v17 1/3] lsm, selinux: Add
setup_report permission to binder? Which patches are supposed to be
included and in which order?

Alice

