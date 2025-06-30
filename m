Return-Path: <netdev+bounces-202354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C384AAED84A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C703B90F0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73CC2459E6;
	Mon, 30 Jun 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXfSVQ9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A970245029
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274716; cv=none; b=dfIO57nIiiTOeUA48cRB7iaQF3AS58qAiSc9DkqM5yUGWdKd5aBBBOgHRKjPNV5DtWF/v0tpSpdHNjvFkxE9+fRZuDDMWoPfrmQ/hlQvVivGOH2lFfWo3N2jEOZRJPO0GopQfXXYep8XHvvmtTzRdRvSCq6KJXZ3gU+I++5BxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274716; c=relaxed/simple;
	bh=NHJzgU0aQXfK39wYCmHOvMeydl7411silGVJgkwozwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dfg7wok2MKxhcOAFJkpF2x4GExy+P4VbxHjei41lqgh6bOfSMJspDzGKdImWQ6UI9A8mPomBhUhf790BWgkXFs7r8pu8H2XTlqsy1JWakdlWvT1+c4qoVJvJ+EPc1Hp8lFhrssyikAcLuhVO3wD/puDUJEqwgMVXRi1Xec+7ZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXfSVQ9r; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58f79d6e9so58580581cf.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751274714; x=1751879514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UU13DdMIaksh/X1KjKcl/Raj5wdqxWH1R0ASLRmV2M=;
        b=tXfSVQ9rNVLvEQn/S262F4MAUbzK3EX67lMCCkpm0foF4u9S0N1ntvvwqJhR4Fvn8W
         ClRbpQj+cfoLPAh2BIjvopomjlurSeL+vBSwcR/CasXCW1VQei1PYpRcmtlhNq86iZa6
         ADPVUDq0hjBQ8Znj5LxNq3ScgZeUTYoJXkA50l5dXqd7f8YmuJZwQvSAIsi8YZa9igto
         g+8vY4eJDVMc3vwmDbxsk/B3gMd7eB/7Ch/JRUycJ6IfVUuX6zorePzWaDGGz4LBE2Rw
         /Em12r+Oxt84VffUz4VNzHqY+jZfnJOXYNoOhUWsk9rHa4A51HYMGGZVijfjzt2MLJXM
         Ev+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751274714; x=1751879514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UU13DdMIaksh/X1KjKcl/Raj5wdqxWH1R0ASLRmV2M=;
        b=Uzcwm9cqXdjXk/bVtPM7wBCkUvWqTN+YmLxDbv8sjpYYobPuPay1qErpHvLPpMu94W
         oghbWSyjfVz3AWW8y6EjJpIRNTGQYNAMOcoaIcsMgqgXv6JLSPgg0yVTTN5+YUuIEKWJ
         lrrgBlJnSXaYag4CLLxCVir63GxzjJKQ0wcYXLWCvgRxo+fu3oKgNFoAkWJtJsR/L/Mn
         263+N+FAI9W7mtcGmXGYZzJFQCmBTwpPMDs5ABtFForvlNPMhQo/hrVBdlLunB+IAuPM
         hngH0AUZdDvQgpgduen+2wr8p7MizHbPjRBbLicVXWvcweuhORhNEy3hvcHNcBeBk/Up
         At7g==
X-Forwarded-Encrypted: i=1; AJvYcCUnAtpXBnwYMl146gglbmwlGtuWqWR/6IcPnt6vqzeD4nBix+j4T13pmyZ0UU/EcRnCV3j/b8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcKH8TEvHCStjBRzF3lRKZ5Ay0Qgvm4XymKR/UdYc1M6HoIR4
	M/b4Qsai5ap90gJHL9aWQjGEsFh7Kr2iqAj9E38HUo7LVPgsSKFHdzw+6lN3+te1XOwePmrG3SU
	kxRT67njgUXmG2aoWCvtM3ROkc/+xfeyr0uCvRHXN
X-Gm-Gg: ASbGnctX9FN8wcodH31+/+dedvwC5HE76gtHpLp1cl69I8Odw5koxHXsWdus1dgAy/l
	Tf0d5h8fDQ1epemyB0GnShaFh6sz51dsBqoLeYJgJR4A6qpw8oOk8doQpaSO719M6PMKH/tPL0X
	x7n0A5WR1H6/2XExBcAFpBlx/PuTExU9c3wRR+PUnqOyOD9kT+NL0PyQ==
X-Google-Smtp-Source: AGHT+IH4S1MS+PwPXkrKUOVhav123OJMtGMBPV3RNEHzL2SXQX+WgUbIwZMUSECufylzadW0GY39deoW/5+5+fET5lE=
X-Received: by 2002:a05:622a:34c:b0:494:a436:5af6 with SMTP id
 d75a77b69052e-4a7fcb12fcamr225013811cf.47.1751274713821; Mon, 30 Jun 2025
 02:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025063016045077919B2mfJO_YO81tg6CKfHY@zte.com.cn>
In-Reply-To: <2025063016045077919B2mfJO_YO81tg6CKfHY@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Jun 2025 02:11:42 -0700
X-Gm-Features: Ac12FXx3UzoZ7hTWdmIYc8ImdO8NBaHRWiXy_DXplPKrL4pToPVr0gT-jxkA6CI
Message-ID: <CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4EUsjFg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add retransmission quit reasons to tracepoint
To: xu.xin16@zte.com.cn
Cc: kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	fan.yu9@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 1:05=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Problem
> =3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the retransmission
> may fail for various reasons (e.g., packets stuck in driver queues,
> sequence errors, or routing issues). Currently, these failure reasons
> are internally handled in __tcp_retransmit_skb() but lack visibility to
> userspace, which makes it difficult to diagnose retransmission failures i=
n
> production environments.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D
> This patch adds a reason field to the tcp_retransmit_skb tracepoint,
> enumerating with explicit failure cases:
> TCP_RETRANS_IN_HOST_QUEUE          (packet still queued in driver)
> TCP_RETRANS_END_SEQ_ERROR          (invalid end sequence)
> TCP_RETRANS_TRIM_HEAD_NOMEM      (trim head no memory)
> TCP_RETRANS_UNCLONE_NOMEM    (skb unclone keeptruesize no memory)
> TCP_RETRANS_FRAG_NOMEM       (fragment no memory)
> TCP_RETRANS_ROUTE_FAIL       (routing failure)
> TCP_RETRANS_RCV_ZERO_WINDOW  (closed recevier window)
> TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
> TCP_RETRANS_QUIT_UNDEFINED   (quit reason undefined)

'undefined' ?

>
> Impact
> =3D=3D=3D=3D=3D=3D
> 1. Enables BPF programs to filter retransmission failures by reason.
> 2. Allows precise failure rate monitoring via ftrace.
>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>

Problem is that this patch breaks the original trace point, without
any mention of the potential consequences in the changelog ?

commit e086101b150ae8e99e54ab26101ef3835fa9f48d
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri Oct 13 13:03:16 2017 -0700

    tcp: add a tracepoint for tcp retransmission

