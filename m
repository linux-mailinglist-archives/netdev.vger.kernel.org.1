Return-Path: <netdev+bounces-300790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y0ivA3VdNmr0+gYAu9opvQ
	(envelope-from <netdev+bounces-300790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1576A8AC6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:29:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZCRTghDU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300790-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FD993002B0C
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C443340DB0;
	Sat, 20 Jun 2026 09:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93421A7264
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 09:29:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947763; cv=none; b=mp68ugjUa1oe707SjWh4ak+xlJmow26qmP2tUNinaXdaHPcLGm33jqXUpEdm4c9hrEDDX2xU4p7SpRW8ABiCKEQfeAKhWPCFgw7ZOgPs5TjY0lFbIARldBrOGNJaykue+ZLl726zoppC+Do1BtpfGcVrZVAhEh72EgRL5T1MK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947763; c=relaxed/simple;
	bh=5APvOQGjBXdDnIo4nhOU+JqLJI07zTuCW2waT0JM4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAJhvgvLzAc8VZcuWK6w9zGuRdxbNIsOlSPfvZdrqmypUo15TPMMHug3p8tKvtEO7d49XGLKlBIbXUKCWDoR0f7YYMKzBSOxLBpHPr+OYzKXhH0OfQ5EBJB74Fmhcs37sF9epiyhl+GFQs7xso1QUtUXLwXTc0aZPvd6CMzs3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCRTghDU; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so20715045e9.1
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781947760; x=1782552560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G7AUd5H2ycf67BaRCEhRwe9JqDuDQY8lDx0k8sMpCM=;
        b=ZCRTghDUuZAPU1FrQTp7UbR0QkBJAbCzeenXF1xqpORz+jtn+HLfGUBWTYM2b44Vt3
         u0+2GctwQkmdy0Gmk6Ou+6zSEg0dBi0VG6U3UfzAl4yGt2ThcP167lUtwmF/72sMrzpE
         qtb4KeGHWCVmn+EMIMM1Fs/nx5IEbBcVzFxpB9lRANy8z8iQzUJa0QpHGKbn9e/KEJL9
         lW9yvtoktEpIEcVJPzOxoVfiClrW6y0kGksLjjJm+MksdDT+zvCk8A1All7Wb13ObWkB
         VZ2ZFkIlOd6l0YWU1gLqe06Jlj0XEWr7q3uWRfRX5/ncX3Sf3fEEVRfBr/Q2BHjr49qb
         Nxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781947760; x=1782552560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3G7AUd5H2ycf67BaRCEhRwe9JqDuDQY8lDx0k8sMpCM=;
        b=pIsdM4W/92QlYWuNNhPj5DxvUtJtTlx43whMgm7Mfg24dwUyIYUaZJdLVBWT6DaGU8
         wIyNxyJQdLRlSMbWWizrRvAV3SaUx20iF9p+NDBdGb24P1LGb1EYzTWjzbemtFRoz0OZ
         v7SHhtrjZYJ5kjOITh1YalHbSZReN/JaawxoevNhggx22RK7G3CkAqANvccGCnkVgs37
         2q0YiZDYaNwhmjRm8YWhR0CV2kq9+mKa1kxkHFnsgH1X7KiElgR9J7eTuNrzKlCbY2rX
         kWd7yUeunSyqs3aA3QSBgvb0Si0uBe+5vHWSH4hADme7uxv0UrMPQw4O8iHv5hWTnFjg
         t2jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ooFR3TFSGNaWB/FVgM3SLaKGntmh9sA9xbe1+2bI8N2DeRFswV9fT+ILAXVa+w2P4ZU0IcSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKymbrehyyVE6U+0gj+08PnC+/4lvDNnBzlBB3qWMVTe+YBljP
	RVVrD++4bvQkgW0G41jDTWwHotSopBrLPdAzsgU8BOWJkq+Sc+6IZMId
X-Gm-Gg: AfdE7ckq8CISDuvn+RF3fbnFbDlU9uC6aMH4usuLYkWWi+gUa0DY7rdcNfkPLMvtlJO
	nDeUxOnT58ZjYjpqdnwjWL91KkP9JVJPcPhFURLqq61z4NisR4x6OYCc7AFEAJIzKWFvWVEbtN9
	OyLpWcZ3hMuDn3DggCKaRlUDolHCSkqxtHhkqw2cYHgOeO/8eQjTwwsB/73jRJ8oLBPecQbXl5r
	yTzLGmjBoGj7AEPdfKwgk5tsR6pZgTanw0hA1jwxq0kQGxtJS0q6si5t8lOZUuJZyR3N4ojPPMF
	aq8fBDt2gdj+YOiiI9o2LtnAIGyHgDT/fpJAxR4pLwASxqlBjxk5Dvawtmy4njbNn6aXhK56fmp
	nNkIfvTndc6dej/OzpdBrIBk3zEh9KMWRTjU7uao0WKBunvF4zvadbymeQUSTlwoCTlGWeig3jA
	XVFmM4WZORlVE3hV7Fy3PPkyvD2/wdAg8xUj6260/rStBdvnDZ31JgT7T/7NAJ
X-Received: by 2002:a05:600c:45d5:b0:490:bb3e:30c2 with SMTP id 5b1f17b1804b1-4923f56c0bbmr114244515e9.18.1781947759946;
        Sat, 20 Jun 2026 02:29:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667881bfsm6721948f8f.22.2026.06.20.02.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 02:29:19 -0700 (PDT)
Date: Sat, 20 Jun 2026 10:29:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org, Samuel
 Ortiz <sameo@linux.intel.com>, Christophe Ricard
 <christophe.ricard@gmail.com>, linux-kernel@vger.kernel.org, Jianhao Xu
 <jianhao.xu@seu.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: st-nci: use unaligned accessors for frame
 length
Message-ID: <20260620102918.7f3e0eb9@pumpkin>
In-Reply-To: <20260620090536.1701282-1-runyu.xiao@seu.edu.cn>
References: <20260620090536.1701282-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:krzk@kernel.org,m:netdev@vger.kernel.org,m:sameo@linux.intel.com,m:christophe.ricard@gmail.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:christophericard@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,gmail.com,seu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A1576A8AC6

On Sat, 20 Jun 2026 17:05:36 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> The ST NCI I2C and SPI transports parse a frame length from bytes
> received from the controller. Both paths first read the frame header into
> a local u8 buffer and then cast buf + 2 to __be16 * before converting it
> from big endian.

Then align the local buffer.

	David

> 
> These are transport byte buffers, not __be16 objects. Use
> get_unaligned_be16() for the NCI frame length field in both the I2C and
> SPI transports.
> 
> This issue was detected by our static analysis tool and confirmed by
> manual audit. A focused UBSAN alignment validation kept the original
> access shape, be16_to_cpu(*(__be16 *)(buf + 2)), and ran it on an NCI
> frame byte buffer with buf + 2 at an odd address. UBSAN reported a
> misaligned-access load of type '__be16', and the trace contained
> st_nci_i2c_read().
> 
> The driver has the same source-level issue: the transport helpers fill
> u8 buffers, and the length checks only prove that the bytes are present.
> They do not establish a __be16 object at buf + 2 or a 2-byte alignment
> guarantee before the typed load.
> 
> Fixes: ed06aeefdac3 ("nfc: st-nci: Rename st21nfcb to st-nci")
> Fixes: 2bc4d4f8c8f3 ("nfc: st-nci: Add spi phy support for st21nfcb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/nfc/st-nci/i2c.c | 3 ++-
>  drivers/nfc/st-nci/spi.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
> index 9ae839a6f5cc..29fdb4ae56e0 100644
> --- a/drivers/nfc/st-nci/i2c.c
> +++ b/drivers/nfc/st-nci/i2c.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/nfc.h>
>  #include <linux/of.h>
> +#include <linux/unaligned.h>
>  
>  #include "st-nci.h"
>  
> @@ -120,7 +121,7 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
>  	if (r != ST_NCI_I2C_MIN_SIZE)
>  		return -EREMOTEIO;
>  
> -	len = be16_to_cpu(*(__be16 *) (buf + 2));
> +	len = get_unaligned_be16(buf + 2);
>  	if (len > ST_NCI_I2C_MAX_SIZE) {
>  		nfc_err(&client->dev, "invalid frame len\n");
>  		return -EBADMSG;
> diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
> index 169eacc0a32a..1326c20e43fc 100644
> --- a/drivers/nfc/st-nci/spi.c
> +++ b/drivers/nfc/st-nci/spi.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/nfc.h>
>  #include <linux/of.h>
> +#include <linux/unaligned.h>
>  #include <net/nfc/nci.h>
>  
>  #include "st-nci.h"
> @@ -130,7 +131,7 @@ static int st_nci_spi_read(struct st_nci_spi_phy *phy,
>  	if (r < 0)
>  		return -EREMOTEIO;
>  
> -	len = be16_to_cpu(*(__be16 *) (buf + 2));
> +	len = get_unaligned_be16(buf + 2);
>  	if (len > ST_NCI_SPI_MAX_SIZE) {
>  		nfc_err(&dev->dev, "invalid frame len\n");
>  		phy->ndlc->hard_fault = 1;


