Return-Path: <netdev+bounces-126687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7898397239D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2AA1F243BD
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A9189F5A;
	Mon,  9 Sep 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cCrsahxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F918C31;
	Mon,  9 Sep 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913612; cv=none; b=ZHcSRiJljibcnTRVCDHzEb2fNOAMjaxrzEtCgWeFrdbV50Eo4NooVcZIZpyWhuxEaa+Z4ksd0EQJ97bLh6TDZAZwVtjROKjoU8K/+X7VxvTLkpc+1II+BqQn449+fJpXWlJacajYS2bDaiQVAdUcDyEzCmcrGogktd0MasAvKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913612; c=relaxed/simple;
	bh=hXtKTqdWWKPLqtm07H2cz2vpFpZqstjIAxUmUCHTUFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3XDTuLQwQM9zYJHhW7HAlGl+UQ3WRxqCZXjBazGqKpo88rgUILJbUwxYDnHeI+OWFOoAzYsGriCq+7UOkw0/PYCfQRCrrzi42hBs2LmAR8qdS8cYAZ9L62JvE/orsJpro+2YG7Ka1/CmUg3HCjV9csvvRROqH/InMyQuyNQU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cCrsahxs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2053a0bd0a6so40415ad.3;
        Mon, 09 Sep 2024 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1725913610; x=1726518410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXtKTqdWWKPLqtm07H2cz2vpFpZqstjIAxUmUCHTUFg=;
        b=cCrsahxsZQHt7TkJzOBDDe8q8JCPeBbS9XbM1Th4dw5vXCB6fpTpiBl3BITv4jli2c
         SsU/uXG6dAOxzCcLU+gVvoJ88xMaDavSYr7pCAJ0TVCQSvdGZppazNe1rM1BhOL3mrGN
         vb5YBDM/yHiJ89DZUxfqEi7WJKW49YYmDXDGFgiVcDAUUgDktXUrfcteoVITzJbLwNjz
         U3SnXaMEitjX+Nwf+uNxbIz5gFNMFvUA2i/0GodyaY+GcewyurQjOiN7CiNUb7zWh+/j
         pBTMScujRwk4Ko28ieuoHSyV2QAupw1GJXvoSMP5Q/dnXgQAcTDmLhxoEElfIYzoo8Ad
         q2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913610; x=1726518410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXtKTqdWWKPLqtm07H2cz2vpFpZqstjIAxUmUCHTUFg=;
        b=wLJZQAmQioYSjuv99IwrGEuTYofKNVhlSwc/EFtggj3JKREZtlc194waiqukBLtTKW
         Xc7r2b5A9TeW9Uf2HP/Bdazc60Vc+U7ekWO5cg97MJM9CjAJpImCMYfOJctw+48GygBd
         6VYJM9PsK9xD820xmwzfWoKZO9egDPhrXnoY1i6ACkpWvM46VBk3zEvGxq20uJJOQmEo
         jy6+kKApKE9T325AXjkjpMfI/HCTNC18cXn8gsZ80d7NQiJ+Dvhzgs9DosCGmYI5Qmnu
         tlQNMDUeeMJZtPTyOHSoRWt4sAUeltnE+I3N2d0TZtdNqshtxEkTwIt1Ze3nW4WMhdTx
         D+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgCV8nwYm4duiyRD7GWNs0zBidh6U/e6RriOYi47f1S/mgSfNG9NfMmUelhrr1yD8+F0ED83ffAGh8@vger.kernel.org, AJvYcCW/GbdAwD3bwKNda/vsOEvXFZAapitlfleCSYjXiaOU0aW5OheukH7ZRlreeX4QumPSuW+Mr9+3@vger.kernel.org, AJvYcCWZBCGhbiGDf1PEEQf9BSdzUlmp07ndOkURb2No4AE8/G4NOGV/urpjpW8JSpS5Xhe5Exdwfo+u0OHM57ax@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oFVGHntE6CLpyN1fi9G8t2fnSgylQJESTl889XbfkHgncOy+
	lI/FFruV3BZ/NNohInz8GOec0m2ZFAnAyXr1xt+pEc+3RgeSldPdwRNBjrXsJsAN9IDpYP0Twmf
	ALyEQw6Feq9b1K83Q55/8kXWXkl0=
X-Google-Smtp-Source: AGHT+IE0yIiSNh7iLrnnnMSnuKkF/A5hQoR5M/1+7xbyC3kDdI8X1yQna/nY992WYvWyyRjnqrcI1fEZ9mQTOFlhE5Q=
X-Received: by 2002:a17:902:ce10:b0:206:928c:bfda with SMTP id
 d9443c01a7336-206f065b8demr138144815ad.56.1725913610159; Mon, 09 Sep 2024
 13:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909172342.487675-2-robh@kernel.org>
In-Reply-To: <20240909172342.487675-2-robh@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 9 Sep 2024 22:26:39 +0200
Message-ID: <CAFBinCDiV1yYHY6curqZ3xSEGSQok24=X6dz2PC91x5e88LRyQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: amlogic,meson-dwmac: Fix
 "amlogic,tx-delay-ns" schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:24=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> The "amlogic,tx-delay-ns" property schema has unnecessary type reference
> as it's a standard unit suffix, and the constraints are in freeform
> text rather than schema.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

