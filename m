Return-Path: <netdev+bounces-177735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EEEA717C8
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221B43B1931
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDD1EB5C0;
	Wed, 26 Mar 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="EZtd1UcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7C1E1DE8
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997021; cv=none; b=BGPhmBqbHI+spQ/oOhfnTnykRDu2MX3sm9A1Ykfjpo5+WaspgimZ5fApRWSsu5rfR8tMVbw30GGEAHQy6pz2zUwFK4MpPR7ug1wYNmLKKQu0eW9mZg5jsinHWqB/5H6aTGG8WYZx0sG50FeNE2K65Da7as7Mk/TfUrFcUSnROt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997021; c=relaxed/simple;
	bh=AA4fYl5ss2AScsJa4WQ2By0P4vTUaQbcp4z0DUHId7o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t+aLgogAjbGokwFoP0Dnuh/xQTqKb638NfF9xaEli/EHxOiN+5LbECE6B65CPmjvNf91/xebmPC3sFBDM/6Q0STc+uoTCWLUUZUyeqV9AW7oXMXEcjcLMP0DFhEBrOWkpS/fISCDe888Lxl4Y00P9uMZQWcqG8k4zJ5IsCY8LRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=EZtd1UcG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913d129c1aso652163f8f.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1742997016; x=1743601816; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA4fYl5ss2AScsJa4WQ2By0P4vTUaQbcp4z0DUHId7o=;
        b=EZtd1UcGaeU12UU08EJ2icF7M7yxKhz7zuKFPTBwaYxsocbpiPFSZVBxKYdASl7byz
         pZB4AahbVsbxAKvAodhO1qZSVink9rAkeFbVPpGwE1uGTwenjyJiuvdHQAuL4KAtTJ6t
         qQJPUjCk8svAuxfexr/98v81PhKq6CarJAFaLO2tz7YcToJa4iFMkZA1BQbsdP047JVP
         BCCIduY/2+Ihj9aNzpvN3SyFMJA3Wllb+NqXvH9sFZk5+tm8qsJhwdbUMEVO54iX6HLA
         8+YWi70/ACN5msnAmiLJzYgFvK4DQ4X8WB9RUjN8e1UKIwFfxvoeGJlMl2WEAbhA59dR
         cYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997016; x=1743601816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA4fYl5ss2AScsJa4WQ2By0P4vTUaQbcp4z0DUHId7o=;
        b=EMn7Dsos3yQiSE7XNoULCVzFxB/w6odsv2VxTEbH4W8obj6GqgWgkJ7dqcphl0dXca
         bo76t2I5fNyOzLQHuBI+d7nRp4phRDcEb1TpvHtINmAbZcGJEWZko1vG2U7HYr2/f825
         1UKIJE0uRLnZLTbhuRBSbnwfPoviOIaAhIrk9n5JspSAw5QnxBJq+4I6J4lP7xn4zT3W
         qpYGo65MD/FAinkEaZ6ZKM6d0/1llwnA3GRtND4/okT2aTb4VAAer/7k/DtyjGLxlIaP
         ecK9dhGoFXpoeL038/sOfgFPBW23Itd/m+b+WGTte9dMjRKPO/P3RVuF/qaCVPbQWxr3
         7/aA==
X-Forwarded-Encrypted: i=1; AJvYcCWn+VR0oqSxOMk2c/19S1+t6rfPHAMDSr/uy8H/GQsjD0crRa297yrcsmWnSYu4EZHofCS8zhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAxoFuhHCOPMznF8eUj9tncoaKZm1yRt8yBlW1I/VGXACgIJx
	6HpE2IM4EtBiok1VuuGkK71XFbgqh7LmGuAk0rEJYPx3JmFP0wt2YTOmgn5vIbI=
