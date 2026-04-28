Return-Path: <netdev+bounces-281734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBrfEWl08Gn5TgEAu9opvQ
	(envelope-from <netdev+bounces-281734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D02054808B7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6F94303AF23
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6B3D667F;
	Tue, 28 Apr 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A1DUeKo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7493D6485
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366070; cv=none; b=SWO41sE6Npn7EETFLw0FNhRt+2YB0612EukpVfEm590SyFOsAVjqoRISB5xHfpVwiEZ64Yw/uRtK2MMx3DwQUn4QVrUIj/hVr0vtS5d1KyjJwIFfN0tAJ+3qUGM328QuP5CVKBAhcCV/aBqJMnPT56PQ7+F1cuZq1tvAa676L6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366070; c=relaxed/simple;
	bh=D1irAjJMvWGObVoz+cYSd0tJefjPWqpnT629T4hAeHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOiULc3h0iZRwXoU7m5YvXZ9wVrQOzmZbstMgV2rTFhsr555ZBLhH0M393GdiTwwBnCfoqIx50TAigTH2A55Hj3he610Bmnb19mpiMZZpAMLXQCCQ14FUz81MCoCIA1BqTnk+Po20361ludfdTfq5kw2Ix/2CxV/zE707cdIMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A1DUeKo5; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-65019c1dc32so1238914d50.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366067; x=1777970867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1irAjJMvWGObVoz+cYSd0tJefjPWqpnT629T4hAeHY=;
        b=OaKH6YqZ0F2onaf1o9DTsdoeXMrKlblyqkb76TNIsGsVCclKVV4tJUwEjxYHV5nuls
         GyBEmW6LP4C2m420w1o+AD/2KriGnkuc/1O7aEEMYJCS8iS4kE4Eh2m7SfuKxBmVujsT
         3tK4l6z1trFolMud7tTvoVJW7rnym1IGl1RII4RZZvXFbZcsI42KLk+mbSRTas5xwFmb
         gKLLPkfNsVW7Y1yS7fqIpLpNsJduLXd/QX5S2cEiPs0YXSqf6ie/AOiXNM6psw2uNh+W
         3kAYEGrLyAni/5370uWXAHqWa9JboiqN9tURaIAIdJd2YyPfoqOJccXbTdFzrKsMvkJz
         lATg==
X-Gm-Message-State: AOJu0YwXr5fxTXglAhf4+5eD8IAeYzFdB+CJM2XZ+FduSz30Rpi0kMMl
	Z/Q9SmAnjxJW5YfPBHcUDw6ZHv2VAmqOAt2PF4NMF+ln4s92PaqfRpnC6bC+kXKB3nFOhObpQPY
	0UYAOW3BWBHTxk8CdA2MM9GX76SNuJeCmU5x9+Av12neck0bpUJXVayO2q0BzyHZSWWsgzaEdBU
	cs/07WtUNB9rtu+1FZesTctK83Gjp2GRLh9C4Qm69dq9zRjQu2x54em/GOMg1fp7UfjMyvu1fDQ
	3thx/VEi8TS/m8=
X-Gm-Gg: AeBDies8tpgz4+AsLJkEODjj8UXchteVnu6Wp25thf5+JZU82LAHSwTEkq0h1oz5xZl
	1Yi/+2AmOG2e+45QBeibw5zakxx6eyoQkyM9jF71NhNJcKXOblCKHQa1y16E35G9bX6wzN3PjiV
	a0nusbMpfQ3/7p0aDqQetFzyslp+m+MEKgS3fkNf/p48qaArBtMinc22Y+4sgSEXHAu5hvut+80
	pKUCag/S+reQL3Xz0o6oJHu28YPIrS2DstnPbFxbdT9lj6WDXZHb6UZ6LThEDR8/ReJ/gwTGrdq
	KARNCRGYll/9bSS9I67t+m9V63r+NpkA86Ua3xzTKijtuRjf5XBch5baoW5pnvTDG+nX5SEpUFy
	2wWD2UqpeAqmwI1bJJ4NyEhBcic45YiGAwhp8Z/ZPULHqHGC5lSwqobVCQaQrdiC8ow5BQYmXRQ
	Ve9VrLXFrCkb4ApbWzaatvyYcr8EAvnJM75ytUeFMj+6uy1e46d5ysEtY2CrJmytzu+A==
X-Received: by 2002:a05:690e:d55:b0:650:1c35:6f29 with SMTP id 956f58d0204a3-65bde24d2b6mr1590854d50.2.1777366066977;
        Tue, 28 Apr 2026 01:47:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65bee26de07sm129553d50.1.2026.04.28.01.47.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 01:47:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ba690dee900so95064066b.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777366065; x=1777970865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1irAjJMvWGObVoz+cYSd0tJefjPWqpnT629T4hAeHY=;
        b=A1DUeKo5/3tRl4arBagpis10RZ3hJ6Q74xgBNNYX6i44VxlgfgC0Pvwt4iSIuoupdm
         G9J0jjAI+TUSRbXQb9SAO9jM95ZXUXhLiR96IB9U0bINYuuEjquv20Cv/V8+HwkwoGBn
         8aBxNibNUU+5UKmdbiAWTU0uZ4NOy9hjtB00Y=
X-Received: by 2002:a17:906:99c2:b0:b99:1070:763b with SMTP id a640c23a62f3a-bb7fc7a9e89mr50436366b.5.1777366065277;
        Tue, 28 Apr 2026 01:47:45 -0700 (PDT)
X-Received: by 2002:a17:906:99c2:b0:b99:1070:763b with SMTP id
 a640c23a62f3a-bb7fc7a9e89mr50434866b.5.1777366064706; Tue, 28 Apr 2026
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427152756.1205-1-ankit-aj.jain@broadcom.com> <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
In-Reply-To: <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
From: Ankit Jain <ankit-aj.jain@broadcom.com>
Date: Tue, 28 Apr 2026 14:17:31 +0530
X-Gm-Features: AVHnY4K94ZA0UN5hBeqlwWRgBUJwEomHwWwB20WhSUceiS-2U6JwG0HfopBB3g0
Message-ID: <CAMh818JNLZZyGoL0LPURtSQtrEswwUhV=0rmwtREsSO3x7cRZw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, quic_stranche@quicinc.com, quic_subashab@quicinc.com, 
	linux-kernel@vger.kernel.org, karen.badiryan@broadcom.com, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com, 
	tapas.kundu@broadcom.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fb3f8e06508148f6"
X-Rspamd-Queue-Id: D02054808B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,mail.gmail.com:mid]

