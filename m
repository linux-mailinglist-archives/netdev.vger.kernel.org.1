Return-Path: <netdev+bounces-218695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A91B3DF4C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE5717D95D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5993101A3;
	Mon,  1 Sep 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ka67yWnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7E30F522
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720727; cv=none; b=X+clvdJcVaI6FwMMEr227FJB8QJFdItTjk9R55Rr+0GuUkH+LDGStloWgjweDl+94H+eQF4O0N8v/fUyumBVwCItHK6Kt0qdb4d7J5nX8MjWGEuosuZFjyfRxeQ4GPKq5vVxgwa44HUdffBogAqtlCunn7AQdPAouOyY/SajARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720727; c=relaxed/simple;
	bh=hEusnzMg2DgWhVhFBW2SBz/1KGA70hpuNARPZygG+kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HggsW+/3efnbLEV/c5/1kipW5cSPGjZYmz2WwPt/DfxTw0J3giQkZoPyjtFCymQHHE7QPnal2sJF1v81lupURPc6zLCcpatpmAVKqHFbzqfIGqzA4WmMNhaiEvmk92mKpxDC49MZ7lQ5u6yfKkbh71EHeizJiuaYM01lhsg/dew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ka67yWnb; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b33527de1eso4145091cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756720725; x=1757325525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEusnzMg2DgWhVhFBW2SBz/1KGA70hpuNARPZygG+kI=;
        b=ka67yWnb79aBmdUZQvzR/Tx6/nMa8Qsf5T7Xulwvgd4lF2PeIoKos16hrXNcGtdFtx
         qtnZbQH56W/tuVdFytKyjgsOxH47/d8t2m7WRgd6txJPNW6bs2hryNrmbf2m5tPGqHiC
         lKW7a72kKrBkyz6fBTBv5HPeEi10S8FdK9vryYhaJ9qG9WVWzFj1JuDZOBD/YXNSVxhE
         eHe2282Dmy1mhoahjnzsjYjJqyl5+AXsOHOShXcUzf8nQGzsTBHwaNAe9gSGm9W9JUmO
         /kN/sUM1LoTF4+xfYyIJiGHnIhLemOvaBgy0QE/bpkoFZSaEqfQzlGbO3kCAyVRFxCX7
         Tp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720725; x=1757325525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEusnzMg2DgWhVhFBW2SBz/1KGA70hpuNARPZygG+kI=;
        b=jICOJTwfxc5wdxyTZPnTILY08nUbe84ZljsNi8CzsbkYiWvg8lfWcx1VevTXW5fsNS
         YiFFM+ZwUba/amhGoEvYn0V5Hx4zoTImIU91EzEMRHb1sMNZDHkUjud+Gvb9sRa+SQQi
         mWYZCsVuAspxzsHj5A/Hesk9zTDToebtyZG7cmGBDXKKUEQltb8xt9SSiC2P1Wl4lWmK
         pPThTYeaSvkFVcf0x/Cou6BkZsUDCYypJdlf7oJarTbAnle/86scJaI32RQwAEl+Vur0
         pjqm0kynq3WvI6d0u8HUpNaGLaxhS/ByY9lntykZIL0HIIky29ojnuC/8Q3LfSDNy3Im
         D5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVdKAiWQ99zTZnyRcyYQhsKqKMz9zi3+hKZKvrM+YsuL5I4tFNriwMO7ChzPHCluEQt0yB0ifk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2AdU4cmd2HVmjYrF/TPxfaFQpFA47J/ypnDQPC5bIhUaRHx1
	lqi27vwuQrfspu51FosdhkxjNyZcjXwybIsGQQE4NWrB6NF+XpLQcgutmbdhFudqZDgj51l+9EF
	nK8RS0rxjJE9ntYYIJ+NxdyDym2rOiiLl++clYrfl
X-Gm-Gg: ASbGncu1kysX/OxTd7M5gKc+cvdzVY6VicY/0J92EWw1VNR5EmoQCf7JspFXKZUh+S2
	idvK50YltTy7oMQ2UUV4uofXC7z9R1JgINA4+5VnRSUGvs2ycbO952miNjN1ZDayWdi5+1DHHmj
	Om14b0w6hBBCm8cb3nMKiFTTzeOBreoxVagZ8wj7rRvmN7uhaTJ+EHZ1hSVoXqmdmCBBF1N+HAk
	FZ/Q35I3nMQw4qLvNn+Tw2j
X-Google-Smtp-Source: AGHT+IEzn/dzmRrgo6D3qIpNTD4LDMrsR1eHzLovuZVxsCUQnffW9hReBRDR2uw/O68r+HxpsyeseHaA5TWRV5ENKEo=
X-Received: by 2002:a05:622a:410f:b0:4b2:f32c:ad4a with SMTP id
 d75a77b69052e-4b31d7f1e05mr86758991cf.12.1756720724676; Mon, 01 Sep 2025
 02:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829215641.711664-1-kuniyu@google.com>
In-Reply-To: <20250829215641.711664-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 02:58:33 -0700
X-Gm-Features: Ac12FXxEzMRx_VOAq139AimmAhJXmCfkC_7cJgvmUn_8UAagsbWZEIYQaoyjMLo
Message-ID: <CANn89iJZaTxf7yW8Ccxy+jaKQR0O_wM3RhqKTzNgVncP_Wzr3Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tcp: Remove sk->sk_prot->orphan_count.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> TCP tracks the number of orphaned (SOCK_DEAD but not yet destructed)
> sockets in tcp_orphan_count.
>
> In some code that was shared with DCCP, tcp_orphan_count is referenced
> via sk->sk_prot->orphan_count.
>
> Let's reference tcp_orphan_count directly.
>
> inet_csk_prepare_for_destroy_sock() is moved to inet_connection_sock.c
> due to header dependency.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

