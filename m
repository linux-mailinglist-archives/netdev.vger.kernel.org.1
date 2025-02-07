Return-Path: <netdev+bounces-164133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCEA2CB81
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160743AEFFB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE31A3144;
	Fri,  7 Feb 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEfx4YA8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7F199E8D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953185; cv=none; b=Po9VfwTqjJ8oV32FdrxuGKqQRZ1xEsuHk6iDeXTfdxq35ruGg2AxoXb5iBvQSq8lXAu6fatybTiLMAunvBQEQycqDarbFyVxie96HB7tXVt1DvGcWEeCIKxxCtc1BI5u43KgcAIbLoSlX7eciVJbe529l2fCV2kh8cRDVGQmzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953185; c=relaxed/simple;
	bh=KFotgUxfmC7ai7PyzaxjdZAl1GAe29TnsnSw34Gvzmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug5UKRUQU/3IpxqMuFrbb4BPEoWGYhLOQZxCeJwNo36elEpR8ff3BYtuBCPFxnJWHN31wUoRcOJ7CtK4TCjA2kmyUTdcmPwz/FE6nsSJ+RyLFDpw3ViwBP+bKccpf+CxI1/NB8SKkcnCp0XFtIcy7/spdNXjujRmftPMq32pStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEfx4YA8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163affd184so12875ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 10:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738953183; x=1739557983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFotgUxfmC7ai7PyzaxjdZAl1GAe29TnsnSw34Gvzmo=;
        b=LEfx4YA8i2YlptRF6xEt3Md0UGpJIkbUXuyFbz0+GWr4wQd0vh1MoxDLJGkmCWLDzb
         2kwTDWZKy24Qsfrqyuq/3uRcEqThd5BNBkiQ7X0oi3kxebcpz6b4fRD27SqBPihf/d5r
         Rzj3jTBN3sST6vngOFmJmO5UP1OAlmNblwVEXhruQOSKOmrRp70k97NMXCPgJilUCAbd
         PNzIBFdJJGk9sGexNC+3Z3mwxVO+HW9VFkyYDdWlrQ2iNrWnkE/Ig/urHTjWRXYRSB2H
         j3cQhK8b0XGm7CVu+GIgSX/YFhWTeqNLiwWxOtPY/PElmFT9TsiKtyCa5n0zka+Gl+Yu
         7+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953183; x=1739557983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFotgUxfmC7ai7PyzaxjdZAl1GAe29TnsnSw34Gvzmo=;
        b=OtWAeR18cC0hzJvfRlnko79Eg163Ak9vUZRC6X/zbOJGWn5nuilkOu9Qa1KZGOvzYl
         ljhl0+9CTTPVBd+E0qoftD6tt7dUmP5Z1hChwwPUTPeuv/VlmQbJBcdnVWHgZuGXJFt/
         fxmGjpyMYV3YbilvILpgBs/s0A2UIFLQx0U6g4ZPtM+xwMSXy0HI6p8TPf+/Rg9MhJt6
         xzGal36NQQNdEwc5UFGaXhqQzVDEp0Yp4C6Mic8GBQ9g6+UMLAnzvaqqUkJsTJl+j0uU
         wc50SIW+VGfalS9YysbrQ0M7rM9HiRhAb/Q28VUXjcXEKIUgkOFCL2pWp5cZG6Y521dT
         AaMA==
X-Forwarded-Encrypted: i=1; AJvYcCX/X4MVFnCh0FKybhW/A8RIgp8nn9sud8xs+lyWCuHPU+r95M2hjF7VEiiSxSCPfeqC11ucxbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxjVugaBJuTRNmFt1wr0fyeGHMFcrh1AXKo+1o+sJDCQCZvx6
	oTdfGMEBSdIOY/GJKAg/Hok8m5FanauE2BxY4K+h773YgbN3VRo+bjcQMK+AWuMWHWCK9xhoFXH
	92DSRz3sZOBy6N0bD4SZAALEvI9mOlyU4hQFsCmqCRd06MPG/t/rz
X-Gm-Gg: ASbGncuB7YEwsqM8Nve0PPv07C3wF3xQqaDIl7HbbisTcX7bMp3TmMLqK4yKOJ3hQV9
	ePSqLWG8fpxcNJK/cjugh5hi8GOdmgLx8pJqnc74eYJaCJvd9PKDXU1yey99qcqupt57WDZ8w
X-Google-Smtp-Source: AGHT+IGdkOU+RI13xBQWaUOd/wbOo4jvt9gqCAHc80EjxhuB0ItJIVoLSEPn1GqroBqJsRXJB90ylZ6PxUDTgJP1w2I=
X-Received: by 2002:a17:903:1a27:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-21f69deebc5mr34745ad.12.1738953183161; Fri, 07 Feb 2025
 10:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207183119.1721424-1-kuba@kernel.org>
In-Reply-To: <20250207183119.1721424-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 7 Feb 2025 10:32:50 -0800
X-Gm-Features: AWEUYZnZliuX8rWa3MXmPQtRIn0btUOZFS0F9oDOzflkwn3pR8toh5q8iLYN5Ck
Message-ID: <CAHS8izP8MtA=JKi+M9yEyXpNMhfVQB0_RF0kCJnwU+BAHpdeEw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: remove an unnecessary libmnl include
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, jdamato@fastly.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> ncdevmem doesn't need libmnl, remove the unnecessary include.
>
> Since YNL doesn't depend on libmnl either, any more, it's actually
> possible to build selftests without having libmnl installed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Whoops, sorry about that.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

