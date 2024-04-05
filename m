Return-Path: <netdev+bounces-85223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE95899D18
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F131F214F6
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52316D31F;
	Fri,  5 Apr 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTSfYwsW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44516C857
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320484; cv=none; b=BLPWH25TOwdGPNa09pw5j9hl1cvV86fjMh5ho/yVBoaBEUGI56Jvfzw2e4Dt36+diqUtMPoXyFg32+notsTncjqGRyFd0DIuNb4F/4BlyLpHRWwef8BQZesdsn+w79PuphocmQhvaOS0sy6yawUtGy7QoGyJnBlPf9ryaw1fL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320484; c=relaxed/simple;
	bh=BWbY/KZqhbCE40wnvC4PrO70/N6mw5Yg/TSOavfYMW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsVwkpKyrUp+jE0knk7iBeAASA4wDkRF44X83Mj6wqGxiBZKqtGmDwYXfxycIbYsdRrzAZC8hfBxRi/Jo6hUee1oyYCBRGx+5wJez8q5J3dTVK1vY76q1qvKidQCVBy0GNc5VO1eYw3XnQcnG1qbleYNGWYCkwzziktWKNUU+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BTSfYwsW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6154a1812ffso22086027b3.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712320480; x=1712925280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2N0mn42V43jKjndtGzZY3LzMYKGKo3zYQTHJIkNMpNM=;
        b=BTSfYwsWCoqZZH32oDYnrXtrdpOCurlcDMXRZE91dYNqKJ2/h86iTFn3+45swiUc1Z
         Ymbduk/5zJCypoowvSasv2ji8qGvJCoM8YVpNu89B8Dgr0GtEsPqtbeEdBKpzd/znF4q
         AAL5VQBFjpD6ihZn0PN3S27TreJeJCYfdwVi89vdgqMofSnq5H/aG+zf5E2opDKG9zVc
         h9gybZkMkr9dRC3jzSVl8MwxubWxdlgnV008LdN+7uzMO4HMxVH3msmv38awTOzRM3LR
         p+Q7Tx8cDtST79ze0KYAnrwKZUsX8UMOfKQUag2GyAuqKFhdlK5XIWYbYEYh2/3XX8Up
         d6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320480; x=1712925280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N0mn42V43jKjndtGzZY3LzMYKGKo3zYQTHJIkNMpNM=;
        b=l+VK7C1DeWQFwARHxgJ1CY8r5fYO25WfgoiZMv+TFao8RsLehzGUI2BRPzIdmT0imY
         uM9Ymw2AkcF79ch0HHnz3Styq/rY3H5nZvp39lHcTDZhtvCeYJ3bXjdJOIdtlIpgLFqO
         6G9O0EtuighMg9+vGdRvXdNtW5bTsuKIDd8Wq8lP+lJquLQrP5aUY11szmSSukV3Wl58
         M53dO0JgzPaougHrz9KEiCHXF024ijk9YS+VCgm3n8MmDYseHegDrEXLHKIrvg64YGQN
         hQUBYOladljx0LDU2Ga3sQ0kDkP1Wsh6rt1IEEpnW5u7g2JSruTW+MDOTfNKvRXR8Es4
         I3vw==
X-Forwarded-Encrypted: i=1; AJvYcCWPkRVLTmoQp+9Md18wEGtBmRrK2IdlcGCkdlonI2HF/Vk0jzVGOxMLNapAXbIAW8JYLkK2RYI+A0Ris9KC+hyMOYShuToG
X-Gm-Message-State: AOJu0YzqL72YSR/szZVJ+9ALLiIXHILbfIUSpKu7LxpXvLc94REOKQ+/
	tFhvXnSF5GnAWkK2R7XmLt3G3e+TYDUbj5fRnEQ2E4yi9L4uIlfT4SbsYJACZmT/8pSqTPGYckj
	ie7CwVp05OeX/lqh9P9MvPoUmwgLrXjOYbYVxcg==
