Return-Path: <netdev+bounces-206768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13FB0451D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB7172FA4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7425F7BF;
	Mon, 14 Jul 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9y+30kg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F925E816
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509483; cv=none; b=sRJSgUws5zv935UW1YNsk9spnzhidmm9PCyncJ4bTM5KQrtuVDOEgcmLSGAnWvCWL6l42C4fD8SyIE1tsgDAMamyIVPWT+HD1Avc76GDvZyZ61zFWuvdl705xn6kQQlIn2KTBhZKnt0y0mcL1/FZejDGP2HjmFLmz8N4VAzucTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509483; c=relaxed/simple;
	bh=vQjKQqQj7/0FRocDtrqvFlkmdQNJcoyjkB7/v8vcPLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaHw7ltk8mpzTL0hkCjo+OtnkYjBD09TA4TqtuD3GbvAjWCKmMDynwW4PNd2GFwQHqu/2ocB/CfDOjQof70fzstQUDbarp5+Y0T8LdJ4l33r1n28vbntmtNRtW3stFKOMlVKDc5V1KR52KJ3axw0K8VmwOMuTsYGjcrOa5MBRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9y+30kg; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso4395912a91.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752509481; x=1753114281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TfSgDJeBP98iuDTDSKxBCCJTmDXTCi+E40UIkPN7us=;
        b=H9y+30kgZeQQxUjH6/JpblUyTnASYxvo8k91S12fRRhhx6qEDaE5kHbEH5LDjWc4E5
         SVKZDW8nhQDc7buUcZ3Xf1Sc0GQ2HNSXWKdbSixyw/AXYnoIYtHsBCeoU7TD+5n/YKUy
         7feN19M2KYTBNn2rqD74f1wDNZgd4wtWn5g0psc0snCrUnf0DyxGQznq7Fgp/w2fgvem
         AEZNAtQTIKxp7s6/fdlhLlWhHVc2AWxs5hcC1OpCg2Zonru6Mb2tJldLOA7iCvcX8np+
         oV6Zkoq8W/JESfGyKcIzAvZ/YqAM8t2S1YbUhdxDB4UHHjrpsNyhaP5z8Vg1Ii9n6v7X
         rROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509481; x=1753114281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TfSgDJeBP98iuDTDSKxBCCJTmDXTCi+E40UIkPN7us=;
        b=GngqJFbGixDqvSof1P4QdPfWNMkIoXKGwYCql7AXfWVqt1gzQSgIL8CPmK9vads3nq
         gMk4X5iVJO2bDXcGfnPd0HwJCnUBdL24PW+aurB4OrHxmkzJOJRdvodOpmvxv0QX7GnF
         M41a7qaqWjkja9gr6F0BRgZuWYNk3WqzmZ5mwmoO63ubQCkfHBeYE6xlw8prkuEco0OJ
         z6H7S3ZydxDil4TB8YLIqz+iy6xLDsZCfiEto2x9nFImEgYBf71Jh3Ok4qSrIbbZ9d/k
         2H0A/ZI5jeag2tlSar2Rvg55BvnpDwkfNER1CNjsoxWBy3/UWprbdc9aVo/YSL4ttTHJ
         pJEw==
X-Forwarded-Encrypted: i=1; AJvYcCXr2xB26YRzgaOrsrHXMyMJDrX1bRpZ5Yh+ertKOz3MtNWK/9t4Kr9vtpSA/x3JIP9Pib70tyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qNix+fp62DilBMW4smP+vZv2aI/TLTZasvDlQ8wujnnAHfD4
	a9iOXP1ZobH+8RvVaGtYBuKj6WAF+z6vX7UO8i9xQDVaPlNDuS936M8upWlUBslZLSUTeZmWbpJ
	QHyL+fUkSv1EhUyQwnYzypWSdMUk2rQHAPxuYYtyS
X-Gm-Gg: ASbGncvQW0Uvy34PQebu7YBRdA/XRFnv0RMNiXF/meJ31fObZR1M8cnCk2PPpHKg7Um
	TkLdIbAcyNzThiBJOHW309sgcO8JsIWBMoHYs8bvAuZ1ZOlktZmzg126I4MnCtBP3227mJIj+XL
	/r6TZbhXWuncjdfXykcaWhpPNe1K8f8zvPU6oHSSLz+lTd//53/h/iaAOL3/hw9o+COFnpfISEw
	aux9gwiKbBRmugxmRwArVcMcbyNZ1TQZKLN0Q==
X-Google-Smtp-Source: AGHT+IGi1lKzp97hb5nVKjsLp2Yc4PioYfFvtz13TEi2ODa2cHytGcZk5J9zzTFWV8PfG2ePjvzUGLBXY7BkNPMEZRY=
X-Received: by 2002:a17:90b:1d89:b0:31a:b92c:d679 with SMTP id
 98e67ed59e1d1-31c4f5e3054mr18709800a91.35.1752509481220; Mon, 14 Jul 2025
 09:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712054157.GZ1880847@ZenIV> <20250712063901.3761823-1-kuniyu@google.com>
 <20250714-digital-tollwut-82312f134986@brauner> <20250714150412.GF1880847@ZenIV>
In-Reply-To: <20250714150412.GF1880847@ZenIV>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Jul 2025 09:11:09 -0700
X-Gm-Features: Ac12FXxwA2_HHK63FHlPcihHW7Wr9zzuGKYWHs16ti9q29J1bNFJMl70wG0K_mo
Message-ID: <CAAVpQUBK5029mFoajUOYoL3aNTfJg0fqR7FSHViLvt-Ob4u0VA@mail.gmail.com>
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in unix_open_file()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 8:04=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Mon, Jul 14, 2025 at 10:24:11AM +0200, Christian Brauner wrote:
> > On Sat, Jul 12, 2025 at 06:38:33AM +0000, Kuniyuki Iwashima wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > Date: Sat, 12 Jul 2025 06:41:57 +0100
> > > > Once unix_sock ->path is set, we are guaranteed that its ->path wil=
l remain
> > > > unchanged (and pinned) until the socket is closed.  OTOH, dentry_op=
en()
> > > > does not modify the path passed to it.
> > > >
> > > > IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() =
- we
> > > > can just pass it to dentry_open() and be done with that.
> > > >
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > >
> > > Sounds good.  I confirmed vfs_open() copies the passed const path ptr=
.
> > >
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > I can just throw that into the SCM_PIDFD branch?
>
> Fine by me; the thing is, I don't have anything else in the area at the m=
oment
> (and won't until -rc1 - CLASS(get_unused_fd) series will stray there, but
> it's not settled enough yet, so it's definitely the next cycle fodder).
>
> So if you (or netdev folks) already have anything going on in the af_unix=
.c,
> I've no problem with that thing going there.

AFAIK, there's no conflicting changes around unix_open_file() in
net-next, and this is more of vfs stuff, so whichever is fine to me.

