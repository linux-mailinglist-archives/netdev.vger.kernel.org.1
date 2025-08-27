Return-Path: <netdev+bounces-217489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BC3B38E43
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DAF1884C45
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A333112A0;
	Wed, 27 Aug 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AdwqpBDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB8305E19
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332947; cv=none; b=oVcflnbUktGbytuXYrWUbTMy91lX7cPBGcsxNJDB/a+30u5Z/s17TK+G8ypqgjRuC112fBYXCLXPEJstRRk6c8UQ0/lKOuSm6PPT1ro68YRZnflqjd4s4FUakr0sVpW6gok9x3+HrIU39itM3cP83PkNvvKKgEKklZxZMk7VwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332947; c=relaxed/simple;
	bh=0B7Q9QT3ZP47xTBXV+V/PbRpJ8ob/o1Zx+SEBI6F73M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOVvBtAzn3dSx36ST2UAeFEsZXlSx3hYMBdFRrv5As1h+nQ2E3eEpEMlv9PqF2mqxmtFNfy+MP/jubEqRLWn8GMQgKwEFbrY7oEi4dI2e4agf3B9rrlvf0I+eSvXdqwwX263nrmb4O+D4friAhhfna+sAqsLHzeo2HU8JlkwsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AdwqpBDs; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso244662276.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332944; x=1756937744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7WibBkFnxrwk8H/AVdXOPEMHvqKc7rgpPZeKMcgvxM=;
        b=E2xVMHbk40QcjWvyZnyQbuvIoumWqmf6idE+PI0pbIamNIKbiXQtqL6gVk7jx5+mis
         erF59nHedIRtxbKne3rMcbBVDSDrVlTobkychkLDbjhPJbqQRmHvQxrrwBiGm5/zf2pe
         EU7jzIeKhJ9BVzkbOQ3rIp1NfDVeVEOo4eVDpyDmioiFUAhI0TIPHe2W/wWGpPCHkWYR
         zYNboYAA3gibJGXcGB6t/QX+1T7/H+YvBy1Ob86my257q9q1oLyZ21cYskQkZgvlN38Y
         2IHyFp7zWeFXFNFuw7WqLvjReLPqIR0Oov+6J1GKdQrVWXeBy+KmJFam5+xxJuFJibAh
         2uYw==
X-Forwarded-Encrypted: i=1; AJvYcCV3ILZOS1cw/lC1AMeDXViW5MfrzAwp6u4rLVP+pkRE5OIoDnKBcqkzm3scKTrDBsB3qY3LHco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHkBSYOHS7NZ851XE3Zwv+nURWBsgj3HPbB6ph27c9jcMR/ST
	XWoOzLvfQhf0hTX0+fTTFtHPOO6/H3W9/ofqtADKLr+b7Ugukic82u3uzmDtRUhhytoxJyoetX8
	omgWvZvA56Qzm4evd+N94nSV7T91kvjzAE7HaNpbIHHiDPAL3b0z5yTuaK6rdhqoLji79C7oQww
	cydSRTuw8udAoZSX1Ot8d3CAUhcrYqO4C7TZGE0SLIs3+TNH/yLM9+x1o7xqXYQ23TatHdsyWy8
	Hlb7RL9ZSs=
X-Gm-Gg: ASbGnctYWr341pM6t5+TKeDDn8X+DtRBxF/Cy+zHkI+MXVtbgyhei/mKh00GvT6riwD
	o+ACaQuBUzwq5aXkAaC31o6JotJtFybKimVo5J5nB3J/n9OcuGUN6sowPjZMCwLvf9sHVh033Hg
	Dhe0mDBvcYG24HXLdpmqP/glCWbLD5jRoul4rdd7OiHEsdxk4nb7gFofW++VcD/8N3jJ15c2/ms
	6e/V4OvIEhYpdwvkpCztAmpgEQcPSYMnudR05FTAUCKM6hVV1gqqA7rjP69TOH8Gashwd2Hi/Gw
	u77YwKw7u1qvXjvhS0wcFQrIbkYv/jerg/8rHJSfFfWBNbeX6kdglQf/14pVgCp7AB0wtSBj9N7
	0gZ52rsWI2aezru2w6sWnSa6W6ilUUxszPo+PrONWB7BpjLKoSWTDAPLx9JoP5yDhIapDJ0gcyz
	M=
