Return-Path: <netdev+bounces-239651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9F6C6AEC7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4A3CB2AD42
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AB29ACF0;
	Tue, 18 Nov 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e+KFKe38"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8535FF49
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486283; cv=none; b=iFL5zkDWaRd+bBr7IxYCN0w1cl4OO3vHY61UYlDyvCRTCzVC51Q2hqIfoPgcVSImhBot/hvjyyqSc1M0qkRVD71CbSXvW8eUU5q6n0n0NMHPPdcwG+2qm9ri2a9dsE+ko5BXik3XhTtl3bvarlCXCF36Qgp91B3a+Am68tGW6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486283; c=relaxed/simple;
	bh=OKgw1vedaeXCNEuMol/qPmGfJfNJCa94IOIyMTRuckA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbJBGByuZIHuYN/R8X4QS5UYiJswUdqgnPIXvja5K1TiP/FcX/T/CkMI+VZutmBKwEtQSAHlfY01vUQHgXyz7gyTQHSw37APByL+QGXsmULI0hp2saMMbGhc6tKsOUY2FURriPsIn+5hBd/QMR1ZPOTcyDxR5BszSX06niyxgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=e+KFKe38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8258C19422
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e+KFKe38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763486280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKgw1vedaeXCNEuMol/qPmGfJfNJCa94IOIyMTRuckA=;
	b=e+KFKe387ifyfmGCh4BsDzcMUntT/o8XuGOPYDNqhOxd1T0OmxeZJOxYSKDXjRi5DKbPWK
	jYQWvs8yVPDXu2pUrPuCogq6JPC0TZgLEMFXUBp8krNXHt4zI39Kg11MBDp6DoS3aAqxPx
	mdEGYE2vQwKvaww6Aq88MKV6Hx7OGJs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ae98e5c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Tue, 18 Nov 2025 17:18:00 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-657244ed2c2so1410937eaf.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:18:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6yhOkzJf4FTFk+DqSWAwKQjq4WEExwtg03mwYf5Z3pjbbh40bjgi9tW5eSPMsvUE3jLoxDSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyf//lR8TATp6zDlJ0vgzDh+COlCco/YdK9aOb/L47DBSQmaa9
	EFtY72LUY0yHDat8JzWwiA0K8QCO4qmdximH+1bIwhaURMUb8EM4rNvrT48Em9mXAMH/Y/7z0g0
	L93QpH71To1A5HXLDNTCIjaRp4T8ZrFo=
X-Google-Smtp-Source: AGHT+IFNBWPDBw5pklBVX5AsBeroJ5RwD1ChkyzYcJ3dQYFKS/DUu0KAj8iexNNzJDzANYb8aYCkwjFzmijeg2aPIeA=
X-Received: by 2002:a05:6808:1b14:b0:44d:a817:2d72 with SMTP id
 5614622812f47-450975f286fmr7795429b6e.60.1763486278386; Tue, 18 Nov 2025
 09:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105183223.89913-1-ast@fiberby.net> <20251105183223.89913-9-ast@fiberby.net>
 <aRyO2mvToYf4yuwY@zx2c4.com> <29155dac-97c4-4213-8db5-194d9109050e@fiberby.net>
In-Reply-To: <29155dac-97c4-4213-8db5-194d9109050e@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 18 Nov 2025 18:17:47 +0100
X-Gmail-Original-Message-ID: <CAHmME9rF3y=p3TzQbHq=LrojgkMKbCUss26a=CzxFnk=9d0A2Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmw7vYCfsPOTfEYsClAYYFzZD6fDs7Gay9mieDLsLV2a_34A_p-eK-nkc0
Message-ID: <CAHmME9rF3y=p3TzQbHq=LrojgkMKbCUss26a=CzxFnk=9d0A2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 08/11] tools: ynl: add sample for wireguard
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 6:16=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
> This extra line can be removed in a few releases, when we don't care
> about compiling these tools on a system with the old header installed.

Sounds good. I'll put this on my calendar to revisit in 6 months.

Jason

