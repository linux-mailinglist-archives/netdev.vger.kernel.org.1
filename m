Return-Path: <netdev+bounces-176667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E22A6B3C4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F6E3ADA3F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F41E8847;
	Fri, 21 Mar 2025 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX+BSGAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFA4206B
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532182; cv=none; b=KLlqV8odldp/OWULXi7HaLNwcqaaCblghI84/UUgH2ayim3hjMmynbuvz5zXA3Zcu+vityjzZb5jIAuBLAW92XrqY9WLPV/zoQwiHk50GspDAXoqEQ3MZM4tMiVLlxxYIihsg3aDG39b61fkGBHtwHDT+ve6WymCED69zm/htBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532182; c=relaxed/simple;
	bh=/J/l2xndIYzwBh3TqfFRxLFB3IOJWbXnrMRVsBmO9EQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CA2198OnQ7uZc0CXYol86uXz0DzEMelfQ98VSi4fc2wU0A8jXwdgmDG8reqermANUK0qdtHLakA2qKZq0PMgnYVVgQhIWJhRhIjcNOTIPyeh/4bZZaixMRIXMONhpVRLzjk8Bavs129ifwvpSOVYaBaIhKJc/u7vjXxWgf66AW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IX+BSGAu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225e3002dffso22265265ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 21:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742532180; x=1743136980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jaHeJ6qSwJ3u/x/VdsUMlK82s8mbA82yyCP5yyeo3Fc=;
        b=IX+BSGAuyK0faO/55sbuhOf5a6TMPLuOcU+ylFUZ5MObFrKbh/NGSgkYoGdnyxwJvU
         LVpSpPw/G4qLGhrSDXcl1sCkjaqGkiasx3V10nryp0ohrgpWKTN2UdwYkbzE6ntLbbfh
         PU+lRYeIaft0Inp7UFL5Mozo+xuA3LJr9FBvDJpZb63FMi3ac0vb0W7L0g+jqG5ckwyD
         NMyTnQWaVyXmA2ClNVbqeevl/1TyxKHJKQjLsPBAsvaD9NX1zHK2Qa26Tzw+7g30C0OV
         0zWH3nrblffaRxQZUP0HKUmFRIc6lJO6GsrmkzayA0p/VUXL7jGniXSeFLNBfJ2+sbhf
         xyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532180; x=1743136980;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaHeJ6qSwJ3u/x/VdsUMlK82s8mbA82yyCP5yyeo3Fc=;
        b=n7/hQrii/0D9o541F3FRVb3IV6VkrlHIhkrwWo2x+fVb03xGbeBhz0HQZmv3Ck7UFH
         +sj3qQkoVag3ujF/bViIIn1+rb2jrHUOFiCMgcAYdhhUb9pBPw9cGUOh4TUUDoh3V/7D
         C+o9Bs6ta8GhQiZ/7kcqHiHi481OiqsAgkQZZgAYOMHMyy/dJBbk8POoUobgoDZvYejM
         3hHQneI48VGkFBeYmKoEVQNvgaV/d4Tje2zCyVab+JedcIkiqmoJrgXREAgeoV4NA3lD
         bifIKKRZ0mRBKqV6fCheG7OVlrQgp7gBQlmKmmhqZaQI6JspB59JpxTB8fA9ewMAprIM
         h4GA==
X-Forwarded-Encrypted: i=1; AJvYcCWUUV21rvBQACzLmDyhJXbxsUXo8cHghBf8mnhKpPXMVdtxo1t0Tx8w9zIftFg1vnWcQwMcUZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKknJF/PbMQ7lI1958mRCRmXUvLc+b1sK7oIFv47SBKvE6+5v
	L/7OJv3aYmmzUhtrkEJzNDxV5hu4GG0Z1BXJVyGIuNSmdco2rhF6PBNcFCr5AA==
