Return-Path: <netdev+bounces-238590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E44C5BA56
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 07:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9445E4EDFE7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477032F49E5;
	Fri, 14 Nov 2025 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NCRuYeli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6025D540
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103110; cv=none; b=WSGOeNCji+uRyKgMzp54aN/E/wqQ9bUFElKxWH7CQhJ40uWWu1QKxoT9xDmB1VvAKsUrU0KHAqokr3RgvK8FZXp7/G110XZCTdmRhdYT5wt+2P/uVBBEdrG/3Rdd43yGJk5pdB4kHnCmLfmJwqt2Vd7KyjQWPGTG3PZoKyJBK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103110; c=relaxed/simple;
	bh=PUR6Xif/Np8wgAd2dAo9qCl3caok50TE2yteEH1SkQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCOvbCm+r241ksa03ijwmqVGB5izBNiXIQL8RKO+TRfuD254mK1L3wzCTm7MoCQjNXa6T5ZyA+wbSjrGrh+LKaYsfuAsrCKhSw8lxEMGaygHrUyHA9CWcJL/N71WQLA0KQ72f7X65K62jtQfNSVJStzcBLvQNHqsISDzShbHy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NCRuYeli; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-434709e7cc9so8419135ab.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 22:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763103107; x=1763707907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ9CA/LgIa6D2hEx6m1bdEE7mGpOm3iFd1Lf7aEv1Rs=;
        b=Lku2+/qLibO6eAP3pcixEiLJf7+lChGcDTXPZA8tpIwrRimjaUuJp70YlQ1VjI8u0O
         DS4h6uy7qxrdW73d0+Oj0y/v7zLCsvQ96sBuJ81qWCjggfc+UGhrUKB7vdU40zxTooJ9
         9KSUEG0R6iL7yo0feTjlg74EynmIyLIiDmgs6QSGjORxcNKMRRg39VFyePIZ8nKTKgi3
         OpklaBaHzCdI3+yHVZ25RRJAjKfaVpT5qw4JOk3J/yLIBvu1WN5MU9E5EvQ1mpNUKQbe
         ER0fNgcojIFWS4PTuP5VJah7zA7ajWrH2MBoCahzpi5fxQrzmN0ZRrD0zsnOMJaB7XNh
         fBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCZtb+rupxZrIARLhwu3CofLOK+sciiLKUJAK2XzSp9J5//GC+rdGPbqA5zsmz3si5xgVzXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5TJmfNJWx2JHn/zeW6CLlhTg4FYnUXlOSbZQ6W3NE19NsQvo
	TJMWPMllPCCS90Wo95SvKGIfFXtkInSnCQ3qnOFj4cE4Nw5ZAPbpGGlcIy27I1QyNyHIcyx5mAQ
	fyLVrPMncberuuV72eco9qwSfJmjGgcckLkayqiCqBHhMsUbDq1lsOzhsqLGHlhx3QI2hht7aO7
	FzWj6kcc4VUvWt3o41w2F3OoonJoxkMQcWrAiL70DXoPCWCArozJVuOUfREvQio1Rd9t9TVjlz/
	qi/MB6MKg==
X-Gm-Gg: ASbGncv5w5pxzp/qZ1aE0IKQArbfMnY+qunpFY39WzIdbjK9gex7/Og4upgi+KozZZ3
	JL751G6/dADjEjvAsJUJXOgcPiw+hQs6oHWpW0A6NWA1vBc0thhBHvU+FaRNikNZ7Ud8qiZMdTr
	+bHT3y8tXDe0CZwz63uMK3XQjNNUvpHQZqQYN9rRt2bUwi3B+Itiux6MXFIHgNrVUIFdRc/1FiD
	EGUr/2NRqUIGjgGu7x984ldeT5Kigt/GBxPicnNmPyo5G4XhZ1ANXqPDS/61l5nn6G67fVKYD2q
	XJPL0TQPPFH8VjlxiHqB+i6+bm/C727vg/9BBpEMxNMwOm5jGTj2HwvKoN8mPDkku6QWCRdGgSI
	lXmphjkCOucwBlVXDfRVyZtCJbVRwHCXxUo/dQdBW8l+FZ5xJ7qFHbr4cxL+hyOlyxqBernU9Ly
	sAZ70/XhP51v3wbuUlYHNyswsDONONSOusta4=
