Return-Path: <netdev+bounces-241710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80FC878AA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3E3A46C5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9A1367;
	Wed, 26 Nov 2025 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xilbF0HV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2B625
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115372; cv=none; b=eTfxnI0MCRqoUQhDYWG4T0va1pXFczQneGQEKTZZFaTN2XcT2OWP2/p+5dJ/aNTOtoXevrQT6F1fmtTNh8/XTWuOdi2tDsHZ0djfbsTeMKUqvYyherUH3+Qsakz6PeoaYpSY57Uq8KzkiCqv+WK3fcjukhBSXpZ7PuIi8sF6uMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115372; c=relaxed/simple;
	bh=cvffFyY+0GYcfqB7QqkXhnNppE9qXOIP5p6PgNEm1R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGbocweVlDt/8WAB630fw5tjM+moWU3Vi1BXoxHl6ZdIq7Lxl5EZ89YhLf0KrwfJHQdhPMueu4ODIXaFL3Cr1GtAFO72AcgT8TcWthjJaZNOwU3Sc20D+YXzVbRyDtGto61vzGKKiOlN+yyJFxnHT1X6+Bj336l1pXLg16LXnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xilbF0HV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4573224b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764115370; x=1764720170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvffFyY+0GYcfqB7QqkXhnNppE9qXOIP5p6PgNEm1R0=;
        b=xilbF0HVdW7Us0BMASBd+jrciyoNgq2G4RYiNjPsy1hmHf2Z3XQT/MRd6Hm0tr5WY7
         +X2slFW6nhH169WxDPxRNTUodurh2b7fMkqpAprfrYg/sgsJ9LNDrctX4YCqcUw2UpX6
         dOj23SdfeZ6fPhedzLA09FW8s4f5jkjtLGYn2u+E30t0VxelRI6jcI00wzBLa47/4sPj
         x8a8qIod3UpI5OmeBr6JeQSFk3miUZjiucHNDfA/woYgoZsyZUxiGl9JbqDRuiV604v5
         IdjpNT5MzTnWd9U3ZHYcYWTtAZtG5D6uXz/3FHM6dNDJRC4Pko3bW+QCMlQjXFnai+uq
         9fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115370; x=1764720170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvffFyY+0GYcfqB7QqkXhnNppE9qXOIP5p6PgNEm1R0=;
        b=fC2sj4H/+nldOD2YgBQ4IcrunPcH3BGziGSmgcb6DFhLPuJ3pKuMh19LucSR8JjdGB
         aA0fYdauWwz7Sqz11ynuKftXDKY/k5BCZnnVZ4gx/B/93oYODTRoQ58kF0PJbJ7UkrPy
         aIB3/PGQYZIil8c9F59qrEXK37zfkVNHxvQGP6/09eMEo8a9bCmbieIb3pVbFADr6BXx
         yj2u+3Wp6GDFt6kj7LVr5uH3HoEeQiamJPEKiPk7MsrZbdzqWEEjlQvNCb8cOKHoBWuW
         2MRXDbG6yH2G+lXEFdjpzuPxeSobN+ijOG1NdHKNLhMh17zOHj8Ht8Ml5GssWqpehDmB
         SqJw==
X-Forwarded-Encrypted: i=1; AJvYcCWDTJw07YmtCZavOpCsPr9nWB3t9iQ26SJts35qg8rVr3uz6kRCjEzAisHKw3GMMxz7pBUZl3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGZEXeXKNBf36mD+TyVq/m9FOSPectOMXwfFU6oqjDy3ofSC5
	1Z+VxCeLevEcs/t0KD+xweSN34QrkA408NyIm1SiNW24qhJw/dZs5Utms4+u0m632a/3GC56TQT
	jsxdZBXH+t/grwIKicPfzVuwZesTl12uNleOBe4Wf
X-Gm-Gg: ASbGnctqirLAsUp7RSzYRp+FXFYhS1iSN3Z075w6O9ECOy3gRLH+n8U08297dwrRANu
	xTrk6P4IzYvU42OqsC2Tyz06x6XnZEMnxuzvO2CIXIps6g2/b8OenBiM5Kj6wuWS6cSSNweX4M1
	oKJTslP6k94csrzo19UQVDhOJjyZyCZSc3cpsa3P65JM2BpEMAkbIuUjEeijWSrmjaz5GqMwmAd
	/1L+992UeOsneGmXOLGRn32+N8NJIJgiSRf+vAMQ7rY42wLbTvCoj7IdLjXTowB4lCh7+cVRZDq
	bYRQ6Fe8hGIQN7qGoj6XCuhko0fhjp3nB9iKDYO5A7irfIhWZYP9kCe4dg==
X-Google-Smtp-Source: AGHT+IFyDVTYg9ma4tiuVaNdzbFnjS3NU+C96WPZY5AleB5evRf0VAfM3J1CmMenwhOwoPkK8A5DFyHJSMsjZtOakr0=
X-Received: by 2002:a05:7022:4283:b0:11a:6136:1f8d with SMTP id
 a92af1059eb24-11cbba47c89mr3314361c88.22.1764115369534; Tue, 25 Nov 2025
 16:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com> <20251124175013.1473655-3-edumazet@google.com>
In-Reply-To: <20251124175013.1473655-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 25 Nov 2025 16:02:38 -0800
X-Gm-Features: AWmQ_bnjmHNuOKA7uP0taTHAtei-vdfq8VYgO62XhV9ViNluLY5SfxXteELH3Ys
Message-ID: <CAAVpQUChMjc+v8jJrytRnpEu1+PaJ0HTFZiWLdyQtxvY=h4pgA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net: move sk_dst_pending_confirm and
 sk_pacing_status to sock_read_tx group
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> These two fields are mostly read in TCP tx path, move them
> in an more appropriate group for better cache locality.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

