Return-Path: <netdev+bounces-106422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4183B916257
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7057D1C20FA5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC81465A8;
	Tue, 25 Jun 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il8StBXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46413C90B
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307899; cv=none; b=ZhLRJCBPoVsPUmOggWd+r8IXvkmYZuIGS7BwN58PMrvxtctR76XvHVfY5hF+ZClNrx2rxu+m2t4F9Xmc091wyHoVL2ALrTmRhGktpuoQMHK14Se3IbRCF49nhk4m7OI1gJ0ypXPJkRfzqFms/xB5f1DcYtV22LEOep5Qisf506s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307899; c=relaxed/simple;
	bh=7dxMXXWhZiTq7esVHxjZ2voedhT4FV4Q2qY622Vz/G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QilqR7dpPciIzLnFCbgvo6XRNG1dph/vQ/58t978IAuU6I/wyeF6aeGIwSoxRtHEeXYIpgnFS5r80rHy2x9IodtZakFZgSSqM010hN50j3QoZRsf8vqAMSljHZW4uvKc56oLdeVJSzDlWsYSd3E7bVyBqa8rtZn8e2sA66duA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il8StBXa; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ef7fc70bdeso635348e0c.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719307897; x=1719912697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQedI5QDfvg7dkTnGjdpGKy/jhZDSguhw/5RJGPrFiA=;
        b=il8StBXa80bmsjj+1jurhJWAigqrgNcKIIrDuv2PtfrEGZ87P0oLNBF7fQJKBLPMwx
         ya5IZwbG6bg7yQCdSB4MBXGtNO9sXEbwJcuS6fKYrI3JMVxFqLfwje5S51WENo/gzpTA
         kWIwyhaeWbRh6wsAp/VNeEXefwY2lCfYdM9OSA07jq/bfmqaZPg0TzVuG0vpVyk9EoMB
         5SNWW+dMZHIrwWVaDoqhaTUekDa9Ipk2uZrWDW+G2Mp0oRrc3EGpxvg5IH3EJ8JUQue5
         eAkoiz0nLcMj2X+4imfnuBxPLX1qmKC72EHIIOkChQhUPq7nIgLcnPRYNHvldeBwxDHP
         mb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307897; x=1719912697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQedI5QDfvg7dkTnGjdpGKy/jhZDSguhw/5RJGPrFiA=;
        b=i5YqYgKPpV+QAUr8dqsfA4d9rRnscQ5my4KXXbbwiR9W5lgDS0EA+ecbFihqgKo0Nk
         72CNyUtEhJOntGotdcfTG5wGqnNa+8zhmYZ6uSn4gUTyATlbsBbTqAZlqdXJkFEKFD00
         5g8isVa7lGP9DdO6VRkoZIC1csV+rDTa6LhenbZsDTswtmRHFlcPbQW6Jg8bOrg3v0cc
         IrnLt2zXipbXTs+CxFTYz+LdfUvaFSZKPFeum3aHgFhwCgkyx/p/JUnpjP7+atcs1dmP
         0dN7+N/I3QfG4UBKZzOPYEpHD6YzmQKTF6Q81nut2HgNtlPB6I1pAY/DysE2FvtuEeGF
         K54g==
X-Forwarded-Encrypted: i=1; AJvYcCWG7xYB8Q/rap3gzVPSZxGB2FvgibtSiSQTsTq9V5kGurDtHE55P6J7tHVgCC+wDUQWxqqg8C/xQcZok5INwiNtPuuReGzX
X-Gm-Message-State: AOJu0YzDS0544Iw5jbpAMIgyMcr+BbWWdY8QFZqYhayHtcNxJBGsORLI
	uKRI1V/9rRBFfo5koe28t0kxq3El5tDKG0DFE5sgwwqfp8R+nC+V98C3l5hXKY3xrzFp9kZhRBX
	bjwe2eiVEwCqJJLE5BpnLxBOd6lKxTocjvOk=
X-Google-Smtp-Source: AGHT+IFZln+GnDoxpXVbo+ofT7HfrOWi3AwUVPBfyXucYe8zZh4OzUhuhJsZMFG91TpZPM8sH993Wd6QAstXyOx0cUs=
X-Received: by 2002:a05:6122:3c82:b0:4eb:5fb9:1654 with SMTP id
 71dfb90a1353d-4ef6d827a1bmr6102845e0c.8.1719307896659; Tue, 25 Jun 2024
 02:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+V-a8s6TmgM4=J-3=zt3ZbNdLtwn5sfBP6FdZVNg09t634P_w@mail.gmail.com>
 <DM4PR12MB5088D67A5362E50C67793FE1D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5088D67A5362E50C67793FE1D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 25 Jun 2024 10:30:41 +0100
