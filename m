Return-Path: <netdev+bounces-67621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766EC844572
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B40296083
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F5912C55A;
	Wed, 31 Jan 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="P7Qrgl+L"
X-Original-To: netdev@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEA12C528
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720427; cv=none; b=TX06JljH5HYOvJRRKvSpNBDBd11ZCmVhZLCeGdbn2irC/htVUHJGQSTyrWUdxdpv7VaPjpL0bNrvprecckEtfilde9xuscY0ZFh/Xhe/kg6YkgzcK0IQL5Hbt8y69aXUbKKrhD8ASROuSU0GCpWnmGCt6/diAZst3OR9170ZmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720427; c=relaxed/simple;
	bh=wCdAyiY4SCB/jR2Jl31XZiUCj02PYoN/FRUYoGRbF7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/AmhWMln/TJS+8CCJAhI49oNfbboRPvQqSksTAgiT47TRlM/HJ2sSVsZCWm3RS0KtJC4QIv2+F3T3uB7zSc1LjE0qhIYgCFZCY8mBtcdNdSKxc2NZmb/N9sEC9P4bbPUjrtVH/22zhcZ6KycjU/lrKxRROpv0nYbXziSRdXr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=P7Qrgl+L; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1706720104; x=1707324904;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	References:From:Organization:In-Reply-To:Content-Type; bh=JgIM2K
	KrNFXvlpqtE5gmSh3dmvueAMiTxhvlZzfk3Ow=; b=P7Qrgl+LGDe5nVL2NhMiae
	+yjZEFD4e8QKQlpFKjUZX315rkTKpRghCDNvv04/qdrDPQRZoSPIggDx3pWCwWDT
	KStbpsxsxjd+AEBYlxXqK5dDIYtvRivBS9QK77cq/Xs5vh2ZKbVRWWTs1fTfQ6r7
	AYvzKocMkrbwUzxaT1atk=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 31 Jan 2024 11:55:04 -0500
Received: from [IPV6:2603:7000:73c:bb00:397f:6a58:774:1aa1] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.2) 
	with ESMTPSA id md5001003791420.msg; Wed, 31 Jan 2024 11:55:02 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Wed, 31 Jan 2024 11:55:02 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:397f:6a58:774:1aa1
X-MDHelo: [IPV6:2603:7000:73c:bb00:397f:6a58:774:1aa1]
X-MDArrival-Date: Wed, 31 Jan 2024 11:55:02 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1760a2d97e=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Message-ID: <dcd9223a-debe-4942-bb22-1e4e0f1ae22a@auristor.com>
Date: Wed, 31 Jan 2024 11:54:56 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Fix from address in memcpy_to_iter_csum()
Content-Language: en-US
To: Michael Lass <bevan@bi-co.net>, netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, regressions@lists.linux.dev
References: <20240131155220.82641-1-bevan@bi-co.net>
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
In-Reply-To: <20240131155220.82641-1-bevan@bi-co.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070504010805020307040909"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms070504010805020307040909
Content-Type: multipart/alternative;
 boundary="------------MGpWWD3EwwdZUqEOGVHrkK7e"

