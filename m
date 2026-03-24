Return-Path: <netdev+bounces-271263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG5qNzLtwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F431BFBE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E74F3029666
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E73328FA;
	Tue, 24 Mar 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiWTVOIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1967313520
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381887; cv=none; b=FO4aCJll+YorTuBLkGIm9LlJcikOpEMdXUpdr3Z/KdruT1S4ifyRyfsCjw5pJPYUOCCwoJ3lGgWQJXgssOEX6zDpnYHNV0mvPXUE0zftPrBeNWVOY634YPIQn//Hcdgx7CcGF+PzP/Kl458nQn3T4sPJ1TAkpcXp+ax84tPceCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381887; c=relaxed/simple;
	bh=Im0A4kCoFRWsr1uqtDQ80hjGO81gX1nBal1d1ObN9wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCJMqUNHuR4SrEFMDZdlCpwpANBhDY54BvHviQhXAWV5PUipapqOobD4EGHjVLo+8SC9kqt9fGFlfPmbzoBdc0IKBIZpxNBXIHFzEA2rSYRCCBm8lpic/Kspt4Df7pW5o0H5uU+2JLNXRJvrzzpPl1pnYoYfLJhmjVoi0OdPPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiWTVOIg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad21f437eeso1733135ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381885; x=1774986685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2FlV49GFof1/DbZQ7yN1r9OH8/Spk/E9iNk4Jp0WPw=;
        b=ZiWTVOIguJr7NV755o/kyHePBTNsxhVgwPzULXsWl393ZYuIvOXC/kOLnUPmJdH8HI
         OqNR9Ua/JG65NJGUhxaC709xr2Jj1DohqmM4YJhielCs95mQYomtXn67tsd8XnriELN7
         g4RhoEKtjODSTIT9rek3mEhIi0iAOzeVKvw5H2ULpe8Dad/kcA4rWL4J7Rlk3CNtZNG+
         SlzkZUSDdLPBLpDDLOvygBzofvAN5Ra6FSS4EjSbLfVnMyi8c6ehXBvM9jLgO8amciAn
         aSnlRm4RV4GKqghrUZXMybFaLETa7xUA+bGsFy7XQKbzcsoULgB2l5Ge7E2Vt0z2r1FG
         mWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381885; x=1774986685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2FlV49GFof1/DbZQ7yN1r9OH8/Spk/E9iNk4Jp0WPw=;
        b=fhm3xFc0RWaD7WFOb+GuOqM9HVYZuP0BOjy745mItY8gY3scIf/JqtK0S2xUFTpFo7
         1twK3lyEdP07essZWIkMapb9KQ36wywGnCSbWv1DY5j0RJ5eLJbjnxbOHAtQnkYjQAxt
         Pj5oE8WXtlOnNDo4EA0E+DMrZaN5VdwZFm40hy533Llxkp/Ux690/qCelovJZW7uj91q
         Av7gAmabtOiN1K75okDDZ/tppbq1PDHq4Im1iLV7gz9EP9ClaMwMuiOURjOQglBJr4/y
         /WbRYRTbVF/PkqXtiazphuir8izTWefPiawmedIIjLgaKF5rjH2ffwm+TRZNo9vx9AG5
         7pEg==
X-Forwarded-Encrypted: i=1; AJvYcCXFzTkAriFuX5GslmouRdfQbKYbKCkG0RYo12a5OlaHibfPTvfOluiNBDpyZkTqKfI2eqd3i9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ASnYuRmtrU5hydSlAAP6nLbKoh6g3QVpc7qIO/qg2u5I3//D
	Vw4KgwLEFs1SQvvCDLyxYhdsU+Ias7J0AIy0z5gQTRPK/OmbChtlIyR3
X-Gm-Gg: ATEYQzyi6ASzL9sQuw0P7OUPF7ObczBnKsDr8qNnBvUGCM2YESiyHE6tre0BMOeoMa0
	i/b8Ttr2f46m+6iRoBvQHHlbcTjLs0ft+fG3nrRWRqsZ6asyoYL9ZUSe6TvPfnGJ01hF1usgSlN
	Ccof/93+Vu//vabIinBXc5m3LEtRUSi4alnqOh7Wp5iVuM8rYjWKUAPvO23U+Yu3jaHIiy1JLS9
	Hy7Pe7V6HCXxevou6F8GNGRGqBpDPnraGGleo7hX3O1w6H8oU/0GX5HK3zn54iu+AjX/8CM44ig
	O+ZfSgaj1Pcmvsug0EkD93RK+XUCT4Ri74LnN6ZGaWP6eZWOPh2K0tDFXWNlmar12VyoTGFl4u6
	cYIWRhiwhCFw+gKxTZrYq7Ud/7/jOn5+U8KcQPmpRlL/oqE5GUSd5GNpxUCrUaYQfCgx2D+Dsb5
	XxfDiIqP7COKTR1f2FzU+sq7uPb4Y=
X-Received: by 2002:a17:903:40ca:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b0a4e1302emr42321095ad.16.1774381885141;
        Tue, 24 Mar 2026 12:51:25 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c56bsm220234505ad.57.2026.03.24.12.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:51:24 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Mike Marciniszyn <mike.marciniszyn@gmail.com>,
	Lee Trager <lee@trager.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net 0/2] Fix page fragment handling when PAGE_SIZE > 4K
Date: Tue, 24 Mar 2026 12:51:21 -0700
Message-ID: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271263-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,google.com,redhat.com,lunn.ch,gmail.com,trager.us,intel.com,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ED4F431BFBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dimitri Daskalakis <daskald@meta.com>

FBNIC operates on fixed size descriptors (4K). When the OS supports pages
larger than 4K, we fragment the page across multiple descriptors.

While performance testing, I found several issues with our page fragment
handling, resulting in low throughput and potential RX stalls.

Dimitri Daskalakis (2):
  eth: fbnic: Account for page fragments when updating BDQ tail
  eth: fbnic: Fix debugfs output for BDQ's with page frags

 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.52.0


