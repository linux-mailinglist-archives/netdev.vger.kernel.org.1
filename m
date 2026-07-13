Return-Path: <netdev+bounces-307267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtWLBs0/VWpFmAAAu9opvQ
	(envelope-from <netdev+bounces-307267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3C74ED52
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:43:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=uD6pPQn1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307267-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1CB309A1F8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDF9357D0C;
	Mon, 13 Jul 2026 19:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36B357D0A
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 19:40:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971617; cv=none; b=uxdVvCRxid4Ew/xBSPDPT2KylQw2yIQeKb3nTMDpFzcqc/Iq/PFpm5iWLNB/wqF+w+5JsNfmaF3Sec0p5i/unzo3vqbBzgI+AJ+Q9gv3ctfOuybMn9XJ4/EhuHK/KcAAGKRf7Rv1VgI/yEm9u3QA1ZgMvix1AevADgvQWpElyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971617; c=relaxed/simple;
	bh=VoRT4Sj7jKJvwGFP+xKRlpFu/iYwkMQNWSEZEQFU07Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugAabL/uy6SUUdq3cjnxA5lgcH4Mn+y5Hutj/ChVfr4j3lOx3SNDCoBNkp7uypz+vAr2a4jmHnmni1cYyqR8ppMfYY8vR9VT3oDKq3RAd38utYQfIk2ZbvBsXmjIP83bYLaSkUeKKN8USJ5jl2ZGz35OVPNk8Z6uFptmtSkv6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=uD6pPQn1; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47d70879764so2275035f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971614; x=1784576414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FbghttrpgSK5b8Xdtw86Vlcl4tgPfJ678kl/v9nlCUw=;
        b=uD6pPQn1jIF0Arfes0oCTlHwUu1CcH31ayADOdL41MLvTSL4R/rhUOhaoUsiRKTVEf
         pRsEQWjjOOIGwfvFzZx+npNt669GvqUOxzxSltpF/CstTTEYSd9FRF+dEocnFODFCzJ5
         GtRVuSV9Okj/xdmhwCmYQ+pdYC/Qvek95bI/+E2ZF/J6UN7yiXRBRI8yHZWF033VJ3Ui
         pFRYgTV4XMOaDhHjYa3SU4A4kylxRYOt2ZAyIuCntDLum59ldUXmj2LAXKGV8cL9b3Ri
         QvBn1oJvChXXjqwLVUrJg7dYPTNnXpQT5//LYCML8OhyDejw3tAa790VgKiHvOK0ITRD
         gFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971614; x=1784576414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbghttrpgSK5b8Xdtw86Vlcl4tgPfJ678kl/v9nlCUw=;
        b=d9XnmyNfm4TUmLnWSKFKpgeYrFb2maFy2TTrRtCIsGYDOLpDfHJJJgTacODzAtJacC
         APIUXAAAFJfn+fgWjxhR+ShqjUKHIYzZieam8KLU7JVNkb+2URAgoQ52YxHXeT87y7yN
         vQ0Q45fPH7m498vkzU6NibHfxAJsJk5VG9fXLrLO1MJnf2UMI08HGHR/HFpciAx/1fZo
         Ah0YQbi1/9RDeX+h++zfjHpyY1S7IEsn9yJRmpnLPH/hnaQ0l4CBQypHm7d1iJYtQjkq
         JdSlDnvk2wNZwOfqc6BHkZgW7x1HzqwOEu9F69X87urprSuZ405dWRtslzPYrdJW1Qdn
         LylQ==
X-Gm-Message-State: AOJu0YwDbUJABRErOTXuxtGx4R+M2GanLdovwvIi5RXxONyDlHlWrHNw
	0fpdIlC1fQG/oqZ+xadKZP/MYVYj4jZGUGk4/zkrnwQwkSRRp+iAZBVqBEZMWc58I0c2
X-Gm-Gg: AfdE7cnJG8eSN3s8qELovTqbgaL5jeo1habfsW7i4SLdL7uAx/FLpytxZKAgtqfXtDm
	wTar+gnjgnFJreOuRjU4+2aFNGtqRRS7WBl6IaAdfCA9a53LstisS/YWQATpwN5jEajuPZn/8rx
	4KNNyPiZl4GM4512wKW/l6ddOTZ+QivmP7wAnXYw7zgML/XJTwdlGPVhOE95RXSSv8n8Ia5E4JW
	YygH9RFr7vuL/iq4UP/R0zyx5n1dAtnjPWpT7Mim2Uur2YJEhalpCIqs2ghxlry8agvLR/nrrs+
	UoI3dVRziMDjc9OQTQjkSOuejyXtAGqMKFPCNatuSQ872NBWCKv3sRzaTQrGa0SbVC2ujjN/Lrb
	0j/fm+qQIjXUi5A8RqJUTncM8Lum6O8Hnh4BuZADFRiEfliEiEhNiZe4e8UftwBHQNhvqZFi5II
	0hKnLhaHWebJNNy90Cok2HurAB1MpJtjOpatA4Tzn+tem07XRi/Tc6gI8JSirjV6o09ALzL6H2c
	UvAkhfF5MIvGpwGZ+dQ6MBeGJ5/USaWZjI=
X-Received: by 2002:a05:6000:240b:b0:475:f100:3607 with SMTP id ffacd0b85a97d-47f2dd02d0cmr13200382f8f.54.1783971614013;
        Mon, 13 Jul 2026 12:40:14 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:13 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net 0/3] net: don't read an unset MAC header on the raw/qdisc-bypass TX path
Date: Mon, 13 Jul 2026 21:40:07 +0200
Message-ID: <20260713194010.54642-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307267-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:doruk@0sec.ai,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:from_mime,0sec.ai:dkim,0sec.ai:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73D3C74ED52

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path, skb->mac_header
is left unset when ndo_start_xmit() runs, so eth_hdr(skb) resolves ~64KB out of
bounds. Commit f5089008f90c ("macsec: don't read an unset MAC header in
macsec_encrypt()") fixed one instance; these three are the same class in other
TX/.xmit paths, each reading eth_hdr(skb)->h_dest. On TX the L2 header is at
skb->data, so use skb_eth_hdr() (a no-op on normal TX where mac_header is set).

Found by static analysis (0sec); verified against source, not runtime-reproduced.
Confirmed by an independent cross-check that mac_header is unset on the bypass
path (__dev_direct_xmit does not reset it). More siblings exist (sja1105 shared
TX/RX helper, atlantic PTP path) and will follow separately.


Doruk Tan Ozturk (3):
  net: dsa: tag_ocelot_8021q: don't read an unset MAC header on transmit
  net: dsa: tag_ksz: don't read an unset MAC header in lan937x_xmit()
  ibmveth: don't read an unset MAC header on transmit

 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 net/dsa/tag_ksz.c                  | 2 +-
 net/dsa/tag_ocelot_8021q.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0


