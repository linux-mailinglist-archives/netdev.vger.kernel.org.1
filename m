Return-Path: <netdev+bounces-71391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC485326F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BE0282AC0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7DD56473;
	Tue, 13 Feb 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHmuOcjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950142070
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832759; cv=none; b=bo3d9l9ldyWfV4HJpPLVMt7PBwe7Tak8BHkSfJvjuO95k7fOVof9aRePDEl+om7oaA1leaUIyNHeqf7tAVcU8qw50rLcyPTvUnAn7jV+CqVPjCVKIzQ7PnG9q0tNTFVphfGkLX/gWXag+qPWSqckaDOuPEz7GIIJ7DM/MQRptXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832759; c=relaxed/simple;
	bh=pgftBDN2uuZkJDLJBWLToB3ZWVhkpa+SKo9QQeutc3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFhWDxrMhLOdi5rrtTLkdWTtoMoqFUpkWnwe0Eow9IYvf82YwdfgE4miG7wUq15lZx1aNkTCU2tgJ0yDIHpyQdrDzdoQpVl1QU4YbBfkvOQiB8Pi+nFAssS6TSu6LV79whlspFvB5W2x0EDxYYXntjJSbJx71O80TGU2u+xdMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHmuOcjR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so9956a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707832756; x=1708437556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgftBDN2uuZkJDLJBWLToB3ZWVhkpa+SKo9QQeutc3I=;
        b=QHmuOcjRBtE1zRRjyQgqFheV+t7iIBaodTkEYhuKSxI0XXGZ5aSBy4Zm3fhrUoODI1
         BDl85503ITsFFrQc73w4NTzCahfk/hGXKoryO+m/YzWZG7igIEFAJqRfl6MslIsF6DA/
         4DO5/6d/3C7pPEkvb7ONXYJunG/2G2/nBUsa5cAhBVuas+2AAg0O1OA2TaH/Lto1vu4+
         59Lqq8BZfa/+6y/iNf1FfZ39yDVgD0pdtFc93Ti/+CX0h7EUsEg4fG0JvF4QG+ePcftO
         oGE9q7FAdgvvAhmsgNifz8PbUjjHXhjDQ0bV9XqMUvA0QB0lccnsJhPklJc4gKOe/qoi
         ABRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832756; x=1708437556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgftBDN2uuZkJDLJBWLToB3ZWVhkpa+SKo9QQeutc3I=;
        b=Ze7XMpCepPEg2Ltc/wSHe93DK6BG4Mg5HerNYcVQV24ZUOfvM5Y5mES2qVUwxAY9E2
         WMaYcYeEl5hNTBhTO5tBXkMeC4RbPwKoR8XfqhqRO0XXhePwIan6WyC5bZIBpRG9sjwg
         5XtxEpO8BoYM7M8MpUOzJ46rnfD7P6N0epcFPpWhNVg33eVH11hF6w9X0Fuvt8xea+h1
         0znloIRp9e7IvbV1KAH55Fl0fS8dDNWi3Hx68iXmgK2OtJyWF0I6kLYopF9enXsJGwvO
         drP6aNAh/YbVa9ZthXocYbGjfbsyoj2kDilSGDCd58pB7EwpObCxdFV1OQ8+BIcg+Eo8
         BIIw==
X-Forwarded-Encrypted: i=1; AJvYcCXoY1KPSA5tpNpJhJ72/Fv2e5Jw4F86Vdv1ewNGrojDh5vG1nAuikxWxp76dfkPD7Zjhpukf84VR2+4mu6evlT2GAQ8OQma
X-Gm-Message-State: AOJu0Yz0paP/42+f6a9rjOPM87dP8Q7tgVZ8K7pLAOu45WPyNwh33+9E
	5IznxSACC9GrIqCcRXfIyJGg5MMAm65MMrCp37eCNLO9fG3BXdhpxGS8BqobmeX+QcBH8VgCu6z
	LnYc+XREdMTERy1zwFSws1MMNjfyKgUMYrgRM
X-Google-Smtp-Source: AGHT+IGOP2w+ii6860pR3cpWL2cyj2kdB8PRvexOdRrObaq+iXh+LldmbY/M1ByDZB7Z9kBNi5z935MfcT78gw92r0o=
X-Received: by 2002:a50:9fad:0:b0:55f:cb23:1f1b with SMTP id
 c42-20020a509fad000000b0055fcb231f1bmr151085edf.0.1707832756185; Tue, 13 Feb
 2024 05:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213131205.4309-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240213131205.4309-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 14:59:05 +0100
Message-ID: <CANn89iKd67ADfCpN=4cV1+SQHak93FK73sUwPF3rmycyHzuAkQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: no need to use acceptable for conn_request
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:12=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since tcp_conn_request() always returns zero, there is no need to
> keep the dead code. Remove it then.
>
> Link: https://lore.kernel.org/netdev/CANn89iJwx9b2dUGUKFSV3PF=3DkN5o+kxz3=
A_fHZZsOS4AnXhBNw@mail.gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

