Return-Path: <netdev+bounces-155056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C494A00DAE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC101884AFC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EC31FC7CC;
	Fri,  3 Jan 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrDmrANg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83181FC105
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929323; cv=none; b=f1XMbAnn5ZO/v8KpXux6m6zY5KYH/bnwHbXq3f6B6e4fIN+s+KsL+xH5DXpz31zPyEqOtdUdBPcsH+5aJOH15ibQX8jB/+a3joRBCqqGb8mcoFA3C58sLaDEgOnZV/SDXNj6EaDGMCrlye+tXxErxnnMuAkxMdzFR4cXskq5TnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929323; c=relaxed/simple;
	bh=QaOJp7HJHHdPaRMU0X9pZcayUF+tNiAnvQkPGvNtOFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZc9AF3++mxrk2L3FAyS86Mk0jzRLPXq7+ND5PrCxMleDzG8OIAg3Wnim17SA+2ivwiYNklUXcl/hYTq3WytbtmxCBJbEf1FFmvjXgfSlSM1t340ArN5Ni7FvwsnQ+PHPUUd+1/tzALZb7Q9bCgakCGF8n+NOxFRV8FltjR+HRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrDmrANg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso21970605a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735929320; x=1736534120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaOJp7HJHHdPaRMU0X9pZcayUF+tNiAnvQkPGvNtOFw=;
        b=SrDmrANg7bq7XatCTkHKwPS69xZ5LSrV1dCtFu5IYgNafX308iHdM25dLyTip2Uwo7
         Mk/IAs9mO3qjdu+itm4a4+Crs+egeCV8O6ml77OnLTqDgZv9eqDmVh/Ezjwr7XcE5r9J
         gJJ6HQa2WEzahZb0no3Y+xJKh2bR2slc61RSstB74BccLgROHKw+a+xVGGWOFNmAb9C5
         ywwhbNMcZ7Z/a0hnu6ZZXjIkNzFWLlCpbiiSJYVPz/W5KJ42APre/Saatx4QJE4ogF1P
         WMTc1cQT8MXR1A8azwekDOWa/n9dYUqb52DgpAM62vR0sXl7l+E2SL9S5dd5l8Uzr0xl
         SIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929320; x=1736534120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaOJp7HJHHdPaRMU0X9pZcayUF+tNiAnvQkPGvNtOFw=;
        b=Af0wRmOrB7fEIFU1k7EZzQRSikJHLnPEgDbqIAuw7ivHE1UuLWQTDqyRWtiK/6dhUH
         BGPGUqBZ2zkEg8Sb6tYCPZdjkbiof7ReSYybGjZ3iJVJgGwDY+MBa/zbbv/dd46T16WK
         s02zUwvAKu66e06+XM1BPiY5uaYOdeW7SaO8ymv4K2K0j0lAAYj/EDVUB32u2U5DS2bN
         96cT6GtbB+jmlWa8p8SdNPJSt7CJS9ID9jJ+uMgswBXoS+tKtzd/jwb83mEhLi2ICWKb
         1BRD6Sv1xB2gEjlkn9DH74nq9hVV9yEodzi2IdLl6/WinzQw3RyDkBLJrpPOQVuqSRnt
         l/Iw==
X-Gm-Message-State: AOJu0YxnkY7rFskGb/rcJp44oy+pCrU0bAq++ICDjVy26tqj/ZAj681R
	OoG0L3tygdd4BTck+ISCns+6K7dZHXd+2Qgo6WGDQnIo5h9eqMj27xkqAUjuh81egIrncJCJ+4j
	VjhNxCLNFTVCe49EJBCUzejfN2QSOcm+SULxhMrjBXrzsEPOFlg==
X-Gm-Gg: ASbGncuwPDP2Oie3ORKgvHji3ou5bIT66yoFKHuuQUNz3GlGLCtzfrlRSxfGHBom7Rz
	CtDXYXXzrlQ+4g+3QV1971xaRCeI4PJyhHRW8lA==
X-Google-Smtp-Source: AGHT+IFb9aRY0DVrCM919IVThtD+cuQpRatmwe2KgRjXI1yw5UOYd+sHnm4XRiC0Xok2nGQctE2vtiWzgpKQdzLC68I=
X-Received: by 2002:a05:6402:268c:b0:5d0:d2b1:6831 with SMTP id
 4fb4d7f45d1cf-5d81e8c1309mr47104018a12.14.1735929319710; Fri, 03 Jan 2025
 10:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103104546.3714168-1-edumazet@google.com> <20250103182458.1213486-1-kuba@kernel.org>
In-Reply-To: <20250103182458.1213486-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 19:35:08 +0100
Message-ID: <CANn89i+oLRQmAeXq9wCfg6E3-_dEZRJtd1tn4W1OxpcKnwFefA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: tc-testing: reduce rshift value
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shuah@kernel.org, karansanghvi98@gmail.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 7:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> After previous change rshift >=3D 32 is no longer allowed.
> Modify the test to use 31, the test doesn't seem to send
> any traffic so the exact value shouldn't matter.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

