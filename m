Return-Path: <netdev+bounces-33920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D28D7A0A73
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB31C2109C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F72134E;
	Thu, 14 Sep 2023 16:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1628E39
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 16:07:59 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B241FD6
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:07:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb71ded6dso911583b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694707678; x=1695312478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juuH/zar78Q48Gj6bVfB0fZD21h8ZoWaQbN1zRk6qWE=;
        b=cLlJnrezTATvFBi/gZ5lh09n/zTeTvZZhPjZbmPI3EeIrXRkGekTsBBP+sLT0oc52b
         T0nH4cmYRLy9iwfsdnDdLR/ao2aAAegYNc5+nnA6Vu4ltYMEzGRrK7c5KNP2yU3Av4FJ
         nmcFfjaZzoT3tN2ti2jbbL62n2V+JUROLT3lbg1MNdiqJwtxbXgbQJcHpYPf+khQ0z+J
         1yoqe+6ZimzyW0Kb7EqTofLF9JCnBaMJMcOwgd4ijru0AcO9W7C4QG01Y9FlpVB3YCKL
         B8O2fgwLBF7q/GbnOgEXR/tGMTwkCblR478bNbGXUJMyKgjc5A8mhVmBCQpFH86W2p6T
         62Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707678; x=1695312478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juuH/zar78Q48Gj6bVfB0fZD21h8ZoWaQbN1zRk6qWE=;
        b=FR0lFCnrexx7Saul5a2IrSttGHXoy47IxROg60NOTW3jne4vwJDuAZAZn/c1zidxN9
         +wnaxZ6HIuImenpldnmYGYntLGyiIDYqgo2uJ7u1vvAzrgNPxKRaM4c4uZhoVSOMvTdh
         Ad6RIeocSPxsyDUI/5TqiL/6T3ZbI79tWfQ2vLPyQIVw5B4LaYut2J3WWc1a8fEPouwM
         kyCBjwPs4gbKZPhWUzVoW6jRrkXcl9enanxW3BzUk64+tgXRTFeRs8aA7/3jkO3ioexV
         ZfyYKRq32qHP+bOtjCHysklFxSm5UPduqeaFvnQsFj+vE0y43liItN56UT16MJ5YvpH3
         Vp4w==
X-Gm-Message-State: AOJu0YwuiiuqqpBSL9IR67NGThHl+KsP97r5mCz65lDL2bfqEfwDj9f5
	aMXNcI2IWU0HUHxEV/yOTHU8piyEWPTtWyfLL1M=
X-Google-Smtp-Source: AGHT+IGYhCU6zz7omf82kZklWoXEFlrAimOYNx9REbudyCngwJ5EgEcX0RndZls09LdNUZe5LwEe0HgH9e0wJ4aiMQM=
X-Received: by 2002:a05:6a21:1aa:b0:14b:8b82:867f with SMTP id
 le42-20020a056a2101aa00b0014b8b82867fmr7080350pzb.50.1694707677803; Thu, 14
 Sep 2023 09:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPsLH6aHJGG7kAaZ7hdyKoSor4Ws2Fwujjjxog6E_bQrY1fA+w@mail.gmail.com>
 <20230914155126.GM1599918@black.fi.intel.com>
In-Reply-To: <20230914155126.GM1599918@black.fi.intel.com>
From: Yachen Liu <blankwonder@gmail.com>
Date: Fri, 15 Sep 2023 00:07:46 +0800
Message-ID: <CAPsLH6aWqo7apL++DZUAkYxQacaW1Rh_-B=VpJAgH3UzBaiZbA@mail.gmail.com>
Subject: Re: [Bug][USB4NET] Potential Bug with USB4NET and Linux Bridging
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I just did a simple test. When using a standard network card, I can
capture big packets on all three interfaces (eth/br/tap), which can
exceed 50000B at most, and the MTU of the three devices is all just
1500.

I don't know much about Linux's networking architecture. I guess it
should be that when bridging is done, it checks whether the interface
supports GSO and then does special processing. However, for
Thunderbolt devices, no GSO feature was detected so no processing was
done causing problems.

Note: ethtool -k can read whether a general network card has enabled
GSO but it doesn't work for thunderbolt0 interface.

On Thu, Sep 14, 2023 at 11:52=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, Sep 14, 2023 at 10:02:24PM +0800, Yachen Liu wrote:
> > Hello,
> >
> > I've noticed a potential issue with USB4NET when used in conjunction
> > with Linux bridging. I'm uncertain if it's a bug or a configuration
> > oversight on my part.
> >
> > In essence, when the device at the other end of Thunderbolt sends
> > packets using the TSO mechanism (default behavior in macOS), the Linux
> > thunderbolt0 interface correctly receives this large packet. However,
> > the packet isn't properly forwarded to another device via bridging.
> >
> > Detailed Description:
> >
> > The test environment consists of three systems:
> >
> > A: Mac Mini (M2): macOS Sonoma 14.0 RC
> > B: Proxmox VE 8.0. Kernel release: 6.2.16-3-pve, acting as the Host sys=
tem.
> > C: Debian. A Guest system running within B.
> >
> > System A and B are connected via USB4, while System C is a virtual
> > machine within B. On B, thunderbolt0 and tap102i0 are bridged to
> > establish a connection between A and C.
> >
> > During an iperf3 speed test between A and B, I've achieved
> > bi-directional speeds of around 18Gbps. Between B and C, the speeds
> > are 100Gbps+ at their peak, with a minimum of 28Gbps.
> >
> > However, when performing an iperf3 speed test between A and C, the
> > direction from C to A shows about 18Gbps, but from A to C, the speed
> > drops to just tens of Kbps, essentially making it unusable.
> >
> > If tested using UDP, both directions achieve roughly 5Gbps. (I suspect
> > some buffer issue in macOS limiting the speed).
> >
> > After various tests and investigations, I found that by setting
> > macOS's net.inet.tcp.tso to 0 (disabling TSO), speeds from A to C
> > improved to around 10Gbps.
> >
> > Packet capture via tcpdump revealed that macOS writes large packets
> > (over 10000B) to Thunderbolt Networking using TSO. These packets are
> > correctly captured on thunderbolt0, but are missing from tap102i0,
> > resulting in significant packet loss.
> >
> > Since ethtool doesn't support the thunderbolt0 device, further testing
> > has been hindered.
> >
> > I'm unsure if this is a bug, or if it could be resolved via
> > configuration. If more information is needed, I am more than willing
> > to assist further with tests.
>
> Thank you for the report. To be honest, I'm not sure how the interface
> should in this case and is there perhaps some way for a NIC driver to
> pass TSO packets up so that they would be passed in the same way to the
> tap interface. Is there any example driver where this works? Like if you
> use ethernet instead of TBT/USB4 does that work with TSO packets?

