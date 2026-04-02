Return-Path: <netdev+bounces-274766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMKaNmf6zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:23:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA438F2D7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEDB03034A86
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63EA3A9DA9;
	Thu,  2 Apr 2026 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="UjhHxjKB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0F38425A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172167; cv=none; b=lLAc8oPq2/peZAS9C/szAn1YYiPs3MSCVisGfd83hxGpFWYE/yhcwffOyyAguoNY62U7AeWdZ/TROj8b3dIhQjsydmw+WLEGhN8hKNeF+uC1iMWOdb4ROz/yhP3oPsN87TKe3ASxK+eCnde/DDgmDsZImhTsif0fMkDaVexl3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172167; c=relaxed/simple;
	bh=DTdy0wGHn9nJPdYwvVneV3WjcTxwCTyqAhd+aFkuiNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRqzytaXNlqQcopQ90SxmIujLzPLik282/rWctje95S9EPwJSRusP/YkiQTxkPrsyzB4BbGmTtUS0W+DijjaZI02ryoNQFMfAMCG6XLnlzy6t7VZCesVIpnLF7Alg3Kvq07pNW/+71Bb0miZIiXUdUi7yt4k0W7C6Wx2wO2PG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UjhHxjKB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70f91776fcso548427a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775172165; x=1775776965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPx/23GDUuRn7oQUGbzWX+WqVXLgjJ891p+NWHhkBJw=;
        b=UjhHxjKB4J/ucIQj7IzKGn5JTn6iaN1jQ2phJYbD3qQjYP3JQNZYyzgsUzemltU19P
         LAXcC448YSqCnrv378IUKrc06/+7EZss4kPEeExTjLgRaRsSZoJCu30Vc8rsfIPXksnw
         FWFIxiNGRf5AQbpBfM9HZiEbqnarvsRND0AlXI5/FPN7ByZQlJ13/BUYMP8y2panWQ0X
         pGxjjZ3sEUpnqkmefTmf26MqjtBLDsZ6waPPPc3yS4/yIgXoTLoevSIsDtH2Frj8crek
         ggjn21Nq73noJsTwpOZaHJVZ4mt3H+LnQRtqm/ac0WYHeUPy4U7UPkyPizYauOkGg13H
         iQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172165; x=1775776965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPx/23GDUuRn7oQUGbzWX+WqVXLgjJ891p+NWHhkBJw=;
        b=oS2qwu/KrRI/OTViyisEKaXoY38rfZdlc1/D8DEw4LSG/bEjziEFv/4frJMw2XxbUP
         E/FdjC8sh0Pul6NgUmMPLmglALl0iuwdM2UuCmlcYW9shIrCtnPBaSU62CUjM7WxRgoF
         T/Yv+usgrnuwDQiEQrDkv9ZWfJlQhertldhmLAQB2Eneq8ViYWPJy1Zp55LBZRXU5WCN
         7xXVEBh7n6EzZkKur9O0e53q4rwJ/UwfWqNZFgw4Og4Fu/LCZh4wM5KjwU8F0V+l77l/
         fYA4tq20cenQwfxoxa3C7Uo66bPt+weyQ+0WrfIvXK8IAMCataA728QHoPeDAmOD174S
         1J3A==
X-Gm-Message-State: AOJu0YyQX49f3iK+RTpsVXeyipwa4f6dKH3fONRh4cF8awykaIO4w9RD
	gabkwHk7hBmU7cJHfQmhnJdSfixwqfo0PUD8eYlxn3lJdxepKbn571HzeV1t1RCmLa9fipvgGMo
	Z3LoC46o=
X-Gm-Gg: AeBDievjAJzNLLQv8Cp1vDT3IAuMHglvu4X+XCSY4psUJPooXr5nzPfMFZvwE7KGEpo
	qxacI8hVso3NDX4c4VycmSWPxmYA8Q769CubgUfmifcDQGZ1ynqRwAxjDosp7QdijSD7jViFdQO
	WzNqMrIMf3fgCANyiIgF0nYWwUcI9DT99EK34r4kurrZP1FzI+scMIDb5oIGwcgQAZn54A+pdc6
	3NJUnixy44uYFH0ZECDdkF/i9zgXcsOztAX8MDrPFhSQK/5pBbBSzCpWRIPgsYetso1nu51vcaN
	lI0MkFL1XqyHCq/4RQ4lhLhmzqAlLU9Ea7JwKDhsAmmymsaqA5GQdg8bJtoWNtbhykZFxcWTT8p
	DqVSD/d6SfpTP5z7aoUjoowkiD1vYldJpljXs0GElfz0VNhPtzYssidxY4M+FmgOap4z0lIIugB
	zIUC4Ma++ITIisDsI=
