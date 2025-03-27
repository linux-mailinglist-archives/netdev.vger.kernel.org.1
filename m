Return-Path: <netdev+bounces-177949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7CA7332C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A04516AB7E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6302628D;
	Thu, 27 Mar 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DZ4CPpjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08BA175BF
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081420; cv=none; b=gUYe69uTh8GtDp6aWRICJCHCWfIbTarxO24UhWZkMFMfC7pPb7rWucjgU3Iauz3wjpLN+/Z0bFX7WWDc03Ms9f3Q06AFLCarxojVW9YK9ZVSrqxdoOGwQV/n9hRcSZk7yKdWoFfXXPgwZkP/yWiFbuohF8NL0hxU3jJKzIr69Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081420; c=relaxed/simple;
	bh=jOOuJIAO0y9K81MUdRMjB3nQxaSRryMo/eHsxYqHysA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkxbG6KoXKKZKNB9cU7JOxOh787ryvdeaOKizKQnngGUPSR6ukJ3Dq/KR6Bml/1W7xQK/rMSDRV0xHVQBpWTq4BAV+CrEh99onz4FxlGsKvIiZSxw5mEEToDbf8ujn9ibSSBTrYMbcU+6Q9yI+bvY8OwBmKRDuvV1Fa1Bwa9JtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DZ4CPpjB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22423adf751so17523545ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743081418; x=1743686218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOOuJIAO0y9K81MUdRMjB3nQxaSRryMo/eHsxYqHysA=;
        b=DZ4CPpjBwj1lxfU9kmC9eMInwUvLxkvRc5mvyxlwhIOMLIW+ou4zvKkXFmf/zo/qun
         D5fiNiy5Tx+vJU14RlQimftD55wAuFwy3folcMjBQQi3Jc2TVqpDyGT5C1vr4/sGQ7YF
         NEwGdh3fGzZ4MFKW8RACaL2Bpzjmeyvso0cNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743081418; x=1743686218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOOuJIAO0y9K81MUdRMjB3nQxaSRryMo/eHsxYqHysA=;
        b=BleAu0Gu3v8OUdce41ZB8lr1NUlwccQ5JDq5SFDTCuFGYRvpYH3E2IRckU+ywgj37P
         lTMwlxJkGXs5gn/ythmEcU1NubyEYcD/M4+J2McTr3QAx/DwdZczH6rHDEKNMz85aeuu
         EG7xXvuhrNx3/q8hC5y246YEffvL1Sk6QglA+/ISxgCOheFj4hl8ykO8ixFabMAMYw0t
         JuI95OSnuj4Uva1HQBXETKqzqXwN9lvB6fq/2wruFD4xgM2fG+gMnvBtIiuCIOqJjN43
         6XvUseTwuwDdjp7Hp/v41SY+xkvSankir5yXLLc1mDZ7g5huNU9euTPWvsF9vMKmZtZz
         2dvA==
X-Forwarded-Encrypted: i=1; AJvYcCUoYq+nCwMgwj52QTQ91KoQYCqDWO/dcw5pWb/3j86nK6tGADPrax0G4rOHQdVQmWZR6Ziglx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzazSgL0Tg14kmvTAk0IHDJLD39/Qshw+tVFDGCdvGtvriPOx8F
	l05+alGMbhfCLdbeWtoz5+/UtUybWzi4h/919ck5jdebtWhlgdHIOIURv0EbkHp0AR7HOyd9Zfi
	XxD93R11YmeGXxHrMoV1CiYajXgBAD/7IkinY
X-Gm-Gg: ASbGncv49A9+Ju/78M1UASlruNMPe9uGqs1AH1XBoaGvofe+784Wj5wpGwmgWzklqjt
	iZXDJ7jCXkkUkC4RtJdjWE4C7Cy92VpkOXs9P28YENWUpZ5fUGb/izqBjvwZJ5hog36YcDN5iI5
	fgnVqFNyzvwzdbMYS3odFcvBCDW5tghynd85B+EA4=
X-Google-Smtp-Source: AGHT+IFR/fEG7uu7r+aubLZf7FFRW/HRSTEazujy8UNy8McAj8EPi5P+iIw5gEXXs0eOChMHDwQEo1NgTv+wLelyC3M=
X-Received: by 2002:aa7:8890:0:b0:736:5725:59b9 with SMTP id
 d2e1a72fcca58-73960e0e55dmr5219350b3a.2.1743081417909; Thu, 27 Mar 2025
 06:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com> <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
 <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
 <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai> <0316a190-6022-4656-bd5e-1a1f544efa2d@linux.dev>
 <CBBDA12F-05B4-4842-97BF-11B392AD21F1@avride.ai>
