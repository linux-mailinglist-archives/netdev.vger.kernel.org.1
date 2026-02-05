Return-Path: <netdev+bounces-256975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLGxGuUthGkA0gMAu9opvQ
	(envelope-from <netdev+bounces-256975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:43:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5124EEC80
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004B330115AD
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0A322B74;
	Thu,  5 Feb 2026 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SEQAn1eu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0913B284
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770270133; cv=pass; b=V8a0bmtesCNpVQrazdBTVEh7fmRD85nmCkKTMqKGuQGr1KR6r4ZQkZtEyTpOewu7ekuvT6hoPMo2YQgJqBn8+RzVwcn35BdRCRtZPNmn1n9u4RsXjlXiuBRepB4WQQ4oiMdZ3CrathKG6CWvG70aD2RGsaRrvPXM0On6v3e8oAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770270133; c=relaxed/simple;
	bh=PfGnfMSnMrn3XtBhGZONKdpAujwo/Pb+USynCspl1fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asyp+WhcgWq/gQicPzU1jAFVkKsLgX3lrnxUiwlBJoIv9TgUyuC7o5fTLrawDN4sG0rvGsFqkH9nHohHX4N5+qSM9oGPao5vh1pLgO+0JgBuMcF5tL5pSc152XKotLstNOmIw0NOpncCUMYoPwenOl6St6rwglII/lO+K7ovLo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SEQAn1eu; arc=pass smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2b7da62b487so972128eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770270132; x=1770874932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzQ+oI7MmyN0+yMWxbHmESyNXZ4Lgf1FRmJB/x6o0lI=;
        b=H3apipthUxo3VFchcygKwKRqLNrOBcM/NX+suQGfddlC6KfcuPjTTsGwL5vmPSo7nz
         8phIW4dIrRZmkLpd5XUe8qNHHXCI7h88yWDf0hbxUXjrU82HYLLj4vhLpBDKiL69fpWf
         6zFShCiAYfn3rqJPJGVRePMh75mPNucI3EcV6GilKTptfdXzZIAZchk1F5eJpGcK7Ser
         6ZITAlxAphGL70s6+SSobMpkS3AlaqEAGAor9iULqiSSv/ld2saW5dOqxRkxFLyxe0RY
         67KlXsjZCyrgd531H4F42cXSTanFjA39SiLuKtAFlbtTiEMEXK6wqd7to94V6l5RyoJT
         R0Ng==
X-Forwarded-Encrypted: i=2; AJvYcCX/EefWE+YfKGh0RTss4mjfjqJat8KYDisSQ5tOSbMqKKE06TH+B66u7lXueAPXclxtUwEgwEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsA03Ml7PFOrcdHR+rV1GpNII4DZhZ+JZSKzUQmW6zyssr9P0
	wLXGRmlCRh0xp234b62geWcQHG+b1otNR4gs5s4V3mi9iIj3tKZXPaAzGNpC2+OeDQf6JjX9pOt
	NWBavoExY0zzC3RTYLRwjJnaZVqUeNkCKvxcYwB3euIigAlYQHm3PXK/PHgSBU2A/ToxQwLxVxE
	sbYpqrH2QJuYc8rf7nu7jsPTBifyCPdRUAW/K0JoaTeMZ6YVsccSpTbWcg7aLzyOmqa8TGhnHJN
	x6Hvm5L3UceKw==
X-Gm-Gg: AZuq6aIbrH7afEzrwg9CwnSd6EWdG2FjTKJDnNp4vdgULaFhEaEzT2O8nIv6y41VXsR
	nVEVkz7ZYmIkaXGwTf1eF1L7tqClHhYVYtuuYDFjgu3qq9i89bNaD7aNiBw4QkVVt5YqF83EKjG
	yivvSg4p+qeEDbOtjLAt6Ilfd26PLTyHo6VA61QtW+cqzjVDoXTUPvfzIXfDIR0hUFSmVJImkEv
	wFMYuZOt9PEkrbg72id421KeyAron3zSoMHukH/Lk/CGPuhFiYAL/TapkwJKO/ibLYROB1LBzpH
	Zwp4/OcCEgTMwHZOo+K6//8gbYoZRKmbvm62kzwZb/yq9IgFazdyuS1IB/DaD04/2OJZqkg7l+M
	o9E3rzLFKDrbSgLaJKAZbUztfTCmqtcTAGOzr8vrW7meLH2ivIeBqLuaukq5fsQVbfckw0SwiFU
	J2AjISu4FcSiMwPfLPsV4wnQ/6K6r9P1kLO7vv9HKhlg==
X-Received: by 2002:a05:7301:6785:b0:2b7:2bf3:ce05 with SMTP id 5a478bee46e88-2b8329717c3mr2478072eec.28.1770270132018;
        Wed, 04 Feb 2026 21:42:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b832eb0b65sm574123eec.10.2026.02.04.21.42.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 21:42:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-353049e6047so385311a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770270130; cv=none;
        d=google.com; s=arc-20240605;
        b=J/B3Sgd5nZfvtfYH11AnonUCwmejT8qKmtyz9Orlp7im99LIzzJIj3K4I2yRdinypW
         BB/4E5l/edrJCZVlMZLnVJM6dye2ZK6inztdOb4172ScH8yNHAPvB2QeqEnmaWOiyhKZ
         G5aCki4Q7uch0BYNy3GZ60VPmJjNklHsp1pPyQmVAMdnmMtQBp2KVm+UqBAXZG6L4Gd1
         6t9TN7nqpgwwOCH6HUd+a3A0R43DxAjA9uBaQ7Z/BwuDuBbVXvzYPUqqaQLzkbBAPt4C
         vsNfTuWvsyqWX92892iW6S4jn+qVhADWxWD8Q0f3TtIQ8GqbS/O+cQeMJchG5LclNG1o
         x/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FzQ+oI7MmyN0+yMWxbHmESyNXZ4Lgf1FRmJB/x6o0lI=;
        fh=LJODaCnmtd+Fkr46iu/4ySX55dVNoiBG89QBcPB/Hro=;
        b=P/UY5rcFbYElMpmoiNz6dXV+rp5AuNQnohb4UhoHAo8V1K3a7ha1l1DFzwIZqSYL01
         qldKeCYQ7EgUgQJNP/grOaTSjemEFZD1gmKAjdBbQB6UrNW7kh/+nKeCA1MqHBLsFOrQ
         fCAvcSEwvWZKkxXdoYJsDjEcLvKbKkx+9YZJ0T1KCXolRjg6Ma2KrEAPljWwOdQ4pVvE
         jenD1znOFYMUrBIn3Q3YzwGOmAWjAVEx75Zm4G0UAjc1LBc+J2QEFwmdFendXVRs9azQ
         zyFO423QO6/gL7kmswdSZatlnVy/CCEmovnFCQeonKDGoSP0m8RMryPVR96lyklwgyN5
         RtZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770270130; x=1770874930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzQ+oI7MmyN0+yMWxbHmESyNXZ4Lgf1FRmJB/x6o0lI=;
        b=SEQAn1eutvKQHYjLDb8hcWC8usZeSdjVcJP/y9SPMJSoWsGkjyJ8m0kgYagBj1Vt4y
         SBt2zdCHGaPqQe4FwCY2J9dUnO2GVql+QL+7tpOqoLWQ5Uwwgmc/vjjkbRWzLadrL1Su
         QQR2QUHtGk12z8wUK46G9F1lMEZ5PIu99xBaY=
X-Forwarded-Encrypted: i=1; AJvYcCXb6xY/m80VYnJVpvn2JcAvRU1jpBNb7ylIfBw3qEwOJrE9EaJ8RMcdAFEtQnlSoGHv0CU5rKg=@vger.kernel.org
X-Received: by 2002:a17:90b:2e0d:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-3548711595dmr5207358a91.15.1770270130134;
        Wed, 04 Feb 2026 21:42:10 -0800 (PST)
X-Received: by 2002:a17:90b:2e0d:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-3548711595dmr5207347a91.15.1770270129799; Wed, 04 Feb 2026
 21:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
 <20260129061646.1417185-5-michael.chan@broadcom.com> <20260129180320.1c69a0c4@kernel.org>
 <CALs4sv2c9QaRtrV-21YsRsGOkap5LnGPcqEnk9ELn3WcUocFOQ@mail.gmail.com> <20260204180902.00918071@kernel.org>
In-Reply-To: <20260204180902.00918071@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 5 Feb 2026 11:11:58 +0530
X-Gm-Features: AZwV_Qgl8Ee4r6v-HyDW_2VAdi2remOl01LZcbh_13e5vku-UvO7-hakxbcNKZg
Message-ID: <CALs4sv3SE9TSQBBaRaSOXrUjpO0+V7t6gM62qLKhrZ2ET+dG+g@mail.gmail.com>
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000048c57e064a0d2236"
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-256975-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C5124EEC80
X-Rspamd-Action: no action

--00000000000048c57e064a0d2236
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 4 Feb 2026 21:45:12 +0530 Pavan Chebbi wrote:
> > > > +
> > > > +    for ctx_id in ctx_ids:
> > > > +        try:
> > > > +            data =3D get_rss(cfg, context=3Dctx_id)
> > > > +            _rss_key_check(cfg, data=3Ddata, context=3Dctx_id)
> > > > +            persisted_contexts.append(ctx_id)
> > > > +        except CmdExitFailure:
> > > > +            missing_contexts.append(ctx_id)
> > > > +            ksft_pr(f"Context {ctx_id} is missing after ifup")
> > >
> > > You can use netlink to get them all
> > >
> > > ctxs =3D cfg.ethnl.rss_get({}, dump=3DTrue)
> >
> > Jakub, maybe it's a rookie question but I am having trouble getting
> > the netlink call to work.
> > Not sure if my analysis is right but it looks like I don't have the
> > right schema..
> > It appears like the decode does not ignore unsupported ethnl options?
> > I always get the error:
> >
> > # Error decoding 'input-xfrm' from 'rss'
> >
> > with the below call stack:
> >
> > # # Exception| Traceback (most recent call last):
> > # # Exception|   File "/tmp/ksft-net-drv/net/lib/py/ksft.py", line
> > 319, in ksft_run
> > # # Exception|     func(*args)
> > # # Exception|   File "/tmp/ksft-net-drv/drivers/net/hw/./rss_ctx.py",
> > line 395, in test_rss_context_dump
> > # # Exception|     ctxs =3D cfg.ethnl.rss_get({}, dump=3DTrue)
> > # # Exception|   File
> > "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 1159, in _op
> > # # Exception|     return self._ops(ops)[0]
> > # # Exception|   File
> > "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 1146, in _ops
> > # # Exception|     rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_=
set.name)
> > # # Exception|   File
> > "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 814, in _decode
> > # # Exception|     decoded =3D self._decode_enum(decoded, attr_spec)
> > # # Exception|   File
> > "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 672, in
> > _decode_enum
> > # # Exception|     value.add(self._get_enum_or_unknown(enum, i))
> > # # Exception|   File
> > "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 662, in
> > _get_enum_or_unknown
> > # # Exception|     raise error
> > # # Exception|   File
> > "/tmp/ksft-net-drv/net/lib/ynl/pyynl/lib/ynl.py", line 657, in
> > _get_enum_or_unknown
> > # # Exception|     name =3D enum.entries_by_val[raw].name
> > # # Exception| KeyError: 2
> >
> > Do you think I am missing some config?
>
> Ah! I think you run into what I recently fixed in net.
> Could you try with 1c172febdf065375 cherry-picked to your tree?

Yes, that fixed it! Thanks

--00000000000048c57e064a0d2236
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAGlvqx
gku15HlsMeSbv1cF0xiJKK8BNZ3SaS9eOMtm3TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMDUwNTQyMTBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAenweS1sDiCh4aboBV6sEs9mrReLTb6UOp1nwRJTfn
Zm39qkl/sfhQQtFb8UVtWZ0KdMXSM0K8/ZwzfsdtmstZRpLO+JfnABjdazQnmbteQGAj5F7f61Mh
aXakgqhaeCnfbg8QJR8LVGQA1qAJl7lcqERPskRDvTmDhGrzO/YSs9uBYXf98KbnXXK6dYCIP3DL
V58j1fv8ZrPf2Po9onAYzNN2kFjUaSQjGC9IqBYToMYw+b/dMdFD2g8a/2jkJAyS1S31yBeRwRga
/bMc9oCZwyHB/t7f4xuLXA2cyIs8S/Bb3mNuuwdUxdv7LFlx1Dno7DR3FCNPWu5g3zqtVp1Q
--00000000000048c57e064a0d2236--

