Return-Path: <netdev+bounces-272119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOmnMthSxWmD9QQAu9opvQ
	(envelope-from <netdev+bounces-272119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:38:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCA337AFF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915723068EC4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11413F210F;
	Thu, 26 Mar 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JIQO4eaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493E3FF8A5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539127; cv=pass; b=Xfq3gFK9K2m26XHPKlv2WTzoDiTcd6R6ueUtqpGhPOHtLckY4mb1vr69eakQ2liAhBK7VSTHXb+L8m+crwRqh/DDeUxdvavelApUkLDpmZ/FDYjscnuJEFjcUoYGLWgkkhIvFkQTX/j9uhpsURHKG/HxN8eqdPrIAo18lHQ9pKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539127; c=relaxed/simple;
	bh=5lPTZ1iBdZv70s+IomgwFP30IqGC9qguw++nT2ALTWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+TsrjMW/4ZxI+e37E8BjXxyKRQRwMHMQ/SFPZX6fYA1V7gQSNDpBGb0Tfs1kXu4qRvO2UJHTgqmMlrpTJviEMrDunkLsWB1PMIIjQHnL3vpU+R/zulMEjT1VZKyBlqaw8M1Vz3b1YNT2Kg8IbvMsglOkr66o6m7Dah1PwPU/U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JIQO4eaN; arc=pass smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64ad019bbd4so1555046d50.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539124; x=1775143924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7M6J7l/0X0lctUfPQfQV1dcTfqrbAaGFxth0MZisGs=;
        b=JL8FM/e/6o53xtZPffvIHRZDHyrLQQ0t6CQdl9/dp/x8wKwE4Gxn5aYbe5D9ttJrTo
         22wEkMxLuN6CW3zQ9asd0EAqmE/8YVkkiByAMqWLwuTE21aE1h1K1XvQMNX736vBykUG
         BX0dgxWMuXOaW4HF8RKQnNy6T2l0BkYFNg6BodHDSt0ylJm463ZrATOgdENHqLImkWYh
         UQNzMm7cKnW2HFwlXKATnosQtbM22qhuLSE84zSOjNgqpdV3sTOu9CvRqQSmdSkPHkED
         kpEZEOQ4dGItvP3recr1wWYcjGnb3YCN+LI8cZh75bh21djxmq6bbRTbSLrKGGMt75MX
         o+/g==
X-Forwarded-Encrypted: i=2; AJvYcCWGlk95+PIsGZo26yd7sUM9CGHP1euQcBkvSzVx3i2tvfypEnhEn0VDCOtZ5/5eyKT8rm0+Ty0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4qCkcaWxL9wDQfW+DCffXL/D1xs9EpkqBWzYuov6m9S14mf+
	JtVrhIdu9uI2FZ/XjEnxI190oF93EMlpTa717ad8qMiM2mWaLRfF1pgGHCPj7cV7BYMaG1B49Q3
	M4FIbY9xLymkZ1sA+PLoemB+LBsgCrDF4pOqnQnSira2mVZnBB5bXtZsj3sazVdD4SG0kGsCmSU
	P8ZVnN3Z5q75LvlC+WHff9Ico1A/v93G1LB2qbAk3GXsvN0sKTzingPJuoLxSY4fJN7nG0HDZAo
	Ln3afsLoog=
X-Gm-Gg: ATEYQzxKn1qKumfltkhMFJJVzRk3yD7otGSgyGsGY8XcSxLRmVlFNhEJiyHM8dBzXjJ
	AHYZNDlHbMJjndoeMT230fUkgnwDLJSC2u9z9Bda61pB0rY6yZgkgoPuq9nHTiivt6ogDq/isWc
	6jecDngLXc6Xm6IUsDDhKlLkx7uXi0jTJFx62siaQf7tsKabHZ7vswVtZcWn93FZ6lkAUttODXz
	lwr0BuoEmtv1UQKLoWOW33skJKM7Gf/ZO94zk2HewqZQqblzEIC+3UwzHWLjWEIw90uFxezeSoC
	+IxFlZSc+tSAyxd7vSZbV94Zrnv75+MxJ0E5lV5zFTeVZ6HJP7Qmwl83f4kLSJd+LI69E9ofuxt
	SjY/xBHOgzE0zzuB3vWZevvfBWj3pzDveIfOt9Kttb1Ve1R91tgj5lmwWskjaidt55dTYTXYrIt
	7rFQqL402fF4+toc7jd/s/vLX6yB04OG88rWWG1y3ijF5I+Q4i67kzG8eR
X-Received: by 2002:a05:690e:d0e:b0:64e:a185:42e2 with SMTP id 956f58d0204a3-64ee6118fe3mr9348170d50.35.1774539123137;
        Thu, 26 Mar 2026 08:32:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64ef56c9d83sm305402d50.1.2026.03.26.08.32.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2026 08:32:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-668005baa62so1615714a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774539121; cv=none;
        d=google.com; s=arc-20240605;
        b=G49ieXISK7PmO3svdfHeLcw8IzevizE+FCXjNSSBLLVvcjWd1ivMFSWLbKJTgr5pyl
         MWDbDs1pcR+O6z5rQgipQEioQxlE5XbE2GlqKNtuL5zC17DTafdr93K43o9iuE5NuiRc
         Fnd8hPih0wQtPDwRHaBvby9XP5XG3xqYmNbv5ucz7+eME7qev8W4q23wAFXcoWh33GgZ
         r6u4u0zSWXLs4E9jfc+32mtLBCsH/A8IqxFajHhE1YJAuXRwcBRa6bo8T0i4yqAY+idf
         G6FYiqoC0Fyj/8+6DL59JJ5jeVg0LFSaGhnBrtpE7OLhB/IOb5nY5vqqX3FVk54cpS6o
         PJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l7M6J7l/0X0lctUfPQfQV1dcTfqrbAaGFxth0MZisGs=;
        fh=bWcxL4EqsHpnko6qmwhgz99r8Stxw7eyjeHB5Vf88mU=;
        b=EQ0R0DO7NwD9cA6PlanxGZ4wt6t38djDv3ts827odut0Sj6h+zHL0rVT8+jIhKdXKW
         O7nYHFRk/Mxw0dz/vWYzNtkxNzztocWKETcQ0ozsCzqravAqNQPyb417esYy5KRRSXzM
         ohouLIIFIV5aMAOAMcF3Jfi+MBtAjIQjK6Ovm6Kqs60KKIC/kpUaqOsHczS9lPBl1opj
         z8quvkjDmsjSdwVZ+XGY7YdnaXavsoIlt+oBDXSIjDIaPQlj1Mm8etvdVwJf2lZ8yUO3
         FTMUcLHnoEYWB70Sqe9FnlAhenar46oSBtAy/OdzliJbL80OXzIyhHsGf/f0vqzqKbFw
         194g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774539121; x=1775143921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7M6J7l/0X0lctUfPQfQV1dcTfqrbAaGFxth0MZisGs=;
        b=JIQO4eaNvh+eZ5GNqLrmoyjZhwN2aOXqXRlEs9khFZL38T9GqncwaCFokiuG9TVgSG
         Kl5X7KBDcQgKJbZNEq5pNVd4Fsg6cId04bFzyNoYj8LFKbK/ECRMSbNoZdbWl4iUBIG2
         WnZf8NbSjk9toTYMxtZpYlUXSbhSgaKeOs6eM=
X-Forwarded-Encrypted: i=1; AJvYcCV1q0CNtA/prRleoowL8XF6NZHEv1DT5vV5OLtEtTLMzPZ55IjbkIRz1816vYAgQl3QihbIOAw=@vger.kernel.org
X-Received: by 2002:a05:6402:4348:b0:66a:31:17eb with SMTP id 4fb4d7f45d1cf-66a826776ecmr5389355a12.18.1774539121294;
        Thu, 26 Mar 2026 08:32:01 -0700 (PDT)
X-Received: by 2002:a05:6402:4348:b0:66a:31:17eb with SMTP id
 4fb4d7f45d1cf-66a826776ecmr5389326a12.18.1774539120846; Thu, 26 Mar 2026
 08:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080336.36905-1-pengpeng@iscas.ac.cn> <20260326142033.82313-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260326142033.82313-1-pengpeng@iscas.ac.cn>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 26 Mar 2026 08:31:48 -0700
X-Gm-Features: AQROBzAaHFnnITHjwk2iyg7JsrlghDofgpXaWQQJwXcGzLJEbzHxdpvLhUJ0zv8
Message-ID: <CACKFLi=Epid26giaeai-DGknHWgo6eRz+ZYk_QoagFmcqc+EKg@mail.gmail.com>
Subject: Re: [PATCH net v3] bnxt_en: validate firmware backing store types
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fed5b5064def15d9"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272119-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 76DCA337AFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000fed5b5064def15d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:21=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:

> @@ -8708,12 +8709,21 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(=
struct bnxt *bp)
>                 entry_size =3D le16_to_cpu(resp->entry_size);
>                 max_entries =3D le32_to_cpu(resp->max_num_entries);
>                 if (ctxm->mem_valid) {
> -                       if (!(flags & BNXT_CTX_MEM_PERSIST) ||
> -                           ctxm->entry_size !=3D entry_size ||
> -                           ctxm->max_entries !=3D max_entries)
> -                               bnxt_free_one_ctx_mem(bp, ctxm, true);
> -                       else
> +                       if ((flags & BNXT_CTX_MEM_PERSIST) &&
> +                           ctxm->entry_size =3D=3D entry_size &&
> +                           ctxm->max_entries =3D=3D max_entries) {
> +                               type =3D next_type;
>                                 continue;
> +                       }
> +
> +                       bnxt_free_one_ctx_mem(bp, ctxm, true);
> +               }
> +               if (le16_to_cpu(resp->type) >=3D BNXT_CTX_V2_MAX) {

The type in the FW response (resp->type) is defined to be the type in
the FW input message (req->type).  If you want to validate it, it
should be equal to the loop variable type or req->type.  Thanks.

> +                       netdev_warn(bp->dev,
> +                                   "invalid backing store type %u return=
ed by firmware\n",
> +                                   le16_to_cpu(resp->type));
> +                       rc =3D -EINVAL;
> +                       goto ctx_done;

--000000000000fed5b5064def15d9
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDBUhF1
BVeu/wrL+BWRt3uhpMZhDwR0jSczab+RsNorLTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjYxNTMyMDFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCjAMAu0t+hL1KmdYrQ4Kaga+VpGhvK/6bJPkp+mUXE
mbqWODuMGGzM60e+w5QssziNBog/sG6gu51lSBFQ/FDQr1QDwBvg9cZB/mEky+yN07ETStPbhsFG
uIDgY3vwoJ0RV1Ke6DpLaPGaEQQv5HPgjsiR3VhUZX75QC5lw6qX+zV16H9CVnlfN5NqSIbSL2hR
2D2pNcmjwxDIJR/gHv89tQFbeTEJg3L1m/DBrK6p8rKcUazo0rnDtMCLFgdUHOe4YWsoLsWQQaTT
xOyTJ+1X1I7yMJBs/rzk6l99nD6/74ewWBF6iRTWXFIgKIzVENO/ySq6FqgwSkgYYJ5v5xgO
--000000000000fed5b5064def15d9--

