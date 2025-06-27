Return-Path: <netdev+bounces-202051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5EAEC1C0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618A93AAC67
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A52EE266;
	Fri, 27 Jun 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXjImftm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044611E8322
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058688; cv=none; b=Q/kl97JhEXk8IvLO32KiPdpu2HLZzAzWZ6SY0udbEMdoi0ujl0MpIjDR6m3iLVTb6KPrXb3tqZQHxN/uduQ+91kDcHyeHOy6wuSiJkSnhvhAW1OLq+JhFO9LOivd9r+Ls0VWE9VxUwm1MTiM2W/sZRqt2B8VMqJnuAvITderPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058688; c=relaxed/simple;
	bh=bcjYnlR/XVEnJOiOcsvKV38ba8TbI3POkGQ6hRtaO1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1K50aY7ne/L1VJcOe5fS3Y6i8z1aTks2ZeCjwBwmO7Lbk6R8/KeZWHZ/cKy97NcSlVsAlwELYmAkP/Ur0/0H2zB+smJZ34PrZKW5AUzygBLl44Mrma0+NhnE91WqkOA+aOa3aWo1w8+/owXq8qJ6i0ccDCOslYRrKZcyRQ7SH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXjImftm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31393526d0dso1486632a91.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751058684; x=1751663484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcjYnlR/XVEnJOiOcsvKV38ba8TbI3POkGQ6hRtaO1U=;
        b=qXjImftmGaumHJbCJeoqOTsyVzjccjktsIvzclmyvZM6fUboL5pPAvWoyztHN6c0tt
         kF2zFQ1rIkXgwresTz+aqOiHevpE/kHOIWXvphEfZ4LehKHLJcE0hSs2YslGUZ+Qb48K
         1JXY6mtzewyqarviELw7HcwfSFbHZTnPyGbTT6R6koryjEwh9aHU4tynIdl4zsnB8iYy
         n+9ZkGwj48a998WQEm8oINVCSiND4RZsz/96/fp9WfpDuYykHHeHMuj0j9HpkHd46md6
         jxSqiA89nJVLpkOBwFYV4gpmPzb0yEpj1/p34sHRr/WE3EzOlmMaB22QSSF3tqetHYpn
         TwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751058684; x=1751663484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcjYnlR/XVEnJOiOcsvKV38ba8TbI3POkGQ6hRtaO1U=;
        b=CVSbpagwUOyPrEfuWCM0SXCTeRei1gKeg0UlyO1V1duavfMdqWe646WgEK+Kmrzl6q
         zcODEU6EVo2VtZax+qaOCn6g8hQn1sOjnjlTSAHqDetA3Ia2qHbnbwR2/61AMTQqVDh7
         btm4UFb0RWsZakqzglaKmn+Ssalvo68Y4AupejXG6iaPrFG43AJPTeBo88Udns2Dg6nR
         EBKQEitPOaTtGSqCYCE6wa9M1N1iKIyj3oIzaIeQy62njVvTNqMV9hSNXS3jawNpSlr5
         OsQ6ggg/OTLnTH8H0y4H3n/rdS4MKfWOn9jgIOxjJG2D2TRlb5zJ9m0Z0nONSGm9HHsN
         1TCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0fG3sbXCAQPMqAo2IDCNu3U6Bc/y5FQwO08APFSE9yhZ1FYIDqCL/mIAtA7pIRFp88ULobHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaytyWlfJ7HEpVkqAw2Me+U52iw2uhm9ZIoLfQn/ETY3jjELn
	Y3dRD+NhNDSY6e8Wn/cubxUzmdJ+pAPRuHm/YRKVL9m+CrMIM2sLHMHZzp63ciTmMhrmqy600dG
	I6m8y4A55+wrBsKTwsXVSop9wYnTwbSD+CqCEhc7W
X-Gm-Gg: ASbGncvxeev/EadaZW3Jj0JrsY54L7YYbIpsXi96gKYd3RDjU4ZmiDfFK5d748m8m0U
	zGS4LpUAGCMqqKweUXq1nZqjfGtYIX2LfWtWWWK1BwEbbYmn96Dgd9FFj0oiHfa2ZdNXhEBLXF/
	1BODEMviHx30rUsFsrggEvRY5brBS9yhpbj/vw7vdwhOLvNpmt9pjABgO+AbUmoFB822e6wWiz0
	Ch0
X-Google-Smtp-Source: AGHT+IE7aVDpMFOoRD51ZwqAlrCjIcKKXqtjyXUVhIyN+QmorvCpDLSlMpDRVMnhRwqZATkeKJc2yZ1tKQMVYsVje0A=
X-Received: by 2002:a17:90b:1f8e:b0:313:2adc:b4c4 with SMTP id
 98e67ed59e1d1-318c92e3162mr6695789a91.24.1751058684037; Fri, 27 Jun 2025
 14:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627163242.230866-1-edumazet@google.com>
In-Reply-To: <20250627163242.230866-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:11:12 -0700
X-Gm-Features: Ac12FXyvylEZSLZmTVqf-A_ymOiqXKF2D4g9keJ2CODp_uXuPI1aIbk0MhL8lsU
Message-ID: <CAAVpQUDv_DApOnqOR+Psu7Ykfd27am-xfEhfFjwYfRg5qSbrjg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: net->nsid_lock does not need BH safety
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Guillaume Nault <gnault@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 9:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> At the time of commit bc51dddf98c9 ("netns: avoid disabling irq
> for netns id") peernet2id() was not yet using RCU.
>
> Commit 2dce224f469f ("netns: protect netns
> ID lookups with RCU") changed peernet2id() to no longer
> acquire net->nsid_lock (potentially from BH context).
>
> We do not need to block soft interrupts when acquiring
> net->nsid_lock anymore.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

