Return-Path: <netdev+bounces-216032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C14AB31990
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576B0189E18E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0099F26D4CE;
	Fri, 22 Aug 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBEZN7qm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579322FB993
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869453; cv=none; b=iceIXZYPop3o1oHFkD4PKRA6wQTPRteGiPNXImr4Snp3N9U0wMdpCjaxprlF0GXnTdxoElqhD0rVV0Y1Xh2joTTe3ZjBWFsXH6CUcbsG0fQi8Dgd3PU263MIBXADIqD+aWPbEirVnFTv4splTFjL6QvGQXXQCD4ptfTAJZAOda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869453; c=relaxed/simple;
	bh=c+lPqVE+fq19dGWLjjKJaor+ziCC59uytMqjLQ+3Hqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ebh5Bjl4JDnJ2AcEHyAioNhPXBT468id5zcHPkjx9/tcphYto8UX0LBR+CtfTcPdF0WPbgR7Uk53rLvp8RmeMd+tSelvO9Bx27lYeokvaEFLTkgSlu95S1zGUIZzDFr6Lv1q/8Nk58tVk1IPBBLa2gQk87/2ccESrVlvRrpI7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBEZN7qm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c482c8so35508081cf.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755869451; x=1756474251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj8FLHuyZdsBV9aUNQpaSkPneUI5MV5B/HAVdbEcw2c=;
        b=tBEZN7qmmyKDlUkG+VBTowkBpXfjxEGUBsqqVwJ95uc6/+uR/BGsvk5MDZMAPmQRIG
         Dsf2Gh58BCpVgtQpPytDzD2E5RihGTosH2r3AelHlxnz54Al4h2lLt0EAYveis5SQkrV
         E7pBN/cFvBy6Cp6Yvi/7Tvr9tZLT8p0BzdUoDY0IsllP30bmJrnc2mgt9LkR5kHqKKeI
         8P9BeJQD9+BQNY02uCftH2lHuU0wHYg7nxgwOXdPBASZOX5yU4zGdW1mjB3VowOiiKtq
         pH8BC7coTiLoxC90oKzQ7klbeJ2LLcduekH9UNzkGVDaSAbfPBBLCKp1CJt0MxoUmVM4
         ACxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869451; x=1756474251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj8FLHuyZdsBV9aUNQpaSkPneUI5MV5B/HAVdbEcw2c=;
        b=ejwZ+5yPW7EdqkXZjM1DrjE46L4m3+94bRptaE5JMwzTxzQv30Gms9/GS2a82J328c
         eq2Nv3sNIt9KG8wWwTHoBfviD6D4VYFcTzA3a67U4JqEskXoIiaEHY0xVBDJF6GEUNHS
         +LP7HzqNoCxcz0McDIZcHEeQW1R10t+CWWZBxmSGFkX2f8kiEVmkctOWey0oMZpkDlWJ
         BQzEh+couipvrWtTnFNLEhSO/h9vcOrga+cCQv3ZBK78DNuf+btRPXKn+uuYJTcVzgmt
         GhJQ7TXYIr5pmwZWjnwGi3tddJ3Wcc2lnCZrsVb+DE6HVrrnuCw4HbnOP9+nUwHvgcN6
         wqUw==
X-Forwarded-Encrypted: i=1; AJvYcCUJjgZ9srLgTNbScoNggxeFnmI7W5z4z04luV6MzWW1W/i6LKaY06rxbxLxw4SxIupt3kostF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZu++bNkbCGssopzmcFwoYUxTJ2AaODoeGIMoce8VW4jEH61G
	CrOggTsvMJWJ57xXDSJl+u4dt3O3N/ui2FDM4yLWAlEIUvwhF1m8QMBwNBFg3rIbSern9JKOo6J
	MwSvtPlXcOqMIKiX+1kpA0EvT6a++DVr0fBnqAOtv
X-Gm-Gg: ASbGncuxcbm4gsL2bZmgMJNtPv+8soyo0PB7SvDfdU4skQfgVYeRS4ub1jt1NOqNMQE
	IJ0v11lksvcLK9U8Mq4WIF7bbYHRorsgMwUp9HeP9tW7G0OraXMsvwRCt91Vtgmi9ol+F9O3CTC
	CyWNGdYQ9AnteZz+rVZNiBrDadKGC6fIdhwolRDYDgGAu4hFtYCcHLdBRsdDlwPWbCHA9L8R66H
	wOxHmZIGz/5FLU=
X-Google-Smtp-Source: AGHT+IE/DsrPeVFd2t2HPGeMZfVohdNRq0ItsJZA8SL1fHpm3DBg3qB0xNOgjuxRi0G22q1SBrfh4QzTv8rltirLhOo=
X-Received: by 2002:ac8:584d:0:b0:4b2:83d8:4e19 with SMTP id
 d75a77b69052e-4b2aab2f2b4mr34638641cf.67.1755869450333; Fri, 22 Aug 2025
 06:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822091727.835869-1-edumazet@google.com> <20250822091727.835869-3-edumazet@google.com>
 <CADVnQy=D7dFCS3ZtQNQsNBuz+6GDsq3NBy=b1BYXQA7E=YyTCA@mail.gmail.com>
In-Reply-To: <CADVnQy=D7dFCS3ZtQNQsNBuz+6GDsq3NBy=b1BYXQA7E=YyTCA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 06:30:39 -0700
X-Gm-Features: Ac12FXyU2_uFefbbgubN-3kt77QQHXk9RMRU-nJATnWeJUOy-2STfM1hQZT3myQ
Message-ID: <CANn89i+5+OhOg2t6oFuiDo3QXQy6nkYMCPaqZuhHyH0E+wVREA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: annotate data-races around icsk->icsk_probes_out
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:22=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Aug 22, 2025 at 5:17=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > icsk->icsk_probes_out is read locklessly from inet_sk_diag_fill(),
> > get_tcp4_sock() and get_tcp6_sock().
> >
> > Add corresponding READ_ONCE()/WRITE_ONCE() annotations.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> > +       WRITE_ONCE(icsk->icsk_probes_out, icsk->icsk_probes_out + 1);
>
> > +                       WRITE_ONCE(icsk->icsk_probes_out, icsk->icsk_pr=
obes_out + 1);
>
> Do we want a READ_ONCE as well for those 2 cases? Like:
>
> WRITE_ONCE(icsk->icsk_probes_out, READ_ONCE (icsk->icsk_probes_out) + 1);
>

READ_ONCE() here is not needed, because we own the socket lock.


> Perhaps it's not strictly necessary, though I see several places in
> the code base that use this approach for increments...

Maybe in contexts where the read can conflict with another parallel write

__inet_hash_connect
...
WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + step=
);

In this case, we do not own a lock on table_perturb[index]

