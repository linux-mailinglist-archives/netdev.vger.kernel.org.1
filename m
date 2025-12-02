Return-Path: <netdev+bounces-243159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74981C9A254
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4523A5A07
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEBB2FD1CE;
	Tue,  2 Dec 2025 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ5uFJCO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B52FD1BB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654839; cv=none; b=fhjBn4NFCxvwJ77RUxGIOvVTTNnm9ZZabTPwVNj39J6tr4RwCyFYRwXx8XHroKE/FFQCjSpdeoPFqAJrWd/nGB++kE553gC2R8X35Bd5gIkM7Go7uUQSY8fgY/2rptgE41n2D2lmnSet+9Nec2ojqTAfe+fg5Lw9L+l4u9Y48Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654839; c=relaxed/simple;
	bh=5a9ZH5YMOBUuDhw+aGn3U9BERMUQSBW4qeg+XxzFEtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3WrZlOGvfNX3n+Nhi9/WRX1wdYK2YCm31vLVsEgw50esBgYtcTaMgKooDg/eTF1IrznO0Gjr6tvxZ7IuK/1dHCaoap5HNuz11NL7cWLsC6HBOOwsiHUbSBlSu4HTFWmobwtbaOesZq8uDWiHbbn0EFdlyWtvJ+PQqfa7ryKvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZ5uFJCO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764654836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdAsUobZEEgGYlSDY75dzMjPZwhAlsoBv8Z4e/MDIQ4=;
	b=LZ5uFJCO/WQBtLy11X4avd1/Cd0QijWndxo1e84ixUkY4p307/BYpoh6K7j0QQJzDc+Akl
	g0uJgbzvAZKGrAmanzinuZfv154CSvtiMlwqRXgpMm9z8tMpig8nPhHxJl73xq5UvRiM5d
	5G34VQhe52vopdJe7nCD/TsAl1Ua6o0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-xreQ_SwjPPqF7MU1rwOHWg-1; Tue,
 02 Dec 2025 00:53:51 -0500
X-MC-Unique: xreQ_SwjPPqF7MU1rwOHWg-1
X-Mimecast-MFC-AGG-ID: xreQ_SwjPPqF7MU1rwOHWg_1764654830
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB06A18001D1;
	Tue,  2 Dec 2025 05:53:49 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3077230001A4;
	Tue,  2 Dec 2025 05:53:45 +0000 (UTC)
From: Xu Xu <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	Xu Du <xudu@redhat.com>
Subject: [RFC net-next 7/8] selftest: tun: Add test for receiving gso packet from tun
Date: Tue,  2 Dec 2025 13:53:10 +0800
Message-ID: <9ec6f9bf4342642ae0ae7e5db8c58c657eedfae5.1764640939.git.xudu@redhat.com>
In-Reply-To: <cover.1764640939.git.xudu@redhat.com>
References: <cover.1764640939.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Xu Du <xudu@redhat.com>

The test validate that GSO information are correctly exposed
when reading packets from a TUN device.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v1 -> RFC:
- Use previous helper to simplify tunnel packet sending.
- Treat read timeout (EAGAIN) as assertion failure.
- Correct spelling of 'recieve' to 'receive'.

 tools/testing/selftests/net/tun.c | 193 ++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index a1dfe45b9d92..02c26a21b363 100644
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
@@ -682,6 +792,67 @@ receive_gso_packet_from_tunnel(FIXTURE_DATA(tun_vnet_udptnl) * self,
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
+		if (len < 0) {
+			perror("read");
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
@@ -698,4 +869,26 @@ TEST_F(tun_vnet_udptnl, send_gso_packet)
 	ASSERT_EQ(r_num_mss, variant->r_num_mss);
 }
 
+TEST_F(tun_vnet_udptnl, recv_gso_packet)
+{
+	struct virtio_net_hdr_v1_hash_tunnel vnet_hdr = { 0 };
+	struct virtio_net_hdr_v1 *vh = &vnet_hdr.hash_hdr.hdr;
+	int ret, gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
+
+	ret = send_gso_packet_into_tunnel(self, variant);
+	ASSERT_EQ(ret, variant->data_size)
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


