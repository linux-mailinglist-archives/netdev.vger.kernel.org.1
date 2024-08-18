Return-Path: <netdev+bounces-119471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633B955CD6
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A4E1C2096F
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11E6433A7;
	Sun, 18 Aug 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIoLa2DG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF879CC
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723989089; cv=none; b=R0JJdLYuHcnyV12+axMn4loB5cNlk27FKi70CWYf0/y573ln8HlTfMOskUjy6d66ymCT+gUfC+qQCTw+4oV17KYA464qGu+a1GUy9EbXEjhCUJhiDDJku+v1VxpU7DU92Wh67md/YaERa708xIlUbfST0JpyxowVUmrK9hpcQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723989089; c=relaxed/simple;
	bh=9Q6VfKsYZU9R6H4Fyh1aIHkkK4pzeyEreNylsFbQ6B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqY6zOrnZlhhcG1AmQrXPDv4tdhYz6Trusg88YgifFiaq30aiBLslZZcSZCFvh/+3xCGsNfxXb/4hpU9uY+3McFHao1wjzohM8zE3K/meZHtnq7Td4j1TOb3cauyaqcp9rKA7gD8ObaVrvDoiDpFT+CsWeOt10N12GkjrGXJSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIoLa2DG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d4161c398so3097385ab.3
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723989087; x=1724593887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkaT9Dcg0giRaD+ufjXGaXO64H/vMXoT5vBuRlnXRp4=;
        b=cIoLa2DGPWrcNsWrJFQ4HFEIzUfiRj0Ngy9JHoJ7qk3OdrmfTwq7rpy/MLUno1OKzl
         oTBGM9mXDzuyw+177rSoQD1cQW6JvchZhUIsxlXIJQX0wOyAgHIRNkJKCX/V3dTSueaU
         4DZXxb9NHJ3vr5yM6WRNm26IrGp7feg5lELGnuwtQ4jZgSp9WpxC5Kgk5fA5WsKsFgBR
         /QDekx8rojSeY4swnUNC+6g8JnCswYc4wrEEbQHQ1JOBqs+pyCAWhWvvPWjBA5Ra+Yxk
         lTdnsth0SnFUZnl4nDdgQmp+DBnd8+4pKfUlnpeTUUdzX2hXPf3gGAocCC8j4vMj2OLW
         ZRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723989087; x=1724593887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkaT9Dcg0giRaD+ufjXGaXO64H/vMXoT5vBuRlnXRp4=;
        b=eN45SmoYPW4s3HjtBMcWiU8xFkfXNxMZ1WfBsibyiFc3dnvMvIA5YpgCfHL0VFResv
         WYUJvPqG0LIOt8minrcpzGSeukV7uaEEGDP8FYxUwtWiU5yJAdV+TH7qUYumYxXWQuMc
         QMF1Z+qOGpuou2v+w+p+qnQUbKsCiB5Wxm1Pu4ivLLDY5GzyfQCnWLZGydtnh2uLu/e+
         D/ug7bkdo7ne4uECra3ejZBZK8fc//S/Hs9JfPqyCFauVBtKOlVMAP8gX/b1YJzevCAC
         jH1cNxABZdkWTf+jh80NTq2rbCXAlM1+Mwi/f0eT5ccqrJHKFCZKI1Kv45kulqDxlKN1
         y0SQ==
X-Gm-Message-State: AOJu0Yx+JUwSwvuScU+WNLS9jAPLd87Bhi+VlkVGc+fkjt0i7MMe5+pE
	8CCUQ6KP9xxrtANYkaic/H0IEwzK1Jf8jECDKEi6pEgZtFjMT6UvYwsJ2v63zMMUXiTpx9JMcKh
	tHrwi4lP0MT52mnnXmKf1bsa6cZo=
X-Google-Smtp-Source: AGHT+IHbrS9bgSQ27DKaE0SQCjLwB7tMX0kQ5wKB5rhIeO3xZb3eVFOjTHSXKMIDyDtNTmWhnyyYb4kKHtukod9MohA=
X-Received: by 2002:a05:6e02:1e06:b0:39a:eb4d:4335 with SMTP id
 e9e14a558f8ab-39d26cdf9f2mr92288105ab.4.1723989087153; Sun, 18 Aug 2024
 06:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818042538.40195-1-kerneljasonxing@gmail.com> <CAL+tcoBPxMGBDN1yijgdpYpb8PJA-fWDi8gaEda=msVk2fo_iQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBPxMGBDN1yijgdpYpb8PJA-fWDi8gaEda=msVk2fo_iQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 18 Aug 2024 21:50:51 +0800
Message-ID: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ncardwell@google.com, dima@arista.com, 
	0x7f454c46@gmail.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 1:16=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Four-tuple symmetry here means the socket has the same remote/local
> > port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> > $ ss -nat | grep 8000
> > ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8000

Thanks to the failed tests appearing in patchwork, now I'm aware of
the technical term called "self-connection" in English to describe
this case. I will update accordingly the title, body messages,
function name by introducing "self-connection" words like this in the
next submission.

Following this clue, I saw many reports happening in these years, like
[1][2]. Users are often astonished about this phenomenon and lost and
have to find various ways to workaround it. Since, in my opinion, the
self-connection doesn't have any advantage and usefulness, why not
avoid it in the kernel? Could networking experts enlighten me? Thanks.

+ Dmitry
Hello Dmitry, do you know why the self-connect_ipv4/6 was introduced
in the selftests which the patch I wrote failed? Thanks.

[1]: https://adil.medium.com/what-is-tcp-self-connect-issue-be7d7b5f9f59
[2]: https://stackoverflow.com/questions/5139808/tcp-simultaneous-open-and-=
self-connect-prevention

Thanks,
Jason

