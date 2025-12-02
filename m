Return-Path: <netdev+bounces-243182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F772C9AFC7
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45D73A3FCD
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EBD3126C6;
	Tue,  2 Dec 2025 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fdbDfONA"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAD28469C;
	Tue,  2 Dec 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669036; cv=none; b=uLy6KDY/MWFcnGvDW9cT8GrshL1suf3asmLu7Z9wxo0pv3Bti48nLKb1APnePJuY6QMmxzoYyw1Fk6rBxP4poCpNrQhZQP1HjTVpziPjlPWjCvwUspfLgJRvcSt2jiqVyJXNYFO4j51kPt1Y89tsQSh+sN/QK53xhyIoqKAwQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669036; c=relaxed/simple;
	bh=1X1h2V35dgh+rN/eM9VsCq9mSIxXdWS0TDGKP0Ax8fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+9QOtWr7YM9/y+gQkCMiroYx4hyeLVnnKkykJMU6WMX5gIK98wqZXE5J5EfwzFQedMa7uT2iZjS+tGvzWl7PryI0SMGq8PAY+M7AzmH654Y6lfsGAHBaRjmQd9FTH0jnrF40XMLc1RWQ3HErerGOUx3G8n46bl5KPLkoyZ/vWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fdbDfONA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J8fS5Lit7lkiIDP0cebrN9uQAOrVXvLn/KFTBwfaMvc=; b=fdbDfONA4ZDdtkSLFnYWSOLJng
	GL84V1p7WNpoSgrpUSTruoPGdEs2yAx09Rlw9q5jmsvYVbEU1ix51SSn0OWfoya560TGjdB/NSl9i
	2X0t39pqxaXV263HFWwkyWAXSBjgfpQlyCv9wtO6pbEm2R+Wk2TlmJPOMjiVyFzXnN7OqJ3SIRJOj
	lLwDGb+PBjTePgvITShXF8fBLZBtZ9YAZxX/tc0Ag51gJo6GN7yGMLtOWlzBWhERweDuGboZnvtl4
	qIqROQssv4ncTHNNNUM9Sld+c5uF/MDPEnYUD8i0wPvik3CY9Tj3GCpleZtpUzY4TbPq20aR5jJ65
	TDWk6/vw==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQMA7-000000001l1-011K;
	Tue, 02 Dec 2025 08:55:07 +0000
Message-ID: <4e30cd3b7ad00fcb27a5f929c28dd69bdceb979c.camel@infradead.org>
Subject: Re: [PATCH 2/2] ptp: vmclock: support device notifications
From: David Woodhouse <dwmw2@infradead.org>
To: Babis Chalios <bchalios@amazon.es>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>, "mzxreary@0pointer.de"
	 <mzxreary@0pointer.de>
Date: Tue, 02 Dec 2025 09:50:27 +0000
In-Reply-To: <579dced1372eb48135863ecc9d244ec8128e09c2.camel@amazon.es>
References: <20251127103159.19816-1-bchalios@amazon.es>
	 <20251127103159.19816-3-bchalios@amazon.es>
	 <e1d7c2208ea0ec2aa6836bf4db5bf0c2bd9e4b86.camel@infradead.org>
	 <579dced1372eb48135863ecc9d244ec8128e09c2.camel@amazon.es>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-ElhewuvXoZFyh2rV2+Bb"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-ElhewuvXoZFyh2rV2+Bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-01 at 13:15 +0100, Babis Chalios wrote:
> On Fri, 2025-11-28 at 13:00 +0000, David Woodhouse wrote:
> > Generally looks sane to me, thanks.
> >=20
> > I haven't given much brain power to whether POLLHUP is the right
> > thing to return when poll() is invalid; I guess you have.
> >=20
>=20
> I was looking at the possible alternatives. The semantics of POLLHUP
> seem to me the correct ones, i.e.: the other end (device) "closed its
> end of the channel" which is exactly what it has happened.=20

Makes sense.

