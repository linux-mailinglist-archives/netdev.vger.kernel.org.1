Return-Path: <netdev+bounces-72352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF10857ABB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99411F24FA6
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B400537E8;
	Fri, 16 Feb 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO3CoV4i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BCD55E4A
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080807; cv=none; b=ZLH5enCE1Huj/NVK7IAk9HTp3I3jP2mgAQ4LmzfIzNGiJY4GVe3q793X3wY6zo07NSKFUsSEaPXNUG79dIluG0Un1NgW2Svps8eLU+ACa23n54abh7oGU56R/AqSB77OPmg8NJ/JrTC+bf0VduTpCO4Rr65qFPmCdrSYeaYsdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080807; c=relaxed/simple;
	bh=MnJdCjsv2w23y1gi+1imz6n7s/tzu2xOCSOIUwNNloc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bYxxNharCIjr3+IKPLSLJwGEXJHFXUuLksDQUcGnWWZbMWdO2whftjkjPvfl/kCSvXNuE4qyE/W7OFajRgyi0wooB9J90MHpYiOEti7sPZPICjADgvQxCdTnSLo5dSB8BlnnRSEPoOhfiaRWXvCG/kSslyOimYuAH93GEtY/fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO3CoV4i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso189888666b.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708080803; x=1708685603; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LUN3OUDnPGrX88v/ALgDwZx7njudAWLkRccPoHEFKE=;
        b=OO3CoV4iP24VNeGM94ryIxEI5qtgtaQrFAmW6CGmZJPTxzoP/m/6ZjR9xX7P7RWfWX
         vsg0bTEpX6Cmx6e3jlHHEOzDWR2cvQ109h/1/7ort3EAeDVOQOzHCzFdCo+nBm4w8FEm
         vWN6pgmyIG3uFCh8pBMVYyvYW3FPlu6t0Tf/BoXlwWypIpoo0NqpJi18XYBo+x7A6417
         RZIrAn/vzG4sIgeP7PNuddGa827IO3lS2lPnlLXweKYXZAN6AeX2WNouQuCfeg+JewRs
         kICMlT29spAe9fEE79ERjVtf2mjv+EH/iZAf5qjC/k5cxB5tHt1x6ivZowJjKEXj0YLd
         2aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080803; x=1708685603;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LUN3OUDnPGrX88v/ALgDwZx7njudAWLkRccPoHEFKE=;
        b=VA4qq2i845oIvmpr3053VfK1Vx1qqZElBM60Si8fglQ61rtO0D8kbE1jhX4ZUszqAP
         FqhS3eMVsTo73E2kz6hdLWKQnvr/7mZU997ICEb9H9G4jkSMujc4Aqtv6X6LB6hmn3qq
         +zbbKZY9RdAtvSTajR+nYnVUzVBKryPt91Nc9q2H0H48l1I3aDNuF5tPHGaEX7p1qYxt
         e0qKSFZkJ9gPkw7o8kh+TZ96qROjMVw24rYVwlOMY3sUJmP9cAsSGum3RHUdhjCRY958
         j3scge5PGKf/7xosHqJ/yZ6pkVR+USiY1kW7EHnEv1cjFGWSDZgGSEsBIdqTfvkgB5zb
         Cdzg==
X-Gm-Message-State: AOJu0YxxjECj1gxmKEooQCoL6cZI9VG1NcFTNT7NdsQ7nG4J9rGuHjbH
	h7LMwe7LCNPk+uJVQNFdxfW3e1WTsubUunrEf4RCKBCx8NFCUUJVSCzjbSwb
X-Google-Smtp-Source: AGHT+IHORvLuGzGUV5NS55jsnJT/zk5RVh1tXfctPjbIdG73p1/NxQBFse5/aIEw7MjTVL+lqeAugw==
X-Received: by 2002:a17:906:b0d9:b0:a3c:f048:c9eb with SMTP id bk25-20020a170906b0d900b00a3cf048c9ebmr3177434ejb.12.1708080803367;
        Fri, 16 Feb 2024 02:53:23 -0800 (PST)
Received: from ?IPV6:2a01:c22:73a8:7a00:dc5a:d3b4:cb75:f027? (dynamic-2a01-0c22-73a8-7a00-dc5a-d3b4-cb75-f027.c22.pool.telefonica.de. [2a01:c22:73a8:7a00:dc5a:d3b4:cb75:f027])
        by smtp.googlemail.com with ESMTPSA id s15-20020a17090699cf00b00a3bd8a34b1bsm1447566ejn.164.2024.02.16.02.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:53:22 -0800 (PST)
Message-ID: <77a48e2f-ddb1-44d8-8e3f-5bc5cb015e9f@gmail.com>
Date: Fri, 16 Feb 2024 11:53:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Question on ethtool strategy wrt legacy ioctl
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When working on ethtool functionality on both sides, userspace and kernel, the following questions came to my mind:

- Is there any good reason why somebody would set CONFIG_ETHTOOL_NETLINK = n ?
  Or can this config option be removed?

- If for a certain ethtool functionality ioctl and netlink is supported, can the ioctl part be removed more sooner than later?
  Or is there any scenario where netlink can't be used?
  Remark: I see there's certain functionality which is supported via netlink only and doesn't have an ioctl fallback.

- Do we have to support the case that a user wants to use an old ethtool w/o netlink support with a new kernel?
  Or is it acceptable to urge such users to upgrade their userspace ethtool?

