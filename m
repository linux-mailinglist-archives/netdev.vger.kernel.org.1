Return-Path: <netdev+bounces-208092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AEAB09C42
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE8D1AA218C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BBA21A437;
	Fri, 18 Jul 2025 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N3UDDmBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087C21ABBB
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823162; cv=none; b=BMrh31Arrr7dKP81INfWGhh4GEvQXoj3iZrSdevCwu/80W7Lr1l7mpZ9qv4ZL0WOfdk9NKDgV9IjvDWAzU/3grhnKBCyT5wqbrTRo27duBAxv5TfZeESposL5ILbiD7ZqyOhCtOzXVoFSbytthoAiCxRkiYiBmFPAQuSqgZtay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823162; c=relaxed/simple;
	bh=IkVYWp4BBcxWmHyoc2+cEMQtbG6nVF7mKveCM9SBbw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tx2T7liRvENePlzLZtDCQHuyAxY9YB6tJmx8wcppX/au5uJoEV4uvRLrW3IlTpevfAZPvv1blpOuHsgMGu7UbfKsAPFOVcXq2nG/CslHrD4V4oCz98AzKWBY9ZAYqBJbDVHzG2JAFwl5h+VFOyXpv7U5MkyKnY9wxHDsJpaGgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N3UDDmBm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so18050275e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752823159; x=1753427959; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IkVYWp4BBcxWmHyoc2+cEMQtbG6nVF7mKveCM9SBbw8=;
        b=N3UDDmBmSMkSwBsX+asDnBaVFgzD7GpIavD9DTUuU4SfJ/GCbHRIr6SSR9Wwou7nd2
         SWRC6Kweckd1o9dpxf08oBnbRhansxElwztqyD8QzllwfO4RQiQeM55hRqriumJBwrdU
         PNrntYmqR7q/tAwMA7S1r5ewVrGZ6cQ1XJHmGOiklFIxuLJ7HkbINtod4uJ11zzB/60n
         bPEv+PLJi1wgeSlZrzKdu+lgyuCHZ2y7Tpw3WgoBwoPtFVVpaBiPo4ilOoEvKO9CXa3W
         V1mFP38NopSXYWmpXCF915dFcR704schQSLh/byJC/5ZX9Po8BHOOBmk+qyjqIEAYQqd
         RXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823159; x=1753427959;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkVYWp4BBcxWmHyoc2+cEMQtbG6nVF7mKveCM9SBbw8=;
        b=V/4BIOgnfmivKfJaRUKrtsYRFkONz3uopkzX0184c5cHb3QTdQPfuV6lEg4XgiB0w0
         Y2UYQnrK+aJkzN0yZb77E8Tk+mOrneV4gs3FyE3jWJeXascmeIA9Ylg+50n6yztCN1gY
         N1QedrT8GcitovI89fgYo3AmpoGYHo4rf1sgrmeUKy3f28UzVWfqAEVG5ciTrz+mAfHq
         /GwqvLtwiRBqABPbO1qEju9NXcdvJF2GRacz8h7iHSciypFK3yuqat6EW2ytFmZD0z9z
         vjn9X4u/jrl1ofZg6Y4Y1QVc7jqdVisglZWtGD/GpHXGK73J01L0a4fIaeGM7XFB8b4c
         w8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrzU/2yOI1Wr6rc8TFfookafiN9qCuhJulgkdR0PCjruMKCHpqvADo13YS35P+8yh5GD7bYZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUN5ntZusrDHiKgzBZ0UreVypCo415ypnafA2T8xszfVfBUQFc
	/KD4WAFlpPIE6lItZfELQfmD6mjMwoJX5Wg1UEXxZeH3l74ySxbb+398FnKPzl3Z5gZUvDrMXQB
	35btHrf8=
X-Gm-Gg: ASbGncsILtXu2eYRZOdJgqXm3hpRn71UXJESfivZCW5lxEoeo/dZLRuEb7Nq/6WrSBA
	LnYTssoY8EOrHn+aGomhkyO3obYDTZduSDbMfaRUYajO3OJ188XNirRwf/pTJIfx7d3eBnI5edu
	5B72i2shFJqeedLQ8sEO1w44RATioGf0K2Q98UTHypI/WUE84v84JKB59IZ9GP9OW/Wp6DWpfTY
	bHpcM0IseLXB5pLpUvLRMJv30Sb0oSrfzafFAAmDVV/meB9xQETV0jJsrE12fLUUIbYq2YAXBtY
	B2roOKSZZ9QGxnUegCxzsRC0KSWVTEU/2lpO/lFEXhUKxIeNNOQZYme+jJJfofaSfWaTcVJ5oio
	wXg4jNmr4Nq94IyOROC2G4ETTeGKJ0/+dxKIIRv8JD0Jxa5UumC5xooA9BYYkEeTs+8oXvcDz3d
	ExINEJubBHMwwqM5MBovCmF3EOyxuLLAKxY+7juzA3OSQc