Message-ID: <CA+V-a8vOJmwbK6Oauv4=2nRXZcOVR2GDH8_FBQQ1dpE8298LKQ@mail.gmail.com>
Subject: Re: STMMAC driver CPU stall warning
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jose,

On Tue, Jun 25, 2024 at 10:20=E2=80=AFAM Jose Abreu <Jose.Abreu@synopsys.co=
m> wrote:
>
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Date: Mon, Jun 24, 2024 at 10:25:38
>
<snip>
> > Please let me know if you need me to try anything or provide more
> > debug information.
>
> Can you also share the relevant DT bindings?

I am yet to write a DT binding file for this. Below is how I use it on
the RZ/V2H SoC.

SoC DTSI:

eth0: ethernet@15c30000 {
    compatible =3D "renesas,r9a09g057-gbeth", "snps,dwmac-5.20";
    reg =3D <0 0x15c30000 0 0x10000>;
    interrupts =3D <....>;
    interrupt-names =3D "...";
    clocks =3D  <...>;
    clock-names =3D "...";
    resets =3D <...>;
    #address-cells =3D <1>;
    #size-cells =3D <0>;
    status =3D "disabled";
    snps,multicast-filter-bins =3D <256>;
    snps,perfect-filter-entries =3D <128>;
    rx-fifo-depth =3D <8192>;
    tx-fifo-depth =3D <8192>;
    snps,fixed-burst;
    snps,no-pbl-x8;
    snps,force_thresh_dma_mode;
    snps,axi-config =3D <&stmmac_axi_setup0>;
    snps,mtl-rx-config =3D <&mtl_rx_setup0>;
    snps,mtl-tx-config =3D <&mtl_tx_setup0>;
    snps,en-tx-lpi-clockgating;
    snps,txpbl =3D <32>;
    snps,rxpbl =3D <32>;

    stmmac_axi_setup0: stmmac-axi-config {
        snps,lpi_en;
        snps,wr_osr_lmt =3D <0xf>;
        snps,rd_osr_lmt =3D <0xf>;
        snps,blen =3D <16 8 4 0 0 0 0>;
    };

    mtl_rx_setup0: rx-queues-config {
        snps,rx-queues-to-use =3D <4>;
        snps,rx-sched-sp;

        queue0 {
            snps,dcb-algorithm;
            snps,priority =3D <0x1>;
            snps,map-to-dma-channel =3D <0>;
        };

        queue1 {
            snps,dcb-algorithm;
            snps,priority =3D <0x2>;
            snps,map-to-dma-channel =3D <1>;
        };

        queue2 {
            snps,dcb-algorithm;
            snps,priority =3D <0x4>;
            snps,map-to-dma-channel =3D <2>;
        };

        queue3 {
            snps,dcb-algorithm;
            snps,priority =3D <0x8>;
            snps,map-to-dma-channel =3D <3>;
        };
    };

    mtl_tx_setup0: tx-queues-config {
        snps,tx-queues-to-use =3D <4>;
        snps,tx-sched-sp;

        queue0 {
            snps,dcb-algorithm;
            snps,priority =3D <0x1>;
        };

        queue1 {
            snps,dcb-algorithm;
            snps,priority =3D <0x2>;
        };

        queue2 {
            snps,dcb-algorithm;
            snps,priority =3D <0x4>;
        };

        queue3 {
            snps,dcb-algorithm;
            snps,priority =3D <0x1>;
        };
    };

    mdio {
        compatible =3D "snps,dwmac-mdio";
        #address-cells =3D <1>;
        #size-cells =3D <0>;
    };
};

Board DTS:
&eth0 {
    phy-handle =3D <&phy0>;
    phy-mode =3D "rgmii-id";
    status =3D "okay";

    mdio {
        phy0: ethernet-phy@0 {
            compatible =3D "ethernet-phy-id0022.1640",
                     "ethernet-phy-ieee802.3-c22";
            reg =3D <0>;
            rxc-skew-psec =3D <1400>;
            txc-skew-psec =3D <1400>;
            rxdv-skew-psec =3D <0>;
            txdv-skew-psec =3D <0>;
            rxd0-skew-psec =3D <0>;
            rxd1-skew-psec =3D <0>;
            rxd2-skew-psec =3D <0>;
            rxd3-skew-psec =3D <0>;
            txd0-skew-psec =3D <0>;
            txd1-skew-psec =3D <0>;
            txd2-skew-psec =3D <0>;
            txd3-skew-psec =3D <0>;
        };
    };
};

Cheers,
Prabhakar

