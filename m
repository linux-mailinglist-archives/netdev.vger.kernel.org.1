Return-Path: <netdev+bounces-70993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29384851811
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99C6283185
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF863C47A;
	Mon, 12 Feb 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYBoLQvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D83C489
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751993; cv=none; b=ZJS6KIOnHhlTIs+4o88VK4jCIs0A5DdTfq4bM9EuvXATXEjmzwl1WGRolsuAgsLlJMTnAB+N5F2mFRVTSrlkXh5J79S5617nxrUyA/T7i2aJOgq1nlRgASxv5xpWUpeNjdPlD3qwTeUU2ZmPsru0cOSfP/iudSmwwvavUTGGK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751993; c=relaxed/simple;
	bh=VSTtDYOu2lfmf9YiBGh4rQiujVE70e7AINwDTL3Atdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp69HeHwfgjSdD5TEj9TiAsfhhgEtR1aKy7lP8v0umLSWcgfwGnt67YIK+KlxQVkAQcn11Z7sJ3tnHDNkqzGwu8W8VpdvtwZJwxhFbLpX9WPYgGhET7hqauKxsxSMhhZZaFqUUkGffOXuLkA6Hc+93Wg9kdbcGz3hiNdNzOl7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYBoLQvI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56154f4c9c8so21792a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707751990; x=1708356790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYPN1gmzL93JiLOCSB0ALr4VnMNGpIc+ImnZEbEVAAY=;
        b=TYBoLQvIZteeXwLL9xSdBawut9S5A7TdZmBBSHKc75Z/hYaFQ7NkJKNtjybsllC8fK
         9UHZansn4T6q+9K1m0tclQbDyU2QI9MYV+gjVXuHhfo3m9MRIZG3WbsmE9JQ2Ha8eoxf
         OEHIjbGXOUQPFYCYZHLswhVltnRB6MHM1aeRYZD6vDlk3+a381dMdkbaXKJzoOwOMV3o
         oeTRWr+DclVmfk7fdpvtONAfY9QmVqhsO4GXsip0OxWqPog50XmuaAQ2EWUXivmzik0/
         9tk4qiXmNBMQDzS1A1r5QmGhzTFJO81B94wc4jm30Azoaea+i7KStgmC04A3h3q8RZDm
         fICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751990; x=1708356790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYPN1gmzL93JiLOCSB0ALr4VnMNGpIc+ImnZEbEVAAY=;
        b=RHv+LAf95WM3IZx/9MkCuxIGpH264MAC+5ntZMKtzKXQYDAjx5Updl1dB0V2+fq7N3
         bgyd3xXXTqZteczlE61k8sraNAXQMp/VkBLZufaY5Scu+l6QzwJXn79kcqKCIm5u2FWl
         NwRlF+nSA1EauVnG9cnSJUS1iIMmSPzXli9biMtC3/kReidGj3tbqUbXmuJVdvnQgOMA
         idBEibUjzb5XXotVFrDWHO/ETtpPYb9M+QAWUH2pShatg0XGJX4+nRjtXilGCyGakYIh
         QXAMj/H3qFzte7r+OSINJdhIlJgmlDpTRcBFYNbprzhzxgEFomaQvwi150l6Pff3d9we
         WsGw==
X-Forwarded-Encrypted: i=1; AJvYcCUCEf6nMBIiqc706kUy0aw4Dv9aV8x0To0l7jyjtHJx/lMjBuEFwUnjLlauPdP7TtENVUqLBXMS4pBXD2JwSyvu1jTpWokn
X-Gm-Message-State: AOJu0YwfahE0yepnSvfwKcaZQsw48ZmsjJ5GX8GSluQFVLbAbzxkpNaC
	Jrj18GEgGIkVpFt9Bv4Yaclpyn+cEi7+nkE1GPfcBQyQPaaMGkBDwy+8nd5IbFAsc6WlkuFDdOZ
	VCtBwyOlcW1mBteetsmtduxcE0HaaOtzbl59z
X-Google-Smtp-Source: AGHT+IHLoNh6zZv8BpMzG8F30wf1hUBMr6c0nuCzffinW85aG5bdzAN+1yefgO6PvQH4Calx+ZYK1dN7zmgu7kCobPE=
X-Received: by 2002:a50:c345:0:b0:561:d84d:f6ce with SMTP id
 q5-20020a50c345000000b00561d84df6cemr60080edb.6.1707751989665; Mon, 12 Feb
 2024 07:33:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com> <20240212092827.75378-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240212092827.75378-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Feb 2024 16:32:55 +0100
Message-ID: <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>


>                         if (!acceptable)
> -                               return 1;
> +                               /* This reason isn't clear. We can refine=
 it in the future */
> +                               return SKB_DROP_REASON_TCP_CONNREQNOTACCE=
PTABLE;

tcp_conn_request() might return 0 when a syncookie has been generated.

Technically speaking, the incoming SYN was not dropped :)

I think you need to have a patch to change tcp_conn_request() and its
friends to return a 'refined' drop_reason
to avoid future questions / patches.

