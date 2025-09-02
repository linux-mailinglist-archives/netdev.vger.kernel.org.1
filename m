Return-Path: <netdev+bounces-219127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70251B40015
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523401B27789
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAB3009F8;
	Tue,  2 Sep 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzLvHWK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC52FFDFC
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815500; cv=none; b=I1/Rzd9kf5355vex4CGhs+3Qwdhs4+HnWte7wJpJOuRjr7DmiQsdwxZ9Glju+T+Oalu7QMg57DvKiMPTYEzK+FmFponowXhDemmd9r437cD/U+B8hbpZOU4kwOTDn0C+egZd41NQVt+xBAKNkB9w3myXZflLb8AOy/+Kf/uSc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815500; c=relaxed/simple;
	bh=NTUciYP4qkVSP3Ids2cPJKg/b3yW1qYXyRE6W2+YvyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5WYduAFiZs0IhxuBwqYkdj6Dq2mGqobfBT7ptaU8HI9ksfksnPC9r9h5r3wZNgXBQqg6i8No0FaMgzCgUD0bH0+mfe/Gr36T2AAeEl11R4ohgq37ZdzzA1a6fvHilnKr0L9OTpP5uoIDMcOLTNO3L+yIS/gT/JI0p7yeAzdpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzLvHWK1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b338d7a540so19057271cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756815496; x=1757420296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BtHVQVngraHXwyztIS7rS2FP0vL/znas/2GvCizYvA=;
        b=PzLvHWK1Pbj6WlpmabFlATKlg//2jKQcWFwDO4mh/b2dlSdxKBjbpmonyVzeAuJ7rI
         VQWlfOtS0GKss+npbDB/bsePPacjgaKOmF6ls2gWRa834PXhpzBGVXMhE68Zj9WgQhdM
         St1lWOqyJKaGhZ93OcLYJvivxqHKuHpFwRGNvBOqTUtmrJqayUOEGitfkU6Z+fOKcs2R
         3+60MEz6IvqSvXCJSPmVkx5Iu/RYKeAgAKI3/qTAVKQxSCw6Lp8wDVcZ3iasJQMAEC+Y
         iudGaxk5lAA7bQTYgN8oumhoWT59votstdkrd4PXS2uAjZ4KQVrMlEW08bKqV9A5pdap
         kEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815496; x=1757420296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BtHVQVngraHXwyztIS7rS2FP0vL/znas/2GvCizYvA=;
        b=Y8+QmVVRFOqHNhi+ae2VvPeLn/guEfodma6EE3Kgk1zXdRrljy0Xj+pD/quQyOSiOf
         74XbEU3BczivMr5+Ja6/aMj9dhPuE1Jxb6MN4hlQWfoogKKg7d08/VwWSU1smG21I77B
         wo3d8tNgJ2LxdnFKgs754Mh4VZF12huElv4MafdY/6it3GSEEsFjbjhdz/Ki7ozVpUi7
         vPG6CbFsUusux5Lcr9Tt4J0Q5Tq146rCPXcyKEn8VZENyd2bbOVBAJJ7pm7t5EI3LZXu
         RmiZDN3daDaPFybqgXR4WDZGLY7qRwREsB5qvuZZbti6dAxxCFoPMGDLbimzLsejEHbt
         92pw==
X-Forwarded-Encrypted: i=1; AJvYcCUx3vnhPYi7D3yEd6g9O4uCBeDGw/Abb5uVQcp9VWBP5i/G4uqN3XtV/z6HcAccI44so2pBaV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbKRh11GLFOnz6PbM/hp85+aqljJ5nnc/EXxvLsCeC5fc9iOZ
	mSsL6VKt9yG88IComZJmmwmPhzSq2f8oOdhqzphrphMiE9v1QCgLQbOT7hYAXeEdFY+CvbHkGmE
	qUnyFL7Nyb82y2u+08tZLp8di3VLylroPsL7SxNIl
X-Gm-Gg: ASbGncsgZVB8vQOlgGo5K5l8tRtSvzkMSS5+Ssm90O6K+3A0tVVbfe/R/BQz59Xm+P7
	9kMZJAMjx8vw/kNzf663aYAK8MwUlQNyS27FMylLX98jRCyp9rYcQz2Tsf+BOouTL0/oNZonlZq
	YKm0pBuaY8Dh+nUoe1VKtrmvtZW/155gf5i7vuw5pjBFKuMhZfbzPVBOH7ntwD1QrRFvxD5cF9S
	qcqJiEZtk2KNA==
X-Google-Smtp-Source: AGHT+IH5vzEO1QHxkAoblS7kriJ2318EF1KTzHsAZLiCGeoig9qB+yVEkkECgxfzHSgXCz6G9dwSrH92f7veZprPEl4=
X-Received: by 2002:a05:622a:5b09:b0:4b3:140c:ef9d with SMTP id
 d75a77b69052e-4b31d844993mr129778201cf.17.1756815495331; Tue, 02 Sep 2025
 05:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLaQWL9NguWmeM1i@stanley.mountain>
In-Reply-To: <aLaQWL9NguWmeM1i@stanley.mountain>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 05:18:03 -0700
X-Gm-Features: Ac12FXwI4CvJS6_vLUukiLiLi6nGCSauJpahGMDDKoEk8R4QGC_U6PfE1GF1EBA
Message-ID: <CANn89iK9FBmqC78Fn95Aa99+TA128xXSvSsLe408zkk1DG2Ojg@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:36=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The inetdev_init() function never returns NULL.  Check for error
> pointers instead.
>
> Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

