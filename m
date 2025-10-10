Return-Path: <netdev+bounces-228488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D082BCC4EB
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDEB04FB85D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC89273D66;
	Fri, 10 Oct 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcjroTTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC2271457
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087780; cv=none; b=L09FF2tzveLfWhTxGxv+jNrTOy+zuP+yC5MLJ8PmnISlI+VCB8yUjH6Xc71a46ydvBTLX5mGwpAKd9du4Nb14DahKW71j5AjmNO2gKmgixOMs80bLCeyoPnNi2KhMYZw2TOipZ9IsU/B8IJ+94YXjKm6eRubSvd71B0rUGa/e0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087780; c=relaxed/simple;
	bh=tQZBUX3XvCYZXjVGGEOa8qb+ycy4vSGnh5dp8xBMu4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxnQZZ1TcrleqWkfajwcdEj2LeBkXOAlw9HcR9X+3mns9K4x3b1YbxuPgusXqZ3X0MzsYblH4nQyLgUNH6AzY8BmyhTN2Gdb4x/K+MLf51waNoj4Z6W8YHSFFcPqDTUTbbYEIJIrzhurgRQHtxmqER4rSbdERqIXVCdJZ18ZSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcjroTTP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4dac61ed7a5so18343541cf.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760087778; x=1760692578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzbSi3MhQ3TlxHHyou9VOzHW9hoBR9Z04kG155RbSzI=;
        b=qcjroTTPnp5fc/eJtGmBZgBkfkUBYeB5L/hvghku77tH+HWDaveGyCKYPlEtQc5Hzo
         jzLcpsPTqvIA24owBjFe8Y1sUnOOPHFo/YBV/0kyLd8aHvGTjKudA4dz9vEl2qsoNaRx
         S4fdro49eqsTrpLWBGsvTmhnGHy6qZfTIAxAZFlV+gm48JHfpRXRfpss7t3GpTu00LZo
         0ErtKuT6Jt2HSKMQLCjooYyL2b86i9nwPrssSo1bCClLQyKkR66Oivd8JFIQV27Tg2ek
         +r84voQG0xa8YKaSDLMWKayojFLwGu+byNYPpd21a9aN5W/j8D1c9pmA1wG31LPmZYCU
         KO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760087778; x=1760692578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzbSi3MhQ3TlxHHyou9VOzHW9hoBR9Z04kG155RbSzI=;
        b=Hhr06XxZHJSVKq8tV8AzChsdMIOTrYxo6Xab78v4a7ckV9ckh0aKpDIdS1rRie0Ie5
         UwmyGYpBZlHzx5RVS6VdNpIuofiPhPgFeF/hWrs3kCv+01Yc1IV/jl1g6To8eUrLu9Wc
         rIRamz8TWpLohMDY7I8Qsb46m5iX5D4bMNVX+irIHrWWv1tz2o/wHXJLvwEcvNp1Iwup
         HUwMYKh51wkXKcPoXTRwudr+cw7XBdweRXgCdLA4ps4jnIoRI4dQXosOkung+CTtpj/X
         FLmnCmSxCRd8kxc1yAnsu5J6OrPhde/cJRUFAF5ksp6OV2Tk+hfvSovKNMcojwkexkiL
         yuXg==
X-Forwarded-Encrypted: i=1; AJvYcCVKhzo7kVeS3nn0qT1HmJ27/vDPZri4rTiVFU0OpKcv0fbzQfR2mpdXMpeN21G07sREEo7oZeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWqA9RFpuq2Ox0vzL3q32owwrW6E1sJHBgrLoyS1w8HcPgU8l
	mUNRCYQig3Phh339UI+DQ66E2TL/m8WffhGcdr5WqFgCHyPHxQql8+bo9QbgTbM1XjvLQ0L/JfU
	41cMqGN/j/IeYupwr7VAa25VVlp7xx3eY4X60p7Lp
X-Gm-Gg: ASbGncvM0tEsqej5xFlSMSSMytJakQ3TIkriOO7f6XpBuCVkoeEbPDA5mAc5MjK2FAN
	TurlOYe9M9Epgew/ypJ9EQUStpRkJF45WHGiXZFw4QmKfYTdv0ZqG23PZrcQQbU6zfbX8WuEOgL
	v3RMRSAugvz5J5vGW2kBwlp2/6+E38MiZYyrWxRKq6OP9upiegKGxc3EfCHqMmzdaWG45YhQYGr
	750Z9hGANeFdzM7J/83+JX/NwD266XtDQ==
X-Google-Smtp-Source: AGHT+IErlLpwK/y5ZkyT1NXvQm0VoBCXIQhIIijbb7FXf3NcLAFxOmvBxYfs/FSRnPzRwXaTTMCVqNUkpI4RlupTQT0=
X-Received: by 2002:ac8:5902:0:b0:4be:9bd8:96f0 with SMTP id
 d75a77b69052e-4e6ead74978mr143714981cf.71.1760087777859; Fri, 10 Oct 2025
 02:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
 <CANn89i+rHTU2eVtkc0H=v+8PczfonOxTqc=fCw+6QRwj_3MURg@mail.gmail.com> <81694a16-07df-44f0-a0a1-601821e8859d@chinatelecom.cn>
In-Reply-To: <81694a16-07df-44f0-a0a1-601821e8859d@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 02:16:06 -0700
X-Gm-Features: AS18NWCPORujAzz3_WeSTAuBKhzVzHemyw1PzLIC2o2khvPutiGDBTseFGRhzhk
Message-ID: <CANn89i+eDC5Pzb3gaszAqD3yjhMSw==O5nnC=R5b_42N5vODcw@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
To: zhengguoyong <zhenggy@chinatelecom.cn>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:17=E2=80=AFAM zhengguoyong <zhenggy@chinatelecom.=
cn> wrote:
>
> Hi Eric,
>
> Thank you for your reply. Indeed, using bh_lock_sock_nested can lead to d=
eadlock risks.
> I apologize for not noticing this earlier.
>
> Can I change bh_lock_sock_nested to lock_sock to resolve this deadlock is=
sue?
> Or do you have any better suggestions on where to update the tp->rcv_nxt =
field in the process?
>

Please look at my original feedback.  lock_sock() is not an option.

