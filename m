Return-Path: <netdev+bounces-200738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3CAE6B4F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B24162A4D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064352DA74A;
	Tue, 24 Jun 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJDGqvKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8432D6629
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778596; cv=none; b=Dt/I1vgHDfCrXWob2Lcg0UhZ9VOsyZF2LL0gWP286L4aevpajL08vTDWWHkSChjUOqo8DFg/7zPVST45nkQNx9u8MXgo7rS8SZIUpDs73bPCcJef22Q65q0ZOc4X5oyK7WhNS2tflAKtluSq4Jh+SD4aekhn1nEoHtOSGL8m8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778596; c=relaxed/simple;
	bh=OsHzL2QmtaBFsR+icUHxcUjIVSkn08E6eAXih9sMNqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geCw0gQwruz5DSl3wx8POoNmAfFMfnNhyOY4hr+CCdOUY4nAhKLuPnTDb2v0EgefnKLOtCdUcahV9qGKdz0KolO3iGWCFwdlGCkJkvfvuVmG5El0HIYr4nyzixKrdj0brC0W7jp4/pXL3setRQiyCDYwNj0PsBX0EjiM/BKe/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJDGqvKX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237f18108d2so196855ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750778595; x=1751383395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsHzL2QmtaBFsR+icUHxcUjIVSkn08E6eAXih9sMNqw=;
        b=UJDGqvKXizd0bPQVkaruWr8ZF1ij+HBzYC68KolzrdVma9a9TrhrfUCx0LGO4vF8px
         AewmRkR0zxzsKTsCcdnuCNqlhjwzwEnPEAyaviQRiywSfKHhiilfCKkXq+1dPEZcPhRs
         ZSkQsLbp+OCsfRoT3VqM8+Z3hrftJ4tZ9SytFwvX3b/Gu7o9hjUfnJCIO10jASAO4xeY
         MJuA0aZsRsbM10waYI4n0FuaaqZSh3dCAL21w+Ln3s9waJre93B40MOkOm7LDFwXMdsC
         c/QQ8Adpxbsj8SkRlBLsFvMWAwW1hlWIo0lyHEY+WgQYpqk9nbLbyNrfW48B6CvWN2JK
         vURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778595; x=1751383395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsHzL2QmtaBFsR+icUHxcUjIVSkn08E6eAXih9sMNqw=;
        b=CFbU5sEr1Sf/jNQW0A95NdkT/Cv/MLiB1UfVz0vza8Ws9st6bNmjNaqW1A/z5aII0o
         oGe7WpWYI0sSS8nHZEku3Bg81ApNrgduYRv5P3+QTOSG+yEN+0WhEY5EFrXmHZE1UMfa
         6SGtzLaWLJgunEjykZeuALvJCQZDKoyKgREhG8wJDOvNrzSkxbUw19QrIUKfouGi9TDn
         OZPg52JYnSs/UXh4/4aYCfH1TbBPJKfyUkhRvC5D/Qp5xf6YZ3alGBxOk4CG93TU/193
         3XIvtgohQnz3P8Vn8vdBK/g/Dog7S/cYhxiSwrZCPVWZ+CxwcGPIUx+yUsJYMPrExDnh
         k7zw==
X-Forwarded-Encrypted: i=1; AJvYcCWBRQLJQNsEPZd4NLJ2weNAGwN7mLBu8ArOTtv0y8+oY7AHXL/F5PIvVDHrkAa9XQ91r4nwboI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2F2vfzAb6/FqdGDHxQuI0x1RYpLWYu4hhS7rwFLUg8tuQFw3
	9yU3cuGlBayw4/+hx6jKDrHmIPEiGRFTqPvtLPyV8ytjnZA2PIaZziUzaeqX92zTlarISY20pRs
	zgmW1KJJo5GUDoPX4dZAp1nkfsqLXmsPsGSggWdv/
X-Gm-Gg: ASbGncuxT13ze5b1tp3EY5eojPuki+fglT6xSgSVNyy0jcb2fdhUCBAusHtNLUR60vL
	g5QZehD4ruq6KdM0A3TI0GMf+isN0/hj9gJX6/iHFBnekKCjl63mZTZDCrwWtxTvAWzDF/Nc95N
	FLTeQuwD0ms4fTrguSjujr2bDenpry6w3Pi8wLVmxsXX/v
X-Google-Smtp-Source: AGHT+IFuV+2Ga9TSOFwnFolgarENN+7E/Cva5lJLhIeCCIC7hFMvve9M0hq1gAoD+N3ejaHL0KTuSlx8P61f7rAinTQ=
X-Received: by 2002:a17:902:d551:b0:236:7079:fb10 with SMTP id
 d9443c01a7336-23803e7f04fmr3511785ad.3.1750778594186; Tue, 24 Jun 2025
 08:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624140159.3929503-1-yuehaibing@huawei.com>
In-Reply-To: <20250624140159.3929503-1-yuehaibing@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 24 Jun 2025 08:23:01 -0700
X-Gm-Features: AX0GCFuB2FfqPxAOT9GIekGHD_Ki0PPJ74vNDf3L0e2L2VE867xDanye4TA_ga4
Message-ID: <CAHS8izM-UsaMCmY0Rqudg8-b8ObFFP9Tq0zD8-L7YB7CG2CURA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Reoder rxq_idx check in __net_mp_open_rxq()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:44=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> array_index_nospec() clamp the rxq_idx within the range of
> [0, dev->real_num_rx_queues), move the check before it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Fix looks valid to me. The current code looks wrong because the
dev->real_num_rx_queues check is done twice, so we'll never hit the
NL_SET_ERR_MSG.

One side effect of this is that userspace code that does an out of
range rxq bind will see EINVAL before this patch and it will see an
ERANGE with a netlink error message after this patch. I think this
change is fine even though it's a minor uapi change.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

