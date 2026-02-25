Return-Path: <netdev+bounces-260780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMSpAemknmlPWgQAu9opvQ
	(envelope-from <netdev+bounces-260780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:29:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C06193734
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5753D30185DB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388A284682;
	Wed, 25 Feb 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YO3CE426"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E73168BD
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004167; cv=pass; b=KOMtZhw9U2g+FSdKvQuRreQ2yf+jP4QBCF+YNbA048sQck1ZFlB0L5OyRVjhvQpP2Qd/qEGK+GSMN82qyMzC0CzLhFTEjHuAW43vJXoarqnQIcAsGMSCwLb9271eZoSSjy7EAzKyVVIUoOz5b/Fmz1e3Daxf/PjsdM4Feij3IQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004167; c=relaxed/simple;
	bh=kcCOke7AKs8Q0vYpvyLjv6oOcBirnl4D4CZhJtJydjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m//+2rcOpWzRjuqsKV7CmCdbxNuD04VqmVEf7DjLurBszzJT0B5/8+QwMO2moMjiMysxHx2NgPyxN6ySKEiIbz6mGP4LYOs/+Wj5TxowKbX/DJjdeQ5PsrqsN6mPaEpq5nDkMLZrMkW+fubJSq4ER8UyeSmTd9AXi+7i1koowGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YO3CE426; arc=pass smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3562e98d533so3763477a91.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004165; x=1772608965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiP3vg40wwPWv4b3jwsoeX614fc61E4zjp0u46sRgsM=;
        b=YgrHOKpkqYEyoBPWG4Lqg+0war/dU6Dlwwn7Bk7yHHLUz5znht2V9Ju1vbgvUBv67A
         s9EWyn8pR75gskpZZZ/QTac6nGrOGh1uEq9RDoXml/dIq83lWL+ClzYC89DNIx/hrnt6
         0zxLLYTc3UdhYhovo8RYDF0pmPsYGjOx0CKRNoQXvX0VTPpyDj6zrxQtbVH112IboFpx
         s7xsrs97nc3pLulLN/AeARV8+6KOEbP7McqTB9QT1ow5Y4/Eu5CBzMbiA+GiOgEg03Nx
         nU2H2FxA8051qMIo0OZumkRb/sKnhFuBAtkglAqG5aW3grldFr7q1/m46JykKFeMH6qD
         sP3Q==
X-Forwarded-Encrypted: i=2; AJvYcCVMjFh7CZvLjs2Qr94IcvxNWKSxnTO1bcWXtbS1rN/CXKQ1NtiqqvS5DW5Ms20rSDj6gI8cQhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4WWfWTcSmTbkIuxFompnLU2B8+qTCiVtfnjkNw9gFKvvJJ6K
	DX5KIZ/6/kZcDVml1tXjQ9TiOI8Xu1OWpEK2CHGXeygzDXS8Gp5q1ejtli2w+bSsFkQOhuUZWgc
	gJ9VYq9U3tX8lVeaPZFb/SMcsjRT3LC84u4fK/r6KAmlCQvBcrohZSdLkXTYp9yrH7ieuvYhDSL
	KBvLPmPon1J3xW2OO+LDVdrQV7oW97DM4StCO9sH/tOmV6wtXZBYaDhjvuDTyvkSJaV5fLB6CPS
	YC9+yxnWg==
X-Gm-Gg: ATEYQzzbewQIEtiGwYGBV4A9Q3yyP2noG7Ikw5jeakKv847eDWKVV+fJ3yz1/SUkEOf
	3/MLvyZmmxPecU4+RP+koV1Yt/elWSG8GCD/8goGmT7g5ZYC8buNr6d/7zbz3qMggg1GFyz2g7W
	xbmebkHDQNNnZOhgS5pkHYAHFpFVYdxNoxFjs9A8p8X6X7e/2Db3HJAB1Jk1nidLuSe7HBF3Luu
	KzVm+qWCYcSyOyiCmgqsxLsE/cPWP+ZFNTRmO+SEfADbDwoZpbEootm89qG5dPg470cypI2chuL
	yljHmVgqu+/wb6U20ZWE4PuQAvasmwS4gElxnjOZWJ/W7QChjs6XVn4N016dNjvpotzfPRSzxsj
	irWkkqZGXJorJcJ1gPVSqPNZuvtgZomuTFgogBkW+870y8uz7k7Og/da4zL6ZEJDMpzJuemdY/E
	cspHP65jeTx05Y/LKAqwJoNOb6KynwVfocUmlTCHqftHvU6tiap/LVPiT94A==
X-Received: by 2002:a17:90b:5150:b0:340:ff7d:c26 with SMTP id 98e67ed59e1d1-358ae8c24eamr13588468a91.16.1772004165087;
        Tue, 24 Feb 2026 23:22:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3590329dc9csm270530a91.5.2026.02.24.23.22.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 23:22:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35842aa350fso33966392a91.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 23:22:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772004163; cv=none;
        d=google.com; s=arc-20240605;
        b=JHvufybA2TVJeK2sup1eM3zRdS3N964XbQAI/mDzFH+8Zs8t5x+uRIGchxdKQFGN5a
         Fr9vwRHDASROEfkR4loWNEUVZv3KN+z8wHgNE8VT4ZQHjFoYpVQJ/nmvrhXoEXS3OWL+
         Vi6KqoZPZGqpD6/9na1unZu+IuU7OpygS8wbX4GDJMUTdryNFuYH/TEtZZGCQdB6/p59
         kZPsVvvUSA1SH22DGN+cdONiveOpWMRLojHIWMYMbYRjdE6ePffqKU6qHHCsBrJ7vykK
         1Sm2fyxzIUbAN1pKSSXtJvf8ObwpmtAM1QipjmSk3fa1mMFuKZb0asdNfmsaAGUiqiOP
         fWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OiP3vg40wwPWv4b3jwsoeX614fc61E4zjp0u46sRgsM=;
        fh=NDJluMnixsiK9EkHE8hilZfVz5MUfievASqePI5rIdI=;
        b=ko+MvNo2hu7M+eO1190LRkY+W4Mpe9XxUsEQtiDB8iMXa8STE+iowQ7shUcZhmL58g
         efhAUsrIxSFflFfGJq2OQOu6rVMn6S3wszriejOegLKICf6e9oxBhLCQPgJyvraUi+jn
         J4OgSElFu1R93SZRPQEo9rx2Bd224BoOv4AJtrlsPFqTe7FqxjdDfdjaCEXuuLntKFhU
         zjpqwHWTOkMU+KaKXEXdHWnBpNe2O9rx2e5evmE/DFuSypv3/O+5pQlCgXhKuxVdo4VT
         m1gVtmW8sRjJ/ujREL/dGVKa0BI7FNQBRvC93d8h4gQjyPSAZ28/wRfgRqnVEEseWCOu
         SjyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772004163; x=1772608963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OiP3vg40wwPWv4b3jwsoeX614fc61E4zjp0u46sRgsM=;
        b=YO3CE426yrJ30TfkB2/q9KxrJmopRZnbAWdX85m1WSLOKHV6GJ+Fl47xTT7mgDpaDS
         KhoiDlnHgqcH5fOScyT3bntmGULML4a+qjJngjyUa7IwJQPD6ux84/CGeJ0Qk/qDxL52
         SOt7GDNaUSNVKs36u1gPIy+efQBzklglhCvz4=
X-Forwarded-Encrypted: i=1; AJvYcCUlfEeDZpfPUNpdkr7QLSZXEXkxiL3Kq7eeoIlC61JqgHRs11+2ACeM471AgSFys6eEIn59Q2g=@vger.kernel.org
X-Received: by 2002:a17:90b:4ad2:b0:354:9bc2:881f with SMTP id 98e67ed59e1d1-358ae8db465mr12323575a91.28.1772004163371;
        Tue, 24 Feb 2026 23:22:43 -0800 (PST)
X-Received: by 2002:a17:90b:4ad2:b0:354:9bc2:881f with SMTP id
 98e67ed59e1d1-358ae8db465mr12323554a91.28.1772004162969; Tue, 24 Feb 2026
 23:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
 <20260223191154.2800616-3-kiran.kella@broadcom.com> <20260223135831.102f73a4@kernel.org>
In-Reply-To: <20260223135831.102f73a4@kernel.org>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Wed, 25 Feb 2026 12:52:06 +0530
X-Gm-Features: AaiRm52fvgOHRLbGi7ncGDowqe4K5AiilY3HB1nGbQz1gVxSw22Q4TOin_K-qaY
Message-ID: <CAPHeo3dzACmSJ2e5ouH5e4ZzBAJuV1zuQpfazmFSro2apaff7Q@mail.gmail.com>
Subject: Re: [net-next, v2 2/2] selftests: drv-net: psp: add test for VLAN sub-interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, daniel.zahka@gmail.com, 
	willemb@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	akhilesh.samineni@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b7c4f7064ba0def4"
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
	TAGGED_FROM(0.00)[bounces-260780-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gmail.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 31C06193734
X-Rspamd-Action: no action

--000000000000b7c4f7064ba0def4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 3:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 23 Feb 2026 11:11:54 -0800 Kiran Kella wrote:
> > Add test to validate that the psp device information is propagated
> > properly from the lower device to the upper devices so that
> > the PSP transmit validation passes.
> >
> > Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
>
> Looks like you need to enable VLAN in the respective config file in
> ksft:

Thanks. Needs CONFIG_VLAN_8021Q=3Dm entry in the net/config. Will update in=
 v3.

>
> # ok 28 psp.removal_device_bi
> # # Exception| Traceback (most recent call last):
> # # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/=
net/lib/py/ksft.py", line 338, in ksft_run
> # # Exception|     func(*args)
> # # Exception|     ~~~~^^^^^^^
> # # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/=
drivers/net/./psp.py", line 597, in vlan_basic_send
> # # Exception|     ip(f"link add link {cfg.ifname} name {local_vlan_ifnam=
e} type vlan id {vlan_id}")
> # # Exception|     ~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/=
net/lib/py/utils.py", line 238, in ip
> # # Exception|     return tool('ip', args, json=3Djson, host=3Dhost)
> # # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/=
net/lib/py/utils.py", line 225, in tool
> # # Exception|     cmd_obj =3D cmd(cmd_str, ns=3Dns, host=3Dhost)
> # # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/=
net/lib/py/utils.py", line 91, in __init__
> # # Exception|     self.process(terminate=3DFalse, fail=3Dfail, timeout=
=3Dtimeout)
> # # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
> # # Exception|   File "/srv/vmksft/testing/wt-17/tools/testing/selftests/=
net/lib/py/utils.py", line 117, in process
> # # Exception|     raise CmdExitFailure("Command failed", self)
> # # Exception| net.lib.py.utils.CmdExitFailure: Command failed
> # # Exception| CMD: ip link add link eni1972np1 name eni1972np1.100 type =
vlan id 100
> # # Exception|   EXIT: 2
> # # Exception|   STDERR: Error: Unknown device type.
> --
> pw-bot: cr