--000000000000fb3f8e06508148f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 9:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Apr 27, 2026 at 8:32=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadco=
m.com> wrote:
> >
> > When an application explicitly sets SO_RCVBUF, the window clamp should
> > not be dynamically recalculated based on the memory scaling_ratio.
> >
> > Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
> > down when it sees a poor skb->len to skb->truesize ratio. If the
> > application explicitly locked the buffer via SO_RCVBUF, this
> > recalculation causes the advertised window to drop severely.
> >
> > If the window drops below the interface MSS, it triggers Silly Window
> > Syndrome (SWS) avoidance on the sender. The sender defers transmission
> > and drops the connection into a perpetual 200ms PROBE0 timer loop,
> > drastically reducing throughput.
> >
> > This is highly reproducible on loopback interfaces (MTU 65536) using
> > Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
> > to 32K or 64K. The bloated loopback truesize forces the scaling ratio
> > to drop, crushing the window clamp to ~26K, instantly triggering SWS
> > stalls and causing gigabyte transfers to take minutes instead of
> > milliseconds.
> >
> > Since the application locked the buffer, the kernel should respect the
> > clamp boundary and not dynamically crush it based on runtime ratios.
> >
> > Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> > Cc: stable@vger.kernel.org
> > Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> > Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
>
> Make sure to add a selftests (in ./tools/testing/selftests/net/packetdril=
l/ )
>
> Thanks.

Hi Eric,

Thank you for the review.
I will formalize the packetdrill sequence from the commit notes into
a proper runnable .pkt selftest. I will include it as the second patch
in the upcoming v2 series.

Thanks,
Ankit