> > I also haven't looked hard into the locking on fst->seq which is
> > accessed during poll() and read(). Have you?
> >=20
>=20
> Hmmm, hadn=C2=B4t considered it because I can't think of any reason why
> someone would be poll()ing and read()ing concurrently from different
> threads but you're right, there's a race. I wonder though what the
> correct semantics are here. Imagine thread A is waiting (blocked in
> poll()) and thread B is reading from the same file descriptor while a
> notification arrives. I can see a scenario that this causes thread A to
> loose a notification (and consequently a missed chance to act on
> disruption_marker and vm_generation_counter changes). What do you
> think?

There's a theoretical race condition even with read(), where you set
fst->seq to the seqno you've just read. As long as they're using
pread() and not serialised by f_pos_lock, I think that two threads can
be reading at the (about) same time, and see *different* seqnos, for
example if they happen just before/after a LM event. Then in all the
steal time and preemption it's random *which* one of them gets to set
fst->seq first, and which one comes afterwards.

So even the setting of fst->seq wants to use an atomic_t and/or cmpxchg
to ensure it's only ever moving forwards.

Then it's either a READ_ONCE() or atomic_read() in poll().

> > Your vmclock_setup_notification() function can return error, but you
> > ignore that. Which *might* have been intentional, to allow the device
> > to be used even without notifications if something goes wrong... but
> > then the condition for poll() returning POLLHUP is wrong, because that
> > only checks the flag that the hypervisor set, and not whether
> > notifications are *actually* working.
>=20
> This is just a bug. My intention is to mark the device probing as
> failed if the device has advertised support for notifications **and**
> setting up the notification handler failed.

OK.

> > In open() you simply read seq_count from the vmclock structure but it
> > might be odd at that point. Do we want to wait for it to be even,
> > like read() does? Or just initialise fst->seq to zero?
> >=20
>=20
> Good catch. I think the easiest thing is to set fst->seq to zero.
>=20
> > And is there really no devm-like helper which will free your
> > fp->private_data for you on release()? That seems surprising.
> >=20
>=20
> I'm not aware of any such mechanism. It seems weird to me though, how
> would it know what kind of data I put there and what exactly should it
> call to free them?
>=20

In fs/ alone there seem to be 11 examples of release() functions which
do nothing but kfree(file->private_data); return 0;.

Maybe there *should* be such a helper?

int simple_release(struct inode *inode, struct file *file)
{
    kfree(file->private_data);
    return 0;
}
EXPORT_SYMBOL(simple_release);


--=-ElhewuvXoZFyh2rV2+Bb
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MTIwMjA5NTAy
N1owLwYJKoZIhvcNAQkEMSIEIJhipJ+E26uSTGgy1hohdWBDvhm+1HOk++VRZXsA9KhvMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAc6z8AwftcsrS
btHa9cGF6IJvAsXQHUN3CeJD0jesqGd7TYx/sRuMlH0nMapurvXFLxrVBIzjarOcX8X/eLwR8HwK
Q50mnCV+lG56aMPDEBb2J8n/Ju1Gl42TdH+M7lnE5y+RqBOEB1fMuW2IFNM7y0eXal7hYmu+BU6Y
VyQffZ4zUhD1s3OJMC1FWchFGmwZDYe97eC1T4DDqzMRLm49kED+Hzd7wLSA1rooZNP4oYTIHw4D
o+00U5WM65FSFbhHf5uuxGs5IcC/yci4PMb+G/kwUa3xAMomJOb6fKfRIKcWpug2WSmBmnnwYj54
h8mO751hGaQ9g6GfcSkzyUOnnPQD7JGulvjl+lwJtFlFbcSIfF3z1V1lqnh9OlcRN1R8TNNuT93K
3B3zSW012trWgC10l+/E4LKbDQEIMLeIyzypqudf1/Uykcyk2rSmLl0f9K3KzPW4wHZgjoJewWfy
XjSMJYdEDcRcqt3xCgA1rghKXELrd+kQN8x7jsjebqz2KFPdRjJymEeN81Fo0Aml+CsRufyLHqsd
wqv1J9GIJBe2qiNfN5UqLmDpCietNniMv/CUj9aIpvzh5fWgIM+dTUWyL4W819TAW0Naj94N3dur
IBgPZz7ZoYybQ6mWUy+BjG6wlZnG4Mv7tCSXs4DQeL5crW2CsEEjD0KNfN2ZCv0AAAAAAAA=


--=-ElhewuvXoZFyh2rV2+Bb--

