Return-Path: <netdev+bounces-201965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FCAEBA0E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C719217DAF6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBC2E3AF8;
	Fri, 27 Jun 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RtR0Uk0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990B2E266A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035212; cv=none; b=fhZNQ3Ddb5vSf14cS+sSZ2AiX1PyweS9qH3xDm+kqLybGXkZNO51F0PQ4v3H7x8Wesf5Jh7EswSRaEn+L+D0zJNXvV0s6DwdTaEA96iAWLGBKbnKCJbKeXkhWdeqUpgT+lAKdO0ksrFnuRiXzx+aq2P+gGf/obu/FV6lb1CJpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035212; c=relaxed/simple;
	bh=y6FgFNYfWFVz9xj4J77T0Xzk1ZGop7saqLDIRvLscQQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=u4tJmcr/OXA8BhIi9CzOMqH/53qYViZPpOaWWnEMENrJAUvsuYXc7meD6uq3YrGnJfRMaWVvb+dTJTmEGxxKtiSZqEak/BoAOmC7bMry6WHij7mX5tZT591IEozTFy2GoybJu5vHPwcdsFJSu4/3BKmX3/3aF3SBCnKFPL6+84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RtR0Uk0h; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1847728a12.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751035210; x=1751640010; darn=vger.kernel.org;
        h=autocrypt:content-transfer-encoding:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6FgFNYfWFVz9xj4J77T0Xzk1ZGop7saqLDIRvLscQQ=;
        b=RtR0Uk0hm3ZBbFbgD15fJ59W47HEeA1JBriZbCB4JFkxWKym5otdCNUA9QuEyA18KH
         1kqSYgQQz+L1Pb7D6iFphxIzzmUqoVm9Hk00mktGuMrjwiH67eY+1xnuDT1SPGVdMe+E
         dHY2wYfxJ3OZXaU1/1QCHeqVXtBY9ATVabC+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035210; x=1751640010;
        h=autocrypt:content-transfer-encoding:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6FgFNYfWFVz9xj4J77T0Xzk1ZGop7saqLDIRvLscQQ=;
        b=fkhpm6TO9dEDkO/45p7Sv3tD/VgsRUSMHDJ4IAS8+nisQfvyX0Ui4x9MXoKCr4ojjs
         S5JcGWkRTc/pyRncD/0SpyPELrbMcOUceoyO/25hxtxvtnHjBRqisziqcppTkv/bXv+W
         jaxzuHdBvASlyhVcIVRKLhnQ0MVWo4JMD8+LcKCrFbNozszZy6r6gGoBM5Mliopkszb5
         ODLP+0Cik0wlEyXkw13gPwhVZ128RIknhTb8ThZDYwbWiCkuBDaAJcQ2uXxEoDAxDT47
         mkwnPUQmblrLgmaD8XNOExr8E4Ovh2YgmDx4eXB7pdsaVWCpGIyB/skkvxHezUWw4OzS
         X93g==
X-Gm-Message-State: AOJu0Yzae+JcqEnOd8SXU2I5tyyOF033EAfvT5I79PiU+EV2ieNdAOA4
	q7bjqV/qukbC5jkjXn3Efx/5N2moYTsSxDPYsCe+83oho6Jmf9JDbXTZQDJz0etx9g==
X-Gm-Gg: ASbGnctTcNFsdE5d4BFvSXioltrgPTjqQfJ0LbQ4W6mzAqmxsHR1o3sWl5tJdm00hfr
	Z0W1SdyIeB4I+pkKjCqvliOLBNSTcSFw4qffjv1ku/WmdYRPPOBU/ucuJys0OItAzmTVXvl6+2P
	qVV1Qk2DxufUFprZBA1KHUCFkb2SIT4xKKLk8cqebmMnpnv0HfxQyvZNeOfFWqndu2PndOuphfe
	dywSWKHAbDPkdwu6LoIb4O2qkOJfa/s9Sw/7p3QvXJf8T8E2erQ8Do51F2e+/ddsLU0D9lDIXAq
	8KNTrh0d7qQOanRaHNWfwaXGInu3+xRFCnQZ2NKZGlSaXl+QU7WX6hkSAWfG+cB2z2ImDR5cPAQ
	=
X-Google-Smtp-Source: AGHT+IGRvMq4BjB9kb3+iA2gC5GHu/MtQOLx70uk/AMc/uT4Q/s5ywB8MGnfmXdva8v0jdCerV2sVw==
X-Received: by 2002:a17:90b:4e8f:b0:313:fab4:1df6 with SMTP id 98e67ed59e1d1-318c9280acfmr4490158a91.32.1751035209737;
        Fri, 27 Jun 2025 07:40:09 -0700 (PDT)
Received: from ?IPv6:::1? ([2600:8802:b00:ba1:cbcd:eba8:f2f6:b683])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1b54sm17784855ad.15.2025.06.27.07.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:40:09 -0700 (PDT)
Date: Fri, 27 Jun 2025 07:40:06 -0700
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Zak Kemble <zakkemble@gmail.com>, Doug Berger <opendmb@gmail.com>
CC: netdev@vger.kernel.org
Subject: Re: BUG: bcmgenet transmit queue timeout lockup 6.15+
In-Reply-To: <CAA+QEuRZXkPjN+=mgeLL8znYsMEpsk8a5omJ+eC1y-0SFnSrCg@mail.gmail.com>
References: <CAA+QEuRZXkPjN+=mgeLL8znYsMEpsk8a5omJ+eC1y-0SFnSrCg@mail.gmail.com>
Message-ID: <C87FDFC5-FD31-46EA-B95B-E6BE03530B17@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
 3LBXw4WCw3QhOXY+VnhOn2EcREN7qdAKw0j9Sw==

On June 27, 2025 7:31:23 AM PDT, Zak Kemble <zakkemble@gmail=2Ecom> wrote:
>Hi, I have a Raspberry Pi CM4 setup as a NAT router with the bcmgenet
>ethernet on the LAN side and an RTL8111 on the WAN (although any
>adapter will work fine for this)=2E I've found that downloading
>something from the internet to a PC on the LAN while also running
>iperf3 from the Pi to the same or another PC at the same time will
>cause transmit queue timeouts and queue 1 locks up=2E Network
>connectivity is lost and a reboot is needed to fix it=2E Doing only one
>at a time is fine=2E
>
>6=2E14=2E11-v8+ bcm2711_build
>https://github=2Ecom/raspberrypi/linux/actions/runs/15676052461 is fine,
>no timeouts=2E
>6=2E15=2E3-v8+ bcm2711_build
>https://github=2Ecom/raspberrypi/linux/actions/runs/15845884292 is
>affected=2E
>
>The same occurs when I backport the latest driver code (just
>bcmgenet=2Ec and bcmgenet=2Eh IIRC) from kernel 6=2E16 to 6=2E12=2E

There have been a fair amount of changes in the 6=2E15 cycle, would you be=
 able to run a bisection on the driver alone so we could come up with a mor=
e targeted fix? Of particular interest would be these changes:

<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
commit/drivers/net/ethernet/broadcom/genet?id=3D3b5d4f5a820d362dd46472542b2=
e961fb1f93515>

We will see about reproducing this here as well=2E The multi queue impleme=
ntation has always been a tad peculiar given the unequal sizing of the numb=
er of descriptors between the priority queues and non priority queue=2E

Thanks
Hi Zak,
Florian

