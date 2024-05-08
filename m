Return-Path: <netdev+bounces-94443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047D8BF7F6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8417283A88
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD763EA9C;
	Wed,  8 May 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="N/RL/99i"
X-Original-To: netdev@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF33CF73
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155460; cv=none; b=JOZs39oCfsyd5JRZcIVoX3zEk9uO8nDz3hhQPNQV2wQ1y1L8uz7K0qPDf+FLGw4u9ooD5SjLYa0itByjGmbvMsnqcs7wzNKxasKGlK8GxddN0MF4wpNrcUHYm0eQR2NzF1myeCqv596Eo4DeHDqnoWUyGJb4t/u/wcNtUcqnwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155460; c=relaxed/simple;
	bh=fnAGjN3WXf6Gf+kzeLVB8Y1WbqKeRRlANUtvCPGb+fs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HaSljgl9qs2S2N2+8D+H2vjx6xZYU0QxlPaAXCRtLXLUcGk6AyJw3AviKTGd56niuLabvk7HZ5aXrZp8G53b+IS3TVf448Tfp9kCmiXBfM37/kLMXP76EKHCKgMmGHB6JiSRBbrgnVJ8TiTca90y4XM72oBsJ782mmJaEzzh2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=N/RL/99i; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1715155089; x=1715759889;
	i=jaltman@auristor.com; q=dns/txt; h=Content-Type:Mime-Version:
	Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:
	Message-Id:References:To; bh=OOGFqnrRmLyMJdtPJTcV8eMaia1HruvhmH/
	XgAfJZ68=; b=N/RL/99itCm4Gb2jZ5L7LGt3pcw7Io9Nkq763XsoMrgFNpKZ77Q
	xSSa5swVv0Am1KmFo6VwFpivejc8p6oI5+mgov5NIMUU011A4XIsVeixf7GSKj/E
	CMwqA+g4vb1DjjI0jH51WaEgICTmmFUm78SDtYidAN6evMOkktW/g/q4=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 08 May 2024 03:58:09 -0400
Received: from smtpclient.apple [(146.70.168.190)] by auristor.com (208.125.0.235) (MDaemon PRO v24.0.0c) 
	with ESMTPSA id md5001003915906.msg; Wed, 08 May 2024 03:58:07 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 08 May 2024 03:58:07 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 146.70.168.190
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Wed, 08 May 2024 03:58:07 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1858b13987=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_D836D061-CAAF-425C-8204-6F0770CDD582";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <20240507194447.20bcfb60@kernel.org>
Date: Wed, 8 May 2024 01:57:43 -0600
Cc: David Howells <dhowells@redhat.com>,
 netdev@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <955B77FD-C0C2-479E-9D85-D2F62E3DA48C@auristor.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
 <20240507194447.20bcfb60@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-MDCFSigsAdded: auristor.com


--Apple-Mail=_D836D061-CAAF-425C-8204-6F0770CDD582
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 7, 2024, at 8:44=E2=80=AFPM, Jakub Kicinski <kuba@kernel.org> =
wrote:
>=20
> On Fri,  3 May 2024 16:07:38 +0100 David Howells wrote:
>> Here some miscellaneous fixes for AF_RXRPC:
>>=20
>> (1) Fix the congestion control algorithm to start cwnd at 4 and to =
not cut
>>  ssthresh when the peer cuts its rwind size.
>>=20
>> (2) Only transmit a single ACK for all the DATA packets glued =
together
>>  into a jumbo packet to reduce the number of ACKs being generated.
>>=20
>> (3) Clean up the generation of flags in the protocol header when =
creating
>>  a packet for transmission.  This means we don't carry the old
>>  REQUEST-ACK bit around from previous transmissions, will make it
>>  easier to fix the MORE-PACKETS flag and make it easier to do jumbo
>>  packet assembly in future.
>>=20
>> (4) Fix how the MORE-PACKETS flag is driven.  We shouldn't be setting =
it
>>  in sendmsg() as the packet is then queued and the bit is left in =
that
>>  state, no matter how long it takes us to transmit the packet - and
>>  will still be in that state if the packet is retransmitted.
>>=20
>> (5) Request an ACK on an impending transmission stall due to the app =
layer
>>  not feeding us new data fast enough.  If we don't request an ACK, we
>>  may have to hold on to the packet buffers for a significant amount =
of
>>  time until the receiver gets bored and sends us an ACK anyway.
>=20
> Looks like these got marked as Rejected in patchwork.
> I think either because lore is confused and attaches an exchange with
> DaveM from 2022 to them (?) or because I mentioned to DaveM that I'm
> not sure these are fixes. So let me ask - on a scale of 1 to 10, how
> convinced are you that these should go to Linus this week rather than
> being categorized as general improvements and go during the merge
> window (without the Fixes tags)?

