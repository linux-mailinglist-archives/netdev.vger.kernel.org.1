Return-Path: <netdev+bounces-225442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D2B93A8F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726D419C0AA9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7D7EEB3;
	Tue, 23 Sep 2025 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhHkS6gV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4A28FD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585652; cv=none; b=NAvBpaHevoW2RIxTGHRiR6vvMIlT2G9OvhA6enrMQZwDEUyVLxXrNcOm7aZiBEd8m8PXcVhIw94YLLrFUyib470lcIOz6mMHLpB1Tv+dIK0W5dWpIG30pKuMGR89eeTdgSWl5/a4t0m7LdculLtdHsUzC7ZjMN9z4XjiyH2aJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585652; c=relaxed/simple;
	bh=Xso6C5DnCXq0L6TjTJIpYhGpWwY9tYt+zQYpusTHhMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUP7ky+BvEKxyjEyFvwN0BeqCBtuZ77KX5orKqg3u7TTDdsCS0YYXLo3SSZjlHAaQJ6PdxCrZJ78Y/6JbCHaLsvZApbCHjA8c/cM/R8Ebj6RgdXcikFn716XeM8mst6zGIxfNEvJstPDLByOST4t8JfHX/Xv45FuGuCGZ92W4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhHkS6gV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266d6f57so5124248a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758585650; x=1759190450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xso6C5DnCXq0L6TjTJIpYhGpWwY9tYt+zQYpusTHhMo=;
        b=OhHkS6gV+OnD0zCgZStTO/4S4PULlCCM3lXAeNPV5z2YKg9ePk6d8Cj7I9LP75s28x
         H26cULEfvCVff06yocdEK27UKJoCtIY/Uem0KnVlv/ScVpO0PS1Uncmk1Fff4tSgSL0C
         RZbY26FDxCMalQmuGfzR/TLqpeKqzV51meBOwjTltNnuCoLynEPnlKEjn43zkdRILh9e
         MtQbr3hgzOv6zjy7Jgg0Qm6TIiHzUfJzEOrdYSYxisSGPNrUPPaFS7Qsuuf54TyBsK+3
         74U+ddbARsh9o3irbQbPGrC0haFhiU5q/mM4tGCeo3NWdkrVhtc8Soy0Lpn1+b+3qOWu
         4XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758585650; x=1759190450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xso6C5DnCXq0L6TjTJIpYhGpWwY9tYt+zQYpusTHhMo=;
        b=M7lQehr8KJ6popDjp4l/8qbuqLFfbytW0mYiCEZUkW17V2BEyJyLF+k73Ucc2V2/TP
         ZuNy+l90hcy3yaldL6IDTqHxLs/V71FxNBiqRjHKV4Nd82StJXwT1NTFYUKAZ64ObKLZ
         jLpgYL2ett8sgoGB61Zxbn4EqEL7pKG7vfs5oeHfMo+Ip614ktUsYiy0k3R1WJVSX0B5
         55mqxD4/GVyeuCgem0Gi78sW3R5kN/Ph0Xh8c8gQqz/TaEc7ey4l231tE56UionHoZbg
         zBOnhfP5fGXKEXOSg+NPLU26kb94g8uvBEepC8DfRU9+8KnJdsXebnSkJRzpMj1aRxGv
         w5KA==
X-Forwarded-Encrypted: i=1; AJvYcCUdkfP4rR9tsjipt+SY5zkxpPr2puTbHLTyhEyxKYwU5LxSzsbTjrE6xvrUcXz9xH30MGikJ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKavYfWiMF4BQuvLksX+gLHeQ5fYAZhplpSKgSJZwhTnoZSkp
	6fFT7n4EuqQSwb/t+gu+Ui00BLBJ5gVPceTmCxRzsU+R5e+7f1aPNu8uputqGUubmVLIUUTEY7L
	O97jS2egCbVv2GTK0kUDJ9yd963ColRjW7/RtQpUI
X-Gm-Gg: ASbGncu6kqu3IS4/VvSDnCXC8tBLDU7cki3pjdecZOe/rWO3Ihe4iXi/qwS25nLE10D
	csuI3Xbl3c8Bo85GChONIHV+HEGpMTd/EL4CPKND/6Vg3yIVmXeLLg7GZ8SxkoHMYy7c7XY+a/g
	8ooi+sj7rnobk+c2NlPeAQJErJj5O3BzKZ3T8VopEAhgyra0g59p76iRSdJA2FC90Y5o/2tMwku
	1534aFpudBTp6e65PyJbvlGF/wdvn6eXh0BEg==
X-Google-Smtp-Source: AGHT+IHLnwcNpBzlET4+D/Seks8+WkB8gvy/jDrJaYeDJgEo82q5MK2YIdsDdTwqxl5yW3nsp6eaxp8EQGYjiDG3EoQ=
X-Received: by 2002:a17:90b:4f43:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-332a951c1c4mr876799a91.12.1758585650223; Mon, 22 Sep 2025
 17:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-7-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 17:00:38 -0700
X-Gm-Features: AS18NWC1CZWCqthlYxUnCsmOmLGnyv-AtBx4VGgT8tNa6SxLYJM3tYnsbTcM8_Q
Message-ID: <CAAVpQUCHQprTy7QBTw9Ufu6u23-3CA9DCW4RJXR=gxojhyQ2qA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] tcp: move tcp_clean_acked to
 tcp_sock_read_tx group
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tp->tcp_clean_acked is fetched in tx path when snd_una is updated.
>
> This field thus belongs to tcp_sock_read_tx group.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

