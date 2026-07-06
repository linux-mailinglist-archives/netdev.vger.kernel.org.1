Return-Path: <netdev+bounces-304915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dYPxNJt+S2pOSQEAu9opvQ
	(envelope-from <netdev+bounces-304915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A89870EE93
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dBNxsJgn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304915-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304915-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB9132EA19A
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5013F54C9;
	Mon,  6 Jul 2026 09:15:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99036E48D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:15:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329314; cv=none; b=n3AwqvoeZi3t1qqg9I5j+ewbNV7To/1/BFs86iOXjuOoo3S4Qm83uv7nooCkHvquyGTnKV5i8uIoNYM53XdjPwg2VmU9JLrgXwZKif+VEB4PuY1puC9EV4wFYvq/LHLMWklETEX+nwZVbVEXCgMEvreQ9P+uroAuaBUhx5sNyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329314; c=relaxed/simple;
	bh=mcE6Yk5jQAt+Yt1V2EfWURtYiAgr7yrD8IJBZ/7gloY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+y7jfN/8zpV7KQaO0Zp/+CeoPXpiqrn9nm/oACPusH4hI0ScDIn8aH9+0/yYKtgrbRvVTqomIcMi2xVqB2b2zCQmkDma8JHZUpk3waHlWJRsiY8b3W0C3WFPyG9T7k987pa7loOb3/ZB03ASmszFSbkjp7wrs9Cksx9PgTnyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBNxsJgn; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-84783bce476so1850803b3a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783329304; x=1783934104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLyPjG5C5L4PyonbjPrLAmmPBiN4HQfMBWtrcgyX/W0=;
        b=dBNxsJgn2K6SnanIeCnSmeqFRUMbFUf3xgu+9p2ku66OhncMRGTqpP3y4bGkGfdXQ+
         1Rk6kpmFqbjqs+5Aw0Wix8jhCMIVyl6Q3EfesnOwNnljTxS++5Lmv90fLb2bQapoVAhU
         iq2JH998QszNv1VbNmWQvZbM2ipyNvQktyWm0l+Qk9yz94qmLskohpl3cTiSCWQ8za49
         6mDP9G0dqWANdIBAF3w1D4+0+/N6EKVU8/2nW+/NzCjftUg0pKWFPl4LcKBBJfzeh44w
         C7URJMQuKff+XBeBnUqYMPVgfQfO9Ugxp0Tzbzrxo7zvQCnIpNICfx0z9u7ID/4LIUYo
         bH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329304; x=1783934104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLyPjG5C5L4PyonbjPrLAmmPBiN4HQfMBWtrcgyX/W0=;
        b=JeUe6etNZUfFT9z/PWXZZG/HPhwW0wIiXWbfUIu8eAm8j4tSqBs4zn9H0m/rrh9AHo
         NrQIVtte/hNBUrUXXKVXi6qUyrn6IBnISLKl+CxGta991xiu1wzevxhERbx0DjAadA+4
         RGz0k7z6aLAtIBMlt1aMnyzXfmcTqhchQvI/9vz1Bfr18RCGTg9CoFHSldTFxflvshAH
         AGX/SyTjLM0C1zCiIi2sBwfBCw3L4+UJ48lyUi5Ks0qXBWuh65LLJk9Mqqx9g8lRxB/7
         RnE+eEaUifcSKikZYO6XjbXCtMT/sJNZ8SdVc1wZa5OympCK/thoDHBfzBPM/7lpqYju
         /1Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rr2E6HJVgi06lVezYC4+VCVcbOun4bjOCptuZA38mCQNEyJNOUE8PMtuCrQbm9cFJX8QX68+AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo/eUeGW1o4nmdDx4WvpljzENeIbeenBcfsgqNej4nRERr6Ph
	wQO3A7zrQqRWqLXQAaDfvWLkAPIOeme4bsDZPCfh8uTKTFwcUH4HX3q5
X-Gm-Gg: AfdE7ckl1wel+vnjlFuBeYnMuLwfx1V/cbi5MAaJOiUfs5wuBvnux5x/6lYFz24qMaM
	n2LnI+YNveQAUMRpNkYZT5cwuVS75D+CrDICrwGPVNg8bC75JlbxNaiuxTW9/u6ADT0CuKGU5dW
	AwdiB6pcsT5BUPT2+Fk9YOhh0x4zwnCmPFmvOV6lnrBlsuGU9TyMGiEahgqbF0oPKp9W4TZyV9b
	Jdoh0QuNvdLFKjMYCAaeb/SqdEAuMUhNc/gIqwOPtaf48rcARKNR4SRGwYiWkrXzerb1+1q0I0L
	7KX7qVHjS/ExqpTFPbY6MLDSNnE7Ofi3CVam2A4UX13ARMxq1d4MjuMtqH5udGtdRXo9ovsCh4l
	vEWKQoHjs3nWSgfCxLxykx80Y9tq16arYDGIZ3xsca1arPxq3HoNkTo9Ns7GO+emSLO7l45qOP7
	r+sZ3xxc483MYJZPFDrxCvh4QU
X-Received: by 2002:a05:6a00:928d:b0:846:c7f4:74d with SMTP id d2e1a72fcca58-847f6f4dc63mr9274624b3a.41.1783329304103;
        Mon, 06 Jul 2026 02:15:04 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm3445963b3a.53.2026.07.06.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:15:03 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Mon, 06 Jul 2026 17:14:41 +0800
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefixes: add alientek
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-rv1126-alientek-dlrv1126-v2-1-ff3176ca362b@gmail.com>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783329286; l=883;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=mcE6Yk5jQAt+Yt1V2EfWURtYiAgr7yrD8IJBZ/7gloY=;
 b=BxvGMeEMOJIcDK1cuZcQyswYfSolbuWRu2T2E+i4BOAKIXIhu8SvtnBgIthxgHZ8eezTIYref
 jRshprlBawRB4rPkB+L3GtuaunnK7RYifBztV8pZ/pbn8jfugmoNo2I
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,motor-comm.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alientek.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A89870EE93

Add a vendor prefix for Alientek, a board and module vendor used by the
ATK-DLRV1126 board.

Link: https://en.alientek.com
Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..914d5a8fd628 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -88,6 +88,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^algoltek,.*":
     description: AlgolTek, Inc.
+  "^alientek,.*":
+    description: Guangzhou Xingyi Intelligent Technology Co., Ltd.
   "^allegro,.*":
     description: Allegro DVT
   "^allegromicro,.*":

-- 
2.54.0