Jakub,

In my opinion, the first two patches in the series I believe are =
important to back port to the stable branches.

Reviewed-by: Jeffrey Altman <jaltman@auristor.com =
<mailto:jaltman@auristor.com>>

Jeffrey




--Apple-Mail=_D836D061-CAAF-425C-8204-6F0770CDD582
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDHEw
ggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMB4XDTIyMDgw
NDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0EwMTQxMEQwMDAwMDE4
MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRtYW4xFTATBgNVBAoTDEF1
cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCk
C7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3xHZRtv179LHKAOcsY2jIctzieMxf
82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyNfO/wJ0rX7G+ges22Dd7goZul8rPaTJBI
xbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kIEEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq
4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6
W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjGIcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAw
gYQGCCsGAQUFBwEBBHgwdjAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEIGCCsGAQUFBzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2Nl
cnRzL3RydXN0aWRjYWExMy5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYD
VR0TBAIwADCCASsGA1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIB
Fj5odHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5k
ZXguaHRtbDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJl
ZW4gaXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmlj
YXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vdmFsaWRh
dGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQYMBaBFGphbHRt
YW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2sgjAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwVeycprp8Ox1npiTyfwc5Q
aVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4cWLeQfaMrnyNeEuvHx/2CT44c
dLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYqutYF4Chkxu4KzIpq90eDMw5ajkex
w+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJoQle4wDxrdXdnIhCP7g87InXKefWgZBF4
VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXta8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRk
gIGb319a7FjslV8wggaXMIIEf6ADAgECAhBAAXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBD
b21tZXJjaWFsIFJvb3QgQ0EgMTAeFw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6i
xaNP0JKSjTd+SG5LwqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6i
qgB63OdHxBN/15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxl
g+m1Vjgno1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi
2un03bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsG
AQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3Qu
Y29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2Nv
bW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djCCASQG
A1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0dHBzOi8vc2VjdXJlLmlk
ZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMIG6BggrBgEFBQcC
AjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMgYmVlbiBpc3N1ZWQgaW4gYWNjb3Jk
YW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2VydGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0
IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20v
Y3JsL2NvbW1lcmNpYWxyb290Y2ExLmNybDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX
6Nl4a03cDHt7TLdPxCzFvDF2bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN
95jUXLdLPRToNxyaoB5s0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24
GBqqVudvPRLyMJ7u6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azN
BkfnbRq+0e88QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8Hvgn
LCBFK2s4Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXF
C9budb9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4dUsZy
Tk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJnp/BscizY
dNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eAMDGCAqYwggKi
AgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJ
RCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCgggEpMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwODA3NTc0M1owLwYJKoZIhvcNAQkE
MSIEIOvI1o7o3RBhHrydMNY+LyjGKKdZbn4T1gSrSHI4x0J9MF0GCSsGAQQBgjcQBDFQME4wOjEL
MAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMC
EEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQAgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYD
VQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzM
MA0GCSqGSIb3DQEBCwUABIIBAJSAqsyvXHysXBxBoywxmyaC/FOja91oh/km1wpW4crvs6JGSdO8
1ljHQAhA/QByvuq1x7fJ5JaQV5yf/A+2vMT6Mi9uYkQztOtzCZ5FX3/9rv/woLflsx9LYuoGjVod
ccenZ9Nikrl1vxbNV3G100KvD+3efWu6sW3nWK44BQWbPjraCZ/eZD4qID5wtdMitQCpymbmDKCk
xRLPOIDTsTpS2HuMxNzNky1dwucRLME9985gP72uEw4LOx95evwklTFzeIDV6xPnPNGoE/8DHoCw
I69v5156EJXF9T7iQPyDSMXtm77DTIueHrXSWRDyX0P2osh7j41koYxvN5rOtMwAAAAAAAA=
--Apple-Mail=_D836D061-CAAF-425C-8204-6F0770CDD582--


