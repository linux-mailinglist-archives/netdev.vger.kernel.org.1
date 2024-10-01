Return-Path: <netdev+bounces-130768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0498B773
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926E81C22292
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7C19CC01;
	Tue,  1 Oct 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DGrWl9Mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D2199FD7
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772213; cv=none; b=Wn5+pO1uPOmYSkdA5rRyNXKpxP8W+HOZQolndOYv22OD+2D4By4qp/5njdNBr/b0O2cxASFeaxuB8MPBoKGQqpHj0mOiPCN6itMFSn2vII96magYRKLkEzaWHjwVJWz0JWbRmeagcJmYDqO/cqrWa7luVQeyba64WqOcnBtPPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772213; c=relaxed/simple;
	bh=0FSIr9DSnb1DIkeZhrs8Ky7Xa0UC1XqAQ9zfuivt1/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDDn+d21v84+6MYwHvfA9Ap0+judrTxCnH8k+yr3ZcgJYjmSm67sHqjWbSsaPWGeLtk7unZOe87x6e4Tr+N1EXNS/5SlHyjIIN0WDprB5bSMr4DiAUw+leQ42PANqJhfgTUOzucxE36Ld0HGRxe5PPTYh9gB2I+l3MS74uo+6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DGrWl9Mp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398e33155fso3122666e87.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727772208; x=1728377008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DzctcYCPZf9QzyHka85drJw5FTPEUG48vTNepSzo8ho=;
        b=DGrWl9MpwEnflPTQdMcjfiCdEocFcGF4ys9axYFUrtjByu7GfRognO4EoORz6oxLNJ
         tG5ADBL2dVCn1SD/CWwUKJI0MfapDFKViXL05Qr2Ow94T/vGT9HrHPWpvR+BQJ1bVfUC
         SXMRKTzJHZeLccRcyfTtpBmhtz5yScgO3Qxu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772208; x=1728377008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzctcYCPZf9QzyHka85drJw5FTPEUG48vTNepSzo8ho=;
        b=m6kMmum/2M0nyQWayTeJbfoi25nX/zc3Ge3kCtlyQYc9fHLvhljrc1C2FjSYFN8plz
         xXr5qN9SIt8oqEjX9LjjWPBxfcSCdM6nuqRASJTRtTPpshWfMEStRDOTpnhvG5Uzq6oe
         ojJJhuOEajZwPi0j1lcz3eVOJrqhCGWGHw3AREsF48M577sNWGuQXp4B8slNB7SjRgDy
         C74wzIF1EkbxvmY45FUsZF1I5jrythv/a/rLdlBuoh6KxhinqoLzsfRajpe17xCeCQZO
         QeMG0HpP8zvED0F/MpzwCrNnUb6tutRxcaCvJaaKTeX0VXwXO09bA8MS/EFAkKsPL7Cy
         VEwA==
X-Forwarded-Encrypted: i=1; AJvYcCWnaiTWF1k2PmxoRewuylB5OFHPSUQ9712zIF0hJWAFmvgllhLxkrwOsD4Vlm1uvcaUwM867B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL126q7Oc2BSVPFLOL/o5LTsoyURow5uVEOftJJGdO7B+VbbkG
	u9klz8ictqNFLJbF34Vec6JSjUgFXX34tCuj4ZMugWEEIxiWq1O+NQDeAPwP/8hSBQ5bimGCxHv
	7AYnXv3qm/dWvvP3jGRqOKcZlAV/79qsl7jNS
X-Google-Smtp-Source: AGHT+IEIcC1MlJRzbbus8V/vcR5x0AHKvP0lrijYeVZjVTEXgzKiMEliuH8/cdJl6DkBpNKlMy3+Wno8JonnUYMH+8Q=
X-Received: by 2002:ac2:4c41:0:b0:539:91b8:edb7 with SMTP id
 2adb3069b0e04-53991b8f858mr4040011e87.42.1727772208061; Tue, 01 Oct 2024
 01:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com> <20240930223601.3137464-9-anthony.l.nguyen@intel.com>
In-Reply-To: <20240930223601.3137464-9-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 1 Oct 2024 14:13:15 +0530
Message-ID: <CAH-L+nNfQGoTrq1dX1Le525S1HgCVRtmZTz+m6a02Ke3=RiA_A@mail.gmail.com>
Subject: Re: [PATCH net 08/10] idpf: fix VF dynamic interrupt ctl register initialization
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, 
	Ahmed Zaki <ahmed.zaki@intel.com>, willemb@google.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>, 
	Krishneil Singh <krishneil.k.singh@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000be8212062366506e"

--000000000000be8212062366506e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:07=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel.=
com> wrote:
>
> From: Ahmed Zaki <ahmed.zaki@intel.com>
>
> The VF's dynamic interrupt ctl "dyn_ctl_intrvl_s" is not initialized
> in idpf_vf_intr_reg_init(). This resulted in the following UBSAN error
> whenever a VF is created:
>
> [  564.345655] UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/i=
dpf/idpf_txrx.c:3654:10
> [  564.345663] shift exponent 4294967295 is too large for 32-bit type 'in=
t'
> [  564.345671] CPU: 33 UID: 0 PID: 2458 Comm: NetworkManager Not tainted =
6.11.0-rc4+ #1
> [  564.345678] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD=
, BIOS SE5C6200.86B.0027.P10.2201070222 01/07/2022
> [  564.345683] Call Trace:
> [  564.345688]  <TASK>
> [  564.345693]  dump_stack_lvl+0x91/0xb0
> [  564.345708]  __ubsan_handle_shift_out_of_bounds+0x16b/0x320
> [  564.345730]  idpf_vport_intr_update_itr_ena_irq.cold+0x13/0x39 [idpf]
> [  564.345755]  ? __pfx_idpf_vport_intr_update_itr_ena_irq+0x10/0x10 [idp=
f]
> [  564.345771]  ? static_obj+0x95/0xd0
> [  564.345782]  ? lockdep_init_map_type+0x1a5/0x800
> [  564.345794]  idpf_vport_intr_ena+0x5ef/0x9f0 [idpf]
> [  564.345814]  idpf_vport_open+0x2cc/0x1240 [idpf]
> [  564.345837]  idpf_open+0x6d/0xc0 [idpf]
> [  564.345850]  __dev_open+0x241/0x420
>
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
LGTM,
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

--=20
Regards,
Kalesh A P

--000000000000be8212062366506e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEINcDW0znTYIgiK7qJNA/ZBQt0oIeNEw8JLAgGiguvJk9MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAwMTA4NDMyOFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDBR5bX5oGL
fmUMk6SguIU5rG+ZvB/F0xfpOCYhJGU6SGRuPMqW8k9dPL8qWbBbKpCUy5gXfu0e35GYari70Zwo
ETHsWkWpyi8FKeJu27qPKu4mS9dR6fPqoo7VBNhe53XxBwgxluk9jjZ3ZaMRnnMyDFMnC5mIdNXd
u0BtNmvC1XnXrBp81u1ISX9FfDAHuRfbb90Qp7mAiVlIlf+apQhXTUoqn9YIBBhSmd83RcSjq1gH
uil2u8yx5X9D5gQgpxt7UKYxSdtMOADgWzn/jjtKfmFQu+IBVG+rcYGCenz85W6BZ48hdD0G4wZU
+yVIEjqyBh4AK3R8lieAzDcIqo14
--000000000000be8212062366506e--