X-Google-Smtp-Source: AGHT+IE9DTe1wMuQT2hdnEiCQgQhxlwsyKj6itvCyFDOKo18zC+YU88RGgr44hqjEdcdyfD3OgM/EC6WOGEFKxTjcZ0=
X-Received: by 2002:a25:800c:0:b0:dc7:4367:2527 with SMTP id
 m12-20020a25800c000000b00dc743672527mr1236431ybk.49.1712320480356; Fri, 05
 Apr 2024 05:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
 <87plw7hgt4.fsf@kernel.org> <CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
 <87cys7hard.fsf@kernel.org> <CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
 <87v85wg39y.fsf@kernel.org> <CAA8EJpq_XLUEMC67ck2tZRjqS0PazCkQWWMGmwydeWxTETHwcg@mail.gmail.com>
 <871q7k3tnq.fsf@kernel.org>
In-Reply-To: <871q7k3tnq.fsf@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 15:34:29 +0300
Message-ID: <CAA8EJppASEmj6-Jt7OCABAeqr8umSgXaDDha9nn2nRafuZ-Gvw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware overrides
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 15:01, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > On Fri, 8 Mar 2024 at 17:19, Kalle Valo <kvalo@kernel.org> wrote:
> >>
> >> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> >>
> >> >> To be on the safe side using 'qcom-rb1' makes sense but on the other
> >> >> hand that means we need to update linux-firmware (basically add a new
> >> >> symlink) everytime a new product is added. But are there going to be
> >> >> that many new ath10k based products?
> >> >>
> >> >> Using 'qcm2290' is easier because for a new product then there only
> >> >> needs to be a change in DTS and no need to change anything
> >> >> linux-firmware. But here the risk is that if there's actually two
> >> >> different ath10k firmware branches for 'qcm2290'. If that ever happens
> >> >> (I hope not) I guess we could solve that by adding new 'qcm2290-foo'
> >> >> directory?
> >> >>
> >> >> But I don't really know, thoughts?
> >> >
> >> > After some thought, I'd suggest to follow approach taken by the rest
> >> > of qcom firmware:
> >>
> >> Can you provide pointers to those cases?
> >
> > https://gitlab.com/kernel-firmware/linux-firmware/-/tree/main/qcom/sc8280xp/LENOVO/21BX
> >
> >>
> >> > put a default (accepted by non-secured hardware) firmware to SoC dir
> >> > and then put a vendor-specific firmware into subdir. If any of such
> >> > vendors appear, we might even implement structural fallback: first
> >> > look into sdm845/Google/blueline, then in sdm845/Google, sdm845/ and
> >> > finally just under hw1.0.
> >>
> >> Honestly that looks quite compilicated compared to having just one
> >> sub-directory. How will ath10k find the directory names (or I vendor and
> >> model names) like 'Google' or 'blueline' in this example?
> >
> > I was thinking about the firmware-name = "sdm845/Google/blueline". But
> > this can be really simpler, firmware-name = "blueline" or
> > "sdm845/blueline" with no need for fallbacks.
>
> I have been also thinking about this and I would prefer not to have the
> fallbacks. But good if you agree with that.
>
> IMHO just "sdm845-blueline" would be the most simple. I don't see the
> point of having a directory structure when there are not that many
> directories really. But this is just cosmetics.

It is "not many directories" if we are thinking about the
linux-firmware or open devices. But once embedded distros start
picking this up for the supported devices, this can quickly become a
nuisance. We have been there for Qualcomm DSP firmware and we ended up
adopting the SoC/vendor/device structure, because otherwise it becomes
a bedlam.

> > My point is that the firmware-name provides the possibility to handle
> > that in different ways.
>
> Very good, thanks.

Thanks for your suggestions and for picking the patches.

Bjorn, could you please pick up the DT patches now?

-- 
With best wishes
Dmitry