--000000000000fb3f8e06508148f6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVKAYJKoZIhvcNAQcCoIIVGTCCFRUCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKVMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGXjCCBEag
AwIBAgIMbntqa4fWscpa/odZMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDQxMVoXDTI2MTEyOTA2NDQxMVowgagxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKQW5raXQgSmFpbjEpMCcGCSqG
SIb3DQEJARYaYW5raXQtYWouamFpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDw7npj4cwT0wMDizZ3jWoZvhYCqc1CIVtZRy5zqR8ZZbNbOlYZ6UUVRXUfPMUR
Z9ffkv26gY+mbjapHpQzB1358nccRYXJcAkztBgOuGllq2/67wWUUIM5YZ5SaeqhSZFJsRJJytQC
DaSuWu5q/33nHVcaIJ3kp/2HCYAuxbyy4iqXqiO8/oBCAd7SQzi2IQw7nSYBdNRh6oY2RWDEBBRG
rF53gLnbWUTEN/292ihDLnEJNkjdCJhAS3oytVWYk9OuIi52Q4LleFysRYTymXUKF4HnjuKd7vh1
n1NxXoEjw6364Ls7rJeHCZe4QhPYDyVpKhuqakY3fcGRWgkM/5RJAgMBAAGjggHbMIIB1zAOBgNV
HQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzAB
hi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4w
XDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDow
ODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3Js
MCUGA1UdEQQeMByBGmFua2l0LWFqLmphaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUF
BwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQu6tB0f+nWQaN4
VmZkSjInquwPTzANBgkqhkiG9w0BAQsFAAOCAgEAH4BFO4g2gliVnQ77RMBV9ww7Oj19gFz8tQwS
LvnxwhLen1ZLZdujX4iw3c/ZLa0h8YUQkTbGDJvRLxwQy2A4gSkYsRt7olZR7miNjAkIRmeNJctR
xmONt5SVp2svfnW7bdt01CrpPTbXGnpP48od9kvmJovO/Vafp9orPWkTxMRuyL5qRVli8V+oBeq3
/Ev1RzYJq99dDFW5lNHB1JvwVN5EabT38sbg8kCD3KNRuLYE6Cp28HwJv1XCk6nIdN/aUV3QCTMp
EW+EMajE+KlRiK1s4lMEV2hLjw7mck6qG5d1/npfyvZ3I3SrWAWHM5ZnhTxSfbrw49qE5lmm8Hj0
33zOCQGQOyLk1F2P5+AqEgaBKxjiTsmTlEAnMLSWjZKh3c502uTR2ZWjnNLolvrA0guExR3J70Ks
nYWHGmSY3ZTZIMGCdz0sbnduyVpHP4FtN4IrskURKKloOBNGcfVn3Ily8Vy5Yiojf55cVYuoVeob
6UYJDbHaoDqig6YcfdzM12JCQFCaO8Px34NGinow7nYdfugWbwWM1JU5Ekl+nGFg3J5/aNvN86WR
6uNRdFpfYPriH5/mbuk3LHQ+uT/tgFAM+83PZpHdetKNWJCEp7pwSgnofznlnuMpZ9GMRXIwYwqc
RCyvmPPRUdRsTZjSE+I2283LmfhOEbgE7JDOdWIxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBT
TUlNRSBDQSAyMDIzAgxue2prh9axylr+h1kwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkE
MSIEIBNdOtd0C586igB0YwouhgO97gCeNYBx2KNyIF8LplJvMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQyODA4NDc0NVowXAYJKoZIhvcNAQkPMU8wTTALBglg
hkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0B
AQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABMtZm3HHSEgnu1/GX1vDuwSJwg8N2Sy
05FZiHG2EHD+lrycAJOuHYTVFsuSGwQcbbiwmbcGDh6ehcmbGYbOtiCrYDkKm6Owz3Sr/5xeBrnV
roT9cnSbu3mKIzCACMMXmdicx70CU6WCTIZEb0INGxmSrH2kx5vRHa8MQAe9yrhF8kVezmXJRqQK
1eHO+PtP/cX7dOZZIZjTkQbU6ONDhPPwOm5J5tT7cqvMf821IrdTrXUnTu6Oz4hpLXoAF53zeT12
QfqoJgnTn/0gLREgjxQiiqhlcc17pXNQrKaxbLpT1lr0/lXswiFu1YO6eqRR8+QCa3UseISBxzT+
0SgGEzI=
--000000000000fb3f8e06508148f6--

