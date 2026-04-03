Return-Path: <netdev+bounces-275288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILX3D0lO0Gnr6AYAu9opvQ
	(envelope-from <netdev+bounces-275288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 987FC39910A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A1D3047BDE
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56936DA13;
	Fri,  3 Apr 2026 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="tsb+mveU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846438F956
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259168; cv=none; b=c694DDy6Ev7TuVHYuBW15z34KS8qpSwG5EIYWorSavNtYw+LreK+L0aTn5Q3eeTEO0qsRQqCI9zWt3r51mvbiJFOeuPUlCrjhauOl996yMscp6xpKPZrEa1b8QXbhe6Z7yjII7SEhJulPCrQ4UFGwdrW30kLl7kcrSmSmTPuC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259168; c=relaxed/simple;
	bh=J4kk90yuxxA42SHtt+Ov+rBowYEAkbWXfw9oGJun+BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1Jyy6H7kyWCtUkO6EaU+kv0tWY2GjgKuGv909DzEfKXoB9hocR5B5pWBNgLz7T5eXBaDZYq5UiEZ/c3nVJfwLpots13Bjp/G8XmuZsEBDoD8zRkjwgqG5GuT4s2efigNFWjI4UHPCW4k4CoNfPJFo+qRHyeDmPchEazbuYfN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=tsb+mveU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82418b0178cso1111964b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775259166; x=1775863966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/znVnDeXjnXzaaF0D3QPKaN1Wp2D3MlfOCy7zxinTk=;
        b=tsb+mveUsa7Pmiu5IYzZiavh8HSMrGf6c2vj6hg3GZ/H2NTGLqYJumUc1n99wxA/sC
         93DY+s6zmB+dvNWOJJpJRMeV8xYVwI0LLyqhzYkj94XMaKJJbTy2FkxmUx6Jv8c6Wp61
         BFXxcMcI04H3eBnjZYhw1ywPK0f/Y5HblnXon6y0sLUfcbpLhSHQBUpUepUZPzcy0zvi
         fgAM8eleeBXccIJd55CSBP9GI2vTRTtwx5aIFn1BT1BZPBO1Lw6IVnmM20NMDE25kaE+
         13SUhC8Yr1XMle9PZYLhgkB/vu+uHviRqFABNvMxI5S1VXAFngS10BUFOuHSu4x9KSph
         vdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259166; x=1775863966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/znVnDeXjnXzaaF0D3QPKaN1Wp2D3MlfOCy7zxinTk=;
        b=bu1CRPBsUhIgIne6bW9JhQdGMC4Jj16/XiysrzJgKgsPrZ3RgFczlLm5P/Hmkp5Tn3
         /pKRwYt6rhlH3xCa1SSxC/n7kJ3W2PdT1naLhNPUk8ZO+1HcTf1s1cwBZSiENgQXGqu4
         7aHs1EEL2AdDLKqVbksUdRwyQq+vSTqbw9al3ZlsSSnz2JhaN5FWaeVz7rv16vExEMIx
         SmVv4W7YSClAa6gGEJX6uemd+O2k1CJg2YIMiujZIHZWVoEtOPdTiKB3lu8+n9TSDGWD
         LKOTAmpVfBAJuU8obNMYBRhuefyMk3p1fh2WgWp+wzT1zAI4GM7k+ZvIdPDlIJsG6nKX
         uw5w==
X-Gm-Message-State: AOJu0YxMOwFFpKNA/M5Q8VTns8fpBsvQ4UTyQpfI2ELBuXm4d+gOW0In
	+4Os/lyjSBGs12UIzI1hBLuUzn0uyaT4TQSnk3mWdWVY9eq9xeHTJI6L8iDvIiCjS0m8rKRA8+H
	JDHvsKm8=
X-Gm-Gg: AeBDietQ1BkcMdU8sx3Svt9hSXNZTGJTQOK1Fg1XIfRO0EhZnij9zFpPKEeI8PVfg8H
	XMOBEpQj/CI9cyPhdqkjS1Pz93Ql03spOsoAEPaMB771N2r98nSFhe2hs73Ms8nGNZxLJyGM847
	eYfMXeUylqfGLO8ALH+xN5So7pRCt7T9Fm0IHQzfVTUbGK7JsgpHt3DYffbtODxfYeVSNK9Qwvu
	ChwnDLzWrClk+npfyxSQkmX2Cimn7x9czlqN+xLliSi1Blv3656xFLxJQUDxDGq5USeUsWi5ZDr
	ZUgf0mjFwT5416A3L1v1z/D2OA3FK3VAu1NdPqy6JhMSTVjdy6tBUYKdijrRBZqXsBvdYjzUW+m
	PjMs8P8GuMG9fNe4sV0dffCtZhTjKiJwUZ9gvZ07Q7yGUJByIkw7MG3b2flR2EvXJY5guhNWGcE
	GpcYNk
X-Received: by 2002:a05:6a00:4b4c:b0:81f:ac78:ed22 with SMTP id d2e1a72fcca58-82d0db53f18mr5221546b3a.37.1775259166173;
        Fri, 03 Apr 2026 16:32:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d439sm7229853b3a.35.2026.04.03.16.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:32:45 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	Joe Damato <joe@dama.to>,
	linux-kselftest@vger.kernel.org
Subject: [net-next v2 1/3] selftests/net: Test PACKET_STATISTICS
Date: Fri,  3 Apr 2026 16:32:36 -0700
Message-ID: <20260403233240.178948-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403233240.178948-1-joe@dama.to>
References: <20260403233240.178948-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-275288-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 987FC39910A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the existing packet socket test to include a test for the sockopt
PACKET_STATISTICS.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c | 32 ++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index edf1e6f80d41..5be481a3d2bd 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -359,6 +359,34 @@ static void parse_opts(int argc, char **argv)
 		error(1, 0, "option gso (-g) requires csum offload (-c)");
 }
 
+static void check_packet_stats(int fd)
+{
+	struct tpacket_stats st = {};
+	socklen_t len = sizeof(st);
+
+	if (getsockopt(fd, SOL_PACKET, PACKET_STATISTICS, &st, &len))
+		error(1, errno, "getsockopt packet statistics");
+
+	if (st.tp_packets != 1)
+		error(1, 0, "stats: tp_packets %u != 1", st.tp_packets);
+
+	if (st.tp_drops != 0)
+		error(1, 0, "stats: tp_drops %u != 0", st.tp_drops);
+
+	/* verify clear on read */
+	memset(&st, 0xff, sizeof(st));
+	len = sizeof(st);
+
+	if (getsockopt(fd, SOL_PACKET, PACKET_STATISTICS, &st, &len))
+		error(1, errno, "getsockopt packet statistics");
+
+	if (st.tp_packets != 0)
+		error(1, 0, "stats: tp_packets %u != 0 after clear", st.tp_packets);
+
+	if (st.tp_drops != 0)
+		error(1, 0, "stats: tp_drops %u != 0 after clear", st.tp_drops);
+}
+
 static void run_test(void)
 {
 	int fdr, fds, total_len;
@@ -369,9 +397,11 @@ static void run_test(void)
 	total_len = do_tx();
 
 	/* BPF filter accepts only this length, vlan changes MAC */
-	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan)
+	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
 		do_rx(fds, total_len - sizeof(struct virtio_net_hdr),
 		      tbuf + sizeof(struct virtio_net_hdr));
+		check_packet_stats(fds);
+	}
 
 	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
 
-- 
2.52.0