X-Gm-Gg: ASbGncuQoTNKZtfyKuIZ+crnv4kDMbOMwy3IOiRqYZu3WVcTkD4AclkYBXQuBg5NVit
	qRRZrFhaqN4/Bg71Edrp5u7NLbZ8xbamuNcFIVyuKdiSiQNPJX2JY1w2J2Kwtg8h5TttzRyH9O0
	pd9YVGUl4vwEI7P6KeuFCorsFXT9cm4OT0ElAzLCFVjYJ+QxDqJf/qaSOvD1KnkH1jrdSTdRDzy
	z5PCHpFgiIoweXmCkncIvEfc3sq4sWly86Wukwwms3CSe3WDQQMnfV9FSachm7zmFGaLkwXHLQ0
	MVXDCOat53NyMPTGSFgsjoIgzyF/4tTxCOyE/zeCnnLAGi9cVPhXdAeFv7st744lyI3di2k9pGO
	fchKaMc0R
X-Google-Smtp-Source: AGHT+IFodC7E3FU1W8ZLhSnQH5tR1ENtZ/ME/aC2uDU71UdflN+c7QlCPNjoJlFrWjY4L1trUTIN8Q==
X-Received: by 2002:a05:6000:1a88:b0:39a:c86d:e094 with SMTP id ffacd0b85a97d-39acc46dd0bmr3287301f8f.17.1742997015791;
        Wed, 26 Mar 2025 06:50:15 -0700 (PDT)
