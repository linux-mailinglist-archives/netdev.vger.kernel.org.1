Return-Path: <netdev+bounces-300530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nu80N7lUNGo7VAYAu9opvQ
	(envelope-from <netdev+bounces-300530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:27:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0566A286B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:27:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RUcZM97Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300530-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300530-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01432300D4E6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E7342507;
	Thu, 18 Jun 2026 20:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E8331213
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 20:27:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814455; cv=none; b=r7BIGdCHzrWJulG2SKZkF79xO+zD4qNC2DkZ/WuyrebRpkNpAL7Ns7WrWiXWl5JqMduquVrkJxIq8PB9BjNwlkhcCeB2CHykAWRoRLdvvqxoe7HZrbEClpIwfMz2ea7Q0Q3wDZmyTCMwYgQFhhry5/wdU1+5KK8l82P8pUd8LEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814455; c=relaxed/simple;
	bh=WjcvnXNOJNLMMFvjRwhzMxY2WHpTrCvwglc+PyDzPTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdCoQOGUrkQl41NLfwfhsZq0oAkECTkWi3oZgoHKmnwdozxgJGaaJtY9OzH9IoA5wpU5oIYmHlVRut72Ir/AmtOYjBuSXuzk+DCAy3QgybOzA2VoMaA7LwpqRMs1Ni5X40v/+e3PuQAdhXdv8X0qh7aU1TLzSzXd3o9UzHps6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUcZM97Q; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423610ec93so1220789b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814454; x=1782419254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvMCtWJN5eeW/nyw5tRgWlms9brUprP3mWFDFUlZxsI=;
        b=RUcZM97Qbl1HANHah8TKKnwvICbeeUtbksnpK54boiyn380h0j90kRg9qAmhbass5W
         ZHHzf2KYsx5eqzMOWczXfbzE/qHHjo2k30/qZ2/UT0jvpbjq86ntEUOIJ7oBBfn+ooRo
         nfzH2ApuFo4f6Ay87Oad1SCBlDdvvt4LQxoLfvo6bMR9qu8Ovn6zT4xDMStoVa8TOGmJ
         X6I64b2wQrtuR0Z7bOKlEVY4oteCELKUkWmrvREiDs1dx5X7rbAjFNBdhJdmzwfBAu4j
         MdYoc0hAO6Tvd8k4UvIxy88CV/2YG+x5POZPPFKF89uAE4tsDfYUyjyWi4/Oc2wsrMSF
         OspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814454; x=1782419254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvMCtWJN5eeW/nyw5tRgWlms9brUprP3mWFDFUlZxsI=;
        b=U786YfSBqAWV1tBgImIYeW50JjxGyKqfClE1rEcxzuAxFIKxNWfF4EBylGG5q1vPDl
         pKNrdPE7xgOXkd/l1nIQnOV+mvx//SgSvj03YoyD6ekNly8cH5UuuLGclFgvTa5wWwa1
         +H0SXVeakkzXC9ClKG5yjQaSQJXxb8zHCwOpmv3MJMuMFFuCbsVW/u6I1rzdiYT79w8h
         8Cv5Pe+vC3FE1OVUl5G701PX1sJf11Z0RuSwVGemZIc4GO57kM2IL0P9x3jTjkf+jPv7
         cwBg3x83mUEv2Bw7AydWV6nhAyzfHPkfjVPRN7T7it5RYVY5pWbvsseATxd7N5P+uSF7
         F45Q==
X-Gm-Message-State: AOJu0YxJ30CEypfooP6TY/f9YfHhOF6TGHvLrqnQlzpt6NizET2uuuSi
	1EX0fUAFWiPq0PvX2D9vxkUn2HY1Gb+IsWOmwgPnNnAoyfXp2kLXTrDp4uMxqzMX
X-Gm-Gg: AfdE7cnBHyjEOC0h/LsjYjo1GeUEyzZ2eRmVuy276Iw0JhQ63nLHOq7CwSYnxP1Na6x
	jQP1cgKL0Ak2ZnOPP5o2jYTbM7zWS/V+oNoSYTPlh6vqlFQOvk1KYxmUEPmjZIH6VFwgeVNUjHe
	mKE7XXwpW+hMKTIUo2iD1QY5GyWAC65ztUr5zmXfI2cumX7OJmn7y0rCWtAkg86Xp4K7LYzMuFF
	5yLgW/FVJtG7mK3kOwjrBiudyGgAjS6v0iGzyHu8Gw6CLiCcdp/70jkv5UPxAj1gbhljnYmo5XW
	QcuwoX52wAwBkM8b6a//FfOfleQ6CsiFxhQDzjEZZiBiddFS9A+YOOPHQ2JI9j9Ypx2kxNNPPYG
	A7AFyAIEVfBWqGFsLIKW31oB+NcyysPZu1viyXadL5MPSgW2LduRgtyUE7FdsvJ67GuDijRFnDo
	7lAWetlfHgaXYmQzEtOj89NK+aCU+CP+9O8iM6FuSi2qlBUcMR+yL0q0Bc2MpwTQ==
X-Received: by 2002:a05:6a00:6017:b0:843:49f0:f5a0 with SMTP id d2e1a72fcca58-845508a1c42mr465633b3a.32.1781814454356;
        Thu, 18 Jun 2026 13:27:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845536758ddsm3590b3a.15.2026.06.18.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:27:33 -0700 (PDT)
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
Subject: [RFC net-next 0/4] net: dsa: motorcomm: Add LED support
Date: Fri, 19 Jun 2026 04:26:28 +0800
Message-ID: <20260618202716.2166450-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300530-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F0566A286B

RFC during net-next closed

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
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 311 +++-------
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  21 +-
 drivers/net/dsa/motorcomm/leds.c              | 530 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 104 ++++
 drivers/net/dsa/motorcomm/smi.c               | 155 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1003 insertions(+), 242 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (95%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0


