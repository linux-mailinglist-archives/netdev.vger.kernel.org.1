Return-Path: <netdev+bounces-270177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN5KLA9JvmmpLgMAu9opvQ
	(envelope-from <netdev+bounces-270177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:30:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 263242E3F79
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA9A3011F11
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBD317166;
	Sat, 21 Mar 2026 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gxovdEoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35332D94A0
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078169; cv=pass; b=lufHE6dH8ZJnrWn81ARa4qjIFAp+V8JBrOX1bTVJGkGhzbhleRoRmC38xgsLxXd29UdznhPYdqkp7Xq1Yo7L+wf39L4wJOKCz6udjohQTShJJq9vQoWfx3FTX/wB4Jdudy5M3cgx82SnD3f1nHG0OyRJfTNNESg/u73oPz/DLgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078169; c=relaxed/simple;
	bh=zSq70TuWWUyYyyPnOo+hxkIT112LULdChsz5gUscDyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxJ68SMf4CruTm2aSLznP85qEH09e3RX00RcSq0ZL3WAWQ7PFqaMyWX3Q73Ql26AOVdgm6JLGx24A4SYp/eGZb5Bv6z1Stf09nahUfJHTGZ+c3yCBh9zVCwscrETtKfWRGq1kmLzj2wQ81f00ajiyINyh58LPzZVKqtCALPUZrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gxovdEoR; arc=pass smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so22515806d6.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078167; x=1774682967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZJxNhMj6YFYFOKoaNOjb/9b1+uglLEgMDRBsanRc4k=;
        b=scWib54YykiXVdh/qDOg8pvPcR4+g7WNEcbv8Arl4UWeHCdnaxe3JtFCsUK4GUyhfq
         pfq3YmXPAKAl/kOGT0QCa4VZnDQaY7D8fAJVBz5qR6IxqcPFEFkHfHy1dfBqWa7E0HNb
         RQfYn5QsoE0ZB0GmZjpwnBoMDaxzZkAXpQ1WfrS67yuEa/vMpeZb/M2rP18zt5XfMHVM
         Je0VS1gs2ZYXhFeUM1ndueGxWsa2lFKUrHt9aLz0SLlyslogQWIzbxXKrUUvlftjm/kX
         rLHK2Q4gvYVtu7AUzT51s7M1cwBjZZDJlbbeNmMe3RwqZd+Oeg3d/B5Dh8twR7c3jwec
         b6Lw==
X-Gm-Message-State: AOJu0YyrZcB9VETG41zAVR2fBHJBPCDcnRyFGBhQU3MHFbMTxJWfRH2n
	mEeo6+d4RrC61GtdUf83+j4N9epjkE9zBlmo0NxF3xjIvzGWOm9E61QdS3fdchNa4TTVAceQt+u
	1pGR/HP4VQ+3IYLKE7UF0Uqqyzm3v8LhjfuLCHI4atz6XhjwdQTuqO9SrdpROQ85i/uiLgvIUmO
	HzKfH/7FNQ1LuNqNXfzqsNPl/BA9oeQyvbsWphypXMMywN3rOL3AcrMOzcUESZpCwQak71M3lNS
	ls2X37+c/A=
X-Gm-Gg: ATEYQzzlt7VNMh9bE0vLozn36f//+4I6qFSxMuf0R7YKNUInoF6U7KnKWxfmosFzSA/
	5eAH0CJdqPUiYvl5zcYCJJ56w6PTboyEtr5QE88AmeqLGNbjCj/lpb6q3ir3GwKUXxaQdoZaEd1
	IW1OjUBChRyxrpBIoeRYry2X8x9Ugd1w56wd2kEK6clmU9DygXmR9oZveDM808dzNyoSvoYH8/N
	IlsTQKSyCqZgtbhn7WXM+ckzuQbV/TScLrI64wOZNb7LcpqUYYHqdCS/c5r20vnCMmsVJ9QxMWf
	OX7j0z5gITHGsinmB3Ne67DAobO8ooqINC1Xo6L1N9scHnyaRKgAZ6Rlxi1iEOg5naquKphogjT
	lon0n1fs1Yv9LdeBCHlx38ZC7uNgdEkRdn043K2Vn1nYpiSOcoW51bJeVrGKitJIFjMzO8jR07j
	MAGLZ31NlyN5FhRW/LiXcA3fzwgbLR6bzeFbDbdnWfQpZ20smpanyO4jwfZhI=
X-Received: by 2002:a05:6214:1c0e:b0:89c:6bc4:7d1 with SMTP id 6a1803df08f44-89c85a2307fmr91547186d6.25.1774078167275;
        Sat, 21 Mar 2026 00:29:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c852f2f01sm4713556d6.20.2026.03.21.00.29.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 00:29:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a8afb2d0aso8409297b3a.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774078166; cv=none;
        d=google.com; s=arc-20240605;
        b=MstLqDdcJT2SsO1YFO+og0UEjmTgy64a+uQ55wNk7SB4J8cXnmuYhQgENKtZdwo8Op
         WtB+CoDZkRmE71/76697aAwdgp2HVl68sxNEbVFkMQQNWW9cVRL+2hisGCOjl/BXrXn7
         kNycgZQnS5gxlcEzEE9fowLHJNuQAmsbZT0/F+IWAX9HIF+b6khNdjM90LX3JA3NeWex
         AaGulANEad0PJUkve1GFO8hKbZ0XdunX4OggScJsMFAd5jk8SBve3FQHoMsD/TT9Cx7y
         oVkn5FFDlrIANTiq0rb/gu2Fae/ua2vIOWYYWG6BxLctHpmH59QUIkonThVRs6AY1/bP
         Hb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LZJxNhMj6YFYFOKoaNOjb/9b1+uglLEgMDRBsanRc4k=;
        fh=mnz4pLJSGwwvZLl2lzZTPj3f6vRMBdNyavizvnGoydU=;
        b=L/eJ5+3kNgQGGGE/1/fZgs7PLUU4j93GIoCOs5PE053HxYxKn1LHjDm6L8qlI/fKlQ
         AFMmkcjgVOVHmj+kZeQrNmwBgi/JBd5WfgRBEK1DT9YOS2IiqLpV4KAvoUkWOl5Dv386
         Q0qlASbblCuEEvkt0AgCitN0U0rJ7hPME8zNeBvDKRYAJ/pJqIIXDsLWLOl2QYUppmHG
         X+OmrqLqoVfwAECnAZHN/LqVPg+TNjQWon1xN//QZ/kbfvTiNxg9RLyhM5reOEVSYqTA
         T7ui6sPxjfv/rNlgbFxjg/EtnTgmGHfV2+MjoKo4sCOfr4PggdUJpePlmaQp3Ot5g2Po
         Wibw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774078166; x=1774682966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZJxNhMj6YFYFOKoaNOjb/9b1+uglLEgMDRBsanRc4k=;
        b=gxovdEoRn2n9OvqRoYan64yTnHluIO99x6sVvCDjfBgOdIHZFX7OqX814m0V8HKvWe
         9NWMXYnYMm7nKHDqnDFDajZRNs5kHn0B/qNgr0DzG4vIQ4uXXKdGuh+EhYK40FYpsdpg
         /yw5W1S9ikTkbKId61NlOvhsmNryE9vevf6l0=
X-Received: by 2002:a05:6a00:1705:b0:81f:43fe:988c with SMTP id d2e1a72fcca58-82a8c1ebf35mr4666282b3a.6.1774078165945;
        Sat, 21 Mar 2026 00:29:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:1705:b0:81f:43fe:988c with SMTP id
 d2e1a72fcca58-82a8c1ebf35mr4666269b3a.6.1774078165514; Sat, 21 Mar 2026
 00:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to> <20260320144141.260246-9-joe@dama.to>
In-Reply-To: <20260320144141.260246-9-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 12:59:13 +0530
X-Gm-Features: AaiRm5064TQffKl8VyUMnpILwDkty7SNzdAgNMSnLDJDcL5eYRt6aWOJlWtvX3s
Message-ID: <CALs4sv3kGC9ffaXvidfB-G7+fU_Mtiqk7m946EULHY-gsVNZQQ@mail.gmail.com>
Subject: Re: [net-next v4 08/12] net: bnxt: Implement software USO
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6cedd064d83c2a1"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270177-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 263242E3F79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000e6cedd064d83c2a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Implement bnxt_sw_udp_gso_xmit() using the core tso_dma_map API and
> the pre-allocated TX inline buffer for per-segment headers.
>
> The xmit path:
> 1. Calls tso_start() to initialize TSO state
> 2. Stack-allocates a tso_dma_map and calls tso_dma_map_init() to
>    DMA-map the linear payload and all frags upfront.
> 3. For each segment:
>    - Copies and patches headers via tso_build_hdr() into the
>      pre-allocated tx_inline_buf (DMA-synced per segment)
>    - Counts payload BDs via tso_dma_map_count()
>    - Emits long BD (header) + ext BD + payload BDs
>    - Payload BDs use tso_dma_map_next() which yields (dma_addr,
>      chunk_len, mapping_len) tuples.
>
> Header BDs set dma_unmap_len=3D0 since the inline buffer is pre-allocated
> and unmapped only at ring teardown.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  v4:
>    - Fixed the early return issue Pavan pointed out when num_segs <=3D 1;=
 use the
>      drop label instead of returning.
>
>  v3:
>    - Added iova_state and iova_total_len to struct bnxt_sw_tx_bd.
>    - Stores iova_state on the last segment's tx_buf during xmit.
>
>  rfcv2:
>    - set the unmap len on the last descriptor, so that when completions f=
ire
>      only the last completion unmaps the region.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 206 ++++++++++++++++++
>  2 files changed, 210 insertions(+)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000e6cedd064d83c2a1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBOaHmK
b35tM0gOcScwGC4XCOqx8Bj4TNkF/gqQJoE3JDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwNzI5MjZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC761cZT4mgPhoBMCj1tM3iZ73bNxuW+19BLCitxkqG
xs7q7CSgCZBn4N5VGiDBk0rl3u66tGb5fzsmw/dYgjNEYDbSEs8TquWbyRi0AFpHmoTSMtzhmm+q
6eqAdhi8i6LpkgYMbGOzG/oz7lemNfoCq0nhBAROuNU5fD1LKTZUC6SUd3PoqXdJ8Ncsc5JGRUaw
fEBBtfuplEE7QLePltzUAnN7WDjZRl262JIrGW0aZvpWcPmBVQxW8AUBRQUZBUKKi9ocnY4d9Cjz
rScuQjtCNm2SM1F0IsGCQUB62rmNZXe0lglsJzwzJmdt51KI8Q10jlGA2T4qGr3YAVZRfs12
--000000000000e6cedd064d83c2a1--

