Return-Path: <netdev+bounces-232809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 982BBC09084
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F654E2C1C
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F718BC3D;
	Sat, 25 Oct 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKI9Hrav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0D2C235B
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761396305; cv=none; b=A7Yt3aPwtebPJ8K01L6sXo6NR2aeROPxBbNPHRY2gD1fyTKaarM0RiQt1xjwWMJ3THbpmsiLo6Xln25yG3svpuZnYj9I6PvX7KFu2w+PdWlV5mN931bXxWLslAJ/MJiBr5mF1u30WgHP7SXqePMlajLAeaud63W3QXqCBu+hmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761396305; c=relaxed/simple;
	bh=C7RCMPYJxiHbIff6uyGxXLWmOareJd5pab4+KHZQmA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neYFG4ZjmEEJ67bL6sn0JTgl8T3epO0CBW+ZEZ6Q2Py3zgMPVC5rHTDCfoi7JAGwcuesMvXPSRYdUUuWpSdcQ10RX5VTPw7PK2WyjUOg7Fj713iHhHatgq1difCdd6NETLdFqcnLH7AfCaYwiWuxCwJcGg8NLj9gYPn+qVDZwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKI9Hrav; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29301049db3so4641045ad.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761396303; x=1762001103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7RCMPYJxiHbIff6uyGxXLWmOareJd5pab4+KHZQmA0=;
        b=QKI9HravYuYwQwLhsLKCL/dtmWKTJGul9bgAzNPvQrM/7AA4dcM/TtsWIsMDQFi29u
         2b9c3DPlRrA4NCfp0gARe2ghRnyoum/ZtV5UHHXMKF+K9wyntg1GfzCgFQUoPTeJoypL
         rpKkVGPOTNuvUj4bHVdt1MT5SN/R1wH6TA07kPTqKL/+ElyLA9fDpYul1jvox6DZADlR
         dOn46Qajidb96sNRuhLmWaaQZNlObM3jCG3mdatsRLJvczrPN6lfzizk/Kkphf1Wolt8
         qjjuWJkaX7IpqP7qqKWZLhyNBeb/QV/1dyLnfLzFtECdzK3w9B84CTKYDS/C2YpRhJ79
         dUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761396303; x=1762001103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7RCMPYJxiHbIff6uyGxXLWmOareJd5pab4+KHZQmA0=;
        b=Ou03owwlwDy4irAIcIFtd1gGNqbHs+Mth+LUMMOVvPJcUT3AtpCyiG8i68Q+Svr2bq
         /8flutuAnCu3ymfMomZy87cxYVWWikIPCMeprEJZAM7hZQwouYGhoW/+DGWic3LCWIfn
         d+U9QU5jgKIWP30Lkj22NOZ5bUWeu73Q13JqvQmUSQ7EbZyFFChSp3r/sl+XeoLNgWa/
         koxEPQwOh4DjxcihGJsuKOe2wmLynA6sRzztw2kFy8ujPrMEV8mSbA+S+JNyFLJ3rRgn
         scp5iFcHO2GYY35SEVl31I3rZnIEJrGnCa1fyqamAHEd9uQISNNt68bgtoMaCryVUqtj
         Uj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJPn90NYYVvDTYv+BYni3DK2anqEogai5iGHwS4T1XnKxTf/RP89Xhc3Rg7ab8JNMcBp1WlYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEspH50jwgHSO1YtKADu9bVvFnL7jzHD7tdVEJWxkGOy7DXzWF
	2Kj5qvXA1uKj2xxY7NUKxhhbZSjbBE6q7o6CxjfI9lC+35s3QGnIQTtb3wjDarWuNJsQAIBhj4j
	kMfGdT3EdtAbPVCG8XmvEEKQGMiA3+Sc=
X-Gm-Gg: ASbGnctj+siVjZM/Pz5MmjU8tBP+vPW8iaeC28OyKrMna9R2yU9byRCJd0TYw5tbGyA
	oa9kPIDPeWI9hFOto2gf3o/RwEzV70xzHgW3hRgiQJpfWkHs1igsY4oyOaMXgO0lUmZxUb8bKyY
	BY47ueZ8guCpZwLZmyi9scH7KsqECxSOhoSI2pabamhAYUW28WmcHOR/sJ28qnXbw5NdylSN1Ld
	OSRuvz+PohezXtRDz7YXuyzIAuBlr0hy2Dk2ZJO4KUjogRgXeROXMtUjSCrIAwbtjnR3QL/Y12m
	qjlYBUvW9DsDVg6JoDn6icYOkm/5QvnlY/eNk17UTWTWlFKT0x9HgpPm3O7WgJHZr/Bl3OxoW2X
	orbmH3W+Mulafhg==
X-Google-Smtp-Source: AGHT+IFnwtuPM1t4cSFlyMdWfosAkAQDsFe7ldATnnuYeEiyjQeUZlc+gbfwi5fU05sJQRiLpWnjw94QHjb7v+hqPPU=
X-Received: by 2002:a17:903:1212:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-292d3fb7f7dmr114055105ad.6.1761396302912; Sat, 25 Oct 2025
 05:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025124218.33951-1-sunyizhe@fastmail.com>
In-Reply-To: <20251025124218.33951-1-sunyizhe@fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 25 Oct 2025 14:44:49 +0200
X-Gm-Features: AWmQ_bnwo3M8FN9w1gVNfQEyRU5EK1H9Fv1DoP63Bar4frG5RXkcOVmvftK9y80
Message-ID: <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
Subject: Re: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()`
 with `pin_init::zeroed()`
To: Yizhe Sun <sunyizhe@fastmail.com>
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	tmgross@umich.edu, netdev@vger.kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:43=E2=80=AFPM Yizhe Sun <sunyizhe@fastmail.com> w=
rote:
>
> From: Benno Lossin <lossin@kernel.org>

This looks wrong -- is the Git commit under his authorship?

Thanks!

Cheers,
Miguel

