Return-Path: <netdev+bounces-182264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86905A885AD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F164163D4F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB28284687;
	Mon, 14 Apr 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX48ZoZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7828467A;
	Mon, 14 Apr 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641149; cv=none; b=f2ZeFzETBNDKIX00+tYpdMJKfOG50x32+ifDk3nyKAql59VNTzjpp1tJsZlVTeTbdg1ob3o1h2KhhWWErlU9qrgN1I/Fb45siwzpdD3rtV9uY69dfTVS+zx5dlibBU8yWBoTSrXfNsDO59sawud7yOWA265Ee8c2ZkWyNnDX3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641149; c=relaxed/simple;
	bh=Ognfh7wJOPNlfUCFIxmGGVXr3bmYiK+ZrCCmo20WZTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoDXtul3nXrJm9hTHsI57IRJ/3TALQcozxi5yiCoCXZCsQMMWhVnrf3n2hxY26Uhd28xqi27nXO3tpaCJXtblSge+MibUNyfOpn2t9UpSqNf2YY5hDxl7vEVM8jKC5Sw+CsRNDqLuIE98bqRjknZW9BfdlbS/jT8EufQShRrksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX48ZoZo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecf0e07954so63129336d6.1;
        Mon, 14 Apr 2025 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744641146; x=1745245946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEISKZ32+v6e9D8ZKBglVGv5jngtAwP6VcoGwP1gGiA=;
        b=WX48ZoZoZGmpivfRgFqvWCUQ7cnrvt6rsOOOw/HgZX12+Duou/y9bSWmag2m19Aq8t
         cXqvYG+OzM4RTcM3TR8iMs6ULTbuFV6oPdhftbZszX0VEsfJAR7IM+H/yicLUfTmLXdK
         6vPdD/8vyjZ8Zhodzohdm059Y2gMKjylS6Hs8V6XNohKWkosKlXgF6Ty/hk3ToPwLO6u
         iQVJpGe48kHNMv4gAiLTiWBFIdPpiwbFZJlRd3Ocq4Afy3Vs3zXAzTl6QnSPS0a/JkpN
         I+YYltzltEQZ45Ggsxt8uiVjly3rfF7ImFCQ/piD/2aXCMGN1Ci42lWt4zsBuQ39CPB2
         eVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744641146; x=1745245946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEISKZ32+v6e9D8ZKBglVGv5jngtAwP6VcoGwP1gGiA=;
        b=lp1LdrRqIJtxbHaUP1n4lnSRo7TDGclJjCjp+uoiG4O+h54mb4bBgKLA1mn+lPtDED
         2t9WJNkH+v+N31cwmkower13AUW3ZCkp0LJwUCPy+8bqKvJllC24Okwo0YEMJOPNBIza
         KKwpc+dRy4Rk07gs37hmvbjD1RTO0dRV+YUPsDUxpgk5iJs7pHTOrFariGD9n8GnD8Zk
         xAZnoaFtUmo4cavGRLjDzirXoDVihEQWajN96RDr4GpYzmM0hZIuw0XcQBC7QAFtArl7
         ZECXcdrGkp/wx2EYAQQS48dnLdEe2qnkM+VsO09KtXY2djz302xtSrq/0lPsuC1ry5DT
         8HhA==
X-Forwarded-Encrypted: i=1; AJvYcCV5v2ibXYqqXvNuoKMRd/DE0ciNIXcwvRtpEUe0g+5S11tdH8DpSMg6qPigqENjuXJ8bmPusaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/RLLG6DsqN+CatwIg8KOPB68iTBB0q9nTDNpe1IvjBP8jjc1
	4Zam7/n0KEFQkewzChkxFxyUEZR7wvFJZQD8UHkJBiJBW5Jlit1K
X-Gm-Gg: ASbGncuc+V1I6BAqNNN2osmpgUMkRQHiLzBSQAtexmBl4Rtq10Wce9Qnfkuc6t2gSZ+
	X5nNNsXMugVPLZbmN1L0MrphIFovec0C1eeEUozxqTAg3/j+PBObI0wglI+CiZi0W3mRzlmY84O
	70QQ2MYrV4451HsghifjeB9YAVNWFFq57AROPyqZWT1YGrzRgWNRn4KdZv3ljX2+AvpFNe0F8MY
	4W1+G1QDZqIWFbTu3hRw3g2MdBI/+NcCQ5zkB+jq519WkgUxErCOMeUClU/7/RBPD02+h4FMzVd
	zZ2JM3J0F08dmgj2GcJjVxiI/ITB+EejtBWywwa1QLhQ5vK0+GEsHekWs/At8mh3fjMiVNTFIzU
	j/g==
X-Google-Smtp-Source: AGHT+IFfw7TFgAS1+PJ2ixoq5QbghC65zW6OUluhn0c2YqIkAi39TMiTOlYUimLRyzbcfwSs961xew==
X-Received: by 2002:ad4:596f:0:b0:6e8:f65a:67c5 with SMTP id 6a1803df08f44-6f230cf5d59mr176620996d6.11.1744641146211;
        Mon, 14 Apr 2025 07:32:26 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea101dasm83906436d6.97.2025.04.14.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:32:25 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v1] ptp: ocp: fix start time alignment in ptp_ocp_signal_set
Date: Mon, 14 Apr 2025 17:32:20 +0300
Message-ID: <20250414143220.121657-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ptp_ocp_signal_set, the start time for periodic signals is not
aligned to the next period boundary. The current code rounds up the
start time and divides by the period but fails to multiply back by
the period, causing misaligned signal starts. Fix this by multiplying
the rounded-up value by the period to ensure the start time is the
closest next period.

Fixes: 4bd46bb037f8e ("ptp: ocp: Use DIV64_U64_ROUND_UP for rounding.")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7945c6be1f7c..e5b55b78a6d7 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2067,6 +2067,7 @@ ptp_ocp_signal_set(struct ptp_ocp *bp, int gen, struct ptp_ocp_signal *s)
 	if (!s->start) {
 		/* roundup() does not work on 32-bit systems */
 		s->start = DIV64_U64_ROUND_UP(start_ns, s->period);
+		s->start = (s->start) * (s->period);
 		s->start = ktime_add(s->start, s->phase);
 	}
 
-- 
2.47.0


