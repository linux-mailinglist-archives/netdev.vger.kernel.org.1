Return-Path: <netdev+bounces-274269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA1qFr2rzWlRfwYAu9opvQ
	(envelope-from <netdev+bounces-274269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D7381B1E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 01:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64AE3007CB3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B562DF153;
	Wed,  1 Apr 2026 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sdlbl+HF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783952F8B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086480; cv=pass; b=TL7Y6VWkdpsbCfHETcpLbhm0T8dXgnb83Eta0Y9mf5hVl7EbdRmuCgqlRVC8B6T3rfm9qLrFDSMzjQO6wQaBMH+TsmrG7DOEglzJE6B/DBMfDLTaCKNj/Am8bvJsja0wWCrozi0Q4nj5YCg+imrEUPFpLrE9hejjPjjOvRj3yLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086480; c=relaxed/simple;
	bh=oJuKVIwWd8r7CQisaIY8MRe1Hm7Opzq2KX7dYVdprsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXxeYwy39as9lfsZKXsKaNO9/CVB+xpOwzPduQwTW8OG4riT+tYGx1Z9aMc6t/09fTNMo79RokfazkKBOIHXbX6SCsc9Ry4EgKosjijQ4GN/Rjg8LHc/MiUlcVnMYDiodYnKHIRFiAib45bEKkN78gQMsZIH/JN7UXFh6+BgrnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sdlbl+HF; arc=pass smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8a032383008so3731656d6.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086477; x=1775691277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeGU81iLQKnQoHlDBFt8jFA8B7aQVBnah0b+fRz6In4=;
        b=fql2a2mF1C0k3tB1+6+cwBIOeqAZdBz7xzeOnPHTF+nlOsKdOe8ERMmo3sMjhP36N/
         8Lnmit2sdQazKxm0C30mJPNO5RZ/lMw/VtjoQ7GMPiRaC5CkkajH/1NF52Kn89rPRbRk
         JlrPJN7CuTMwQ5SZ0wXZOFBfzgxDyieoaOtOLV9W2KawB6BL7uIOJ+N7tV2sO8sL7atK
         /SKhT0/+cl0aHVcGRII8UrotgFYjUoQVUX2LHl/nrMATNl787fOuZXUl+fOWDGceiyfD
         nwm3CjVOYR0hpXboGXNUABkfk9Gv19vEDSYg7wUUVNrBJIZHmzLN3Rzl1DZZ0bISE9+7
         ly0w==
X-Gm-Message-State: AOJu0YwbBescrvrOl8eFTFK3KhEYYKnEG0QXUh4c7ZpwWwItoZNItGTR
	6BWBMtfyGlRc8tHxm1VllZtrKTz1dpZBrRAI7HR6l4mHnE9Vns9ArHVSvNyC++b3RLwfio10SnY
	1zy3SSjDcImM9lQ+IsdtCZGn3IYXSH21QCbcELR0nws7QkJtoiRhmT7DgYRSf39F2mkEusg4h5b
	Wh92u4K9xHbV1vLjVkYV5VPzb7FANlzIjAPEW5lV7NwdU4KoV77KjruXQVgCHIvFR1IdOAm+WY1
	S1blADNunk=
X-Gm-Gg: ATEYQzw7rnD/gy0SBn50G6h3/CGp/vOX0+5DnP8ujpeSeI2nRlqOcehNL6HUuVpQM+0
	SJqSun6+RCXYQtsJvFbOLzCuh896+RCHNkNOQAycWPVFheqoc9nyNe0hJzGpXNFPY4HciVXM3m+
	KJ9MG2llXOMnvT7B/HFSDrMd8cdmIxAVJsuk0ZxedGPMQBi9WXWMlfBUK35I4JEbPc4VPnnSR6V
	V2Ixrujn79t6jJbbrYKFzOUeDnwOW9iZY06prWjBOAliMa7WtYbj5DPnrFm+zNFc8EkhBkXtDKt
	aPeMvzMSa4IgSSC10caPcv4Fsr3riGH/2hm0Ii0327DpG2uxN/Ie0fuLniOsIjFNM1YfYXLF1fg
	iksRSKnRwga8YYt/rVEX0i0DcG6wHl0duXX7E/lHSZdTaKkLffe03muaWPGukwSUVUObztmdbZT
	dKweJ5av4freSmv0P21hiAtFF0uU6C+HDf4wZ0uMaMr+3Tln6lgW5dJIuy
X-Received: by 2002:a05:6214:27ca:b0:8a1:4169:7b93 with SMTP id 6a1803df08f44-8a437a1a282mr94734876d6.21.1775086477334;
        Wed, 01 Apr 2026 16:34:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8a596e06764sm1057886d6.21.2026.04.01.16.34.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2026 16:34:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66a8e90f0d3so252021a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 16:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775086476; cv=none;
        d=google.com; s=arc-20240605;
        b=YDGoaDUQTWYA/r1LnipDpGRUeKjr5mL0rwE1ySWbREYiSLkfHpBC+ASdz4BhaAKGEN
         4UXzWTKr6Q1XRlwk0hooQ7DI9symE27ib7O3XcwUvh3Cx3gF/0ySh7daWIEqyuSoqq4D
         O/r0E+K07jPQ+C42zt4RxV05BR/9HyqDOH0R2Lre8cok6I7UyK2+PCeEEdo+Yzn5qbbf
         jkEeP40i3kUxaSuxCeZyd+AKPD/uCbZNJQ3VGMMcrdGtXMXQBYa0Pu21p5vpzlDUZcnq
         yVZa+O1AuXV1oqL6C2cvhZ6qRvjDYLQrpdyuHMhQU/eqKfc62sZ8J7qy3epl98OF9VpL
         O+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UeGU81iLQKnQoHlDBFt8jFA8B7aQVBnah0b+fRz6In4=;
        fh=jEpmzWFIj2NzclD6Tm7S7t3uPaMD2M4mgWRIZEBYHyg=;
        b=AXjf8dLl+bx38ehI73ED9RxtoTbuKWDmcKdxvaub+95DQ4jINYxzEMobjPoOt3//kO
         01a9geaDzmmNgZwLxBqfdLCrVFgefmy8Qzck5Jhs0psgfcnB3bzk2MvtHMOJTE4wgqGo
         wXICTULSPpxI41MNCytxCMgZLMb1dLikjiI+GIbyWasjc6SKxUaLsAPSJuN2KWOG9G4g
         aL2meJKnCjKEFuyx8knbeTTg3dcObomE3uCzFimzLez9NdHJ0NSjYe38WNd6TivAYH+L
         myMR67Q0QIGX4I+Qtr9ASiguEPFyExVJjsFBGTinqAdKQCm16a347ilrarjrLuF08FE/
         jULg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775086476; x=1775691276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UeGU81iLQKnQoHlDBFt8jFA8B7aQVBnah0b+fRz6In4=;
        b=Sdlbl+HFJJFuSBhqO0VnTh6BA0T47sSj5bIjL5gyXbI76PQOE//cs7YRdJmKZQ/dBw
         5kO0b3g3tXfzOkTB9zwl33FlzJOUT033urYOja13IalLtc/Fm0PtVKc23zEcPJNy9ikJ
         5vPyXHWLmk0DNpt68kCOckHhDsCFthHG8XTG0=
X-Received: by 2002:a05:6402:4584:b0:65b:a2b5:5320 with SMTP id 4fb4d7f45d1cf-66e0403a3fbmr584239a12.26.1775086475763;
        Wed, 01 Apr 2026 16:34:35 -0700 (PDT)
X-Received: by 2002:a05:6402:4584:b0:65b:a2b5:5320 with SMTP id
 4fb4d7f45d1cf-66e0403a3fbmr584227a12.26.1775086475178; Wed, 01 Apr 2026
 16:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401011914.1716692-1-sdf@fomichev.me> <20260401011914.1716692-9-sdf@fomichev.me>
In-Reply-To: <20260401011914.1716692-9-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 1 Apr 2026 16:34:24 -0700
X-Gm-Features: AQROBzCTHtg68TQmOvOeF1tLp1nqYkh-zzSgZkYBKcdc0Bcb7Nj_kLndnUBLHTM
Message-ID: <CACKFLinxVzp8HrYOg7zHpK0VYbDUS+GtENnxa55BObXRr24EXg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/14] bnxt: use snapshot in bnxt_cfg_rx_mode
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000da8ee4064e6e8648"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: AC4D7381B1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000da8ee4064e6e8648
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:19=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> With the introduction of ndo_set_rx_mode_async (as discussed in [1])
> we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to
> use uc/mc snapshots and move its call in bnxt_sp_task to the
> section that resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> bnxt_set_rx_mode.
>
> Link: https://lore.kernel.org/netdev/CACKFLi=3D5vj8hPqEUKDd8RTw3au5G+zRgQ=
EqjF+6NZnyoNm90KA@mail.gmail.com/ [1]
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

This version looks good.  bnxt_uc_list_updated() is called only once
between bnxt_set_rx_mode() and bnxt_cfg_rx_mode().

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000da8ee4064e6e8648
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD7/D6o
FwVcr2kfU7zBzpTCmERBCla46z/OLNY+OPGDhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MDEyMzM0MzZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA+/XPZmJfP+UyFC1QBUCgaVFX1mPT79Kp3WtmUVEaN
aX6T2QLP3O/Z0yX4hDdHPOm6oIvg0w62mSPWbjxXbrzv3mwACDFopZk8JB4ARRHd1rGLq6a07IlL
kT8b9GfEd4bUir64fhP9Zkz9PvM3j7Vaw6sOpDMJvNyZ8gyGwznpnm9JGTJ1gqadw1klfuNgPHn0
+UTaYWJIuB4OZdRThbeUVUhMv6U1s45wDIYP5lF6SggjknGijKon31nygtVj9ai8MIfTRPe1JBxS
S2PIUT+54Dce4xZ6LjvnYFOT6V9JjcHrLU54xjup67lKXlRpsOcxlmpviPrZ7YjupNsYoPG8
--000000000000da8ee4064e6e8648--

