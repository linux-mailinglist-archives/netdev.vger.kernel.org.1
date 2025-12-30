Return-Path: <netdev+bounces-246303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA53CE8F30
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6147E3015591
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7111519B4;
	Tue, 30 Dec 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAH1+k+I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2F2FD698
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081595; cv=none; b=OmwRRRWOZFfM5pxHRTLddoEEvREgccS/O6ZBJNkc54jTUE0zgmVXl37zQF0+IAuzyvbsmNMLfhF1KHHZ6EwKLH7YKcYr+N1xZHe7GK5e7xx0RbPnecuy5KfWi2luqUiIM8fiCKXmTtbEApS1ELRJueQMfQfTZfJtf2xIwJAPaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081595; c=relaxed/simple;
	bh=A9eHKD1wuR2AB7ym2KBl010k+MDToNhmM511fjTVzac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARix2ifeFEh74geJsbOprCVpA3CDENVyF7EeBl+4q8MwSd7a4D4I+1VP7Iu//MAVyZsXShx7NDU4cwHN8nOHAY5+NNPnmO3v8EMYLdqzUfV7rxapzMhg7izVbHgBhk0UJ0ZbYfT/2TdXcxpx0Uz1R9/Gw1fTlXitPbCE76N2eDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAH1+k+I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767081592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvUgZNgE+2O5SZ3XN5OGJVXjV7D5E3bPQGGa5K59U0U=;
	b=gAH1+k+ImC8mNIKNI/UB4I7w1af3RCwCVp2koqzAMw9g2xjHHvaDCKNh4EihPiJcHJ/Ew+
	J6k+JW51fya9cz3NFJyRt2m1rIMpLIuEeZ2+GucnSjxRt0xBytum3q3q8L2jbMOxAFK4tX
	u43Vpj1wgUauSidPlUzm469k/zL1m1c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-XCqpAOB9P9q_-Om7Vc1PWQ-1; Tue,
 30 Dec 2025 02:59:48 -0500
X-MC-Unique: XCqpAOB9P9q_-Om7Vc1PWQ-1
X-Mimecast-MFC-AGG-ID: XCqpAOB9P9q_-Om7Vc1PWQ_1767081587
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25C7B1956096;
	Tue, 30 Dec 2025 07:59:47 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2E671800576;
	Tue, 30 Dec 2025 07:59:43 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org
Subject: [RFC PATCH net-next v2 7/8] selftest: tun: Add test for receiving gso packet from tun
Date: Tue, 30 Dec 2025 15:59:11 +0800
Message-ID: <ad95f5debb2f6a48dbf8af54854f28751f7e86b5.1767074545.git.xudu@redhat.com>
In-Reply-To: <cover.1767074545.git.xudu@redhat.com>
References: <cover.1767074545.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The test validate that GSO information are correctly exposed
when reading packets from a TUN device.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v1 -> v2:
 - Use previous helper to simplify tunnel packet sending.
 - Treat read timeout (EAGAIN) as assertion failure.
 - Correct spelling of 'recieve' to 'receive'.

 tools/testing/selftests/net/tun.c | 194 ++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index dc114237adda..519aaffd6d1a 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -356,6 +356,116 @@ static int ip_route_check(const char *intf, int family, void *addr)
 	return 0;
 }
 
+static int send_gso_udp_msg(int socket, struct sockaddr_storage *addr,
+			    uint8_t *send_buf, int send_len, int gso_size)
+{
+	char control[CMSG_SPACE(sizeof(uint16_t))] = { 0 };
+	int alen = sockaddr_len(addr->ss_family);
+	struct msghdr msg = { 0 };
+	struct iovec iov = { 0 };
+	int ret;
+
+	iov.iov_base = send_buf;
+	iov.iov_len = send_len;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_name = addr;
+	msg.msg_namelen = alen;
+
+	if (gso_size > 0) {
+		struct cmsghdr *cmsg;
+
+		msg.msg_control = control;
+		msg.msg_controllen = sizeof(control);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		cmsg->cmsg_level = SOL_UDP;
+		cmsg->cmsg_type = UDP_SEGMENT;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint16_t));
+		*(uint16_t *)CMSG_DATA(cmsg) = gso_size;
+	}
+
+	ret = sendmsg(socket, &msg, 0);
+	if (ret < 0)
+		perror("sendmsg");
+
+	return ret;
+}
+
+static int validate_hdrlen(uint8_t **cur, int *len, int x)
+{
+	if (*len < x)
+		return -1;
+	*cur += x;
+	*len -= x;
+	return 0;
+}
+
+static int parse_udp_tunnel_vnet_packet(uint8_t *buf, int len, int tunnel_type,
+					bool is_tap)
+{
+	struct ipv6hdr *iph6;
+	struct udphdr *udph;
+	struct iphdr *iph4;
+	uint8_t *cur = buf;
+
+	if (validate_hdrlen(&cur, &len, TUN_VNET_TNL_SIZE))
+		return -1;
+
+	if (is_tap) {
+		if (validate_hdrlen(&cur, &len, ETH_HLEN))
+			return -1;
+	}
+
+	if (tunnel_type & UDP_TUNNEL_OUTER_IPV4) {
+		iph4 = (struct iphdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct iphdr)))
+			return -1;
+		if (iph4->version != 4 || iph4->protocol != IPPROTO_UDP)
+			return -1;
+	} else {
+		iph6 = (struct ipv6hdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct ipv6hdr)))
+			return -1;
+		if (iph6->version != 6 || iph6->nexthdr != IPPROTO_UDP)
+			return -1;
+	}
+
+	udph = (struct udphdr *)cur;
+	if (validate_hdrlen(&cur, &len, sizeof(struct udphdr)))
+		return -1;
+	if (ntohs(udph->dest) != VN_PORT)
+		return -1;
+
+	if (validate_hdrlen(&cur, &len, 8))
+		return -1;
+	if (validate_hdrlen(&cur, &len, ETH_HLEN))
+		return -1;
+
+	if (tunnel_type & UDP_TUNNEL_INNER_IPV4) {
+		iph4 = (struct iphdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct iphdr)))
+			return -1;
+		if (iph4->version != 4 || iph4->protocol != IPPROTO_UDP)
+			return -1;
+	} else {
+		iph6 = (struct ipv6hdr *)cur;
+		if (validate_hdrlen(&cur, &len, sizeof(struct ipv6hdr)))
+			return -1;
+		if (iph6->version != 6 || iph6->nexthdr != IPPROTO_UDP)
+			return -1;
+	}
+
+	udph = (struct udphdr *)cur;
+	if (validate_hdrlen(&cur, &len, sizeof(struct udphdr)))
+		return -1;
+	if (ntohs(udph->dest) != UDP_DST_PORT)
+		return -1;
+
+	return len;
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -683,6 +793,68 @@ receive_gso_packet_from_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
 	return total_len;
 }
 
