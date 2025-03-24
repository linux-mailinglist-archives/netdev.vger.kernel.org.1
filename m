Return-Path: <netdev+bounces-177126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D2A6DFE0
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646FD170DFF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C490263F29;
	Mon, 24 Mar 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsXr2DdW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D1263F57
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834149; cv=none; b=ZxHsPeaiLBDFWKCwwbEah2cA4wd46XiI2lkfLGathyu4+epbzoR/TIBXmcCPf/b2SxMwzIvGlwR83dH91EDe/6zMSQmRcU0Uq7APEJCvnzcqn5A9IPLaX/Dea2bCfvJ4URcMR/CagpHoTna2qy4nb7u1b3lsUKg1Sr0yJLmVzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834149; c=relaxed/simple;
	bh=/FSAwxDYQOB36xF1oqNtj7/ZKJBk1mFbz2iaPAw7vEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYfPt2C1QM7l3ZFQcQSly+vrwlXldUObxAfL2N8/x/fqzGE9IO8MZGPqpSbnConNHrNJ5bfKG46lIxT+WHmgXz+x2T6KxkPQHbgIMy5OO7c+9wqpfFGOxmZuSiawOpYPjoBrBeJEdediCISDO8n939vHw/CXeMSsECZLGPhCHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsXr2DdW; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d589ed2b63so40458245ab.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742834147; x=1743438947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Sw4E7+YNbyefFANGYO/HcxRdT3tzbDRYMfL1qwqZc=;
        b=DsXr2DdWPrNqnH2XGdK9M/WZQGyS7hmVpST3sImgCnRK4Ijgy7B8yinek+Tjyahk23
         12fSo1D15ehbhV+Bgh9YimhEl2wKlY6n8M3SNtllq+2Hvbs9b3P1G8gDHeCJN4F8fYKW
         WuoDEFCozW27h6iJNMr3zouCp+JADO0XQRlKpTK6ZxnG7tuGo3kxU0Kohgo4x64RH/tr
         uT0ObG8Ngk5JVpcw4ysNRApdYBd9g3a0hShIeAsfk1O/0hdpD5KBQUqUnowU+Mr2S3Kr
         ZLOQfUDHVIXwanKapgUNvlynu+CxeUywRN6Bwjk7XdWRUPI1bDkA6vZ4j6+HIP3Z8A5S
         36Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834147; x=1743438947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Sw4E7+YNbyefFANGYO/HcxRdT3tzbDRYMfL1qwqZc=;
        b=OtLb0FJE3HwQ5vdmMpqdNad5o3bVSFL3j/O7usN70UhmsgXpNNFkUhCsUqP3K6wIOO
         gC+gs/0Yli3tDDnUzync2E70qj8x53LoO3W9psS6u45jMKneBLqhfK/r7vc9gu0XBB8D
         kWChj28XWsP+AcmlPEAdJjxj54m9RcV2kHoiT86uPUZxG0C6O8II1HnFf4ruu9wQkRIO
         qnJWOsmdGMMxEuIvoG0eH7Vzp+OS2UNHx5wCFGOFG/aKWP7mu96dELbh/dCa/kIXFvvM
         X3v0+SkbF+UY3DOUoUHKHN+XPJR4lc6wJjmjgvkM8Jp6tuCR2USwWH1560DQXyl9Z/3e
         rVFw==
X-Gm-Message-State: AOJu0YyJjaaeWTCEVIw+jg4Ff+FFBgtBMiqr5hhdP8jNKLs14BV/I6Ss
	0XqstBeNdvlrfARax9Y5G4oui8PWykuAENlMSAriplgOCO5Mz+7mueznMiQsYHSK6WPcMk9za/e
	pDAx9Kx6VM7Af27LdFYydYtJnh7M=
X-Gm-Gg: ASbGncuPby9zMJtVM9154UGhz0nuQB3lnx5327g1SZFxnqIrEYF3VFNO/M/0N8QzHMB
	t+WAz+cjdPwWyTsXSOyZVoOYaLDPWbH3WZN5XFf/pACmRkqvnqkluGgyhKCI5f1HF8BnN5j0RBS
	gP0rDLLU7rbfWYOw8Sz967B7gN
X-Google-Smtp-Source: AGHT+IGuUGO72I24EaqpnFeF+Axnck/Tt4r0LyK5vzAnZzN/y4djRAWE2jGACDtt4egrjh4V43zVVlxl6aBqyT9iRMw=
X-Received: by 2002:a05:6e02:3d43:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d5960f2de6mr135935725ab.7.1742834146660; Mon, 24 Mar 2025
 09:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317120314.41404-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250317120314.41404-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Mar 2025 00:35:10 +0800
X-Gm-Features: AQ5f1Jp77oLVOfgqNYBhz_h98uLdq-6pemQsTslK0lTkmm-L39vOpoeaCTATx70
Message-ID: <CAL+tcoA6uawe99jrkRugrPmgEOsnCAgcqak-2uBO80jMDB+SHg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] support TCP_RTO_MIN_US and
 TCP_DELACK_MAX_US for set/getsockopt
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	dsahern@kernel.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 8:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Add set/getsockopt supports for TCP_RTO_MIN_US and TCP_DELACK_MAX_US.
>
> v4
> 1. add more detailed information into commit log (Eric)
> 2. use val directly in do_tcp_getsockopt (Eric)
>
> Jason Xing (2):
>   tcp: support TCP_RTO_MIN_US for set/getsockopt use
>   tcp: support TCP_DELACK_MAX_US for set/getsockopt use

Gentle ping here :) I noticed that net-next is closed, so I decided to
reply to this thread.

Thanks,
Jason

>
>  Documentation/networking/ip-sysctl.rst |  4 ++--
>  include/net/tcp.h                      |  2 +-
>  include/uapi/linux/tcp.h               |  2 ++
>  net/ipv4/tcp.c                         | 26 ++++++++++++++++++++++++--
>  net/ipv4/tcp_output.c                  |  2 +-
>  5 files changed, 30 insertions(+), 6 deletions(-)
>
> --
> 2.43.5
>

