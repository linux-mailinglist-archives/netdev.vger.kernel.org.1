Return-Path: <netdev+bounces-130673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871698B154
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDEDB21FEC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78B173;
	Tue,  1 Oct 2024 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua3XQ/re"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77B36C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741604; cv=none; b=igi/Q53O/nyhvk99VY0qBcIVfTmIu4DK9ZgtxdhCp2fFoXcoFmLMb5u+UY+pH2rRlwuVXa0m3Liu86zHZFUCMOubgvwIOHx7EUHH3fD+U9M3qpIW4454k1XZuxGkvFxvcedWG+sREJMLQvsP8NaGQBQYABjVla1zsGAkf2jsysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741604; c=relaxed/simple;
	bh=kq01IeCQb3DsZha9sLfeLizz4Wx0hXe64RVUIbF2His=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze5Em84YDhsr6+exIEXh0L4nqF5Ha3MX2aF/+4h0UYZi6THB1HsTpnBkHY6Wv251gPXGd/OoZ5At36GZbpITluJ3TVBQ+bHGsOTKQ5juFIFxG2/W1bRrLzH0K9cnBngv3HvYR7xvD1rsVtRwhRrqK+80T4aBlUMFJdL4EFf22Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ua3XQ/re; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e109539aedso1656750a91.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727741603; x=1728346403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wGoK8DPKzPFOz5acKTbBRxQf+NMvuIpnjXtWd1AqSs=;
        b=Ua3XQ/reuRdp13FSoSFyVHVkogkA15dhKr6k5GCeAm5xg6QNyD7Lk96llAzaW0xlcD
         ywtYcaLkNqAkD+gMnkOT3OifJF9dnP00V3gZ9Azf0Qp2SApcxPWy2IWkQq2o43DAI4m5
         OySDMH79vg7GjH0iMeIAY0esuTCFtmde6mHxzqCD8QAteQHFszlgwW/s3K0SSlBPSItG
         8VOZvD1jwEAZ0aqmk7kI65r2y/uNUSvuo4Nu03QKrLLP9JFSH0mcLp6PMzvkO48PG3Ta
         MRGtfBlL3PxXChn+60N5hZJvbxW6RgjKBDCmEliO9w9H61RgAayhVWPwm9+vMyEqAkyz
         1kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727741603; x=1728346403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wGoK8DPKzPFOz5acKTbBRxQf+NMvuIpnjXtWd1AqSs=;
        b=um8yQ6DP5AOumEEEKnNe9YmSfd2lwzSw5k0zJ8WEkkl1ZG9IgQ8NIeUoBJlGyTM32T
         FgSPbaiB2NGhBoyYuj3kNloN7Ahe6P1NL+M0NWGj+idlgRGRhqd7XWctU72YAqpIrPk7
         Z17DKMml33qUHRcHt1oKAPwtUZMFL0N7Dl9SpJRwR2GocKSCyTTeanXsSvnhuLQVwjjq
         6HcsHMXfKBSp+B+h5deN61JIQGTfeTGWFbDqavHjoVo/N+6E038tyfoegAmEvOyj+CwI
         pT0MSjNk0nK6W4hABPNZD3W6X6ygjYMq9OjE6d4bDiG+p5HP1n7KN+Wwj5GUOKHl68wE
         egbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVW30RGWxPRN5Punhy92oY9ZUSZBN/RBfI0yUE7fwRiIr7tvFRG0KvKQ5LmP0Qe/dGCFiy0YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRL/xj4h9Kjpj1LhtLseEVhXytm89n0U2b7Q++Z7iTNzTkvQR
	Id4y7LUdoI3fo98hMkYRJBbaVTfe2C1FLl+FmInRXMMMBAMPNRjhpuYwViZzY2jhepF0RNq7RK6
	Dpl5VTaJ/5NE/MGpc1HyGbhFRG8Z+x3GRNV4/
X-Google-Smtp-Source: AGHT+IG2k46H/ljRgiej2AimW8j4YnqoM4oGz/qGaPPyc0VH5224poWz8Z/NWtOZytPFw9vPWK1PBB2TQEQhPYfTPzM=
X-Received: by 2002:a17:90a:69e4:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2e0b89e218fmr16151470a91.14.1727741602207; Mon, 30 Sep 2024
 17:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
