Return-Path: <netdev+bounces-254518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMO5MuvEemmY+QEAu9opvQ
	(envelope-from <netdev+bounces-254518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:24:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DE8AB182
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7C3630055DC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A243542DE;
	Thu, 29 Jan 2026 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NBwYNOqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A854739
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653476; cv=pass; b=WWhfpooi0XboJWiTtMUFaYzy5piJp2cfTUG2xlkpMggvMCq/EIZ0ylBvEBnCEjQ/J8auJcdjvA7IRFiQL0lEcA2N3BdY2EbddXMpBj/x4gQfGKT/2jgPSBGKw56J+Cy+38km4PtLnuT/e28dwRiMyvmhtp72Dg9kc4VWGkVaxFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653476; c=relaxed/simple;
	bh=B4fBPy3SoBOnCtokvoKUhX77V4Wxr5wfAQy7VtXqvJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VTnJupaYQlMLYZWIDD5dOiScO3sVYnockrs0fX7BG+UJNEVlqZKfm70v33XQvb/CUVnJ2Wb+AsnZ80Jv00VeKCgdiMf3GP0/II38g+Hf4BqpwapSd3b2lW1fL1gzkJHTSH6ef49FQij9pzg7v7kV8GuRdVXAG+oBJMNMrFNtSLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NBwYNOqH; arc=pass smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8946e0884afso8466636d6.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653474; x=1770258274;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKnS0V0aeHjfIVu27rJcISLs4Gg0AP3DO9muSyKwx98=;
        b=gc9+VlaXvFCPt2kGuyTVivsGwKwXrcvSnNQfvcLKbYJmYwWxOFc2fua09Wj5xPQ8ve
         XMT4raVv+SS5z2XVdgrKQ1KDXsGonZ7r/97fzS/DBWi5LFTtsr3p/hqDq5SCC30EEDoY
         moRhuSZtoXtPFrZOBUByNO3ETERvA3EnfmaqPbGOcLQcjnlkqS+lrvehPiXBdS8t5xe4
         NFJWo0WDoifuW2bJxhglxWAJX7YLzLN4Zw9qlEO2K/Zyk3VWrsynbf7XjkKPgOHYg50m
         JyvKrjPXM+dW+RSKjcgTzAZmOPGtCTMBVCx1ywbVCRW/uSSIjfTZswsjbvHLzq7nbUuc
         ow6Q==
X-Forwarded-Encrypted: i=2; AJvYcCXm2T76pr2eRbKieS0g3+w+omtfutTEyefAXmYVk/8dhtGWTw96RQ6THuS5s8gpgC5pTkdnPO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlDa0FKXD6uFEf7lcpHtXK4vcAQjqwSb50nTGmSEPxUsSoPye
	u580GXGlFp12Oq81EU5efkrMBJu3UBuCt6ZFuM4OKMIJUV4x9/41Nr3iKkQyON+tMErW/IXfiHU
	e7uKwB1u87UfvUnUHRdfy9qaNjW/Nqkz7lzdowWw8huLNYbIvY9Yy+ztOCQU0TK0LyKwtzg46fg
	sANnrNgsa6Y+iitjVa/3Sy+i3juONOFpWSQK/JZuyv+qpUL/ztUcDO8BirG88/rbsWH/oc/y4rh
	o02VOsMwnc=
X-Gm-Gg: AZuq6aK/RmE9jj7HCNhYF7h6fcW7+Trox+oF1Mk3tv6fl14PeQYnx0pgUfaR/Txx9ws
	ZFODEa6oDx4lmLqKlsxPCBtOnVpRdQHJC21BvIfX0TZ/BOeLgrxToScSUnvrdKhdhkcrim4YU4L
	uJJCo/8yyOTgGxIq9r/J2CfYV/j1skJnUPjrEKutlN7yryolp/QIYH479RLjFDJYN3U+LyVyJ/A
	5Nxux9xix4s6PvzsF+FoXcPC9IKrBNuxn91bKkDsHUpOk6dskTZpzFCFlWss6q95vMc3qAoAKwO
	+qh2YXC6Ri/n12l4B2obeeG0o6Vpr5kIc8xrYyXovKbty/NtWune4Wa8ldIMQeG+6CFf/h3RPEy
	visfa314Az3lAmIriyay95OpjwjsI5NJcCn44vPcQPRmkzNYf/coxg9iHuhRM4sSjji5hfrS4xg
	/mSUIaveOW0PjvGZ34ocwRPuX9GTf4C8iI6npFcUmbhVGu
X-Received: by 2002:a05:6214:c85:b0:888:89fd:a727 with SMTP id 6a1803df08f44-894cc907f7emr111485296d6.49.1769653474329;
        Wed, 28 Jan 2026 18:24:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d373e6bbsm5060056d6.22.2026.01.28.18.24.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 18:24:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8871d4f7b8so115523066b.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769653473; cv=none;
        d=google.com; s=arc-20240605;
        b=H9dQCP2UdDbw5i2WLq8AYpcwCG59wfxra2jrze8YPjjcsleMMiHED+Y7x1J27A0NmN
         6zUA7ku4xwWb8maYtDUz40UlvlR3j+/JQ7ORU2fZRz1/LHxrS+/hz9Js8hBud+vHe0Fb
         ukrMKQ7IRAlg5MroaZcLrGRqtQj1P+wpQPDzBgk8bdY5Nnvaheic54VLfAXmHaJhwjO8
         d7H766WfkZ4f2gDz06g9s15fOFeMnLzi9jijNxQDtv/cCVTuJLs/JCJZK9Ekjc2uoRNF
         yC9b1u3mP8MMJxUIkG/aFJlqVV/yMslbQmWbrcl/sPyLZ4C9pr8CV1UuVPl1WrwH3T54
         QFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=vKnS0V0aeHjfIVu27rJcISLs4Gg0AP3DO9muSyKwx98=;
        fh=prhBaeSW8kgxtKAk8FmBzAVJ4RhKeiNDS0J4lb2flWA=;
        b=D3W2li9KXaVBnbCT45ao/tVphUajjYDX8a+bflxUsJZhhA+TYQ65hL/RWzlh6zc7e7
         8ZNMxay1tndoTvrrEsGE3WiSHBB0vQFVjcAguy00r6HrLSUyVuvRzvD1HBQi6PkcOwQk
         pXYkLynQjLemAqz4KST5dovctR4p3RCk2cTy5KVxEt82GE/URc3dihjBYABZPPqUCHJX
         xhmAauAi+c2rBnaOzdHa1w1eoAlik6px9N/YL0vqL63n0wB+68GlQ/A2FRrkGiIShKCJ
         saHPL4TTOr4Us4d0eZojrbKYztSxsH41QNoBhchjG30zA88/zxsvhhsdde08bp5hob+R
         MdPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769653473; x=1770258273; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKnS0V0aeHjfIVu27rJcISLs4Gg0AP3DO9muSyKwx98=;
        b=NBwYNOqHqvJ2Zr2AzsAgN/2QexHdlv+sDGxEiXsAzj35+vW6o+IzHXalhe7wwYMzNF
         ZcT6/COHhO7UzyZ2hgDN19GqwFGQxg05YMqJAyMmUGfW4HM7MXpdU2XGwV/3TpI1IYbb
         d/kaGZNpNqquH4yEvfvsWAtqf73ldBuuGtbN4=
X-Forwarded-Encrypted: i=1; AJvYcCXefs74LQOiskCJZS+NszcDvW1obuyfo5idcXU5kI/M49KdGJVGdzCzFwFc7WB+9l0kyM4K2Po=@vger.kernel.org
X-Received: by 2002:a17:907:d1f:b0:b88:48ba:cdd with SMTP id a640c23a62f3a-b8dab37d770mr514848866b.43.1769653472772;
        Wed, 28 Jan 2026 18:24:32 -0800 (PST)
X-Received: by 2002:a17:907:d1f:b0:b88:48ba:cdd with SMTP id
 a640c23a62f3a-b8dab37d770mr514848366b.43.1769653472321; Wed, 28 Jan 2026
 18:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128222718.1679581-1-joe@dama.to> <CACKFLimN+AOBeesHaiHPZM-OFUtLNeL-3GFtLUDCdv6_RGkEJg@mail.gmail.com>
 <aXqrIXo7GFQR7UyP@devvm20253.cco0.facebook.com>
In-Reply-To: <aXqrIXo7GFQR7UyP@devvm20253.cco0.facebook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 28 Jan 2026 18:24:19 -0800
X-Gm-Features: AZwV_QjUKeU0HfPUZeMXZ2dRiz3U8_4LNeN4xrlf4gDtLZ1nMoEUZBjbmPO42RQ
Message-ID: <CACKFLikSduOjOtnPkFA=3SfWZvqfvPViKhcO9QsyO1eqt3r4Tg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Allow ntuple filters for drops
To: Joe Damato <joe@dama.to>, Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	shruti.parab@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a3843506497d8e24"
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
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-254518-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 00DE8AB182
X-Rspamd-Action: no action

--000000000000a3843506497d8e24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 5:01=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> On Wed, Jan 28, 2026 at 03:09:21PM -0800, Michael Chan wrote:
> > Alternatively, we can also change ethtool_get_flow_spec_ring_vf() to
> > check that the cookie is not RX_CLS_FLOW_DISC or RX_CLS_FLOW_WAKE.
>
> That's up to the maintainers.
>
> The existing drivers I checked which use ethtool_get_flow_spec_ring_vf al=
l
> explicitly check RX_CLS_FLOW_DISC, so it seems to be an established patte=
rn.
>
> I think we should fix this in the broadcom driver first and if there is a
> desire from the maintainers to handle this in ethtool_get_flow_spec_ring_=
vf,
> that can be done as a separate series which updates all of the drivers to
> remove the redundant check.

Sounds good.  Thanks.

--000000000000a3843506497d8e24
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCB0pwB
f2fa8mzbX4RQf0MNEF74uFKB7vj6VEhr81cHWzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMjkwMjI0MzNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAwljWFbUrOwh+KI4nOadXIsOdoIv9c//6Ca0WNhwKx
3DsPbhWB3GpzoVIu5UsygvjIeaigc+eMotVObUVN2dxtE6A0m3TaqNnuzG6lexeqPitqMYkJyC3j
fJKRtCl02Hi/mnsRjr+xgDRht1GiUkXhngg73gL6bVTkJAqcG58kuERjqBmLGOi6z63T0diczx6O
apDkaE/un/jMXD8lW/ag4kevh7K6N6s3eXCdvl8RAiQ2VGhAX8aWpn5KGY82KCy7SycRX3yjjiI9
zms1vltz39ye/hT4RJ3xJLzOs87Yabz9dmN+59hq+8hVUqM+bC/Zr6c9FBUB4IBJ6Ub/P5HU
--000000000000a3843506497d8e24--

