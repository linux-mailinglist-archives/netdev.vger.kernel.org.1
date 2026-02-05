Return-Path: <netdev+bounces-257346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fo+LIMdhWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:45:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CBF82E8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F1573004699
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22A02D47EF;
	Thu,  5 Feb 2026 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TvftkYF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF401B532F
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331518; cv=pass; b=Cs9fKNdN1M6aqm6sRVjSq4zDFTKLLC5B0pWBOtuH9iBs0CA2R1V35Ai7H5p/WKEsfd8QX1g5vcoaB77bEJSgm0a+wkHHA/EgHgoXOV3hSjCo3AK/Z0GrtgZnEUEUVzAyNLS/HPyoqZJ75gJPdu7sZEtW7Ri4ObDEQPY/vAKOQnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331518; c=relaxed/simple;
	bh=9t1/pUp8+K2IH+WUjNOWRDJVCkOhV6q1F1H/y9ijRnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1sFCkOdipxttZyss4J80eJlBkYWkcNNEwVTZjHV4QvicQZO6V89P2C25xWPx7A6pv9vDjCgmJt/u5nfzYfDW5C0JwhuFt2YTjYybmhkBp6bbT9zn0mGKRPD4xl9y0STv8f4rrXaeDS0ufMtaZj/2G/qXu+ivI8RSVUnDdzIfpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TvftkYF+; arc=pass smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7950881727cso11369057b3.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770331517; x=1770936317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbY1rzn1bTGNc/7qf0VCX2u0YgB4o0kCgXZlRT67/78=;
        b=RKAN2pM4/ztPPSw6g1RpdjFROuLKMKEmdAKTmB/UrnGCVGyX5yk2XhRHac2kFSio9N
         EI+htTERglINfj0U0NKZUEgXUJk8lWSUrZLu6oba4Eb/EAtzNe0xMAUo7HwGCPBPLJzz
         Th8a4si1b3ZAt/IT+7/n/pdl9LeHukGwjr7V9t9mn8EUU6KzTGagwvaK1kZTthddZQgV
         0qvZnlNzeOKqCzlTc5nG0Q38j9n3kfoaGOBH5ygu3uw1/BUUfCthtDevlTOYXS36CzM0
         lEdZIJS+QpSWBufE7jiL2w5c8QfJ9kKAP1c5MmaOKFMUX2q2eS/JH6/HYD2P3cN6AKB/
         K1hA==
X-Forwarded-Encrypted: i=2; AJvYcCV55yfczUJdO5aFPjXwsSs1a2ngaMen/zc75DHxBq8h8cXz1MAmvqN1ext9CdYAWq8cvO6jJGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBljl63+qaA7rQ+fRX/HWK0+g8ZMLGWfiHDBJVoC4MJR+H3eGy
	oliv5/UalNPr90NQ8Pij3i+4IGEiEoVyaLZYLgGvLBVBFjGER9aVLkolGRabzPGgUf/9jBEJJbB
	n1dLLXDYq5+1SS91pY2/ltwGjo71RxpLcM6NXbVKcSbLm/25BF0MqDWrYVzNzDp5cHewVW0fAVk
	SlLgkOjNcFBGRL2Dw3exCxUqsWIOB7UlS7P+3KQKglYJqfuCN5A6+bzGMGaVTz/GPli1Z53057k
	HJnWJP19js=
X-Gm-Gg: AZuq6aJaWH+I0vsx325ADEnxNbABVkPywrfVLOzNMJTpKcZbAryjkUoj6oAjIuxNmwG
	F/4AP95rlM/Z+VPZX3skdC8GpkcT11qOEaAuQii8OWmeLz9wpIEr4rWcmnDuMy0UtbpwBlZgdRk
	Bzd+lQ4uDKDYKsudWhsawo5b2RgsBHkmjLM4QeKHcpg4WLJPZYnb/41cM/VvPH5edv4zRfu1pFx
	OO79rnDajIXoFOxF/U3Ro9baY45oT7aGWH4WaxEtouWoyVgWRK6cHfFRhyHQV3w0zhBx7AC3gks
	nsOjSdnI8V8LaYbson7DF9iXL3W4mc9v96lYLqZWgd8anshmqUxbO7mLLRRkYI0jgFAaLSLOouU
	Szcx8AFuTPCfvPu+T6fbue7sphgNF6+IgI0GiCSQ7AwZaJ+QplhwkqZVDqRENkzf5UKfzBTbkR9
	WSpmHDTJv1LlCw/YLFkNiyN+YWLEghVOE2iBBFqmxlEw==
