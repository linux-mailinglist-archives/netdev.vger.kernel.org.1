Return-Path: <netdev+bounces-234123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1E0C1CD27
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6650E3B3592
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E39357A24;
	Wed, 29 Oct 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyqGUxnW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EE357711
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763590; cv=none; b=lpNmwYJxAfuTUtACo2kG0q5ijOuFsKBBWgst+jujQ5lZVeFPL2rh2NIVJpOd670u/pVcn9jymS0dly5SpU4D0XJpV9/0/NhKFBdkL16RJ1rE4znjTx4IFpuP7H7ClcO38SgcSdaqTwRNQ+Sd/o2ahfEqsqxrq+h7qmAFuwZ3qLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763590; c=relaxed/simple;
	bh=U62r/fOtJQtPieiV20zK2df1a6i4gyeJChvtG9Zp0uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nmp/tNTKykvD4P4yfQ9gWqsxduDL7FBHHP2CekIMIey+WYmFLxs72BugPECpAiAbUmmhiRFe/pJuyOhFkWguJxRp+M054slwON6unKmP1Nx34WCCfWZya8IFC9o1id+g66l4zmuknfAtHCNkYFsg4ICXRQAe+zTriOwkoh9RzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyqGUxnW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5535902495so71527a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761763586; x=1762368386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwXxkHaUQ2Itwxa70IRVOY6FUcTZ8h4FSg8gJ3GP+iY=;
        b=vyqGUxnWSfuM6gNzvCAUPRSEhIZ+wcLCbHMjIT+8BdsbnzqEfSkEW/QR7gCEL9xAzU
         ublzSeVhH6CLlfGowrVegJnFDLzwqkyJUbLyPtc+B4LLW02oqNqgg58aQzIo8WQQLDk7
         SpMbhb+JZcLVBee9WXeghSSfmjwtamEjt95PlWGWz0E+8ZWCkZdbgIPZUIVBIBnSBWIV
         mSDXqQq6qlyj9021Y/ndN5P1xtNXksbVqAcFBs0XNTeUXNCkeGoYhV7wVIp276dGC4LO
         M3twMhi0l9qYHXl6+wGvU8/RjCqym4+TWlhVIexXw8/Qx65l343Jaoqkat4N25QNPFWQ
         zy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763586; x=1762368386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwXxkHaUQ2Itwxa70IRVOY6FUcTZ8h4FSg8gJ3GP+iY=;
        b=XT25BQxfjenwyiw/Ejaw4yY304/lwbw+vTQ8uh7GPFvIMHgAUAdHmc3/DU3l1MsqMV
         znitA5cPtuhDIwwnO+TKzWpMooSuwd5ohrtsKleu5ids1KWxe/NUgq+oU8QN7Bi9k360
         y2hnuSNVCEEZGVecx3d1XPIWNynZhzSB6atKfJ8cmIJLzRum3w7MkcDXVcuHZQrfwO8a
         uuDwtwpJInjS4tHmQNbGm0/JID7vW9vFrNNuhICJFv0UtpzeFbyKzEf6ZfP8cUxMQaNl
         tnhEU6k7oBGiMcBL8YwUNkCDyDQwwvDt8amoonvMAJ5Xyo7aOTYQi6c0DNmfneglFA/k
         PUDw==
X-Gm-Message-State: AOJu0Yw9Bis0BY/FNvg5/ZrZ4mhl0xqQZTa84PUCbJ1yPqHFjFaJOgGV
	EtBXh8NK0Ito6ybBTjN5X3ZLFT35oQvHrW/cvmntoox1MM+9wf4isKDSAM9JE8XQQxwBvcS/Tzf
	bUl9Fl86bf+zCDYAerGsa1FZaBwON1PxYQQWwGVY2d/chemjZmBSNJ83zwRvlflnQftrOYYmSpq
	4ze4Vn8FnMDdqSaOVO6FLnBgflGG/RG/xEV+7reIO1qKTibA8=
X-Google-Smtp-Source: AGHT+IEb8imeJZc3wTyKz41hV95DU4DMFq/L+E+K9W8WpFaQM2j7DiK2tfOxXrcoiZMttlqmrXtWeGjhIqlpIQ==
X-Received: from pgbfq12.prod.google.com ([2002:a05:6a02:298c:b0:b63:7a61:419c])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c9:b0:334:a9b0:1c87 with SMTP id adf61e73a8af0-3465250ee69mr5270481637.1.1761763585755;
 Wed, 29 Oct 2025 11:46:25 -0700 (PDT)
Date: Wed, 29 Oct 2025 11:45:40 -0700
In-Reply-To: <20251029184555.3852952-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029184555.3852952-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251029184555.3852952-3-joshwash@google.com>
Subject: [PATCH net 2/2] gve: Implement settime64 with -EOPNOTSUPP
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Tim Hostetler <thostet@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	syzbot+a546141ca6d53b90aba3@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Kevin Yang <yyd@google.com>, Willem de Bruijn <willemb@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

ptp_clock_settime() assumes every ptp_clock has implemented settime64().
Stub it with -EOPNOTSUPP to prevent a NULL dereference.

Fixes: acd16380523b ("gve: Add initial PTP device support")
Reported-by: syzbot+a546141ca6d53b90aba3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a546141ca6d53b90aba3
Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 19ae699d4b18..a384a9ed4914 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -33,6 +33,12 @@ static int gve_ptp_gettimex64(struct ptp_clock_info *info,
 	return -EOPNOTSUPP;
 }
 
+static int gve_ptp_settime64(struct ptp_clock_info *info,
+			     const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
 static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 {
 	const struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
@@ -55,6 +61,7 @@ static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
 	.gettimex64	= gve_ptp_gettimex64,
+	.settime64	= gve_ptp_settime64,
 	.do_aux_work	= gve_ptp_do_aux_work,
 };
 
-- 
2.51.2.997.g839fc31de9-goog


