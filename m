Return-Path: <netdev+bounces-224181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD42B81C02
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D07A8515
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02DC2C0263;
	Wed, 17 Sep 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIh4oIWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5E22F74F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140711; cv=none; b=DkYI2LL1D08AsImLOvRBaDsuDUdWkazoOceBFsOMD8j8F79bfHYU70gpBVNQs5qpKQsGgNjA+VhMUIrnweS1jNk2NCcihNADDLvX1sTvVRdz4bp6IsQak98Swux8tvKX0aq5L8+JEBE/FJ9bqVJpD/FL8UA8x5Ulh973ELSBlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140711; c=relaxed/simple;
	bh=7dc/T3NiAPYzmFFFppCpGvV8e6oL7rv+p6bbY4Wwh64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gV15xUAFtRPxqPhYmR9bTQ3EjnszwMYrrOaxx2DmwSyA2+SFlWsLR0765FdCPc08+FxoHKqQ/C1YFbHs5NgEObHLP9L/qvN3QsUrxFMy0Lv6/r75YHg0RRcHw1R1cW9UFu3c3EArvKzPMNb7rNc7SiJwyszn7kSBq7bewMiyIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIh4oIWx; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-62340cf6870so76420eaf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758140709; x=1758745509; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7dc/T3NiAPYzmFFFppCpGvV8e6oL7rv+p6bbY4Wwh64=;
        b=KIh4oIWxmqpI+L8QKpmBLPbyMWGZ8UR3nUnENDJG+RP5tFgP4F0bsstTpwgszAtka8
         Gzu/iBkih0j4IDx/qWS3asDPzzmvHcfXl8KD/MrVFMNW6wCKhOmInhH7+PpTn9Hf342T
         oXMG8u9ZVoV6CU32xCnEUkg6HGxl505GM8OiYIRXuuasvlRIXCyE9hxCy9XWzwqTs2DG
         +eyI+JNY540ZcWoogv+CeOzATDGKZEIgtz2V19kYRJDuNSSfbEj2/5DyyMP3Zg2aKVru
         uvVrqQ5TxAZMxHI0KuW8INt9Zoy07aqeIoQvfv7nvs8PUlK+2WjpfaFVhtkSlsVX9wMA
         j2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140709; x=1758745509;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dc/T3NiAPYzmFFFppCpGvV8e6oL7rv+p6bbY4Wwh64=;
        b=IOZOD+hJuzSAxV/vi4HP7MOd0JKRBmeRz6qiWParqIRrXyW8WgjSmyQpJ9X1sjCWNy
         rFg9q4RPYN0dt2GsJd8xaWVLf174eAcHCXTlPMlrWDpUHE3i2j12n7H6mY91d53N5hot
         5vVoruilx1CiqTkmSdTHkQb5i5BxJlVLOgPEhnHTH6D5Lk5zGpy6WSISgld4Va9xdnjP
         qd0TxAscmct/vSkVma7cWWYMv450MG7dKgjnBR6R3S6BWBzE/lQra5nXN9A973IQs816
         4Ud9sSXokbN8xXpkQ18+D/Rvgn1L69y9m03WH8uUmpmF7KYRfFxUpWaR0l8GZJBbyIgg
         EncQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQUndAHDJqUq/gCZ/9p1vlh6GZ4eb5A1KP+XP9I1H3ASWQu+w83QJY01dlXluQmp7AyplNUcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBWQywNjPtbZgVembrPSBZBEjwXq6Zj8Yqx5F3Y0/wBSu0n2+
	Zs76S77imngYm2rkffVTxjs1Q/31vXGoYOddqa0Vyp2h/OHPzLS1meTc
X-Gm-Gg: ASbGncvjlVitn1GpPLzUQzJ4JjJMpnAebuHPk4DliRcHMx9DoYIapN+YCot6FN65Nhs
	Z+JpMUCqPGPRpEjRlc0RoKEhe9/rYlNejhQ1C+Y5JUZDk4HM7ZGlnqpJcuwxmXuI0fJezatPqKe
	By3VbzyY4lpfZGjcyFhesjGcxgUYHeLd81+grONukD/rm3q1u6vN4wL9xuY6RfidQwpKnrT7PTl
	HU3X/t0eVwTKVJaKYtraKLbxKBTNGvQfHQOYREjoZsqFpT+GyK1fzkRCinw+GBgW0Dcn0rdwUNc
	yP8dDW3X/1w/vS3pDzT4Q+Bhe1ED0kFoZ/gux7+SYtlbgt1c4hFeBpFG9dVwZnd8ZsBJziAkhRB
	QuJ8QVmvla9YuEi8wSNnHnMkAJL0XO7NGkFvVAPLojTaPR9VXW5ZpR1WM7dcQ/uH13bAP/YsRZq
	zb+pu2MPIcd4Gpq1i5E6q31Xar3BtHY8t1llrOTGKf3MSgQUtoNsoiRA==
X-Google-Smtp-Source: AGHT+IGhOKVNgPbUMi5QcAEGdZZUFZp3baLhtVrdFIanYhMPSKuTqGIV0Rw8Y8CUPJ7y9QLOU5wEkQ==
X-Received: by 2002:a05:6808:4f62:b0:43d:20c9:9783 with SMTP id 5614622812f47-43d50d83b3amr1772003b6e.40.1758140709345;
        Wed, 17 Sep 2025 13:25:09 -0700 (PDT)
Received: from [10.0.11.20] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c6c7532sm101903b6e.12.2025.09.17.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:25:08 -0700 (PDT)
Message-ID: <caa08e5b15bc35b9f3c24f679c62ded1e8e58925.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, 	netdev@vger.kernel.org, pabeni@redhat.com,
 regressions@lists.linux.dev
Date: Wed, 17 Sep 2025 15:25:07 -0500
In-Reply-To: <20250917184307.999737-1-kuniyu@google.com>
References: <d994dd8855c3977190b23acbe643c536deb3af71.camel@gmail.com>
		 <20250917184307.999737-1-kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Thanks for testing the painful scenario.
>=20
> Could you apply this on top of the previous diff and give it
> another shot ?
>=20
> I think the application hit a race similar to one in 43fb2b30eea7.
Just tested again with latest mainline, but no change. Once suspended,
keyboard becomes inactive and no longer accepts any input, so no way to
switch to tty to view dmesg. The only way to move forward after
suspending is holding down power to hard shutdown, then power back on.
I tried enabling persistence in the systemd journal, then checking
journalctl -k -b -1, but nothing is recorded from dmesg after the
suspend.=20



--=20
 Brian Sampson <brian.scott.sampson@gmail.com>