X-Google-Smtp-Source: AGHT+IFz+/Z1aL7dYzEg7OMv0PeHB95GzWKabQT/FZMulciht8Cyl3i4+DH1J97vfyPgjgbqWJeN+xAl0YTV
X-Received: by 2002:a05:6e02:12ea:b0:433:29a9:32e2 with SMTP id e9e14a558f8ab-4348c941bdfmr38800445ab.32.1763103107315;
        Thu, 13 Nov 2025 22:51:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-434839e2cfasm3489135ab.30.2025.11.13.22.51.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2025 22:51:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340bb1bf12aso4109037a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763103106; x=1763707906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ9CA/LgIa6D2hEx6m1bdEE7mGpOm3iFd1Lf7aEv1Rs=;
        b=NCRuYeliJJNsZCfvS0C20vhw09br+dGudanrYlaHugeti8Kv6ezUqD0n3Qgspq1MwR
         NXDNIt/YN6U3ReKUvV13aFI5AwZolafSC67K+B1eEPs56cheJcMP36d3iTJM6JOzErYh
         WsnapYqq7A5W1ENGSOF6c2Tyutr2gaJqtKs60=
X-Forwarded-Encrypted: i=1; AJvYcCXOr8T4Qt2znjDwgIkwa8zLg+ByaReTCQG2Nnni4wn6oD1xwBhvet3iciLrjRqRXUCudUqFjRM=@vger.kernel.org
X-Received: by 2002:a17:90b:2b48:b0:32c:2cd:4d67 with SMTP id 98e67ed59e1d1-343f9ec8fe5mr2125231a91.13.1763103105614;
        Thu, 13 Nov 2025 22:51:45 -0800 (PST)
X-Received: by 2002:a17:90b:2b48:b0:32c:2cd:4d67 with SMTP id
 98e67ed59e1d1-343f9ec8fe5mr2125210a91.13.1763103105211; Thu, 13 Nov 2025
 22:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922154303.246809-1-siva.kallam@broadcom.com> <20251113114348.GC10544@unreal>
In-Reply-To: <20251113114348.GC10544@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Fri, 14 Nov 2025 12:21:33 +0530
X-Gm-Features: AWmQ_blynz3VTHTgCy7gBRkSNijZUVCCfLqGKZEZ-qJNOtGDjbdQoZ4REubWFZE
Message-ID: <CAMet4B5SjY-6_dGU8g1tGcnkoxasi3LafJkeYR+QPTCETJWv7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Introducing Broadcom BNG_RE RoCE Driver
To: Leon Romanovsky <leonro@nvidia.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, usman.ansari@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000055fb340643886e11"

--00000000000055fb340643886e11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:14=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Mon, Sep 22, 2025 at 03:42:55PM +0000, Siva Reddy Kallam wrote:
> > Hi,
>
> <...>
>
> > Siva Reddy Kallam (7):
> >   RDMA/bng_re: Add Auxiliary interface
> >   RDMA/bng_re: Register and get the resources from bnge driver
> >   RDMA/bng_re: Allocate required memory resources for Firmware channel
> >   RDMA/bng_re: Add infrastructure for enabling Firmware channel
> >   RDMA/bng_re: Enable Firmware channel and query device attributes
> >   RDMA/bng_re: Add basic debugfs infrastructure
> >   RDMA/bng_re: Initialize the Firmware and Hardware
> >
> > Vikas Gupta (1):
> >   bng_en: Add RoCE aux device support
>
> There are some nitpicks which I wanted to fix while applying,
> but it doesn't apply to rdma-next.
>
> ...
> Applying: bng_en: Add RoCE aux device support
> Patch failed at 0001 bng_en: Add RoCE aux device support
> error: patch failed: drivers/net/ethernet/broadcom/bnge/bnge_core.c:296
> error: drivers/net/ethernet/broadcom/bnge/bnge_core.c: patch does not app=
ly
> error: patch failed: drivers/net/ethernet/broadcom/bnge/bnge_resc.h:72
> error: drivers/net/ethernet/broadcom/bnge/bnge_resc.h: patch does not app=
ly
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> Press any key to continue...
>
> Thanks
Thanks Leon. We will fix it in the next version of the patchset.
>
>
> >
> >  MAINTAINERS                                   |   7 +
> >  drivers/infiniband/Kconfig                    |   1 +
> >  drivers/infiniband/hw/Makefile                |   1 +
> >  drivers/infiniband/hw/bng_re/Kconfig          |  10 +
> >  drivers/infiniband/hw/bng_re/Makefile         |   8 +
> >  drivers/infiniband/hw/bng_re/bng_debugfs.c    |  39 +
> >  drivers/infiniband/hw/bng_re/bng_debugfs.h    |  12 +
> >  drivers/infiniband/hw/bng_re/bng_dev.c        | 539 ++++++++++++
> >  drivers/infiniband/hw/bng_re/bng_fw.c         | 767 ++++++++++++++++++
> >  drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
> >  drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
> >  drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
> >  drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
> >  drivers/infiniband/hw/bng_re/bng_sp.c         | 131 +++
> >  drivers/infiniband/hw/bng_re/bng_sp.h         |  47 ++
> >  drivers/infiniband/hw/bng_re/bng_tlv.h        | 128 +++
> >  drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
> >  drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
> >  .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++
> >  .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++
> >  .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
> >  .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +
> >  .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
> >  .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
> >  .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
> >  25 files changed, 2907 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
> >  create mode 100644 drivers/infiniband/hw/bng_re/Makefile
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
> >  create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
> >  create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
> >  create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h
> >
> > --
> > 2.34.1
> >
> >

