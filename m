Return-Path: <netdev+bounces-198924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58517ADE54B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082F3172D56
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F742475E8;
	Wed, 18 Jun 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOT+isn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44152239561
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234278; cv=none; b=UN4B333RKo6n6IW6TE1zuBOjCmX9nBp/qb0b3HarilljYjBxX0QaFbAt6hHXtEwV11wdJ8xkkgFD50Oz6hX/eomGbFDOBgp9u7MpKHBqEn+EpTt64gGW6mdVxJ0FtSUU+cQg/A0K2s1/8pbpY34ZTV+J0pnjXVwG6HGb837hmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234278; c=relaxed/simple;
	bh=9rbLfolEq79cZpI6Y0ZGuR9bPO+JcRO7D0YcIOXcQiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK9Re2oGuSrtlaJZd0j84Js+xGYk7/HzvlY6w0ilIZsF/gDkS8togf36Ae/JL9WK8jQ1IQRNwq4+bd7eRR++no8Qd56+BRXBog2yu0ysAyGOEk3qx14fyt+nKLePShSgobcue5Iyuzm0nwd+XlJJJrBixvkqxsqvo9tfujWaGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOT+isn9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d38d1eae03so625629085a.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750234276; x=1750839076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rbLfolEq79cZpI6Y0ZGuR9bPO+JcRO7D0YcIOXcQiM=;
        b=UOT+isn9OjKwB6yCamiscTEkQUTnn2/8ZKFLA7DGno5gNqZRUJlI50emkrFGyg159E
         wi7V42r/gF6ypEwVe+slx+C9fLhfDuvUL/NjTrKlqqnVtTEbLuCRiycV5MCh5dQLX0I4
         lHih5zIiaSD4PJ8y9gpCZzug5680U2g8z9SqlhvK7cIsy8yzwihpUh0UgWnYNQZOK8Cj
         dvZkgxRDE4eFoil47YNn2hkP5CSYHeiqZtQkc2nEuUFJtukndxlfJQMV8NotXxRB8pXf
         6L8gJO8tA1a9bB0kFnKjO+7MDpbuyarITr08tnrPvDIFN3UkFj5pLoyrDRME14vuwiQA
         22Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750234276; x=1750839076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rbLfolEq79cZpI6Y0ZGuR9bPO+JcRO7D0YcIOXcQiM=;
        b=ZI7YVoqk7k1DKkjWc9usYCRPjzLy5mInpooYexi2V2fscpzKGEngV9qiJUvpvzSBRf
         vqoaghTgsv3XHdYvnTR0IZz7qv4IX/CUlfK4UDXDdFkToOtL1RUj3qk6B1brX9ugRwuY
         QKwSpoyIwGNwjn+DqM5nFj70lrxjBHKUjSLMXPeuCw7WqtUl3STkU3mVaRQtVqd/boH9
         ia8c1u6+z/1rKG9i+Z0ZAMPPw1nX59n8pkaoXuIwptZlqEhQ4YGe2jVXu87tfb1vMxkv
         XzbKkRwcaJ/C8RFT5xnk8J7Lx5+fMwPAFW5KA/RjVbWtlzG+69O9/d/lWHzBWKJ6Ft9W
         vxDw==
X-Forwarded-Encrypted: i=1; AJvYcCUu+Lw+7SUSHVp7nczgSDKrEQnQEvbpx8w6p1w+vpDr24T9duHJ4UwPdABl3lth+y8ln0Fob9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHxDZ2AecDQ8X3hOfAuuaibutBIDzZBshOUP7rXzSFxmuz1bu
	rRUHz/3jODLFO7XjPtFpxBmHBmkGMQN2fXBGWovAXhnpQNcPkEb1FY78bUsArLfsZzmOam0XLZh
	pYRaCfp4Oeef6KW57A1frePw6qoKneK6nMtTS+b3A
X-Gm-Gg: ASbGnctuNBYA6vfsOtXbapYcIBghyTo+km1Y+TTtAnySIu3e13870d1jgZRV4jakGZk
	2Ak4QfdNLcISwdQlTrRkxI3y2za8zuwrL+EXE0HLBMDH0HH4GBDbWucdwzg8fG3R8F/EEoRxliU
	IrboBR5m3iwNG8uObLBtbRtjGGYMJRsdofT6lvzV/V7Ls=
X-Google-Smtp-Source: AGHT+IEuPch1Q0k4bdYVmukaJi3eJ6ma/n7M61TrctJCvnwEq7zcLAVDkmk5MWcRSuX/9QdEz5iDZ6MAv95TTG/pcuM=
X-Received: by 2002:a05:620a:444a:b0:7ce:c471:2b8e with SMTP id
 af79cd13be357-7d3c6c0c744mr2237140585a.10.1750234275768; Wed, 18 Jun 2025
 01:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617212102.175711-5-dw@davidwei.uk> <20250617212952.1914360-1-kuni1840@gmail.com>
In-Reply-To: <20250617212952.1914360-1-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Jun 2025 01:11:04 -0700
X-Gm-Features: AX0GCFvgB3HUWv6wogxU74l7Y1HN-Pl9sllgQB9ZbL_KfGGm4M3rZNiGNOoE2k4
Message-ID: <CANn89iLzzgk=kWrR8vE6K5_o3RabRQf9dcCGeFYrwa7Os8MS0g@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] tcp: fix passive TFO socket having invalid
 NAPI ID
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: dw@davidwei.uk, andrew+netdev@lunn.ch, davem@davemloft.net, 
	dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:29=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: David Wei <dw@davidwei.uk>
> Date: Tue, 17 Jun 2025 14:21:02 -0700
> > There is a bug with passive TFO sockets returning an invalid NAPI ID 0
> > from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
> > receive relies on a correct NAPI ID to process sockets on the right
> > queue.
> >
> > Fix by adding a sk_mark_napi_id_set().
> >
> > Fixes: e5907459ce7e ("tcp: Record Rx hash and NAPI ID in tcp_child_proc=
ess")
> > Signed-off-by: David Wei <dw@davidwei.uk>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

