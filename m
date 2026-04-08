Return-Path: <netdev+bounces-276701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNeONhm71mnLHggAu9opvQ
	(envelope-from <netdev+bounces-276701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 22:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384413C3CCC
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 22:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B555F301546E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 20:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2803DA7F4;
	Wed,  8 Apr 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzA7DMNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17708339853
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680279; cv=none; b=HbSJcgkcfdSkVvM19P0io9hecrXCQj3KJJZAnzzY3X1nGs4JljCupU2YcH7q2DBh3lFk+l8T2vwKs5mnP96Ow6ev22tH7RqZrMEotidzRatWe8MZJ/TiqlkrH4y0TDLcxg4GxiTPUblGm2823uI2V9A1YAF6R/2tdAqczcEoXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680279; c=relaxed/simple;
	bh=h8ZIAXsO1O6Av4gmoYRDT4j/bjB3v1Wytys4FQ2Y5Iw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qtw0HM8cyWFCbXtn88edsWJZSeCSBdP+g+yAkT5pAK3s+m8ucG5Zvrxfm5i0loT9V/5hwAtxhH7U0H+7yBJvXkic/FGRhjZ7n4fGXiPzQ0gnsYiRfBWlPVf2+P+hNL6xGzuunFKP4JEeKbFjIAyL7Zeh6fSVPD+0BDxdmvPVjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzA7DMNw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so106865a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775680277; x=1776285077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99FF02REYBGZGd3XmZSOdGpqAG1Mt1bdn2Q0CmrbSjc=;
        b=UzA7DMNwVcH5Se7VSqYva5YrCxttmwSXDGUA7Hj6d/1BFsoYgO4g5+EuXwgPyQKlLK
         /HunzYtkhj/f4xxKWpTTMoX9T1+7nMoDbrJa0NSM/XLAXRHaNiqKHw8Y59s1Y/jF/Qi8
         nELDt0a/+k6DuCXedh67m6ExWquHFqI7TAUxY4iCmL5gs8m3gXK002rDiSC5JFB/B2fa
         cWgyrXjdqPU55sCLjPTCqNZw7tcaGC8+NB3AzZIp+WeYQhOoO5sQLvhldvGmSUkvdY0F
         tWXhenSNnYbnPRYEGnadoIMKWq/ZaddIU3M2KXSwdmc3+ifEAIj6yVtPujk6boz7iXKt
         5YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680277; x=1776285077;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99FF02REYBGZGd3XmZSOdGpqAG1Mt1bdn2Q0CmrbSjc=;
        b=WsblM0OB2GqEpn4lAHS/tImHEb/wbeOz61YB0MVKmK1yDihl9lcm8HS0keRQhq2kRK
         IaxA2LrhPGp4ajFnn6jP86D93uDCKOyJ0zGeQP2pztBvftUpClvuxYvf8+OhkcBLsTGf
         L/7hUmN9wiwA6WWSYRV9U3xQXVAQ1CBqHk9kVvyaVHoeJ1b0UBH2kxnm6kazA7OYVODc
         jXtYNzAFQ8d9K65X/X/GEB/aYACRy3LkxCN/uCjecLJnBSG1IRMFjkxRDNINJaMxLt+x
         6WrSCJg6Nh8abp2myzaf0IBLFpDIZbQmyam1Ci4d/MkQ6GqLd8OoBkVO04LLaScrNaFK
         ClVQ==
X-Gm-Message-State: AOJu0YxTE538UrGOejyzCwnMB0AJKmMhEhWGT+UMjWsFBJJl1UJvqPjL
	Znydkm80yMWZ/pFAJ9nHcUp3tzq83OkRaoifyohyabBBBDtjhCisD+rJ
X-Gm-Gg: AeBDievlTQXPe1C1Z+gS7iUK6OAQxBWMIPhWkU+OlVcDdUTYb4SEF/kySjKmtIs/wqZ
	Sk3t55Kqzx4huhVAnMOT2fBX9EfNSj7xWhoO/je3gmiXXbllkNi7onlqC4vllfaJ9SjTANuYDXo
	rwzQfNSvuHD1t1qwBGIk/8BiGlVPIRgRflyTdL3UM1Mli0U4hnRkgnthHtltlZTtDiPbtTBLuZj
	uC9BD8aQz6diPegTR/uO8eGKf12CjhFVPIkEB+xWbUb9GtjH0G+BuWHvsi1ABTW8ts7gWmcnVf5
	oXts+0ROo7vtn4x4oMu1LZhCXF5kJZShobCwySugL2tN0JrWD722f081YSZe67QiNXgETfHoKx2
	rGOJBn0npP90ewNwmo/b5P2lMdtpJtFBDsaIw8dMHRPrW3bWp7Z+3LisnI90RD3gXRIZDni1UKY
	8/lHDQ36r5zgktqr+XkJ+dxFH3nTKOSrWjV5lQTA==
X-Received: by 2002:a05:7300:3b0c:b0:2d2:c60d:4fe5 with SMTP id 5a478bee46e88-2d2c60d581emr2996224eec.6.1775680277332;
        Wed, 08 Apr 2026 13:31:17 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d16d115c00sm9556512eec.12.2026.04.08.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:31:16 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH 0/2] net: dsa: tag_rtl8_4: fixes doc and set keep
Date: Wed, 08 Apr 2026 17:31:00 -0300
Message-Id: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAS71mkC/yWMQQrCMBQFr1Le2kBSSiNeRUSS+NSvEiU/SqH07
 qa6HIaZGcoiVOy6GYUfUXnmBm7TIV1DvtDIqTF62492sN4Uhkfl/XiWiWrowtZx8D7FiNa8Cn+
 iJXtkVpM5VRz+Rt/xxlTXHZblCw79CDx7AAAA
X-Change-ID: 20260407-realtek_fixes-e1a81e477cbb
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276701-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,msgid.link:server fail];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bang-olufsen.dk,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 384413C3CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small series addresses two points in the rtl8_4 tagger used by the
realtel rtl8365mb driver.

The first patch updates the documentation of the tag format while the
second patch sets the KEEP flag bit, ensuring that the switch
respects the frame's VLAN format as provided by the kernel.

These patches were previously part of a larger series but are being 
submitted independently as they are self-contained and already 
received review.

Changes in v1:
- Resubmitted as a standalone series from the previous larger set.
- Kept Reviewed-by tags from Linus Walleij.

Link: https://patch.msgid.link/CAD++jLmX31KfhGXA6SMAPXb14dHSC1t4JQZ=PQvjh-3hUcnzJA@mail.gmail.com
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Alvin Šipraga (1):
      net: dsa: tag_rtl8_4: update format description

Luiz Angelo Daros de Luca (1):
      net: dsa: tag_rtl8_4: set KEEP flag

 net/dsa/tag_rtl8_4.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)
---
base-commit: 1a8dd88469bf742fd5eda91cd8e0f720a983ec5a
change-id: 20260407-realtek_fixes-e1a81e477cbb

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


