Return-Path: <netdev+bounces-163703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF169A2B65A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3253E7A278B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE32417D2;
	Thu,  6 Feb 2025 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUlvnk1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C02417C0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883173; cv=none; b=axhdURV4e2rXHoGF9HVi1Vui9T82SHtVEFVScZReJTVrhGH/l52HBvu90VpW77qREZHp2EdsuTaucATidDir6yerp9qcsGjCrXGoDx1tde6q6XKH7yuUd+ayr3JleGjTTQAct13gAFo7Rr3p43jw1mafp65ReWklsljKwzctFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883173; c=relaxed/simple;
	bh=rUSvgfNbND99qBCNBUk970XMMlVTlwiRPXuJYX4Zyd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F12So8X+4P+OBjGQWQM0qWgITglPIcV6Ix/fedA6bKh5ConTBHUPDCMoEA1xrtHOnh7O5knKTBWRL2NaYwJEjm2KxaqA0tLpwSO19dxfP/wZXhRFvrBOPRGsrwoeRtU4iMFHQGjd6TyCO7Cuze4qw2diSV18Caw8yt4uCyM358E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUlvnk1M; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f032484d4so58875ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 15:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738883170; x=1739487970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUSvgfNbND99qBCNBUk970XMMlVTlwiRPXuJYX4Zyd4=;
        b=aUlvnk1MszZsdlmYkB6W0VchtC5BFnBkR6eD36/EAzOyV0LlZeH/7vpJJypE8RpY7c
         A7rcJiUvXEaEPQMbZLflf0/cbti3o7GGG4jUJZ/7RgipswPZVvTQdB7tdlM0Vn7gsMEl
         Oc9imyxtD7DHdQr84fY5Lthlj/VDtc2aa2y4iPs/JqEuHyT6/fal18+FCf+ZWLNy0y3j
         2+8yGcfKIxv8QIMbYhdjUuQQe6ZfH6ljaRLqc0sA6oewZtK1Bs/43a+NOVye60AwF80r
         zcNf7DGifuZX1cv7uyO/xszMD/Efv/h1aAy2q2b+wStelpRXkgPH3SjFGHUtlphK12DB
         zTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738883170; x=1739487970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUSvgfNbND99qBCNBUk970XMMlVTlwiRPXuJYX4Zyd4=;
        b=TDmECRAakr+e6Zhy/Tdlvsa9pg3Hdpuu2UZg1UouTAHfwlRhuEblBoC2QrH/ppZn+Y
         yHksIXEX81KBPWjo5vZ8FIoXv/9hfMAKDqc2uEwKEUoYO44fbGySaWL/wtgYt24nghvS
         jyHlIyHur4YvfaNE753rKmLcEGOy9BIk++2zv6WKL391Mv4/KaFQiDIGpR3QJIeJjoVi
         A6nUgVSt1EG6aS7m9tt9xwB6ws7i0IXCCpxuRi0k2luOQhaMqhf95y/XVp+vbAH9CQk6
         jqNbAQdWVW9c8i5rKtGWRHjuE6MMeOos6yUniascOutiI479z5zhnvywlET+Qt1qMcFq
         36Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUoKCpSUHon/LSMUpmManu9kMdQp615lz6iyZdJfhoeJThI3GM2W5R3Q4WCnPuneH55PNHF/Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZIw/VWNXhJkJMBAe5DCPwVR15EmdUxnPNiNDY5Oz7FdLvenF
	nQ3N5RJ3PIutHt0jOJwS816VKSYnJ1cJ4TlN3eA2+r45W/8MivO7zMH6PXQdbfsnMXP5kxZmnnV
	o7qNLhb8vDs6qXuIB2fOHbDX+I87hAUbH1fLQ
X-Gm-Gg: ASbGnctwm1YNgUmxFHeBmQp2BUlyNRDsw7+sjxhO82xFv6PN1+fSaJB7OHCpyr2vGVV
	VCWTw8nVrbcABrSts69Gy+rttEHhZq0CdGVC3Vhg1xZ58Xhr90MwnsYWyztWWA8lA7AuSP+Mc
X-Google-Smtp-Source: AGHT+IFXd7NPJ2C8IqwSDvhUwW8hEDbnUsSB8xSiZQsVhTRFwxD1LkqCQqIpC8KDHqykJBn3iCWF1m6/qyPYNkGXOzw=
X-Received: by 2002:a17:903:46c6:b0:215:4bdd:9919 with SMTP id
 d9443c01a7336-21f52605586mr346645ad.17.1738883169613; Thu, 06 Feb 2025
 15:06:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206225638.1387810-1-kuba@kernel.org> <20250206225638.1387810-2-kuba@kernel.org>
In-Reply-To: <20250206225638.1387810-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 15:05:56 -0800
X-Gm-Features: AWEUYZlarzEyVaVfe3FR4361GMNDdd0j4eARVtGGnfAxxLjgxoJDAhBWBtJsuq4
Message-ID: <CAHS8izNpnB+-Ev1DHZ_nuVTc4gDGQq67BdQ0Gn37MLHX5fBieA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net: refactor netdev_rx_queue_restart()
 to use local qops
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Shorten the lines by storing dev->queue_mgmt_ops in a temp variable.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

