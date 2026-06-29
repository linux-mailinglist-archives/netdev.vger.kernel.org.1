Return-Path: <netdev+bounces-302787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bwqzNSe6QmoRAQoAu9opvQ
	(envelope-from <netdev+bounces-302787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D406DE113
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:32:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="VJ/5NjEp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302787-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302787-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49CEB3005166
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD33876B7;
	Mon, 29 Jun 2026 18:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804D3101BC
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:32:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757925; cv=none; b=n5kz2IVhZhJwO5g+/I7qwxmyngpuv7JbeRm6qO6LaMVMpyPC8Q6q9Xih69g7b12nfPEBKsmHXXHt8oBwFXx/fv096rW7idN3nfuhbaVwnLQYqBB6nAIRdmBKZPOJmmOeB/gW/TsyR10J7FwZdM/R/hRDFJ4Fx9St8V2h8RUMxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757925; c=relaxed/simple;
	bh=wG0ZUQOIc696ujuX/vbnaF7gtzwEkgNUYCNEd8+3MC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yl74RK8jG00sk0tlx/1lj+KDtGJxgfZbcl/jn4DoOGlB25yKzgfpARY/Zr1BR19peLdsEUI6QqHTRoPW5ogfIkadnifeGEn8SVsM50JRCpSyCgu7aAru7A2NCsBh+HDXwaQsESnTQCSTySlwZZJSYWeWIJqc0A+hX6Y5zo00Xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ/5NjEp; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8894387780so1571195a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757923; x=1783362723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6swtkEPiHC3oaxv/2vbG5P1KrCA6T8m3Pul3+3QzmU=;
        b=VJ/5NjEpc4xjlhxDsLM6WwmB/p4tU11+3MblzQ4Vly6/zdsOMFTuHsvhAyxk7MU7a2
         RajNL1LTShkzeLlYEYjVkez/2fZr4+Cp4TK7UKgsL+is/v1RRsI19tuCgcm4jWRtEjVu
         ARbR/yJM3TLOrBRje2oYk+xllMo9o58yG9ILCuJaYeEMFSAofJD42ZDQ7pHKz7rBUy/W
         M5d0X5mKoyK5dJkleUl5vCcLqt1p5PKYRyrVaI95Uw8l5NnAHaXFMgiTsGI33GqwysU1
         8DOTJi/KOZpBKB2TORzTXvFkJhYQ7dsvNYOSGV2Hc72zucwchnjMoYMV8MObv5wwxHVh
         VGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757923; x=1783362723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6swtkEPiHC3oaxv/2vbG5P1KrCA6T8m3Pul3+3QzmU=;
        b=O5q/8qqGTE1Gusy5jWVAc+KvFpczdf2ePralsc1nQr11LirryZrc9ntJpLRj8oy5NP
         PMMqT8mF7VWrfs3UIp7ns5GA/zDz6x/QDaYAIRsFb9H0wSf2kmfy1TzVoe4Gd2rG5Mlo
         X+2xA0EFHt63YlvezTOvGRAP8FO8dSYypcV/Lr62JRqFCF+/nFwXVc3jadGnlrAQjuCE
         tZmq5peC7rCZJaSuIJkTm4UMRM0mU8dIIkOCexlOv/n8de1pdadPzggHXGLaz3qsMsyW
         IEekeeZe7KAGseTrktrsqD/fNR0oM7ltVFwm74t7Tf9cH99dewfF3YL2f5w86YzuOTV+
         9JVQ==
X-Gm-Message-State: AOJu0Yz90OzIz7/zU7mZ1ZQarumUEW3hDOvyKp0CHjN8gXry56XLxr3S
	qZUebQ2h+fIrXM7Z+LlAEDpQUParZtmDcT9fIRAlCmKGxhxbc/NZVN4VtbvYt0YA
X-Gm-Gg: AfdE7ckXykb95d/MkKp4NXZMB5xMZZ8eWHLFDVAJSqakoJVFwi8ccY/Zm0+MaVy7+y/
	9VhWiWlk1EJByXZeSu81WsFO5m2Y7QgwKFnP4wWE0pCyaUGSZ0CwB3PBX1R1h3691+d/xZX/XiA
	Qu3ZGfqysgjfEhiaujeyp/qPLbgTnCjFHLvPInee2ikSx+hJavyMahwn7rMoYIuJTrbP3rjcFIu
	SmW22wgfqinPY/N2vz+xzDKGo36Yq6JHsTpLDP7Ijl2w36h/lLJRWanYyHOXiLkhhWrTxFf28Bg
	8lWzvw0cx/OkQ6OhTx6MOdu1nCqupITemCR311SEG5AqAHtNUy/z2FBSGciY4ifGNhB8JOv+7Gg
	vGlXoTQPAvR5PwH+54mhpld62EfNppl4ZRB7DMmnfTxZT34Ej1bCrkMhv6Ej2izeTuRuFpQYfFe
	Aj3q5AWdVwGBeY7azPqLEAz3ccT/o/ohMAsZcFhw==
X-Received: by 2002:a05:6a21:e584:b0:3bf:80b8:9c8a with SMTP id adf61e73a8af0-3bfc505f4e6mr600604637.6.1782757923255;
        Mon, 29 Jun 2026 11:32:03 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95aa99sm224754a12.17.2026.06.29.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:32:02 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: dsa: motorcomm: Add LED support
Date: Tue, 30 Jun 2026 02:31:31 +0800
Message-ID: <20260629183137.541341-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302787-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44D406DE113

v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lock

David Yang (4):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Dynamically allocate port structures
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 336 ++++-------
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  24 +-
 drivers/net/dsa/motorcomm/leds.c              | 530 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 108 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 ++++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1029 insertions(+), 250 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (95%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (98%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0


