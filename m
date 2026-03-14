Return-Path: <netdev+bounces-267650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLuJBzOptGn+rgAAu9opvQ
	(envelope-from <netdev+bounces-267650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:17:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F728AE08
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D22A3010B49
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4B1D5CC6;
	Sat, 14 Mar 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQdoYJaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E640DFAB
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447473; cv=none; b=nF5AKQuW4Hs7xHUTlGm7flgpMXJafAr2XCTKKLa38jeohZau8Ha6+LLxtqPC7A7VS8cU+K47CkqxRQdDHlmZ9BS8JFarhIqbGe8TJtsAjD41wZBt+RV5SH3zGSan5vFVbe2Bp0wvKSz+EM+G4jOOG/lCKpfBVdkFnvOnmb1lGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447473; c=relaxed/simple;
	bh=7jqylH0f4wwZVDI4I7lH8WM9rK2nffR6NsZx/RBRmQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSyj/bhf3wz4I1lb5Wf8Q/bhSR4ABobn1Cf6hQ/q1/+TIDJy9XsD761CkJVUrdEwESElEb9q8O350KiEbzc0J7X+CuaM7MlXzV4+6sbsDLlQS6rePdT96o92Z6+2ZgHc4/DLS/bgXyAzFTUg7alD6IUdb9TUtoSCTXfNZQheNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQdoYJaV; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56af73db66bso1061298e0c.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773447471; x=1774052271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+ccuodmc83ut74QkQpXDtI8JJy8lQ6P4b4M35Delbo=;
        b=QQdoYJaVGNcgw6k+dFfxuzOrvap5WqOXcPkptNaHTYuUuRnyRisFzaNyE7R1qM2avy
         2LYp7OlzCkwE0HoiX/FxNV0wQD51sJpwi9F0fPlu6oKJc+w4aHVVghpCa0cgPvX4QPRA
         uCV/L4yR0Eg86MBJ2Fu/EtYHLXwZEL2CsIwDwWvJYUlAtZTLZ3OCD7MmL+vrWcnosTPq
         GRZpgcIi+uwQo7GVOuxtz3hTG67dRjQ4UIaYs+cVQIBbgjCx2PGYG2PNBzjiCGoNY7Co
         NsijrlEU8fHOsKkOXP5Ae6eWSvzIMGmKgLHJ+EpjYvLr3wWKaVlreljvbUH+JN2V282i
         o3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773447471; x=1774052271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+ccuodmc83ut74QkQpXDtI8JJy8lQ6P4b4M35Delbo=;
        b=YMHlcCBygN+0ZjsMjTcldVQkf/VGzBqNqj4OehdTfSBhTRBJpe3VF0NZS5gVLenDyY
         D93tznh/Qz4hbncBjD1CTc/EDCowCls8pLwUOTrakBXTLlHU9bxQDsjOkMdwNHNbKJzp
         Z/ebyIzg+ng6QLry8I87JmwbhTlLDccRaoOsCVUY7lJvY/jpF6Jc553QjWyeZQtaWtnk
         Rq/Fv6EEufvuuWFKUYL9/ZEToauVfRasMII4EXCe3PAE9vezrQzVzSlvSLATkNKX9Qul
         TfJeQwvbulMfDLZDRvoQ+1gggjsYgryhSrkqoFFju3QwDUUJ3TvqSzRAliGvekUgs2gl
         nXXg==
X-Gm-Message-State: AOJu0Yw2y4QDEMQgbLuQ+FITTvH8LkKgm5uzwkKjhVuD4dsTBSMsu384
	NA8munrfd5m9tX68+RpqvZ6PkQe7oqCL/pHajtOXQZzRF19Tj3aKdKRy
X-Gm-Gg: ATEYQzxBWhSa8kl+vHcrKrvO3lEBPL7hjbBy9SrBBEBshKYZlBKpu0V3aZPKi4WVSAz
	t+UUoomEqBb2+G7RtIaWQYHRFBskrxE9TBxaQPZ2sxLveQCtPbFh8fcxT+XlcUqHNk56M7DIlon
	gXSLnClchGozWXjoApYbpFnPcc3GCfEt6qL8KxmLkXQQD0EqSW2+1aNuSuqgm9NXIR2mRmxyzRi
	SMWyhoLnyaTUWxnO7EN2UdCZj2jrd9KizUhcel0YVaBgFCYN0v0bT/xygBVERC5WtOtfhjfxIKn
	/7J/UM26mZxxDqdw3T4Jlez5+KMQigi/o3YHXo+QOTM0Y141BqwYuKJhL/3yLb82CRsHamwA+sx
	zdAK9od9Y3B2akkBDCWOpMqRWtFM0rvHn3PjKK+BrJA2CGWf8jFR5xA/hFVbkeYGDOIYsxgKOPX
	nFnQ6kOr9JAAtqliSZ/1lT
X-Received: by 2002:a05:6122:178c:b0:55b:10d7:51a5 with SMTP id 71dfb90a1353d-56b6290280fmr2076284e0c.10.1773447470905;
        Fri, 13 Mar 2026 17:17:50 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2a::])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b46311eddsm4486862e0c.3.2026.03.13.17.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:17:50 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	alexander.duyck@gmail.com
Subject: [PATCH ethtool-next 1/2] ethtool: Update pause stats struct
Date: Fri, 13 Mar 2026 17:17:36 -0700
Message-ID: <20260314001737.494082-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260314001737.494082-1-mohsin.bashr@gmail.com>
References: <20260314001737.494082-1-mohsin.bashr@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267650-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA0F728AE08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With TX pause enabled, if a device is unable to pass packets up to the
stack (e.g., CPU is hanged), the device can cause pause storm. Given
that devices can have native support to protect the neighbor from such
flooding, such events need some tracking. This support is to track TX
pause storm events for better observability.

Kernel commit: 8d282b680c72 ("eth: fbnic: Fetch TX pause storm stats")

./ethtool -I -a eth0
Pause parameters for eth0:
Autonegotiate:	off
RX:		off
TX:		on
Statistics:
  tx_pause_frames: 1
  rx_pause_frames: 0
  tx_pause_storm_events: 0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 netlink/pause.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/netlink/pause.c b/netlink/pause.c
index da444bd..a22c7a3 100644
--- a/netlink/pause.c
+++ b/netlink/pause.c
@@ -116,6 +116,7 @@ static int show_pause_stats(const struct nlattr *nest)
 	} stats[] = {
 		{ ETHTOOL_A_PAUSE_STAT_TX_FRAMES, "tx_pause_frames" },
 		{ ETHTOOL_A_PAUSE_STAT_RX_FRAMES, "rx_pause_frames" },
+		{ ETHTOOL_A_PAUSE_STAT_TX_PAUSE_STORM_EVENTS, "tx_pause_storm_events" },
 	};
 	bool header = false;
 	unsigned int i;
-- 
2.52.0


