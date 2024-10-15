Return-Path: <netdev+bounces-135477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8899E0DD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243021C21724
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7971C7B99;
	Tue, 15 Oct 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPa2LeRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51B1C68AA
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980503; cv=none; b=YewbSzNstIY6DZsr3orqSQufhUESzhsx3wLaaXSOO2SzNM1qVLQTZOi30RgwiGBPTmxpX17D/Rg2hiDfUYFwW+QHFTw2JVJczpd7zFNBmDAf7xa4gvASdLDQ7UgrONZi8wHLhysl/xU8XMB+Lluwy//1i8GplPQlLXNNOS0o9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980503; c=relaxed/simple;
	bh=LES2uBIxczbxDVs+cSbXU1thHwIA+M4/UkP0RYskqEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTrPXHY4Ag/ekvhckdMzVNH33hPXxZMGdjq3TMNBESNlUdrdJ6tQGoYyKxRCD6MzRGBBElCNM23MJgCPLawfePePctD8SAzwJ3LvSExUQQUIH8Ep5037TW1TMdY7ei6qkJiWs/6APueee7+ONSCvL2tvRe1axiK//00Ss4Rxz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPa2LeRD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso6717991a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980499; x=1729585299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LES2uBIxczbxDVs+cSbXU1thHwIA+M4/UkP0RYskqEQ=;
        b=YPa2LeRDhjIsSGWsyYXua8J0WezRU2Bit+KIUt6Wldn1mtWJXmg8VHbOdPCmd0LC8i
         aBeVcvXrMmvwJ9SdzPCJXEEpLxA2iEGwZHTA6pr9eejBKKRqR8C+hfmmDC5Ba4ijcLRl
         ctf7ZCNwnT91DThyOLcwSvQZ2k8AB6Tf+NhRkmraF90VK/CB4xRhRGe0CopcyJjxl+zj
         wrMspj8chHsE8RWUkSIduyafakJo1w4r+FSg/5sqw/QUxjFPws7MBhBhSz2B7ryDlnlm
         fUXRPpKIab8uo3/qvMO+Smk5S6CtmYab0NkR5AuvGKUe88l0zZrVBUjwlXIMn045Jp2r
         WK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980499; x=1729585299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LES2uBIxczbxDVs+cSbXU1thHwIA+M4/UkP0RYskqEQ=;
        b=VV9Tnj/x3QOrjb5WwktJ3tz7/H7N/LL2IuGBTWHm8kSsRWbanC8yVZWLVCbtLI2xwE
         xr0C9KGMeCpAmOM6Sf8mrsLDLBwubVFB0mxTr4XnMKtS0JTZQuJ8VwNEBBWLYvRRTabL
         8PNgO5gBcHal5uk0TEORSfuxjXHtfHkZLYakjdCXRaFv37EEK6fWUbzYIKvn7TyKhsJr
         cQKTw5zk9esu1SeMXT7H4FiECbgPIzNlymzFY9uQu2qXbd+TDhZOcFGnAY6ZcUllt/NO
         Slb2Oj+7LplwwDiTfYDP5E8kTo7JYk0GVifXO5y0uDSy9jJ+njh/shXlYWn0YXdCidTj
         Ifug==
X-Forwarded-Encrypted: i=1; AJvYcCU8aIoxcTzS4XngUc/YA6fEgP4CtsMnqPKTpuYNWA/G2YmOJ8IuxCNWTRYZG5I0UG5uDmoxqN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNS1K1pNNj5A9pAFRYjMboeCvoWm2yhojRMk57/IvDOH9HUQpA
	cIvzVKbxymlmTVj7Bv3V7Lswn6ROQ9LL11MjwtPUrpus/7+j0AwZocAOW+8Ar0Z/CZP5/oSmWd5
	MHdBeMPyNdZV7nsRVCp5Jv89H1TfbA+gvOXDRMRQPs1AuS3EBpQ==
X-Google-Smtp-Source: AGHT+IFMOUpmjvik8XV6iipUriDfgeV0YLg7/Rpyyr5C9w+tuEzt+O98Jag1+C3+YMy/X1ndRHyai8jm06yMJd1cC8M=
X-Received: by 2002:a05:6402:e8d:b0:5c9:1c15:7a2b with SMTP id
 4fb4d7f45d1cf-5c95ac41600mr7003433a12.26.1728980499072; Tue, 15 Oct 2024
 01:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-10-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-10-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:21:27 +0200
Message-ID: <CANn89iJm_mOFATf6MBYZOL+z4DORc+cGdNvuMi7ypbwJDoLLaA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 09/11] dcb: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

