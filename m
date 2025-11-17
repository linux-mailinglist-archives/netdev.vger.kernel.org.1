Return-Path: <netdev+bounces-239027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B18C62829
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1C9335EC98
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 06:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB8314D32;
	Mon, 17 Nov 2025 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDHfw0MF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA09314D04
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360742; cv=none; b=fDutRysE7KVd6UcZ/MpqcK9HLZx4tMis4KchE9d+1Whb3erNSMGwLUbm29ZSk9G3HhVzHkhULEoKlQ/p8FNgts1FYxZ0FMy2eLXDexN4HIIWyjANLyjM0pizx3XhCPOC0zSPO92QLt5uxAQQyKY7WlcT47neMkR3gtI/lqVALIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360742; c=relaxed/simple;
	bh=mNzJoDGFNeGhdNOBU/WQhJFMFkzlH3ERtDSwt7gogPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbbCvZbq00PQ6MbuyqbLs6f1H8iqziq+iwWUtoLsg8PUZ/X+CIGzoIYZCHaVPRzAuJ1fepm2rHC5tkpwekUVjdNeNNhUTK4N7lFKgxYCvkPT4ZsXxNc8+6Jp+eEOEDkjAyUslvpg5bAfb7VPazGK9yNbgGEAq/28Nx0wTFb13Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDHfw0MF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763360739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKrtEXslqbTeJCvMttywprhCnUud58fGhlotLOwLh3c=;
	b=BDHfw0MFEsH+b9zRw4/V53ph5xudTWzW4RknE2SMeiBjfP6eo7i5AZpf1wteUXG/880lXk
	P3gjpjXly1o5V3tnrXu9vL8AxbzOdf5uikywdI7VtNuSqtPlBDepruFQm8AEGxGlsRn+w/
	7tIzs65WZZZxbnM87jvTT9jAubezmTs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-LfNkpUdYPUGVBjRI_fkLXg-1; Mon,
 17 Nov 2025 01:25:35 -0500
X-MC-Unique: LfNkpUdYPUGVBjRI_fkLXg-1
X-Mimecast-MFC-AGG-ID: LfNkpUdYPUGVBjRI_fkLXg_1763360734
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 792BA1800EF6;
	Mon, 17 Nov 2025 06:25:34 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3139195608E;
	Mon, 17 Nov 2025 06:25:30 +0000 (UTC)
From: xu du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 5/8] selftest: tun: Add helpers for GSO over UDP tunnel
Date: Mon, 17 Nov 2025 14:25:01 +0800
Message-ID: <c52450d30c60b20253a4d195dc66f4d4c0a02603.1763345426.git.xudu@redhat.com>
In-Reply-To: <cover.1763345426.git.xudu@redhat.com>
References: <cover.1763345426.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In preparation for testing GSO over UDP tunnels, enhance the test
infrastructure to support a more complex data path involving a TUN
device and a VXLAN tunnel.

This patch introduces a dedicated setup/teardown topology that creates
both a VXLAN tunnel interface and a TUN interface. The TUN device acts
as the VTEP (Virtual Tunnel Endpoint), allowing it to send and receive
virtio-net packets. This setup effectively tests the kernel's data path
for encapsulated traffic.

Additionally, a new data structure is defined to manage test parameters.
This structure is designed to be extensible, allowing different test
data and configurations to be easily added in subsequent patches.

Signed-off-by: xu du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 391 ++++++++++++++++++++++++++++++
 1 file changed, 391 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 2ed439cce423..8f0188ccb9fb 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -15,6 +15,81 @@
 #include "../kselftest_harness.h"
 #include "tuntap_helpers.h"
 
