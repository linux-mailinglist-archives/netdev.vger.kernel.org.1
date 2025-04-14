Return-Path: <netdev+bounces-182021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49219A875E4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 04:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F5C7A60F0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9842AA1;
	Mon, 14 Apr 2025 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On/dk+CV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047FC13D;
	Mon, 14 Apr 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744598499; cv=none; b=Xf0mFRa8rZilAhA+5cNwlMtzE8lgGnnJbCHjrU3JohHH21Iwu+hg5DG90itEf/cTZBlpkiSghsQVDe58w5JcjA7f9iwfvqpMWazsov+uWhyY8Rh6S7nQTfXyLBLT1y/raPW+nd6yvIeesYyMgynI6DWs1ovIkR5kj7B7QWUdJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744598499; c=relaxed/simple;
	bh=extizdPSVHsFqm+U2lE/bv6dq9Y2BlWIqIlxZRWAm2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLA6QKWBnw4AOhA7oX6EY0opj4QbNTRNKNqLs5+IGnxkaNNXQLcN2gwWLnrazTurd58567NfoBw7epipnJvXgjELOz2ZeM1o0tHYfb35iNbxJvKbcL5RzJMEFu3SMVc2hm+HXWwr1MeSr+3G9KToYeS9IJU1AqwBlW3hv0lfo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On/dk+CV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54b10594812so4534535e87.1;
        Sun, 13 Apr 2025 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744598495; x=1745203295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECqEbIVAlk0Sg8vuMg77ZgqE4GcS+fY49rI9O9J+HmM=;
        b=On/dk+CV8WNtQsoiXdvRMO7tXUGEarx69TAbnF/4VAXxx/zNa5z0t6s5CFxR14DXe8
         pNcz3bo1pG+LuPm2sQMLzQmj//fM0sFPIqsR5fJAvvVb+GTQs8hQQeFrPlWub2+YXvoD
         hYbGmCQc16scLWghg0fZ0c2alccExweHxF/XfT/2rAtyczmzSMpBzyrYY2LXyvC4RL00
         6pBTqRcGZrIglNEIa8FEQ/XhpHkHuyaAMmuLhbzzzrwW9hIAhzAmIOp0vWxcbe6p/yIN
         JBqb1rdgUVvX+4V5RHRbaX8WQBCyU1nxhBnbSZymmYinMt9ZISIdbsBcpfAKl6ENX88P
         6FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744598495; x=1745203295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECqEbIVAlk0Sg8vuMg77ZgqE4GcS+fY49rI9O9J+HmM=;
        b=gEy6gMB0CpimkYFQ+33839ZKP/2uvpHR435KBv2vMT3c2Qx+Ehtvv0X7lwECN2s4Z5
         b38CcCAjtUkjySyE8WdMMF7fDjFAFAxBGEqlFyelgExmJkcwQzhEAyW1vVnX34yPrYlW
         0x4x6kxwfluT6ll9w1GcBq95RHmKTlZsERqfQj287BQnfrQneSUS55KTTHd5quKbX/0k
         PGhC+BIpKO1G1btl8yWbvnQSfKyNRwlqKWb5U9qNwrxb7MsUragIW5jcy/pwsNcOiRwL
         SNJFPXve25UHoevyBwRyRETUDuGHn+VkznK6D2C1x0/ocHLvQ5up67xQT4Qx/CpVyuIb
         IflQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHArqxi1YqFls4M1kfLrj8Y72ntpaQ/mcv+vHB3iusz2oRm7a/OPYxS/dfQFEK+hWwJePeY6GeuHUVhWk=@vger.kernel.org, AJvYcCWi/D+7Bj4pcYpvh9IzCdkNZYOvrsoq6oiVIs+ePQpoyrIXzg02DoTa1uKxIIoKm4T+HKl1V92P@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSxJbYZqr/oFk0WWcm//7T1SHCPA9DGWGaraySLE+0s7igu/X
	ZuoiLjSnD+1mqe4Di8F6t6ba+ysrYn5CmohKFmlynxqMvpUTyYHcOzzwVMvjHEk3optEDCRc3el
	R96bjhu+HYGnWq753jAWbjAHTHJY=
X-Gm-Gg: ASbGncstOygpom2A0n3Jgh1aGybC0s3aq3INL81LdulMboUPcseQnJsLWasJTiimlG+
	dRSRVJOfkV3Z6kH4pUxvhdOfURuKp9QzoNMI0I2B9bSj0CuIuYeCSHK5vE/HP6jLBrHE7eML2BQ
	HmSc7zqw1aEpbtmkSsPQfhxA==
X-Google-Smtp-Source: AGHT+IGh3+UtDVSwZOAeflMNi989+1QMQ7rZO+Y4T3i7PvjL/qcsgcjyJBylmBWqEVzqM7OKp2FBQAhQpyLWJPdUthw=
X-Received: by 2002:a05:6512:6d3:b0:549:8b24:989f with SMTP id
 2adb3069b0e04-54d4522dec0mr3141051e87.0.1744598495278; Sun, 13 Apr 2025
 19:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413133709.5784-1-huhai@kylinos.cn> <Z_vGfedEZGnkM6H0@shell.armlinux.org.uk>
In-Reply-To: <Z_vGfedEZGnkM6H0@shell.armlinux.org.uk>
From: =?UTF-8?B?6IOh5rW3?= <hhtracer@gmail.com>
Date: Mon, 14 Apr 2025 10:42:10 +0800
X-Gm-Features: ATxdqUGIX85VbmoHalnfairYb7tvOzQg_bnsDRs5iNV9xL801P1CwtL91AZzFlc
Message-ID: <CAAq-RfS0_vDJPg6mstUhCk+e3egvyb5oF=LbWb7Ui3zkUbvhqA@mail.gmail.com>
Subject: Re: [PATCH v2] net: phy: Fix return value when !CONFIG_PHYLIB
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, huhai <huhai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Russell King (Oracle) <linux@armlinux.org.uk> =E4=BA=8E2025=E5=B9=B44=E6=9C=
=8813=E6=97=A5=E5=91=A8=E6=97=A5 22:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 13, 2025 at 09:37:09PM +0800, hhtracer@gmail.com wrote:
> > Many call sites of get_phy_device() and fwnode_get_phy_node(), such as
> > sfp_sm_probe_phy(), phylink_fwnode_phy_connect(), etc., rely on IS_ERR(=
)
> > to check for errors in the returned pointer.
> >
> > Furthermore, the implementations of get_phy_device() and
> > fwnode_get_phy_node() themselves use ERR_PTR() to return error codes.
> >
> > Therefore, when CONFIG_PHYLIB is disabled, returning NULL is incorrect,
> > as this would bypass IS_ERR() checks and may lead to NULL pointer
> > dereference.
> >
> > Returning ERR_PTR(-ENXIO) is the correct and consistent way to indicate
> > that PHY support is not available, and it avoids such issues.
>
> I wonder whether it's crossed one's mind that returning NULL may be
> intentional to avoid erroring out at the callsites, and returning
> an error may cause runtime failures.
>
> You need to do way more investigation before posting a patch like this:
>
> - Analyse each call site.
> - Determine whether that call site can exist if PHYLIB is not built.
> - Determine whether returning an error in that case instead of NULL
>   may be detrimental, or at the very least list the call sites that
>   would be affected by the change.

Yes, when PHYLIB is not built, the relevant call sites are not
compiled in, so they won't exist.

Thanks for the clarification!

>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