X-Received: by 2002:a05:690c:c145:b0:794:e463:d090 with SMTP id 00721157ae682-7952ab5a383mr14128817b3.58.1770331517444;
        Thu, 05 Feb 2026 14:45:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-649f2550b56sm61185d50.8.2026.02.05.14.45.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 14:45:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6582edb3894so1872248a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770331516; cv=none;
        d=google.com; s=arc-20240605;
        b=FK4nUr9LbDcg5cObITBBQ1LjhnPb78S24FfA4l7BMcUzo2qM1NTKJ7NDavMXAvrLqN
         pGH8bsz+sPb3IzbruDnEpZipsvu1um6cgcWcS9+4AciFgQrh1zKPNI5gIMEVD5fvswgI
         f293zpd5YG9BFB9EwSB9OmCV8fc3hgsegOZjjBqq+v7aagtoh4sCZzWzUowaGHLHCwAl
         igV3E8l5t1U0Vg2HBrrKvozs+I99g4q6BtEmiYhxTbKpHSN4I7mnR1XJeJjKoCfjUEdU
         TyJgibsznKUXUaAXW17BenWBMi+xAELtCJigmSTYnbuyLwhq/OimPZs1y8yvqbDRBuKM
         vb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bbY1rzn1bTGNc/7qf0VCX2u0YgB4o0kCgXZlRT67/78=;
        fh=zw1rrNXYGOVG0HgMzsrhyQKyTAyrdgEeqICVjehQAs8=;
        b=F2iCpUHOctOPGa7nL5J0p7hKT1pfzsxnBMzMnuQ1w5+4OdtaW8vqlMX450VZRYlucU
         yWL7DovwzZMpnXVvEv+YTTF6WC4AxWMFI7xbQdGqMGZ/3wpx9avJcGF4QX67e/meRpmH
         WijLIiMb8PnfZIuNmmgx9Wnb5w+QrU6821GpWdLT7qKO9uFO0KigodcKums9Rwh4bjmR
         mS5YPcIMM1l/MgiieRKyKm3NeJWeI8EGGM8Y0TX7X0ZpB6QN+t1KkSZ6HBS7kHqFK0bG
         30nX2svMa4RsDexMKE273Cc6+jVWyrtKOU27YHCr6wQbMcZ+HZ1RewvcbMKMGrtaBaa9
         hPvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770331516; x=1770936316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbY1rzn1bTGNc/7qf0VCX2u0YgB4o0kCgXZlRT67/78=;
        b=TvftkYF+WiNjs7CRrpeqOQSo98CAG7QDTyY8EXXElra2Bmf43XVyanRJYhRtExdhWe
         lGiwR+U9bpV2VUV+3JVOV1K5dQ0Q2dE6rtJMR69sjlez++NFZYnN4MQXajoE1xu/JSEg
         oTrK3jejp43hjCWUvFtkSrqPuO3X5Z3+//09k=
X-Forwarded-Encrypted: i=1; AJvYcCWSMu8BDAWfjbVFhZhjYePrAWORyU31+ds3jPmVlI/2C4cfwWJokONu3Oz9cWPMTZp89T7IdQs=@vger.kernel.org
X-Received: by 2002:a17:907:7f8a:b0:b80:3738:2f11 with SMTP id a640c23a62f3a-b8edf1782ddmr33592766b.13.1770331515533;
        Thu, 05 Feb 2026 14:45:15 -0800 (PST)
