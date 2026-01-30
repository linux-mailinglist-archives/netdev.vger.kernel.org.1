Return-Path: <netdev+bounces-254982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOgtK2wZfGlgKgIAu9opvQ
	(envelope-from <netdev+bounces-254982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:37:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A2B6813
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B21DA3010167
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841AA3164D0;
	Fri, 30 Jan 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZJzwgZEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B7315D35
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740583; cv=pass; b=q8k/a56S9KmTdh5mxoJMAtb5bA6MRz2D/63TkJ69rzFO1PPIwoON0HHFCOIpEQmDuhYcOonlmReig5vC7ij0Q/qXRGgIjtiBmAsbhL0RrLt1GnU9HDcOQAVwNcLqTTmIBdbliBiLYRHUfpmLnsyW7pTUCFxiTevXmAaqLtRRH/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740583; c=relaxed/simple;
	bh=53ZLotjVaF/5cXRFUGrBq5U1sMzhGeJu/FyiV6900G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjAofnzU/0pYU6xpZrAPCg+FyUpLTD5p5VwqS1VfFZGLEje1lgaDlN/LbswZiub4rW1uTA4SdS7nQOuAquT+Gx/k46ptuI0m3ESXQvY/V0HfghD9KR7EtdFBZVsqsWTAy7YWU6C41/VeMQ7se8UPiqFqt4R3rR0qyvdZtCr9s7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZJzwgZEK; arc=pass smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso618867a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740581; x=1770345381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6ltEeqcZYmIaTPYPpyNugdOYwbJNqbHN3KNoTpNRz8=;
        b=ENZ3NMzjziSQnfDYkZ3kzGaAiEjR0qKYR+1P9X5imvSxwUpyE1hKX7iBRTT0hhjyfo
         4Iu/Do4gazddgpnxJX4X/QBHl+/QacY/rDzN8F9jK7s/NBOT+a0bifNtfLGW3aD9sots
         /NQFYhRT2KsWzp7wpuZMtuh0T//H5przLRbQf7f3adajedY0ewoIES4F9lI9fOR8Qdz1
         l37QPHhsgYTQRQxskg6w5U/5PLFt7fVJmdHTchX/hqW7MrRWqfknz3JHpp1spap7uiSh
         9A36wgrfG2dTg8sZ2sBvwcuDKgqv87Dx18qKoe+O7BIH//q2REiinb1R+2a/3sMqohKW
         nbIQ==
X-Forwarded-Encrypted: i=2; AJvYcCUWvP3zBqoWFb+36fqwfjqIWkMDHwyfgfwFPyvomAxsX2hAm+ozQcLgD9ave+sRTHcwKQLjIWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONw562jK95Wrl9xJKcOHR/YMP6uaTwhDV4MnYKeIAK52qmump
	ACH0gUQgZLu54Ie0pdNQfTGLF6hlzz4OiEhqtef4Hn+5M4vGeU9d5AY0YsWC+Dmwv3EvrBWvNBP
	OeeRNvbKKfnE9IPZ3CZF/xXJtoTMgvFQfCBLVT0eaZ9cXQSNogghjMYiVVXwQ0awhHIaBMAur3r
	PdFVjVevQ+THt7qubzI0tXI1f7N8IJDXA/GBZSDVMErsk7NV6WUJFqmxrYnqJPG1U/86GKrFxEG
	9tBmFIcCo4=
X-Gm-Gg: AZuq6aIivFgR3jBEd6GEDBDxBnBmLzqP+Ur+jPTGJ+Pw04bDZvid/rkIwybB0da/SKM
	4f7N5GEbF5LhRDI4GsKTV4F64y2wG3cCniIbRwbaI0CNXnmGq6P7IWwT5N98x6qMEcQDtzgkwZx
	5/mTiq8J5M7Ns9FMbJceEDsAL0i3rvjqHMdmLG+eRj0iqbV0r6Fjo5Eh4aVR7NCsgVUAoyPnlJ5
	w6fHKk1KHvhSlQvKA25+hzu4Ky8Z23hl3R085QnN3iNCOBEhR+R6z4uxKVTaaefQo+5FwuhULy3
	3dS+vHCVbJ9SVk8BztkTorFZcNkj918joP4Ndw6baP26RQ5OjxvbSv1+7drTIwq6yN1cF5khIfP
	AXboiMfjDzh0bTRtFeFF8qkeVnHiq2FkWKkOr7ljY8DHrKJ56obsIVKNinYNFhrHhApt2gfaUld
	np/ONcH2jX14xRZNCS79GY1AMwtHtc+chFmbkHdJFv4wzm
X-Received: by 2002:a17:90b:1808:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-3543b2f8d01mr1070888a91.5.1769740581196;
        Thu, 29 Jan 2026 18:36:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-353f6255654sm1382937a91.3.2026.01.29.18.36.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 18:36:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-658b82db375so2233188a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:36:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769740579; cv=none;
        d=google.com; s=arc-20240605;
        b=fTL9x33Yvf/aa4ziCr8zR8Dteq18dlAU+h1gCjx/RF7jaoCKuKgKkbhJ1Ds3x5FnEY
         lR9zF1D6K6Vg44q21nlkFZq6OVjHMphDo6v03JK+XmvXz7VpnTSGyYJ/FGuOrxdF8G0V
         cO/VClsBCQu2TgbeZvRko+tBTV7p7fX7ec5DS0IWBjNm6OGdSOOM0Dk0HjKTl2pxahIt
         RgLhBN/Yq40qPNetlYIp+AzCHAa0KAq1uqzykYseot5bKoJDFxfg/QbvTaX+/M6CbeTL
         e+vDbJsTRNSy1IqBzu+Xj80vRp1yUwpifMutwII04P8ZaY1IjGs8klvXcy8gt6Di0kmx
         NChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A6ltEeqcZYmIaTPYPpyNugdOYwbJNqbHN3KNoTpNRz8=;
        fh=5QgRjcFdz9Lz47ONzQBJTpVNUrgUb6mx0Yyv1isPaJg=;
        b=bP411q9MX8ZquCFHHSUVk02i0Q8+zsT8zg3tdmXQoGzFBkbBiYINxRiT+q5HD5rjaN
         zoaPMwcEhQesHFMWDy+/Vc0m3CcBPnGegxoHi4Umig03qJpjywp0CHgFWOgfhSLeNIom
         UZgq1OFkAJiJBbaZ+ZRsQ+xSpbHVs9kD6bkqElnvJNba/CI2AaR1kqgwaf69xLWMkMsb
         pzVbCw64jZ/pTPXjXv9CyPNH4qjtLvoouVpHzrrEDb9Fr6VcgdiDyJdB89XEIsUE/Rb2
         J3pOdjrRHV+zs/jgUUMgt4Newd3dN35ffzsl4s+pptiKgmu71I7wZJHs5Rn/FtHXYNnU
         7OuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769740579; x=1770345379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6ltEeqcZYmIaTPYPpyNugdOYwbJNqbHN3KNoTpNRz8=;
        b=ZJzwgZEKtlQH2rKB7IgGIhZgkYrj5JVyXQaSfatqMYraXUrIKsrT4HObqphXAhlKpj
         mNYP6u2LC7vnZTGc8c1x9hVU9uk6ZmKcgxQI9W4G5FMbUUuS/6xJ73F+oj91s3G5oDFs
         1SefIAgy9WdPE36x23bYGEx8DuG72aumbk9vQ=
X-Forwarded-Encrypted: i=1; AJvYcCX+bdEjwj8UHInCcxNzG/gEaDHh1B5fmbNp3yOX4xlH2l7kDCMA6FH5Z9XJrfWNND/AtwzFjzw=@vger.kernel.org
X-Received: by 2002:a05:6402:84e:b0:64b:5f4e:9e6d with SMTP id 4fb4d7f45d1cf-658de58b514mr814519a12.18.1769740578911;
        Thu, 29 Jan 2026 18:36:18 -0800 (PST)
X-Received: by 2002:a05:6402:84e:b0:64b:5f4e:9e6d with SMTP id
 4fb4d7f45d1cf-658de58b514mr814508a12.18.1769740578547; Thu, 29 Jan 2026
 18:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128193258.125274-1-kuba@kernel.org> <20260129182332.040411b5@kernel.org>
In-Reply-To: <20260129182332.040411b5@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 29 Jan 2026 18:36:07 -0800
X-Gm-Features: AZwV_Qj5HlaFinP98oaIjjLHLFA_ly2FT0j9jl-v-d1iQ6YyUmVALZzvM2Jl_wo
Message-ID: <CACKFLi=bzz+HcTGO+fKXEwpxPMN_9fYndmFDnKfBqcKC1RnQDg@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: make sure we populate the qcfg
 defaults on old FW/HW
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, asml.silence@gmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000092dd45064991d62e"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254982-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 0B9A2B6813
X-Rspamd-Action: no action

--00000000000092dd45064991d62e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Jan 2026 11:32:58 -0800 Jakub Kicinski wrote:
> > The driver now depends on the core to tell it what the rx page size
> > should be for the agg ring. We must populate the ndo_default_qcfg
> > callback even if we don't support any queue ops.
> >
> > This fixes:
> >   Oops: divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
> >   RIP: 0010:bnxt_alloc_rx_page_pool (drivers/net/ethernet/broadcom/bnxt=
/bnxt.c:3852)
> >
> > with fw version 225.1.109.0.
> >
> > Link: https://lore.kernel.org/20250421222827.283737-20-kuba@kernel.org
> > Fixes: f96e1b35779e ("eth: bnxt: support qcfg provided rx page size")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Can I get an ack here? This prevents machines from booting so
> it'd be great to fix before too many people waste their time.

Yes, it looks good to me.  Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--00000000000092dd45064991d62e
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCApyWev
b5tnwrkynJuY+0jb3EDcEaBF/W4fSg+ZdbDrmjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMzAwMjM2MTlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCZm0py+FmspCuWf4XW2gVjcA0+6Mc+ulhB2k4b9VC5
K8YWaZAj7452h7C2nQ0XPegN7KqHpPofF4INq0wJwXA+eE7byoWUG38eYHEarJGJz3F7obV8gzwI
/hFOVmnbGIviP9GFJ2t0lwalfFn4aKmXY4W8a5RHY1nm4I1KmI0PinOfILFRnjIDaOLflSqH0oV8
i2nY3uwibDvgIz1cr1s6PXjOcRyB0eUyBbCZdES80F9zQJ0gZ7Z6GLvko8CLh0XMIvsY8gkMn/8Z
2nrrIJWXymJRbcL486sLGmWz+ro7/gpI38VDlP/FuDl4uFGWqkhrYV5rQxAyiHRzWrlp/LaH
--00000000000092dd45064991d62e--

