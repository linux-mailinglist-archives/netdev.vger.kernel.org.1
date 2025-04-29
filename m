Return-Path: <netdev+bounces-186798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D422AA12B2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCD91BA412F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166E253F34;
	Tue, 29 Apr 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMCcA1od"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92932522A2;
	Tue, 29 Apr 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945666; cv=none; b=Z3O7aTpGnkhYtbC9AEkvtaxUjVHuFzalLGhhWh8V/HQ8gLFQBdoZuPEUqvWkntKfialJ5as+/zSXNfdKOcLzsYEO0D/Qn4ERRGbU5vTsLTsY1g5T159EQHgWvvoF3M8Yy3gOpcED71ZrB9+QlJ81bxpFmM6wQ89V85Q18eUQe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945666; c=relaxed/simple;
	bh=AdoYyKISP36xJeQD9woyN2YEZghocYxvykppZ9AflqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr8mieE96j94cMt/wnYY8R/S/ztsNGL0vBCqyrlyDP2EutBbj6Q2a9AUwzcIITeFS5czrogRg6++i97KY1ursM37ITSqqxdObZkTB5AINYh1IjVi1aMaTBMCdPJQxtPthmspeSowrfLtBrtW4BeEwX33REfTe31oJe8w9n8Fwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMCcA1od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9792FC4CEF7;
	Tue, 29 Apr 2025 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945666;
	bh=AdoYyKISP36xJeQD9woyN2YEZghocYxvykppZ9AflqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oMCcA1ody40ilGXC0Qybb7DD6sqJxB52dAXTz8M0wbK6IB+bf8EDHo+zzXnykV1B2
	 ZI1MDHferuz/WYILmf64MfVy+QwDtMwoK9hJu5FENIHEjcHPdsmJr8V+2NcyUZWQR/
	 Zdf6orSEajxT7dZqQA6CDJXGCy0o17kNrAxtAudher8AP/WyxvfA6LVxGJvT4OZ6pS
	 0bIxAIDtB15QnFrdc3oEUAdhVzZGoHIszrH1ZT2KmV1CIzLZA5KlnpXlD58F78ji4B
	 Ov8zQU6zZvoTI9gS8fwNBEguGszOBuHXgZ+V74f8H1IwxjKGkr04VtKNjQAL2PJNdg
	 FAAdjY9cCvHBQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1117676566b.1;
        Tue, 29 Apr 2025 09:54:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA6wy6LKyHIWE/uLdFhDoQrCh21Q5Mq21OOZjzan7z8Xv56yoO3P18NBME+R++5GiL8NmCnayM@vger.kernel.org, AJvYcCVQs0Y9bFooAFPxEFfnw5zELioFUW3uMJHjSt5bZmCwuTe54h65WT9JohIEQePN/4ebNRAuF9xeYgU6ASA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eRoh90BjKxmXTGKInplZgFI7V+d58WIIZZZMvtX1s4LZotwv
	3ZRkDqcjn7h5rKsMnV6zuJitYB3Qjvl30qFamazsi7gyPpC8ZUbUyZUakSQKC5Q8ECbSiScqXNs
	1s3gtPcdFgEOBeeJTBvcR6T/Lf/E=
X-Google-Smtp-Source: AGHT+IG7skFkYmrh78r3PBufunbwFhCyH6bMAAQyF6iwtL4SiSNbNImHJcW3bMTneYB2TP8fzRb2vISMbXZRWbUX/Vo=
X-Received: by 2002:a17:907:3d0d:b0:ac7:eb12:dc69 with SMTP id
 a640c23a62f3a-acedc6226e0mr11217966b.28.1745945665026; Tue, 29 Apr 2025
 09:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428105657.3283130-1-wei.fang@nxp.com> <20250428105657.3283130-6-wei.fang@nxp.com>
In-Reply-To: <20250428105657.3283130-6-wei.fang@nxp.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 29 Apr 2025 11:53:47 -0500
X-Gmail-Original-Message-ID: <CAOZdJXWxX6BKqt8=z-dWNO15AunjbhNBkSi5Cpfx6Dn3Yw4BaQ@mail.gmail.com>
X-Gm-Features: ATxdqUH2vDIYWUftzeH4CwoDWqiZzAE9yKFOOu8ghijiqo79WRaU9jaZG_afqrM
Message-ID: <CAOZdJXWxX6BKqt8=z-dWNO15AunjbhNBkSi5Cpfx6Dn3Yw4BaQ@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 05/14] net: enetc: add debugfs interface to
 dump MAC filter
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 6:19=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
> +void enetc_remove_debugfs(struct enetc_si *si)
> +{
> +       debugfs_remove_recursive(si->debugfs_root);

You can just call debugfs_remove() here.  debugfs_remove_recursive()
is deprecated:

void debugfs_remove(struct dentry *dentry);
#define debugfs_remove_recursive debugfs_remove

