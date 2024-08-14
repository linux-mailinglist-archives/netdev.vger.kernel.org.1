Return-Path: <netdev+bounces-118367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B695166C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007431F2367D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D713DDA7;
	Wed, 14 Aug 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uMGrFIFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE913D88E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623448; cv=none; b=TdZ1gW3U2RzKbHFO66/FxPDJF5FYMCEnlTpscSPEzTQlhoneVDTNCW6oeEg7YiQ+qrSbs9To30meKuRi/AFzsVGvKe8QiGL2sjQ2WuTM/f2kLZiiy/wG5nQzLQUxJA5knyIEDTuzEWdXq8YDY1ejlgq1FlNW6LX53EB1fmqwr6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623448; c=relaxed/simple;
	bh=Fw1ZzF4puvC8w/0p/Rm/AdsvzvgJ0Zl7btq/IhBSGQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjiRIjNQapYmKHXUAWgQHmwvzZ3Hs2Gei6fSidw0msnTa7xS8ggsiVJKyRLfY5IIjtLjQv8gzydP8iOMpjzjc6l2WE44TeAxZX8GOHWJvwL9M5VCWV+PSEOve6430ofXpkVox7DRYc2tO2kBWfglZQ12CX704XzRTy0LiwOASA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uMGrFIFI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso11667371e87.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723623444; x=1724228244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2TgENL3xawlLU4YIOAIlHofb+6muDPN75SD/sHSKy0=;
        b=uMGrFIFIEWy/kjEUM7tnh6G2NLfpBBR+l5jkI0cnVmAGJS9r1vL+2s/xHowW3Qt3pQ
         C/WwUf5FvynXPlv0LwsmhpZGDZRBFDcYt1w7P/gNI0WK7HHUEH6Mq7V6ydwqntc+3xs/
         YtEzVNq4j2SQIhGdGwaPIKXX7IdkxkqoJ0Yw1WaaXWgTY2iQ40IblKXMJYKSbDHzUZgh
         kVyOVB7CAWCMj58llZaH2WZ8YfZYROEkJm+8iJ1stUoPVKo3JmJmeSNowplrlXI4IvfL
         3KGg0PYPYBRc7YlZ5NMvIzVzop/K2tUBlvLxooLAGLKDWq/K0DnUXIIcsHV2JeO7OflB
         G3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623444; x=1724228244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2TgENL3xawlLU4YIOAIlHofb+6muDPN75SD/sHSKy0=;
        b=Zyl/PllOKYRK5TB9XpvUf7Ha33CartArcdgY/5VLzc2Bl6BdzgwOj3KyUB0SP8rVxe
         eC02S4GxWYIJ5QGu/Agx7BaaRSeEY3NLy5WhiwAvSUOPUYys4NuzmwgC/CJZaSP9k1A9
         FQaOeO1laZRXWw7okh10zF0C77nhP/UVl60ErhpEkhEsLT/68866RYlNcF7/cL4BS0nk
         Am37sIzdU95Bk4BQScs9Zl+au9ZxyMXFj3C4Op/dNSeYllO1wSzyoeV+/XcFcPEoWYre
         UwoyUQ1vBSJQdfXZ6r6EsPP8xQFU/RXiCat8Aq/1O2SRQesDPMzOwRXxTv7p/LU7fIVf
         w89A==
X-Forwarded-Encrypted: i=1; AJvYcCXLJldVnVQp0+nOhnHr5EKtnwtQLedDgsfDC3kVM7alUAbCoLXZVqQS6kudMN9KkeG1HP5jksL23CnN6nOQa1V9ZhKvcvxg
X-Gm-Message-State: AOJu0Yyx1IurE5YRTmdkgY5qq1uGRUdffwzOTK0rid54xM7ESX5VExPm
	LVZrCPwYthEKL7e5yEJkTjtT+k4CL7Ln3ycJbWhmOScOcYSgeo95JLnz91wiD8Z3mUuJo2HiW0p
	fse+ZR+8Sw/s233I7Wrwh/SnCMupD5sVU8nvd5Q==
X-Google-Smtp-Source: AGHT+IHKjTX3v03zjUihKU1aJBKyTKGdAZsW85MS+ZnqWBZeBvBl+H7h6kwdOiR/LFg4qqcFO1k0iWiGDkGBp9lCNMM=
X-Received: by 2002:a05:6512:3d8a:b0:52c:e10b:cb33 with SMTP id
 2adb3069b0e04-532edbbf006mr1492770e87.50.1723623444198; Wed, 14 Aug 2024
 01:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813190306.154943-1-brgl@bgdev.pl> <172358277338.2007176.5717215982820920385.robh@kernel.org>
In-Reply-To: <172358277338.2007176.5717215982820920385.robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 14 Aug 2024 10:17:12 +0200
Message-ID: <CAMRc=Me+FFH7duM_H6fcxdPd_oTtZGk1TQ_AioWDXb-GQTspQQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: ath11k: document the inputs of the
 ath11k on WCN6855
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	ath11k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
>
> On Tue, 13 Aug 2024 21:03:05 +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the inputs from the PMU of the ath11k module on WCN6855.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../net/wireless/qcom,ath11k-pci.yaml         | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfacmn-supply' is a re=
quired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddaon-supply' is a requi=
red property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddwlcx-supply' is a requ=
ired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddwlmx-supply' is a requ=
ired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfa0p8-supply' is a re=
quired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfa1p2-supply' is a re=
quired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfa1p8-supply' is a re=
quired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddpcie0p9-supply' is a r=
equired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/n=
et/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddpcie1p8-supply' is a r=
equired property
>         from schema $id: http://devicetree.org/schemas/net/wireless/qcom,=
ath11k-pci.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202408=
13190306.154943-1-brgl@bgdev.pl
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

Sorry, I ran dtbs_check but forgot to test the binding document itself.

Bart