In-Reply-To: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 30 Sep 2024 17:12:42 -0700
Message-ID: <CAGETcx-z+Evd95QzhPePOf3=fZ7QUpWC2spA=q_ASyAfVHJD1A@mail.gmail.com>
Subject: Re: [PATCH RFT] of: property: fw_devlink: Add support for the
 "phy-handle" binding
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Rob Herring <robh@kernel.org>, "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Serge Semin <fancer.lancer@gmail.com>, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:28=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> Add support for parsing the phy-handle binding so that fw_devlink can
> enforce the dependency. This prevents MACs (that use this binding to
> claim they're using the corresponding phy) from probing prior to the
> phy, unless the phy is a child of the MAC (which results in a
> dependency cycle) or similar.
>
> For some motivation, imagine a device topology like so:
>
>     &ethernet0 {
>             phy-mode =3D "sgmii";
>             phy-handle =3D <&sgmii_phy0>;
>
>             mdio {
>                     compatible =3D "snps,dwmac-mdio";
>                     sgmii_phy0: phy@8 {
>                             compatible =3D "ethernet-phy-id0141.0dd4";
>                             reg =3D <0x8>;
>                             device_type =3D "ethernet-phy";
>                     };
>
>                     sgmii_phy1: phy@a {
>                             compatible =3D "ethernet-phy-id0141.0dd4";
>                             reg =3D <0xa>;
>                             device_type =3D "ethernet-phy";
>                     };
>             };
>     };
>
>     &ethernet1 {
>             phy-mode =3D "sgmii";
>             phy-handle =3D <&sgmii_phy1>;
>     };
>
> Here ethernet1 depends on sgmii_phy1 to function properly. In the below
> link an issue is reported where ethernet1 is probed and used prior to
> sgmii_phy1, resulting in a failure to get things working for ethernet1.
> With this change in place ethernet1 doesn't probe until sgmii_phy1 is
> ready, resulting in ethernet1 functioning properly.
>
> ethernet0 consumes sgmii_phy0, but this dependency isn't enforced
> via the device_links backing fw_devlink since ethernet0 is the parent of
> sgmii_phy0. Here's a log showing that in action:
>
>     [    7.000432] qcom-ethqos 23040000.ethernet: Fixed dependency cycle(=
s) with /soc@0/ethernet@23040000/mdio/phy@8
>
> With this change in place ethernet1's dependency is properly described,
> and it doesn't probe prior to sgmii_phy1 being available.
>
> Link: https://lore.kernel.org/netdev/7723d4l2kqgrez3yfauvp2ueu6awbizkrq4o=
tqpsqpytzp45q2@rju2nxmqu4ew/
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> I've marked this as an RFT because when looking through old mailing
> list discusssions and kernel tech talks on this subject, I was unable
> to really understand why in the past phy-handle had been left out. There
> were some loose references to circular dependencies (which seem more or
> less handled by fw_devlink to me), and the fact that a lot of behavior
> happens in ndo_open() (but I couldn't quite grok the concern there).
>
> I'd appreciate more testing by others and some feedback from those who
> know this a bit better to indicate whether fw_devlink is ready to handle
> this or not.
>
> At least in my narrow point of view, it's working well for me.

I do want this to land and I'm fairly certain it'll break something.
But it's been so long that I don't remember what it was. I think it
has to do with the generic phy driver not working well with fw_devlink
because it doesn't go through the device driver model.

But like you said, it's been a while and fw_devlink has improved since
then (I think). So please go ahead and give this a shot. If you can
help fix any issues this highlights, I'd really appreciate it and I'd
be happy to guide you through what I think needs to happen. But I
don't think I have the time to fix it myself.

Overly optimistic:
Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> Thanks,
> Andrew
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 11b922fde7af..4a2fca75e1c6 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1220,6 +1220,7 @@ DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cel=
ls")
>  DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
>  DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
>  DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
> +DEFINE_SIMPLE_PROP(phy_handle, "phy-handle", NULL)
>  DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
> @@ -1366,6 +1367,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_extcon, },
>         { .parse_prop =3D parse_nvmem_cells, },
>         { .parse_prop =3D parse_phys, },
> +       { .parse_prop =3D parse_phy_handle, },
>         { .parse_prop =3D parse_wakeup_parent, },
>         { .parse_prop =3D parse_pinctrl0, },
>         { .parse_prop =3D parse_pinctrl1, },
>
> ---
> base-commit: cea5425829f77e476b03702426f6b3701299b925
> change-id: 20240829-phy-handle-fw-devlink-b829622200ae
>
> Best regards,
> --
> Andrew Halaney <ahalaney@redhat.com>
>

