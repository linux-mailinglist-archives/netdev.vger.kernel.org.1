Return-Path: <netdev+bounces-215889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF8EB30CD7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A48606F64
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673291A01BF;
	Fri, 22 Aug 2025 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAkux7rY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACC1F3FEC;
	Fri, 22 Aug 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834358; cv=none; b=khiGAcvmDvxE3oRoF0LBat7GrdvUIevHCc17aGURaM437sXiq5OUkSDSbhRY6EYQEPzp7GoNeWZ9kDwkdpuwlYz6ilVRfThJu4vP3cBMvxFyyuNYfSzzaqpOSVph6HNFl8TM8unQDtwodoQUB1PWsrfPpn5GLWBCT9Y2SFEeGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834358; c=relaxed/simple;
	bh=DwT9jB9xEL5DJdob71yB+pqiA4Dmg97hULwKPrjDOCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NG4MrQ91I5qrAPLUYke8FEyNErBl18MUCLMB3yXo6cSOcaftp/6GWajdgVvRvpQoJvIWZXSyfceNu0kVWUVQy3JEmXK2RDmvKYvy3MQVDW5cfjI5RBLoPBoCzC6lg5b+sfFjEHIQ7ZVKoasHwj0vG5pbYd3rT7Y3hewFC8ILHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAkux7rY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1655822b3a.1;
        Thu, 21 Aug 2025 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834355; x=1756439155; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg2xoapVLQrVMHettX1odBe9dNrFVJwjrIiE7N0omTs=;
        b=lAkux7rYrpmoiq2+qhtw/ZvLeulHxYjivgouR5I2CiDp7C6FwJhQUnrrpuzC4eyMeH
         M0SZmLnwv/faTmaTC4Qf15KrpJL1cz4NXFDl76XJ/QxvnpqjXynICnb/ubBCffmehkst
         5rnT/PccRqdbrUI6ubZhyF7nR0cJyI4623EQKte37ixOCHYJFXfaTuJXlCIL5ZaWYfEd
         ZO7EigbIiZqG3XH8AcxaQeE0jIHXp+FYdXM3VgMPVl2X1ILJT2bNkadK+Juc2PyHZ46J
         F8/T/dfHh2r9hNKZ59mc/1i28gt+6YsXGHSqES3JATAH/mRmm33N0p6BlhQxNYTlz4K3
         tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834355; x=1756439155;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg2xoapVLQrVMHettX1odBe9dNrFVJwjrIiE7N0omTs=;
        b=J/r01EH3C8yptHvy982xJa3DXtjVQaMu4AVHQqieNQLymWoKGQ0dc4wLF4Nm6UKc+D
         v9GgvsKMyCJ0fH9hg07HeZsbMAaaBI6v17147c8X7xhMIWRIWQwt873tRqx8N6vOK/Ai
         OJQK5pX/iHyylwigPgRI0AvCl7Bo0vDHvFkbigzLjw7MLAzm0SNNw9/EQFnLE1O7GVfH
         6oKrbrZwY42OxVhaxzHbktjNc3zodOqMSL1b9AYb3eg0llfhuk3F9OVZUGuvMDjjVpJw
         YXrIRcTOeS9fUhI0DP/wo6Pk8M0G/oF2BAW/lwkcnSNtlkU3QcEbCEq1KoAx5Gn4N7QP
         Jhpw==
X-Forwarded-Encrypted: i=1; AJvYcCUmZGEufMAITotwRLhEw20Z/7i5u/KmbLm5/zbWZSL6UwrwF8GaAvirgC2+aN7v4RNPwzapUtnmNrxnh4M=@vger.kernel.org, AJvYcCWCQ6JSv77FTYkW0bisZpiED8OY5IjxQmzwAbo6L/HopgcIjdNCRaLme9IEynP+ioLqBscYe473@vger.kernel.org
X-Gm-Message-State: AOJu0YySWz2KhMRUfR9wgEAIc2k45tscjwssQxp4nrF0Hj8RdCjmXjFW
	v9pX5hi4xhkRk0K1VPisRt9nSkua7+lGvSdEf1SuGoo5jI7xgJYp1uZJ
X-Gm-Gg: ASbGncvhl1HD68LbDbTGA3x1BYZnWt027jl1pnklj8BXOWKI4FuK33lHvVHzoFCMHhu
	+mV69CZ68e+iXvVFZ4Jn6MIYjOSeEw1PzfZOUe+0E51Js5bYf2JGBngL3II0UPhOFu8vQeYbEAW
	pV6rsp02/waTogMtJnT+lWsV6JgZuSnUc4ROQB5XcreK97zlkqMhARYtcPLlBfCl3dbLsd1NAHO
	ZWwTqHPozXDY/wN/DSdpuboUrKzraIU5PqEXQGCnpFY2Ce83oPnjlRMiyfVAkkNEOmofc2SvE8f
	EGex2lQn0yOAjg2vmt6CpojPEB3andsAHft21anVLCOo2keDxL4pbhfdztdIiSIRxED0SyALlYv
	M+D54PF+klaxHWGEWzetG0HgTMJbWbx1tbzbh33G0QuAEG+Wd7ymS
X-Google-Smtp-Source: AGHT+IH2rs3ce1nmGIQuqUJpbn8s6PSuC59+hWGY/5bdE3Gnt/j27h8x55vafz2Bij2jYO+PLj3lAQ==
X-Received: by 2002:a05:6a00:2a8:b0:76e:8bb8:b1b8 with SMTP id d2e1a72fcca58-76ea303345fmr3946540b3a.7.1755834355093;
        Thu, 21 Aug 2025 20:45:55 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d547405sm9411888b3a.98.2025.08.21.20.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 20:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 12:45:51 +0900
Message-Id: <DC8NBXG4QWKW.2RWDAM6L66YBE@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dlink: fix multicast stats being counted
 incorrectly
From: "Yeounsu Moon" <yyyynoom@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>
References: <20250821114254.3384-1-yyyynoom@gmail.com>
 <f06befad-ebbc-441f-95e5-c206bcd512ce@lunn.ch>
In-Reply-To: <f06befad-ebbc-441f-95e5-c206bcd512ce@lunn.ch>

Thank you for the review!
I sometimes get confused about whether a patch should go to net or net-next=
.
I will send v2 with the changes you suggested.

	Yeounsu Moon

