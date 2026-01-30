Return-Path: <netdev+bounces-255154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOqbBIu2fGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:47:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7BBB537
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B4E9300D713
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CE30F808;
	Fri, 30 Jan 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYuvV0Xh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A02D97B4
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780872; cv=none; b=j404nOvr+oW14KrxFH6BLXYIX7sW8Bcxms/ltaWDegMCEEJUgDkWFRPGPikwkLhW5CHn9Ip21Ih+xDMgDR/b4PliNEopTof7FLX0TFg0BVoDmVzBzeYzmPVnSraw76mzgZuivDtp8S7N9rUQl+NJHTEXDE9s6Avhe7Jofad+eUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780872; c=relaxed/simple;
	bh=d95vyHE5VFHsMR0/siOYn9RQj1yoKkTPxH6ixL5nFHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOWtRki7HWndj09TKtzAf4nf4+0q+qYIfymbpEEi1O0G1+IFKL40rKUD5edJ1c0tOsZpQPmBGAjYUpkKt0yOQFls0t3s9viaKwC+T0cAg1i52hja1ZcTKdXAUjclK0YDz4I2qvYcyBLRVy6pusoQJcsyIZjgpg88pIe9KM9kJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYuvV0Xh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8849dc12f6so323795666b.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769780869; x=1770385669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EdujWQoBAn/IwVhOEaFp9E9St0lYVYzZ1tCazrBN34=;
        b=VYuvV0Xhf5fokEsAsNwZZZl3EiUuLvO5zLf3bZcXOBUKzahCU7P71aD2YAgIKS7isv
         cOa4wLaPwGYXxCOtsUxV1MrWqCbyb1LFBatKJGlEzHJHMaBCoVmpnZTCy/LeptW7AzHR
         AYQEPgol9jDbXCfvej0AJiXmoKPls6VzI4qgyIswj4UXKxIPHi+vhusJJnZlUjLln66J
         +BAdUW3F4LMsNYzSiQ3zDWtL8KXMD7WPFEvLAf6kUfgKvNEEQmBVVN61yWI+qVvhUKdZ
         BU/0+hhAgNCG8Oy9i9NoLHYsTGYsEfWWT+GVhDk+6KpYnOl4QKd/wLcy208KwMTmRXsC
         RX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769780869; x=1770385669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EdujWQoBAn/IwVhOEaFp9E9St0lYVYzZ1tCazrBN34=;
        b=cJI2gaMxR9CvREN3QeqEZ/ixUkXpKnfGn5wXT7Z9qZFbSrU6086+fT4KDbyJfaupfr
         VFvyY7XHG9Xj8tSkPiTZhAj27jUDulsEjULdcTaK8j7jnJuFrp2HCGqs8AJqh+1oPiXg
         cjHYYUTVxHAlJHzFMIzgz6a0rJzOmF9xsqleoWQkwH7zZUuWcPwUbViXEbdEonxYR6gi
         Ewy7NuCv1nH2YZ0gWkUAjq2Q47KJzMn19hbwyPrxGCtIePJTKKZwjuqmRbTABBhAAftR
         ZDvWJLO52JXKf4n42So1K/+H6uWhNBCpdt/qfPDeUku51l1pmUnvRPArpoBKuS1d+6T/
         RNig==
X-Forwarded-Encrypted: i=1; AJvYcCXM892dPlCkzJ1AyrAmr1UtCmFxOk1WBWfH+bXIy2JbFovyz6AjE/Ex9S157HaN1AUxXSIZcb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyad2qQ2IFWEDFD0fJ5UwX9rCA4SOD9vTPxdmTJPj7MFaAISm2u
	oTE1Oc2cpQmCctGiIQ2Cij+JmR3NwbBIQA/q6gT+1kxcrdwNRlKc29TXqglLiw==
X-Gm-Gg: AZuq6aJH1km3tR95AgQW4FgZOaEfvh+/S92Lap4NOAEkh0fTRD66PW75lp84HSYXutm
	Wll/2IqanDB5OxAaUWyqvwWcC6trGv3H8XYQfsftD47JTtlXeLaj8EdrYChvm45rSllM7yeGMxB
	xxopkWWIHJFLfBo7tiFrolkfFdosZTr5OYW17Ar1O7NAzm9mzDxajGZEtDq0gK8NHUIte2kBSbd
	edSEUS9HXH871vGHq2O6TH5Kw0p2hVx+OZvLzsQNify1FDNFL5qF8F6P5BZJZnH7gfZITcK69yf
	UAI9WmloIypRKvkIHmi3dy/IoqJgH9+LW97JfhAnDodE9yL2M+IaNU+fSbhrpqcXJNVdUgE1nGs
	0Lwgw8dUBjI5mCnX+9n0NnB690jSOHr8iWtpHmvWsuyWQfK52MGSufieo/KSHs7C3yJjx/NmQPC
	P3b2lJgP+oPwmotjnZE7EOsbEQJv3LjftspLA=
X-Received: by 2002:a17:907:7212:b0:b87:daee:a6c4 with SMTP id a640c23a62f3a-b8dff6846admr145665366b.36.1769773667338;
        Fri, 30 Jan 2026 03:47:47 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bd64:2984:fe71:7633])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de3046abasm243751266b.2.2026.01.30.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:47:47 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next v2 0/2] Add support for Renesas RZ/G3L GBETH
Date: Fri, 30 Jan 2026 11:47:38 +0000
Message-ID: <20260130114744.252533-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255154-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,st.com,synopsys.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,foss.st.com,bp.renesas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 83D7BBB537
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The Renesas RZ/G3L GBETH IP uses Synopsys DesignWare MAC version 5.30
compared to other Renesas SoC such as RZ/V2H that use MAC version 5.20.

The RZ/G3L GBETH requires an extra clock compared to RZ/G3E and has pps
interrupts. Document the Renesas RZ/G3L GBETH IP in bindings and enable
the Gigabit Ethernet Interface (GBETH0) populated on the RZ/G3L SMARC
EVK. The eth1, pincontrol definitions and hotplug support will be added
later.

v1->v2:
 * Separated ethernet patches from series [1]
 * Collected tag for binding patch

[1] https://lore.kernel.org/all/20260128125850.425264-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
  net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC

 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 77 ++++++++++++++++---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  1 +
 3 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.43.0