--000000000000b7c4f7064ba0def4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ksPFF8lRQaSHMJFFWI2usTUpS9gKxRAuJyHc0xlNKy4vK2ZEic8RWs34T6LcL98JR51RaKtE0Dw9
7F/uUf87z+/74aOyyxrTl58LlkxL/+1yMEHZhyn6z30LHQuA52TSp7uD3au8gu0YN+hKIsPBKVbs
dzf/bW6eDpGSwgwRzqF2BcDBOUA9U2mB2cxinBxOxCVbYRy//Q46OuAx0pXw8trIkPDdp8kHAoWD
7JxJ70nrdMy8VRmC02NQp185/6szeMFYLA0CAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYa2lyYW4ua2VsbGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBS/iTArBeV9hFyyktvkwzGbaKne3zAN
BgkqhkiG9w0BAQsFAAOCAgEAdavxLwcm6Kj3S7/bA/IO6B6MTHIndKyB630T3CTPeOeuHV7ZS4wr
rDZbrSjERD36308lnaXSESlcu8LX2SKJ0KqNM3VQNTawSKS4wMXlyTzOBfaslsjtFiT4jQW9Py6u
6nf1EVoQ6YTCGJ+htyKqFgIljJIdBBOvXY+gECh/DC+VbLUVK9CgZLKkFJ5udhYvw1tOc3zOXGOd
kwaK7AtwRSLgNt5RSAaikL6bvU1kUWgITNKKhBK5F3CNUbR0hD/i7yG6Afdh27V1T7FEdV07fBbu
3+AVnAdbZmHfnB2T8lHTaR9GbgkF6lG/a8I+eUG5NPrDEM+afXT7/+zOTjf799qoyhMdfgp90DEW
9ukfyqfUq37ctBG4TdnDlxtkwy9XYw0Avotf2lrYy+6MYjt3cZFF+AF/F6ANk+Gx9zH5gyeUlruJ
+aqmP1U1lX/n2YEXAfiLJulbb3Jfi8lvyYzHXpHLIFtLfyVOzUXdGdj3dVxxFSPJ4uXmpk2SLExM
W7+cvJ+PxSJyWK723U609whQmqbVRz5B49CjNt/exjWtBGGjCwLPMGNWbHbwtDVWcoZzE0KoL7EK
VPB0t6uom5ElZ+qieZghO80tR/MW2eL8i+EiVMwq5GF1Ni3D6uypwZYqgdicI0YGj7JCgrIzr1kC
xwtQkw5ij2CCUWXxadt/C9gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
AgxbhXTUwXZ3dIWSpigwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJ5rNyl1Oass
pbua8vrWXULtscvVVv7ot6ZObAFSQtb0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDIyNTA3MjI0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAK5icjnQVvXajQ3SuijyhKOP+ZkoOOr7eLsH6IjIU4duarer
hjoii2HQduPMDdEpTEW17bnM66/Xq4p+qWrmIMmsmN11gwWnkkgeTYXtqxxop/Q1i5ZoW6hK5iWd
eAub9f9HmPkwSOFEOVnweV+XUfTjOmBPuQQHreE/QfqOK1c3YvMnOLiKHZj088b+3LCZN+2XmY26
LrGBP4SfHnpOtfa0nMkfhTYDUJbSqNGFw7YsL+nEVMUCmY8XdADQ6sxGsnlIkjudwvJdT1U+2J0k
/aQyQOp1lt5oogY0vQigszqZmuUxUfIgZfIwNd4GCcYa0UF6kAKynKKW4lVjKm+xJ/A=
--000000000000b7c4f7064ba0def4--

