Return-Path: <netdev+bounces-304250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6LPOHCxRmoLbwsAu9opvQ
	(envelope-from <netdev+bounces-304250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF9A6FC3E7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aZnIiu6C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304250-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304250-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C32033018330
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B23939A3;
	Thu,  2 Jul 2026 18:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A935F179
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:05:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015526; cv=none; b=nr7PURKyyjq3So23lujV4ANqkwvowCM/n6CoiA+Q41YXkqXquPunMZnoPJIzZEea6kjQ0d5MNsywW5oP6WjmB1NI7RmveMkJHBbahx2xRiEBomMLupGeNKqW1xp41TLQqFQ8CDNLi5hzTZEHnmI7Y9mlAMuiE1sLTN7lFVoXlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015526; c=relaxed/simple;
	bh=eXe6gHrIdzx3AbyH6byQKRn33eQMYZps1YSv6k53jyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qL6+wFTdhrO3uCSyefVlpt7sNjOFCS1HR7Q7uT9lfCsIumz8+niRzFuge4/A0/deLaB4PHSYhZbQ8e4AUV+tDTfdf5x+dMizCZJQKbo1UFE6PJKmK5/7BZg1ecRgHP77N+7bXLbORGVNccNxE395WiJTHaFFeFx5+kvod9ISADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZnIiu6C; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-847a69ba83dso1265140b3a.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783015524; x=1783620324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngrWeAFGWZKAuNlc7TaCDTTI9bO1M1TDbhwW7lrz4r4=;
        b=aZnIiu6CNcmCglYWhOCt2CMKuCKNv+GjcbVlbFL9L0Yb1V251gxgpYfRcBxtf7f/32
         MEC1oQjd3ZyGIyPMGYYzkYLB6BqdLGHXbCA3c5fCLdvQDK0lFfoPZIdX/xElxqGe1GBA
         yBeJ0MneHgFHU3RiQqh1+AJSB8AWO6sBOZ5VhsEW44yAEGyTpj9u5agEe59AAXcg/hV0
         GHXQC1CY0BSpFlxrdJzkAVughLy/PG6sw4DRep37QOSax5qy/pdbQxacdGAPl3u/Ezgw
         +2xKQeLercrDW+tMvORwRD7/e8y1Fhg5ad+bBwxyMf811oTC2nLbK2G8dEwbND9llT98
         WPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015524; x=1783620324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngrWeAFGWZKAuNlc7TaCDTTI9bO1M1TDbhwW7lrz4r4=;
        b=h1ozUrth95HyWLp4FNya7srvgiXqZN8xNS42caOzS5fkO2edsmPX5734vuH/pARgWS
         JByhTizeHiNgjjm62Dpkeqqg1430CnAzhiov5jaoZ7S7zwmRGCCd3C+kE+F4gkBLo8Pa
         2RJMR0uD97E/D5DKlPgzB640ztkl61mAdudWlc4tWOjP23KZKov6vnc6JDhIeqWwyGo1
         ko0ce5DIChtAy5hvQrHVhVBYdOfIeQfbb05/2gG6AlGj70jOuok3sjWVMkk/7NBR0WLy
         xhZa2obG49mS3vj/oZ2AT60oYz7MqK4HT2AcuIdrEwLOZQz8ykfu01jIw/J2im0ZmQ8y
         fuMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8w6t64TVmKQOTbZU76z66h1jt1MxA5c0tm8TdGMHkn3P8mtQRHvMfLblKhrNRepMzKHnu6HRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2/6jsUJLMdhCf/iCeDfFAZ3v1bRKoG4Hjur9+zqXxkKu7Wh+
	MsQAP0q6Q5NgTOqH/fC0YDiQRrwte0AkYQEDSVcHIHG3x8AoGKBDox60
X-Gm-Gg: AfdE7cm4WfhxDEcAO2i6OOw/z2hhrJli7YNZiuLIIFox5sqn+yTRDY3VYWuy9jELrKv
	aHj5PKCX4NkIAwCsV6daisLKt2klv7dzDTwkC+RMIWo5LjDdV62ZSde/LGPRaEVmkNbO0H+OhoH
	Pe032JVDXQ0ISybNZmM8VoytFAcILkWYHkMiW7B0iP9ZMfCA8tqBaDdAneVpSe7EMkKSSiFnv2Y
	AxD08pEjaWewNCZ++NVIGtbU4dLAfhooaTM1HzfCUZ2OoB5bmpiKETeKvrxq6QgcZnil5X5S4CS
	levta+ATe6tSPAA4AGfNcxLJ78bHiOHi6D0su7OPDRarLua9if7wCJCsmwRbUfcoa5evo2J7AMT
	SvJH0qySyK7zTFlFwGetOagBkb67eAMRS1Kix/IfRw+GJYodzIBhW4UsBm7ghrhrffkcJM5dhHc
	dlL5aH1R0b+jS+LlkSIvswrfbPRush6UloVoRIZwc2l28sthhC
X-Received: by 2002:a05:6a00:cc9:b0:845:e23f:108 with SMTP id d2e1a72fcca58-847c088ec3fmr6916190b3a.42.1783015524252;
        Thu, 02 Jul 2026 11:05:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78d69csm1701877b3a.25.2026.07.02.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:05:23 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] octeon_ep, octeon_ep_vf: fix skb frags overflow in the RX path
Date: Fri,  3 Jul 2026 02:05:16 +0800
Message-Id: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304250-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAF9A6FC3E7

Both octeon_ep and octeon_ep_vf build an skb for a multi-buffer RX packet
by adding one fragment per buffer_size chunk of a device-reported length.
Neither bounds the count against MAX_SKB_FRAGS. A long packet yields about
18 fragments, one past the default MAX_SKB_FRAGS of 17, so
skb_add_rx_frag() writes past shinfo->frags[].

Each driver now checks the fragment count before it builds the skb and
drops a packet that would not fit.

v2:
 - move the check before (napi_)build_skb() so the driver does not build an
   skb only to free it, per Maciej Fijalkowski.
 - the frag count check uses the same u16 length the fragment loop uses.
The repeated linear/non-linear code in octeon_ep_vf that Maciej noted is a
separate cleanup, left for net-next to keep this fix minimal.

v1: https://lore.kernel.org/r/20260701112825.1653044-1-maoyixie.tju@gmail.com


Maoyi Xie (2):
  octeon_ep: fix skb frags overflow in the RX path
  octeon_ep_vf: fix skb frags overflow in the RX path

 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  9 +++++++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 20 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.34.1


