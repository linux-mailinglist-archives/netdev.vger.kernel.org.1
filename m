Return-Path: <netdev+bounces-292979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K5UJrMiGWqVqwgAu9opvQ
	(envelope-from <netdev+bounces-292979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:22:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1A5FD4B9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C65243014866
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96C3A0E88;
	Fri, 29 May 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+s0MVyG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433A39FCDB
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032174; cv=none; b=sStEsuk4as+lVFFDsNZyxBFQY5/793N7ZATzU/j+V3AxYv67Um73DBcUXFViHrgO+sFG9Hr5KJ2uESkPOdHK3z/kYb2C2dfK5/GEfS+2KW8Pogoh7RiRvPIrPKPHlehxF5hPwG/6si/uhyx/71rNr3z80iqFgx2F1ugrDT1Xs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032174; c=relaxed/simple;
	bh=yjNeNKwVqAVtLi5UEiEW0Wf45yTXODU2c+e9fUnr/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofBag6ND2wOd+6t0Ks1f5BZrxkvOOpooP6eCyjhNMw1JWABZG3lIs9W0JkjNIreOt1Jw/1kr1OLmAnEoK6RC7pk+UOiXt3BHEN53Byb3zGABry03QlakcSIoLy20A0O19v8w5C0X4TBkrAPf/hQO9ZLZ/G2CtAr+hc488ouUnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+s0MVyG; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e61e251966so3035965a34.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780032172; x=1780636972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJH/oTSFk2WoNkZ5UrYmehv04y8AoFIFW3mAejVdYxw=;
        b=n+s0MVyGMGbb7vdyDuP4gcKzqJbs+oJFhFXV9Jc5NBvYrwmVbMEhKG/kPYAr3I9mcM
         uAT8oVn/6g0PuL7LAeOVtMOeFOtcB4xkqsgdirvRhejIEFzNzA579Pby6zdcyBQ/548g
         qoQt4WZ0XrxZ8NkNwUuJdkjhPTWGoZqd0jaxJjEG375THqucLMZh6C3A26jxQV1d7Qo2
         wdAbXOjnC4Dmn5+88r/dH2DrRHZpBqLlYEoFpA9buBmisRJsB7Q1ljgg0X66nYaA5F16
         jCMYduWCxgOKewwHpSMf+NyNQ1jm7l4NBvBcBWbgyD9lAKj8AG8xZZL7wBzodeY0oiNa
         5vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780032172; x=1780636972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJH/oTSFk2WoNkZ5UrYmehv04y8AoFIFW3mAejVdYxw=;
        b=PlUTkC5m881bA9Qmdz+BtVuYY8dzuU9wEC7KyhuNdQJYK23PtNTB8ZIDF1EQ6HZsHP
         YqaukKyIeUJTc8Al7IS6ZMuVv/wjVA05ND5hfdKClGGo9QnixEV6Rnj7xzxnUIDH3OTj
         ob8UIMWdL3+9jYGuCq9oCiTYOwMb/SLWMiU4cCSH0DvIBY0TrprrplhfFi3nIRuUDGAr
         of6jEqcNyb/a8nFJuYnhxdvgQmfhGggJ8sctJOwXBsUGgJ8qr/3mpT+YN0liNMlJcuVY
         2KxXhH+l8lJbBUe90muRN5T/iFO3rYWjjZK1H7A2CuxW0y3tRd7FtLbg7RyRQMcomqJY
         5aQw==
X-Forwarded-Encrypted: i=1; AFNElJ+IvwplAcKnQDVxLFof3uTNbSb/xAjZ3T2L5IHY+QgBXHHLuPF4ar5EgLMfMxeJFDsAksbXJdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgFgf9tFAsbKoeO67xRcfP+Z/XmYWNFZ9qYIZlXkLb4CBJELO
	iqwW1hw65nJGBcSbwI+ogR+HnSes3P+qH5K7GfaNqj76nu+VP1ElU3IT
X-Gm-Gg: Acq92OG0Gn5JEi3fg8BRInreOzF2+vSps/bP1LKH+a7ZegokGhVqmeB1V2fHd/mbGi7
	/DGU4iEXh3955Z5vdCiALzSdyoXCmBDpt/vaU/FJIcOuWTS6Kje1kXL9neVhw+xpxtLbCahFdTR
	pf03I8m6uQVHRj/dtcDSZT+FOzTnJK+Igt7r185Z4kWyWBDo3qe5HEMFZaamND6dfFRqR2nPn7e
	84tgay8UM5MEZHbRrNLl8FEQ3ElzikvfVVWxVS3UKZBya14C0/fOwj77F6yuqZQrL2dBCBnErJD
	+R0bfhYNMSfVNbOt7d/2UZC5P7m3PL8kXnEMN3FMMwe1Iil53+2xth04Gjy3e5lg7JZYWe90spE
	gKq5NRtAPdrFbqeSuGddlJk40TzV5agqN7FJH1AvwcOUOZVXR9/x310L1aeIkeTtxx40g9HYNSr
	abiEE70y7Ltzy8OJTPQ85F3vo/6lvAYw2ZP2JzSMRewrpH0LrG8+Hc
X-Received: by 2002:a05:6830:67da:b0:7d7:c96c:c5d6 with SMTP id 46e09a7af769-7e694bb3792mr1003529a34.1.1780032172437;
        Thu, 28 May 2026 22:22:52 -0700 (PDT)
Received: from fsh.attlocal.net ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bd790fsm760909a34.10.2026.05.28.22.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:22:51 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: net: remove obsolete mdio.txt
Date: Fri, 29 May 2026 00:22:38 -0500
Message-ID: <20260529052246.4934-2-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529052246.4934-1-akash.sukhavasi@gmail.com>
References: <20260529052246.4934-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292979-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akashsukhavasi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0D1A5FD4B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mdio.txt has been a single-line redirect to mdio.yaml since
commit 62d77ff7ecbf ("dt-bindings: net: Add a YAML schemas for the
generic MDIO options"), which introduced the .yaml schema and reduced
the .txt to a stub in the same change. The .yaml has the same filename
in the same directory, making this redirect unnecessary for
discoverability.

No files in the tree reference mdio.txt and it has not been touched
since June 2019. Remove the obsolete stub.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
 Documentation/devicetree/bindings/net/mdio.txt | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/net/mdio.txt

diff --git a/Documentation/devicetree/bindings/net/mdio.txt b/Documentation/devicetree/bindings/net/mdio.txt
deleted file mode 100644
index cf8a0105488e..000000000000
--- a/Documentation/devicetree/bindings/net/mdio.txt
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to mdio.yaml.
-- 
2.54.0


