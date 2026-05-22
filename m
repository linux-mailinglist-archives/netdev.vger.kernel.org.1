Return-Path: <netdev+bounces-290760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHBgKT4zEGqqUwYAu9opvQ
	(envelope-from <netdev+bounces-290760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 040155B25E4
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972DA302BDF6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8253CAE63;
	Fri, 22 May 2026 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lYqy/jqb"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AE3B2FE5;
	Fri, 22 May 2026 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446103; cv=none; b=WBABXDDahv40L4q0xZiCwr1PctJqO8vN8uYjNRvnZSmcHnzJXpxiXLkV6jmSGCxqFp9YDd/uphOnixuU2NgsPsdf9sziaaB9LRWPqxXhFJQwa2nyvQ55tVETp1k2vpaq4kYOfFacxy3tlSK495XxXw904AiiBPtkAlWD0hls9Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446103; c=relaxed/simple;
	bh=rR60BJO7B9L4b6QE4wRlnUA0XJuNiL54x0/rrtZ7Jxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAoaOytr9ZretdHpEj86pITItUjhMRnO7eDZF5BZ4VtwDdv6ugVu/jaC37Wm33J3gevaY12hTMLDpBsKhzcbTuzaa5yuob4c0U3TjqFJjk8STv9aEF7Xsv4YvirXsEezLRgbfcfSOy2R6wbb12rg9zvs+odnlR8z4Hf3rQ4CFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lYqy/jqb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OJwuH4/OnrJV5YoA7eVdj2CwUhyRm0uifDW/z1AQiok=; b=lYqy/jqbqz2GxyemXoZigaw2zP
	7+hSFB26Nf08rW8eefYZcBQGSgGifYRB2mggbeW25KiAD2i/dwSM9H6cm7bxXyuYituxVHmwZVrPv
	j1AtEIi9BUidopV2blRBvuUJULniB7LB9IM6E2YyF5lxTR9AtEnF46ICyTa3msF7MeExh+MtTx6qy
	3W50iX0Tip5WpoY95bu6Zj5e72QJa/4zQye8ca237oM4HtVFSrvLzhwkI6gnz/o558b0uFY9SBy73
	EInRuZ6+zTL/DIRr4fasyjxfNk+xk1t8U5e5fH6njgJ0aN41aYDnnlOj2ajAOS8S9eA/WB+lN8tor
	KUu7kIEg==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQNDU-00000009xam-34T7;
	Fri, 22 May 2026 10:34:56 +0000
Message-ID: <aee6f77138e5f173d36f3f4ce65cc2acc4e4ae69.camel@infradead.org>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>, Harshitha Ramamurthy
	 <hramamurthy@google.com>, netdev@vger.kernel.org, Arthur Kiyanovski
	 <akiyano@amazon.com>
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com,  jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com,  jfraker@google.com,
 ziweixiao@google.com, maolson@google.com,  jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com,  pkaligineedi@google.com,
 horms@kernel.org, jacob.e.keller@intel.com,  yyd@google.com,
 jefrogers@google.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>
Date: Fri, 22 May 2026 11:34:55 +0100
In-Reply-To: <87bje8v0xl.ffs@tglx>
References: <20260514225842.110706-1-hramamurthy@google.com>
	 <20260514225842.110706-4-hramamurthy@google.com>
	 <cd5868258edee932fd9b4ed46a48b5a07b4c6da8.camel@infradead.org>
	 <87tss0vdrj.ffs@tglx>
	 <63ff978516925951df0f95aecbd4ea5d7bb2956e.camel@infradead.org>
	 <87bje8v0xl.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-pDrdbFyYJXrhnDe/A9mi"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290760-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,intel.com,vger.kernel.org,linutronix.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 040155B25E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-pDrdbFyYJXrhnDe/A9mi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-22 at 00:43 +0200, Thomas Gleixner wrote:
>=20
> Fine, but you can only do that accurately if you have the relevant
> parameters:
>=20

I had elided this discussion about KVM migration as a digression, but
I'm coming back to it because I think it could use the
clock_get_reference_time() thing we were talking about.

> =C2=A0=C2=A0=C2=A0=C2=A0 1) Guest TSC value at freeze
> =C2=A0=C2=A0=C2=A0=C2=A0 2) Guest nominal TSC frequency
> =C2=A0=C2=A0=C2=A0=C2=A0 3) Old host REALTIME at freeze - Ideally you use=
 TAI
> =C2=A0=C2=A0=C2=A0=C2=A0 4) New host TSC frequency
> =C2=A0=C2=A0=C2=A0=C2=A0 5) New host TSC/REALTIME/TAI snapshot
>=20
> =C2=A0 #1 is a KVM problem, but see #3
> =C2=A0=20
> =C2=A0 #2 ideally communicated from the guest to the host after early
> =C2=A0=C2=A0=C2=A0=C2=A0 initialization at boot.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 You really want this information because the gue=
st won't change the
> =C2=A0=C2=A0=C2=A0=C2=A0 mult/shift pair for it ever.

If *tell* the guest the frequency in CPUID, then it shouldn't be trying
to manually calibrate it against an emulated PIT while suffering steal
time, and its mult/shift should have a little bit less entropy.

Even a system which *has* to do that crappy calibration still does it
with a lot more *precision* than accuracy, so I suspect we ought to be
rounding the result to the nearest 1MHz as long as that's within 10PPM
or something like that. But that really *is* a digression :)

