Return-Path: <netdev+bounces-161403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1A9A20F76
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DEB1889AE6
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA961B4159;
	Tue, 28 Jan 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFKDT7Ui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646927452
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084324; cv=none; b=jSSp1g7RRYoevG6rX2MRdzZSasJWBK+wIKQIOql5vQNr9IqOJCguua2t0HObtBVNYLrzWL5miX3sc4fzoXbDBiL0EcZ0I9TerSeOLAzvoO1ZtOjELzY4YKXtJQ34h90HUSLA6LtEzAg0QJBo1kCGZzJ5V8AVOKtzOHOySfdMMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084324; c=relaxed/simple;
	bh=hcQD1fdJZynbKTTaiAhfOXu+zrcKSjiO0b418sCTMgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLWARwyCAWS51AT7CRad1bGNnEHRGo+weJG2VoQPhfcecD6alss83YOr9OjVZ0GNuxFAIFfUU4w9o3zhFEZ+SGHI8c34R3E+OvtN7El57jMhL8Xitkp0Ru3NRGOmPL0AeJu5mum5woNQRtnEzB1TJ1DkcOjO08sWuH9gONOqTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFKDT7Ui; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab69bba49e2so431073966b.2
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738084321; x=1738689121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcQD1fdJZynbKTTaiAhfOXu+zrcKSjiO0b418sCTMgk=;
        b=QFKDT7UigeBPtLLyNjzD77k6K0mQQ2wIPBwotN5pkXZhvepenh7jVTVZzGk4kchI5s
         6sUlOwH3GswVZ4WhlUUJk0dmiHESMtv5dZRWrF/IHXxZNQ+lOzIfnX7IZSFEU5/CDM89
         xa7zPUb4l/tC9kbf2wRfq2PgkshHhXkpJZdd1+ZBtqDohGHA+U5euCsIpEWlu0rh6tND
         sDCZP8TkNBvyMtTQH6W9/4RMDnnDrE8V1hPP/gv4U7AapdXYsNVZLhybe2/j91zxXGuy
         ssILSynhC5RZv5gyeLZdXl9NSNBrmyGoBEK5Z9hgqe+4AnD0aIOHGmmmA6vNFw635r6B
         oICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738084321; x=1738689121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcQD1fdJZynbKTTaiAhfOXu+zrcKSjiO0b418sCTMgk=;
        b=VReP3R9rAsel4MGnOHctSfZqrYH28MxtmpCfkQ2Mig+WIzdOg4vvAwy1t4XOChorKF
         /9Nqqa1SAVt8kYHYjxkQogdxLFaZy84Xuyz2F7dtx9MOqlhFvNXIOjWtpxgJD64HhiAt
         K2ajBuDIKhzwVGgio6Lfl1o1oIyjqXjjUdZWj0Z8LjwiXItFeD3ox5lVBm7UZHNhelrt
         PmON52wYbOjiTtajr2b3XpLeMyR3yf7VyEfSAEKo4jFWsKV0mV9zz9SxuvJF6xhBRVy4
         d4oKK6FD89WFAFsieAQDogd1QSIE8Xlmxz+I9eHqYGkvihmA/MElqze3vU5//zxp0WOA
         TK5Q==
X-Gm-Message-State: AOJu0YwJ4KgkInJnPolxXtBfPqix6GKHw8FxlwTWJkfpZH3/Fii6/KVJ
	zuzrzeuy10PnW+XjMSsx2qm8WTDBiBmH2pD8wODVR5yUofTNsPLeLGOXxM+a3/Auc8z/DehbDYb
	KJITzEZ+hm6nxV+D2PPgSaKgmPhxSk35F735V
X-Gm-Gg: ASbGncsSv4m6JYA0rvJhS5fuiocGcFUfUtX4U7YJvXJ1SLE+yIpGwQ9TiyXrylGp+sH
	Z1gkCxy56lqEJFN7EZVmu7OzbyqtD19oXy+WnNvp76q1+INOifBkngD33rnv4iGVRTOxEoDxM
X-Google-Smtp-Source: AGHT+IGktr9mwYEMzeQ/Y1KJ5FNYumRp4sqnIdMw0E2QJUIbcbrvObVgW0Bw1Pe11l0DKyfu5SCpEaSxTyPgbUft/qI=
X-Received: by 2002:a05:6402:4406:b0:5d9:84ee:ff31 with SMTP id
 4fb4d7f45d1cf-5db7d2dc6d2mr106600123a12.3.1738084321123; Tue, 28 Jan 2025
 09:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127231304.1465565-1-jmaloy@redhat.com> <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
 <415dde0a-2272-45d2-8fa8-473fe7637a78@redhat.com>
In-Reply-To: <415dde0a-2272-45d2-8fa8-473fe7637a78@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 18:11:49 +0100
X-Gm-Features: AWEUYZlm7d16TwJ9isgMknDvaIJJ0fd-5Wq54l2xoSSxmRybdwYXu7YVBF1qNv4
Message-ID: <CANn89i+YRqgg7YncrvRhisqBP8PZcrykNnUUF+tguaMEJG340Q@mail.gmail.com>
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
To: Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com, 
	ncardwell@google.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 5:51=E2=80=AFPM Jon Maloy <jmaloy@redhat.com> wrote=
:

> I clearly stated in a previous comment that this was the case, and that
> it has been fixed now. My reason for posting this is because I still
> think this is a bug, just as I think the way we use rcv_ssthresh in
> _tcp_select)window() is a bug that eventually should be fixed.

I was referring to a wrong statement in the changelog, claiming a
'deadlock situation' ...

It is pretty clear there is no deadlock here, unless the remote TCP
stack is _absolutely_ _broken_.

If you still want to capture this in an official changelog, it would
be nice to clarify this,
to avoid yet another CVE to be filled based on scary sentences
misleading many teams
in the world.

Keep changelogs accurate and factual, so that we can find useful
signals in them.

All your __tcp_cleanup_rbuf() repetitions are simply noise. It does not mat=
ter
if it is called once or ten times.

