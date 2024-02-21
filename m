Return-Path: <netdev+bounces-73600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C285D53F
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C44528232B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE23C47E;
	Wed, 21 Feb 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wxeXZEhU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4B3D0DA
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510339; cv=none; b=a+f8OIhr39YIZkWHJltERa+8IxOKnxEfB03wAgzCK/6LGDYlwnjCGoHQALxWkUanzwuV9PxNnCSJjvubke6uyMySdvYv2TfIbjhub43/e3NmDoe/O8b0IJbH1N4zoc8OMWA05tz4usDFhFluwvFrETfyluwH8iXECT620pcVsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510339; c=relaxed/simple;
	bh=W7A7g9P0XpDLbE49JRjSseRpYfjrTfCEIbO4y0pInhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU84paHwluM+ImIqrqpNco4/lh6Dob7nmm5hNmfaV9A2qnI8PU2ViRDR6rgr2njb3wqudQeKUFdBTHv3eLmD3s7n1aYG3ZbeVcEqaEkH/TOnt80cJEPqQwS5Z/Py9A+aph9g/TaxiLpG0V8AJSU4BtWjP3U/C8pZmSuUclalLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wxeXZEhU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso6345a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708510335; x=1709115135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7A7g9P0XpDLbE49JRjSseRpYfjrTfCEIbO4y0pInhg=;
        b=wxeXZEhU1HuejEO+v3jqGoWAbd9qBQV5JJ5eiqbJ05H1cF822ThgKKTX7kPkW9XQhm
         6R6FezrOL0ViKNwb0I++tWoOwkPVvxltBngaFDej8bxcsVJF40qElJCBav0W0SuZnU5f
         7rvToP9Z3+j9Fxy+Nas8nV7KGnGsQeCtAacxuAmCY+9PzXCLa1fbIEB4cs95FgVGgsa2
         2iKe0SJYD8ClbT8z64Mu6ur0blq8Hz7SqsTofjg4f7sExARQpc1FObI+lTGb9e8bJmVb
         m3L+zq4F9t6F7Y3ld7voHSDlddOEc9uzg1juk1EpdYGx/D28FukI4ORENB9690GhawdB
         jNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708510335; x=1709115135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7A7g9P0XpDLbE49JRjSseRpYfjrTfCEIbO4y0pInhg=;
        b=pKcUpkHBxwcjutS6mEAiTZLX7vJAaLWsCemeaIVo5VPPGOeWwq4iBMyQzGL7hc++k1
         op7sGt66NfyQvpMr2rKv4WjONZj7oig/RKebW6lPcP0uQ30EkDVgzPHowoL7jmtnthE5
         KhMIta6ThEdd2vMgws6E81XdYglDIAufCqxxPw0rNEK6psAPP0nYzn02e7OVXf7mWKet
         z/n2rD6o/Z9EWynvSWQxF5kOVms5XUL+2NeuZpx4K2nd9qW2K2O94+Ky7AAX96GJSr8j
         NahXVioAk/Cj6OmFIhowbdr/AmPeKrvPkQVCHW1HidxyW3+6es08SxgHc2vL1SgFyRlS
         a8nA==
X-Forwarded-Encrypted: i=1; AJvYcCWjFvWXaZCWiyQnAu/KuNXm6ScZgto4+NiQP2ifhqfQo6JLoge0FJKSnXtXgBAJIsoP00Ku/lCrPg+NuWumBYvG3ZZd1eUv
X-Gm-Message-State: AOJu0Yyd/ipGtS6TowhOEhPxKY6zwhZT5AAlxP4Obyqc7tZC/iLrn73h
	SbeX/3gRc/0zwx9XNzgaegkE7jY54BFgxBoKhlvu/ZXGlhczFt/e8bDAyN2nYAbgfSLfKSA0lYc
	d7dOYGib63x7nRd7SjKks8tmD2BsHZESvvFKQ
X-Google-Smtp-Source: AGHT+IFCJz/EBAo/zjW5U7Y3G2zGTSUjY/KnnsEu3Wtw48y/zUmmLlVXDUbOnPolOU1Ovu9V3pNtBPgeWdpqU/NGoFM=
X-Received: by 2002:a50:bac2:0:b0:563:f48a:aa03 with SMTP id
 x60-20020a50bac2000000b00563f48aaa03mr148458ede.2.1708510335306; Wed, 21 Feb
 2024 02:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-9-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-9-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 11:12:01 +0100
Message-ID: <CANn89iJJ9XTVeC=qbSNUnOhQMAsfBfouc9qUJY7MxgQtYGmB3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/11] tcp: add dropreasons in tcp_rcv_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In this patch, I equipped this function with more dropreasons, but
> it still doesn't work yet, which I will do later.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

