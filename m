Return-Path: <netdev+bounces-275290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKfyMLhO0Gnr6AYAu9opvQ
	(envelope-from <netdev+bounces-275290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358C39912F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66E083084ADF
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEEF38A72F;
	Fri,  3 Apr 2026 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="vwmasTSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4D3909B6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259172; cv=none; b=L+KRU+s1nSTky9GCBhuxNXp5VOWdvRhjqArfMY3A6zrHut+UdgT42XbylBO9MYfCx83KqLqmJBRD6HvPWAbB66DxmMtWqFGcXWJJifqWBTjnOtFm6e+5e5j5i8Iwf5XMg32vYgwaoDDxeO/UdBfPMrDbLwsB8zy1ybgzb2J4/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259172; c=relaxed/simple;
	bh=eu5jZunTrftltps3rQrKaYDal1uU6Yu6GQaFaOvmB3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUWtEGFayqrNht+2AvpfJ4rsG0ukDUjFoOl5vJntR81mXWc8dQ1Z9vrTHAmR1qKk8plwDYoRorm/uDcZszyTnTjzXxR+8QrnjjOBiO/sUbBd8tdyJ8rlEzS7XwgRSlUcio81BW+DhsCfmf4+AAPB+ObjDwX/Y9ATTvIYjMacqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=vwmasTSr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b24fede2acso12156925ad.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775259170; x=1775863970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofx4AIZ9/cOO66oovYm6JD1XQUXd4lYsRtHMoCpiyu4=;
        b=vwmasTSrwDgJrVNAg/v98XxAetB1e8iW2pM3O7x3s+JnMPIFbDtyc1NQLyg53bnwRr
         XRNID9lousc98rEcvqkythqlWAz89Ci3k/pKGVGB4FzP6p6d7MZM9cwRNF0sn+t/FCVs
         QjRaMzhyAUe+lDia39mnKIU5wuwDnAJAQ9z/PEBLNxo/QQuACl1bw7nQu7nia1DuHBWS
         3Ku6BAhTjGZimw3nMRM0yPq92Im9ZYxX0/nGYUDlmL6bSynNS6eMq86tBCRUbzM4LeW7
         /SAVg+EvyvHBd94Y3v1ZGaLH/T998svDNtGXiIIoqSV/g+4DXUH55PtOs9QTlHImVoel
         BUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259170; x=1775863970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ofx4AIZ9/cOO66oovYm6JD1XQUXd4lYsRtHMoCpiyu4=;
        b=YeL4gkUVC5HLKE3bKvjoWtECdAplpE3H2/JKKSJim5DvLZPo8EukcM7DtsImJ8XakE
         aWNENTZ47rEdZiNmOUBwtcrw+J3MmLPbWP3Kz/dayYFoUz/lGUu0mVIffsy6yYFWc9cS
         zeSJlvro/YImSUSgK8qj5dCF6EshfywkhrA/xPzObIMGwq0c4FXkebIXY2MlRVFQfoGR
         2VUVO41HOe4KGfpX6ixF8nsicTyVmUSXRFgzhkqHtrvqehmKmqFOqbwQyzoBlmkQFGLQ
         ra6ODzspWgVUU7vG6vEWnqxMZ67fl4Inhlo4AIOvEZuCqFyyg3CfNzOBK/dnkE5+t8Ch
         Ro4Q==
X-Gm-Message-State: AOJu0YzbIp9P2WTA+CxszHUDP+mewprIzHMWlAvAR/FPJI6CbYVnvmCv
	QIlbI2rpf9/F3Yv6Z4ZCxRkoX788L8bPyD0XttNqYwEcV0NHwY5oPe4245GckMhYHMyqHcHlrep
	nPODubq4=
X-Gm-Gg: AeBDieuAarIAqiF9/mwTv/oienn1rlkPg82r6LirjAotrAnJeKaUaHb7qWKkG9Z6QSw
	T1Cu7MiTOEqT6xJLYpf4+vdZvMswP5AEJ74BO6GI37+8d+TqAm300Jd8ySkJyRhDYjHnnLSGbry
	gH2BDOZhmmGCoEY29v7ArOP5L6+FQR9ZtSzG0TUf4ktdm+dkI00jrA9BmC1KwSEmC6s4mvuY7oW
	CblMfV2G5cFQ+B2GZMzy5rVnDDWnN3XzoIdwNLWDR99fTPNc84jHUjQdd7WH8yZAmFP+VWLvTCo
	/lb/f0TuPPGlKkCPYX+BpQBD843tOtiwvo64lEwCwRlOWZdn1X0f8VcidDktMZvD50H3tT4Xbzh
	0qw8HjjLCtVsDxQ0UHg72xyb25w70pX8GHvRPWpcxTt0YA/TJ1FQIWSDodFtTcc6Cg8oJFWa9xX
	Xw7tqI
X-Received: by 2002:a17:903:4b4c:b0:2ae:4cb8:484a with SMTP id d9443c01a7336-2b28182068amr49451485ad.17.1775259169762;
        Fri, 03 Apr 2026 16:32:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d233sm70066325ad.2.2026.04.03.16.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:32:49 -0700 (PDT)
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
Subject: [net-next v2 3/3] selftests/net: Test PACKET_AUXDATA
Date: Fri,  3 Apr 2026 16:32:38 -0700
Message-ID: <20260403233240.178948-4-joe@dama.to>
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
	TAGGED_FROM(0.00)[bounces-275290-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2358C39912F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the packet socket selftest, adding a recvmsg path, to test
PACKET_AUXDATA. Check basic attributes of tpacket_auxdata.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c  | 67 ++++++++++++++++++++++--
 tools/testing/selftests/net/psock_snd.sh |  5 ++
 2 files changed, 67 insertions(+), 5 deletions(-)

v2:
  - Add is_psock bool argument to do_rx.
  - Factor out aux data check into its own function for readability.

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index 81096df5cffc..5464317c1764 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -40,6 +40,7 @@ static bool	cfg_use_qdisc_bypass;
 static bool	cfg_use_vlan;
 static bool	cfg_use_vnet;
 static bool	cfg_drop;
+static bool	cfg_aux_data;
 
 static char	*cfg_ifname = "lo";
 static int	cfg_mtu	= 1500;
@@ -279,11 +280,54 @@ static int setup_rx(void)
 	return fd;
 }
 
-static void do_rx(int fd, int expected_len, char *expected)
+static void check_aux_data(struct cmsghdr *cmsg, int expected_len)
 {
+	struct tpacket_auxdata *adata;
+
+	if (!cmsg)
+		error(1, 0, "auxdata null");
+
+	if (cmsg->cmsg_level != SOL_PACKET)
+		error(1, 0, "cmsg_level != SOL_PACKET");
+
+	if (cmsg->cmsg_type != PACKET_AUXDATA)
+		error(1, 0, "cmsg_type != PACKET_AUXDATA");
+
+	adata = (struct tpacket_auxdata *)CMSG_DATA(cmsg);
+
+	if (adata->tp_net != ETH_HLEN)
+		error(1, 0, "cmsg tp_net != ETH_HLEN");
+
+	if (adata->tp_len != expected_len)
+		error(1, 0, "cmsg tp_len != %u", expected_len);
+
+	if (adata->tp_snaplen != expected_len)
+		error(1, 0, "cmsg tp_snaplen != %u", expected_len);
+}
+
+static void do_rx(int fd, int expected_len, char *expected, bool is_psock)
+{
+	bool aux = is_psock && cfg_aux_data;
+	char cmsg_buf[1024] = {};
+	struct msghdr msg = {};
+	struct iovec iov[1];
 	int ret;
 
-	ret = recv(fd, rbuf, sizeof(rbuf), 0);
+	if (aux) {
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
@@ -292,6 +336,12 @@ static void do_rx(int fd, int expected_len, char *expected)
 	if (memcmp(rbuf, expected, ret))
 		error(1, 0, "recv: data mismatch");
 
+	if (aux) {
+		struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+		check_aux_data(cmsg, expected_len);
+	}
+
 	fprintf(stderr, "rx: %u\n", ret);
 }
 
@@ -312,6 +362,10 @@ static int setup_sniffer(void)
 		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &one, sizeof(one)))
 			error(1, errno, "setsockopt SO_RCVBUF");
 
+	if (cfg_aux_data)
+		if (setsockopt(fd, SOL_PACKET, PACKET_AUXDATA, &one, sizeof(one)))
+			error(1, errno, "setsockopt PACKET_AUXDATA");
+
 	pair_udp_setfilter(fd);
 	do_bind(fd);
 
@@ -322,8 +376,11 @@ static void parse_opts(int argc, char **argv)
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
@@ -432,11 +489,11 @@ static void run_test(void)
 	/* BPF filter accepts only this length, vlan changes MAC */
 	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
 		do_rx(fds, total_len - sizeof(struct virtio_net_hdr),
-		      tbuf + sizeof(struct virtio_net_hdr));
+		      tbuf + sizeof(struct virtio_net_hdr), true);
 		check_packet_stats(fds);
 	}
 
-	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
+	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len, false);
 
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