X-Received: by 2002:a17:907:7f8a:b0:b80:3738:2f11 with SMTP id
 a640c23a62f3a-b8edf1782ddmr33590966b.13.1770331514991; Thu, 05 Feb 2026
 14:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205220541.2992807-1-kuba@kernel.org> <20260205220541.2992807-2-kuba@kernel.org>
In-Reply-To: <20260205220541.2992807-2-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 5 Feb 2026 14:44:53 -0800
X-Gm-Features: AZwV_QimaC23pTcmSmt1ce0IYHGrRHclQwJRgHzSmLFxDhodjo-7112kLG9KJ_w
Message-ID: <CACKFLinY4qNTf-pPQZ4R3efm8F4EnAiZsOqPknLcc32qTaiHUw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] eth: bnxt: gather and report HW-GRO stats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	willemb@google.com, petrm@nvidia.com, donald.hunter@gmail.com, 
	pavan.chebbi@broadcom.com, linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000271531064a1b6dd8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257346-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: C92CBF82E8
X-Rspamd-Action: no action

--000000000000271531064a1b6dd8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Count and report HW-GRO stats as seen by the kernel.
> The device stats for GRO seem to not reflect the reality,
> perhaps they count sessions which did not actually result
> in any aggregation.

Yes, the HW count includes single packets without additional
aggregations.  In the driver, when we see only 1 segment, we treat it
as a non GRO packet.  That's likely the discrepancy you're seeing.

Also, for completeness, should we count LRO packets as well?

> Also they count wire packets, so we
> have to count super-frames, anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

> @@ -1804,7 +1804,8 @@ static inline struct sk_buff *bnxt_gro_skb(struct b=
nxt *bp,
>                                            struct bnxt_tpa_info *tpa_info=
,
>                                            struct rx_tpa_end_cmp *tpa_end=
,
>                                            struct rx_tpa_end_cmp_ext *tpa=
_end1,
> -                                          struct sk_buff *skb)
> +                                          struct sk_buff *skb,
> +                                          struct bnxt_rx_sw_stats *rx_st=
ats)
>  {
>  #ifdef CONFIG_INET
>         int payload_off;
> @@ -1814,6 +1815,11 @@ static inline struct sk_buff *bnxt_gro_skb(struct =
bnxt *bp,
>         if (segs =3D=3D 1)
>                 return skb;
>
> +       if (bp->dev->features & NETIF_F_GRO_HW) {

If we enter this function, NETIF_F_GRO_HW should always be true.

> +               rx_stats->rx_hw_gro_packets++;
> +               rx_stats->rx_hw_gro_wire_packets +=3D segs;
> +       }
> +
>         NAPI_GRO_CB(skb)->count =3D segs;
>         skb_shinfo(skb)->gso_size =3D
>                 le32_to_cpu(tpa_end1->rx_tpa_end_cmp_seg_len);

--000000000000271531064a1b6dd8
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCC+lkX2
skH3fubBx2WMC1HPy2tO8J7ESm2i3NEqGAegoTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMDUyMjQ1MTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcKIuwt1RcjLyIg9D3V0DConnZFYavXQeaIuC8JvCr
L4gJube+93u9LC8HLLc2R+XOOekr20OUFRvG7TIhqFBZWs/EWWvPc3rzHwF7ej1Ofaqc0Sv/8hSD
cDMfcFy4eGwWF/2+13qDQu3N3VB3v9Jj8ZDs6Swu2vNPAMwLLKSrmf/BbzZlYDerJQvXcG1hWKFe
HgZmjstMkHyQZdzJGGYaQLIScFKIycI5GpLxe5C6rcFy29sHWvqYWauKJWIz2mU6vo/NCnX0XIcw
oW51QxaWiwCeoRAtKJHtgy6WUOXwOzDdyDfKGqEitdsGF/Q1m1M/qckf82DwgPZu21mkT0Fz
--000000000000271531064a1b6dd8--

