Return-Path: <netdev+bounces-166550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB6A366DA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADBE18956D9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9111946DF;
	Fri, 14 Feb 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pw0aiNyX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786719066D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564864; cv=none; b=cz+eqx/pJ/H8VJL63bavPMPB3SDUgI//c44TCsf99BI9VE5/LQfn9dRiDLfgjudKDKpzH+wuTZVUeEGkzECuVKAM2JQBKHPRq0ULTS5tDViECd4EC4ADDj/eKVsuScr6zDDltQ7Jb0LtJhveb8yu/sDnl/SAmYWkqGlRSCno/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564864; c=relaxed/simple;
	bh=VCPU6tMeRzNjqLOnb1S+RgcD5SzVpg4aXx7T0M9Wh9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ4h+NuGg5bH7PVOJT8OTdOzgh1Z0pQiz2FmJLDsU5KDAJG1J9ygpsu1icwDR9+Cf4yIPd5ZVIpcXhcmz3i7qXdBbuKOCoWq6nXpTl0UZfKA4s7hbm2I4QI49p/Sbvn2yFWOvj/U3sExEESyHjDufuz0OHNXYnYr2vhoQMRc53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pw0aiNyX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e0575f5bso31335ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739564862; x=1740169662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwpA/RMhjV7JsKTomzzIW0f4b0sDBr3whrocPzfdNs4=;
        b=pw0aiNyXbdXdmVA7r311YlnfO2JjDwsV4MYacXGvKv0D5Gp40Dw6q4oMnW/jFEaY1n
         /XnJJU18a3rZ4HttrzPy3T6+kVAHSVvfygVD8JYMMs4hOM5TcUo0aJz6GnfjnHy2Y2Q5
         bjfSP/0qTiSNZ7u9muNp+GYtluFD1qOtRO72kDosAXaWpWoOfNSwOFjOOnR8bV5wXGLC
         WKnxTKrIwzPV5pTLk13V4hHnan8AdzpfunA6sdYVP/Y0NLbhvKnArNt86YGAiBuvom83
         AiCZvCvkvU7DwYF7fqzW36bc9k23gGRp7teiTTfwYohBy+5rLzVG23tCzsFSvX90gvBS
         Tq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739564862; x=1740169662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwpA/RMhjV7JsKTomzzIW0f4b0sDBr3whrocPzfdNs4=;
        b=YVTBeDXZwJhmIVHE/gcJywpWD2SpXavXUJNpjsYh4TjuRvuMdF6WfiqhPrgYWd6h02
         1JCuGpRcPul5EJiBqmiVm/0lVj3hZQB7gkQi6PiAaFCN9zrP0F+j5ac1GJFRgLjtfLvj
         mqSOz1KwMG8JxDTM20Xjz3UURZJu2SaB+wRI941mInZP1r8zSWGsRJ8AzoTf6mKFd/5/
         1l9oAAU5PBtj43DiyHn9C4NIYHZJjqm9IgOvYzaogdVGlAxd0s76uzYqUYl+zcEOTTkM
         XZOrU9ea/xKEjcmtFqnZxdRGMBt5eOXQ4S+1RWTN3vASrv6ko5SZNLn6lfjinQrT0rce
         tFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2492KRVYJf7mOzy/BzxsmbIC9toRllJFx26/Pse6rmhA1qXhOrPhoNS9hSr00wOlZ5g4BTsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcUDENjqc4MY/YnvlyCycMU6LwbHCtBZhTA4B7RESIy675C4i
	8+Ynm0I2XNO5TsyJ9l7giTsFG2NEUCFRDE+c2+uAN0BKgiIZQdJo0/E58L36nvvl/aOSX7d9DQZ
	eyGVyv1N3oudhBXl9EhaFis5ExQHzflyY3JQv
X-Gm-Gg: ASbGncusqodaji8h62A9KolcT2zEABw47nzA2JLZYQElZ/+eEJKjDkVw3N5/vJdCboM
	LYjHy6+Wscjv3a23oj4qEpjOfMSS0U7xqxWbZ2JfTaA8SIhyUavBsFx1XAryorzNdQKKXoi9r9z
	R+NxD6eOUgQvUVm+5Hyk3TjqKjySY=
X-Google-Smtp-Source: AGHT+IFS67FbZudHmMog/UO28ez8+7+Y4vL9x2r2hA7/iScXyRXEqYji14tYFulYCn7jQdrsPGGK5UXy34+egNU4Gm0=
X-Received: by 2002:a17:903:278b:b0:216:27f5:9dd7 with SMTP id
 d9443c01a7336-22104ed8d42mr270375ad.11.1739564861804; Fri, 14 Feb 2025
 12:27:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214064250.85987-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250214064250.85987-1-kerneljasonxing@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 14 Feb 2025 12:27:28 -0800
X-Gm-Features: AWEUYZmEEHnDP7LW-1MgZaR5Lnnblh5_r-XsOqK0jytepsCcVpfmJgHLHSgfMIw
Message-ID: <CAHS8izOcLnt3SXzfbSA_vqno0R1SaBbXq-U8_LtRv64Bj7tUSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> We noticed the kworker in page_pool_release_retry() was waken
> up repeatedly and infinitely in production because of the
> buggy driver causing the inflight less than 0 and warning
> us in page_pool_inflight()[1].
>
> Since the inflight value goes negative, it means we should
> not expect the whole page_pool to get back to work normally.
>
> This patch mitigates the adverse effect by not rescheduling
> the kworker when detecting the inflight negative in
> page_pool_release_retry().
>
> [1]
> [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> ...
> [Mon Feb 10 20:36:11 2025] Call Trace:
> [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> Note: before this patch, the above calltrace would flood the
> dmesg due to repeated reschedule of release_dw kworker.
>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks Jason,

Reviewed-by: Mina Almasry <almasrymina@google.com>

When you find the root cause of the driver bug, if you can think of
ways to catch it sooner in the page_pool or prevent drivers from
triggering it, please do consider sending improvements upstream.
Thanks!

--=20
Thanks,
Mina

