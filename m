Return-Path: <netdev+bounces-80640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BB4880193
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866DE1F22E70
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7382883;
	Tue, 19 Mar 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lF4Ir/Fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AC823BE
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864678; cv=none; b=sMC0Ar5zQaDXJSUWwRwv1CmVk1BkDupiXrrfKkeXpst21Z9fkBbrNy7/DeCh2I6k03BxeRNiUyjZyMPcOKrOK8E6NMEm768FH59b/d3PFeUyfLD8dvKrCP85fOFRLP373Nv/iKxEi2IJQlGsoz9M6H3Fvh4uTg6izgpcBIYtj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864678; c=relaxed/simple;
	bh=rYjMj7ePgUflQEILg5XkDq3SlXHXtDYoYHvIrr8ecTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alG4fw0KTPB+dLv7zfQC1AO6pn5QAmXPkU6eV3IP3dq8g/RuACe7RBO8sUjDAkQkI/624aZv37oUIvmp9DrlNKpsjOKz9oRMvqzb2Z+m2nCQz1yFXrjMoocHUUYwHEVxvy1gOWzdn3y/BRc6Ab9F8s7Uora8cO3LNXbiBU5Q9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lF4Ir/Fw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789f3bbe3d6so193459585a.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864673; x=1711469473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=lF4Ir/FwKWl4PUdieCSv+Zv7EdBjdE+sm/bOgiFIEBq5uCwDsryMcKLQ5m0lf7Hk9x
         l66LD2jd8mIMh6/xNRfvq9dlEe0VU9q8jwypVLz5u+G8y9ewoyWFuqhCBT50atSE6ij5
         uPGRX0ra4yj+53w58X70+UgmxIDJwAzLiHaRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864673; x=1711469473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=M3qiRH+xM58SPXsDgAwfBVsDISthe3JjwcWTRfrtVFANhXjnCsK2AQya0YuE/WJubt
         YqKOFb+os+2O94cwo2XdWYfJbegzYfKdfDJFS9I72IqWQxPdSpAonnCx0wjyBhCubjd3
         +UJJmWzk1b0WUeD6VfyNDldq26COTq1UHfHVyPx8TCE8DD/tDi9HyDFC4hzBWcvN5yP5
         UGOokFWS9NmrkoGf+LCH7RgmkGN60lCzmLP/oRoSC+0bJCYrDV9EnmqhYc4U5DvDprTw
         nnQeOypyK7YdNZDk27+479ridme8QSQ94eUpEYvMRAVwMvcA459NQvc87BUpp4VVdHyf
         EyKA==
X-Forwarded-Encrypted: i=1; AJvYcCVHORHO7cmS5RSImGMM3qcoe2w48dDQKaSJLg2hC6V5r6rQixDzEDLnAbO2+bqG1bKTEYARBdGjoEuUSGYnpAesmcXCafUy
X-Gm-Message-State: AOJu0Yxeqk4JiJ3JLYLr0Gd0gz/73C2y4ubAvWD1xGXqaIOgboQqCMj5
	bt4B5nBlDQ1nmGdP7lLEGQgBFXbnV9FOHlz0HBFsTwgbkpvW5Tf3hlkD4+IPLVGD9b/Vg4mUuw0
	=
X-Google-Smtp-Source: AGHT+IGnGB9JjWNXJS6OcOGEtRrCkft4c3i0i15ZM/Z/nnEIt0+Hk3L5Py9vXiBcxVrz2N3md/O0Kg==
X-Received: by 2002:a05:6214:5605:b0:691:59ad:ff48 with SMTP id mg5-20020a056214560500b0069159adff48mr2833958qvb.28.1710864673290;
        Tue, 19 Mar 2024 09:11:13 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056214260f00b006905c8b37bbsm6597052qvb.133.2024.03.19.09.11.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:11:12 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so374311cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvAc1iVT9TJokUxt7A/yrgM+0AhNUHh5RDAMqLrLmz/oht8AhTded9/31fRzg1xMQV/pHshT6jeQAaa3J9r048T4lJjY/d
X-Received: by 2002:ac8:7c44:0:b0:430:bcaa:187 with SMTP id
 o4-20020ac87c44000000b00430bcaa0187mr392494qtv.18.1710864671219; Tue, 19 Mar
 2024 09:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-6-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sc7180-trogdor: mark bluetooth
 address as broken
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
	Rob Clark <robdclark@chromium.org>
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
> The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
> so mark the 'local-bd-address' property as broken to maintain backwards
> compatibility with older firmware when fixing the underlying driver bug.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogd=
or and lazor dt")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Assuming DT bindings folks Ack the binding, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

