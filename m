Return-Path: <netdev+bounces-80439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D487EC1A
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D0628112E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F5C4F206;
	Mon, 18 Mar 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ho4NZNqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59674F1F6
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775605; cv=none; b=izqUmV4iTyPzBJI0AR2/hXPCyjttvG/KbOj0YJICD69QTiCCPCncJ+7QhZox+nkXAOT4gxHpOKLxAgZW0v1BqVWQ1E/6DZ/Ghhhec1LUMsa9kHXXRIlqArs6YQysnD6Bk3v9a+7HZqjZqMKaO3hCreOJB+GHYTtzhoRs0BmtYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775605; c=relaxed/simple;
	bh=PhWdZeNBOqRnQlySupzqWY3j6i3+Ipt/UkCpMfvZd/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxSewKYbmE21k0Kq8VvGDRTxeUzF4Mr3N3mL0UlgbBY4P6nhTCpplpcS8nF9Z82eZUCfvrjWEsxwyLDo4AjPIK1QvgyI4gKchOJdlcH8xTFGdBFFa2vZ6AjBKeUlt+iI5SohddPr/SAM6ohxq6t65qgfYiTOi2JrTU4UXcy9kXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ho4NZNqm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430e1e06e75so71531cf.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710775603; x=1711380403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hv/QWr8M8ls7knB1wZCVGtf2AvJWRUgL6rtvFRG9dk=;
        b=ho4NZNqmCiLQ7HWHlsIjzcX9Rm4CtT9YQXvjax3No5poNUDL7DxYEj3uJoeKgEp4/v
         viaCB3yR2Yvn5HTvnyG2jD3hT5mSxVMWSlLjDij2cOq3o34GqT1CAPvK8WcqFo9KGKDV
         lSPDmxWPcYYjYqZF4r6bmExQzO5UTTHyKVFNhegw7SOjWLKge5zKe5rP7MS3Z0r3oRu0
         JVdHJGjFg5vdkt6W63StUs59IFgJq0+deUbOzBicebrndoD+eyHFuIJE5QFnv/RnFjzd
         fP26FtT/fVvcliQfLZEDIrNR+ioGVA6UnobnNi4LTf9zpyjmSrrgRJQct69FUTjv13vs
         nEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775603; x=1711380403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Hv/QWr8M8ls7knB1wZCVGtf2AvJWRUgL6rtvFRG9dk=;
        b=sYAW/uBReitbWIpZusbyJtMESDjLjI9hc9KDEwRCxvm69YO31ipCbEPPG8vGF4YJ5p
         2TECT97fB3tr7tj677oVFpUB1uB97CW3pSGdoknr+PlSywB3RnlSiibCIFQpFzBNsKVv
         9cTlynTHHi+jncbX8hV/dz16EgP7BCjivBHGgRD8dx3tGwXRZpb4mHTwQlWCT3u+b5LP
         Th8vIcSlEdzDjNjSWKNVaTlND0nAT+TTHbL8zNmc56JwxQGOhe3uAy8si2rTJxq4Z/pi
         cBst3NU5Hr7BeX5fJ6ZyguxDZcQ9v7Qt29uPONzW145PnX/pLa31syCZ9bcSwbDvGGyi
         oxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUIvAhHzXBi5AGrnV6CQTg9h2XnBOwVQn+QxsuR4Cfap6ZxVlh4Ak9kZ7BA8fetaOD5nxVlGWTGVLlXhlakUa568rlAaGF/
X-Gm-Message-State: AOJu0YxJ8B7/AlBCIW1dYuhUsVQjBcDKkR4B5gM7HYFylcbEM5VZzYNg
	AOQcdTGQLfjPNdJUk6TcQy3WAjuAHIrCLEys80KL+NpsVOw+qRBGQe66+ycCy75bir72Yq5oRwf
	asUAk7IiSwUeWKe7BuztXZswQyqaASjrgpMyx
X-Google-Smtp-Source: AGHT+IElNKMYwCi4pjlGQPSRb/mYiqxHrQTnrkhZuM+F1WRWvuGL2GBfnxd8OlBNdyC8AcvWl00mmRDtzrqltlVm71w=
X-Received: by 2002:a05:622a:18a8:b0:42e:b6df:819d with SMTP id
 v40-20020a05622a18a800b0042eb6df819dmr333517qtc.24.1710775602553; Mon, 18 Mar
 2024 08:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org> <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com> <20240318144806.GA3963554-robh@kernel.org>
 <ZfhZffrZXwtKgZ13@hovoldconsulting.com>
In-Reply-To: <ZfhZffrZXwtKgZ13@hovoldconsulting.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 18 Mar 2024 08:26:26 -0700
Message-ID: <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991 compatible
 to fix bd_addr
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2024 at 8:10=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> > > I wanted to avoid doing this, but if we have to support Google's brok=
en
> > > boot firmware for these devices, then this is how it needs to be done=
.
> >
> > Don't Chromebooks update everything together. So maybe we don't care in
> > this case?
>
> That was my hope, but Matthias seemed to suggest that we need to
> continue supporting the current (broken) binding because doing such a
> coordinated update may be easier said than done:
>
>         https://lore.kernel.org/lkml/ZcuQ2qRX0zsLSVRL@google.com/

Chromebooks update kernel and devicetree together, but not firmware.
Firmware is relatively hard to get updated trying to have kernel and
firmware updates coordinated at the exact same time has challenges.
This would further be complicated by the fact that firmware
qualification for each variant happens on its own timeline.


> A new compatible string (or one-off property) would allow them do make a
> change when they are ready (e.g. by only updating the devicetrees after
> all boot firmware has been patched and pushed out).

I have no real opinion about the exact way this is solved so happy to
let DT folks decide on how they want this. I will note, however, that
device trees are never shipped separately and thus we have no
intrinsic need for DT backward compatbility here. It would be OK from
a ChromeOS perspective to add a property or compatible string for the
broken case.

-Doug