--00000000000055fb340643886e11
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fyIFUZVWSBcxHWtNNVK4Oi0mqSJut0p/SwfLg6IMaVBU9VdXgVmw35CgcX/9B1ITmih041Oz+Qyo
wTULsXik3lHJuyhYevN9h4259CoDPt+tpaykVaqa4luUmGv8k3F6aC4+fZl83ywHGVun9fBVk/GE
2hmynyIEon1w6Me72fdjaPht4V1tbZBu/76zGxBiBFc13nAKU0dYrvIGPgKN9j0HDuOVC7UhhdTq
Gw+wN3sPJk9D2VtNAzNGw0sa/eJF1wQiBy4RVYG9r0MCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYD
VR0RBBwwGoEYc2l2YS5rYWxsYW1AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBTNBMIvX7vsfxNYWor1Hxth
tmNmHzANBgkqhkiG9w0BAQsFAAOCAgEAJDoTbZO7LdV1ut7GZK90O0jIsqSEJT1CqxcFnoWsIoxV
i/YuVL61y6Pm+Twv6/qzkLprsYs7SNIf/JfosIRPSFz6S7Yuq9sGXNKpdPyCaALMbWtPQDwdNhT7
uJgZw5Rq9FQRZgAJNC9+HBtCdnzIW5GUmw040YclUNHFEKDfycJMKjSPez044QcDoN0T2mIzOM8O
Dt+sJTrC1YJ6+HI6F2H6igZUL79y9qYUz8FNshyITihg/1VBVCiMU9WRK3tNfUlLFzLBuTTr245d
xMh/e75vypL3qDSF4UG6Mpy++Plsnjfwab70KFFyCvNwB2hT1g/y8MLgslfxJl6fCyGdWqOmUB2J
QiuiqbSy8mlnucIPuGWQqqt8VBQjxKYIHdjXtkvw0uVvOHUC2QJWfGWDhMncxF5LFoaRPer4tlXJ
b5zmz9Mn+uQPQQLYUqYzs+EvX1REmGLGUuzlaNwAC20+8CVPY2EkU1mjU78+aW5Zbb2MyjQrLc6J
5IdkekEtk+xjpM992MC/aNMTpWIWhorGq8NmPXbuoUZf9MSi7WrVCaO69ro68FXPTErr/e13lJ/5
GAkwcxdTC+YVPVa/xpdHyAFW03/Oow/7fV8qjy6PAWfqEV97D2Tspc2aEFkbeuFS6UkPRy1OKjGc
/IUTSY4h9roe7Bh1ecqtofP9XL8E88sxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxoOshI0IGR+aGCCXkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEUp
txHROlq8MTApbhe+7PT6ftQlNB4VY803AATHgS/iMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTExNDA2NTE0NlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALSbtj02rFB3VxsiM8pCAwEfljvZX2JqoOr1DIaO
JTd73PZ1mGqYA3I9OWWtI3GdFGH32++YVhlvAAQMTjPVskUhMLxg68olbvc3HqWwlpGBgrntWmgC
pW5Tukhguyif+TDF9qx84x+BwHlTdfFVZwhayjN7CunfH2X8JoEOEiM86L+bGsEdkXZlQSYMQmUw
ZC0KG3CaXjfzBmel8WH6wYPQrY9x2QpjgAMYHnvTBBTWAtZVNtlFkBTdOg1Quudqx2h4O+Ir+rrn
xDRet8clUtNgLt0k0KLxS9GgkWF3KhlT3IYtneADR4fUKU6i8dKzmkEysduABK/I4txRbMPZ3+c=
--00000000000055fb340643886e11--

