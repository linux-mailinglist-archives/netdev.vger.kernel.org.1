Return-Path: <netdev+bounces-202131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F47AAEC5E4
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 10:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E3B17C4FE
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D78A224B00;
	Sat, 28 Jun 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B08+/v2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9349222584
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751100303; cv=none; b=YKKWYWylyHU3iHURPs+r218f5gJX5CarFZOpEFDTfq26dG8q8XiOQn6+HFYi3vv2UnWb98CEc5p2UrrfZlGPimASCnR41EIltUQUadlDY+vSoZIm8Zcpz8ya+bQbiF5N+IkQzrSvrEKYRvoP4PupTDt6eUTLkVrFa3AYsPO1Ev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751100303; c=relaxed/simple;
	bh=f3o9OoZUEbBDeBbUxOB3GnLGKqZpAG8HFhx3v3nlo/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xhzly47OYXF+LjSY17l09LX/ffdvvJkjiRR2cfpOcahr8RM23Fx+Ssr17d7EEnCPhZMv+vxNWcm2ouWPvlp8PL3FLZlhU+VFRQj+LHIkFDtMSMACUDiR6M+3fJjw/qGAb4xPEDIFCLYRlD/PMysCBBZQbgIGQt2yfB/UGVCKXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B08+/v2f; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a6f3f88613so5798011cf.1
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751100301; x=1751705101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nmnfrusCNXdjpYHJ43O4MY52XtsNNDAe7B32gXZR/A=;
        b=B08+/v2fGg+9DMi96O5lWHnkIwL9hBfG/wZVW11A3dfylVQAL7PBgRCbPFXewsYolW
         TBOPcyswj4KZIA3xmvaUE3mScm81a1s1Xg3IkUvcShQSgi10WLhImnOKPbKQP+0c9kN+
         NA/19wHB6OkvJYnmEH1Olmu3rsHPSbCsOxJ2dYdPWM8IO9p3NLF6phfpO1TjYKiR9qlz
         Gf6JBgLNnYVnsO1okmSa9xLVtEOOG4yMg/tn7QMq2oixJch0oRuiagCEDZEuvLUW5NbU
         8Ik5rbUzyAbfojkRH2WYm+HS8X6Zq8+dWOr36Gslq5o8wuN4aPC8wZNS9xW0OVoTo9W+
         zQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751100301; x=1751705101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nmnfrusCNXdjpYHJ43O4MY52XtsNNDAe7B32gXZR/A=;
        b=qWnFczXqEApA1DKMWvxI7MnCFC31Va28nMXUpc8t8n6ALudd11lFl3nDDwDYGQOrH4
         f69yQeDAf5NefGowh8o0+vCNknvFaDzFYL0p+bZcHxGnkIgAcGgsXSScd5HLjoM32rpb
         ym5O7IAwe6Rz0b1pIO1JlmyZJTW1UytUglVtKFCSCHTlW9037f7afu94A/XAr5/I+RV4
         XhhbLgFhO0bG+sFV4A+jcxaAVqR2bbDrVJh1C+KabLJ/lvscERvWCkDAIGzpLZ1ZevDD
         Y6IGmqxM09VL4JLj7xHqj7Di9ajQcMzCBzLrNUADYQ4HJbcI3ha42NDetgETEfYrFYK/
         mxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYF6g38Z6gH3imW1d4apoTyW73ghPt7fIXZjNaFp2kq3V+r17JTWReAK/R2OwC5Sb3QYSLmU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRTNlnUwAOoLGxaP3yRlEWinMvr7vCN5DXFler0CLQO94Tt4L
	Dos3BkS+/+JwHf4azldKNs6KO2cxY6xaUYHxIGpx32inOJRj8ATo5aG70hF4ly4YsShBTWFG5AN
	kze96Xy/qzebgIC7OYUWG+7+WDnUnX2OBllaVlmQs
X-Gm-Gg: ASbGncutKw7/eFc3uGwLpTJA2UGO21i3rDkI0mMAzYCW+sOGYeEezdwQ7OR/2kSI1yN
	R35lBpc9FPvms+sxxysGmUX+7xIY+U+/0gf9FfUfwkH4QfEshcvFDeRII8il2DZCC2ZmYlNUpjy
	47ejIqR59WndZZdRzdEyWiwdgBgwvrkxS8SjFK0giaMU4E
X-Google-Smtp-Source: AGHT+IEOmVnyFajIJ8a0GhgPX2/JYD/n70Gv15+Urivpy9ZmnV3HQI05bvkqKXfOyYfw16w5ldtEaRL1UFR0A99MQpw=
X-Received: by 2002:a05:622a:1a27:b0:494:993d:ec2f with SMTP id
 d75a77b69052e-4a7fcab93bcmr96209851cf.12.1751100300350; Sat, 28 Jun 2025
 01:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626083512.GT1562@horms.kernel.org> <20250628081918.523857-1-malayarout91@gmail.com>
In-Reply-To: <20250628081918.523857-1-malayarout91@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Jun 2025 01:44:49 -0700
X-Gm-Features: Ac12FXx7HbqsaSi67Ecn8j0W_HA9gHLw_rRrRWO3BQVTSD-WwmLZmje0U1gXKqQ
Message-ID: <CANn89iJUz2EXu_h-YbiNswixHo6z1EwcmQrfSk6o-MmBznWfWA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: net: fix resource leak in napi_id_helper.c
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: horms@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 1:19=E2=80=AFAM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Resolve minor resource leaks reported by cppcheck in napi_id_helper.c
>
> cppcheck output before this patch:
> tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resourc=
e leak: server [resourceLeak]
> tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resourc=
e leak: server [resourceLeak]
>
> cppcheck output after this patch:
> No resource leaks found
>
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  .../selftests/drivers/net/napi_id_helper.c    | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools=
/testing/selftests/drivers/net/napi_id_helper.c
> index eecd610c2109..47dd3291bd55 100644
> --- a/tools/testing/selftests/drivers/net/napi_id_helper.c
> +++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
> @@ -34,7 +34,7 @@ int main(int argc, char *argv[])
>
>         if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt=
))) {
>                 perror("setsockopt");
> -               return 1;
> +               goto failure;

client variable is uninitialized at this point.