+static const char param_dev_vxlan_name[] = "vxlan1";
+static unsigned char param_hwaddr_outer_dst[] = { 0x00, 0xfe, 0x98,
+						  0x14, 0x22, 0x42 };
+static unsigned char param_hwaddr_outer_src[] = { 0x00, 0xfe, 0x98,
+						  0x94, 0xd2, 0x43 };
+static unsigned char param_hwaddr_inner_dst[] = { 0x00, 0xfe, 0x98,
+						  0x94, 0x22, 0xcc };
+static unsigned char param_hwaddr_inner_src[] = { 0x00, 0xfe, 0x98,
+						  0x94, 0xd2, 0xdd };
+
+static struct in_addr param_ipaddr4_outer_dst = {
+	__constant_htonl(0xac100001),
+};
+
+static struct in_addr param_ipaddr4_outer_src = {
+	__constant_htonl(0xac100002),
+};
+
+static struct in_addr param_ipaddr4_inner_dst = {
+	__constant_htonl(0xac100101),
+};
+
+static struct in_addr param_ipaddr4_inner_src = {
+	__constant_htonl(0xac100102),
+};
+
+static struct in6_addr param_ipaddr6_outer_dst = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
+};
+
+static struct in6_addr param_ipaddr6_outer_src = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
+};
+
+static struct in6_addr param_ipaddr6_inner_dst = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
+};
+
+static struct in6_addr param_ipaddr6_inner_src = {
+	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
+};
+
+#define VN_ID 1
+#define VN_PORT 4789
+#define UDP_SRC_PORT 22
+#define UDP_DST_PORT 48878
+#define IPPREFIX_LEN 24
+#define IP6PREFIX_LEN 64
+#define TIMEOUT_SEC 3
+
+#define UDP_TUNNEL_VXLAN_4IN4 0x01
+#define UDP_TUNNEL_VXLAN_6IN4 0x02
+#define UDP_TUNNEL_VXLAN_4IN6 0x04
+#define UDP_TUNNEL_VXLAN_6IN6 0x08
+
+#define UDP_TUNNEL_OUTER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_6IN4)
+#define UDP_TUNNEL_INNER_IPV4 (UDP_TUNNEL_VXLAN_4IN4 | UDP_TUNNEL_VXLAN_4IN6)
+
+#define TUN_VNET_TNL_SIZE sizeof(struct virtio_net_hdr_v1_hash_tunnel)
+
+union vxlan_addr {
+	struct sockaddr_in sin;
+	struct sockaddr_in6 sin6;
+};
+
+struct vxlan_setup_config {
+	union vxlan_addr local_ip;
+	union vxlan_addr remote_ip;
+	__be32 vni;
+	int remote_ifindex;
+	__be16 dst_port;
+	unsigned char hwaddr[6];
+	uint8_t csum;
+};
+
 static int tun_attach(int fd, char *dev)
 {
 	struct ifreq ifr;
@@ -67,6 +142,177 @@ static int tun_delete(char *dev)
 	return dev_delete(dev);
 }
 
