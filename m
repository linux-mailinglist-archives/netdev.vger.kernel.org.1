Return-Path: <netdev+bounces-303812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xH+YNKdwRWoHAQsAu9opvQ
	(envelope-from <netdev+bounces-303812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:55:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2186F1265
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:55:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="egVl/b34";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303812-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A5A93134C18
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524FC42A78F;
	Wed,  1 Jul 2026 19:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380B4252DF
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 19:33:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934400; cv=none; b=VY4UzMM/ak49oDlnjfamlIiq394NIMu/hnQWsPNlG9+1n+VZG2lJ+m3AOwHtXndzM1pCfm0OvcO0WMjQlfN2m6/i5dLHl9Fxo+nqRj3/kmtccTmvJn0qndoXpeXcjBnI4jCy7cQW/Gm0WaUorw9VY6rgimZnoxrz4rzsYdRCp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934400; c=relaxed/simple;
	bh=EzcyK8KQAPq+xS3KRabSKUrzFYSXclGEAobTC9euuq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMRAfH/YgQG200vfGlWmqxhnzsvt4KRrb9iSvib6wHLwm9Y84rQhHUIO3SQmT/yF1feRfBlNDZC1AUhhJmh4zFdwSjFQSZewXSsMrHv3SKu35GGN9zT4yQ86pN3DWor65s3upy1rSvSTJOcYjQnUenCQI9Ou4hl2SE6E8gNDJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egVl/b34; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47248615e4dso1049356f8f.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782934395; x=1783539195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaXEKLb5tE0UPuqTQ/sKkozLzOhIqRiW5VBP89Tj6dM=;
        b=egVl/b34US0vfBZGM64KQFas1mtcT14zbOBqaucQ82349CPJ/squ/zwmxEHq8Nt95z
         HQRVxHMb53e7e0DgZ0ehC83sQf6uRK1i+BTOWSOkh3ELKxpBC9vdHAVl1vXP6H2T0h5f
         vpNQb0VR+zatkPK2NzIYkOoTtl5Nz1CFoqIqmtkDpVD1rATywguxRhywWqx2hH6KbQRY
         rjD6yL6XBJ47GQZ4vWdsru9P1RMlKVHAFMVWgoCB60PZg9O4qQjKB7ovb4xqi0md2lgF
         QpJ7uYgJDV8vdbx8xMUD6BwjuXzHzRKJxRMExpOgOy3CbyEKV+PzBZE/eLkcKajuoWVd
         eD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934395; x=1783539195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaXEKLb5tE0UPuqTQ/sKkozLzOhIqRiW5VBP89Tj6dM=;
        b=KNwzfjZI7yy1gT99UFk+ygaUsv8wbEXBB6hHbVdKs9bnNzvR/1LQBw0vKcdCWsz7oH
         eecDe1wozrEliBfoc3q+9Mf8unNWG236viBCu+Kc8+pvnUcWX48AZmPO/9vRR3u6wNxj
         GtNBmnAey9XP8QZ4l5be9FhrOUz86jWkThmfFbwtOoSnZnbpRcptR7iMTuy/bH/+UUNc
         P+SZAcO2LP98bOARoW1xgPLH/ZMu26ceyiWkFk62XNtVg0XoiFK0+C0y5UG6JI2UP0ac
         YX95YYKNJKla4MLmxjUJ2mcr+21rOTp3mfwJJFvEdGUVsmS65P44Lw/iuIo/3o93cS51
         LCXw==
X-Forwarded-Encrypted: i=1; AFNElJ9k+OVJFJCpSu6tu2roBDB/c04lGL3k/Ceb2BQY+8w2PaP//Xc5jzhrh7o/R6WL8fto/DB0q98=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuCMdBR8333Qu6JAHs28ou3LN3y78BswZOaFl75LuujGISwcp
	2ffpsE0jfWohekW1Waqdd1bpQbJt9RnDcaFAILHsJdR7l/9geOWlUl/f
X-Gm-Gg: AfdE7cmxvu2uYWm0KwLcKQvhOv0DW3sYCBEjpFzxnOQiQkUXVi+B8TjTpH5QgFZKrkr
	ZS7rfdwiSjj+BneezciS89wWt/WWHiBpoI8L4nph16DYJIdJeo20ZMPKF9CsBIMI/XQfMUVLoAD
	vtXYLk0nsboho2FDr6lhgBWqskfrUFquumtIWTCnXt2+HIowfoD4aC7oQqPE1joT3VfefrMMsIS
	AwSLNI6zxW6VdD1p8igsXWkKLCVY56RWBzxLPLuI+mlu3FfeFyg2gFDJ83Vgdh/vRTHawIJrh2a
	9GRLFeR2AmvbvYYEkKyCvhEE/YuYZpeQXFQRTOn/iHXATPdSpUR9eqWEVXsFLlcXjpw6ytX3JHO
	qBKPi0ZGPcaVhzFKZJypYZTHcsg+LwQOpamjPeRD4mUY9tnfyhFBl7xWv+DozeOP9c2Cnfbv9eO
	YePtyfPwpfI7YGa1ScNaVETIM99eZtIcqvIjnWcTKSy5C2KQ==
X-Received: by 2002:a05:600c:8217:b0:493:b91c:6bf with SMTP id 5b1f17b1804b1-493c2b7c93amr45574945e9.18.1782934395222;
        Wed, 01 Jul 2026 12:33:15 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfe7427dsm46471655e9.2.2026.07.01.12.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:33:14 -0700 (PDT)
Date: Wed, 1 Jul 2026 20:33:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Baran Tuna <barant@fastmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, netdev@vger.kernel.org (open list:QLOGIC QL4xxx
 ETHERNET DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] qede: Prevent possible snprintf() truncation by
 bounding %s string format
Message-ID: <20260701203311.5e819163@pumpkin>
In-Reply-To: <20260701144713.197557-1-barant@fastmail.com>
References: <20260701144713.197557-1-barant@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.com];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:barant@fastmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leitao@debian.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fastmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF2186F1265

