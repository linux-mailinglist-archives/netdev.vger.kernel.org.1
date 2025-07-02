Return-Path: <netdev+bounces-203248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47CAAF0FDE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9414E0B3B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C32459F6;
	Wed,  2 Jul 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Vlccg2bY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBD246335
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448276; cv=none; b=XC0lzLbPjLIVkMR/ZJvIcMaeZIq9rI7DdW/bYiI1aWlHuDRzlZL/EtFpRk1QZpa+yd98izGWm1gs82CD+C6Qg1j/jvIgmxoP6ofuotK45yelg20TrwYIoeW+Sy52g3lPimh8mQuHW8gQXCyXPu/7lJ6HXvNL/Z2ql6DDjMW75Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448276; c=relaxed/simple;
	bh=s2/pkGo1KgPXhul1pIkhh9thlM4yY0+G3/Erua3W2FY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgHdd19P98A5Qy6Incv71aDMyFGgHj6q5wSu0Ofx0RwG1rjvYj/FY0ArBTfOiZ3e1C7Pn4iJigd4PFgziIWAQ5Ft8Q0TZ/W5fJG9zZ5mR8fObiFirgjRscsIaXYOakhj/vAY1xvJavtzzyY8XPWRZvxmUdxRAgTVhWb+FHaBJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Vlccg2bY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo7452564a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751448271; x=1752053071; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2/pkGo1KgPXhul1pIkhh9thlM4yY0+G3/Erua3W2FY=;
        b=Vlccg2bYdFI2kVVc+2n6hm8m3ajYSFHVr0TMaERxDcYaO3JLeOpS0Dm1EEpcpdAj6b
         Fznoh68S8rTyCzaZOB94DmzLLNsSOnP9Y2zK8GUM/7nUucSt2qcIsnXQKIV+rLBGHQNN
         d4TwuQqzc0NfUJ57s0jUHIUiwtMqE35U91xIjR8ds5I3bQSqFXCSbUhp+ZYBH6Er2DWq
         vxH8e+2w/dN8PvQQ1E18phwUVll/DPdRRQ7NY67Ik4wgLnSyr2SYebXtSHgaLUmyem1O
         iTo9Z7ZumJrvSozw+mDFULc2LBZAgPffS5jVphnr9WAoNVSS0/kacHw/KsYcrzStgIEU
         4kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448271; x=1752053071;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2/pkGo1KgPXhul1pIkhh9thlM4yY0+G3/Erua3W2FY=;
        b=JpJSbSujdHAtYpBC1wKdt15MRIbKHndyCaxhb0zTiWa3Xp3SdFUUhNzf4YU5IxdKXk
         1Pw3/OwL/+38jcH7Yl4l8d+Vzf0gs+Wku0ebIo8rXD/03y6WRIz6OZQuZBefKOUUGH4W
         bwhbsuzYrhEV45QUHldEWVzzo8zvqQYeuUenbwwXQ/mAsVa98+HSxzzBSYMlzea9u8/3
         U+zSl/EoH1Ky5VZOAX/5mAPS86FfJL3gIkmuVvJmwsGpKYft766N6of07X82RluMiATK
         VpIcl8k7BDMB9C+lFp8jr0nzxdjIGmE1fuo0Cl7wQU0MscRp2SAH7B9fffjgSZT7aL9L
         WKtw==
X-Gm-Message-State: AOJu0YwmzcLnqOY+V95t1xOI7aCBx5sxMzus21cfPZnKv5N5Do0iKCdt
	kNVdPZ8w2eAY1wplfWf8bD2fgX+XkZzSuu2j+pEv2VSafkxNlIr5a8BxIquQrk/T8fk=
X-Gm-Gg: ASbGnctAQXdM86n5Gg7YfaErDpdBoZE1cOrAqMRmWtr6/8/VuRxpY+gRueDbD+KEL2f
	iOWdoRv+xsqihfKumwZWQZf62s/YG/bT1fh++5zHfqCkfjNyzscWqCEyQeEK85Ex2OPuSiFfW4k
	+0KB0eALmat+IhuflN5DSQidgSuv+DD/QkmyXUruKSTUSev0zhyxFRF+IIRhZkFlAzvpDpYozeR
	Ly4X19rBFIiZAGsxpJI2IoSEhpgm8kp4WnAeIP6m1pGzJhKFsupBA7H6vXlglswSNXOmNd1k756
	TA5zr9BhWIZ5qH8Jhyb+DsBekUOB/XEwem7rTiBP7QVjg6nKEMZZehsZ9HDVkHAySw==
X-Google-Smtp-Source: AGHT+IFV41hFF3U+zliks32cLXq2NSxbarTe0yBpA+bLAmYsFPnGmaGaHYM3ptii1H62tsI00pRSBQ==
X-Received: by 2002:a50:fe87:0:b0:606:d25c:c779 with SMTP id 4fb4d7f45d1cf-60e52e3c340mr1632001a12.34.1751448271494;
        Wed, 02 Jul 2025 02:24:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319fd60sm8692843a12.38.2025.07.02.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:24:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 1/4] skmsg: rename sk_msg_alloc() to
 sk_msg_expand()
In-Reply-To: <20250701011201.235392-2-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:11:58 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-2-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 11:24:29 +0200
Message-ID: <8734bfndwy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> The name sk_msg_alloc is misleading, that function does not allocate
> sk_msg at all, it simply refills sock page frags. Rename it to
> sk_msg_expand() to better reflect what it actually does.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Nit: If there happens to be another iteration, might as well add a doc
comment while at it.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