Received: from smtpclient.apple ([2a02:14a:105:a03:4178:8ead:91b6:bfe2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82f1bb80sm2568465e9.28.2025.03.26.06.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:50:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: bnxt_en: Incorrect tx timestamp report
From: Kamil Zaripov <zaripov-kamil@avride.ai>
In-Reply-To: <0316a190-6022-4656-bd5e-1a1f544efa2d@linux.dev>
Date: Wed, 26 Mar 2025 15:50:03 +0200
Cc: Michael Chan <michael.chan@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Linux Netdev List <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBBDA12F-05B4-4842-97BF-11B392AD21F1@avride.ai>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com>
 <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
 <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
 <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai>
 <0316a190-6022-4656-bd5e-1a1f544efa2d@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: Apple Mail (2.3774.600.62)



> On 25 Mar 2025, at 12:41, Vadim Fedorenko <vadim.fedorenko@linux.dev> =
wrote:
>=20
> On 25/03/2025 10:13, Kamil Zaripov wrote:
>>=20
>> I guess I don=E2=80=99t understand how does it work. Am I right that =
if userspace program changes frequency of PHC devices 0,1,2,3 (one for =
each port present in NIC) driver will send PHC frequency change 4 times =
but firmware will drop 3 of these frequency change commands and will =
pick up only one? How can I understand which PHC will actually represent =
adjustable clock and which one is phony?
>=20
> It can be any of PHC devices, mostly the first to try to adjust will =
be used.

I believe that randomly selecting one of the PHC clock to control actual =
PHC in NIC and directing commands received on other clocks to the =
/dev/null is quite unexpected behavior for the userspace applications.

>> Another thing that I cannot understand is so-called RTC and non-RTC =
mode. Is there any documentation that describes it? Or specific parts of =
the driver that change its behavior on for RTC and non-RTC mode?
>=20
> Generally, non-RTC means free-running HW PHC clock with timecounter
> adjustment on top of it. With RTC mode every adjfine() call tries to
> adjust HW configuration to change the slope of PHC.

Just to clarify:

Am I right that in RTC mode:
1.1. All 64 bits of the PHC counter are stored on the NIC (both the =
=E2=80=9Creadable=E2=80=9D 0=E2=80=9347 bits and the higher 48=E2=80=9363 =
bits).
1.2. When userspace attempts to change the PHC counter value (using =
adjtime or settime), these changes are propagated to the NIC via the =
PORT_MAC_CFG_REQ_ENABLES_PTP_ADJ_PHASE and =
FUNC_PTP_CFG_REQ_ENABLES_PTP_SET_TIME requests.
1.3. If one port of a four-port NIC is updated, the change is propagated =
to all other ports via the =
ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE event. As a =
result, all four instances of the bnxt_en driver receive the event with =
the high 48=E2=80=9363 bits of the counter in payload. They then =
asynchronously read the 0=E2=80=9347 bits and update the timecounter =
struct=E2=80=99s nsec field.
1.4. If we ignore the bug related to unsynchronized reading of the =
higher (48=E2=80=9363) and lower (0=E2=80=9347) bits of the PHC counter, =
the time across each timecounter instance should remain in sync.
1.5. When userspace calls adjfine, it triggers the =
PORT_MAC_CFG_REQ_ENABLES_PTP_FREQ_ADJ_PPB request, causing the PHC tick =
rate to change.

In non-RTC mode:
2.1. Only the lower 0=E2=80=9347 bits are stored on the NIC. The higher =
48=E2=80=9363 bits are stored only in the timecounter struct.
2.2. When userspace tries to change the PHC counter via adjtime or =
settime, the change is reflected only in the timecounter struct.
2.3. Each timecounter instance may have its own nsec field value, =
potentially leading to different timestamps read from /dev/ptp[0-3].
2.4. When userspace calls adjfine, it only modifies the mul field in the =
cyclecounter struct, which means no real changeoccurs to the PHC tick =
rate on the hardware.

And about issue in general:
3.1. Firmware versions 230+ operate in non-RTC mode in all environments.
3.2. Firmware version 224 uses RTC mode because older driver versions =
were not designed to track overflows (the higher 48=E2=80=9363 bits of =
the PHC counter) on the driver side.


>>> The latest driver handles the rollover on its own and we don't need =
the firmware to tell us.
>>> I checked with the firmware team and I gather that the version you =
are using is very old.
>>> Firmware version 230.x onwards, you should not receive this event =
for rollovers.
>>> Is it possible for you to update the firmware? Do you have access to =
a more recent (230+) firmware?
>> Yes, I can update firmware if you can tell where can I find the =
latest firmware and the update instructions?
>=20
> Broadcom's web site has pretty easy support portal with NIC firmware
> publicly available. Current version is 232 and it has all the
> improvements Pavan mentioned.

Yes, I have found the "Broadcom BCM57xx Fwupg Tools=E2=80=9D archive =
with some precompiled binaries for x86_64 platform. The problem is that =
our hosts are aarch64 and uses the Nix as a package manager, it will =
take some time to make it work in our setup. I just hoped that there is =
firmware binary itself that I can pass to ethtool =E2=80=94-flash.



> On 25 Mar 2025, at 14:24, Pavan Chebbi <pavan.chebbi@broadcom.com> =
wrote:
>=20
>>> Yes, I can update firmware if you can tell where can I find the =
latest firmware and the update instructions?
>>>=20
>>=20
>> Broadcom's web site has pretty easy support portal with NIC firmware
>> publicly available. Current version is 232 and it has all the
>> improvements Pavan mentioned.
>>=20
> Thanks Vadim for chiming in. I guess you answered all of Kamil's =
questions.

Yes, thank you for help. Without your explanation, I would have spent a =
lot more time understanding it on my own.

> I am curious about Kamil's use case of running PTP on 4 ports (in a
> single host?) which seem to be using RTC mode.
> Like Vadim pointed out earlier, this cannot be an accurate config
> given we run a shared PHC.
> Can Kamil give details of his configuration?

I have a system equipped with a BCM57502 NIC that functions as a PTP =
grandmaster in a small local network. Four PTP clients =E2=80=94 each =
connected to one of the NIC=E2=80=99s four ports =E2=80=94 synchronize =
their time with the grandmaster using the PTP L2P2P protocol. To support =
this configuration, I run four ptp4l instances (one for each port) and a =
single phc2sys daemon to synchronize system time and PHC time by =
adjusting the PHC. Because the bnxt_en driver reports different PHC =
device indexes for each NIC port, the phc2sys daemon treats each PHC =
device as independent and adjusts their times separately.

We also have a similar setup with a different network card, the Intel =
E810-C, which has four ports as well. However, its ice driver exposes =
only one PHC device and probably read PHC counter in a different way. I =
do not remember similar issues with this setup.


