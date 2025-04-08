Return-Path: <netdev+bounces-180426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0AA8149B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C33A7A2BA3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4823E32E;
	Tue,  8 Apr 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OaolTzFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D422ACF1
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136760; cv=none; b=QYYZ9KoaZwN10j6cWhqvLlMeW5htJzlBuidIYycz5O/I8RECMQYK/RKxLNdQh/W1fdgN5JuT7pIB/D1m1Eq26/DIqwLmJBLpK6MIU553FffxI9WNyhoeLBK2YLPzhbCbd+P+59uz7V2DBl4dgdumvUDcgMPqCSXVxlQm71TILkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136760; c=relaxed/simple;
	bh=5BUuLYHBK920+uYujuCFkR6aZY96lGTCuhOIKN3jHlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpU4rjhBkcn0fXs3dfg8rZbBn1wztdc99rVm/V7hSnGkm88ndSi4TlNCCKuvlGEFj+JI+Anu/V5Sfo+3YJrhO/NZIAv+Ur1Q3vrwshXgNWSYw6Ef76RK5UmtzggKY+JqZ/1FApHvvnUsu8cNMjoO4qKsbzUR+vobNgVQmt7TCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OaolTzFX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so9297379a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744136756; x=1744741556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk5e9FnoUxavt6eBUUT49D1bIBlt2mTsDJgBBqkcDMg=;
        b=OaolTzFXvZ7Z5Qt07Ig0cmGCINpGKupV33Qb8oQiLSH5kGfvK5qNaIu6QMMw7Sdrsl
         7u2zE+eot8NF7as28WmpFgbNk8XelN37RbbA2ORzHJ8UUeB699G2Y0EsU2lJ50vAKpbK
         G2sGchJzhWXnQcfnmCnLTyrJeiNblwoo2/g8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744136756; x=1744741556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dk5e9FnoUxavt6eBUUT49D1bIBlt2mTsDJgBBqkcDMg=;
        b=YJSrESAdU262AXxzPVcMVKpjrR8r/93TPZDhuVI2eFsUmzSzBKFklnan23opjjYb5d
         m31ZkSbsgynF7foVBvMUhKpR0vp02iusjLUcCHoi1amQIZHWRCeFIP9gkIMx5HzKFCQs
         taiPyGyTvuNju/S1n3v0nCpUBZF/7S8h+vPwfdaenTZzJpDNSRBEAqXgJ/tfMaJ3vHP0
         hEMbHYT7tZXicCIxmCYoHt3GsED/icztmLw1X93bQFHp/w9Uh/pdjNsWX6ggS8qe6y8C
         txWjELaD9eg0bPeF4CvIEZID6UwBtjVm/oVaYLnF1+BKPHOCbKj8WDmgTTbynqlDVfOD
         cVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUZQu6BOEcsg+CWtZ1iDXUIem5tVvw4c7QFKjq+hlEyLaQIL4vdc8hWkd7VqRE03NbkM9BklR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvRQpWRZ3Zw/4MrfIsK8lFV/fqosyykKvS+iOKeltg70s5d+ra
	oyYjBdhGZBL2sxlxb3Bd4wEeEhlCUWVd8jhUukipCOG//cqgqOD3OKgsXA4zqaNhUmew2+3kMXR
	WmL6NZuYTjvfX/Fg/KZ6nanAf2uul4C3qXCtr
X-Gm-Gg: ASbGncv8g72pDruS04g9TZOf05rHrUcrtTDdQwN/zlh4PxnIKPej99u6UIAu5mw51dF
	23+DWObFtRQwLb8XX/uzdvA7erWTzMeAxh/744YUI5rwVrnI/FZ0tlpCyphVZuyNFYGfAgPffrf
	8CkSY3uOSNnD5PkBgso6IJCgZJvKc=
X-Google-Smtp-Source: AGHT+IEuUdsOJwVaJTNoUmd8xocoH9qaKWzxlG/nwqG2+hiPhCa8mR4G5UbJPkAOIbnjhZ6C7ytuMgEozZFJbyG5Wzg=
X-Received: by 2002:a05:6402:520c:b0:5ec:96a6:e1cd with SMTP id
 4fb4d7f45d1cf-5f2f76a7fa3mr63180a12.2.1744136756470; Tue, 08 Apr 2025
 11:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-3-michael.chan@broadcom.com> <Z-6jN7aA8ZnYRH6j@shredder>
 <Z_P8EZ4YPISzAbPw@shredder>
In-Reply-To: <Z_P8EZ4YPISzAbPw@shredder>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 8 Apr 2025 11:25:44 -0700
X-Gm-Features: ATxdqUHOCgPWyvQ-GxWDvngCzBcvxUIzwPDnPH2vdh6HfN9aVEYtazk2g12NylU
Message-ID: <CACKFLik=7nTXHGUiTQH=aAsY=3sxd39ouZLEYkN2hj8rRHetsw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ethtool: cmis: use u16 for calculated read_write_len_ext
To: Ido Schimmel <idosch@idosch.org>
Cc: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org, danieller@nvidia.com, 
	andrew.gospodarek@broadcom.com, petrm@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d4db4f0632487b67"

--000000000000d4db4f0632487b67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:23=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> To be clear, this is what I'm suggesting [1] and it doesn't involve
> setting args->req.epl_len to zero, so I'm not sure what was tested.
>
> Basically, setting maximum length of read or write to 128 bytes as the
> kernel does not currently support auto paging (even if the transceiver
> module does) and will not try to perform cross-page reads or writes.

Ido, do you want to post your patch formally?  Damodharam has tested
it and he is providing his:

Tested-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

I'll drop this patch and repost patch #1 only.  Thanks.

>
> [1]
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

--000000000000d4db4f0632487b67
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKUMtwLR0/pijfaNeMuIRZ6k3Qogs9Y4
OY5SXC+kIi1IMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQw
ODE4MjU1NlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAFO8JabLU75oCcgeK6QVVrIQfy9ED1nICdiYdNxc2dkq+MWKRJ6mx3fOpeviOdXSSJzL
m666MyMbE5GDVyKowSUYsCjQkLwkMshDrf0//Eyv8fcLqTDsUq52Fufda6a2yKt4q4eQr9WKDSqn
uG79Nr8EMs/oMIuCJdtdNUsp0YBw6e0sp/k74XA4ZMdKgcV3dPjOUpUZI5JnUeKJWwUjZeHg5OUt
KAGzbSpNF3yNupWRFMnLN1/2lVZ0b1j9O+rHa9T0lfIl4Z/x5Wnr/m+KWCvE4MsoOwllWFyAG8IY
2RoaZ0UiIpyXZzOSXuNg73ocxdcisWVPrJTJaFs2xDBJhbM=
--000000000000d4db4f0632487b67--

