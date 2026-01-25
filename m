Return-Path: <netdev+bounces-253142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBgWN8nVdWn0IwEAu9opvQ
	(envelope-from <netdev+bounces-253142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:35:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A38003C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D73903001326
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EC205E3B;
	Sun, 25 Jan 2026 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXW3hwS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAB1482E8
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769330119; cv=none; b=VH2+V0/mkgx6Z0BEMioYSLYx0iL5O3NSx65p0NWUBdmhVr202nkH3zTMI5jcvxT5e2zpOJHsIefTdCvYJxUi82CLEGzUGd8hNTgiBxl7eY8eJQm2GlTl1elmHnbP7EUSdaqt+IeK77WDaqUTZ0s3ZQnsu/yiBNr9oPoyDM3IGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769330119; c=relaxed/simple;
	bh=nptkR/F3z/bZnGUFQjrT1hdRyKnPvglcmVwbtmg/si4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJfIFsGm7WAgBqwQmykjSF516fNGTt4ZH4aU9WZ+XsHL6mZdg5WQQG345L5fAE6qimlqCbCD6XwSZj3KrGgFn08wA2dvK43EiKOL3MXorknSdc9UA0NTRYifLh7tFACp0pM6COnJqRaJ/PBSuYfYk0KPS7XMpYsuZrGnwmcSvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXW3hwS2; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b714f30461so3147202eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769330118; x=1769934918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYChDDJqwd3nSz4SLjzCMME+PV2qfla0x9dNDwR4fTk=;
        b=DXW3hwS2+1xPmd/Q5JhsQXeNOnsMuomB7vM/hgquIpTetmz1m82Whempcx7WNDzxcM
         k0zurP7al1uEGitDG6zrSMmQduwOzWZjMEpOIc7HXJqewTv/dxbzy5qA5VhcTiTYLxXp
         +MVTKIzvNtvcF7S7COZYY6y+5PVEvGEFkPaWFBFxk/xR+/CLjq7F9veu89PRzC6bI4zO
         sO8eKAtP76k3xEJNNpMyw72FlFYONb7svVTlJUNz3rxoZAPtaZaJKGOu/gtCz4E0XOiP
         ngZUWxIXVl+rLyQvRc2hiOLCfeQyK04Tk8/ZqV+ED6UrNIybXGKIIR7AjXAFXPm37PZX
         E7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769330118; x=1769934918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYChDDJqwd3nSz4SLjzCMME+PV2qfla0x9dNDwR4fTk=;
        b=vbaDPwVIh6Huhy5hqBw2Vv3L9EqWVnG45egi+YL5ulnWByhysX5rDkRaCwiG/aH4C4
         D0o19GZH+vv41xZN+nhyKJMtpqnouFU0UtPMHfeu8j9vetUXpA+JbJFcdMHkU115XC3i
         m012MONEH0SDz/VrrojnjWoqZOn4ks4Qpabnh+J/2TqsXNWbIzhLA3waSrLMFnkzpUr0
         08t1sqO+3Bj1rnPSXK9DLvO88SK+D2qUMJv3YoSMx47wQcXDi1QEe8lzmt/KfvDUM2NA
         kFu7bV+JhGZvCRfZscpDH27eeUq1SmzbPRUnoxwVO4TCoUpJQa4wDpyyRBo1EYFOdl5n
         euig==
X-Gm-Message-State: AOJu0YzPmql4Njanf33Ju6CQnweDXxoBUzwTGrlez6qt8qmw37irxvKB
	l4oBMBaelRTwkzgPgysCtkmE+OaxLrL9qEPMm3npmt10C0V8C0ij/KhaFv8HsXro
X-Gm-Gg: AZuq6aKeqzm76Xqu1mfaZ2OwrjGJeYcmyLoTLDhWdNoB0n9yWu64KC2UMh/xWEpw+bx
	AjYn2sWLW1us7CzDQN/0udPOqZ7wzKAWEtnhrfAV3zKXzKxawuiTA8Vv4t44UZAt8VtvAXKplW8
	ExU2PloRNKDCp0ZBXXoQ80/Xk9CZkxWl5Co+9tdgNQTtjnqYsr/GnMCDn4R1jAhkHYFL0iwX4a/
	W4M+N8AJYWkS2Hi1R8SdSbbbzascuJQ+mhrpvghk8yCglzySCTnsQBlbruRDu7hoOEnc+EOw+Qa
	WTct7Dm8Pu07TaDWzBuAF88/AdfFVK9dwg98u/jYlwRnNC7V/THkOkKBZIR0OHXDgO3Y/ESUbuJ
	xwCkqUOYZX/OfXtdBElqLrFAkvvZi2lhkh9c+m7Pw6Mjsuxkv78V3ZUOse7XJ9oOLWIZCuunDFl
	XziRIEpPQfJdzIocIm/fVyMBtJaXG6eHdvcMcLd6+MNQ6RaZMANF4UNXXWOTRlT7H53USiBxFc4
	NvuByo75Q+LYFzLgwRE9FZFsLzEGR0AdJ8Yg7ZdgPW2K06/lQ658BCJ3jtvtqKUF5SMn5KLwW+V
	DFQc
X-Received: by 2002:a05:7300:2211:b0:2b7:2263:3d3c with SMTP id 5a478bee46e88-2b7644f99ccmr342032eec.24.1769330117511;
        Sun, 25 Jan 2026 00:35:17 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7410615c0sm7994977eec.0.2026.01.25.00.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 00:35:17 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: usb: adhere to style by removing typedefs
Date: Sun, 25 Jan 2026 00:34:54 -0800
Message-ID: <20260125083501.34513-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nucleusys.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253142-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A6A38003C
X-Rspamd-Action: no action

It violates kernel code style guidelines to define typedefs for
non-opaque types. Update the USB network drivers to conform to these
guidelines by expanding such typedefs in their code. Also make small
style improvements to code modified in the process.

Ethan Nelson-Moore (3):
  net: usb: rtl8150: remove rtl8150_t typedef for struct rtl8150
  net: usb: pegasus: remove pegasus_t typedef for struct pegasus
  net: usb: kaweth: remove eth_addr_t typedef and bcast_addr definition

 drivers/net/usb/kaweth.c  | 11 ++---
 drivers/net/usb/pegasus.c | 92 +++++++++++++++++++--------------------
 drivers/net/usb/pegasus.h |  4 +-
 drivers/net/usb/rtl8150.c | 68 ++++++++++++++---------------
 4 files changed, 84 insertions(+), 91 deletions(-)

-- 
2.43.0