> =C2=A0=C2=A0=C2=A0=C2=A0 That is more accurate than using the scaling fac=
tor on the old host
> =C2=A0=C2=A0=C2=A0=C2=A0 plus the old host frequency. Especially if you a=
re migrating the VM
> =C2=A0=C2=A0=C2=A0=C2=A0 several times because every migration results ob=
viously in rounding
> =C2=A0=C2=A0=C2=A0=C2=A0 errors, while if you use the nominal guest frequ=
ency you keep this
> =C2=A0=C2=A0=C2=A0=C2=A0 back and forth conversions and the resulting err=
ors out of the way.
>=20
> =C2=A0 #3 That's obviously related to #1
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 The old host knows the guest TSC scaling and the=
 guest offset, so
> =C2=A0=C2=A0=C2=A0=C2=A0 it can take a coherent snapshot on the host side=
 of REALTIME/TAI
> =C2=A0=C2=A0=C2=A0=C2=A0 and the host TSC value, which is convertible to =
the guest TSC
> =C2=A0=C2=A0=C2=A0=C2=A0 value.
>=20
> =C2=A0 #4, 5
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 are obviously required to set up the new host sc=
aling/offset for
> =C2=A0=C2=A0=C2=A0=C2=A0 the guest TSC, but if based on the nominal assum=
ed TSC frequency of
> =C2=A0=C2=A0=C2=A0=C2=A0 the guest it becomes actually accurate and usabl=
e across several
> =C2=A0=C2=A0=C2=A0=C2=A0 migrations.
>=20
> Anything else is just crystal ball magic, which is what KVM has today....

The model I'm enabling and documenting for KVM migration is basically
within the noise of what you describe above, yes.

But if we want to give the illusion of the TSC just ticking away while
the guest happens to experience a little steal time, when in fact it's
been completely migrated to a new host, we actually want to work with
the *true* running frequency of the TSC at the moment of migration.

So...=20

 1)=C2=A0Use clock_get_time_reference() to get a { host tsc, time, rate }
    from the source host at 'freeze' time.=20

 2) Use clock_get_time_reference() to get a { host tsc, time, rate }
    from the destination host, when resuming.

 3) (Optionally) scale the guest's TSC frequency, not by the *nominal*=C2=
=A0
    rates, but by the *actual* ratio of the rates from (1) and (2)
    above (plus any original nominal scaling of the guest's TSC from
    the original host).

 4) Calculate the guest TSC *offset* in order to convey the effect
    that the guest's TSC continued to tick at the rate from (1),
    during the time period between (1) and (2).

 5) (Optionally) Once the guest is running, slowly undo the scaling
    in=C2=A0(1) in order to get the guest back to a nice simple unscaled
    TSC (or scaled only by nominal frequencies as it was when launched)


Obviously, a dedicated environment which disciplines its TSC directly
can do all of that right now already because it *has* all the
information it would get from clock_get_time_reference().

But as you know perfectly well, Thomas, I'm never happy to keep the
blinkers on and focus only on my specific use case at hand; I want this
to work for the *general* case, including people running QEMU in a
fairly standard environment. And I think clock_get_time_reference()
might be a reasonable way of doing that, and a fairly clean counterpart
to the clock_set_time_reference() you suggested?








--=-pDrdbFyYJXrhnDe/A9mi
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMjEwMzQ1
NVowLwYJKoZIhvcNAQkEMSIEIPuZBTDzPhcHMd5BRXHhjBTKE1T4NDMzbhEImasrHZPIMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAYrUT5Aw5fBDK
fP7N/7ZbixCH8ZckIRLCWErHhP2W2/KZEhkJL0EtSZesuiRMzcjmAHQ3GCYCqjcm7WFzHc0lbk9S
uIOk6lqCJYoPa30/x4NcCsUAPciwZ9M9hiJRyl32wlpB8A0HAuD67EXquxAlhAWePtj60DRmWoTQ
FdG5Mr1SL96sGPbjah5I/7yjUZS9IJGW+jaJMYdjnNaPE8EznjgEoTOGaYsO50KljNm3wcpv47sH
h9TfuMF+VnAahx+uI/d4gpTF62H8U+8AWKrwZcYIrENSqM9iF89tPJQvjB3IAgCHyUKfQodWVssT
1CghfI7JqAr7pj0XOjC7k1NbdicmKER3N5Ni3NPHFCeeo+oPWaBREUddYT7v9EA8hUJPQmakXg8H
1RCf8HQb7T9wN27Lc+E07zqifqnCZURBJ4aaoFh1c8tfHiaI8WLm2C+Xxr5N+MNGXduofz1hBhu9
qgeDZtfiVKFv7Z3Xb7wTG3y/0CIlaCaaZHA6NOzq1/QgVgzyHsKhzAlu4jzBY/dVwk3yN7MLS26S
13VIfCAiMgktmJMdb6j1hq6VsxqqFuBOtfYRlOP0OfgFFgxNhAShqwZIwxG1FB8HFxXrPZF/m36B
7JvSrnPN9yf/XATTYR2iNME+8p3DnLib30MKLKHVLEit4j13+5hzQqKACHgLxQQAAAAAAAA=


--=-pDrdbFyYJXrhnDe/A9mi--