In-Reply-To: <CBBDA12F-05B4-4842-97BF-11B392AD21F1@avride.ai>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 27 Mar 2025 18:46:45 +0530
X-Gm-Features: AQ5f1JrtyS0UW1_uv92dzbS1wupG5tdWqZbmeZ5DFIC3L8-dyyY1U9Yg9yoSptI
Message-ID: <CALs4sv1KFsXLMJhsXTr2by1+UAXAiLTz90EQR5dJ4bqrs6xZCg@mail.gmail.com>
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Kamil Zaripov <zaripov-kamil@avride.ai>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan <michael.chan@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Linux Netdev List <netdev@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c3355a063152c481"

--000000000000c3355a063152c481
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:20=E2=80=AFPM Kamil Zaripov <zaripov-kamil@avride=
.ai> wrote:
>
>
>
> > On 25 Mar 2025, at 12:41, Vadim Fedorenko <vadim.fedorenko@linux.dev> w=
rote:
> >
> > On 25/03/2025 10:13, Kamil Zaripov wrote:
> >>
> >> I guess I don=E2=80=99t understand how does it work. Am I right that i=
f userspace program changes frequency of PHC devices 0,1,2,3 (one for each =
port present in NIC) driver will send PHC frequency change 4 times but firm=
ware will drop 3 of these frequency change commands and will pick up only o=
ne? How can I understand which PHC will actually represent adjustable clock=
 and which one is phony?
> >
> > It can be any of PHC devices, mostly the first to try to adjust will be=
 used.
>
> I believe that randomly selecting one of the PHC clock to control actual =
PHC in NIC and directing commands received on other clocks to the /dev/null=
 is quite unexpected behavior for the userspace applications.
>
> >> Another thing that I cannot understand is so-called RTC and non-RTC mo=
de. Is there any documentation that describes it? Or specific parts of the =
driver that change its behavior on for RTC and non-RTC mode?
> >
> > Generally, non-RTC means free-running HW PHC clock with timecounter
> > adjustment on top of it. With RTC mode every adjfine() call tries to
> > adjust HW configuration to change the slope of PHC.
>
> Just to clarify:
>
> Am I right that in RTC mode:
> 1.1. All 64 bits of the PHC counter are stored on the NIC (both the =E2=
=80=9Creadable=E2=80=9D 0=E2=80=9347 bits and the higher 48=E2=80=9363 bits=
).
In both RTC and non-RTC modes, the driver will use the lower 48b from
HW as cycles to feed to the timecounter that driver has mapped to the
PHC.

> 1.2. When userspace attempts to change the PHC counter value (using adjti=
me or settime), these changes are propagated to the NIC via the PORT_MAC_CF=
G_REQ_ENABLES_PTP_ADJ_PHASE and FUNC_PTP_CFG_REQ_ENABLES_PTP_SET_TIME reque=
sts.
True.

> 1.3. If one port of a four-port NIC is updated, the change is propagated =
to all other ports via the ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PH=
C_RTC_UPDATE event. As a result, all four instances of the bnxt_en driver r=
eceive the event with the high 48=E2=80=9363 bits of the counter in payload=
. They then asynchronously read the 0=E2=80=9347 bits and update the timeco=
unter struct=E2=80=99s nsec field.
Not true in the latest Firmware.

> 1.4. If we ignore the bug related to unsynchronized reading of the higher=
 (48=E2=80=9363) and lower (0=E2=80=9347) bits of the PHC counter, the time=
 across each timecounter instance should remain in sync.
Well, no. It won't be very accurate. We designed non-RTC mode for such
use cases. But yes, your use case is not exactly what non-RTC caters
for.

> 1.5. When userspace calls adjfine, it triggers the PORT_MAC_CFG_REQ_ENABL=
ES_PTP_FREQ_ADJ_PPB request, causing the PHC tick rate to change.
Correct. But only the first ever port that made the freq adj will
continue to make further freq adjustments. This was a policy decision,
not exactly random. There is an option in our tools to see which is
the interface that is currently making freq adjustments.

>
> In non-RTC mode:
> 2.1. Only the lower 0=E2=80=9347 bits are stored on the NIC. The higher 4=
8=E2=80=9363 bits are stored only in the timecounter struct.
> 2.2. When userspace tries to change the PHC counter via adjtime or settim=
e, the change is reflected only in the timecounter struct.
Correct.

> 2.3. Each timecounter instance may have its own nsec field value, potenti=
ally leading to different timestamps read from /dev/ptp[0-3].
Basically each of the timecounters is independent.

> 2.4. When userspace calls adjfine, it only modifies the mul field in the =
cyclecounter struct, which means no real changeoccurs to the PHC tick rate =
on the hardware.
Correct.

>
> And about issue in general:
> 3.1. Firmware versions 230+ operate in non-RTC mode in all environments.
No, the driver makes the choice of when to shift to non-RTC from RTC.
Currently this happens only in the multi-host environment, where each
port is used to synchronize a different Linux system clock.
But 230+ version has the change that will not track the rollover in
FW, and the ASYNC_EVENT_CMPL_PHC_UPDATE_EVENT_DATA1_FLAGS_PHC_RTC_UPDATE
deprecated.