--------------MGpWWD3EwwdZUqEOGVHrkK7e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/2024 10:52 AM, Michael Lass wrote:
> While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
> address passed to csum_partial_copy_nocheck() was accidentally changed.
> This causes a regression in applications using UDP, as for example
> OpenAFS, causing loss of datagrams.
>
> Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
> Cc: David Howells<dhowells@redhat.com>
> Cc:stable@vger.kernel.org
> Cc:regressions@lists.linux.dev
> Signed-off-by: Michael Lass<bevan@bi-co.net>
> ---
>   net/core/datagram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 103d46fa0eeb..a8b625abe242 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -751,7 +751,7 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
>   			   size_t len, void *from, void *priv2)
>   {
>   	__wsum *csum = priv2;
> -	__wsum next = csum_partial_copy_nocheck(from, iter_to, len);
> +	__wsum next = csum_partial_copy_nocheck(from + progress, iter_to, len);
>   
>   	*csum = csum_block_add(*csum, next, progress);
>   	return 0;

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>

--------------MGpWWD3EwwdZUqEOGVHrkK7e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 1/31/2024 10:52 AM, Michael Lass
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240131155220.82641-1-bevan@bi-co.net">
      <pre class="moz-quote-pre" wrap="">While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
address passed to csum_partial_copy_nocheck() was accidentally changed.
This causes a regression in applications using UDP, as for example
OpenAFS, causing loss of datagrams.

Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
Cc: David Howells <a class="moz-txt-link-rfc2396E" href="mailto:dhowells@redhat.com">&lt;dhowells@redhat.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:regressions@lists.linux.dev">regressions@lists.linux.dev</a>
Signed-off-by: Michael Lass <a class="moz-txt-link-rfc2396E" href="mailto:bevan@bi-co.net">&lt;bevan@bi-co.net&gt;</a>
---
 net/core/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 103d46fa0eeb..a8b625abe242 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -751,7 +751,7 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
 			   size_t len, void *from, void *priv2)
 {
 	__wsum *csum = priv2;
-	__wsum next = csum_partial_copy_nocheck(from, iter_to, len);
+	__wsum next = csum_partial_copy_nocheck(from + progress, iter_to, len);
 
 	*csum = csum_block_add(*csum, next, progress);
 	return 0;</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">Reviewed-by: Jeffrey Altman <a class="moz-txt-link-rfc2396E" href="mailto:jaltman@auristor.com">&lt;jaltman@auristor.com&gt;</a></span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------MGpWWD3EwwdZUqEOGVHrkK7e--

--------------ms070504010805020307040909
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DHEwggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEz
MB4XDTIyMDgwNDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEQwMDAwMDE4MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCkC7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3
xHZRtv179LHKAOcsY2jIctzieMxf82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyN
fO/wJ0rX7G+ges22Dd7goZul8rPaTJBIxbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kI
EEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg
9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjG
IcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
My5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2s
gjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwV
eycprp8Ox1npiTyfwc5QaVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4c
WLeQfaMrnyNeEuvHx/2CT44cdLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYq
utYF4Chkxu4KzIpq90eDMw5ajkexw+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJo
Qle4wDxrdXdnIhCP7g87InXKefWgZBF4VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXt
a8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRkgIGb319a7FjslV8wggaXMIIEf6ADAgECAhBA
AXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUAMEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBDb21tZXJjaWFsIFJvb3QgQ0EgMTAe
Fw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6ixaNP0JKSjTd+SG5L
wqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6iqgB63OdHxBN/
15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxlg+m1Vjgn
o1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi2un0
3bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkG
CCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29t
L3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djCCASQGA1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0
dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMIG6BggrBgEFBQcCAjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMg
YmVlbiBpc3N1ZWQgaW4gYWNjb3JkYW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2Vy
dGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20v
Y2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0
dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY3JsL2NvbW1lcmNpYWxyb290Y2ExLmNy
bDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX6Nl4a03cDHt7TLdPxCzFvDF2
bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN95jUXLdLPRToNxyaoB5s
0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24GBqqVudvPRLyMJ7u
6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azNBkfnbRq+0e88
QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8HvgnLCBFK2s4
Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXFC9bu
db9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4d
UsZyTk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJn
p/BscizYdNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eA
MDGCAxQwggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEzMTE2
NTQ1NlowLwYJKoZIhvcNAQkEMSIEIPBB0ZozWki6jEOZQFm+P2FMYE1HpKtAGXQIVb1pZ6QI
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAFPpx
5Ewkfis4fN4y9mLAkDUsD8Li3J1ITKjSmXwvy9uJ7xFI7rlAUJLatAOoDz0yaKAQ82maduaF
9JHI3hYCrpVMNf5lA82+JNGSyM8z3pqQnlAgfQAI9mRmH0jEricIQRILyLg2YCUW3Rgg0Uoz
inXPhFe0H3LMfat7Q7PniuxBCbCDLrb1CNBRBJu/AwCMJPqorJDaAjyD9pSk6P2ZY/nOtN11
0oAJ3SyvmH/lsfpeTFsab3kPXNSRfFlARSCe8wC00qlk98Dy8ttCiUirIKUO3ZInNtIY5KSY
izB+nRKVx39iQOqkeV3DsSmqNtVakzfR2PgoHu+52aFiWGYBNgAAAAAAAA==
--------------ms070504010805020307040909--


