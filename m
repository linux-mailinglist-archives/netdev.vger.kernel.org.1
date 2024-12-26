Return-Path: <netdev+bounces-154277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C71C9FC807
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 06:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCFB7A04A3
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77334204E;
	Thu, 26 Dec 2024 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8BrTJRs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C418E20
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189220; cv=none; b=Ca0oUjU3B507u2ObqICKEJz+NGi7jAHPjB7esotfGHE0m3WfnTekJ3VpUjWWvj11DGmHHDjo0YIBaxVINlZ1u7nO/2DxP8j/gonDxltxMSOu/7DdZJDq+WgXSwVt/+rHVd0QG2qHEmKd8wwgoeMybgAuDdi+SeOfEzakCeDbvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189220; c=relaxed/simple;
	bh=U+POVFYfRaoOCTQcOhUpgN7FyxBmgd5bLarJH/zllr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzjW4yaitCON38xJ5btV9XxWA4DDbTyDJUNnGc6IMKNmxqNAz6SpLL1qVDHKBlL8ztuA3tFuS9zs6lYjuZkXRxfLG11lyZSlIAKHppevAtlL1Z13fHBNgyci5cvUsYvlKYcIpWUuXUhtBEjxhONlgZbyxiAVoRco0Xdd/Ywm84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8BrTJRs; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e46c6547266so5687366276.3
        for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 21:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735189217; x=1735794017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TIoioJmDwQLq6ojZvbfk4gX6Bmi+eAVpJx8YKUJOQc=;
        b=L8BrTJRsgH8tYclYIj1biHhZ/JBSC4OQuYlEVEuqlMvrvlbkx0oaN8swUWV656DBDQ
         Sh8w89Fx4b5vIGny6ZH4hzfmPqCJYeztY2WvCUb9kngGaLGTpgOAdGuB6/AawldSDIzT
         BMFhyS4O74FCkPV+JSnXQ0u7iPckt43RKgi/ORNZex1jFxH+REzbAYMaYsg7LNJXGbpg
         Dk6Z9auSZKbnNFa0nVv7gv2vgoR0Urp0UlKhtQ9EIl3D5ej7++qHepsrMGbWa6oipOY3
         MeWatuO+WgCEGy0L3biMFu8YLVyHsbN3rEDaIo/jaE/wSKUWeO8smVYbp988luor4cvv
         4O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735189217; x=1735794017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TIoioJmDwQLq6ojZvbfk4gX6Bmi+eAVpJx8YKUJOQc=;
        b=g2fsglo467zRLWTxTvYYvXBD2U5cAJ2ulSa5BPdA3W38ij9JqyAtIqYzp3c0COt5bD
         a5n8Jry0Z5z7eLbqnTyCSZZxAlFONKLxYJk4zr91bTNQRg5GqgjUj34uZHn/Q2yKTrd7
         BL8poRHTdwFp+Y9MfrjQeuo/NcbbTN/XwLRD0gQIS49q7YoU6XINXgXLNC5oSAWB18VU
         ExS15Q53crCPZuUM5W9xDnQc40m/mi74196mIGDH3/f1HINY2BnDdJI0wSIsWUaMZXiD
         iiZckmQVH1OSZF5nbEOZaAcL5scrVM4GhVKQ6PX95sPAwvj93i5EpoP8+ONCNSKhav9Q
         a1mA==
X-Gm-Message-State: AOJu0YythTI3JJRWkgQ4iNP6hke/HFNv0O03nC7MKKmTEuYconJxE3vH
	0UIO6ZXry+d8aAZ8+7aA47fycg4pGZu4g20Vx1ODqGSt1sjnB9iNSM4ajGKaRE0TfaQeUmuxxYj
	DMd1PL21ArRjfKFKHRseuvqii+aSy02kr
X-Gm-Gg: ASbGncsuv1eKCulz3FBLvQiex/Zzwz6RPTj6zz1hzowWwO8gQMaSLhCEPOQUm2Fcspm
	TsM7GNsdmg4GfFG2+rx5kdiccDeHh4dSEXCeh
X-Google-Smtp-Source: AGHT+IGyuR0oVM11HKce5N3tF2gSkQ3jjsRGGxtkAZzxSY9DsmASCzvas2FbZyGFXxCucvXVi8U7baXTztxuh6lXLyk=
X-Received: by 2002:a05:6902:15ca:b0:e4d:25c6:c3ab with SMTP id
 3f1490d57ef6-e538c1e8ec3mr14132739276.6.1735189216857; Wed, 25 Dec 2024
 21:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
 <25d02ea3-02f3-4699-99eb-ac49aef917e6@lunn.ch>
In-Reply-To: <25d02ea3-02f3-4699-99eb-ac49aef917e6@lunn.ch>
From: sai kumar <skmr537@gmail.com>
Date: Thu, 26 Dec 2024 10:30:07 +0530
Message-ID: <CAA=kqWK=+jN1axoDkb_ipC3+0rLie35bGxr7qUjz-acOMHTscA@mail.gmail.com>
Subject: Re: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Sorry my mail getting bounced back due to not being in plain text mode.

the issue got resolved,  issue was mismatch in phymode between
eth1(rgmii) and switch port0(rgmii-id) in device tree.

The Port 0 RGMII currently set as default as per data sheet, didn't
modify its port registers. The issue was the configuration side on
device tree for port 0, cpu port.

While trying to follow Vladimir's suggestion to update the device tree with
dsa-tag-protocol =3D "edsa";

Found there is a mismatch with respect to phymode; in cpu port port 0
phy-mode =3D "rgmii-id"; and fman enet phy-connection-type =3D "rgmii";

I tried changing the phy-mode of switch cpu port to match fman enet phy mod=
e,

Now the switch works as expected and dhcp discover of client connected
to port 1 reaches external cpu enet port eth1 with even tag protocol
as dsa.
and errors vanished on eth1.

Somehow this missed the radar earlier since eth1 link got up quietly,
and didn't observe any error in dmesg with respect to phymode mismatch
between fman eth1 and switch cpu port 0.

Thanks for your help for immediate responses

On Wed, Dec 25, 2024 at 11:23=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Dec 24, 2024 at 03:00:17PM +0530, sai kumar wrote:
> > Hi Team,
> >
> > This could be basic question related to DSA, if possible please help
> > to share your feedback,. Thanks.
> >
> >
> > External CPU eth1 ---RGMII---- Switch Port 0 (cpu port)
>
> How do you have your RGMII delays configured?
>
>     Andrew

