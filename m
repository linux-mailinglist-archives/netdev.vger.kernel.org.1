Return-Path: <netdev+bounces-151162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA79ED31D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB091883B54
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440D1DE2BA;
	Wed, 11 Dec 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bhHnvpLG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250E24634B
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937129; cv=none; b=a/+eXK8GtoGmcjrkX2P1br5nrDyRAzqLCFFmMWD/tRrv/qyh6kuMhMtkIybPMdPl27/TBu8T6YBalA6rBZxli9wylysKgBTfuf0br9vcrXn5RSQCk8lSId0JKFkqO4HyioR5HNlVRdg3LuaA+igOA2KnaTULBCLUc/TaMTELlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937129; c=relaxed/simple;
	bh=QQ7K3Lu4arkKLX7kiMA+zkg6y4XKHaj8RlL9VOwFDyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxx7MSI4IyzysjEIDzLqp+UHTqQ0jopktIQGtmIWqrdg5dVh4uq2Gug+Uns1M2+2Z/dyVnk237U3oJTDfUA1YvmWOwhOljQZbclD5MP3KjdBUjeN+c7wW04lKDcNvH4pSasoP2iZKk2qMR/rAszV4F+pTPScQDkeXJPW4GlMz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bhHnvpLG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so8490200a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733937126; x=1734541926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92AZoo/MjdD1qKdUfB1HBigrZ4ENtCv+bJ1Jat9cQtA=;
        b=bhHnvpLGrQVmf1qTS1KuLmfqNjJgwD6uTrjbn7LqZxDKJJXRGFt1H2u+Ykb40Uup0E
         i+YP0mFgvhTcAYLDtfgl/wvlOWKlMvoJU5z57SD7PJxQ8QBBo/rtsZCCQJ2serqSDvpD
         MvEEGa/PWCzbUreRaKr/+bzk54pHAdpuo7ayo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733937126; x=1734541926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92AZoo/MjdD1qKdUfB1HBigrZ4ENtCv+bJ1Jat9cQtA=;
        b=B1MD731aqHGozGfnN4wIah+0wJzD6VVdX1sHZMWU0XpqrFmEbunPL9Sd/2vbwf6dOv
         m5zOL/nBpOXTNMBdAR1l6jZ4J7X/se96pFdz6KoDY5at66IkWzqELsQdD4zYv907hqlE
         Sw0G9vlldbyzVniMXqwvxYiYRxUwPVTBlMZU9145lUqPgwfH7FPZ4Xm6XNNYULYlF/4O
         JhCq1Qd15U+OVl+sbSvIsH4iWO367fCvRnwnb5LBJeQWZ+NaEMZaSGeXlS0oaheol1W2
         E5aqFKAEXYJa9fMYce8+RtQgkZxSgHbYAyLStTrHl+vEQHOrQXNBGFYNR4DahNtMkaZv
         g9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCakPhWd5aeT9VzkPxFSveSRWy19CiuLw0NjkhpR0WvGRiPmls2CllGphYWd8gsj+oUPJ9sZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGoEkdbGHCVE5JFr0w0ztk9eABhOa0JgeAcGGIFWE1GqL5C2O
	nFpUzG1UBKO7bEpqr1X1XVOOuTz1NlEsClXFsddDujJPPdI1OXj42Cw15taje0ZEdmb+3Zgy0d7
	LJwcPUgxG1Q8Y6kysEkFg+hRUCtkNfRhi8f/k
X-Gm-Gg: ASbGnctqIIaJVu+7PnQ3u+LJYRaaKvealXZm5trxmWEiZNozTa41fYi+A16zFddnfFB
	nzlk+yy4IMhy+H4LhnQp8VCnbXrk8U0J52Is=
X-Google-Smtp-Source: AGHT+IF/XDl//2JKWG2bcTCrd2pboWGC0UKEczogFxkv8woPEDw61cM/4rk4B/19QeWjCX8gZN0Ib/nqP6tlgyOm9e8=
X-Received: by 2002:a05:6402:358c:b0:5d2:729f:995f with SMTP id
 4fb4d7f45d1cf-5d445c0b878mr309435a12.29.1733937125911; Wed, 11 Dec 2024
 09:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204041022.56512-1-dw@davidwei.uk> <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com> <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com> <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
