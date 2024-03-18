Return-Path: <netdev+bounces-80440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6933987EC35
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 16:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F492819A3
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094234F8A2;
	Mon, 18 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oW+ds6Wx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBC4F894
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775887; cv=none; b=XTMbuYQThWm3PeoUhaRc3SNUF6PE/4zJv4LbaAg4xgC0Z3OnxIoaUSpWbKLrOG1o4Kn4V0ULrSU/GqD3qDm17Zw7mL5xOYSD9OztCYNku63i84c3DuC++A30KwgkYLBEJjT1cTKs1nktaUHGgDVBIz4W5pI2vb3j6l2SfXrBLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775887; c=relaxed/simple;
	bh=m4+I6MBoUeUHGxnrD5vzjttWojTZkPCJQ14dx3myEDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVJ3nDmV131SulVAl3hVJMV/C/5CtZvXCV0bX35jDSYwuOXuGd3pCl2YQt0031YZm3QwPbCZ1PBvS06DwM74GI3Hgx5JT2m2/pQ88U942GKLGBBXCv+B4K9J0KncKLBNLh7xAkL7ubJJudOTT5DlMx/W4QIIYQY9SlxmawFpSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oW+ds6Wx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430d3fcc511so197011cf.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710775885; x=1711380685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA9/NiX8/E19WUiHKA9tr52IADuhSxANcPtKQ97R1nM=;
        b=oW+ds6WxOpW/jRhOjraBRnZ9oYYtUDIgqGcTiI85U7K+Cpj8UktYnD9iWkB0J6OnGZ
         c2TNHu9EpLVqHrKYgQayqEAY3RLhQc/B/mf6fNManTAVjNN/zEA02701EyoSgQukjHYM
         MK8S3x0j44jgkZun13lguylavxOPYCsWEuvLSIZWcu5xr6C4OSoEkTFuRA8xmBXR1y+V
         /uFIY9300VbpIrFPs3Cn9cgtXjwkjtF8K0urRG+6KKl03MF7V9SiUMRrgtTpp5pVEK2j
         2jdwfKzWkL27aaIzCGKLYVXkz9qR7WzfeJ3IUoTfFSAyt8Iq5U5oTaodMnrlwV0ffY1G
         3Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775885; x=1711380685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA9/NiX8/E19WUiHKA9tr52IADuhSxANcPtKQ97R1nM=;
        b=kbzOyN+Q39pfcQcoIH+a/W6PTlQp74Y0jOYKNC1QjDoTTSaq59eBO34isiZdes18hs
         akJhC9l3ZNui3DU8TRkW4UkfKPQfXP0+jG91/0ctIfPSQ+IDxtmr37DVQLJG8ch1wwm4
         knl6gwhT4E5adqAKT4lZXP9rXeGPr3MnQXT2Dv4FZyeITogIxc9Q+X3GkrwruVHDq12K
         8+8Z5JdixN9aaemTrrBqOyDqkDBAFZM6MvbAGFkSew4ABIXSsB0QOtxOsehq75yNHiba
         n0IhwbTCZWOHGdU4Wp41tcsQIoIjA4xXpEKpgJ3Q5KUTXSO9Glw2pbqDvtZdhXowtGBy
         2jNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Gi4jXesJNXHZuh875mRVtLcNxh7VQzzMO4/oydVs8LCqNrgZMdzc6yRebciikX8/6Ba8z3BUMS4iw0hTWxjcQkv9awoZ
X-Gm-Message-State: AOJu0YzkuwRGYDj7Q8cpkfQ79AFMPAAh9JtJBUcT+iA2D1vG+PjXssO1
	ENl8baVaaFnajrh5WZo90DKfabLBHorJuAi6YYTvjiUdOB1e2FUiiFLK1U3J5JXwKxoAg1yNtsy
	zyTKRxN1GX4cj3dFeScaYTLu5DTEcuN6MzPBF
X-Google-Smtp-Source: AGHT+IGzWqUIOUu5I0duuZgvPFrMrMabv8H/NdN0jk0nuFo5i4muxUfa/my0tZITK0IRu5y8Tg7eEzkZ4UvjvZQkd6c=
X-Received: by 2002:ac8:5913:0:b0:430:a5df:a3af with SMTP id
 19-20020ac85913000000b00430a5dfa3afmr367264qty.5.1710775885132; Mon, 18 Mar
 2024 08:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org> <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com> <20240318144806.GA3963554-robh@kernel.org>
 <ZfhZffrZXwtKgZ13@hovoldconsulting.com> <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
In-Reply-To: <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 18 Mar 2024 08:31:09 -0700
Message-ID: <CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com>
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

On Mon, Mar 18, 2024 at 8:26=E2=80=AFAM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Mon, Mar 18, 2024 at 8:10=E2=80=AFAM Johan Hovold <johan@kernel.org> w=
rote:
> >
> > > > I wanted to avoid doing this, but if we have to support Google's br=
oken
> > > > boot firmware for these devices, then this is how it needs to be do=
ne.
> > >
> > > Don't Chromebooks update everything together. So maybe we don't care =
in
> > > this case?
> >
> > That was my hope, but Matthias seemed to suggest that we need to
> > continue supporting the current (broken) binding because doing such a
> > coordinated update may be easier said than done:
> >
> >         https://lore.kernel.org/lkml/ZcuQ2qRX0zsLSVRL@google.com/
>
> Chromebooks update kernel and devicetree together, but not firmware.
> Firmware is relatively hard to get updated trying to have kernel and
> firmware updates coordinated at the exact same time has challenges.
> This would further be complicated by the fact that firmware
> qualification for each variant happens on its own timeline.
>
>
> > A new compatible string (or one-off property) would allow them do make =
a
> > change when they are ready (e.g. by only updating the devicetrees after
> > all boot firmware has been patched and pushed out).
>
> I have no real opinion about the exact way this is solved so happy to
> let DT folks decide on how they want this. I will note, however, that
> device trees are never shipped separately and thus we have no
> intrinsic need for DT backward compatbility here. It would be OK from
> a ChromeOS perspective to add a property or compatible string for the
> broken case.

Actually, I should probably say more about this to make it clear how it wor=
ks.

Chromebooks ship the kernel as a FIT image which bundles the kernel
and device trees together. The firmware looks at all the bundled
device trees and picks the proper one based on the board name,
revision, and SKU ID. The firmware then looks for the bluetooth node
(I believe it finds it from the "aliases" section) and adds the MAC
address there.

...so we could update the DT to add a property (if that's desired)
even if we don't update the firmware.

-Doug

