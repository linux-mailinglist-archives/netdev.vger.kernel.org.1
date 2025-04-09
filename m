Return-Path: <netdev+bounces-180902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9DDA82E27
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478EA3BF057
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B31D5CFB;
	Wed,  9 Apr 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="adDmVeRG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7D1D6188
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221784; cv=none; b=U7JQQutNvxwv8txqCXZSD4mpgFJ/xY12cMk3joc95n81fXPAKHs/krzggZ02uZ9BgiIHDUD8f/3hJ8OlQa2vUJyVjhRwjM9aze3eO+h9rxOkNzr8Jh9mtEpASr0t60p0J//qulh54kosTH2uHsDB8ywHz8+haFEB2Fom6n43G6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221784; c=relaxed/simple;
	bh=I4DWbodnPHm9Ra6l3dLKMs6Ugpg2RDIaJg6L0ZLYqT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llaMgxHgayXpcENQhxFeQgIHrq85zCyl1ILUaZUBHaBF1OY9fW7R4RnA/GdcJ2vFT88Mn3RlAM5FhkFbP2oD6PGiL3kP0Xdc9fXWE5mYHyI1t5lTGYS/f65EpUigOQGaX4vJdFCuoRR4wlDB1mCClkffqgQSbJsNH1cvim5Uv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=adDmVeRG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b1095625dso8295673e87.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744221780; x=1744826580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rGgX4FZaymbn85hsrTOcQQFq/pt96mxBUuOokpizosw=;
        b=adDmVeRGM/BS5H2ZeCqg0nSHHrc3QN88vY09uPcJMgOjIRGhoGPcejIx43+sqhGIM/
         4vquNNrb3npscPw0/hLXFXpgFP5c1dZ1mH0kh5p14Vbd5HmX08NVPmn0M/skTJjsbSVB
         sCUUZDdqhztkpnYRsEVj5gvYthPsddGPk1YOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744221780; x=1744826580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGgX4FZaymbn85hsrTOcQQFq/pt96mxBUuOokpizosw=;
        b=Me6iB485kU7V0jtljZAUVNVb/r0clDZzDlmHsM/4WID/e9lJ8+w4iI/62rhOx5BBYx
         BhpHhFbQ/BlFuAgvyfvDdCV7sJgA+VRzN8dJOoYPy8V3bMUSHaQIVvJ5D/b/auNlUmz1
         UaPAoAE4mviZJFA3ljz0h3LonI7AJsvvTsIfl5hteelCWEUZUVUrWJlYdjlc0eaw4DPh
         40rAX/01rHd37SgIHfwrpdbd9a6ZyWWl4y5hdRcY9XHO7HVXuYmVRX/3R81f5HAaG1jE
         xYicldZz2m6Zzy7AWvsfIUwIsO8bEN5eqwkgk+lNKdrOcyQ2DW/WIGk8XVvo5aRgcvVU
         1GZA==
X-Gm-Message-State: AOJu0YxOQY/Za5xGqCvMG+sWSw3+/Wy1JaFE1AGIK9TGo3awYfNQguJ/
	XP/RIeavCa6GbmlNZ5QK+zTWhIx1tYyDG6x67te7gxryIFMtFVJwxiYpENlbGF9QWTY4y8TjlEs
	xPcElViUBSMLPIagM4YUKKhwwBAHSe/yfpCRoMAiXdYGblY8+0XpjCG2WfxdaRz0G8QaTZ5DueT
	FkwyP8NnZVxxWxbkXf5ywr2aI04OWy/6I=
X-Gm-Gg: ASbGncvmKHTQ+yZlrz61xS21HYgBSIG+hHiOsT76bhk9TLehGkZKqw18srWRIyE53cP
	Bz/we0BZ1I2MwZKWj5dngFGmolx/9IBPS+YQl24J/p4mrTxO8syat0nuULMLu9I7ORrT5rUA4zQ
	zLYhmZIpmvPKntxgt6MrNp53Ko7WmfnzBRW4N8Yqw9fl8uVGHKP2kekQeL/huEPG4I
X-Google-Smtp-Source: AGHT+IGAKsvsZpyJzo5SfuSbUf45FexhioZJWEXj1v8jgOjV8SWnUrfhPsRkj+oceq3wfqJ5TfqmuqTVZBMvcn+wyeU=
X-Received: by 2002:a05:6512:4010:b0:549:7d6e:fe84 with SMTP id
 2adb3069b0e04-54c437c02fcmr1349448e87.53.1744221780315; Wed, 09 Apr 2025
 11:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409112440.365672-1-idosch@nvidia.com>
