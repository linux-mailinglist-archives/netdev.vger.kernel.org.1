Return-Path: <netdev+bounces-116582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF794B0DD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3C01F21A97
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5482D66;
	Wed,  7 Aug 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6NXEQlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6107144307
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060991; cv=none; b=fnIiuHei77dM4aiVN65gHHWEv4wDf1AQqkYW4LYwoHYWVqkmlcr0R31DpLHdpOxunakCBvN6CXQgpsAzcxvubjPiMFljDolWECyRXv6pt9wSG3pu/Oa0zizFbDZaomgLA7pcuDp6dhSJhkVodwaz/V/V1Qz8Nqj3Faw/Vx9Txis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060991; c=relaxed/simple;
	bh=0nOt9wP5GCBvmTAJR7O6W3H/vFRapUz0xXIRj99vvRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofawxfB0B2zvljElQnlh2Np1dPs4u5Aa2WSPXmt5Vw89/FPtmDtNbtxcTxNAwFrqFH3iP6NpRMYwKPIUVf34da4lUTiA9HieS0NlvoxeCw9zBwruTyxLre2To4wXcfndIKMhGybiw3rHIAk/UvCwmIMLEN6dCIyp66IfAVQwKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6NXEQlV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-65f9708c50dso2268437b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723060989; x=1723665789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7vSrj4J1P1BC7W6/6ZrvgAL7js8cH3pfzU3pKYBuQA=;
        b=f6NXEQlV8cWZtvlkou3cVa3ocw6CB/FHlvIoMePIhkFhNH48ZQiWlG2kx3qWlKUqb5
         JGwcVO6u8HFp6HFkRR4n4DTy/Hl7AfLlkaUGMiBrS35S3ySOcYkcGLopuCIc8yEwkg0A
         rxM/7fRykXlT7BL7A/aoXcu0noXgZQNAALRdUYqUHEF8roN2LaVhkjMtaCQux8oYnRby
         NRoqzzM9ezSol/rx5DMM4zcJXC9oJ+mrZ58cfx7Q+eZAMl46dFnVTKAOxRY4f+m12Lvo
         HuRDv+oVNkTDkQNvbGh0VTOHobyq3EClDX5JteRmVJl4ReFVIIodNIEyVbNliF3psFZ4
         Yuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060989; x=1723665789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7vSrj4J1P1BC7W6/6ZrvgAL7js8cH3pfzU3pKYBuQA=;
        b=vMTIGK9jzvUi3rZwmu8OucXGyVt+wwxdhyMlkWFWABwlAX+X6/zpm2slaul4cwsR1z
         t/G+NGsbPQ4jxx5vOI7tH/m5GQwLnjzId3uNoXuQIt0ONoMh9ImFMAIH3rT0I6RshFmi
         zwbPQeAJoWPEMaJc70syX5Fpbyc+0nMxVIE5N2lMbj/pFxnSoDMcuMLVgZGd4Q1gevMY
         3x69hGTvgikSe1en1tiFS9/M4ni/fYBLbExL38SIUgSttFrRlZ4F8Q4ye7rAiZH9Uxlj
         pWeK8d7KhXBQjEMolQL1us7/Eycy1XbHgMu/UuJSiRewRMskm5/yYy2/kcisA6RcgQJz
         /nwg==
X-Gm-Message-State: AOJu0Yx3J+DX9g4rvT/2dxc7ueYN7ouaYWmqRHZ4HiQdCowbLLPr7/vM
	Fe4sev9LKDxa2rwx34zJHvlt+4pTvL6vear4pwSgp+PRYeNGh5KgyOyd6Uuit8FYd0xeKTjfCq7
	RQzqawYOitcgG1mKI65sESQ7bf/tQOenb
X-Google-Smtp-Source: AGHT+IG7ywvF5ceE+Lb4j3ZkJaCfcYek72knFvVId4QzwAe9+bO/nYx+GuEJO+Ylp62BcB997WnN3sGYmH8xNFv9c8o=
X-Received: by 2002:a0d:c247:0:b0:644:ffb2:5b19 with SMTP id
 00721157ae682-6895fbdbd45mr216570757b3.9.1723060988665; Wed, 07 Aug 2024
 13:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807185918.5815-1-rosenp@gmail.com> <64e1f8a2-ba01-402f-81e1-e51da76a5db0@lunn.ch>
In-Reply-To: <64e1f8a2-ba01-402f-81e1-e51da76a5db0@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 7 Aug 2024 13:02:57 -0700
Message-ID: <CAKxU2N8t0vNxq_xTxZFkjYgbrUG6GWBTQJAdt7T+XqD9YEb73g@mail.gmail.com>
Subject: Re: [PATCH] net: ag71xx: use phylink_mii_ioctl
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Aug 07, 2024 at 11:58:46AM -0700, Rosen Penev wrote:
> > f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function fo=
r
> > ndo_eth_ioctl and used the standard phy_do_ioctl which calls
> > phy_mii_ioctl. However since then, this driver was ported to phylink
> > where it makes more sense to call phylink_mii_ioctl.
> >
> > Bring back custom function that calls phylink_mii_ioctl.
> >
> > Fixes: 892e09153fa3 ("net: ag71xx: port to phylink")
>
> I don't think the fixes tag is justified. phy_do_ioctl() should work,
> although i agree your change is the better way to do this. So for me,
> this patch is an improvement, not a fix. Or have you seen a real
> problem?
I have not no. I've just looked at other phylink drivers that seems to
be using phylink_mii_ioctl.
>
> Please read:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#net=
dev-faq
>
> and mark this patch for net-next, without the Fixes tag.
Will do. As it would be for net-next, would it make sense to mark this
patch as v2?
>
>     Andrew
>
> ---
> pw-bot: cr

