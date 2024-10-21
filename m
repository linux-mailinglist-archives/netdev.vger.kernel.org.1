Return-Path: <netdev+bounces-137614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025169A7279
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80861B22DE3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A81FAC29;
	Mon, 21 Oct 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwimAlmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9571FA24B
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535775; cv=none; b=MVGUPDbEOdFAXch5Cx+sZIux24By1kpgi0VCYN9TgYeiQVUbQfAHYW9w4y05syu1eAR6+D64gqE/u4Yqgz1N3flJRGlKmNXOqQ0//s9KyEUvn2k9Knn09FHJDwSfJNjmyAjVAWYhQNiLA7rRF5+7EELmIWn5/zY1CuLXP/TJLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535775; c=relaxed/simple;
	bh=f8oj3vfqmlM0xsYADMFgn3dqvUu8ThnYSgPeaSBvCJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HIru1xph9hOK9tJ6A5dLKD+yhw6TgfRKK7+PigxgXXjd0Q53GX0Trya8VvJjwR4d2xSm6oAxg0n+wjWwistrEMvMvBnMJKHSjEs/MeHW4vD8eZw/jyrkc0m22rYEUsSKYoQpp+1q4zLRSmbICHYNN7VRD0Os5rNjK1To3hHSqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwimAlmS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a007743e7so5748376e87.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729535770; x=1730140570; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8oj3vfqmlM0xsYADMFgn3dqvUu8ThnYSgPeaSBvCJ4=;
        b=XwimAlmS6W5G+5nBrUQJTnXjmhPwREPe5Geh7cIV/BRgVMBwmSR6gKn6onlD800zVP
         KTr+IGcKu6hYSKvUAvRWY+wnL/6lx4w84QHO1a4TRFLDsyjuFPVvU42AOOd32LLMaLt5
         GN3gbhMBKVJA9xYFLPKgIbUFZnxETX+e0ljxmflJVCWqHyt+IQ/AGCYO/akmGBw/WhK+
         uipwL9J++2grhM/+T4BWzHkm1tInGvZtbRrgjresxUSaaKV4keWmXeYOq1b8josm4MYW
         UcHguVJwcRaN+SZ3ZLTbjZmEmZwsFpX9u176rw2UXUrghf1IJKayuQsC5AbhBnHde4DP
         i0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535770; x=1730140570;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8oj3vfqmlM0xsYADMFgn3dqvUu8ThnYSgPeaSBvCJ4=;
        b=BOnSSBxWsV+Utd4fpVbtHoVEN9sFJ3rKdiGgmkoFrO5/p2EGVSIrnC5iCcLy0p27fC
         eeoUj8g24hWcfFHjmbPkNnUWNUX1wAGUPq75EZiwou/Sn2KBufx68URu1XC3e6Nh5pCx
         lp7AURsNKAxl2txeCENM2d8f2k+j8T6plaI74LOT18iCkNfF6jMEebkmfqrYANB7Tx5Z
         HorcTBmPRXgqwoSmvB8GrA9+/uia9E3LjAf87u8v6UxUKrrjbIz2CPP4NcA1NDakkbvv
         CqAYecLx8dPYPMzYz2egTjSJ1X7zLQ2VVrn2gmK+H3jl3qTwlo6+i87vS0YUwuRRxjsd
         JRzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWUTisjONgCEN9A8DUKoGE6bqWPCVRYYvoA+2L3Nsojlm0qsnz44slj1KJzEZn2kbdLA6t240=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkoCuSqrc5CwNk8Tb1fsmzl8rs2laGb6AGxcz8rotFpyLqOVU
	fy4MsgILOFw2qTECczgAh6iNrYvabBM4yFoO9vzMDR4OOrpU7CmoVRxwDnLoN4hZ8hJ690C868X
	R3qzmAawChmk6pgeJov9rkDlqpgjET1qiWCvL
X-Google-Smtp-Source: AGHT+IF+0F+zaNHtxsbg+gonwYc1DvKt2ow49jd6XgmTT1CLmLAHX/pP8qve/Wi1OK1gXjQs8uB/egmJ+SnCNS621MA=
X-Received: by 2002:a05:6512:124e:b0:539:ddf1:ac6f with SMTP id
 2adb3069b0e04-53a154fb010mr5963550e87.46.1729535769525; Mon, 21 Oct 2024
 11:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021182821.1259487-1-dualli@chromium.org> <20241021182821.1259487-2-dualli@chromium.org>
In-Reply-To: <20241021182821.1259487-2-dualli@chromium.org>
From: Li Li <dualli@google.com>
Date: Mon, 21 Oct 2024 11:35:57 -0700
Message-ID: <CA+xfxX5ygyuaSwP7y-jEWqMLAYR6vP_Wg0CBJb+TcL1nsDJQ-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] binder: report txn errors via generic netlink
To: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, please ignore this outdated and duplicated patch [1/1]. The
correct one is

https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.org/T=
/#m5f8d7ed4333ab4dc7f08932c01bb413e540e007a

On Mon, Oct 21, 2024 at 11:28=E2=80=AFAM Li Li <dualli@chromium.org> wrote:
>
> From: Li Li <dualli@google.com>
>
> --
> 2.47.0.105.g07ac214952-goog
>

