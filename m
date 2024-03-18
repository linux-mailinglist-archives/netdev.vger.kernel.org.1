Return-Path: <netdev+bounces-80393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29387E9A7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14203B217B2
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05288381D4;
	Mon, 18 Mar 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guNOzgPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BC33CF1
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766854; cv=none; b=b83d/TvOOYFUXNsGdIV2VtpG+7h9KvYCAQUExQY9DBdd/EJXisQNg2nI9SvCzDZgJ7Kzr+yQjq0U1DLwLlpuN+C6KgXTPKtdlH3EUyQXIZyxEy0VNOxgVZsDpta+e8cQpbgQaOTuULSYXZUQ9JpcSQUMOPZVf012yNJckRJMgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766854; c=relaxed/simple;
	bh=abNTLKYcLXIhe2eOSU6DyOpFwTK4BPqk/0FE1JzWnEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAyDWbdtzWgHNnuQauCp4efFLEN5ghofnTUUeo9Jc7EAj3rOCWiC0ifGxCj2Xp2Uj3mMQ3pBrbYYcehggxULTvZR4xIlgceNXmWZjNpGIO3VvR89SP+OdaJs5/ITkjIBnK2ctcijO8k7eD6VDhujUGFdEH6n99k1Rhk81Af9OLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guNOzgPG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso3821345276.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710766852; x=1711371652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=krtW4aUuwrjQ2jkX8A4jBdsmWsZ29REGKZPPhdTh9uc=;
        b=guNOzgPGHeiyycfe5bqDTRCmhhmnzjQVZ21JIJnG+IdNfTFILcG6WbmBcWnYwHg3dk
         QcnRhwO27DMW/DFy4bCUQYqPpQElRSt6/Baq8IjYSx1iDiiwWZ5fejxRfd+B/CCLVKz5
         2CJSZ5IFz3xDMNS5+VbDD15FcNP8CuZBtAn0+3tZ9Ad2I65nhDHA0oHgvVoGqkcW8XwE
         ehDTgkvHvzE8GI6DA0Dgidf3jt7D9lRs6C5No2H2IhA2UxAHxvnDi9TXwT4qekPdKOVU
         lwWWG2c23SUjzg53W75uUzPXlOIJevBw9+8Pa4/shbVfkv3Xy05uyQqG03Treuq/R5Cy
         gNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766852; x=1711371652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krtW4aUuwrjQ2jkX8A4jBdsmWsZ29REGKZPPhdTh9uc=;
        b=HoEMxs65IIsFnBcUs6xRFD6VO04kaJsZXKs/gjXJC+xfW7RpjYj6Ad824Cw0SiYecX
         YItx08wBA8LNH8hxYvxjeHnLdi39DezP5+bUdKmqM4yuBsmuEpE9vdLHFAvIdyb3QspI
         p3Cm28JdyKK56tGJ5yjOSkUi1o3GnunwxOyVfXh3FMpuwb8CyOgEPctGRPAUlcXso3sQ
         VGYdR7ec9jST1lX4IuQVO6bZePpN/UWNL9OUV3oS8S+XVfUc1kb9G8EXPu9atKSGJihA
         IGaYHjzSlAlHUspYBP2f8474eTG5+tzH3azK/dslPUnLJ1E1FJ+VX3VEBQvqaynJ8C3X
         Jteg==
X-Forwarded-Encrypted: i=1; AJvYcCWdr/3RJIfCGzUt7oSp75DP0njmluNIF61zCRvpXtSDYfPz/A4iDU3d6F7evAz0nwDoDv41fEm9i7++GqSrQsrHTAmUS//T
X-Gm-Message-State: AOJu0Ywrssi0rZzGRR1pi/Od+CvnZUG5J3k8qfZbi/lvurPezlf8r4XG
	80DwwyMIFdVnRyPJuwHnGh5jBrJGVOBHUZmtsU+2OUQkZhVSl/KYW/hRm83WnMsReWpog6gZQWI
	Yiv3US/0clnqEsZUk5Va9Bu3BIJ6Vduxlp0rDpiHxHEGPNT4V
X-Google-Smtp-Source: AGHT+IHNIqyRYAx97Bsm8icZ7FibD5CfXZy6+AclCn9jOAbIEUGiVoB04TJFOEhgeti/W3RP6sRcFIurJfwvOEdKwzA=
X-Received: by 2002:a5b:845:0:b0:dcc:96db:fc0d with SMTP id
 v5-20020a5b0845000000b00dcc96dbfc0dmr6407441ybq.25.1710766851867; Mon, 18 Mar
 2024 06:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110855.31954-1-johan+linaro@kernel.org> <20240318110855.31954-2-johan+linaro@kernel.org>
In-Reply-To: <20240318110855.31954-2-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Mar 2024 15:00:40 +0200
Message-ID: <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991 compatible
 to fix bd_addr
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Doug Anderson <dianders@google.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 13:09, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly says that the address should be specified
> in little-endian order, but due to a long-standing bug in the Qualcomm
> driver which reversed the address some bootloaders have been providing
> the address in big-endian order instead.
>
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks. To maintain backwards compatibility, mark the
> current compatible string as deprecated and add a new
> 'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
> binding.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../net/bluetooth/qualcomm-bluetooth.yaml     | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index eba2f3026ab0..b6fce6d02138 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -15,18 +15,22 @@ description:
>
>  properties:
>    compatible:
> -    enum:
> -      - qcom,qca2066-bt
> -      - qcom,qca6174-bt
> -      - qcom,qca9377-bt
> -      - qcom,wcn3988-bt
> -      - qcom,wcn3990-bt
> -      - qcom,wcn3991-bt
> -      - qcom,wcn3998-bt
> -      - qcom,qca6390-bt
> -      - qcom,wcn6750-bt
> -      - qcom,wcn6855-bt
> -      - qcom,wcn7850-bt
> +    oneOf:
> +      - enum:
> +          - qcom,qca2066-bt
> +          - qcom,qca6174-bt
> +          - qcom,qca9377-bt
> +          - qcom,wcn3988-bt
> +          - qcom,wcn3990-bt
> +          - qcom,wcn3991-bt-bdaddr-le

This compatible doesn't describe new hardware kind. As such, I think,
the better way would be to continue using qcom,wcn3991-bt compatible
string + add some kind of qcom,bt-addr-le property.

> +          - qcom,wcn3998-bt
> +          - qcom,qca6390-bt
> +          - qcom,wcn6750-bt
> +          - qcom,wcn6855-bt
> +          - qcom,wcn7850-bt
> +      - enum:
> +          - qcom,wcn3991-bt
> +        deprecated: true
>
>    enable-gpios:
>      maxItems: 1
> @@ -122,6 +126,7 @@ allOf:
>                - qcom,wcn3988-bt
>                - qcom,wcn3990-bt
>                - qcom,wcn3991-bt
> +              - qcom,wcn3991-bt-bdaddr-le
>                - qcom,wcn3998-bt
>      then:
>        required:
> --
> 2.43.2
>
>


-- 
With best wishes
Dmitry