+static int send_gso_packet_into_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
+				       const FIXTURE_VARIANT(tun_vnet_udptnl) *
+					       variant)
+{
+	int family = (variant->tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET :
+								      AF_INET6;
+	uint8_t buf[MAX_VNET_TUNNEL_PACKET_SZ] = { 0 };
+	int payload_len = variant->data_size;
+	int gso_size = variant->gso_size;
+	struct sockaddr_storage ssa, dsa;
+
+	assign_sockaddr_vars(family, 0, &ssa, &dsa);
+	return send_gso_udp_msg(self->sock, &dsa, buf, payload_len, gso_size);
+}
+
+static int
+receive_gso_packet_from_tun(FIXTURE_DATA(tun_vnet_udptnl) * self,
+			    const FIXTURE_VARIANT(tun_vnet_udptnl) * variant,
+			    struct virtio_net_hdr_v1_hash_tunnel *vnet_hdr)
+{
+	struct timeval timeout = { .tv_sec = TIMEOUT_SEC };
+	uint8_t buf[MAX_VNET_TUNNEL_PACKET_SZ];
+	int tunnel_type = variant->tunnel_type;
+	int payload_len = variant->data_size;
+	bool is_tap = variant->is_tap;
+	int ret, len, total_len = 0;
+	int tun_fd = self->fd;
+	fd_set fdset;
+
+	while (total_len < payload_len) {
+		FD_ZERO(&fdset);
+		FD_SET(tun_fd, &fdset);
+
+		ret = select(tun_fd + 1, &fdset, NULL, NULL, &timeout);
+		if (ret <= 0) {
+			perror("select");
+			break;
+		}
+		if (!FD_ISSET(tun_fd, &fdset))
+			continue;
+
+		len = read(tun_fd, buf, sizeof(buf));
+		if (len <= 0) {
+			if (len < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
+				perror("read");
+			break;
+		}
+
+		len = parse_udp_tunnel_vnet_packet(buf, len, tunnel_type,
+						   is_tap);
+		if (len < 0)
+			continue;
+
+		if (total_len == 0)
+			memcpy(vnet_hdr, buf, TUN_VNET_TNL_SIZE);
+
+		total_len += len;
+	}
+
+	return total_len;
+}
+
 TEST_F(tun_vnet_udptnl, send_gso_packet)
 {
 	uint8_t pkt[MAX_VNET_TUNNEL_PACKET_SZ];
@@ -699,4 +871,26 @@ TEST_F(tun_vnet_udptnl, send_gso_packet)
 	ASSERT_EQ(r_num_mss, variant->r_num_mss);
 }
 
+TEST_F(tun_vnet_udptnl, recv_gso_packet)
+{
+	struct virtio_net_hdr_v1_hash_tunnel vnet_hdr = { 0 };
+	struct virtio_net_hdr_v1 *vh = &vnet_hdr.hash_hdr.hdr;
+	int ret, gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
+
+	ret = send_gso_packet_into_tunnel(self, variant);
+	ASSERT_EQ(ret, variant->data_size);
+
+	memset(&vnet_hdr, 0, sizeof(vnet_hdr));
+	ret = receive_gso_packet_from_tun(self, variant, &vnet_hdr);
+	ASSERT_EQ(ret, variant->data_size);
+
+	if (!variant->no_gso) {
+		ASSERT_EQ(vh->gso_size, variant->gso_size);
+		gso_type |= (variant->tunnel_type & UDP_TUNNEL_OUTER_IPV4) ?
+				    (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4) :
+				    (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6);
+		ASSERT_EQ(vh->gso_type, gso_type);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


