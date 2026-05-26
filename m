Return-Path: <netdev+bounces-291692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GEoHhygFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1BD5D67D6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC28430EE9F8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DF8395AF8;
	Tue, 26 May 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEs28TuU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83C2D6E58
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801380; cv=none; b=RND4isK5bcuf5IOHeDTfGOUO4OcoVNKBQRF2KaVbYkFWPpeGT3e5cNJ1OIGcgPutKn0F6XcuNR7B+S6K/Te/3yeFB3S2XD0bZVbYG5+y0IqbWtn9LrmNaQVMG4ALGD/2pyMl2HtX0OqZk8TnYMWwM/4AgfR0I4aHUPSbe5iNtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801380; c=relaxed/simple;
	bh=WrfpjCxA5r0oPDsYbmyNko6pFpXTYcRQ4JwPnntAL1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFZ8BZ4oJRkhaJ5k2jncqCeNFVu3hhumAkC1WvmCMI6aoAXz7Vgq/0ePkwoOTC3cUExOejubATF5B2yiB0rxtsdoFHkVXb40tN1S12IAQCLcJqX3mIU8KPX1nrO7IgAiP65H4MOBdZv9RqdHhAeMOidZ/h26VXfkn7QU2kRr0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEs28TuU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779801378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOuBgw7R3FRAFaEEyLdwt7nIEM2/+t6k6wLOLkjxWfo=;
	b=DEs28TuU0z6e0KY8+It05CcNwd+IMxbIm4syR+hK/qbKMyyvHdGsQV3GZAODLHp6l0SnPy
	Z5UmaT7Sb+P5suh017n/jJdRFemnyFsQeDEvlLEpZ35QmcCQjqZ8Gv3bJ7m4zcyZIw9XYs
	CqYQQHRSdpUSYyxjc4iq8XGzWAzIimY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-CDksQCNpPk6jsWTZUmuDMw-1; Tue,
 26 May 2026 09:16:12 -0400
X-MC-Unique: CDksQCNpPk6jsWTZUmuDMw-1
X-Mimecast-MFC-AGG-ID: CDksQCNpPk6jsWTZUmuDMw_1779801368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AC4A18002DD;
	Tue, 26 May 2026 13:15:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C68A1800465;
	Tue, 26 May 2026 13:15:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: devnull+cedric.jehasse.luminex.be@kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cedric.jehasse@luminex.be
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Date: Tue, 26 May 2026 15:15:35 +0200
Message-ID: <20260526131535.185363-1-pabeni@redhat.com>
In-Reply-To: <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
References: <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,luminex.be];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291692-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,cedric.jehasse.luminex.be];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: DD1BD5D67D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
    net: dsa: mv88e6xxx: use the hw tx queues

This patch adds support for transmitting packets to specific hardware queues
on Marvell 88E6xxx switches. It exposes the hardware transmit queues to the
networking stack and modifies the DSA tagger to embed the queue mapping into
the priority field of the DSA tag.

[ ... ]

> diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
> index 2a2c4fb61a65c..96c8fbedbd3b4 100644
> --- a/net/dsa/tag_dsa.c
> +++ b/net/dsa/tag_dsa.c
> @@ -179,6 +179,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
>  			dsa_header[2] &= ~0x10;
>  		}
>  	} else {
> +		u16 queue = skb_get_queue_mapping(skb) & 0x7;
>  		u16 vid;
>  
>  		vid = br_dev ? MV88E6XXX_VID_BRIDGED : MV88E6XXX_VID_STANDALONE;
> @@ -191,7 +192,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
>  
>  		dsa_header[0] = (cmd << 6) | tag_dev;
>  		dsa_header[1] = tag_port << 3;
> -		dsa_header[2] = vid >> 8;
> +		dsa_header[2] = (queue << 5) | vid >> 8;

[Severity: High]
Does this code map the Linux transmit queue index directly to the 802.1p
Priority (PRI) field, potentially breaking hardware queue utilization?

The PRI field in the Marvell DSA tag corresponds to the 802.1p Priority
Code Point (PCP), rather than a direct hardware queue index. By default,
Marvell switches use a Priority-to-Queue table to map the 8 possible PCP
values (0-7) to physical egress queues. 

For a 4-queue switch, PCP 0-1 map to Q0, 2-3 to Q1, 4-5 to Q2, and 6-7 to Q3.
Since Linux creates 4 TX queues for such a device, skb_get_queue_mapping(skb)
will only return values from 0 to 3. Placing 0-3 directly into the PRI field
means the switch will see PCPs 0-3 and map them strictly to physical Q0 and
Q1. Hardware queues 2 and 3 would become completely unreachable for untagged
traffic.

Should the tagger instead derive the PRI field from skb->priority (capped
to 0-7), as the priority needs to represent the PCP rather than the
compacted Linux queue index?

>  		dsa_header[3] = vid & 0xff;
>  	}
-- 
This is an AI-generated review.