In-Reply-To: <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 11 Dec 2024 09:11:55 -0800
Message-ID: <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API implementation
To: David Wei <dw@davidwei.uk>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000079f5f3062901b298"

--00000000000079f5f3062901b298
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:10=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-12-11 04:32, Yunsheng Lin wrote:
> > On 2024/12/11 2:14, David Wei wrote:
> >> On 2024-12-10 04:25, Yunsheng Lin wrote:
> >>> On 2024/12/4 12:10, David Wei wrote:
> >>>
> >>>>    bnxt_copy_rx_ring(bp, rxr, clone);
> >>>> @@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device=
 *dev, void *qmem, int idx)
> >>>>    bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> >>>>    rxr->rx_next_cons =3D 0;
> >>>>    page_pool_disable_direct_recycling(rxr->page_pool);
> >>>> +  if (bnxt_separate_head_pool())
> >>>> +          page_pool_disable_direct_recycling(rxr->head_pool);
> >>>
> >>> Hi, David
> >>> As mentioned in [1], is the above page_pool_disable_direct_recycling(=
)
> >>> really needed?
> >>>
> >>> Is there any NAPI API called in the implementation of netdev_queue_mg=
mt_ops?
> >>> It doesn't seem obvious there is any NAPI API like napi_enable() &
> >>> ____napi_schedule() that is called in bnxt_queue_start()/bnxt_queue_s=
top()/
> >>> bnxt_queue_mem_alloc()/bnxt_queue_mem_free() through code reading.
> >>>
> >>> 1. https://lore.kernel.org/all/c2b306af-4817-4169-814b-adbf25803919@h=
uawei.com/
> >>
> >> Hi Yunsheng, there are explicitly no napi_enable/disable() calls in th=
e
> >> bnxt implementation of netdev_queue_mgmt_ops due to ... let's say HW/F=
W
> >> quirks. I looked back at my discussions w/ Broadcom, and IIU/RC
> >> bnxt_hwrm_vnic_update() will prevent any work from coming into the rxq
> >> that I'm trying to stop. Calling napi_disable() has unintended side
> >> effects on the Tx side.
> >
> > It seems that bnxt_hwrm_vnic_update() sends a VNIC_UPDATE cmd to disabl=
e
> > a VNIC? and a napi_disable() is not needed?
>
> Correct.
>
> > Is it possible that there may
> > be some pending NAPI work is still being processed after bnxt_hwrm_vnic=
_update()
> > is called?
>
> Possibly, I don't know the details of how the HW works.
>

bnxt_hwrm_vnic_update() only stops the HW from receiving more packets.
The completion may already have lots of RX entries and TPA entries.
NAPI may be behind and it can take a while to process a batch of 64
entries at a time to go through all the remaining entries.

> At the time I just wanted something to work, and not having
> napi_enable/disable() made it work. :) Looking back though it does seem
> odd, so I'll try putting it back.

Yeah, I think it makes sense to add napi_disable().  Thanks.

--00000000000079f5f3062901b298
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEjScIolNVf4lPG1ZSBU1/gD9ilIsDvK
x7K9OU9dSYehMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIx
MTE3MTIwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAJO5ZeLCu/IVMclTTBpoBzBiA20wfr+oGgtkXgRGhcq+WUhj4W
wKgYUPRnxUiLiLTnTZc2tHl74nJXgZY19hE4vvImOZ/adahnohrJSyuFqyo68UraLYm94nmcUnxj
a2msdBCHTRdvCEIlPO0kw1m/maFg8A1+0JBAUDY+Re0ITkJaPYjK3gcazU0+ze9m34dHTXxjXYxG
ztlSj+zrpa/fu1qIIAVHiEXiMt5TIiPrgRg/SmL8VSMLbUfWYmUpViXuzT4JyRtG0ZhP1/7uJ09v
xBPEQpIUJDRvnvnTaCbrazacuRl5eNTECGhHEl2/MOdLhXTPtHwVxjGu/udYhIwg
--00000000000079f5f3062901b298--

