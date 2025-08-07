Return-Path: <netdev+bounces-212066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48060B1DA93
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 17:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D76A7A3EB6
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79F264A77;
	Thu,  7 Aug 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1J8Wu11l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D214884C
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579379; cv=none; b=CLVWJJHNSjWNNEp8N2kYf7ZVMPevdxwq4kUFPC8j0Wj5Dhww1hYAzDlJZI8+Nnz3DtumN1yyHed89M8aVvhEldEDni6OFfYTwgQop8B5qjLTD/3Ex4jAPwndDDg51WnEM48A+d2HBFOWhNbeZf2E5xvqZGK1eQcRpl7zVjSvBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579379; c=relaxed/simple;
	bh=vXI9Zam5eYCmdhXZAZEND+qlnOZtF3m0aq2gFtw/4+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7A2fGRuWarjMcRTh9IbWLP/RCaEO4naerkmzeyM+iVWtVcg8VEIPAVyKzsUm5H8089lxkp5y1raLkFA1/sW/hvh//RhYC3/R1NisOUmaIf+gMCvB4GMlPKWKj+1xTN7+OUTRSImlhiaVd73ERChzOKB53XxMczBteUjBde/m3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1J8Wu11l; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bf3dafaa5so2239803b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754579377; x=1755184177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXI9Zam5eYCmdhXZAZEND+qlnOZtF3m0aq2gFtw/4+4=;
        b=1J8Wu11l6Gy7VVNO/QwqqYEuaa34gA+Cs7/kv3fet3ag6W3hJrZatjQfMUmWECQ7ni
         soXqdD0BKLYhti0KC+r+cJ6LmVFAFcm+UtRT41bhZ/5s7gHQcOkIlFuRhu1jdLAQI4ga
         4KAawXhziw/1r4vODcSQZ6L/Qk3raaZ6bN8gOO6jmmacDKfw2rjOjHetC99EJAh1gn0P
         HiE1iNCQAsXF3SiZ67qnDK0GL+Vwq2ciNUe2z2TY40bfvQBT4LE+RH62T7he1UTHGt/M
         dYEJ5+QtKwGh0MaT00T7o0dGurtb6XqnugI9YAvOHRGpzMEdn7ybx832QZTQfLh6r0pI
         myLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579377; x=1755184177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXI9Zam5eYCmdhXZAZEND+qlnOZtF3m0aq2gFtw/4+4=;
        b=tEpAHztU113E9I0/ONDf2To1ta1h17M5F8NdYwQuBoY+pGAgOFRxjpkuDye4b02ekh
         EcjjkEpJ6o87Zb6sPZjiv8EEoJbJ0SeQVEi5cGxY7kDnzMrVNRveIuonajjFOG3Ayzto
         wThzwgvpZc77GReqrcLjtB6IQkrpM+WCLdy8J6PK0FAE1nP5OhHbz+xdJi4DEtoBTM5o
         xGHeNfS3iLpANRV7QGMEEhiGcBS6vemSleQqQ1uJQLhWEbDcicI7L01/AOjlyNRJzI8E
         QPw+eLhz3l6V/UAS0ww0pWQAyZWDlHEKcnqHwxmK5BJ5Qr1CE7YbLvULNb4FxQJSVlp+
         mRSg==
X-Forwarded-Encrypted: i=1; AJvYcCVBMrSkcLKtz0H4zTtZWNT2T7WZr7YnGdtldBEHg9E36O96GlJH4R9wkZsI/1iCmVeKD/+U+Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGRXxNbfx4nj8mW8/twlIPv3E1tkAuNpnMz739vMkK/tSqesw
	VwQsjIfCUxqCekKlG9cCUPkSQ/uj8GzmDH+PqMbX+Ka2RClOv/KiQ0Rb63dHeIwZuSHZd0rukxk
	kPHmvEyLCbyqHr0OY/+Kf1i+Rh/cnLydDmbMszqFv
X-Gm-Gg: ASbGncsDP3iQFMGlu9nRU18ES0OZQkByC/au4kk3LKw8cwS5P4RZ9z9oJhiib7vWEKj
	DUN2JlEH4M/NqblJ+MhcVk11QBZBSzsACHSyo71VQZQ9dw/a6kBGJJgwXIRdyaJ/sgGN+aPrwFH
	UKkihBpGDgcHXHmBsiDjWqIiY/G6TFwtXLKOxIJ6Tu9DSvQPdcg0IVm2uR07wjwG7DHHD0QcM6X
	FN3DviNJIwBW9tyuDcheAaq7rjzPrG2OwIDt8J3j5FdeDAL
X-Google-Smtp-Source: AGHT+IG8QlJyGrI/LcZsqPJ4tTpGg3cKXVWXjR1Ly1wLcsKoXFz1GMnQ///H1MLhMEXGNQE8r3JHiVH9uD53B/zlYEk=
X-Received: by 2002:a17:902:f64a:b0:240:4d19:8774 with SMTP id
 d9443c01a7336-242b076a24amr47832795ad.24.1754579376834; Thu, 07 Aug 2025
 08:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722100743.38914e9a@kernel.org> <20250723162547.1395048-1-nogikh@google.com>
 <20250723094720.3e41b6ed@kernel.org> <20250807064116.6aa8e14f@kernel.org>
In-Reply-To: <20250807064116.6aa8e14f@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 7 Aug 2025 17:09:24 +0200
X-Gm-Features: Ac12FXyf-LII2oKhENT74R1IUHeqtiItmnUOlh8HIq0rExOfD6gVb883YMc88zw
Message-ID: <CANp29Y5mZJJgn5LYDiLx11bH__NXZ32ut6VUTsEyXwqrOhksTw@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Jakub Kicinski <kuba@kernel.org>
Cc: dvyukov@google.com, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Aug 7, 2025 at 3:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 23 Jul 2025 09:47:20 -0700 Jakub Kicinski wrote:
> > On Wed, 23 Jul 2025 18:25:47 +0200 Aleksandr Nogikh wrote:
> > > On Tue, 22 Jul 2025 Jakub Kicinski wrote:
> > > > I think this email is missing a References: header ?
> > > > It doesn't get threaded properly.
> > >
> > > Yes, that was indeed a bug that has now been fixed, thanks for
> > > reaching out!
> >
> > Thank you!
>
> One more thing, would it be possible to add / correct the DKIM on these
> messages? Looks like when our bots load the syzbot ci emails from lore
> the DKIM verification fails. I see a X-Google-DKIM-Signature: header,
> but no real DKIM-Signature:

Thanks for letting us know!
Do these bots also face DKIM verification issues with regular syzbot
emails? We send them absolutely the same way, so the problem must
affect all reports.

We use the GAE Mail API, and its documentation[1] says that it signs
emails with DKIM only if a custom domain is configured. Since we send
from the default GAE domain, this would explain the verification
failures.

We'll explore the ways to fix this.

[1] https://cloud.google.com/appengine/docs/standard/services/mail?tab=3Dgo=
#authentication_with_domainkeys_identified_mail_dkim

--=20
Aleksandr

