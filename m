Return-Path: <netdev+bounces-110201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7892B45A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174FC1F22E22
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056B15573A;
	Tue,  9 Jul 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fLhRrTag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B1156220
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518525; cv=none; b=bY3iChGfpHZ3fASdoHCNwYj1VACIyvIJz7yuDi24/eZ8Kqo1t90GG0LWrvJlNWxoKtoSo1TEVQuzZyqvRnC8rS6miFoev+lPf3r3CLu2lYQ4r7blC0cSctvLk3mRq6oAAoeZuDDmD1KIOdJ/FWTlEBU5EgkbcWV3zBUqtKWilvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518525; c=relaxed/simple;
	bh=Y/XBv0dj0yaw8j4TaNYEP9A7Ddp+e7sTRck2NCfQRJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eDqOqKI9aXn5UyQRhEcIIQvFNrniC4LnLvgQ4erYHmKjryRug9IQ2GmXtuGJ5jJxru72W0JGr24QBPvJYexOHcnTIv2S8BacaTZDuPP00PetSMY6Rp5gfu3qw8Zj4box9B5/M1bBKHFXEa/PLcjQNtxdMEXb3dE3QvnmrBAoQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fLhRrTag; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso6009085a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720518521; x=1721123321; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/XBv0dj0yaw8j4TaNYEP9A7Ddp+e7sTRck2NCfQRJg=;
        b=fLhRrTag83tm3yCfuYEGZD7lnaNp2hbIRV2nWwLDSHSsAWjI+9IhXnVYkaIwv+529a
         ryA5Hg5RS8HafWCv9r/Zg3AbN1Cnk0jIHuKulGx4RTyaQT+pJxmFAoxoWPANEo14VTy7
         kzBFysFytMfRlIO8culCakWotSA28sg+psJJSAIlANI35X1XHZJTT3lwNGLOcjHmbELG
         py4mwZrzn14tYxmGohGR25boXpeQMZqtC62gUN1OFvNSAE4W20F0B2sV6z8wO6CDC/gE
         bSEcxcNIAL+ySMZnelKjVmcW3w3zNv8WiKqcHi2bwRyAWc95eP+A0uJkoykioUd5kFuO
         9w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518521; x=1721123321;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/XBv0dj0yaw8j4TaNYEP9A7Ddp+e7sTRck2NCfQRJg=;
        b=XFOX1xf8rGaGQArfgYrHmiYmV0R7izezx50zby79fcE+uR4Pfy2KKfQwX7M/1+exDe
         iMI5p16LYR6LwttH0RUbnKa7K/84yRqWvG8zvUpZWJ89ktOdL0em1t1Dijh9i/eIpz+p
         lS3mnsd8OM1Jlvdn52bMe8/UvfZbEFnDCEVDdeFoMXmdKUN+HTJVt4JaGpCFUGTJlmD2
         mnOLzLZSIzrWBzL6MNIBSO1KXpwNOyZLeomb9JkSjoRTdxpiS+93/9N6VQvlkF6lsHfP
         eyi7/Nc/fNmUOGbwX5dFJELOm/n2yRxZh38qMzDIh9JF6JsxfvhdKDnO0Q8Cwi3/5v4m
         roEw==
X-Gm-Message-State: AOJu0YzwQOQXdJPR03dwzyUET2MNCVngCNl/sS/2Cu49HleqX4D6ebNC
	oSszZN/PrCJkLr9cfQ5ZQVfL/85mkbJ8/UrSyjz5wRGNv503sGFwrzjHnU4Xv/VI+Dvh0RgioJP
	DElo=
X-Google-Smtp-Source: AGHT+IFa7TjPN5lLimFPbNL0GxxV5HjS/WosDVCQgAAFjft33oGxiL6FlKbOeWJKQbKNjUuLnSqBaA==
X-Received: by 2002:a17:906:f756:b0:a77:cbe5:413f with SMTP id a640c23a62f3a-a780b68a3fbmr138258366b.4.1720518520664;
        Tue, 09 Jul 2024 02:48:40 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a72ff52sm63874766b.97.2024.07.09.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:48:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <20240707222842.4119416-3-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 7 Jul 2024 23:28:23 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 09 Jul 2024 11:48:38 +0200
Message-ID: <87zfqqnbex.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 07, 2024 at 11:28 PM +02, Michal Luczaj wrote:
> Function ignores the AF_INET socket type argument, SOCK_DGRAM is hardcoded.
> Fix to respect the argument provided.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Thanks for the fixup.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

