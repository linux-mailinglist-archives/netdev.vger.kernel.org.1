Return-Path: <netdev+bounces-214152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0EEB285EE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6797BB94B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B723BF9B;
	Fri, 15 Aug 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6+gIu6o"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5E3176E2;
	Fri, 15 Aug 2025 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283425; cv=none; b=P+TcqNvOtyCgDXYP2xXa0np9r9oSe/xUFVLAfDLQcF4TTgOTZMm4+GeM8zS4IRsLLPMK0OStaMu9NbN04uv4uano0Tx5BCQM5tPEkp5GIE3KEHtR095snAlvhP9SUBo1oSlIw0Bj894uS6arCFU65g+7FZqZoxC/GIAJq8ZYHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283425; c=relaxed/simple;
	bh=pyUnlgyu1hk7ZXZ6aHZS+qN+Vvwdr9Wy3QvqA9UPYps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7xEvfTgJSOM0iuYwZzT/Ao7qR2mKM5/7lQrYjhI/ToBx0LgsKJ6KLrtf5mIoUp/t/YKISOduGYMbQzKa18lFyb9eCsK4L1x9aZi9xSF4HbCuxjJJwkJLQttFK6b4Q3xyHHVlc6O86fW8wRI4V775to8tsE3Lri/jfa+s7gU6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k6+gIu6o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+5KafjM0IWYE6D2j5vkDAd6Y/Fk3ZDbC1+4dwJEOz9E=; b=k6+gIu6o3MprGSD3gkSziwhSge
	4xwN5Fk6xysVPs9bFtKAXQWEQqrQO/J+vooNYGW+j9eoy1txVtkqUFUcvfAfQYvcMalafM4h0q2Fm
	Haz+jOEkkovbtLL1MKqTfblB2FiICN2ZahCb+QIzQ8NFUTwC1QAA2JhbETVdYIfEA0CSNQKNX65aG
	badHx95HoC705DWMS+uFoLTusoN/HmBqpUHSTwA7u6q/QViMAfUg/PyjJ/wA90eIZKzVnfzRgsfiQ
	PdNaZPRkPHAC0jVt0bPQF2tWoTJ8muAmHwLZLWYtpDo7QvliLVAEfnSkzsHq2njOFmvUL4UMUVbeK
	5IrXVolg==;
Received: from 54-240-197-234.amazon.com ([54.240.197.234] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umzOo-0000000GE2V-2R42;
	Fri, 15 Aug 2025 18:43:35 +0000
Message-ID: <0eb8283cfb0de9e4e5fd67b186b8b6c7aab80766.camel@infradead.org>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 15 Aug 2025 19:43:34 +0100
In-Reply-To: <20250815113814.5e135318@kernel.org>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
	 <20250815113814.5e135318@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-l9QcHSbBoyq/H+VL+kiA"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-l9QcHSbBoyq/H+VL+kiA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-08-15 at 11:38 -0700, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 19:53:21 +0800 Wen Gu wrote:
> > This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
> > infrastructure of Alibaba Cloud, synchronizes time with reference clock=
s
> > continuously and provides PTP clocks for VMs and bare metals in cloud.
>=20
> > +static struct attribute *ptp_cipu_attrs[] =3D {
> > +	&dev_attr_reg_dev_feat.attr,
> > +	&dev_attr_reg_gst_feat.attr,
> > +	&dev_attr_reg_drv_ver.attr,
> > +	&dev_attr_reg_env_ver.attr,
> > +	&dev_attr_reg_dev_stat.attr,
> > +	&dev_attr_reg_sync_stat.attr,
> > +	&dev_attr_reg_tm_prec_ns.attr,
> > +	&dev_attr_reg_epo_base_yr.attr,
> > +	&dev_attr_reg_leap_sec.attr,
> > +	&dev_attr_reg_max_lat_ns.attr,
> > +	&dev_attr_reg_mt_tout_us.attr,
> > +	&dev_attr_reg_thresh_us.attr,
> > +
> > +	&dev_attr_ptp_gettm.attr,
> > +	&dev_attr_ptp_gettm_inval_err.attr,
> > +	&dev_attr_ptp_gettm_tout_err.attr,
> > +	&dev_attr_ptp_gettm_excd_thresh.attr,
> > +
> > +	&dev_attr_dev_clk_abn.attr,
> > +	&dev_attr_dev_clk_abn_rec.attr,
> > +	&dev_attr_dev_maint.attr,
> > +	&dev_attr_dev_maint_rec.attr,
> > +	&dev_attr_dev_maint_tout.attr,
> > +	&dev_attr_dev_busy.attr,
> > +	&dev_attr_dev_busy_rec.attr,
> > +	&dev_attr_dev_err.attr,
> > +	&dev_attr_dev_err_rec.attr,
>=20
> This driver is lacking documentation. You need to describe how the user
> is expected to interact with the device and document all these sysfs
> attributes.
>=20
> Maybe it's just me, but in general I really wish someone stepped up
> and created a separate subsystem for all these cloud / vm clocks.
> They have nothing to do with PTP. In my mind PTP clocks are simple HW
> tickers on which we build all the time related stuff. While this driver
> reports the base year for the epoch and leap second status via sysfs.

None of it should exist in the cloud anyway. The *only* thing that
makes sense for a VM is for the hypervisor to just *tell* the guest
what the relationship is between the CPU's hardware counter (e.g. TSC)
and real time. Which is what VMclock was invented for. Use that,
instead of making *every* guest on the system duplicate the same work
of synchronising the *same* underlying oscillator. Badly, with steal
time in the mix.

Given PCIe PTM to synchronize counters, you could even implement
vmclock over PCI for bare metal.


--=-l9QcHSbBoyq/H+VL+kiA
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
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxNTE4NDMz
NFowLwYJKoZIhvcNAQkEMSIEIDETVoxjVdqDDuf//hFiHZrH0K3KeURWLkwGK6uzwzYuMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAuaogdmv/Nnf2
YkD0/BhCLLbuScwO+EFjp1qNp/FZlZqoWYvwyZQLivmtMjkjPFYYLc7pjKIvILo0nTnwjjdRtEJe
i2f0D7kFaldNVH4RX6CKw787BLdfyyPSqfeBjta40Yxq3Qt0G40gsihe9qXWUn4d0731crj31Hkm
PlEwqyshhegggZEjm7ML6oZ4RufQP7PRxLeGcOeeKeuv90YlWIseKiZ8ojoqeHZ/Gz17eZlCzAd/
bMChAY5mwJ9+LKqnGjfptCDpwER5Cxfl9uT0uCyhjPP6TcH6ArJm2l8KvGg/FpbCuSF+mAenZy0N
0kDQmmchKLmBjHidLQ7OYtRC2qdclIpkRbS9z1VXRLzne2rpixDg1b8XD8Uvrp/JyGQUlEueKyat
sKkSI/GTKj4UrLx6VFJibSp8CC1jNTLlo2RuNjvJaV3Mx5BJkKXVNV3RrKPrGHd80O8ELVFhyUwT
AS7lvv+/PLgBZbMUr5SiYLlGmYWt5v1pU9psxUsTi2l+pp5madGkq7moa79sRbLkVdwArZpCTuTG
sb3X9YWD62samxbK6RBExFwBiWqPRms0gv340aK+aem24JOwF+xY6HETKmMr+CyrlAESQ9885ddf
luF/a7Gl3WT3fIQF1Rp6+AmxSsxalQQ/9ZnUrIMGHeveuAEcLCoROscwNHyAuWIAAAAAAAA=


--=-l9QcHSbBoyq/H+VL+kiA--