+static size_t sockaddr_len(int family)
+{
+	return (family == AF_INET) ? sizeof(struct sockaddr_in) :
+				     sizeof(struct sockaddr_in6);
+}
+
+static int tun_open(char *dev, const int flags, const int hdrlen,
+		    const int features, const unsigned char *mac_addr)
+{
+	struct ifreq ifr = { 0 };
+	int fd, sk = -1;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		return -1;
+	}
+
+	ifr.ifr_flags = flags;
+	if (ioctl(fd, TUNSETIFF, (void *)&ifr) < 0) {
+		perror("ioctl(TUNSETIFF)");
+		goto err;
+	}
+	strcpy(dev, ifr.ifr_name);
+
+	if (hdrlen > 0) {
+		if (ioctl(fd, TUNSETVNETHDRSZ, &hdrlen) < 0) {
+			perror("ioctl(TUNSETVNETHDRSZ)");
+			goto err;
+		}
+	}
+
+	if (features) {
+		if (ioctl(fd, TUNSETOFFLOAD, features) < 0) {
+			perror("ioctl(TUNSETOFFLOAD)");
+			goto err;
+		}
+	}
+
+	sk = socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0) {
+		perror("socket");
+		goto err;
+	}
+
+	if (ioctl(sk, SIOCGIFFLAGS, &ifr) < 0) {
+		perror("ioctl(SIOCGIFFLAGS)");
+		goto err;
+	}
+
+	ifr.ifr_flags |= (IFF_UP | IFF_RUNNING);
+	if (ioctl(sk, SIOCSIFFLAGS, &ifr) < 0) {
+		perror("ioctl(SIOCSIFFLAGS)");
+		goto err;
+	}
+
+	if (mac_addr && flags & IFF_TAP) {
+		ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+		memcpy(ifr.ifr_hwaddr.sa_data, mac_addr, ETH_ALEN);
+
+		if (ioctl(sk, SIOCSIFHWADDR, &ifr) < 0) {
+			perror("ioctl(SIOCSIFHWADDR)");
+			goto err;
+		}
+	}
+
+out:
+	if (sk >= 0)
+		close(sk);
+	return fd;
+
+err:
+	close(fd);
+	fd = -1;
+	goto out;
+}
+
+static int vxlan_fill_rtattr(struct nlmsghdr *nh, void *data)
+{
+	struct vxlan_setup_config *vxlan = data;
+
+	rtattr_add_any(nh, IFLA_ADDRESS, vxlan->hwaddr, ETH_ALEN);
+	return 0;
+}
+
+static int vxlan_fill_info_data(struct nlmsghdr *nh, void *data)
+{
+	struct vxlan_setup_config *vxlan = data;
+
+	rtattr_add_any(nh, IFLA_VXLAN_LINK, &vxlan->remote_ifindex,
+		       sizeof(vxlan->remote_ifindex));
+	rtattr_add_any(nh, IFLA_VXLAN_ID, &vxlan->vni, sizeof(vxlan->vni));
+	rtattr_add_any(nh, IFLA_VXLAN_PORT, &vxlan->dst_port,
+		       sizeof(vxlan->dst_port));
+	rtattr_add_any(nh, IFLA_VXLAN_UDP_CSUM, &vxlan->csum,
+		       sizeof(vxlan->csum));
+
+	if (vxlan->remote_ip.sin.sin_family == AF_INET) {
+		rtattr_add_any(nh, IFLA_VXLAN_GROUP,
+			       &vxlan->remote_ip.sin.sin_addr,
+			       sizeof(struct in_addr));
+		rtattr_add_any(nh, IFLA_VXLAN_LOCAL,
+			       &vxlan->local_ip.sin.sin_addr,
+			       sizeof(struct in_addr));
+	} else {
+		rtattr_add_any(nh, IFLA_VXLAN_GROUP6,
+			       &vxlan->remote_ip.sin6.sin6_addr,
+			       sizeof(struct in6_addr));
+		rtattr_add_any(nh, IFLA_VXLAN_LOCAL6,
+			       &vxlan->local_ip.sin6.sin6_addr,
+			       sizeof(struct in6_addr));
+	}
+
+	return 0;
+}
+
+static int set_pmtu_discover(int fd, bool is_ipv4)
+{
+	int level, name, val;
+
+	if (is_ipv4) {
+		level = SOL_IP;
+		name = IP_MTU_DISCOVER;
+		val = IP_PMTUDISC_DO;
+	} else {
+		level = SOL_IPV6;
+		name = IPV6_MTU_DISCOVER;
+		val = IPV6_PMTUDISC_DO;
+	}
+
+	return setsockopt(fd, level, name, &val, sizeof(val));
+}
+
+static int udp_socket_open(struct sockaddr_storage *sockaddr, bool can_frag)
+{
+	struct timeval timeout = { .tv_sec = TIMEOUT_SEC };
+	int family = sockaddr->ss_family;
+	int sockfd, alen;
+
+	sockfd = socket(family, SOCK_DGRAM, 0);
+	if (sockfd < 0) {
+		perror("socket");
+		return -1;
+	}
+
+	alen = sockaddr_len(family);
+	if (bind(sockfd, (struct sockaddr *)sockaddr, alen) < 0) {
+		perror("bind");
+		goto err;
+	}
+
+	if (setsockopt(sockfd, SOL_SOCKET, SO_RCVTIMEO, &timeout,
+		       sizeof(timeout)) < 0) {
+		perror("setsockopt(SO_RCVTIMEO)");
+		goto err;
+	}
+
+	if (!can_frag) {
+		if (set_pmtu_discover(sockfd, family == AF_INET) < 0) {
+			perror("set_pmtu_discover");
+			goto err;
+		}
+	}
+
+	return sockfd;
+
+err:
+	close(sockfd);
+	return -1;
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -129,4 +375,149 @@ TEST_F(tun, reattach_close_delete)
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_vnet_udptnl)
+{
+	char ifname[IFNAMSIZ];
+	int fd, sock;
+};
+
+FIXTURE_VARIANT(tun_vnet_udptnl)
+{
+	int tunnel_type;
+	bool is_tap;
+};
+
+/* clang-format off */
+#define TUN_VNET_UDPTNL_VARIANT_ADD(type, desc)                              \
+	FIXTURE_VARIANT_ADD(tun_vnet_udptnl, desc##udptnl) {                 \
+		.tunnel_type = type,                                         \
+		.is_tap = true,                                              \
+	}
+/* clang-format on */
+
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN4, 4in4);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_6IN4, 6in4);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_4IN6, 4in6);
+TUN_VNET_UDPTNL_VARIANT_ADD(UDP_TUNNEL_VXLAN_6IN6, 6in6);
+
+FIXTURE_SETUP(tun_vnet_udptnl)
+{
+	const int flags = (variant->is_tap ? IFF_TAP : IFF_TUN) | IFF_VNET_HDR |
+			  IFF_MULTI_QUEUE | IFF_NO_PI;
+	const int features = TUN_F_CSUM | TUN_F_UDP_TUNNEL_GSO |
+			     TUN_F_UDP_TUNNEL_GSO_CSUM | TUN_F_USO4 |
+			     TUN_F_USO6;
+	const int hdrlen = TUN_VNET_TNL_SIZE;
+	int tunnel_type = variant->tunnel_type;
+	struct sockaddr_storage sockaddr;
+	struct vxlan_setup_config vxlan;
+	int ret, family;
+
+	self->fd = tun_open(self->ifname, flags, hdrlen, features,
+			    param_hwaddr_outer_src);
+	ASSERT_GE(self->fd, 0);
+
+	family = (tunnel_type & UDP_TUNNEL_OUTER_IPV4) ? AF_INET : AF_INET6;
+	if (family == AF_INET) {
+		ret = ip_addr_add(self->ifname, AF_INET,
+				  (void *)&param_ipaddr4_outer_src,
+				  IPPREFIX_LEN);
+		ret += ip_neigh_add(self->ifname, AF_INET,
+				    (void *)&param_ipaddr4_outer_dst,
+				    param_hwaddr_outer_dst);
+	} else {
+		ret = ip_addr_add(self->ifname, AF_INET6,
+				  (void *)&param_ipaddr6_outer_src,
+				  IP6PREFIX_LEN);
+		ret += ip_neigh_add(self->ifname, AF_INET6,
+				    (void *)&param_ipaddr6_outer_dst,
+				    param_hwaddr_outer_dst);
+	}
+	ASSERT_EQ(ret, 0);
+
+	memset(&vxlan, 0, sizeof(vxlan));
+	vxlan.vni = VN_ID;
+	vxlan.dst_port = htons(VN_PORT);
+	vxlan.csum = 1;
+	vxlan.remote_ifindex = if_nametoindex(self->ifname);
+	memcpy(vxlan.hwaddr, param_hwaddr_inner_src, ETH_ALEN);
+
+	if (tunnel_type & UDP_TUNNEL_OUTER_IPV4) {
+		vxlan.remote_ip.sin.sin_family = AF_INET;
+		vxlan.remote_ip.sin.sin_addr = param_ipaddr4_outer_dst;
+		vxlan.local_ip.sin.sin_family = AF_INET;
+		vxlan.local_ip.sin.sin_addr = param_ipaddr4_outer_src;
+	} else {
+		vxlan.remote_ip.sin6.sin6_family = AF_INET6;
+		vxlan.remote_ip.sin6.sin6_addr = param_ipaddr6_outer_dst;
+		vxlan.local_ip.sin6.sin6_family = AF_INET6;
+		vxlan.local_ip.sin6.sin6_addr = param_ipaddr6_outer_src;
+	}
+
+	ret = dev_create(param_dev_vxlan_name, "vxlan", vxlan_fill_rtattr,
+			 vxlan_fill_info_data, (void *)&vxlan);
+	ASSERT_EQ(ret, 0);
+
+	family = (tunnel_type & UDP_TUNNEL_INNER_IPV4) ? AF_INET : AF_INET6;
+	if (family == AF_INET) {
+		ret = ip_addr_add(param_dev_vxlan_name, AF_INET,
+				  (void *)&param_ipaddr4_inner_src,
+				  IPPREFIX_LEN);
+		ret += ip_neigh_add(param_dev_vxlan_name, AF_INET,
+				    (void *)&param_ipaddr4_inner_dst,
+				    param_hwaddr_inner_dst);
+	} else {
+		ret = ip_addr_add(param_dev_vxlan_name, AF_INET6,
+				  (void *)&param_ipaddr6_inner_src,
+				  IP6PREFIX_LEN);
+		ret += ip_neigh_add(param_dev_vxlan_name, AF_INET6,
+				    (void *)&param_ipaddr6_inner_dst,
+				    param_hwaddr_inner_dst);
+	}
+	ASSERT_EQ(ret, 0);
+
+	memset(&sockaddr, 0, sizeof(sockaddr));
+	sockaddr.ss_family = family;
+	if (family == AF_INET) {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *)&sockaddr;
+
+		addr4->sin_addr = param_ipaddr4_inner_src;
+		addr4->sin_port = htons(UDP_SRC_PORT);
+	} else {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&sockaddr;
+
+		addr6->sin6_addr = param_ipaddr6_inner_src;
+		addr6->sin6_port = htons(UDP_SRC_PORT);
+	}
+	self->sock = udp_socket_open(&sockaddr, false);
+	ASSERT_GE(self->sock, 0);
+
+	/* give 1000us delay to ensure the interface address is ready */
+	usleep(1000);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_udptnl)
+{
+	int ret;
+
+	if (self->sock != -1)
+		close(self->sock);
+
+	ret = dev_delete(param_dev_vxlan_name);
+	EXPECT_EQ(ret, 0);
+
+	ret = tun_delete(self->ifname);
+	EXPECT_EQ(ret, 0);
+}
+
+TEST_F(tun_vnet_udptnl, basic)
+{
+	int ret;
+	char cmd[256] = { 0 };
+
+	sprintf(cmd, "ip addr show %s > /dev/null 2>&1", param_dev_vxlan_name);
+	ret = system(cmd);
+	ASSERT_EQ(ret, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0


