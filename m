Return-Path: <netdev+bounces-237825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F69C50A61
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EE53B4BE9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC162D77E6;
	Wed, 12 Nov 2025 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRVhWhJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448611B87C9
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762926912; cv=none; b=YISoZNAzWu3HAehLeYcy2ovrff+A8/bDTSykyRQ4TGjL42oEPItD0IagJsZZkk2PrBrJdz5xpbcssOS1lZjk2CVj88TD9neNde3lxRw/dWqT2efs/A2V1aRJ+c6PAWbAR8ypU3kodoyhFUMl+xhn02BUd3G+fjp54Edi+B6gBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762926912; c=relaxed/simple;
	bh=JfzF3PKz1OBmah8CUsnVpIPdOAfNky+3DjmY0+vWLoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8EruSkYfI+zpwpQo5OY1l9Qea6+g1oxMV7bhrPfusVcrWI9Pr9rn2O8+pMKQaPtUWuC/FsQZZ7+HTGK3IYHNY3vVZh5RQbQJsNa0MkGBhVQ2d7Qgzl+LHFnvGTikL1OZ5sembZLyBJYeSO/Lpi7HScmHW/DHLZZruDeU501SlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRVhWhJ6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so315977a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762926911; x=1763531711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfzF3PKz1OBmah8CUsnVpIPdOAfNky+3DjmY0+vWLoo=;
        b=XRVhWhJ6zUFV3ba8aiJRl0BdumANATzC6Rt8CWlSmyNJiLojD5xucKMxA51RvcCWjP
         Ae76Qbx+sJI7tmFjT5ofL4XxB5iJWsCHsClH4ogMLms9iITD5LhXoKemO0+NmEEjwiGs
         PaJrz+VcZjHTS6Gr4Rvx9LJ871Vr5mxWasyQU8YtVb4o5OvBYnwcRowtC3DQmat21VVo
         sRQjDa8/a6a96x/clICuEHvzrAQ8vdV2etCh8i4cvS8Qlkr/CjJH2xyxsoBlBVY3QyoV
         CtliwlEgFoq0IPXij153cUIQ8f8U6sWoEwvmy47S2yij1KeffDTW0REFEpdf1EaUtY/M
         /BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762926911; x=1763531711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JfzF3PKz1OBmah8CUsnVpIPdOAfNky+3DjmY0+vWLoo=;
        b=HoYdtXVioqsfQmIyKWnpBC4yEE3hx9AKEXPQ8y4XJQGUxbeoDKy2QRUypFQO/CWHGf
         P2yJaYpcJbhBDjSbECJL3q3ekLO1rDJ2CTCyjWfvSkxKnZBEWK74rNsOsvUiICI9nfnv
         W4D8Q/g5xI+vHL0HE/vrLbSgMi4jgyNuLVoOTeIc7F9zP25NomfuDkYd7GZe4ApKHeYq
         xs8/IQuxwb2OvuvPL394QXKPB7zOSjt2q0JQMsEaV+2YTYMKbNoiOv5mdruQOZH8uLa2
         gWbu5h+/gShtQX6KaMFO7nuWCXJohB/aEXVzGI5i1AoauBHi7NEu/mbrB3geLrBvrpZ4
         kfYA==
X-Forwarded-Encrypted: i=1; AJvYcCXDHDoQFElUp7623511jVGNo18bvdam6fDTRw/h1CeZ/QkKRgl9qQZhU3RNrft3hc+gJl+wcsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBBko1QB/BEnhJ/3xzY1xlY7UyNW1bRoVDFpHSTqZ9DU1N9Gr
	XFADl74aMDAc9BfkaHUzE3wBOs3oCAtk+dumjNL/iybq36ANABguoUfggGbtFgXuSJXEzHKnp/k
	q2Hy2aTYUqohc25LhuU5Ut0inv+uv3wZhdwDs579+bVuM/OjtkFZ81fiu
X-Gm-Gg: ASbGncunbvyh7vgyOHo9uxneAoQUhG2WZkHRflU/XXXp1mAYIcz4k2jEEwSYkxSMn/u
	62HVDCwp1LtJ4lApM7W6bjiluywJiYq9Y/mxgF1iJJNIp22Xr2XKOWAqGATwGuEA646UXFQOefE
	QttvzrVjXlhDoKtFP8I23uspyepa0/Fp5UGuZIox3ewCwWslApGGa3wqI4YxtOjIcCzsRsw7j7Q
	XY5nRAjh0UzxqIVACrgNtnFPd/DCXnS/n/25C9Gx+883X4rogCoC0I4owgpZ2ZiMmbkzzNO2VD6
	yohRsS4T/HjQBsJqpmcaAx/wUlHupQr9PlJ9PrI=
X-Google-Smtp-Source: AGHT+IH96+vapZzbqznNg/84MqiAM7EOoGUywb5xafRMeYvWp9BwMqCHBXH5nHyco4x+UDs10130DpK7XVi9dz+XQ+U=
X-Received: by 2002:a17:903:15cc:b0:297:f0a8:e84c with SMTP id
 d9443c01a7336-2984edec330mr22210395ad.52.1762926910374; Tue, 11 Nov 2025
 21:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111151235.1903659-1-edumazet@google.com>
In-Reply-To: <20251111151235.1903659-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Nov 2025 21:54:59 -0800
X-Gm-Features: AWmQ_bnEW2xqlnoRWyxEp4D4SlcsoUE1rzM6AFIGrq0VZtW5_L4GRPWrEsWWSkw
Message-ID: <CAAVpQUBw5v4VD7Ekz78t4e8hcvWNbF-cF9RMCBY9WtW3oN6F2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: clear skb->sk in skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:12=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> skb_release_head_state() inlines skb_orphan().
>
> We need to clear skb->sk otherwise we can freeze TCP flows
> on a mostly idle host, because skb_fclone_busy() would
> return true as long as the packet is not yet processed by
> skb_defer_free_flush().
>
> Fixes: 1fcf572211da ("net: allow skb_release_head_state() to be called mu=
ltiple times")
> Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

