Return-Path: <netdev+bounces-80638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87EF880182
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0852F1C22B46
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449481AA7;
	Tue, 19 Mar 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eM3YBj9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9281AD8
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864634; cv=none; b=KrDQoGsebMr5OQEHq/MhhNifOsKB5JE9oTL6582/izILyV+2u6K6FQZg59dZ7jvlovRjemeSpRIg2Lno1rwHHwvnfuBU41jWUBmiJMdVKC+79pQCFNk3260Xu31nRvto61g3Jw3xDxdQnjbDoUM+TNA4wT2kH0ceW6G6gygd8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864634; c=relaxed/simple;
	bh=FWs6LFKM/xcvvgakZ39skUFNVfNPQgC7Bo//2KPJp+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbVswKZMJiNGGTtR8fE/5oxLQ142EpmInZyVXrh3olNxIG/a3DvicSzCWd6yjJhnQWBSMZN/OQrS0jydjddaQ/1W/vWZCoxu3NIp/xMgJRnkWeD53NBtdcvFsDEmQM59X3jBj28p3X+JrLfnI7VMvzNDnTYFlwSdaO0aVue9lKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eM3YBj9/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-788598094c4so295815185a.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864628; x=1711469428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Suh5QCHeNsdbI/6JZV91e5lppTR9YIcMyoALsn6PjZc=;
        b=eM3YBj9/wWnwAYlxSdq7Ro9SqQiiENW4Nz4K9XerJQ7A0RGjQ2Sm0caYDn18+OopHo
         9GYvo4NeXVSTzrGdHSeR2vfy9hDO9BMJnSRoWTsjEZKlhjJGiZYf36jTEI0mLaDUEru8
         15B/Fbg4Ew9P1I0M8f8LwMHDeMVa4bHtk+mTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864628; x=1711469428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Suh5QCHeNsdbI/6JZV91e5lppTR9YIcMyoALsn6PjZc=;
        b=vywBITwhXlcy4mdkRNRptdUk/ZF/WeSi9Eu4M07PLkHo5b7Fk63+LzCB2FqAPUUyF1
         8v8nA4im1OkJkbr+1oy+bxPpgl8pPezgE3XJSPqXfGOXgfEpusKwjJ0XWtQeuKgaz+qg
         Svt6w5j6RJTbI+UA6DoQ9zOqT00n+dHiQ0ZNwyoxUMEnNgiixwn7VJPcIpkuPVfQ6y8k
         R9JFJQbbfDMq7kOGvxGxQUmnIgT0rogTc/WGZFLUCMSfXwO3IVYL5epH6L6Xoi5c0YYc
         ktBsGEfUiN7n7mV9uqgBZRkNaKPk2qFEt2wIeBvUglVy2fvbCfhtrxlAeSmXveuH5MxU
         Q8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwdMxfbOk4bxUuFhgiZY8z6aZIlKaUJIocFES7M8z1WV0Zm1JjU5mrh6rdHexTmr+x3sn0D6/u66pJpga6dyeO8cJkemND
X-Gm-Message-State: AOJu0Yydwqh5YFpQurnfGYCjlcBtsExXX/Ccr6SPISS7+DsS/pOFDowZ
	kRJzKFq561vyeZNUvaCi7zlYCn6v1QwCf8xmOi3Q2ostc1GJPDjbZEEpzEfZ7mHMl1NXM5iE8BA
	=
X-Google-Smtp-Source: AGHT+IGwzd2rf53g8Elhd6+oYl3657FQHjvpbjzz17afpDyzVbzhk+UBfRBcgmwlL4i9LcX+85PTpg==
X-Received: by 2002:a05:620a:4096:b0:78a:11d5:280b with SMTP id f22-20020a05620a409600b0078a11d5280bmr2982055qko.15.1710864628140;
        Tue, 19 Mar 2024 09:10:28 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id vr17-20020a05620a55b100b00789ea5b08bcsm3537575qkn.23.2024.03.19.09.10.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-428405a0205so373861cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:10:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrBqqAPJ1PpQhjsgGyND03pht1BK766aLuh/Jf6bnmttQI26ChpPpA73GAm+zGRb2DKRCzMLmsWubHzwuciu7jRrb3ikYx
X-Received: by 2002:ac8:5991:0:b0:430:eb3e:d599 with SMTP id
 e17-20020ac85991000000b00430eb3ed599mr197066qte.28.1710864626281; Tue, 19 Mar
 2024 09:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-2-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Message-ID: <CAD=FV=XJ+yAvDn5NyfCSJdg+DujPrWO+DZu=BmcqbJS-ugEGMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
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
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
>
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks.
>
> Add a 'qcom,local-bd-address-broken' property which can be set on these
> platforms to indicate that the boot firmware is using the wrong byte
> order.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-blu=
etooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-blue=
tooth.yaml
> index eba2f3026ab0..e099ef83e7b1 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.=
yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.=
yaml
> @@ -94,6 +94,9 @@ properties:
>
>    local-bd-address: true
>
> +  qcom,local-bd-address-broken: true
> +    description: >
> +      boot firmware is incorrectly passing the address in big-endian ord=
er

Personally, I feel like "qcom,local-bd-address-backwards" or
"qcom,local-bd-address-swapped" would be more documenting but I don't
feel super strongly about it. I guess "broken" makes it more obvious
that this is not just a normal variant that someone should use. If DT
binding folks are happy, I'm happy enough with this solution.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

