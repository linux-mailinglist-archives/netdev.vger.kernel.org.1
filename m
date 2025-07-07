Return-Path: <netdev+bounces-204695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF6AFBCC5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190C17B3071
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21321F4CB2;
	Mon,  7 Jul 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtPObzA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0A8488;
	Mon,  7 Jul 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921283; cv=none; b=sD8Q8ReL+2rSV8ZEk977od97FkHiWR5d1lBEUNagi0eHqzq+4c80vFIIas7H4wmjMtCtcPJHf+abv+yhEtV7piaD4UZaIfTsySrsKeuoLOjtoCavbFg1Ynm3201QXf+koVcSlXQGDjEpVJyE0GuNXwUQqDVUtKSoOlVAu5ciEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921283; c=relaxed/simple;
	bh=xJVtwmc/iK6WqebKZ4qTtDS2Kdb9R2RwXSRmNLz/nOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is770slEQuetpqD0VAjtXZ15efvb9LBfrqVJbeVSchGvop7kI30xeQovAiknCmlw/Lyr7kLCeM7zmsOEfOTeCS7b8t07aIHjDXd5zJMlQdbGRtwdz8RztLbLaUtLbazKSTRdENCsvFbv569bAaDV/bYX5VTgwP5mwLcswFDSDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtPObzA0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so3155469276.1;
        Mon, 07 Jul 2025 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751921281; x=1752526081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTZfTlmBEIK7Q+Z0xK68TlVvd/e06jW2J6dQiNg6krg=;
        b=FtPObzA0/hLiqKIwjbvR2R656SoCIlAe4n9rSnAPxC6LPezRzVqxqW2UbzDXfBEd9x
         alyQlYRDJqYloqtZd+qexjaTpHgjKpsiB/i0PISQj+OtkjEDwvUtgvUGHl4BwyDiKSIk
         iqTu49KEqLPOVBs3+FtEf9CgLr6hdKJv/s6Jq6+lg+92uLk+OSPDY//IQuL1IIUfsPPC
         EWD0f+vlz79iSRPmMfGrSR85MoS9ebLpjY4qw4Og4tggGP87vzwDUuVrrHXwZcBK+Et1
         yVk6vPV5+kasd+M+SorVULelFqf3LyTa+s4veXFV4D4/maZ07HDYQ4e4vSGbjYdH6ftu
         GgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921281; x=1752526081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTZfTlmBEIK7Q+Z0xK68TlVvd/e06jW2J6dQiNg6krg=;
        b=V4wtAapzkpAFTdPn1g4spTxwmpSRr2vsNKl1cHuvUF0sfGf8ELjm5DghX7hTi3eh4d
         yudUKJV0ZX7COAoxr2IjVK3WIr00hSkMeIVjcFeOzmGmVPkif++cs7UB3jqVHjRo8KxG
         oBPtos57slVRlSrghoon6iWXdpVtOTTndhn0Jc6X4jRE9QHc/nY+/WJDijkr+jXySOM0
         T3G2N01+k5ygk07SirAWYFrkwL4sWGU3gA78Qq6410FsShxUtayQMeImHSJOqaJZDw+X
         ZQw+XOXHEVYTTJ8NV65LBV0tHTVzqmYsDk9KFUEtk7F7E4Cy/LDs3QKp63dvRWjtrdlG
         9UAw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ic4NfXkFNE6A1yjoUVwrBtQ/tNyHjb8Lb9AHxvzmIYXgbE+zPA5St+DJgwbyDYupPK5IOUTPfJy+lZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo0Un/uaHsMvICXq06dCxbAiSWtYHqqKFknLJDv4R3vf3/vV6a
	E7Jjf/Q8EfZE9lsSr1Qv1X71LPtl0ckHsNdjA7Ek0LKZmMHrJSIIiPz9mTnqMM3KmrsBR/bOkip
	1ddEUiBRmk8Y/PFxPJLiGsDyjqQagCFw=
X-Gm-Gg: ASbGnct/F6dEx0a54NnBZ6gyInMHG3+h5wfFPerikrQC5l7u3RsiyVIF2zhxLK+z2kG
	DOEj23QgQEvXoO27nXRpFN8f2MTI7JbibBw6lhxb65LABUocMjuGIQUXkj+kH7I2dVel1f2MkfU
	/9Eg/yLTbr+iWTD6hdO/mt9bUpTl6NkOcraGRntcXk651U5ek8Ho40YgsoEf+fU8aLt/4=
X-Google-Smtp-Source: AGHT+IHWxLzF1XOgg0Mvh9rrnM+tU/Df1j+N31sIXa44sA1tQCOEDRPX9sKv0BiyOvyazV5xtA1UF0jHJJNPuiCbwdk=
X-Received: by 2002:a05:690c:f10:b0:70e:1771:c165 with SMTP id
 00721157ae682-71668d47310mr192088597b3.29.1751921281170; Mon, 07 Jul 2025
 13:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707003918.21607-2-rosenp@gmail.com> <202507080426.3RX5BOHi-lkp@intel.com>
In-Reply-To: <202507080426.3RX5BOHi-lkp@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 7 Jul 2025 13:47:49 -0700
X-Gm-Features: Ac12FXxnYnizo5pcZVLFOw4eNbzaqe2Xe-OqD4rjrt8Ta0IeWk0gI-_xVQvF8YI
Message-ID: <CAKxU2N83JjTG19_GD-9LPJfe=aY4tU+7dFjRhFqGeLDn6beGKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: dsa: rzn1_a5psw: add COMPILE_TEST
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>, 
	Necip Fazil Yildiran <fazilyildiran@gmail.com>, oe-kbuild-all@lists.linux.dev, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 1:25=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Rosen,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net/main]
> [also build test WARNING on net-next/main linus/master horms-ipvs/master =
v6.16-rc5 next-20250704]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-ds=
a-rzn1_a5psw-add-COMPILE_TEST/20250707-130922
> base:   net/main
> patch link:    https://lore.kernel.org/r/20250707003918.21607-2-rosenp%40=
gmail.com
> patch subject: [PATCH 1/2] net: dsa: rzn1_a5psw: add COMPILE_TEST
> config: alpha-kismet-CONFIG_PCS_RZN1_MIIC-CONFIG_NET_DSA_RZN1_A5PSW-0-0 (=
https://download.01.org/0day-ci/archive/20250708/202507080426.3RX5BOHi-lkp@=
intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20250708/202507080426=
.3RX5BOHi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507080426.3RX5BOHi-lkp=
@intel.com/
>
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC =
when selected by NET_DSA_RZN1_A5PSW
>    WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
>      Depends on [n]: NETDEVICES [=3Dy] && OF [=3Dn] && (ARCH_RZN1 [=3Dn] =
|| COMPILE_TEST [=3Dy])
>      Selected by [y]:
>      - NET_DSA_RZN1_A5PSW [=3Dy] && NETDEVICES [=3Dy] && NET_DSA [=3Dy] &=
& (OF [=3Dn] && ARCH_RZN1 [=3Dn] || COMPILE_TEST [=3Dy])
so it's probably better to do
depends on OF && (ARCH_RZN1 || COMPILE_TEST)
to match the pcs driver.

not sure it would fix this error though...
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

