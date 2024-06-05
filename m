Return-Path: <netdev+bounces-101089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10118FD435
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207962857D6
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341F13AA47;
	Wed,  5 Jun 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8fGFWbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80423D7
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609048; cv=none; b=l9SbULi9uIjvVD5oPuPKSYZ2PA4NMwqNkNTa8YhYhtk27uIbFgYPs+6ADUgKdEVl6344vBTUO+V7xrnTltQujrSug31WBbqKQwNf+ILx+BB/h4/0ljNnugbWWh6ArhoTPAfIr0tUTbSSsihvaC+1VM4t4HvNK9sYQUoxJab6BXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609048; c=relaxed/simple;
	bh=VNJYs+kGaMCopwBQ+lusDjSQTVikl64WzNj7Py69ocg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+VC0JCYtjNNl5DkGYUKUBELeUacchuGorDBAjzpk1k01w5Aei0RCjbCoYWscz4m5/Cs+V5bF5sIted35P9s2w2/+BE25w4kW3IvrBLsT6h5lBzzWLDfui9wjGCZnDlPybSF59LI04jzMVXrhoZBr1iOdy6NJSPljLntRiZifKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8fGFWbU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so872a12.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717609045; x=1718213845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRCudjCBZglMVEtFZ1wsBH2p78pn49xRBD8fZ6tyagE=;
        b=o8fGFWbUmy7sg+2z3zHDp5pvWOcu7rmIHx32kgsPC0MFw0eDEIV8vwMEUBhtJuRf+4
         YoTd1c4H8j7QPquPWy8HZ50oN2W6qDC9HC9XzC43YSjEyBgQaLmMH7d8jwduKAs+py50
         YudZjZ5+BInoKJPbYo94i2M5SkHeLF5D2TLLkcczl24PWlYRPGYf/liHqtNobHqNgTDf
         FJ1bqz0kJd94RLrgic7PYeqLtMpcnxmHfMJQ+muXnlSTHqnqkOZL3CAI/55oP4XlgyE5
         93Q8++M2ALq3HbOsroDVDU0lOj+FtXW9fBtutDAfnJU/ydbcZ2IAafFpMOhHVLT3zqu1
         oRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717609045; x=1718213845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRCudjCBZglMVEtFZ1wsBH2p78pn49xRBD8fZ6tyagE=;
        b=Er0yH3OPVKMk+2VVakZh8R3xn8lL1mIHWFEThQpvbUkmtC+7hsD93WBQvDXYQCan9k
         QDFixRv4sY2fpY5mZCyqqUtfVnSJY5RU2WyQi2lLGCZYnw5eRgOdsPWdOmbMdko4roFj
         lQjRNPtwzvHUGb88Bstvqvz69EFMuxRhlKHUVWcy0EgDJssD8i6eFEJBBSF3W+EOqLKV
         4mOeuIhp/Y5x7YNNbzebFSEpDTBZvWxaNkjISzIAw5YKPwZeS/mBx6z7qPUj7oyuyE6o
         K6Ryc7foC9piAAGyjA9n1rZBa0boz6ACXwdX4mgT8I22siyZlH9nU9vDNDQ6v8I+oXPk
         Ewvw==
X-Forwarded-Encrypted: i=1; AJvYcCUaQgqB+j75pEBxpRGPX5iBxJwbmaAyqQTcSQXBFtEx9mE25AGEK0Cril2SrTuJH0AXZdHHkId45nvqd8OExsFUuiniP0wG
X-Gm-Message-State: AOJu0YwmBLmZJR7TuQAvMyE5nESjif2izHzSTig2gKC1ShBsSSdy3CSV
	v42WVvH1crjA31l5G/FcDKbwEO7QGImAApE8xdLSsN9svnhvZt69NwRPeQRT0pmPMKnQVw0INRm
	27fDRbSey5A/CRmfvwWOJRcrzAaXjC6QZapnH
X-Google-Smtp-Source: AGHT+IHLiZlAEQ5p636IbcSei3Znb9UHk7JIdf3DztS9vt2K+vDsJ7rJxBbdtw0ZDwKybVi2W25VMVlMGprcksXuuic=
X-Received: by 2002:aa7:d6c3:0:b0:578:4e12:8e55 with SMTP id
 4fb4d7f45d1cf-57aa6ead48bmr144a12.1.1717609044559; Wed, 05 Jun 2024 10:37:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
 <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com> <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
 <CAJwJo6YVtBaCn+iUEvC7OWa7k9LtC9yReHM=RmuiDUACFympRw@mail.gmail.com>
In-Reply-To: <CAJwJo6YVtBaCn+iUEvC7OWa7k9LtC9yReHM=RmuiDUACFympRw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 19:37:09 +0200
Message-ID: <CANn89i+em+sjuQE32bM2KWg=EFcf-jnfvzD=YekMviUSjARrnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:35=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Eric,
>
> Thanks for the review,
>
> On Wed, 5 Jun 2024 at 09:07, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
> > <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> > >
> > > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > >
> > > Two reasons:
> > > 1. It's grown up enough
> > > 2. In order to not do header spaghetti by including
> > >    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
> > >
> > > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Then we probably do not need EXPORT_SYMBOL(tcp_inbound_md5_hash); anymo=
re ?
>
> Certainly, my bad. I will remove that in v3.
>

No problem, also make it static, in case this was not clear from my comment=
.