X-Received: by 2002:a17:902:f611:b0:2b2:65db:8c51 with SMTP id d9443c01a7336-2b28164cba3mr11916705ad.8.1775172165399;
        Thu, 02 Apr 2026 16:22:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm42617235ad.53.2026.04.02.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:22:44 -0700 (PDT)
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
Subject: [net-next 3/3] selftests/net: Test PACKET_AUXDATA
Date: Thu,  2 Apr 2026 16:21:59 -0700
Message-ID: <20260402232203.2004496-4-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274766-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama.to:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BECA438F2D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the packet socket selftest, adding a recvmsg path, to test
PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c  | 57 ++++++++++++++++++++++--
 tools/testing/selftests/net/psock_snd.sh |  5 +++
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index 7bbce274b9f0..682e0afe364d 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -40,6 +40,7 @@ static bool	cfg_use_qdisc_bypass;
 static bool	cfg_use_vlan;
 static bool	cfg_use_vnet;
 static bool	cfg_drop;
+static bool	cfg_aux_data;
 
 static char	*cfg_ifname = "lo";
 static int	cfg_mtu	= 1500;
@@ -281,9 +282,26 @@ static int setup_rx(void)
 
 static void do_rx(int fd, int expected_len, char *expected)
 {
+	char cmsg_buf[1024] = {};
+	struct msghdr msg = {};
+	struct iovec iov[1];
 	int ret;
 
-	ret = recv(fd, rbuf, sizeof(rbuf), 0);
+	if (cfg_aux_data) {
+		iov[0].iov_base = rbuf;
+		iov[0].iov_len = sizeof(rbuf);
+
+		msg.msg_iov = iov;
+		msg.msg_iovlen = 1;
+
+		msg.msg_control = cmsg_buf;
+		msg.msg_controllen = sizeof(cmsg_buf);
+
+		ret = recvmsg(fd, &msg, 0);
+	} else {
+		ret = recv(fd, rbuf, sizeof(rbuf), 0);
+	}
+
 	if (ret == -1)
 		error(1, errno, "recv");
 	if (ret != expected_len)
@@ -292,6 +310,31 @@ static void do_rx(int fd, int expected_len, char *expected)
 	if (memcmp(rbuf, expected, ret))
 		error(1, 0, "recv: data mismatch");
 
+	if (cfg_aux_data) {
+		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+		struct tpacket_auxdata *adata;
+
+		if (!cmsg)
+			error(1, 0, "auxdata null");
+
+		if (cmsg->cmsg_level != SOL_PACKET)
+			error(1, 0, "cmsg_level != SOL_PACKET");
+
+		if (cmsg->cmsg_type != PACKET_AUXDATA)
+			error(1, 0, "cmsg_type != PACKET_AUXDATA");
+
+		adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);
+
+		if (adata->tp_net != ETH_HLEN)
+			error(1, 0, "cmsg tp_net != ETH_HLEN");
+
+		if (adata->tp_len != expected_len)
+			error(1, 0, "cmsg tp_len != %u", expected_len);
+
+		if (adata->tp_snaplen != expected_len)
+			error(1, 0, "cmsg tp_snaplen != %u", expected_len);
+	}
+
 	fprintf(stderr, "rx: %u\n", ret);
 }
 
@@ -312,6 +355,10 @@ static int setup_sniffer(void)
 		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &one, sizeof(one)))
 			error(1, errno, "setsockopt SO_RCVBUF");
 
+	if (cfg_aux_data)
+		if (setsockopt(fd, SOL_PACKET, PACKET_AUXDATA, &one, sizeof(one)))
+			error(1, errno, "setsockopt PACKET_AUXDATA");
+
 	pair_udp_setfilter(fd);
 	do_bind(fd);
 
@@ -322,8 +369,11 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "bcCdDgl:qt:vV")) != -1) {
+	while ((c = getopt(argc, argv, "abcCdDgl:qt:vV")) != -1) {
 		switch (c) {
+		case 'a':
+			cfg_aux_data = true;
+			break;
 		case 'b':
 			cfg_use_bind = true;
 			break;
@@ -436,7 +486,8 @@ static void run_test(void)
 		check_packet_stats(fds);
 	}
 
-	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
+	if (!cfg_aux_data)
+		do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
 
 out:
 	if (close(fds))
diff --git a/tools/testing/selftests/net/psock_snd.sh b/tools/testing/selftests/net/psock_snd.sh
index b6ef12fad5d5..111c9e2f0d21 100755
--- a/tools/testing/selftests/net/psock_snd.sh
+++ b/tools/testing/selftests/net/psock_snd.sh
@@ -97,4 +97,9 @@ echo "raw gso max size + 1 (expected to fail)"
 echo "test drops statistics"
 ./in_netns.sh ./psock_snd -D
 
+# test aux data
+
+echo "test aux data"
+./in_netns.sh ./psock_snd -a
+
 echo "OK. All tests passed"
-- 
2.52.0


