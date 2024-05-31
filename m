Return-Path: <netdev+bounces-99650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546F8D5A84
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45DA283EE4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C017F499;
	Fri, 31 May 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaOZIk0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662517E101
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136776; cv=none; b=n0iG3T8or4BIE1/lnAYuQDCT/ILfw9H9O5fAgnMEJkATB913x84Q5jAIdFMiwylLluCrFVEaVistUsqPhYgOr3VGyS03vD5U1H9orHQyFMSBs+v2k+nVaoMvnM8fRohxMaqUy5aK60EFfZ1Tyv1MbxLMEJqS8cEwflT75MPie5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136776; c=relaxed/simple;
	bh=t1INJeM1b5EhdcoKhwPK74FNBNyMwEAza5KlFdey1uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyZYOq/1OpvFpFJI0nFF05mJu63889ACC3Up6UKAjkkotxw/HBr9la5EqgSCNM5LE/BH5WaQ04mFmyRrkDhm3W6S5Of+tE+nmnTA04qHoLX93VXvkReFbdMejfC8M9RGQLDreGpMkVf6qBSVE9dR7iw7wgttQdUADtIuEV3DiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaOZIk0F; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso11078a12.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717136774; x=1717741574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDDaap/Zd+yl4UAhzv9tDTF7kK2BXXfxpdxIRsgYILU=;
        b=EaOZIk0FDAXVGw/L7R3J/B5kzSGjc2EVE3kSfK4vmrpgBbfjaO7qDsY5+CdprhWlBZ
         lRK/SPaPhz+LWEgnJaWPNIy+6KB8DHOjyE+IvLHCoJzyFpmm8t02+pStiPjHe5LX1b3E
         mWk/mC9Mz0wM4fKIeFZjwqaoMP9yMU6+CKoM2eeYlRB3YQvlad3zv6qM79XbW6JB18nq
         H+0sgsthtmKHtqPRV8nqoBPD2fiBOsfeRYzoH7NJUyOF8DGnzXOE4c0V+HeLGLVGbpEj
         BN89fo+ojeN9gs4Xbp0+GAxYSeUWhljRSCPRXbn8WlodjUb+FaEzjg+eZ45ePwefmpJo
         x+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717136774; x=1717741574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDDaap/Zd+yl4UAhzv9tDTF7kK2BXXfxpdxIRsgYILU=;
        b=a91njTIPDXazfHxS47TMyypDnX8slmBOUWNtXQZQZlU2EneZY7iiCJKEJjz5pGjmOM
         MFyefZ65aq7q4zCiqMFk1WdS6gM/1iTvKskCNaIQNieMXYJrKnS1rQQJympUHOcqyl+/
         WEGQE8oSH3aLFv2Il09lBrDrXWNrxF78rv8hfqMpSiZZuD8GNh5tbD9hG4cPlDoK0/6v
         F1wwKdEMcPy9dQoKXvpP3Gpx+FeuNrXqWNI7YVp34lXeBBIQ39YkclILQ+nVf4ulRXSt
         aKGOTN3GQBfled4p5MK0tRMVIxXs90OT9qjNslybt6bVZXRizsmhAM7CHT2ptEEKqQf+
         U2ww==
X-Forwarded-Encrypted: i=1; AJvYcCVVmSi3tnCllGQzrh4kS0u/TunT5eL0FVaWW4xu/40rb0Vf7JRooNY8UOLLLfVzmGQUAY1JMhDBBGE3CV6B2THUjVD6h5Mz
X-Gm-Message-State: AOJu0YxA4XB/Ds97Rp377gBUuGX9vbfyi2MzAwHWyDmdN6pektaWhHDh
	0C6yj3I4elFX3ZngFaZRExqAeZFibbjma2HaVAd+pZX2C4ltWJgydOoXXbjWfCWJImIKYlWfIqH
	t0168EIUgAQk/6r2cT8yzCQV7MnxitSNlf2me
X-Google-Smtp-Source: AGHT+IGgorT+ZMUlhUGGf5mKNimyLX32wJFSSiFwPxNqEI9U3HG/0UnUjNNIjCYOCRfzeynUzXtGomqrq2ZpUaDgYUg=
X-Received: by 2002:a50:fb18:0:b0:578:4e12:8e55 with SMTP id
 4fb4d7f45d1cf-57a3785622fmr60079a12.1.1717136773372; Thu, 30 May 2024
 23:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530131308.59737-1-kerneljasonxing@gmail.com> <20240530131308.59737-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240530131308.59737-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 08:26:02 +0200
Message-ID: <CANn89iJZo2R3eOVvWpo3-5aoMaaEtzxH90H0iv0FQXPUz7aJyg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like previous patch does in TCP, we need to adhere to RFC 1213:
>
>   "tcpCurrEstab OBJECT-TYPE
>    ...
>    The number of TCP connections for which the current state
>    is either ESTABLISHED or CLOSE- WAIT."
>
> So let's consider CLOSE-WAIT sockets.
>
> The logic of counting
> When we increment the counter?
> a) Only if we change the state to ESTABLISHED.
>
> When we decrement the counter?
> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> from CLOSE-WAIT to LAST-ACK.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

MPTCP was not part of linux at that time.

