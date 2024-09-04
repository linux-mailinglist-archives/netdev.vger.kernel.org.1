Return-Path: <netdev+bounces-125097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA696BDF0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE61F23022
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039A1DA638;
	Wed,  4 Sep 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A11/46Zl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AB1DA10D
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455215; cv=none; b=brmvgT/idZQMztwrmbV6Hqomna1y3t/THMEyApzDV2yIlnOdLzNANnmsxwK3dmTDSPyeuAIkaQR/fXevAR9pI6lQ3jxpibvizSRwUBgVkH3vM872tV85vr0jmi2Vl077CQCf41DTOXMJToFOuiyTtI2UoXc3FtbMZeqPHp4oZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455215; c=relaxed/simple;
	bh=0OI3/OPJE3n5hFkiQApeZb/Tc/XFcDs74SQFEl7XEWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drLsjzaDn45fjhGMP1j+b6NtivtqvTmt0DQieIZ9xDxujBI9OggUCK8Qf57tUiJjA41FO6k9EUg4M++apro7SpPNT48MKgm8CA6z3gxdHxCHsjGt4QRbWBUxPQSKZnRzO8CThP0RE1kAQ8K9e9OwFBaGlKUv7LVfMGnAfW45qJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A11/46Zl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so3686400a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725455211; x=1726060011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OI3/OPJE3n5hFkiQApeZb/Tc/XFcDs74SQFEl7XEWM=;
        b=A11/46ZlKkz/95mNpA6guHL14Yk6SRP5AAmvBlxSaTKGnKkrfZ/4/ri7pLHqMuSkfN
         9bNgpcivxK4H3USQwN4eqySfP0F1RRNBN5pJwRB4ayrD6Edg7Nwk+mdXv+ayNeyvrAy1
         QPAJUG6NBBzb2aHEnjugsvhLBEhP+5v9AgJUj8sMwGG4DVvDXLyeqDgmjfvzD9ht3oAO
         WC2jzhw2cqnQ4FB9pVzp5MUODwSJ9puqUhlOTl1HFYfgQaLVvQ6no5ETqtCdkUL692F1
         HvA4dKCw7l2EyUNSKw71igkqWFnZ79nQWxJmrHO29Z/dmmDqup9N2wG93yagVeLhStjh
         sUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455211; x=1726060011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OI3/OPJE3n5hFkiQApeZb/Tc/XFcDs74SQFEl7XEWM=;
        b=tuaAunmBDjmuq0lpodlPEgrx7ncOozdG6YYbx3al0lzwsRmpi5rvEDR2x9vfCTMUOf
         DseOqCxpWTpfpdSWrRN7FZk1V7PZ3BhLy9JEYG5qNoIu+Tqj8xYGxrsWGvTZ2gvdz8xK
         C9NmsintHoKhdTgRavKEOrRDQUyZhb/dwMOaYuzzOxRrPX+lsCDC6+PTpoNB6X2qGEI0
         5vRy5Tso+8GabMkcBkMQKxyKNX/ZaYjYX7kOrTO0zJZBzLGsErxb+bYDj1D2EjFtywrW
         LTsk3rj3McfLbIaOBaGRA+6BbtCsqYk3wdvmpJlPc/BuHNgiwm2hoYmmCvyoh1Qa295H
         xIbg==
X-Forwarded-Encrypted: i=1; AJvYcCXA/mWWlgcxKBbJxhChx6fxpIa2nDLfKKVGyWRvqdE1KORWoYnV2BdD6BP3V/s31Tg6knwI+Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9ZVrsNGi1qnrcmLfZwnOg+jSjCvEMAWpCLsLbjIe0St1vyO5
	JT1KnsZX2aoZM/GgQEoBhtZ5cQ8d1f91KzaGGjHBr0zjSSNweYktD8/S8UWEyvAX5id63JToAcO
	WepS1JmPr+PSwvfVDIOThg3x4rHcITtpb4re3
X-Google-Smtp-Source: AGHT+IHn22ssXGW0yF7W9DrfoEIn7rM9xJ97Zc9egCpo1ER3mrV/IPOElhJVd80kL2WB7ZM5FZIBkfoGxF6mwE/00eQ=
X-Received: by 2002:a05:6402:d08:b0:5c2:1803:ac65 with SMTP id
 4fb4d7f45d1cf-5c21ed54d08mr19008148a12.21.1725455210156; Wed, 04 Sep 2024
 06:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
In-Reply-To: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 15:06:35 +0200
Message-ID: <CANn89iLe9vdyOSknQNqhpm4Ehibziq5oBMn_yOJ4cFBHdZjTxA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: enable bind tests
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Joanne Koong <joannelkoong@gmail.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:12=E2=80=AFAM Jamie Bainbridge
<jamie.bainbridge@gmail.com> wrote:
>
> bind_wildcard is compiled but not run, bind_timewait is not compiled.
>
> These two tests complete in a very short time, use the test harness
> properly, and seem reasonable to enable.
>
> The author of the tests confirmed via email that these were
> intended to be run.
>
> Enable these two tests.
>
> Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
> Fixes: 2c042e8e54ef ("tcp: Add selftest for bind() and TIME_WAIT.")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