X-Google-Smtp-Source: AGHT+IEI3W/Gqf2JwB0iq5tDrGWUdkmegp2dkpDlsWqyeEpdSJ15MJmTFXgkKTYGBPfW6GE59zb78BRYarUL
X-Received: by 2002:a05:6902:725:b0:e96:f14a:6b59 with SMTP id 3f1490d57ef6-e96f14a6fcfmr4925548276.20.1756332944420;
        Wed, 27 Aug 2025 15:15:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e952c345fc7sm1018916276.12.2025.08.27.15.15.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Aug 2025 15:15:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61cbf4f0bbbso680894a12.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756332943; x=1756937743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7WibBkFnxrwk8H/AVdXOPEMHvqKc7rgpPZeKMcgvxM=;
        b=AdwqpBDs6qSUWS1lv/44RRIuv58trZOurpjvMCnWOuzdR2ry6UBgy9EtH0NGy/7peo
         W9ybxzONgg4XdduL5xDkg5TkTPrVJB6T3oGfGC/yJoWdmNjO+ZPycDu4uSjpGSr2tC/4
         zz1ZYvwK6ZxcNRM1ix1/6h1z0u0wZ5UbYOOy0=
X-Forwarded-Encrypted: i=1; AJvYcCVZK5nJDwR3g3rWc7FzFV3Kf8I7wcFl3FUjJWN484B69Cul+ResWGOwVt0F03FNDk4KvRRV8zQ=@vger.kernel.org
X-Received: by 2002:a17:906:3199:b0:afe:d1a9:e815 with SMTP id a640c23a62f3a-afed1a9ec9fmr159551566b.26.1756332942770;
        Wed, 27 Aug 2025 15:15:42 -0700 (PDT)
X-Received: by 2002:a17:906:3199:b0:afe:d1a9:e815 with SMTP id
 a640c23a62f3a-afed1a9ec9fmr159550466b.26.1756332942368; Wed, 27 Aug 2025
 15:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827135021.5882-1-qianjiaru77@gmail.com>
In-Reply-To: <20250827135021.5882-1-qianjiaru77@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 27 Aug 2025 15:15:30 -0700
X-Gm-Features: Ac12FXxnvL1uw4Lsz8LztijBCF5xMcXB6fjqrCvKER55OidT80HEkVeOLoMl5eY
Message-ID: <CACKFLi=d68RC-1d_i_E1eduVbOpdZFdJYwgj7YBYOwRanZVgKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] RFS Capability Bypass Vulnerability in Linux
 bnxt_en Driver
To: qianjiaru77@gmail.com
Cc: pavan.chebbi@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002efc66063d602198"

--0000000000002efc66063d602198
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:50=E2=80=AFAM <qianjiaru77@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 207a8bb36..b59ce7f45 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13610,8 +13610,11 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool new_=
rss_ctx)
>                 return false;
>         }
>
> -       if (!BNXT_NEW_RM(bp))
> -               return true;
> +    // FIXED: Apply consistent validation for all firmware versions
> +    if (!BNXT_NEW_RM(bp)) {
> +        // Basic validation even for old firmware
> +        return (hwr.vnic <=3D max_vnics && hwr.rss_ctx <=3D max_rss_ctxs=
);

This added logic makes no difference.  We already did the same check a
few lines above and would have returned false if the opposite was
true.

--0000000000002efc66063d602198
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEILZWXQWhkbSOTTD+U/RSze47pNrKNtvB
xnnGW+I7vqLrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgy
NzIyMTU0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAHIje3A/1pcyYZf2dbcNU+tHiSFWMY1eF3YB2nV55le3MFqymIjLRCxaK8ICRMZIgJJt
xeFZt7MxJNKAT2vmOEowVKIdT1EaJjDyKi9W/KRMK7bJ+FJhxPNYMIKSeDiahbvPvRDYu0SCagnP
9SU2/8/rQIbWZNSbnfuf5hP0hmvDpaw6UtStJW2aj7jkulJjCzk2VAvtXTwySbhS6BoesZdbktiL
5dzhnBskt9yGAzF1+QdCE/iYwJRZAQg28eovKZo7ldEaQicyBodfC5PlNelHDJmc+jusQLh0+Io5
4XtUyCmc7g4GxXoxFMmi+D4qyUu8bTBa9lq31iR5VL/s1OE=
--0000000000002efc66063d602198--

