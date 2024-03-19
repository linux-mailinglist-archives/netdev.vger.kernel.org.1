Return-Path: <netdev+bounces-80639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C186C88018A
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE4B283BB1
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392781AC3;
	Tue, 19 Mar 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="asU+2MIz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031581AA5
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864657; cv=none; b=oY9IOzf4EPxnWtm/LWom9/RwkuwxDqU3TdlWeCzlQ/mNc81TwMlH5e/WCssQeHshA8K+NvlnLvS7tAJGsnYX+6SbZyNWmft/G59Khrhu3fXpaPI4U1Ma/NVN5PF5K35S28w/aowRltxwEi5HYNDS+ifKRn0o89GUqbSrecUsm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864657; c=relaxed/simple;
	bh=fKSF8pzEMf4QAy0lGBTclAV9vz3vznJXW70/aPT4oU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaoQy2blmVOhGDPhtxZl5wMXvQwOI5WAzyG25eZUylDfIcEifDwufD+kurTNIJ64iaMmwjdgxNtO21KMM9jy1KFUjqEKZ0POuFlnW66I5VlZXAKUO6tzPLZ0MeecEmeCnAVuGsppglwKPWUG981y0BqEhM5QpgO9Lta9ARHesyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=asU+2MIz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690bff9d4a6so39869336d6.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864654; x=1711469454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=asU+2MIzy8Xp18m3UusmpJeFf5SnsHkQVk6V5/H23Z4PBpv4SJA+14gaCR//LrtKky
         t4hATfX+ba0bP6LJqb91lZzpTtdomG06A5h/nUC0VFZQIOxwubg34THiqSg5i87CyGEX
         DkCh99F9wn6qOZ9Kq3/krOOXF2b+j6+hGqQwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864654; x=1711469454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfOND8/B1sy+/Pxonj2Y99N5MbJN54ZzelPtBRESoQk=;
        b=I6xKu4KxM/WDmAKOPfiFAcz8M9ozT+NQ+QLVNk27azLZnz8B+DxdE1I/N3TPjxNPLN
         2ngblJpRqCT+7OZaelTlAGdANaEvx9jA1SzgjV7T7WdVMsbRy+KxZcUxDCT8NmELwYJL
         QIRhVM164lDEozTads8RGIW35AT7RiZYYyNdFwXV5YkpoE2ZCkyuTJF7/g+Svhh0srdd
         CEs9D/LWJ6+Ndw9OjKg+/ntQYjGV9FYyCOmOBe4DVZm+Cy3mXCxu3On45zINSFsTc4+X
         emb3/7zL7h6urQbehIfrWJ9qUHfq0Ep+3SP8S9+nVKAcSPHKiP8KAwO2Gz8Qay9Ud/bR
         erBg==
X-Forwarded-Encrypted: i=1; AJvYcCUBtmcmnIASJWsZ2hMZnc/aJeu5jbAhFnrVyQuVOAsnixVHTkX59YmdPZk9qcRjpsja/FzI5vxZy99tAsKXeoemXuTiKhnq
X-Gm-Message-State: AOJu0YyFIvNv837TFUiYF8FyuWzZnV4rw3WNIMAboSIql1g1oswuAPiQ
	dx7Eog3T8yLLX/iXQiAaLgOKwp4QQ2ks2hgXTOGEFd4kzdEqlAlbRGSFW+/+jRTLaTFjZYC2dxg
	=
X-Google-Smtp-Source: AGHT+IE+9EIbmJsmcA6tq/VnQe2zC92huy5WbiBHIBpdyOChsV/X1C92iYowi+HIEc6lcEH/YU6wfQ==
X-Received: by 2002:ad4:5a53:0:b0:690:ca82:55f7 with SMTP id ej19-20020ad45a53000000b00690ca8255f7mr14679519qvb.19.1710864654522;
        Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 4-20020a0562140dc400b006940b9ec66fsm3665171qvt.82.2024.03.19.09.10.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430d3fcc511so264381cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0/vLnXWvjIOk1gXtXs0OlhPfNy3LfAiOKOH9aYy9rpQLkac45UNPdGH5+/C3N/a0Q4PEFKXtYVHyYc+QMvmpdriJdiERB
X-Received: by 2002:a05:622a:1648:b0:430:e26f:4bfb with SMTP id
 y8-20020a05622a164800b00430e26f4bfbmr262803qtj.19.1710864653792; Tue, 19 Mar
 2024 09:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-4-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Message-ID: <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> device address in big-endian order when setting it using the
> EDL_WRITE_BD_ADDR_OPCODE command.
>
> Presumably, this is the case for all non-ROME devices which all use the
> EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> use a different command and expect the address in little-endian order).
>
> Reverse the little-endian address before setting it to make sure that
> the address can be configured using tools like btmgmt or using the
> 'local-bd-address' devicetree property.
>
> Note that this can potentially break systems with boot firmware which
> has started relying on the broken behaviour and is incorrectly passing
> the address via devicetree in big-endian order.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Personally, I'd prefer it if you didn't break bisectability with your
series. As it is, if someone applies just the first 3 patches they'll
end up with broken Bluetooth.

IMO the order should be:
1. Binding (currently patch #1)
2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
3. Bluetooth subsystem patch handling the quirk (currently patch #2)
4. Qualcomm change to fix the endianness and handle the quirk squashed
into 1 patch (currently patch #3 + #4)

...and the patch that changes the Qualcomm driver should make it
obvious that it depends on the trogdor DT patch in the change
description.

With patches #3 and #4 combined, feel free to add my Reviewed-by tag
as both patches look fine to me.

-Doug