On Wed,  1 Jul 2026 17:47:11 +0300
Baran Tuna <barant@fastmail.com> wrote:

> GCC warning shows that formatted strings may
> exceed the fixed-size destination buffers.
> 
> Bounding the %s string format
> so the maximum formatted output always fits.
> 
> This eliminates the -Wformat-truncation warning.
> 
> Signed-off-by: Baran Tuna <barant@fastmail.com>
> ---
>  drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> index 647f30a16a94..5428f53150a0 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> @@ -618,10 +618,10 @@ static void qede_get_drvinfo(struct net_device *ndev,
>  	if ((strlen(storm) + strlen("[storm]")) <
>  	    sizeof(info->version))
>  		snprintf(info->version, sizeof(info->version),
> -			 "[storm %s]", storm);
> +			 "[storm %.16s]", storm);
>  	else
>  		snprintf(info->version, sizeof(info->version),
> -			 "%s", storm);
> +			 "%.16s", storm);

That looks wrong.
The code is using two different formats based on the length
of 'storm' but you are truncating it to the same length in
both cases.
I think this will work:
	if (snprintf(info->version, sizeof(info->version),
		     "[storm %s]", storm) >= sizeof(info->strorm))
		strscpy(info->version, storm);

-- David

>  
>  	if (edev->dev_info.common.mbi_version) {
>  		snprintf(mbi, ETHTOOL_FWVERS_LEN, "%d.%d.%d",
> @@ -632,10 +632,10 @@ static void qede_get_drvinfo(struct net_device *ndev,
>  			 (edev->dev_info.common.mbi_version &
>  			  QED_MBI_VERSION_0_MASK) >> QED_MBI_VERSION_0_OFFSET);
>  		snprintf(info->fw_version, sizeof(info->fw_version),
> -			 "mbi %s [mfw %s]", mbi, mfw);
> +			 "mbi %.10s [mfw %.10s]", mbi, mfw);
>  	} else {
>  		snprintf(info->fw_version, sizeof(info->fw_version),
> -			 "mfw %s", mfw);
> +			 "mfw %.16s", mfw);
>  	}
>  
>  	strscpy(info->bus_info, pci_name(edev->pdev), sizeof(info->bus_info));


