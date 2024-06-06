Return-Path: <netdev+bounces-101545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E728FF54E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0D41F26BF3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6546EB64;
	Thu,  6 Jun 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssDq7W22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6961FE0
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702339; cv=none; b=c5JLrqfPmHARb38qUuNbD989uh8km7RcRz9fNW+J2kqn9y7iQFal0CD5bIJ9GGheHVHA+JKcl44T1yaxjsZo8yKoF0XsjneaOPFFJvZHTTlN5VGacH2Hm3eptXj4jNRgDKE0vsEH0yl6pbnbNW94+JSkKfifKNDZdklarHFIosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702339; c=relaxed/simple;
	bh=cAmKIx2+UgNcuQBFot4p5jbltSaygdkddVxlCRP+3Y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOS4Lv+HJrAKf+YtHM0D1Grz7LwW31K2+ZODzDE05xoY5jTxlqwfd3WpOmlGtygOkuCejJ4H/BWOcIbgAwjTjvvhWGDMcemqJRQD5JbVILytuQUlb/XNcJTwmq+iVCOj8/Ehtk13M0pddGPm0fb0ZaHOATUwUvVMKFsftuU4dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssDq7W22; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a50486746so19804177b3.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717702337; x=1718307137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Us5kw3fIsRJVzMbaEb9EJYarQPDAku4qQMRL1mEGwI0=;
        b=ssDq7W22ezN/5chrAarXCG6s9065F8WvN4mxYjINmde3fcubleFAdSguIBSAkeu/xr
         36CAIpTBDxk167C9wIxl5xwEBN38Q9IAX5qtXNeY0DDFcsg/5uapngG+Iiq1hifvOfCf
         F0AjbIDrvX8lIlsGEBTfq+vmEx/ReeyYuD0+G8GCF1BQc/ekgYBARMf/eHX8bhfS2ByV
         bjPliHaiMnj/dycEdca3aBmqzU8tMFwLLdFgI6B/S20xusDidc5zMgB3SC3Pga1F0gyP
         T1EOsNOtmXxLzcsGL1fNZ8aYz5PC998+kU9a8RKSTqPNvobXdROFWJql1v+gHOgN9Cgz
         BiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717702337; x=1718307137;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Us5kw3fIsRJVzMbaEb9EJYarQPDAku4qQMRL1mEGwI0=;
        b=F93dkNyPS7p9ZK9nhEwLOeiIhOFS19LwexkYnKdjeFmD1Rb32ojT01aMWe2ecOvf+s
         avNr0GWmiDCGRcWZQUPICNZf2QYqT8iZpYsXXv93Tc5be/hcnLy4tE4q4W5t3FAeGsk0
         G0LeRci0zl/KVzpmguJP6uep+2SfScqpYMmJLvmNzEj0jGiUnxzFv6ce6aVcRVyiMhHA
         4uEWzey1s3LVwGRpI4Q+b2XGGzDRyFVWeJ/lrPa557CB2J7Q2fkzmGkCWTBbtULqo+HA
         tGHRR4ynbPuJGhXVl/UnEuFEsa2xRae+52Db2Qdgk5PO1vd0sqEFgKyqCOvTYndKtRj1
         NuKA==
X-Forwarded-Encrypted: i=1; AJvYcCU1XQTMQnB8MiLqsaAy8PSLhKZAR5oC1Df9dWs4ck1HEuze5lewBmIGxgjy/ZfcHxklTxjgbEDZHjk+TPhcopKn2K1ON/w8
X-Gm-Message-State: AOJu0YwGqYpOQZRYRulccTAKyYl3GJvB0QPumwDISCuxxUwm9P2ymCGI
	nVPrDDOPpLNB04qa2rqY8J4nN59gCwuX8am9+u14h+UXVI0kZLLCN0ty/ocCJatL2v53vJHIvOo
	FBw==
X-Google-Smtp-Source: AGHT+IGuutWtJjBpFO3VxSCq3j0WSE6iFmjH8jY1+Hy7CRzoly2/MFImVM+zgtvIzvRtbqZN3kTDiKT4Hlc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:3609:b0:61a:d0d2:b31 with SMTP id
 00721157ae682-62cd55e4952mr645807b3.3.1717702337593; Thu, 06 Jun 2024
 12:32:17 -0700 (PDT)
Date: Thu, 6 Jun 2024 21:32:15 +0200
In-Reply-To: <ZmG6f1XCrdWE-O7y@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com>
 <20240604.c18387da7a0e@gnoack.org> <ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com>
 <ZmG6f1XCrdWE-O7y@google.com>
Message-ID: <ZmIOv3MiXC6M4Dws@google.com>
Subject: Re: [RFC PATCH v2 00/12] Socket type control for Landlock
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>, mic@digikod.net, willemdebruijn.kernel@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 03:32:47PM +0200, G=C3=BCnther Noack wrote:
> Thanks for figuring it out so quickly.  With that change, I'm getting som=
e
> compilation errors (some bit shifts are becoming too wide for the underly=
ing
> types), but I'm sure you can address that easily for the next version of =
the
> patch set.

Addendum, please ignore the remark about me getting compilation errors - I =
made
a typo myself, and it worked in the way you suggested without warnings or
errors.

=E2=80=94G=C3=BCnther


