Return-Path: <netdev+bounces-169817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E1A45CDD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857231881A55
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8218C034;
	Wed, 26 Feb 2025 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/2rJWCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E3258CD9
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568616; cv=none; b=L/4uX3TU4E3/O4s9nJcOEOwOlqaSVN4poX3QRRv4QBAJ+Mvg/qXouFmvJ65ON5HjAynUA8I3+ZHT70jpg0ZQXMLan+3JOGbDjdEwRtTZ0o9z6CEhmH3cjeuLvrUjdhaOa3TxIcOONoBl7C399rMJn6WSwScMOGcIQKooa3DC1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568616; c=relaxed/simple;
	bh=KRtKp3WL0mUuvEo01WZDc0YIx/eAYxHtU1a62l/aZhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7Kw4fzFBVFhT9YDz5BST3gWrazlcd+Bl5fsawzzTaG3NYU4s8ze28c6h18O9QYcYThpqSbx5rfgLGhYJFDXerp1SGipIkAWqRoP/es92gdGPPu049vm3R/Fr763z+AnlNMoGSa3z3KDY9sV1y/RTA5iLKWutOT8U7VvibEqxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/2rJWCV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so10219945a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568613; x=1741173413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRtKp3WL0mUuvEo01WZDc0YIx/eAYxHtU1a62l/aZhw=;
        b=R/2rJWCV1sEJb1V5rynlcwohP+gvny1+jy1/MZ2Voq8BzGHKew27jYNP95IbRo4sOe
         H0tQ5tsIFkJOWOY9XOh313G4cFo8iLhSdOFwi+k970MswjdxKFAjqGDwi0Z1c/zeDDFi
         N3xQmjkXGLTxnZmADk4xi1dxq3lz67psu+daM+wkg5rvklOV6Y4wV0cNTfT7qoM1HDfS
         Qbm5EwLUF7Vm1xEWhgJCmiLcbk4/+6woTYSMGAtAqCDDmp3VXCyDxvEUDkf3Oz/ahvJP
         9K6uLnDSQ8INyy14shs+MdJTL7eQGF1s9QcFhqCRh2RV2coIzkFSuGTouDh1Pt2TH0hT
         pLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568613; x=1741173413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRtKp3WL0mUuvEo01WZDc0YIx/eAYxHtU1a62l/aZhw=;
        b=CXf1ML+MHHo359HyM035+w9UkUSl4g1lxMfr9ZpEBSgCmeXYB8C8LqdYItt46VWTBd
         JifCmX7gaW+zlwZ9iyoycRzjTZceuppNrRHNFnZe/k7GEmpuSh3+Kk2PzUNG44AOPkf4
         ia8Yu5lGdKQ4GJOXcrGwznJnM3Sb8AO26wUgnOTs9CCSnE63aNeG5+0ESFOeawUBtUF6
         YNqcVs/z5azSpSSFu8ViHguu38px61yJbXWaKLOVvmoCmJpyXLi71dI1f556OKeY3G1R
         jB2MCA/PcrUkBmK3CaiJFCjGFyMjYXBHLB+/2Qo8MYkLNTmbLGIpp1syxdVlTU6wAWOK
         LY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUijKoCgB+HzS6EX65V8BOB/e75z5f0d2rCiGs8sDIVGEqZGcaUS4EN4sgDxYFXRagIfs2idYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/w5RZGoWZ+mFRpxVtP300FVexJO5AgfsKiLGi3eSr4nlXi9f
	MLQ8fLTWxwoNvqQJZtfJkgAiAmsmulX+ySyekTa9Cr7AnYUMIN6wuBzKNaafHbgX5T42ecqErmu
	gEyLcgFuTlOoOKVpwqpDk71bJOhhuNf15ubaz
X-Gm-Gg: ASbGncuzfP7abfQINdT8jpxS5S1XZXQIDH8XDzpCxSNECiRmi6uAScyQhzCucyvPtdA
	WPtnd3Q4Q/ba049IzoslPtfZnR7HrxQ33ee/gfjPHpZxQub9i3T08ZkcCgtgWryADVHN7QXmODp
	zcS34PcN4=
X-Google-Smtp-Source: AGHT+IE+wYgejaUlz3NoOC8oEoO31UtyOBiY30LE3QZPYjvNWT+8ceSvRQ4xI9uYoGc8LLQVRyBhUGGoO430SfFDSJ0=
X-Received: by 2002:a05:6402:27d1:b0:5e0:68df:4fc1 with SMTP id
 4fb4d7f45d1cf-5e4a0d72331mr2926211a12.10.1740568612656; Wed, 26 Feb 2025
 03:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-7-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:16:41 +0100
X-Gm-Features: AQ5f1JpO3wA2O5sz-ocjX2lfnRc8G_JsZzQSIFDW5XnyfEHijvokCfDJFdLCDy4
Message-ID: <CANn89iLzk1q8WQ78nmnc3uV2WN9NvKSWT+yg3V3dq4CW31_YDg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 06/12] ipv4: fib: Remove fib_info_hash_size.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will allocate the fib_info hash tables per netns.
>
> There are 5 global variables for fib_info hash tables:
> fib_info_hash, fib_info_laddrhash, fib_info_hash_size,
> fib_info_hash_bits, fib_info_cnt.
>
> However, fib_info_laddrhash and fib_info_hash_size can be
> easily calculated from fib_info_hash and fib_info_hash_bits.
>
> Let's remove fib_info_hash_size and use (1 << fib_info_hash_bits)
> instead.
>
> Now we need not pass the new hash table size to fib_info_hash_move().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

