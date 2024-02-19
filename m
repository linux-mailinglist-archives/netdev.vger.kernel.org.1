Return-Path: <netdev+bounces-72930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97F85A31D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49305B2208C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3E2E62C;
	Mon, 19 Feb 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y9NlYGWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E02D610
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345406; cv=none; b=nHVDUCgSpPgLdfwcpIgHjw7wHPHPTmx6w9JglYl6TkGHTZyyHIMIrhz36TaOSD/Zo2AIsi+06ti5odhM2R56NpKdYetaKUWLCYt15yqV2b5B7y/qhKImX7fZ811+JnoEUWzboiOQBDTdtuJZlNDjX3PMp4ry8Jz+P2/hI/QFHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345406; c=relaxed/simple;
	bh=JCaGChRGUNtrESJTd6AhgRt3rpjjekNlziPebDsi98o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlKeTH+cN9AvRTYamjkJQc2is+YoUkxsKYesLCePlb3JvZCl0s+HpW2ktQVaGBVGQacphlAExH8K7WEMfyfuWobBBq8qgnZTnx4fDnrw4Hisz/b5DApYswaFv3scciMgfhOx0o9fmLDAZ3Xz9KHtU2UYaov5ys57CMe3s53uFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y9NlYGWh; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so2666769241.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708345403; x=1708950203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCaGChRGUNtrESJTd6AhgRt3rpjjekNlziPebDsi98o=;
        b=Y9NlYGWhWXkn0m0UTUk43shbgdS0/so9hJzHIpupXqdzTz+Xmpnd/lMlQ5V/72NxJj
         hmye7oYrHu+8uYbVw8xeaTMnGHu1fMF0ECSFvG21TlGjTsTE5qt8cDdfb4t3wsuYDdvm
         mBmyjQUDltAfhwFVKD3szLn3HAJmwxAa2ezYFgP7OaANFLxUZGQTZ/gNH+02HKGQRlsc
         YWNcuan5Ok2mF7fYx7B1tYDgEVm/Y8gW9yxUtTMCLD+ygZpfNkpkd8tRMr0AtjqTthx7
         2bt3Fyv79se0/xjXCgYB4oak2AORYv8e9hq56azN1/nneY5J2XEFL1VkPWshqDoD8wDM
         8OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345403; x=1708950203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCaGChRGUNtrESJTd6AhgRt3rpjjekNlziPebDsi98o=;
        b=pMeqpUTjDAxJLj7T+r95r0/JHmQ0GsgmtIK54Au9q8zz7D3rnesWIZaI7/ZQ7BM6Se
         79FIhpgbgAOLl+6ncBsQkixlhW7udcIN6dyV5MQn3pRDNPkV0WI3Bb4NFep1YNW9uNxp
         D8QiS+5553iuoZq3w13IC8u0xPqC2z4YAq7AMBxBnWIUuJ3WcRQ1bn1xGAb541H9lx/A
         J6RiHj4WILbZP8dTnYQy7QIz134Dmvb391rhzzhYmA+6m1AAeJJZtxqG5TlsB48a+7TU
         ah81ZMpT1IaYW97a9HS3WIqEvyaeUDQlclif0WwtilrWiiCEPgj2qvm7krQZZWSKVOBo
         fCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/aksLy4YklQdFRCH6Ro9Kj9KbHslQH6HbhYpW5UERH6uDpg7Az1pg5EEhUIiWce6DPHy9f/axSkgWLy356FBSIai6g/RD
X-Gm-Message-State: AOJu0YzzM6f4Nuuymfd0/r2yZyRsYxuVK1xgaY1HTjbsGX4CGCTPTQKT
	wPywJzYrudzX9O8W5JLxXm0L/VLIIXCkh7s9LVaIAAgAsjsTE6+8SHrZwSqEe5jfUDghwHSLNvI
	fqweLTeCmm48QxGvzGwfop56RfnlI2v/yOBUtkA==
X-Google-Smtp-Source: AGHT+IF8QcDgkljiNMmo2vfxi+b1NQ85UHBOseDQ8gS3vMihHH6Kd8r7v4M2Q6MY2/Fw/swZFGL2ynq5zcQX6aZeYGo=
X-Received: by 2002:a05:6102:1142:b0:470:54fa:b37b with SMTP id
 j2-20020a056102114200b0047054fab37bmr1527000vsg.35.1708345403354; Mon, 19 Feb
 2024 04:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
In-Reply-To: <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 13:23:12 +0100
Message-ID: <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>

[snip]

> > >>>>
> > >>>> For WCN7850 we hide the existence of the PMU as modeling it is sim=
ply not
> > >>>> necessary. The BT and WLAN devices on the device-tree are represen=
ted as
> > >>>> consuming the inputs (relevant to the functionality of each) of th=
e PMU
> > >>>> directly.
> > >>>
> > >>> We are describing the hardware. From the hardware point of view, th=
ere
> > >>> is a PMU. I think at some point we would really like to describe al=
l
> > >>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including t=
he
> > >>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
> > >>
> > >> While I agree with older WiFi+BT units, I don't think it's needed fo=
r
> > >> WCN7850 since BT+WiFi are now designed to be fully independent and P=
MU is
> > >> transparent.
> > >
> > > I don't see any significant difference between WCN6750/WCN6855 and
> > > WCN7850 from the PMU / power up point of view. Could you please point
> > > me to the difference?
> > >
> >
> > The WCN7850 datasheet clearly states there's not contraint on the WLAN_=
EN
> > and BT_EN ordering and the only requirement is to have all input regula=
tors
> > up before pulling up WLAN_EN and/or BT_EN.
> >
> > This makes the PMU transparent and BT and WLAN can be described as inde=
pendent.
>
> From the hardware perspective, there is a PMU. It has several LDOs. So
> the device tree should have the same style as the previous
> generations.
>

My thinking was this: yes, there is a PMU but describing it has no
benefit (unlike QCA6x90). If we do describe, then we'll end up having
to use pwrseq here despite it not being needed because now we won't be
able to just get regulators from WLAN/BT drivers directly.

So I also vote for keeping it this way. Let's go into the package
detail only if it's required.

Bartosz

