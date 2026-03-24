Return-Path: <netdev+bounces-271265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLKRMRXswmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:55:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB931BEDC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B654130C5B5D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75D34676D;
	Tue, 24 Mar 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9afyTZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346D313E36
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381890; cv=none; b=K+INe+AfF61+XKtO6Q60xBGHSD/lS34tMfA/Q5UGcrrub7kPnxwLj5cC8Eqg4D2tjUDMH/sApaI1chXbnBPeUvJrwxOgPuQqPNhxSj4Q+EFv1ert7BXLw/eyYldC5W4a3eOrJHrrwvo4ByXQKhUyWHrYMePwX+Lt0W2Rq0QYUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381890; c=relaxed/simple;
	bh=/mm+3yEXYqfwAngxm3bZIdCKr/yBRxH8m+joF98ZsvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEi6aAj2ZKoIeWDA1qQgYtzshC9crbxUbp0ppvPwTnt13qUMC1rfb1XHH7hoOBkR2+BklAn7IcIIe/257FbLltzQEgs24v0kAzmft2S+Ue5tdpgGTSNp9QRtlx7k3u23AgyhlHdAAh0QRyPTRYHeuHx+hgQKhAowuIjTEkogenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9afyTZ5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c741692db4cso63176a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381888; x=1774986688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmQnEO18bvLloeehg0qw/sXcoT8UcPeOWutrTiYEalw=;
        b=Q9afyTZ5Emkp1lthKuOmuRhjTM5JQYEcbrLrr/LYNr3SRMCipYl+NoMqUdu2F9A732
         7FQml6uqH4jbw+9K0pjaq+Fn2B3fypvmhPF9aC3D+Bovi8/ixdWSQbHRr/9f/zWOlC+G
         OqMxyGOlOTqmm4yqczx4tQEtD/UqP1xkooalLUtAfxYO539NJ9XkmMyEco4jpHynIsKB
         p0TCD0fC51bWgXuTMsEaG+3UNzU0XR0O+C122Ro58/gii//gk7IOeAYlJvaYKXoyQIwP
         Yy8rEmvIG9KOIjzd4TsawA/PGmM7X+GwNdQJ1Yqe+l02/tzHxzGfeS+A9vshAkMv1CaQ
         yevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381888; x=1774986688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmQnEO18bvLloeehg0qw/sXcoT8UcPeOWutrTiYEalw=;
        b=NA/b43ATd/LLbsxBJZrpI1HYK0DnfChTHnpXsgJ2nQlCwBmFy2+Y5eTQnawcGKyrcR
         KOLdqo2alIBhSH6CWx0Zdrj4R5G9h+/7NUjFLd3teE0O+zHjDv1xGHujxNYSSO3zYTM1
         RSMmul4SpWToN7madfPAcC9CZyDa5Cm+TlaKlkL2lGe3cAkw2FQTe1PUBJeqq6tUYP6K
         gV31s73b4fZC0LNtRetQXMNNOUceQTqrrDriU/7aDZzKZtCxpvH8WnVkc3kzIgJlNwZL
         JxtBnPFv+XW0MlGlEpi1ez0wOTGcqqOe2+Sf7/R9m19jq/VFVnN3tfsqaoBL8//bNIx9
         LWvg==
X-Forwarded-Encrypted: i=1; AJvYcCV0x8wZpfA4LdbYHI7hn6xchnvFO/lBNqtgQfu0N7l2ZU4d6w5sKYx2f6EKrgPpcdODIRuEz6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvAXusmpJgYYToYtGSAI/O3DKJkKCqMAsHbMBqI95F9GnXeB2
	RKyxNSegcMem5ODhUAvWQTjLEBz79zajmLoPzXA0i/ehJn6+35DGLybP
X-Gm-Gg: ATEYQzxNMaY1T9u/G+gEuBwIXzGPGOZaXqYSgT8MSCtDmsc1d/s5av3mzKVtx9eEX/F
	PUB3tM4lKdP+3tARjM0D1ptcLNBDzgXPpd5Wcgr6foxc3hpfubuHTGLgeQPC2+XFD1sLH3VvtsX
	Y+MKPDYBAzo3zjdRtDLy7tP2GIwkdrjtphvOPaFnvlYW+0LV4ZaUXHtw7pvdELSSIggmA/NyRXh
	QLF50IvNyy+ewyqgl6ujNbv92mGM9xDQQYmmoMdYQhswA/GS8xzo4jcbWj8nasKv8VGa1wedNNx
	81pwwcZuYnOkBe3AokvdXD2fXjwIAbWRsZ28y1XDujGGYdbd3M1OVedAQtbS44fmAgBmCEZdKr1
	SpYspqiUZyUZ9VqxXOaX12hA25mfmzehbgFF3MAvW39WnAw33OHjDtVrVYg7PwoFp90PJSVThc7
	X649y4Y2uF7g6B/sNl6oba41i/GcqQCbv7xiS965s=
X-Received: by 2002:a05:6a20:a123:b0:398:7796:7823 with SMTP id adf61e73a8af0-39c4abb7039mr904207637.6.1774381887655;
        Tue, 24 Mar 2026 12:51:27 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:5a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm12996732b3a.45.2026.03.24.12.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:51:27 -0700 (PDT)
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
Subject: [PATCH net 2/2] eth: fbnic: Fix debugfs output for BDQ's with page frags
Date: Tue, 24 Mar 2026 12:51:23 -0700
Message-ID: <20260324195123.3486219-3-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
References: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-271265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,google.com,redhat.com,lunn.ch,gmail.com,trager.us,intel.com,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 3EAB931BEDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dimitri Daskalakis <daskald@meta.com>

The rings size_mask represents the number of pages, so we need to
determine the number of page frags when dumping the descriptors.

Fixes: df04373b0dab ("eth fbnic: Add debugfs hooks for tx/rx rings")
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index 08270db2dee8..3c4563c8f403 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -197,7 +197,7 @@ static int fbnic_dbg_bdq_desc_seq_show(struct seq_file *s, void *v)
 		return 0;
 	}
 
-	for (i = 0; i <= ring->size_mask; i++) {
+	for (i = 0; i < (ring->size_mask + 1) * FBNIC_BD_FRAG_COUNT; i++) {
 		u64 bd = le64_to_cpu(ring->desc[i]);
 
 		seq_printf(s, "%04x %#04llx %#014llx\n", i,
-- 
2.52.0


