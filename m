Return-Path: <netdev+bounces-64406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E57832F52
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 20:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B471B2145D
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56CE55E4A;
	Fri, 19 Jan 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKEvU2p/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD081E520
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691608; cv=none; b=VDtjxd+mq1wovsOb0Z8QCmw+4BCt9hg7QF2Jknzm9bqhIRUfwxf4pW2mWpfxy6LI3Pme46rgH/iqqCGKlurI/o3gyG44XCX4aSqrlLzV8R3GZF9YcaiSkA/L9+fMVDZh2sKoOePd7PDbV8/JYKcfzOmEwRGp42ZHBrvZlv5xdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691608; c=relaxed/simple;
	bh=SYKpAr56t2j6hX6wQtgOlIhtIZj/0iPcc98VDznfO9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N26McwRm4Gc6S5hDnj69Q33sO314xgZJKx+P/Qa5OdfqukqChBNP809rxDemgtXEEhdSDKL9n5GTJde9H8OWjgqsCXCOy121SHKBhcWA08BoTXR1slYRWSLD+f6S+yBxSXQ2f4FsjqOAKtqR6TdqdB3NXOkF7S1zd/xaie9hz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKEvU2p/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso1463a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 11:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705691605; x=1706296405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYKpAr56t2j6hX6wQtgOlIhtIZj/0iPcc98VDznfO9M=;
        b=gKEvU2p/d+pLI/7/Xc2615w5FHf+5eCNg6NERlv5uYFmV7f5oqB97uLko1AxhAHpen
         95BYXYCR8lIzF1x67vT6zzFFm25JkHZUOeKnR4xjcjAS2Xt7X3rYCLHD2auy9HGIzrHz
         +JKEff9rmman0M7MyPNiTfpV99CHNVzLkEmWHy59Hjw9tzUrgfFrw9WCB607SpzskVV6
         fkbFoeBXFLigTpnGsIl/Olp3XvDT1nIelaoQ6R2io2JMegRmCXVvBu0/l48jzjk5TA1x
         HscA9B4gkDhfKYGZasdQ5x43TEmNK7GivITlNJNIEyK+BM6lPnTQYENNf5eiHBJWKh/G
         8KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691605; x=1706296405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYKpAr56t2j6hX6wQtgOlIhtIZj/0iPcc98VDznfO9M=;
        b=SkMePiBZMPbw41t27F7VMbEKADdHjwzVx1qBHgCyjnydrgj5qa1AP7HT3uCaUKKGlt
         zdJszJQ8MlALkq9tR/++O8TK6uxJuK7NEGur7zMBJNUDwP6e8vkRc9EAW4AR40YFyiAk
         Wi6jsDVsAC6JBYcLk32I0B93MGDlcDnSKOQerWrKIVeJnjZvcJ+grAN4zazJchAY5cMa
         RUb3ac8vBbdo+MMznK/JKP7CcmDnEOzQHgUBpId+VAU+HHhMHZqfnbB6yiRHbbttnSm9
         rrBJqknHEWA0BL00BpcWJz8LfKeTRw4N+u8cPUNu1kxJdP1FBgVFYijIoaaYV+MczSrB
         Eqkg==
X-Gm-Message-State: AOJu0YxYEOC1dLl74JuiFqwa1nyIPX6uLouHqkIev0A0GXzpDEKk916o
	L6Y0vs6qB/Ip3CgDqskIaDeRThxTJfPudltTsvcnaK1qe+IHwHHJWP3b54pMjN2FynwKxTkMERW
	4iIa/gP7NPxY96UWQsDXjWc2Vj3Rr3vXauBBw
X-Google-Smtp-Source: AGHT+IHjAqk4NIHU+kSH+eG/dxFXMi83yxRtVgAm481tMcW8nL2z6JYGAZLgh9NAyvP+p5E1azRP6zQZ5Fg1Gtdn9PY=
X-Received: by 2002:a05:6402:228b:b0:55a:47a0:d8ad with SMTP id
 cw11-20020a056402228b00b0055a47a0d8admr16030edb.3.1705691605308; Fri, 19 Jan
 2024 11:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119190133.43698-1-dipiets@amazon.com>
In-Reply-To: <20240119190133.43698-1-dipiets@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Jan 2024 20:13:12 +0100
Message-ID: <CANn89iL8JswXFmEBjNgvhbE9NTXXM1x0Faf8Wpjp+jXQ3eJehA@mail.gmail.com>
Subject: Re: [PATCH v4] tcp: Add memory barrier to tcp_push()
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, blakgeof@amazon.com, 
	alisaidi@amazon.com, benh@amazon.com, dipietro.salvatore@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 8:03=E2=80=AFPM Salvatore Dipietro <dipiets@amazon.=
com> wrote:
>
> On CPUs with weak memory models, reads and updates performed by tcp_push
> to the sk variables can get reordered leaving the socket throttled when
> it should not. The tasklet running tcp_wfree() may also not observe the
> memory updates in time and will skip flushing any packets throttled by
> tcp_push(), delaying the sending. This can pathologically cause 40ms
> extra latency due to bad interactions with delayed acks.
>
> Adding a memory barrier in tcp_push removes the bug, similarly to the
> previous commit bf06200e732d ("tcp: tsq: fix nonagle handling").
> smp_mb__after_atomic() is used to not incur in unnecessary overhead
> on x86 since not affected.
>

> Patch has been also tested on x86 (m7i.2xlarge instance) which it is not
> affected by this issue and the patch doesn't introduce any additional
> delay.
>
> Fixes: 7aa5470c2c09 ("tcp: tsq: move tsq_flags close to sk_wmem_alloc")
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>

SGTM, thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>