> 3.2. Firmware version 224 uses RTC mode because older driver versions wer=
e not designed to track overflows (the higher 48=E2=80=9363 bits of the PHC=
 counter) on the driver side.
>
>
> >>> The latest driver handles the rollover on its own and we don't need t=
he firmware to tell us.
> >>> I checked with the firmware team and I gather that the version you ar=
e using is very old.
> >>> Firmware version 230.x onwards, you should not receive this event for=
 rollovers.
> >>> Is it possible for you to update the firmware? Do you have access to =
a more recent (230+) firmware?
> >> Yes, I can update firmware if you can tell where can I find the latest=
 firmware and the update instructions?
> >
> > Broadcom's web site has pretty easy support portal with NIC firmware
> > publicly available. Current version is 232 and it has all the
> > improvements Pavan mentioned.
>
> Yes, I have found the "Broadcom BCM57xx Fwupg Tools=E2=80=9D archive with=
 some precompiled binaries for x86_64 platform. The problem is that our hos=
ts are aarch64 and uses the Nix as a package manager, it will take some tim=
e to make it work in our setup. I just hoped that there is firmware binary =
itself that I can pass to ethtool =E2=80=94-flash.
>
>
>
> > On 25 Mar 2025, at 14:24, Pavan Chebbi <pavan.chebbi@broadcom.com> wrot=
e:
> >
> >>> Yes, I can update firmware if you can tell where can I find the lates=
t firmware and the update instructions?
> >>>
> >>
> >> Broadcom's web site has pretty easy support portal with NIC firmware
> >> publicly available. Current version is 232 and it has all the
> >> improvements Pavan mentioned.
> >>
> > Thanks Vadim for chiming in. I guess you answered all of Kamil's questi=
ons.
>
> Yes, thank you for help. Without your explanation, I would have spent a l=
ot more time understanding it on my own.
>
> > I am curious about Kamil's use case of running PTP on 4 ports (in a
> > single host?) which seem to be using RTC mode.
> > Like Vadim pointed out earlier, this cannot be an accurate config
> > given we run a shared PHC.
> > Can Kamil give details of his configuration?
>
> I have a system equipped with a BCM57502 NIC that functions as a PTP gran=
dmaster in a small local network. Four PTP clients =E2=80=94 each connected=
 to one of the NIC=E2=80=99s four ports =E2=80=94 synchronize their time wi=
th the grandmaster using the PTP L2P2P protocol. To support this configurat=
ion, I run four ptp4l instances (one for each port) and a single phc2sys da=
emon to synchronize system time and PHC time by adjusting the PHC. Because =
the bnxt_en driver reports different PHC device indexes for each NIC port, =
the phc2sys daemon treats each PHC device as independent and adjusts their =
times separately.
>
If you are using Broadcom NIC, and have only one system time to
update, I don't see why we should have 4 PTP clients. Just one
instance of ptp4l running on one of the ports and one phc2sys is going
to be valid (and is sufficient?)
I am thinking out loud, the phc2sys daemon could be picking up all the
available clocks, but I think that needs to be modified, unless we
decide to stop exposing multiple clocks for the same PHC in our
design.
Of course, I am not sure if you have a requirement of 4 GMs to sync with.

> We also have a similar setup with a different network card, the Intel E81=
0-C, which has four ports as well. However, its ice driver exposes only one=
 PHC device and probably read PHC counter in a different way. I do not reme=
mber similar issues with this setup.
>
 I think on the Intel NIC, this problem itself would not arise,
because you will run only 1 client each of ptp4l and phc2sys, right?
But I am not sure how you can run 4 GMs on Intel NIC if you are
running that.

--000000000000c3355a063152c481
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHis4hMMmcT5CpLQVwEzZToetVWPMI7M
jVsp48kupRKeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMy
NzEzMTY1OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAF2EKN+F41UsaY2bCkJ9xTnSqu/gyY8dwxJR8lkTXz5d4N3YCU3ph+GdahhEJVz2IwiT
8xnRpjCaav9Qp9fM1yJiEuRkeODldIiz6KMKbXlO9v0h7SZ3sZUifXywsb504uQ4wblzYXra1Hih
z4AKHuyewswyQGCdeevAVg0F0k9CXbqheVOKXkpKs6m80vMgcZZFVWrlezEf4YK8a/cgVD10KIzG
jA4fxuBosYT76GjnQ9Hq3Djqyh6J4VMMq+kVJQMP6eigNt+O7EE6lALI2b68ipPyUQYOlVW2XK11
uAUtfmSuzA0FeB5Rq+nl1OSQhTVCa0gMdJZ7VdgSnxFmcEA=
--000000000000c3355a063152c481--

