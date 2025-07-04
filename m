Return-Path: <netdev+bounces-204187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73098AF96A1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108B454729A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233311CCEE0;
	Fri,  4 Jul 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPbXMW68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A01991D2
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642343; cv=none; b=tXJhieR2puds4iiePkDI5oUG64FaBIvZmBvsjmjCd951D6ibVzyDCoHrapACXeHAxsaho1VmgQE4vsWBwIet3CtoxVOFsmcgU1qIr430AVJ9FjyhUqoAA00pP06fdqb+gyb0ghZkiRQBHSvv2a/3w2XjV53n3yScpJww//7SFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642343; c=relaxed/simple;
	bh=Yqe/pwD7AyGVmoL5xzBOCtjhrEIVJhXck3ab/p8Jlsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+dIVwEu+4NjsefGE4d1Y0s8kaQ3JEBWqky5+iopkK0WQZ6Ek90F/HFqtySY3NyX/ryELBgKfRDvBAo5B1YdiUGHg7XyZRyh1TdHANdMPZD5aH58bZkEYm0lQBPP6DPW47LN0iKCjwiYp6fTsUro0tAL7SyK3hf7SstrBXqbEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPbXMW68; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a5ac8fae12so980811cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751642340; x=1752247140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3GlbbaPlqRv+/DEEtqvv3IB346Z8IPmcH1mAgiGhrk=;
        b=nPbXMW68C5ChNKqhptn1Lttpx41610qHYVhvLMiQGMO2elvvTULRD4Em/9hiI47hDb
         C1JrGSYhHxAvdPCMXXLsGwR7CUx8iZV2UbqKFr7pXkEwfI/XBH9a+qRPt7tp/lNvQazt
         oZYzirz3bzh7hBWUIpahgpqdB4ng0Ily6bYcMjRoYBkMLZ8FD0JNu2x7tIGi2Tpezz0c
         TsS2dMZ50d1lCl7R0pperebQSxR2N1FuV0drUZR+2DkclJ2tt67COe/NRq9feiG0XQ1C
         8CsDT2GbE7rjHBFbvWK91JaPxPZH1ZRbkyiXn4UXZsaR/lzS11QUdOTIaoT1TQHJ5hxR
         CYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751642340; x=1752247140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3GlbbaPlqRv+/DEEtqvv3IB346Z8IPmcH1mAgiGhrk=;
        b=HYizI0TN0sr3atpQGKaKvadhFK8YHUxuCX5MxMYyW8GHNRXH5OEi3RpmpZDcZZY0cp
         xtBdnq3qKJPqKoA/4UwzIShEk+vgt2tc+I/1YhUgQfyRgyQQ/YsuB81UwfANBB+Rp7me
         XvNaijjzLih/hxejBPH/y1qCTnfbX9oOM7eqNtqnSXx+7lQcKdI652hMSzg2miNc8Qg0
         +nSqBZ5JkxYXSj1nI4tduUPfK5ytTh2mmGhRIbpKqYZmQ+12YbRFdSkSj/DXwmazu1Ui
         8u6Cuv+A6qKTjj5bcxT9Nro5QMJ3zqcLnJKWcMv+bjYybVCkEDJqXRlCslvLycCfEyoL
         7Yog==
X-Forwarded-Encrypted: i=1; AJvYcCWxnDeS6lx8nPr3tgpnlvxNDga8e0gSVvkKesRUWLPSu/gNcbkgHBSr4cPb1/Ga5UP5c3bF6LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvc9TrbAQGNYfY/uYnrkitcqBb2mdX0uyTST0nC4uiccfcTDWs
	3kyAb6RO7zGfGp9Ww/X2jJJLbovg5XzSj+DWTWWXFEe+KOaXIr746/Ix7ai8p0s6iYNhDWGG6SS
	V91iLw+PbWpKU7gT2sLKufbkRlXwS41bz++4KTJVq
X-Gm-Gg: ASbGnctjkYA/LCnLoggR92rK5Qpa7HHyujm9etKlXYVkWkDIz7jGKczmu7H1cJCTCyD
	pJHBKEjkcn9Bi8l5xL7DoF+CGuuxPszic1WKNcqGLmMGIeF0XJX2/ipl1bNx9xd17+t4pRwbSg4
	WQ7xVgmLm0V+z9/jQkUfQVFWa7dbB4lOTdwerSSM80znkeQ6YIg0WiltMqIdvyPhUkCumq1pNu5
	QcJ
X-Google-Smtp-Source: AGHT+IGrbmoNwSV4gGCqgdNZ6JBB75TKk2uFeHNZGf7KdVjqOTMILaSAOxzfKQoFn3BwM3eFIdpel65r3G/gKlFf/+k=
X-Received: by 2002:ac8:5794:0:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-4a987e934b9mr8885721cf.10.1751642340067; Fri, 04 Jul 2025
 08:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704144830.246159-1-guoxin0309@gmail.com>
In-Reply-To: <20250704144830.246159-1-guoxin0309@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 4 Jul 2025 11:18:43 -0400
X-Gm-Features: Ac12FXxhRuexo6Ct0veI_79HKLqeASoJEsSPyX8PGv7oJY1ciCfP66dpPoAxAW0
Message-ID: <CADVnQymBGf3OW8oh8PBKXtNpxF5C=FZJTvaQe5TGy3uObZuCOw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update the comment for tcp_process_tlp_ack()
To: "xin.guo" <guoxin0309@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 10:49=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wrot=
e:
>
> As ACK-TLP was published as a standards-track RFC8985,

nit: typo: s/ACK-TLP/RACK-TLP/

> so the comment for tcp_process_tlp_ack() is outdated.
>
> Signed-off-by: xin.guo <guoxin0309@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 79e3bfb0108f..e9e654f09180 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3714,7 +3714,7 @@ static int tcp_replace_ts_recent(struct tcp_sock *t=
p, u32 seq)
>  }
>
>  /* This routine deals with acks during a TLP episode and ends an episode=
 by
> - * resetting tlp_high_seq. Ref: TLP algorithm in draft-ietf-tcpm-rack
> + * resetting tlp_high_seq. Ref: TLP algorithm in RFC8985

Thanks for updating this! This looks good, but in net-next at
6b9fd8857b9fc I see two other outdated references to
draft-ietf-tcpm-rack. Can you please fix the other two as well:

git grep -n draft-ietf-tcpm-rack 6b9fd8857b9fc

6b9fd8857b9fc:Documentation/networking/ip-sysctl.rst:434:       losses
into fast recovery (draft-ietf-tcpm-rack). Note that

6b9fd8857b9fc:net/ipv4/tcp_input.c:3717: * resetting tlp_high_seq.
Ref: TLP algorithm in draft-ietf-tcpm-rack

6b9fd8857b9fc:net/ipv4/tcp_recovery.c:38:/* RACK loss detection (IETF
draft draft-ietf-tcpm-rack-01):

thanks,
neal

