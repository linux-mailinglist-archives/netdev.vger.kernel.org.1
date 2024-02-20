Return-Path: <netdev+bounces-73288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5E85BC70
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710B01F242FD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE567C74;
	Tue, 20 Feb 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkccN2Kd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AF8F4A
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433041; cv=none; b=T6KXeTQftdHIljuur96QprLWXToSdnd077z09prJOwj20Ch6DRJrbx7Q4Rx0PL5uQ85+siaTPgqU5jzWRT+PX09ESXPW+qmZlKYE76koX7GUHa6WYijU/JS1ZdqMZ3Q9NrCG1+qIzsDaGh+OuAOyRP3hvCAF/yMBf1wdlQIH9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433041; c=relaxed/simple;
	bh=HtPSG6BPy7ZaiiV7z1bz04I8EL1Dj5VtB2yFVdU/H3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfTnMcMyCP9LgcK9NcOjgD3w4WRtVxhrYLfhZN09GMsbDJEqZAiQa5gVftE9SkYDsYeJsiSy1siEoIcoVBe0G6e+JQ5N4CTvkBtpGbJi5OXRvIP3swcuDpFgssI7QCBGt3sCwDtIyUWDJcHSNHJzK3jwjSlpS+zQsM/HAuQj/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkccN2Kd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso24802a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708433038; x=1709037838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtPSG6BPy7ZaiiV7z1bz04I8EL1Dj5VtB2yFVdU/H3Q=;
        b=IkccN2KdPM0C2GvTUbr71sI6SKUucHitvGa5rsTi8HD9GpIsLVB790pM2DdFqSvq1h
         OjO02tw6dHkNQJQkBg6XzCFI/PnUbhCTIrwt/MTlW1ImWT8dCriArVxbogi4KSLAK9oP
         ++WoVeMS2vRReD+MwTYY6+dHmmCQSMQA6nTjc8m1TohQAPhKup+fiaMMu+5K+vsOofY6
         ODJa9TUeQSQSq7NWNvll0HwrjUXJIKmZ5TESTnCuxryJIX3I/QXggnk2tKxgOqcIdmcq
         Aj/ist1fgMQwBr5iHZUujKD0XVYNU7bxEsadKLbwUQWJmVseqlKzJeKWU3rWkkO2JoEk
         RW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708433038; x=1709037838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtPSG6BPy7ZaiiV7z1bz04I8EL1Dj5VtB2yFVdU/H3Q=;
        b=BFgNYM9K6oVKDHWYlqNKmZiVzX+CebsaT3aNTLomclna2H9E3o+cQsw+UtSZCLoI0H
         pcSVsZL0NYwHY02oMy/QSXYyUZdU4dCNYuynV/h2wsvgwyvqsCE3HtsGywpYTydwcr28
         3JmcwdmFa3DQOtmF75hNKhDRVMUf8+FGIE8GOhHlppom0PyKgjIzceMf1MYq2lpPys13
         zRqptT1GfhCpL/Ws+GUC9rYpTbgC0gglIpGt4IGQdXi1UvvFAf95Ah2XOxljuhbcDoFL
         lV8NiceQQGub1RU6e+tOqm13kPoffIVsamfOb8P2WKyiUp5xI66MOs8imuTOkM0XG21I
         GxMw==
X-Gm-Message-State: AOJu0YxNGKzeXn+dFZP3JEr0Pc34yUsJwyvxl9BAmTS1cSsf6MZ7/1dg
	SWNHfQDzA0or0cOm5Ac1Om9ZYHUHuTdDf6wrKU5rU07zNilQU2DJLTPDvsx5VSorJxiJDqiXZev
	IfxbZBnncpmgwcJOF2JCyCoboIL8ckuWLM0OQ
X-Google-Smtp-Source: AGHT+IEEuWARbmQ9MRMb1yaaz9J2AjADSSxYUOkNHtNhr42IoYqeXhS8wAyjOsvH4XyAnDzGJ2W1iRC/Slk0OFFx09k=
X-Received: by 2002:a50:d696:0:b0:560:e82e:2cc4 with SMTP id
 r22-20020a50d696000000b00560e82e2cc4mr374629edi.3.1708433038351; Tue, 20 Feb
 2024 04:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67ab679c15fbf49fa05b3ffe05d91c47ab84f147.1708426665.git.pabeni@redhat.com>
In-Reply-To: <67ab679c15fbf49fa05b3ffe05d91c47ab84f147.1708426665.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 13:43:43 +0100
Message-ID: <CANn89iLQ1Sz7=sYMr=4r66-ZjHfnG5REi4uvitewfQrC7jrdZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add local "peek offset enabled" flag
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:00=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> We want to re-organize the struct sock layout. The sk_peek_off
> field location is problematic, as most protocols want it in the
> RX read area, while UDP wants it on a cacheline different from
> sk_receive_queue.
>
> Create a local (inside udp_sock) copy of the 'peek offset is enabled'
> flag and place it inside the same cacheline of reader_queue.
>
> Check such flag before reading sk_peek_off. This will save potential
> false sharing and cache misses in the fast-path.
>
> Tested under UDP flood with small packets. The struct sock layout
> update causes a 4% performance drop, and this patch restores completely
> the original tput.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

SGTM, thanks !
Reviewed-by: Eric Dumazet <edumazet@google.com>