In-Reply-To: <20250409112440.365672-1-idosch@nvidia.com>
From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Date: Wed, 9 Apr 2025 11:02:47 -0700
X-Gm-Features: ATxdqUEKJE000Nw8bDk-GTLDtR5zutwn1ljPOwa0dzJr0BeJ_jRJe2TTuKIGjfo
Message-ID: <CAKSYD4y5cTMdRmo97naYX=xE4k3jLBOBzptmyXi-YEimK4VmPw@mail.gmail.com>
Subject: Re: [PATCH net] ethtool: cmis_cdb: Fix incorrect read / write length extension
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, 
	danieller@nvidia.com, petrm@nvidia.com, andrew@lunn.ch, 
	michael.chan@broadcom.com, andrew.gospodarek@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a6e7d106325c4758"

--000000000000a6e7d106325c4758
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:25=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> The 'read_write_len_ext' field in 'struct ethtool_cmis_cdb_cmd_args'
> stores the maximum number of bytes that can be read from or written to
> the Local Payload (LPL) page in a single multi-byte access.
>
> Cited commit started overwriting this field with the maximum number of
> bytes that can be read from or written to the Extended Payload (LPL)
> pages in a single multi-byte access. Transceiver modules that support
> auto paging can advertise a number larger than 255 which is problematic
> as 'read_write_len_ext' is a 'u8', resulting in the number getting
> truncated and firmware flashing failing [1].
>
> Fix by ignoring the maximum EPL access size as the kernel does not
> currently support auto paging (even if the transceiver module does) and
> will not try to read / write more than 128 bytes at once.
>
> [1]
> Transceiver module firmware flashing started for device enp177s0np0
> Transceiver module firmware flashing in progress for device enp177s0np0
> Progress: 0%
> Transceiver module firmware flashing encountered an error for device enp1=
77s0np0
> Status message: Write FW block EPL command failed, LPL length is longer
>         than CDB read write length extension allows.
>
> Fixes: 9a3b0d078bd8 ("net: ethtool: Add support for writing firmware bloc=
ks using EPL payload")
> Reported-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Closes: https://lore.kernel.org/netdev/20250402183123.321036-3-michael.ch=
an@broadcom.com/
> Tested-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> ---
>  net/ethtool/cmis.h     |  1 -
>  net/ethtool/cmis_cdb.c | 18 +++---------------
>  2 files changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
> index 1e790413db0e..4a9a946cabf0 100644
> --- a/net/ethtool/cmis.h
> +++ b/net/ethtool/cmis.h
> @@ -101,7 +101,6 @@ struct ethtool_cmis_cdb_rpl {
>  };
>
>  u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs);
> -u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs);
>
>  void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *arg=
s,
>                                    enum ethtool_cmis_cdb_cmd_id cmd, u8 *=
lpl,
> diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
> index d159dc121bde..0e2691ccb0df 100644
> --- a/net/ethtool/cmis_cdb.c
> +++ b/net/ethtool/cmis_cdb.c
> @@ -16,15 +16,6 @@ u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs)
>         return 8 * (1 + min_t(u8, num_of_byte_octs, 15));
>  }
>
> -/* For accessing the EPL field on page 9Fh, the allowable length extensi=
on is
> - * min(i, 255) byte octets where i specifies the allowable additional nu=
mber of
> - * byte octets in a READ or a WRITE.
> - */
> -u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
> -{
> -       return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
> -}
> -
>  void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *arg=
s,
>                                    enum ethtool_cmis_cdb_cmd_id cmd, u8 *=
lpl,
>                                    u8 lpl_len, u8 *epl, u16 epl_len,
> @@ -33,19 +24,16 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmi=
s_cdb_cmd_args *args,
>  {
>         args->req.id =3D cpu_to_be16(cmd);
>         args->req.lpl_len =3D lpl_len;
> -       if (lpl) {
> +       if (lpl)
>                 memcpy(args->req.payload, lpl, args->req.lpl_len);
> -               args->read_write_len_ext =3D
> -                       ethtool_cmis_get_max_lpl_size(read_write_len_ext)=
;
> -       }
>         if (epl) {
>                 args->req.epl_len =3D cpu_to_be16(epl_len);
>                 args->req.epl =3D epl;
> -               args->read_write_len_ext =3D
> -                       ethtool_cmis_get_max_epl_size(read_write_len_ext)=
;
>         }
>
>         args->max_duration =3D max_duration;
> +       args->read_write_len_ext =3D
> +               ethtool_cmis_get_max_lpl_size(read_write_len_ext);
>         args->msleep_pre_rpl =3D msleep_pre_rpl;
>         args->rpl_exp_len =3D rpl_exp_len;
>         args->flags =3D flags;
> --
> 2.49.0
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000a6e7d106325c4758
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVQAYJKoZIhvcNAQcCoIIVMTCCFS0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKtMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGdjCCBF6g
AwIBAgIMLn8lLzdNn3iuIRSnMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDgxNTEwMzAxMVoXDTI2MDgxNjEwMzAxMVowgbkxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEdMBsGA1UEAxMURGFtb2RoYXJhbSBBbW1lcGFs
bGkxMDAuBgkqhkiG9w0BCQEWIWRhbW9kaGFyYW0uYW1tZXBhbGxpQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKTOTiEM9VXocEeEqNwSSCInX6pzIDka9Ux5oY37
MzNBjrka0eveof2NigzPwsVrOLiIxbdWAGwTg0Y8CJGLhW2oeaAMvR4DRiNKoVkAlq87iA+0Lt+b
UlOWZ9GhhdGiyoKgyiVXVoHNE+qaCdiA7jSt2IiKNwtbrJ5ORhhVJhVO7TUWSA+eHhxxX6YVobyW
h8I72UXTTrWfZrpyVpnzcjRD46GJDB0p0KU/2mY7wE2nUvT20sCt1G9JQTq8fr+CHG4DXJj3HFyr
xucep3rDhxi6mbVTlXY3GuQSPWjJ5b/MtvWL3b02wY85/WEzAw5yP1QoxWyfCvS9C4+QlRgMwVcC
AwEAAaOCAeIwggHeMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUH
MAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAy
My5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIw
NDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYD
VR0TBAIwADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2Nj
cjZzbWltZWNhMjAyMy5jcmwwLAYDVR0RBCUwI4EhZGFtb2RoYXJhbS5hbW1lcGFsbGlAYnJvYWRj
b20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UY
sKCSMB0GA1UdDgQWBBQPTiO195ramjDswK3B4QGsKDTPRjANBgkqhkiG9w0BAQsFAAOCAgEAk/bL
jIfng3rwfvQM0w6iGYjLlBQUSPgjuJMjshP/aADrjnHhcxKKImHh8mmWGxMHY4POjHmYAIbQrFHi
yG8aVI2kLKc3/0zJOKqGqx7NvyKmwerKKELVOMdDBXEnXExqAMOj3rYACeJhZqYwqGaK1BcLvTgo
hbrXTFXUvlU12mx0OHcc0GGEQu90+qFwFFPiGcJiHu0pAMH0d2e83iNeJ3ply+KhDxw5Wc/pqAEy
XOcuERQuTAGZH1NY+UVFxxIrr6pvquPAABXaXGU3QG36jWtGPPSjL+1Qf2Jmb3KKm0h4BAHRka1c
KfrM/0EF+/7YszLeeA7o2bpqhcahprLZUuiy7dgCRQs9b8wN+kJBpV2Ql7bBDj5Cm0avWUtGxjkR
LxqSIHo8rccZJskrJx004QmEwKVnkChGRxZ8LrhNKLy8ikzmrxpA2eK7cPyGewmFKhxBoGDsGCfy
CMVthgjbMyh2cVbo7cIXrnx8rf7q9S0aAPt9yHX4+GtXPw44iTsJmD/EOmwX2QLPjjdBKbSgi55S
nUnMFar9lAhGDw826s0j4dQooqLC1BX/jGH1VapU8AGfGAWbsGhBG74yjHfRC74KkFuOj2ORU+9f
ueOdPBxQH3SIl77cHdNp3NWTwFAdBKpdDLMyGf79t5bgpNRYDZ/szNAxW6aH6PhnUMBtD0gxggJX
MIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYD
VQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwufyUvN02feK4hFKcwDQYJYIZI
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHYU0qvx0oKnivYZoglaM+eEXcNfwSXvUrGrO+Xh
q+7+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQwOTE4MDMw
MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
ACbsF2ZyMzuCU4ubXxhsO6nwcrEAlzNV4cpub0B/UA77FNNxZQXN/Adw4Iyaq8p+pLluGzN5d6lJ
x/XBu1pKTMipgA6blmlf1zfqeCnzkPGtH7V5AdoXx37pfLqixmp2i8JQk4Gq2IzPhUjV5CB3csRa
tw8wh4rK0l6Ralj3CQjnU2pY9/xJ5ZJr6JXoY2Uu+DcMF5JsSGmzKFxFV2C1hZ8GQj/Dj56NgCRn
71XtSLpOmBR/jxSewr4Ali8Id2DHiIdmp5nA6bU0qzDTrvItxTxM1Pg6n84RUoWzVKdDzHYlkH5S
KDkVEJykY1ayRJq3BvZTp8ui1nuCCzqHYYpyjMo=
--000000000000a6e7d106325c4758--

