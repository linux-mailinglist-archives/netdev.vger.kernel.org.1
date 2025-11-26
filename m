Return-Path: <netdev+bounces-241912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58892C8A404
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F7EC347835
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9132D781E;
	Wed, 26 Nov 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LvZ7SMWq"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFE2D6E61;
	Wed, 26 Nov 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166479; cv=none; b=mVI10YQ4naN9h8fS8xBui6HowF19/DJMT8T4U1jokInGgJ1Wg5E071/XV9SlLfhBdH0qxDvWoZnWTMiDuG8cMwepBC8u0vHfH4tAjJ6Hv670UDZJce2aH6MikHYa3g6YislyHCS2eNoaLt6pxugExI+xICZfoebpRHEyiwaYQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166479; c=relaxed/simple;
	bh=xVjTk2jzLbAxXYSZNBJBcZfk3x8gCryYxGjkjkccXXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgffUXhbktVTwwxiokK2cx+yk7ZbdI6SyiIvVULlQIS++XC/bNly+TIceEy4xGJSDcNH8O+5XubVV3AnhV0QXX2gDMCMO/p5fz/aX6W93KrTRA2BFVfwWzjEwthD5LOB+aLKhUcs+FEPn986Ao05M/glrGRYilS6TZxv9OAnabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LvZ7SMWq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=shJ8INqCd2/yfnuiDjwObFsi6cv+nBH3HMTZig1ESzE=; b=LvZ7SMWqxM+HNf5d6MXxszdtWr
	d4qcpEcBkzGc48eN7Goq9z6iTRJeUpifTfsFiIldo29+KTsYcVbqjkNSFfU40yRVifLHRQEj1tsO2
	v7jF1sHyWGr4eqXrXaukQKp6yJlPzdrhe2sxsA8R20bfV1cTR5Wo/RvB1jGRQwjMOT27QYHb7LUD6
	OZES2jkmXNlljA5Q1Gx7KT4YgzI3EFMA8zFVvVhIHudx+oDocE0vJw++BKU3TMsuhSbsrMQeXs3+H
	hpm1YUlYjOXY7FPtLVDZZmU4/vgqDQVkfNpVuHpos99GvoRTy+DfFYN63knXGvxqRieN/5MXDx8x1
	PNfUSA/g==;
Received: from [172.31.31.148] (helo=u09cd745991455d.ant.amazon.com)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFQH-000000086cM-0SMZ;
	Wed, 26 Nov 2025 13:19:05 +0000
Message-ID: <ebc45c917c4c50e40411135e5fdfb19b907bfc3d.camel@infradead.org>
Subject: Re: [RFC PATCH 1/2] ptp: vmclock: add vm generation counter
From: David Woodhouse <dwmw2@infradead.org>
To: "Chalios, Babis" <bchalios@amazon.es>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>, "mzxreary@0pointer.de"
	 <mzxreary@0pointer.de>
Date: Wed, 26 Nov 2025 14:14:27 +0000
In-Reply-To: <20251125153830.11487-2-bchalios@amazon.es>
References: <20251125153830.11487-1-bchalios@amazon.es>
	 <20251125153830.11487-2-bchalios@amazon.es>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-PgzzRXrfw4Pk0aNK2tYW"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-PgzzRXrfw4Pk0aNK2tYW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-11-25 at 15:38 +0000, Chalios, Babis wrote:
> Similar to live migration, loading a VM from some saved state (aka
> snapshot) is also an event that calls for clock adjustments in the
> guest. However, guests might want to take more actions as a response to
> such events, e.g. as discarding UUIDs, resetting network connections,
> reseeding entropy pools, etc. These are actions that guests don't
> typically take during live migration, so add a new field in the
> vmclock_abi called vm_generation_counter which informs the guest about
> such events.
>=20
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
> =C2=A0include/uapi/linux/vmclock-abi.h | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmcloc=
k-abi.h
> index 2d99b29ac44a..fbf1c5928273 100644
> --- a/include/uapi/linux/vmclock-abi.h
> +++ b/include/uapi/linux/vmclock-abi.h
> @@ -115,6 +115,12 @@ struct vmclock_abi {
> =C2=A0	 * bit again after the update, using the about-to-be-valid fields.
> =C2=A0	 */
> =C2=A0#define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
> +	/*
> +	 * If the VM_GEN_COUNTER_PRESENT flag is set, the hypervisor will
> +	 * bump the vm_generation_counter field every time the guest is
> +	 * loaded from some save state (restored from a snapshot).
> +	 */
> +#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT=C2=A0=C2=A0=C2=A0=C2=A0 (1 <=
< 8)
> =C2=A0
> =C2=A0	__u8 pad[2];
> =C2=A0	__u8 clock_status;
> @@ -177,6 +183,19 @@ struct vmclock_abi {
> =C2=A0	__le64 time_frac_sec;		/* Units of 1/2^64 of a second */
> =C2=A0	__le64 time_esterror_nanosec;
> =C2=A0	__le64 time_maxerror_nanosec;
> +
> +	/*
> +	 * This field changes to another non-repeating value when the VM
> +	 * is loaded from a snapshot. This event, typically, represents a
> +	 * "jump" forward in time. As a result, in this case as well, the
> +	 * guest needs to discard any calibrarion against external sources.
> +	 * Loading a snapshot in a VM has different semantics than other VM
> +	 * events such as live migration, i.e. apart from re-adjusting guest
> +	 * clocks a guest user space might want to discard UUIDs, reset
> +	 * network connections or reseed entropy, etc. As a result, we
> +	 * use a dedicated marker for such events.
> +	 */
> +	__le64 vm_generation_counter;
> =C2=A0};

Looks good, thank you. Just a bit of nitpicking about the comment.

I really don't like talking about a "jump forward in time". That's what
clocks *do*. VMClock tells the guest a relationship between its CPU
counter (TSC, arch timer, etc.) and real time. As long as that
relationship remains within the error bounds which were previously
promised, there is no disruption. It certainly isn't about time jumping
*forward*.

Let's also make it 100% clear that an implementation must *also* bump
the disruption_marker field in this case, not only the
vm_generation_counter. How about...

"A change in this field indicates that the guest has been loaded from a
snapshot. In addition to handling a disruption in time (which will also
be signalled through the disruption_marker field), a guest may wish to
discard UUIDs, reset network connections or reseed entropy, etc."

--=-PgzzRXrfw4Pk0aNK2tYW
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MTEyNjE0MTQy
N1owLwYJKoZIhvcNAQkEMSIEILb5194eTFudgyGNr97ArNbe8H+2wWhgWQkLJH+cVUbkMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAXGhcO76i4xgO
KDd9QsmV07QbV/oLZF1FqwQpbNCVDjXcJjr/2tTIC/2PsqM6mgMWPVrcSs4LwOqS1XXSeiUFCqPu
pyaCv1MhmgKIKiR7P3gYqxbwh+cWoS/wQl/ln2O/6Z2Xn+yDraizcwvdZqHEfein6+17vo2N84HR
kyq55dhvUcA/z9AYJz3L6PjIHVE4lAYMAOk0PEEUwJdhDgdV1lBac8/7aHvh/oeOE4Hjnh5vau0W
E5mlI5/iJlMCls80mqP4g/KzMo/8/7jUw2Mtg4Pr9vQP4QBlhzdpVbgw3Z6EXvdstNRUvSWhzgCd
lP/IxGmrJl6CIM/Ua4FBmUH0AN3P1wr8T7SN6J8XPgPEv7oeTHBcuFQFzkZADvOjnBBUdbl+b7qi
6tq7eMVeeCobsromTNgwhHxSbompPlpRb7cQmv6pgqE0aON43dXkx7Qyo6DlHL1ULiyEzEmgvlmG
P90p6zf45b3f7c7i0X89w4RT4Hryj8joengWtW6uj8ZXG+VCk/u7TRn/r2Be5bV6oMqaxj//kQWg
M9j12OoycGL9TDKpGlUXz3tlXgbcRmBWylBvba5jZh9XYRRQ/GJrFB4uHX7+HoHZGalJLtR9WXHr
xzSm7jV6xZbz0Kxt6Ayfb1u4NiX6AK9eSU+bn4qIov0LYVjAvRIR8f5Ka+FkTbAAAAAAAAA=


--=-PgzzRXrfw4Pk0aNK2tYW--

