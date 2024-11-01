Return-Path: <netdev+bounces-141046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD39B93D4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7707D1C20A0E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC931AA787;
	Fri,  1 Nov 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqTjhhBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F81A4F1F
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473078; cv=none; b=T0VEYGtuQv74sFKRUVYc1W+3TlQitFs3VRyLitJwtn3LsP5G/Nql9/DxyL43HDJ4n+1xu+WVEpFZGVvhwidlyyvbz0pP1pAsgAYaTDiaFpGMQfHGClKtSy6EfgRUBv8gT1GfB/4mFJ2deSKuyG5LXzkK5uPum18EWPoh4G78nCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473078; c=relaxed/simple;
	bh=HAKYWZYx81tzoWdX3VevVxQgSCoKlHjOH/hWoXOy5W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RX4qwV0fQAp2ZXcQVo4x8hKyq1kVUtDj7VsjtulQJGAgNGwAY75N8ZVSPvHVFmdB2WwyK1vIKWp9jx5Ccu8lg4E8VdekavGHKCFCr5pya9gle4RzvRs/SXWYxQYlXa3sKLFcOgosG80+WDlwcJya6b7N2HIcJRYPUGzKwFVR7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqTjhhBC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4608dddaa35so174961cf.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730473075; x=1731077875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAKYWZYx81tzoWdX3VevVxQgSCoKlHjOH/hWoXOy5W8=;
        b=rqTjhhBC9hU+WkOAPWU4RIGn5JxKM31Zak7qWRSJuhvRzpz2bwF4dwzOa/lwXxtCod
         i5lm15CwzfTUIex05xIMHzauDWPmLWJ2/FypGM9rXRcQ1zywN+4+tjfhsjIl0HEiIVZ7
         FC7zkr0qLUv8L66Nr8RDiYrzdXMPNwDu4tyKCJhshfL6SXEK6r42RME1nxs8u8HKEy+Q
         ++TtTI7hdv8M3v3IU42Z7uaMRVOgiX9bk0YikOjXaPLORao1PT1RyaIJYlqwzHVsBqcu
         Qszu/gaPEbNsvEoqS0c7iDVu9Q0wh1D9hm5uOUnCvOTMk2IuEv7p/zwm0DnAJ2by9vsD
         40Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473075; x=1731077875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAKYWZYx81tzoWdX3VevVxQgSCoKlHjOH/hWoXOy5W8=;
        b=FBJOyh/EAx4gOT0fnUN/g8Ezi+Y00lxBMEcWze8LNzGfkxOZZBRLC0tkK8OQ+LPAcA
         XUQ4+XtImAQGFCQp1ML3CNHmuXKzPz9+kXB2uqgK8J9nCbK3s/wHaoo8bfM/EYanAjo5
         /E70QSY4DNvvpLbAClHjAJnIbYoeAb92A4YiOq3nw6T9q/sLUD/AlTe4PX/vBluOB+Bi
         rFZueSubGFe8aH4aly4XU+lpELUz/Bx7/vF2a7Ve5/EhWLmDur8r+R6LH1bv8q8yHOK6
         CjlOOSA9+JpSVWt+HLowEcCWXIMT3nasFGtAWUXrKBdyjk/fs3yVVDsi2/bHRKgCTiYm
         lALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA15P/QRdHyGFkmS6GTBtgDCRNj3kcrpnzBuaFnE19UHNxPFjA3zH7VeCWC2zsEssQoZwL+0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiGMT4Ymhjb3TvQ7C/UMcS5nu0hfyK/hUxwvTJ9L2B4Mx0jTw
	6lbGTaojl5YQmxEk6O7Mc8Aqw9BD4QfJeMR3+dqlcNGFHHEgjPiv2P3w3W5IKGQYQLmb1ZqcUpD
	nQCFdAqkBKGaE6QCTnyvWVuv2XW48L+0IKeiDmLDoe7a0EPRu91ai
X-Gm-Gg: ASbGncsjf5mjY1iSHFWvWrCu9da/JSQFiZ7R2XSwFHsJ3Mj6MJawnXYxsiJg5v1zq9x
	5u7ospuMxov39uui+Lz1tEkwIzPORbms=
X-Google-Smtp-Source: AGHT+IFsxGUWa4VfPbyiWUamurViNWXHq/tQXiIZJlN6p9X0wZXszbpUZgaUZKOuw2yIZ5QZTxwGURHFCn6Egdnz7go=
X-Received: by 2002:a05:622a:88:b0:460:4620:232b with SMTP id
 d75a77b69052e-462abb290f6mr6586171cf.28.1730473074948; Fri, 01 Nov 2024
 07:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029230521.2385749-1-dw@davidwei.uk> <20241029230521.2385749-2-dw@davidwei.uk>
In-Reply-To: <20241029230521.2385749-2-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 07:57:43 -0700
Message-ID: <CAHS8izOeCDKrEcE4aH=OofTJL0OGtGA5O8R9aKk1=VOb1C9kLQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] net: prefix devmem specific helpers
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:06=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> Add prefixes to all helpers that are specific to devmem TCP, i.e.
> net_iov_binding[_id].
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Mina Almasry <almasrymina@google.com>

