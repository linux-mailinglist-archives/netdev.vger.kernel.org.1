Return-Path: <netdev+bounces-274764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILTdAmj6zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:23:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8E38F2D8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E19D305846F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E3397E76;
	Thu,  2 Apr 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="L5mvlOXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101B3890E1
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172163; cv=none; b=kvjeKC4lrEPdPUvtPUfz7+l37Hf2cHvY0SLxzw3+Vh7fdXIf9rlTT2OsvmwetaWGbvmor3G9iksOR5uT1CgPZztjTQpQU9mdLR/7TfOhwnni7dvVlg117Uy3O0SJJFJASA8fJ67grdtRL2WS007XiDRk5oHtMm9GAYrXB70jjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172163; c=relaxed/simple;
	bh=J4kk90yuxxA42SHtt+Ov+rBowYEAkbWXfw9oGJun+BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snrWt+5z9WC3jdDUd6EUbl/sG9dirwWTE7btY4EyqQdk0hy4TkIbLp5/Bq1v13IwpjXMobXW6Zh6pTU4Kw0NAArZaOunkI+DNpyCdey7gh3nSTb15ae6XGKoBhqcz8lDzYjSdbMjKe+dlPzXSMbjUPWZfPjmCZXMfalogAtDeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=L5mvlOXp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cf976ecacso598417b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775172161; x=1775776961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/znVnDeXjnXzaaF0D3QPKaN1Wp2D3MlfOCy7zxinTk=;
        b=L5mvlOXpo9GuRB05+CefSLJG3fY4naXPL3ScsMnISrrTzV5IQMMMHvlhhVWX3mGemi
         nJ4jis/WGryHwy968WFzyeeKdfHO4W5aZpmrev7AErr3CPuTBECIUA8sR352izBCJrXT
         VbGvS3iw6RfqkcpxORbYnUcitgR4OwNpP3BT70th6YB+3AZ0MeEg/shCpGj7+douarjs
         tFTJKZ+fvb+WstHQ++LeMFS/xGOOLxx+/BrHG9PdiK9F/e9dBQkGgtZsDjwAg53MnH08
         tkeuwK08ztU1Pnw6BwTPwq9SMojKnGtHbxREPdUB/iNOYQStaD1GZdMecGR0183ZI0eQ
         orFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172161; x=1775776961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/znVnDeXjnXzaaF0D3QPKaN1Wp2D3MlfOCy7zxinTk=;
        b=CeSFQG/EsyevZPrJlBf8F/FcEl9QyHM1L8OqhiJx58x64fp0SjllGaojGQJKIqrkif
         H2ZKB5+JVHYZcjd9iue62da6shwUMsqn6k7sg8ihFU7eUeXR+cqm7gnHo2KgK8EBOTzE
         FRxLUC7055FX3z5nBD5wtwwxjZeyc6f61tNuKumXBzHuMItTCA7b4N/yqkTpzDfUIk5q
         H8+YLun702j0V0IU64DkG4Be2R/SxcFodkO0xfqtQdyhpo43s1UdcvN38wvfkk/KsZus
         ufWqH8owExHGTZEYpcvl9sZjdVlNIIcFcbec679xFypi5QK0GOlAzt1iSK0oO1GvfIrR
         kphA==
X-Gm-Message-State: AOJu0YwCyYUfLQVMx+xG+zNJE3TKrFn0JsdWcEbCUMNf7Z9apWS1syt1
	1ZWyQsHFB6CyuZu+c+D4/9eeP8OTuC4r5eWalRlTJf4pR6HDnLMTu7jCoISk3fz8StJ56eVLssB
	ACmRnGvM=
X-Gm-Gg: ATEYQzzUGMmcfyDBrwU3YrThMxCX4KhMPm9yieRojcTqbR60TIdVO8nlznOYDT2j8Bh
	lrdIaZT+BAyA10rj8FxYJzEHQ/IPyXx1d9owGO+66X5SZKrfklVR9/lhoZjsRHcLbq6KGxMqrw/
	BcyKC0MJADs5iggedKYKuoWhqe5RKhUleUYNuwqr6jk4DqRbqIGWPF+jOO7d4AlgsM+zgwiYa7O
	azhkTkfprgYfhm5Wn+yG1/GbMsWvw6WuuNNDYSLAbme0OB8i62ytnSkE3RzGcye6ELJCQoyp3EK
	CtVGRxbq0vupjremRD1TzdvrMkZHfp2C71KMZHb8qHEgCHNYOCIlAVxYOSLzLSMT8r0/L3eK/bL
	x9n6QAh3pen14uvEiCMJD3gsDSLlZNNKi1J2Vsb1bUnNoPOu6W9CWafn8g39qpSMHG9F/IrZfiD
	eoS0X4
X-Received: by 2002:a05:6a00:2d18:b0:829:7b0f:c9de with SMTP id d2e1a72fcca58-82d0db4f7efmr788927b3a.35.1775172161583;
        Thu, 02 Apr 2026 16:22:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b27313sm4052568b3a.5.2026.04.02.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:22:40 -0700 (PDT)
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
Subject: [net-next 1/3] selftests/net: Test PACKET_STATISTICS
Date: Thu,  2 Apr 2026 16:21:57 -0700
Message-ID: <20260402232203.2004496-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402232203.2004496-1-joe@dama.to>
References: <20260402232203.2004496-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274764-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: BED8E38F2D8
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