X-Google-Smtp-Source: AGHT+IFf1NaaVxNM20rAf6mY3dCCqWB+DbMybfAW7ZG3zy7W2daEjP9PnDc6V7BN0i7/PFXwSHPVOQ==
X-Received: by 2002:a05:600c:a305:b0:453:8bc7:5e53 with SMTP id 5b1f17b1804b1-4562e853505mr80793365e9.0.1752823159010;
        Fri, 18 Jul 2025 00:19:19 -0700 (PDT)
Received: from ?IPV6:2003:e5:8709:f00:6357:915b:11f9:6d20? (p200300e587090f006357915b11f96d20.dip0.t-ipconnect.de. [2003:e5:8709:f00:6357:915b:11f9:6d20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8018a4sm70680655e9.9.2025.07.18.00.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:19:18 -0700 (PDT)
Message-ID: <4f54ed1a-e265-43db-b4f2-f3c0d3b3dd00@suse.com>
Date: Fri, 18 Jul 2025 09:19:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen/netfront: Fix TX response spurious interrupts
To: Jakub Kicinski <kuba@kernel.org>,
 Anthoine Bourgeois <anthoine.bourgeois@vates.tech>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 Elliott Mitchell <ehem+xen@m5p.com>
References: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
 <20250717072951.3bc2122c@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20250717072951.3bc2122c@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sNCzsxRw3QDQ2jmtij0pKYFY"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sNCzsxRw3QDQ2jmtij0pKYFY
Content-Type: multipart/mixed; boundary="------------jursEURXftlZrflz8W5Od1wX";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Jakub Kicinski <kuba@kernel.org>,
 Anthoine Bourgeois <anthoine.bourgeois@vates.tech>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 Elliott Mitchell <ehem+xen@m5p.com>
Message-ID: <4f54ed1a-e265-43db-b4f2-f3c0d3b3dd00@suse.com>
Subject: Re: [PATCH v2] xen/netfront: Fix TX response spurious interrupts
References: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
 <20250717072951.3bc2122c@kernel.org>
In-Reply-To: <20250717072951.3bc2122c@kernel.org>

--------------jursEURXftlZrflz8W5Od1wX
Content-Type: multipart/mixed; boundary="------------TfPj7xlxFQkdadzaSCJS2aSk"

--------------TfPj7xlxFQkdadzaSCJS2aSk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDcuMjUgMTY6MjksIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBUdWUsIDE1
IEp1bCAyMDI1IDE2OjExOjI5ICswMDAwIEFudGhvaW5lIEJvdXJnZW9pcyB3cm90ZToNCj4+
IEZpeGVzOiBiMjdkNDc5NTBlNDggKCJ4ZW4vbmV0ZnJvbnQ6IGhhcmRlbiBuZXRmcm9udCBh
Z2FpbnN0IGV2ZW50IGNoYW5uZWwgc3Rvcm1zIikNCj4gDQo+IE5vdCBlbnRpcmVseSBzdXJl
IHdobyB5b3UgZXhwZWN0IHRvIGFwcGx5IHRoaXMgcGF0Y2gsIGJ1dCBpZiBuZXR3b3JraW5n
DQo+IHRoZW4gSSB3b3VsZG4ndCBjbGFzc2lmeSB0aGlzIGlzIGEgZml4LiBUaGUgInJlZ3Jl
c3Npb24iIGhhcHBlbmVkIDQNCj4geWVhcnMgYWdvLiBBbmQgdGhpcyBwYXRjaCBkb2Vzbid0
IHNlZW0gdG8gYmUgdHVuaW5nIHRoZSBsb2dpYyBhZGRlZCBieQ0KPiB0aGUgY2l0ZWQgY29t
bWl0LiBJIHRoaW5rIHRoaXMgaXMgYW4gb3B0aW1pemF0aW9uLCAtbmV4dCBtYXRlcmlhbCwg
YW5kDQo+IHRoZXJlZm9yZSB0aGVyZSBzaG91bGQgYmUgbm8gRml4ZXMgdGFnIGhlcmUuIFlv
dSBjYW4gcmVmZXIgdG8gdGhlIGNvbW1pdA0KPiB3aXRob3V0IHRoZSB0YWcuDQoNCkkgdGhp
bmsgaW4gdGhlIGVuZCBpdCBpcyBhIGZpeCBvZiB0aGUgaW5pdGlhbCB4ZW4tbmV0ZnJvbnQu
YyBjb250cmlidXRpb24NCihjb21taXQgMGQxNjAyMTE5NjViKS4NCg0KSSdtIGZpbmUgdG8g
Y2hhbmdlIHRoZSBGaXhlczogdGFnIGFuZCBhcHBseSB0aGUgcGF0Y2ggdmlhIHRoZSBYZW4g
dHJlZS4NCg0KPiANCj4+IEBAIC04NDksOSArODQ3LDYgQEAgc3RhdGljIG5ldGRldl90eF90
IHhlbm5ldF9zdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYNCj4+ICAgCXR4X3N0YXRzLT5wYWNrZXRzKys7DQo+PiAgIAl1NjRfc3RhdHNf
dXBkYXRlX2VuZCgmdHhfc3RhdHMtPnN5bmNwKTsNCj4+ICAgDQo+PiAtCS8qIE5vdGU6IEl0
IGlzIG5vdCBzYWZlIHRvIGFjY2VzcyBza2IgYWZ0ZXIgeGVubmV0X3R4X2J1Zl9nYygpISAq
Lw0KPj4gLQl4ZW5uZXRfdHhfYnVmX2djKHF1ZXVlKTsNCj4+IC0NCj4+ICAgCWlmICghbmV0
ZnJvbnRfdHhfc2xvdF9hdmFpbGFibGUocXVldWUpKQ0KPj4gICAJCW5ldGlmX3R4X3N0b3Bf
cXVldWUobmV0ZGV2X2dldF90eF9xdWV1ZShkZXYsIHF1ZXVlLT5pZCkpOw0KPiANCj4gSSB0
aG91Z2h0IG5vcm1hbGx5IHJlYXBpbmcgY29tcGxldGlvbnMgZnJvbSB0aGUgVHggcGF0aCBp
cyBkb25lDQo+IHRvIHByZXZlbnQgdGhlIHF1ZXVlIGZyb20gZmlsbGluZyB1cCwgd2hlbiB0
aGUgZGV2aWNlLWdlbmVyYXRlZA0KPiBjb21wbGV0aW9ucyBhcmUgc2xvdyBvciB0aGUgcXVl
dWUgaXMgc2hvcnQuIEkgc2F5ICJub3JtYWxseSIgYnV0DQo+IHRoaXMgaXMgcmVsYXRpdmVs
eSBhIHVuY29tbW9uIHRoaW5nIHRvIGRvIGluIG5ldHdvcmtpbmcuDQo+IE1heWJlIGl0J3Mg
bXkgbGFjayBvZiBYZW4ga25vd2xlZGdlIGJ1dCBpdCB3b3VsZCBiZSBnb29kIHRvIGFkZCB0
bw0KPiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5IHRoZXNlIGNhbGxzIHdoZXJlIGhlcmUgaW4g
dGhlIGZpcnN0IHBsYWNlLg0KDQpJIGd1ZXNzIHRoZSByZWFzb24gZm9yIHRoaXMgYWRkaXRp
b24gaXMgdW5rbm93biAoc2luZ3VsYXIsIGFzIHRoZSBYRFAgcmVsYXRlZA0Kb25lIHdhcyBw
cm9iYWJseSBqdXN0IGEgY29weS1hbmQtcGFzdGUpLCBhcyBpdCBoYXMgYmVlbiB0aGVyZSBz
aW5jZSB0aGUgZmlyc3QNCnZlcnNpb24gb2YgdGhlIGRyaXZlci4NCg0KDQpKdWVyZ2VuDQo=

--------------TfPj7xlxFQkdadzaSCJS2aSk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------TfPj7xlxFQkdadzaSCJS2aSk--

--------------jursEURXftlZrflz8W5Od1wX--

--------------sNCzsxRw3QDQ2jmtij0pKYFY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmh59XUFAwAAAAAACgkQsN6d1ii/Ey92
HAf9FxknXo8ab3VlYhv5MGc+u+XcIvzXl29ETWThBwy4W0il7jnLJOdjyxJXJ7+4ljqWe61h7C9e
ErndnSt3qCecLISI2eT8jnnrR6q9gMLtRkMdMsLR/kbhzueSqi+puiFMkPennx4eA0mCLLQL/4ZY
DzNs5DJ9JL8ruOvzQ90lSfCoi7xZaFEsRCQnpqkoHHLgrKJ7TZNelsOdmzfaPtjYEaySpbqQv6uo
cprBxLq5+3WBcKtJ5MHukMW3ZxHHvvClWRoWqk/3EeR75oIY8vrt6GP3kpIjdi6SCKqf3gTrebAV
6fkqRG8sdkceEiTUpWmT2zeaR/xhQs4FOxWe1fYImA==
=UdGc
-----END PGP SIGNATURE-----

--------------sNCzsxRw3QDQ2jmtij0pKYFY--

