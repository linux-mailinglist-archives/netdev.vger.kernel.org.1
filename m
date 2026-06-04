Return-Path: <netdev+bounces-295115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eO5ILng+IWpIBwEAu9opvQ
	(envelope-from <netdev+bounces-295115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:59:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9263E41F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=djAY8CMF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295115-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A3830C7170
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684A3A7199;
	Thu,  4 Jun 2026 08:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE625B0BE
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:48:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562899; cv=none; b=SN2+eSyv5JNw7XUR9OS3DVVQSuJMdGMTwLOD4ndc8TjwRRbbvWCwx9RaqU/BATzS0pexit+yofLPpT7djTZOsudkBLvgXJF5lNT3aEPi63lGkhAkZcBxJaQ6lqRZyvWt6tW5tTjLYY6XAWv7pQaf9pkLhnVyi+jaId2TJcuqc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562899; c=relaxed/simple;
	bh=ff1L/NMEv6IrgzuRMJul8C6mMqZeof/Dw+M6uv9veRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY8vAIQtOqIK0vKgtHTtxGBj7Drswai+M68uLqV2NfAPFSb2htkFTmhjsBLZsWIciSHxqtFQbRvIJOmPE4cPTcAnlKXQf+tGNgfvxJ39Qq3APx2I9qwhj6arM9qhI02uLNF2WQlLwiAs9993+2yAdFy+eCrzK1HwxcpLEoATTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djAY8CMF; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780562897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLy2ui1zH+xe/yDG2eZDPsP5/IZUw8RGdjLB0ACLri4=;
	b=djAY8CMF/CmuG6ycETQylzCXJ/TQlre+hXfd7lSakCrcMJVTl1zp9p5TVlWHeT/gzcjTh1
	Op4ERQ5sUfQdV+0wkHoHNJaDt6kVKRr1xzGSzbmbxUlDWY37hBVHNPKLIVV7RvS5olrOkb
	rSk4b/+9RO9FjzPdJJZzpZ39iAYRJIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-hhwUpmD1OMuYdnB4wQYmMA-1; Thu,
 04 Jun 2026 04:48:13 -0400
X-MC-Unique: hhwUpmD1OMuYdnB4wQYmMA-1
X-Mimecast-MFC-AGG-ID: hhwUpmD1OMuYdnB4wQYmMA_1780562892
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BEA0195608C;
	Thu,  4 Jun 2026 08:48:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A45151800361;
	Thu,  4 Jun 2026 08:48:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
Date: Thu,  4 Jun 2026 10:48:03 +0200
Message-ID: <20260604084803.67068-1-pabeni@redhat.com>
In-Reply-To: <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com];
	TAGGED_FROM(0.00)[bounces-295115-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21A9263E41F

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

This commit removes the Receive Buffer Unavailable (RBUE) interrupt from
the default RX and DMA interrupt masks. The goal is to prevent MAC
interrupt storms when the DMA runs out of descriptors under heavy
RX pressure.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b03..b5fdc253a2f24 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
[ ... ]
> @@ -379,9 +379,9 @@
>  #define XGMAC_RIE			BIT(6)
>  #define XGMAC_TBUE			BIT(2)
>  #define XGMAC_TIE			BIT(0)
> -#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
> +#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
>  					XGMAC_RIE | XGMAC_TIE)

[Severity: Medium]
Does removing XGMAC_RBUE from XGMAC_DMA_INT_DEFAULT_EN prevent the
XGMAC_RBU status bit from being cleared in dwxgmac2_dma_interrupt()?

If this default mask is used to clear pending interrupts, writing a 0 to
the XGMAC_RBU position would fail to clear it. Would this cause the bit
to latch indefinitely, triggering redundant NAPI schedules on unrelated
abnormal interrupts?

> -#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
> +#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)

[Severity: High]
Does disabling RBUE entirely break RX out-of-memory recovery?

If the RX ring becomes completely empty during memory pressure because
stmmac_rx_refill() fails to allocate SKBs, the MAC DMA will suspend. Once
a new packet arrives, the MAC drops it and sets the XGMAC_RBU status.

Since RIE is only asserted when a packet is successfully received and
transferred to a descriptor, and RBUE is now disabled, it appears no
interrupt will fire at all in this state. Could this leave NAPI
unscheduled and result in a permanent RX path lockup even after memory
becomes available again?
-- 
This is an AI-generated review.


