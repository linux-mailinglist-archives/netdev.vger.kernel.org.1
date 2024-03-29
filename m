Return-Path: <netdev+bounces-83197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6B891537
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06085B22265
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D04A936;
	Fri, 29 Mar 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZIdOSdtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815C3D69
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711701336; cv=none; b=OQwT+bG+d65lacPNdhUcQY7bb8FW1LL3pL+FpKTSu0wpJkEahKfTgmIhD0D75kR6wLc0/stcZBUGOjA5/adkJQwhF/f1jhttfsCIR586XASoQ4qTUgp4dBvPlcSnl01cNCNI+94qYUAfMdTR9zIbvpTJx0iS/wN7ZSzbdXNgTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711701336; c=relaxed/simple;
	bh=7cf+gMEMkLBQR7jffrU11STSely+c3oQX0mCeLJvuLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShZ1RDg1TavYXdE0oXZBHOBQB3mTUaOU133pIqFNGvy25pnE732Y4cp4lY0EqLLxiPmBbf54Yu9SeF3J59x79og/MaH2fYJq8gPMWli8p48L7duMNjXk0zfMoDPJav9cEioMPylS3Q1jaq+FQ/NqXKLku0FstcJPsL3GvdU0dDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZIdOSdtV; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d68651e253so25765261fa.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711701333; x=1712306133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VBGFAJMKrUPN9WpPTKtCaVkyR95ZsD1RZlAUVargiI=;
        b=ZIdOSdtVd1RfNLIW80mx2et/Koex+B/ALvCAdv6Uiu+q/4+JkU/+kcdKY5uCEvwOR1
         +ZNHTdrW0mDZSVEgL/8TgSkvzUn01Z0gBor1BtdBz9nTYK9VrO44gT68NrrF8HOMPMBX
         4r3R2zlRaBL1/fi920g0ju2qd94BhyTyYBkb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711701333; x=1712306133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VBGFAJMKrUPN9WpPTKtCaVkyR95ZsD1RZlAUVargiI=;
        b=njNUm8IS+f35eDL+LUXnq20tG95pcH3/G5S5Bi08jgTZDv9nfgPxUfkrhmOsCEbuY7
         OApQiGiP1e12gWoQg1rAe+QGb93U3wSzukM67EeC9Ho7CV9JUnw1F7mDYW3XLe2MwN8S
         ExT0pQ1uziG+Ty5RUr4xTVLu4mWmShCBeuZ3HNqpqnMgpxpEQ5jNWRmtq1iamKnGdrhL
         xvn4ADGVMijqC8f6evvdqniCc3jkCoODH9CUhFjjkfaoQTYjBlYis0ez2Jr9HF01XmMt
         /wSoFQEx0g4WN6zuXGuuRUawYGBIHPvvwQ/ZZoiW96VZsaHVCv+N1hRdF/VZTrFpZTPw
         NP6w==
X-Forwarded-Encrypted: i=1; AJvYcCUGRcRCLqP6X/AdpBuLwCPlLGPziobio3vVqoIElqVsR6c2dBLYoxldIHXCPTborqH2AxfVLI9QUhjx2ObrfUET4XPZSRkC
X-Gm-Message-State: AOJu0YyVBFwMXgWl0kuqU1A3fpsBa/MQlw0UxLeqPqxws2/ru2n6geOW
	bns8svWtSITyujtLCnulXQ/QKBBvAYm2QVFtbu3R5QlGxOnpYnJ+KxxoDfV7R+j/5gGrqZI53mK
	QhmUqZC6OSB4DZYdMD7AUDFgFkfLuwph8zfnf
X-Google-Smtp-Source: AGHT+IGwbqmDDuhlaHheh6cXhZbZKQ4vWcSeVWBlKEoAoV73mLTKSYpOfG1R4pZV+Td3Tfo8kucB3KHbkQk5gAIBnq4=
X-Received: by 2002:a05:651c:49a:b0:2d2:d0ba:2586 with SMTP id
 s26-20020a05651c049a00b002d2d0ba2586mr763979ljc.24.1711701332834; Fri, 29 Mar
 2024 01:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325232039.76836-1-mschmidt@redhat.com> <20240325232039.76836-4-mschmidt@redhat.com>
In-Reply-To: <20240325232039.76836-4-mschmidt@redhat.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 29 Mar 2024 14:05:20 +0530
Message-ID: <CAH-L+nPBf2RNM2=ec1H1WN4DOwfvp5nQAwcfLW4NiTNU_Kk4rQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] ice: fold ice_ptp_read_time into ice_ptp_gettimex64
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000edbe440614c88542"

--000000000000edbe440614c88542
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:07=E2=80=AFAM Michal Schmidt <mschmidt@redhat.com=
> wrote:
>
> This is a cleanup. It is unnecessary to have this function just to call
> another function.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 25 +++---------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index 0875f37add78..0f17fc1181d2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1166,26 +1166,6 @@ static void ice_ptp_reset_cached_phctime(struct ic=
e_pf *pf)
>         ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
>  }
>
> -/**
> - * ice_ptp_read_time - Read the time from the device
> - * @pf: Board private structure
> - * @ts: timespec structure to hold the current time value
> - * @sts: Optional parameter for holding a pair of system timestamps from
> - *       the system clock. Will be ignored if NULL is given.
> - *
> - * This function reads the source clock registers and stores them in a t=
imespec.
> - * However, since the registers are 64 bits of nanoseconds, we must conv=
ert the
> - * result to a timespec before we can return.
> - */
> -static void
> -ice_ptp_read_time(struct ice_pf *pf, struct timespec64 *ts,
> -                 struct ptp_system_timestamp *sts)
> -{
> -       u64 time_ns =3D ice_ptp_read_src_clk_reg(pf, sts);
> -
> -       *ts =3D ns_to_timespec64(time_ns);
> -}
> -
>  /**
>   * ice_ptp_write_init - Set PHC time to provided value
>   * @pf: Board private structure
> @@ -1926,9 +1906,10 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, st=
ruct timespec64 *ts,
>                    struct ptp_system_timestamp *sts)
>  {
>         struct ice_pf *pf =3D ptp_info_to_pf(info);
> +       u64 time_ns;
>
> -       ice_ptp_read_time(pf, ts, sts);
> -
> +       time_ns =3D ice_ptp_read_src_clk_reg(pf, sts);
> +       *ts =3D ns_to_timespec64(time_ns);
>         return 0;
>  }
>
> --
> 2.43.2
>
>


--=20
Regards,
Kalesh A P

--000000000000edbe440614c88542
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
AQkEMSIEIHadM6lrftzNlzizcFBmR1LkjCV5IduCBoeY0BdS5j7dMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyOTA4MzUzM1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDABKsMZVKZ
QC8zF0KT9HC8WtPPMM0h81kNeJ+Yg2nPLH8EsmkHQZxVlYVYlpjmsyZf7BhoufFSG53riX3r0gME
ouyYcxbPBO3VHNfV5aJ6uy2s7pGsQOArCVq4t6AlL8A2xaTKKrirVbytiT8I0YKknMNtGBelKk7f
6u8SN0UOrlBuk1+/yO7cmScNu3Qj45wEImRluJ8BYsylYYDXOIFJdKE8AVSMbvW7rhr/29Um0PLi
dPaWQ2HzW6vk/L8BR/Ro1mDcB3WFpQXHdkX+id4QLKH2kMGKPKbO41jltG7ftPL257S0GJik3Q8H
dU8Qr8I9D/yLK5pmX/HoGLEVbWr/
--000000000000edbe440614c88542--

