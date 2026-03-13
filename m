Return-Path: <netdev+bounces-267560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O7QIitZtGklmQAAu9opvQ
	(envelope-from <netdev+bounces-267560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:36:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF72288CBE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2DC307D7D9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689B35E94B;
	Fri, 13 Mar 2026 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iKwfE06U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A3313E3F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426982; cv=pass; b=TGDqBOtDmEC/Nc8j25/cY2HBWk7ofhYe4QxlRDxoCg6XYqAgOzK2LxzxXIrIIKyjdlgVkI819LGEesrPE5akVEfn7bc2uldD/zDVipoQNuB8WC35ZYembPli+3j9Z5o1xwIKh+z8xltWidqqzTMGOFvwmmIz3FX6w293zp9+aHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426982; c=relaxed/simple;
	bh=7BBG3vS8me8MdAyRUv8+2LuWJKYptzAMjSon9g2SrYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWP9H8oYa+egVAI4fe11428WwKk9S8ZbAJAUhvpGRGZFtZxdO2VAboTB5dHXdNONDDPSfrY3x5q6O+EAOPhRhayaRsj1MizvxSUM9XuAzOaZBSUIAc4XR2mcn7bOTHZfIa8Fy7lcPqnthcjd1G/7daG0KrcLkn+BKR9ZP7WI2SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iKwfE06U; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2aaf43014d0so16707995ad.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426981; x=1774031781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BBG3vS8me8MdAyRUv8+2LuWJKYptzAMjSon9g2SrYw=;
        b=aWQv9t2GF8HwOcTGo+bvEZijkUv0hi2P0LvPnbrW4H0DJr0kLtgfaY9L4ziBmgTRjr
         U9+OHneHG6m9KX7fHVfAhU+6hFEu7fEP+cADXWPZoEeTsCBdVFcESqFKAQvur8Hrzjzc
         1SzWAp/ghsDll8j2pjmLmYogPdI+a8zeKI5zK5iKntQ9hztqANTdnZcp2o7tZslqFOmJ
         9SGbjo+AUI/DY7WD8PX05nOwQgEx7yJI/oA5OtAi+fWXLmm1cLWJP3K1usT17NMV9Gs+
         Bf0sGHt3mYaX9hdBGg081sMc8AO0b9k9eCpDOMP0cnev6B96EBcI+WRBm7hPIzzRDjw3
         t9sA==
X-Gm-Message-State: AOJu0YxouIf9Iz1COjLEbKulEAuE6xK8Xj2rAPVJVdpLo3XmTOqTxPtJ
	09/kOfdIEn+KmOBYs6ZDZrJW7ptiERqprTGa6QggTk8Qka2/k/z5K6FbpnOBN1Iv1YlrxYjlq+p
	11kBkgctYgr9R6MWJcV1jzzuCExARCrnNOLAAGtqm4X5jDZuDtBEMz7nUrRzDEqiA7W9dKocYgQ
	yxkQFrsAzIjXhYQ7RkrX7kfGD+Pop2NFJ/8WOGja4M1/i3lDMPte1eaTsGWz0g0Rr8viypAkSDo
	GlQEXdULdU=
X-Gm-Gg: ATEYQzwD0768mTCRPT7sB4i0HT465fTcer1TVDAVxWBOpfSFxUy9QRRz+MltAEI5BHV
	1S2g22gxSsBDA/zmJoy073dsPnUX2dLdtnC+pV1Ei5FmErnxHtGtvh+0CLzG/yBD+58+OOTUAYd
	DekIoLVwsjn25XFb5AZuP5EDKrwe+HoVF0lesphG/QbrK1EhpwridTRKTbrKWOKKlyy3OkAM3mX
	wc8BTEr4uGbaz9Zoxq3Gtlddrws+6ykKfKmTPQkjuhPK75jADQaqfOSc4/xU8BDnIoJzaywAmuH
	FzVabYA6uwN0SyffdRGqdF6hNfSeySYORYV8Wgxhk49FLVMXjBGZMybDKEjNNuBnJtEnfH0tU74
	pzwmoNbJ69/bVDqVsdblH3bt3EujxtzQQEpuPoQnvkQTp4Ieiqp69PJ7pYffO1HEpae8dQrVlwK
	LpBOhZp3ncuAooJzCOLEz+h3yhlTRZF8Rn0pfzaSMhh+CyCdZlUm2ShSHy914=
X-Received: by 2002:a17:903:240a:b0:2ae:5b52:3818 with SMTP id d9443c01a7336-2aeca9412bamr46309985ad.8.1773426980673;
        Fri, 13 Mar 2026 11:36:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aece58c2ddsm3250655ad.5.2026.03.13.11.36.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2026 11:36:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b96e8e87061so296246066b.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426978; cv=none;
        d=google.com; s=arc-20240605;
        b=hbSggq06dFmKp3SrGFD2BCuzCLGu56vRBBq3uI8dJ18C1piGPzur5c9vjwiA2EJ6db
         ZC1R/P5spA8leHc4ZMGFiTTpcNTkYGm/lTKZqNfX5a/F4naJ67F7lcXPAZHAg3nsGfCR
         wCeS0OjO1dCX4O2g3+iXgr3gKQGZHe3qNvlMGNJfIRZBRuOO8zI0kKxby2uEriS6OZYl
         TD4rgmRqSEELom3c+6VwZvvDAowYyaBi5cCN8IwVBtjfq6UoIoTcIDjTCXeT8Z1VRFGo
         xZuyGJwo82BLR6FMelTaPpq05Qu/WCpvS7GbENeST9aIBbSPHc2H0k9BgBF+E8FirKNR
         lHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7BBG3vS8me8MdAyRUv8+2LuWJKYptzAMjSon9g2SrYw=;
        fh=52vG7AKpdfmdN/ZPQwea9Md6DQhAK9LLP5b2E0/9jxY=;
        b=HePy3bo0fxltf9DmQsAsWQAF2gHquxC3vcssCtMmc7XCEFaryzRI9SQDzcrAKwRZEB
         Pkm8DuyaluX150Q8TT3rPvhq0kQn1DjsEhp5fQX+WR8yfn3Sr3stQfO36XM+YQpBHhpY
         QUNMGXGPmFMvNFBReTH45siJ4c28x2ac4fJgouu+TYNUTMNR8mhf/ZgdJ2fWhdEDqLnq
         h8cVKPvn8URQZpSEl+70SMsebQkfyCqucZ71Yaygl0mz1shsa40A2Uv+QSbQ4whvbiTc
         E5z3OoSgzOgnysv4//lKEl9Jaie9EAfcHNxAlLAOKz6BZ9Dmai1h1R0LKx+vYBv875tR
         XkWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773426978; x=1774031778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7BBG3vS8me8MdAyRUv8+2LuWJKYptzAMjSon9g2SrYw=;
        b=iKwfE06UcDkp+SLRw/CXSis828I+lp+FRgtuogcUcoJ5NDc41Elo+V+t6FG0Wf5kwZ
         +k0vWVBbY14aV8gQjQ6fUJOaMPJmdmjZBd8iWc3TRFVZN9dR0uC6ZVL2FW7sXT1WFXuf
         csZ8sgZP7jVGx57URci5vrAQYNji/YR4ahmOI=
X-Received: by 2002:a17:907:3d87:b0:b93:5fa8:d7f9 with SMTP id a640c23a62f3a-b97651e7167mr282683966b.56.1773426978434;
        Fri, 13 Mar 2026 11:36:18 -0700 (PDT)
X-Received: by 2002:a17:907:3d87:b0:b93:5fa8:d7f9 with SMTP id
 a640c23a62f3a-b97651e7167mr282681266b.56.1773426977880; Fri, 13 Mar 2026
 11:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313145113.1424442-1-sdf@fomichev.me> <20260313145113.1424442-7-sdf@fomichev.me>
In-Reply-To: <20260313145113.1424442-7-sdf@fomichev.me>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 13 Mar 2026 11:36:05 -0700
X-Gm-Features: AaiRm53PTVHUxfoPVRge5iG-03ZHEplsJtlhKAi048-tzF_nLTAgESwfbhz4_VE
Message-ID: <CACKFLi=WRRnJqBqenwkFb+gjrpR6Y=+sz6qWbWcjAyX4tQvj3g@mail.gmail.com>
Subject: Re: [PATCH net-next 06/11] bnxt: convert to ndo_set_rx_mode_async
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Pavan Chebbi <pavan.chebbi@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b4226064cec25d8"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267560-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEF72288CBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001b4226064cec25d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:51=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
> bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
> now take explicit uc/mc list parameters and iterate with
> netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
>
> The bnxt_cfg_rx_mode internal caller passes the real lists under
> netif_addr_lock_bh.

We should now be able to call bnxt_cfg_rx_mode() directly from
ndo_set_rx_mode_async() without deferring it, right?

--0000000000001b4226064cec25d8
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCEizWQ
SBtJ5RyPAJPKs6jYUwdTPv4usa4pwNiozN6r3jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTMxODM2MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCHcb/PTkeFQNiUQqS9i4xCw+woGyxVbURGOL1kY0pc
K1RUPX5/o0oLALFqUWPHya8MynQxftnAtM40JefevB4OnpA3j+PPh/a8OdepZI5ebG9bu4KEZNqS
WLBaMA6RSuM9uK2hZP9IjZnb8HxYTl5lMvUTTkixws3/rRFoDSBe35GZQQqezxb5IQyuHvTEXaL+
r1VuSzT5VwBt/LwvCIGH6UgqD9YAUJwpbrHUQRtxkmLM4jtSxGkMryvlL5BJ9dL9YvAyQQ7ifk1x
TclmXtKdT/42yGDIPEZmZG8qunQAFGLj3HYVn8AM35qCpqZekNSJiTbvamBuEc0lUwLGrl+h
--0000000000001b4226064cec25d8--

