Return-Path: <netdev+bounces-244384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC1CB604A
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673963020493
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0F313298;
	Thu, 11 Dec 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8MxOb2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC2313529
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459583; cv=none; b=tC7uAzwP3L7g7DS2UiBrCj5FYtCcszuqodtQ3lzQJXQKeZbH6siGUMByMuVTOMdiQWPorrJKVuGhhO3KgaI2cWYVs4AGhXlv1bV9Rcta0k317YhmNUCGujXKusFUXr6s/Ljtct7cfXXx1wx96s76r90h6Hpp9hEsttVrnjIet7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459583; c=relaxed/simple;
	bh=g4EZtkPk8SWeZdiy6hP00m8tmMqkLZiYMlk+LWYtQUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgOFxWNq/EMkeFFZ0xH23tyt0hwx0dgfzhl8/KNre3dDLlb7DEcxqAFjUCpOcN1nZ9e9JWoEP9bpcGEOzJTHitp2inwUY2xfUrcDBSZB5JEkPiw+84+YSrqAgMx4E5rHAdE6/3E0vpknsnX90a4Kjn96cLnJ2zLfsynqVTg4QcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8MxOb2u; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2e40582eso65393f8f.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 05:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765459579; x=1766064379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlfuqWd+wXy1Z6z/5IbBi7MVW3SrOYuOUgMVtqsk6rQ=;
        b=L8MxOb2uljsVbiEyIovNw3uL7W7zHBpVLh+IgmGwnmIyulhbXw1qevwovmiK6aj60L
         PJhbIgFIu7x77pxe9LpyKa2qjzHpi6w+Ak95hszwXgIdkEaP2IDAdo39Hgx8KgJ0Edrq
         fBK3UoBKAPhwEUvKL2DxsQ9mO0jRU7+WqxyeXp4ke2uQ0qQvdvnwxvSnuuSR/f8ovL1Y
         hKTj1WSlzRNVehjZwjg2jBK+BUn0ueeu5oTav8N1l52bHFHq8Jlm3Q90TdkBqzVLeAhY
         /d7c31l2Gb6kDsACyuQlcXg6nAYDP+Xocz5p61ynDD/tdc6u/VWGsQbrCPnqBrP8avdv
         /f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765459579; x=1766064379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlfuqWd+wXy1Z6z/5IbBi7MVW3SrOYuOUgMVtqsk6rQ=;
        b=UsJHT32IefIm5Oy8tvmZegd8NbGaXkaaVXF13A9dDxNmFEudCf0I6mmbVPImKebrqI
         DB2WmVagtdkgytU48szMDXiU59lkk/EtKn1QSSgJweh4Zc2p7zgzCooWvNl1bCWaUZnO
         FyDiJpd8BiGNYcT1U8CozWkjgyogRwW24EgpO2BStX5mCHSMv83/YBa3OaAMoOpQlnmE
         8MrFThgiwoaNsC7CEEA1tKNt5vDRJZZSptwX2axSV+GUfx97M5MElVP/iq/0NSqExRdv
         8AmGl2dWvHdU+NaJ7WHxyREvtfP4Tv8RxUleDvcxmEL0v6hdLDqIpJBdfiFTY8CBAcHN
         09QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1ASxyheRbpsCwY/UJPhnOvHwB/OJqlyxW9ZEfAW1VIdgdKk4tdI7b1Z7EAKII8dJx6mhEBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh70Q9zjt8YFohGMvoufCRVhvUV/QvtFN2zU7UoEZaX9QhEwZi
	11a1PWAN+RkLujzGSwSm3p6YWFmhsjBRRRi1PMpGDxYtGwom1zo2481R
X-Gm-Gg: AY/fxX6OzpvaAhvlT+lU+y1hv/vIeV79E+4XRrsk3euFTDd3ne/7/fiid3NCtQoJm/z
	Iffx1PeMjNN7zEza9uEMPkTcwtHKaQ0w8IboQgPicdpBizuPSaXMOkY1g4tZL/eRcYgcnunnUe9
	jn9mddVHDp2qSGQSheqHn32WDolGpWiftIoXHU4ZjVRPG9ycbpfMnLTyIzH/ykBQhFyT+9b9C4S
	1Hg+ULdXjyB2WmVyJdHBZ3VHKZJHOvTmDn2kx2kzF6wbE4X/n683RSlxjqlFX/7BgljZrRUjhcr
	IFxHO2fD80pS5cqhbxUfqyPTEcTt7LGyl23YKa4EkGLS82i/HOOgAoKlWn2bWBplsIhZzw2qdMJ
	kGcvtScV8bkRet8d98IQz8EaGmNNa1bXQ6zSV4KYws0EuF6WungZBF2b94bCObXDuC0fTgIIU41
	6R3TS5dP51eFYmY4MZ/HsYw1JbfB3Mu8A7tyXu38DCLIADHUnm+lgR
X-Google-Smtp-Source: AGHT+IH6movm7b2euzwcgRjXCZdmfEYd3c5Akj56OpLE2KX8CWu2MNAl4nC6XLt32a72nqxw++BF1w==
X-Received: by 2002:a05:6000:2c11:b0:42b:4139:5794 with SMTP id ffacd0b85a97d-42fa3b12ba1mr6655880f8f.58.1765459578915;
        Thu, 11 Dec 2025 05:26:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b259sm5539863f8f.41.2025.12.11.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 05:26:18 -0800 (PST)
Date: Thu, 11 Dec 2025 13:26:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sjur Braendeland
 <sjur.brandeland@stericsson.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] caif: fix integer underflow in cffrml_receive()
Message-ID: <20251211132616.0dd2c103@pumpkin>
In-Reply-To: <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 21:30:47 +0800
Junrui Luo <moonafterrain@outlook.com> wrote:

> The cffrml_receive() function extracts a length field from the packet
> header and, when FCS is disabled, subtracts 2 from this length without
> validating that len >= 2.
> 
> If an attacker sends a malicious packet with a length field of 0 or 1
> to an interface with FCS disabled, the subtraction causes an integer
> underflow.
> 
> This can lead to memory exhaustion and kernel instability, potential
> information disclosure if padding contains uninitialized kernel memory.
> 
> Fix this by validating that len >= 2 before performing the subtraction.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  net/caif/cffrml.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/caif/cffrml.c b/net/caif/cffrml.c
> index 6651a8dc62e0..d4d63586053a 100644
> --- a/net/caif/cffrml.c
> +++ b/net/caif/cffrml.c
> @@ -92,8 +92,15 @@ static int cffrml_receive(struct cflayer *layr, struct cfpkt *pkt)
>  	len = le16_to_cpu(tmp);
>  
>  	/* Subtract for FCS on length if FCS is not used. */
> -	if (!this->dofcs)
> +	if (!this->dofcs) {
> +		if (len < 2) {
> +			++cffrml_rcv_error;
> +			pr_err("Invalid frame length (%d)\n", len);

Doesn't that let the same remote attacker flood the kernel message buffer?

	David

> +			cfpkt_destroy(pkt);
> +			return -EPROTO;
> +		}
>  		len -= 2;
> +	}
>  
>  	if (cfpkt_setlen(pkt, len) < 0) {
>  		++cffrml_rcv_error;
> 
> ---
> base-commit: 559e608c46553c107dbba19dae0854af7b219400
> change-id: 20251204-fixes-23393d72bfc8
> 
> Best regards,


