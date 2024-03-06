Return-Path: <netdev+bounces-77802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275438730BF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8F11F272EC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34D5CDF1;
	Wed,  6 Mar 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUNn94dG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED45B1F2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713898; cv=none; b=W8QiIgMweObJrKQy0nSuci57LcffJHiFXXN9ExE9+K7pGxo3T/Oj6VQhxoMv4ZZFfqn2rv66j8dYJaXsM7BXCxBEKMOoXruVQbLRIxFdxSXAtXiMQnbBgIvhhdriFR7UZp2VwQ/BGEPIuavKgFEofn7+CW1mQrMoD8lnf7Dg+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713898; c=relaxed/simple;
	bh=jyJfCp5OfDLV0vJjPYvgRyGpn9ZGCSUjJg2Lp5gPxbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIVuoY00yOaJvnzk3L7jLRrlNgGMxlg6qcGFqKdfFIwH0nOaxTXN7rID9wI3zyFOsNgbf6zpP0UJCu17Gl0TncjjQpiQjP3WcFJOg8jLBok3qO0s8JDElcHW6iUnrkgF13WyQ2SUxrljsOnyrdFV03eam5xcBJmy854RtojRwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUNn94dG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608c40666e0so62660137b3.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713896; x=1710318696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyJfCp5OfDLV0vJjPYvgRyGpn9ZGCSUjJg2Lp5gPxbI=;
        b=GUNn94dGRxdMLZdNrtL+U0o1POZRJ8qfYxFDTmVLBLa44TywyCQrj3mvf2vSdb7fUm
         eZiufHlr0Wsk3K2iAgXsxLBl0XxrtHj9bb5A4LAXVGFoy6GwDt8FHopZc4XoEQ9gdYQf
         jl/0+90/BMPriCrvUBP+i1SYsuV3fVb9VhUP5xyQbwtwNjJTo7dNBp8g4y5t73ehhKAJ
         W3skDC/KFTfRiCbqlQZBeuzuvXWkWIWN8VNheZWfwzzY7D4hzAJxST/Vt1R9eD9soFEa
         FNqoqGNyqUlxMdgstwEI1a8Cx0zTI0UcKO0zdNV2RLgenz33RAF+KgaW+zyZKqvWhVtM
         RtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713896; x=1710318696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyJfCp5OfDLV0vJjPYvgRyGpn9ZGCSUjJg2Lp5gPxbI=;
        b=MRGbp30ILTw8Sqn9z0SnfNKslloqfxaWH7Fp+LaW7FA7HD7U29K+AH1QiepSW7XwZQ
         5gD9c7w5nWubJX6PqgUy+6aFtZ8ubNqnwKVmd/A6gxnCecM80leW/wEU+MGRvC5by31q
         qdpkNMVnblNRPTbsI7uwG95OyvhzwwO5i7R9CSInRUgev7hYHmKkrmBEWwcGUych1wmB
         TG22k3o3IT5cdjvMkVMtOcuR+OljW1657Cg2iYDUi3W/N2hk4Vt5qM5x9yGC+1baPahD
         PJgBuHRilKLE+0XD+sXb+2HCAAxFoNiHRz7a9hLi1duVEkTv6y6gZ/QEKXmly+VMyCc4
         Aq/w==
X-Gm-Message-State: AOJu0YxC4AMDWfoj5eaA43ksrtYWTCFFtvw6PY5OYP2js8CyDrDMNnUx
	ZGY+0eYSco3AtgpKG4SfvFiRq/5O2yXpbDMh/5oCyjNauOJ7U+QHkAGuQ9Xd/ajMLIXIbkfjzDD
	5wY+T09PyK7OhuDakScr893gUhfA/id7laywhuA==
X-Google-Smtp-Source: AGHT+IFe2cHdjC0zImLtE7dX7CjofAAtqRWjocUz6T7nhpqnCF+/HJ3jk1WHZkdRVj+sVVBs8P7hOIo9q8+hxeZwX9c=
X-Received: by 2002:a81:ab4e:0:b0:609:356a:7b22 with SMTP id
 d14-20020a81ab4e000000b00609356a7b22mr12125019ywk.22.1709713896313; Wed, 06
 Mar 2024 00:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-15-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-15-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:31:24 +0100
Message-ID: <CACRpkdbUNtQqTADMmLn+RWHvxMakrVCpXtGShz-=2oiz0pLdCA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 14/16] net: dsa: Define max num of bridges in
 tag8021q implementation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:18=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> Max number of bridges in tag8021q implementation is strictly limited
> by VBID size: 3 bits. But zero is reserved and only 7 values can be used.
>
> This patch adds define which describe maximum possible value.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

