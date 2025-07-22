Return-Path: <netdev+bounces-208738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14EB0CEC4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35AE3B8B4D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7885347A2;
	Tue, 22 Jul 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fv/EL6ZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198412E36E8
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144439; cv=none; b=KYpdIC40IAYSVLv+j/o2WmbytDclC6fyXcXkdWwW9oWSK72YRDuC+3AmqmR30/ZqDcLOjmoc4ysEs5C46HhpeIqv25Qx1061rU872kqZAFfZX2Zp597j7yE5UJL/GMOI9QKg8+ENP0t6u/9jDQuIk1hgYJYxw3G04NdevoS4464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144439; c=relaxed/simple;
	bh=wZtlK/fCCRI+E9S5gNjgoVTfYtUgS2d8yDeWriMrCBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvGiaj8yTetDFiBNpIK2L+LUvNui/JIQxyCU7AdVYXHZVYqaffUR3qiI+NCaRk1bzg0QPUErEeWA3psZKcFKSmrS5djoQAsEt1L83xC4FNFSch1Wo89+/NNNGgPLQSw64djwnOwq/Om/Dq3XjdReFG4wAWJFM/bdyk1Mn9d+zS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fv/EL6ZD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54b10594812so4811380e87.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753144436; x=1753749236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZtlK/fCCRI+E9S5gNjgoVTfYtUgS2d8yDeWriMrCBU=;
        b=fv/EL6ZDBnfmSYERbg2qrC3CwrB1yg+Hy2wJ0KzR0VO7RUAsDRLdgZADseWOW9EGn9
         dcujOJt9YaZEbvOBlWQFFx+wj9wbsl20hmbrzmz3xmIpkaZVfbE0rwdQ3fAVZDkBuZLA
         AHvUQZiru6hOo+Jl+rxOZnDrLWCeMmzIa1qETrQu6i9t8R5pdYURKOjbYEIttwdZQJLb
         sePwNk4usZtMBIHjVwSb8xD5B8nQXKglZg4FHQEE0WsvV53hq0RehsF7hpYr/zkvaBet
         bgSPN9SS8HwQlSzjlwN8K06STxhT/Za7i3af8XIqThPEp2kW6MuqHA1W1JWZJA4/92Ps
         vRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144436; x=1753749236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZtlK/fCCRI+E9S5gNjgoVTfYtUgS2d8yDeWriMrCBU=;
        b=owLID8ylnLAx9/uUHn/KSy5I37OB3oNja8shbhUtS1T7ukUgieJF23OMdkll894RCO
         oLao7kYRPRg0922dkMu9RTaVgaXR90lEbdk4ZHUYXRLKSmWZLJLGD8E2sARbAcfdyDJ7
         Lhk6tvFmB2GnTrQsAByq88+NvJrmzXvPlSsOdBR2ym1JZJw/t3iOb0rQY8flWRleHL6N
         l0xRrUYrIqUajRfK3lXRdRk+SZbp51dzqeDXHtf7YJ1uPj6hyBMlQyU9a/UkkdFtn2DL
         3a8SZoFsZk4nzqU7g5jNxl2lNTrXQUdqgaVWhtXEE8y86s0raDoRrAi1kv5Czh2LePym
         26ew==
X-Forwarded-Encrypted: i=1; AJvYcCX6cF25BTAShXgETmDD7/UsyWQNaRc/5/mL5AiUOplg2gxeqJwF2gcx4oYrw3jMHDyinScSvJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MnFOPz8rNxcMR50qjYyDniEwUTmsjmNv2baH02mtVaNseBmI
	pdj11AZfUrLpMb6vA+Kiyd6uQBo1mVxOy7NflAUKDvastbiLm0bzcJ6fFyFo4Fph0AA9MANOP+R
	M6hXVVu5HeFqiVtWO0w78o6PQJ3t62GEflbZ3t6sK2XRNV+1OMsGF
X-Gm-Gg: ASbGncvgJZSVHriqQsxilArElR3BqkwVVmcw+1f6VYVJkJWXMGqM7kgGqKJAjZ7RMVK
	vexZUqN/X/KQGFbBTetHdWx11XVorj0G3Eco8qIPdp2I/rkY8YPDWYtnLyVUooCy+ouJsxlMP9A
	yEGRrprLaMM98iMIoZctHxnkVLWrIJXsRFn1AhtLXhHIMAPHbJQhYYOqzGMFfXqu6s0qzA2pgCH
	i+wtKeHsAzv2PXc3eNuwU605e32HJ5jpj8=
X-Google-Smtp-Source: AGHT+IFPkdz/j0WmlQPf9eirRVv4pzrJfVe9XcNeD9iftAmBq9pNEGWwscLQQrIDHxFF73EFaTg30vEM0mhYbaxj0hs=
X-Received: by 2002:a05:6512:60f:10b0:553:2645:4e90 with SMTP id
 2adb3069b0e04-55a23f903a8mr3918362e87.52.1753144436009; Mon, 21 Jul 2025
 17:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
In-Reply-To: <20250720-timekeeping_uninit_crossts-v2-1-f513c885b7c2@blochl.de>
From: John Stultz <jstultz@google.com>
Date: Mon, 21 Jul 2025 17:33:43 -0700
X-Gm-Features: Ac12FXzw8e_7tK347TOtMoDcf7inbuDAbjNTfhyZDD3X2xHKbAXOB6AX_06IwXo
Message-ID: <CANDhNCpE5KPjdJVsB_UszmA0eePnZTtQ9P-Vye2rJQRhBGFTLw@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: Always initialize use_nsecs when querying
 time from phc drivers
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, markus.bloechl@ipetronik.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 6:56=E2=80=AFAM Markus Bl=C3=B6chl <markus@blochl.d=
e> wrote:
>
> Most drivers only populate the fields cycles and cs_id in their
> get_time_fn() callback for get_device_system_crosststamp() unless
> they explicitly provide nanosecond values.
> When this new use_nsecs field was added and used most drivers did not
> care.
> Clock sources other than CSID_GENERIC could then get converted in
> convert_base_to_cs() based on an uninitialized use_nsecs which usually
> results in -EINVAL during the following range check.
>
> Pass in a fully initialized system_counterval_t.
>
> Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for converting =
to/from a base clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Bl=C3=B6chl <markus@blochl.de>

Sounds good. Sorry for sending you down the wrong path, and thanks to
tglx for lighting the way. :)
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

