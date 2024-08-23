Return-Path: <netdev+bounces-121436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E814795D29F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A801C20B4E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D818BBAA;
	Fri, 23 Aug 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SW8mP8ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9618951F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429533; cv=none; b=bUBSmwehTGN8WJjKcSaclND8vTDsX3LfjtiEiPMSDEh6dFEYq+d9DIsd/4Vugg4NuGKuZSxiWO/LP60+nbKUgZX7trxgaXsZOSWA+RS2UqUwatsCJs7VEriuqWokKmIodBVNOESRqOn7A+qprzlArE1UdrtICLu+czP1wkwBwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429533; c=relaxed/simple;
	bh=x9HeDgtUzI85qaXdWmBXNojHvmN9gKIZ55AlN9BnnFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANzzTPHPxkm/yPKnMPKL5nGDqTPA45vMRB52LTVlbvFGJWNrXCZ95XSWCh1YL6cPS1SBbXHCWHF+XX9zbyWBZwUQ+0FDnJ6+LkhdPK6JbPPXx88rsRLkC/sGMpXl7l+aTTVteYQp5P7TrvCw31nTVcX7rTCbFDRxzdfbBFp6N6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SW8mP8ci; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533488ffb03so2638755e87.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429530; x=1725034330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUtJ+oLA4esiCwHxzR1PJ9WRsZLpLW+urZuZZ82HGUY=;
        b=SW8mP8civONpsBVASNaU+8nXj9ShrbnaRU44Oa4Q/1xfGRdAucLAQp0rmV31HZC2LN
         KFFXXfSAorBnPJMP43IXBMYWUNd7B1499+iQmAlR6/KoWd7VEtUy8YEinxrrCKSx0vD4
         +KrWeDAOHxtzdFjfCp6b3W4MWuSiUsWH6P/7VJvJBgZGCGUReKwi/mAm0FrVy/jpDh0o
         qaAk3BefH2PTXExUYsewvWXshCe8hD1sqjUEXZ3VChiNFDV3U5Z1N2w5AYJGyUANtLEC
         Bw5MU1lRg0ZUU1fZ/mnfCgAcnmAwL7Xuin9Y/EYRiWYJPBk8VWm5SbD3aeLcgI1sXy55
         9Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429530; x=1725034330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUtJ+oLA4esiCwHxzR1PJ9WRsZLpLW+urZuZZ82HGUY=;
        b=n/SSOf+ydfup41yFMO29CbSt3pGyoSA5dFyuwdBB3Uv27zwZUng3naO3EV7an8Bfaw
         WpKzPitmc3PT75cKHoKLbjN9lG8Dm2uIw+F8Ccaq4vpVoJUBNm4tWdExxu+ZueceRFJQ
         UY2Piv9ezueaCe2ME/Y0P8VmcWWenCGXtN33TP8Pj1ACpaLFMk6Kcbw4XHJzumtvuTiB
         PxXYldpj5vptbI6kjSaDb8uHXxu/jGctTe/bprL0d3CYeefYTt7kyK4brNlsIOax2SJ/
         bCeGPMczEl1hvl8RswQLnboJyIJooGUaOnrS9bl/NfEazjwQDPZ3ECHL9kHocOK2OuKZ
         ebmw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kRDoC0T2EJ4TdIDswxfDeYU2dUUYoW+LsPVDk8531M7ZfGjQIuF/GPOGAkogBoMxjcEsGk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyzn833yL3/etY+6bPbmCONbGeCN1AVe+PiF4+lkliwUbex0TY
	GsxFQ0vzf4dW+sW/gCsXU+MyC3x55XSinz1t4a/jMLK+MSGZl4v326/VqkmEmYyFFihqYkxoY0V
	PI3KUcEm02U1XtuoIrO2qfJKBLuZB7LNRWJPhqQ==
X-Google-Smtp-Source: AGHT+IGGfa4J6/rrOmhK+K2Ol6XZFt8xdTBfsTGvDz88zJF2GE3+F2dUfKvoePIHG1HbHuE9HLf0FWj4ywInoY22pyo=
X-Received: by 2002:a05:6512:234b:b0:530:ae99:c7fa with SMTP id
 2adb3069b0e04-5343882e2e1mr2006824e87.10.1724429529236; Fri, 23 Aug 2024
 09:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
 <20240811-dt-bindings-serial-peripheral-props-v1-3-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-3-1dba258b7492@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:11:57 +0200
Message-ID: <CACRpkdYyZRVC-AYfpTG1f6sqrqAg0pCWxzUr7eXYtnM3jacMfA@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: bluetooth: move Bluetooth bindings to
 dedicated directory
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Johan Hovold <johan@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Kaehn <kaehndan@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 8:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Some Bluetooth devices bindings are in net/ and some are in
> net/bluetooth/, so bring some consistency by putting everything in
> net/bluetooth.  Rename few bindings to match preferred naming
> style: "vendor,device".
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Excellent, thanks for cleaning this up.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

