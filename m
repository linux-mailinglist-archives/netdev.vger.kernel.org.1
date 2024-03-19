Return-Path: <netdev+bounces-80642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26188880223
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917B0B25392
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231DE823C9;
	Tue, 19 Mar 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SOQsmgKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A481ADE
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865088; cv=none; b=KopLFdtgCNi6VuRszJjBE4U0VNk57wVInx+SGqCC0rNJLA07c3O+ZutxE/Ido2ctS8gSGFW3tkVjsE4iTitBgAQ52zUyVF7gsW779o3dwPk1gs0aKuJUDMEpb/WzYGnx3ttlJZp/QB9DHKreh1DjbTpPUTrx3cq3KMGi1mj5lpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865088; c=relaxed/simple;
	bh=4BDyA1fp80l7JzPfJ1e9Vcia9HkvY/RtUdxfuRXBrig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAF8d2KbmXB4kaQdiQ8TN8reDYMn2+fbbaYfjLVnbI11QYIAaM1iqPC9cKD0G3JaragXIGYxXuGOArxGWWRZqgo7evmOe1SDjdApCXP6Dwkm/DawqtuKUxkv/Js7FmNaU9jSPDnLj5qFREAvHUInDtJk3qZOZYZa0a7zBqEsK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SOQsmgKs; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c8b777ff8bso143290339f.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710865085; x=1711469885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=SOQsmgKsibTE4ArbHJ3nUEpjM/MWBYwVSBkFtl12ZFI+nUT3Uzee3kThg+OYZLQWXo
         okLv2X5wys9pMP6GFgy5FJxRIXssVheEjQLgughgHDhcASYy97uW0ZUxvpho+g2RdvTX
         DVSt24FAlSBEjKmGEFSYnXaZJ8guVJMgIpMHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865085; x=1711469885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L6WBF/yO8q1qFXY+u+U+qwB52PYKW+UCvdVhNRdhUs=;
        b=VCyc2IvggejE9piDbsqvvWf2EB75QM4RgAoJBG5LSH/EeCZf7dwqVbifKr4veqbgGC
         pqjlh+HPeo24HTNNCrGogzJPCG6Ms/YGeadmG9gjaSDfmqYHz7KMmNPBWewxn9Kn5aUW
         psdUcWzq+OJ6Nt3n9sgHYV5br+LHX9Gv75d2D4bYoVdlp3XdT7jFxViAQvu9Zi2Gnpn2
         oz8rBwa65jgSySyPC0DDnl49H3NwZ9sATeaUlu3hNwFjJt2WqbtHc+XmsyRDXeEu7TNX
         5L5GVW7leYtJAz2rQcTVQwXH2wDmGBjlEcsahPdEttmQwGB/M+ODcgSUAqBunQ7cwIO0
         spbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6fyXis99CKIU/S85dEiw1Q4xXIOrGYr2FR5OCHoYYKZyc8G5gSIsj/jkWCuupscfNiFHR2QxwZv0cSi+RDpUYvsEK0gtA
X-Gm-Message-State: AOJu0Yy/RC7Xh5yYllNUIJMMdmckRqbCWkeZq2Gw3OtC/AuADpwzBgRb
	4tgp8TXDutjO1oiJ0HBW1JkDlsj3qouHumqRPis5E+KXZTKIVl66vy9EyNvu5b0Tp2MgMdndbJ0
	=
X-Google-Smtp-Source: AGHT+IHOQJtpyp+cK+v6PSjcS9rcattfnIYj61e2lrCyEo6C/EaZJzSfYxeOZ73fqSHVX5or5wKz7A==
X-Received: by 2002:a05:6602:21da:b0:7cf:341:4ba2 with SMTP id c26-20020a05660221da00b007cf03414ba2mr1637111ioc.15.1710865084867;
        Tue, 19 Mar 2024 09:18:04 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id r23-20020a6b5d17000000b007cc01c27a76sm2429606iob.55.2024.03.19.09.18.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:18:04 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-366abfd7b09so162565ab.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:18:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/BrxLfwluZ860UnBtzR2HuB14sCUqjfbx5EcvFT5/TxeiWa1LilalRWGFYoKZIg7kwwPGxcyIFmvP1pNV7QV+B0PJWfvn
X-Received: by 2002:a05:622a:11d5:b0:42f:3b05:dc8f with SMTP id
 n21-20020a05622a11d500b0042f3b05dc8fmr390619qtk.8.1710864639829; Tue, 19 Mar
 2024 09:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-3-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Message-ID: <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Some Bluetooth controllers lack persistent storage for the device
> address and instead one can be provided by the boot firmware using the
> 'local-bd-address' devicetree property.
>
> The Bluetooth devicetree bindings clearly states that the address should
> be specified in little-endian order, but due to a long-standing bug in
> the Qualcomm driver which reversed the address some boot firmware has
> been providing the address in big-endian order instead.
>
> Add a new quirk that can be set on platforms with broken firmware and
> use it to reverse the address when parsing the property so that the
> underlying driver bug can be fixed.
>
> Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device addres=
s")
> Cc: stable@vger.kernel.org      # 5.1
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  include/net/bluetooth/hci.h | 9 +++++++++
>  net/bluetooth/hci_sync.c    | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index bdee5d649cc6..191077d8d578 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -176,6 +176,15 @@ enum {
>          */
>         HCI_QUIRK_USE_BDADDR_PROPERTY,
>
> +       /* When this quirk is set, the Bluetooth Device Address provided =
by
> +        * the 'local-bd-address' fwnode property is incorrectly specifie=
d in
> +        * big-endian order.
> +        *
> +        * This quirk can be set before hci_register_dev is called or
> +        * during the hdev->setup vendor callback.
> +        */
> +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,

Like with the binding, I feel like
"HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
"HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
don't feel strongly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

