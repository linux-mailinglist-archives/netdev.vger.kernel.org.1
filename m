Return-Path: <netdev+bounces-214080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE940B28299
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9011889E1B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E721FBEBE;
	Fri, 15 Aug 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNV2qv0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176119D081
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270330; cv=none; b=XrN7XGErkT6l596sT0mDtZzwPk9s5Ppr4fw5R9oEK+MYWGFurhDgIH8aktrOaKKJ6/P7P++z3Csl1cCG1Wyq5oFP/jEgAhMQ5AMicUmETIx7GuLx+mDTBT1N9ReCJlBvbMa/MuEQs588rP4/ji5SLNpQRh4WKpTif56nHTmIsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270330; c=relaxed/simple;
	bh=dKLbDrUReBNfvypVob7Qf4D22jVDFl4udMb8HhtJLTE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=IWRgdW9RU45cNEZB2ZIwcREMNMjO24doadWVFE4e1OG2FYyirDJGaENMpwj5c173jAkSB1vODU8pXOQwIA/AJ7gxaJ4Yu9wywEEsdcthCusgshhxnXhRkt517Hw5DjbDt/Io3vdbZl0PRvzutJbF0bSf0zrLxToP7cRe5y/LBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNV2qv0M; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24458263458so17802155ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755270328; x=1755875128; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKLbDrUReBNfvypVob7Qf4D22jVDFl4udMb8HhtJLTE=;
        b=kNV2qv0M0JcMsJoPC0+NRMxuU2WYWwTJ9xAqPmweXCc9vUV9LgfmlrvtmUKc2VfbHy
         uRLqlgm1mFG2irtwvivDioqg+2D/kDfjVNc8sNe+YbWVsxwHfrqtXKwWmhc/aL+NfK8J
         gT6PzMvIXOo5tAss7Zlf6ggYlQ2fTKGVW2poeusNjiQrN5Q1tZbjdUT3+RYeB1y40RQM
         +M7mfRhyZMkxqYKqN0gG6dTGIN9kPeyc2OLcXmeQom/OznxdQ9bag3ssfglB8QuqJb8B
         KkQEGcFw9ZloHgYV2mw5M6PgyUeztI26g5sBG4nS3UMAL71NbPbzaJ0/ePNEwSzFct+F
         wnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270328; x=1755875128;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKLbDrUReBNfvypVob7Qf4D22jVDFl4udMb8HhtJLTE=;
        b=TEqrE/R03Qo9r7vQlGogo+BlM4+s+URfI95r/qPwq+xPMv5ki+bCGuIjZeQNGCNtrH
         FEG+VBNVrRuuRTW9USdSPDOuIT8sePIOC1qQQ8fqMGPU3w45KXH2SnK0vh+N3JB67BQc
         o+dIH8Gd9uvbaOpiZ58frVLIfRld4ZisPpKmhG+sJXF8+DGigcQtwesq7o4goisYZ0NM
         zO0wpU5eHLHyeQcG5Pxe5bjYOiwKOoTCO3ObT7HjxHKaz5eVU2N2gk9SSCggWVmAckgD
         9ko7FMIcF4C0S2+rW0IWv/mPwx6S21tYR4S9vqYDR9JLBHgwU+U01jkJvpOyNVxjLdhx
         pCHg==
X-Gm-Message-State: AOJu0YyKo37StfY/ZCqwuzyLIkM+nKBvP4/ETziwKaXjVp8Gqi9bZufL
	C7AO46XxCx9CeKg+b1Dwa2kmjThla0GB3Mv3nNAHwMSXLmuIY6/x0FTQsr54/TWo
X-Gm-Gg: ASbGncuJsfZNpTupPMKk7BFMY++AZT0RtYOHkzLUW868UTnQ4R14j0ZC00bD7DVCSGL
	1z4ZaHCzPaNOclZFaqlG3CU9ew1oTruGCdhYBWvb3x1Ez8Reg2afnJP5P7sAZYp/yQgvDCTQkFN
	jwwozjXaazIAy0oz15gvfwqa/H10l0SiEcq+mca15sA9AQHuiLzlrk5IGC2zBsuPi4wiZCXSXEH
	L/4nYMYDd6FvzKVdmHHXLFgnDehbFrqJrIHqk8LZLO57VJrL7LvLp8kaPqO4Pu4e36ecOuR4mKM
	/Eq8KE1KVG113IQUiahgrdZR4kMk3GebesYPbL+I8vKctLMhu/T+kOkYGJMc7WlxMUTy/uDhbfb
	VS2+ccrtxz/NEMSfOjyqoJsmg4li+UFMyIFRxVV7o5bjXGtLJ
X-Google-Smtp-Source: AGHT+IHzhp1U6GqElUExJVw6sRkTd0dRoS3PDvcVyzc0GyPecRJ/88YyQ93/IMnn4N5MvbkPj9lBeA==
X-Received: by 2002:a17:903:1252:b0:242:2cad:2f8 with SMTP id d9443c01a7336-2446d748d74mr42033515ad.22.1755270328132;
        Fri, 15 Aug 2025 08:05:28 -0700 (PDT)
Received: from smtpclient.apple ([177.189.100.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d99csm16252735ad.24.2025.08.15.08.05.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:05:27 -0700 (PDT)
From: Guilherme Novaes Lima <acc.guilhermenl@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Seeking guidance on Rust porting for network driver as a learning
 project 
Message-Id: <355E9163-9274-49C3-98AB-7354B9C091B7@gmail.com>
Date: Fri, 15 Aug 2025 12:05:14 -0300
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hello everyone,

I=E2=80=99m a computer science student working on a graduation project =
focused on learning more about the Linux kernel and Rust. I understand =
that the kernel maintainers have been cautious about integrating Rust, =
and my intention is not to push for any immediate changes, but rather to =
explore Rust porting as a learning exercise.

Specifically, I=E2=80=99m interested in working with a network driver to =
get hands-on experience. My goal is to comply fully with the =
community=E2=80=99s expectations and guidelines, and to better =
understand the technical and cultural aspects before considering any =
real contributions in the future.

If there are any maintainers or experienced folks willing to offer =
guidance or suggest a suitable driver for this kind of project, I=E2=80=99=
d be very grateful. I=E2=80=99m not asking anyone to do the work, just =
hoping to learn and engage respectfully with the community.

Thanks for your time and any advice you can share.

Best regards,
Guilherme Lima=