X-Gm-Gg: ASbGncsTP9gs/Ahvxh+UCNc9OEo5ITSPE1DEo8gRnBOI7JqCD4q8vJBcWqTXIvQOemm
	N1QjR82ZmfT/0/MqAFMqsjiF50jQJhY1usj5WVO/TBZeGOpKq1wevRxvGZsrMUtAUvieHK8VV6p
	BnOO7uDZTImXqgh0sntkSiBdMPs3qvlMAwDqG+XrmiRHYStkx/R895/v9fG+6FGSHXJU/2M99Pm
	VYwmDxsc3lw+VmM16gt8pbeT+/tEIe7iZblZUV02nWWzBZZvU5E6fcD1UJPSCw4joBueOj24pbU
	heibRY5AEQflO1w0FcSjPNThF0YLU1FtHEOKI7lWI1Va
X-Google-Smtp-Source: AGHT+IFCZZBsBpT+JgPon/LLEbu72ysiHsPxVJfQnDNrm7RkPGl69Wa7QQ0PvDzg1cJp1vKd8UOSxQ==
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id d9443c01a7336-22780e38317mr26158175ad.51.1742532180528;
        Thu, 20 Mar 2025 21:43:00 -0700 (PDT)
Received: from ?IPv6:::1? ([2409:40f4:3109:f8b2:8000::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da38asm6929485ad.186.2025.03.20.21.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 21:43:00 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wei Fang <wei.fang@nxp.com>,
 devnull+manivannan.sadhasivam.linaro.org@kernel.org
CC: bartosz.golaszewski@linaro.org, bhelgaas@google.com, brgl@bgdev.pl,
 conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/5=5D_PCI/pwrctrl=3A_Skip_scanning_fo?=
 =?US-ASCII?Q?r_the_device_further_if_pwrctrl_device_is_created?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250321025940.2103854-1-wei.fang@nxp.com>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org> <20250321025940.2103854-1-wei.fang@nxp.com>
Message-ID: <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On March 21, 2025 8:29:40 AM GMT+05:30, Wei Fang <wei=2Efang@nxp=2Ecom> wr=
ote:
>@@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_=
bus *bus, int devfn)
> 	struct pci_dev *dev;
> 	u32 l;
>=20
>-	pci_pwrctrl_create_device(bus, devfn);
>+	/*
>+	 * Create pwrctrl device (if required) for the PCI device to handle the
>+	 * power state=2E If the pwrctrl device is created, then skip scanning
>+	 * further as the pwrctrl core will rescan the bus after powering on
>+	 * the device=2E
>+	 */
>+	if (pci_pwrctrl_create_device(bus, devfn))
>+		return NULL;
>
>Hi Manivannan,
>
>The current patch logic is that if the pcie device node is found to have
>the "xxx-supply" property, the scan will be skipped, and then the pwrctrl
>driver will rescan and enable the regulators=2E However, after merging th=
is
>patch, there is a problem on our platform=2E The =2Eprobe() of our device
>driver will not be called=2E The reason is that CONFIG_PCI_PWRCTL_SLOT is
>not enabled at all in our configuration file, and the compatible string
>of the device is also not added to the pwrctrl driver=2E

Hmm=2E So I guess the controller driver itself is enabling the supplies I =
believe (which I failed to spot)=2E May I know what platforms are affected?

> I think other
>platforms should also have similar problems, which undoubtedly make these
>platforms be unstable=2E This patch has been applied, and I am not famili=
ar
>with this=2E Can you fix this problem? I mean that those platforms that d=
o
>not use pwrctrl can avoid skipping the scan=2E

Sure=2E It makes sense to add a check to see if the pwrctrl driver is enab=
led or not=2E If it is not enabled, then the pwrctrl device creation could =
be skipped=2E I'll send a patch once I'm infront of my computer=2E

But in the long run, we would like to move all platforms to use pwrctrl in=
stead of fiddling the power supplies in the controller driver (well that wa=
s the motivation to introduce it in the first place)=2E

Once you share the platform details, I'll try to migrate it to use pwrctrl=
=2E Also, please note that we are going to enable pwrctrl in ARM64 defconfi=
g very soon=2E So I'll try to fix the affected platforms before that happen=
s=2E

- Mani

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

