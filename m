Return-Path: <netdev+bounces-251843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPAtHc+scGkgZAAAu9opvQ
	(envelope-from <netdev+bounces-251843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:39:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC15558B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F5288EA533
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAE481255;
	Wed, 21 Jan 2026 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAwHwc6A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A978480DE3
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989929; cv=none; b=OpQdVgRoMzIri29kHMrcAdTn5uVjX0+PBiddZAboqt4WXmYhzT6nI6ehUxvmWfV3PiX9jkrXAb7dkXm86yZRCu5IiA8XH1HXh2YF3xlKLggx5FBLqWBh1Thbo8QSplaG4Q8MYrzck6x48C9E6vZwM/rIfAGvk+pM2PJ15OC2l6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989929; c=relaxed/simple;
	bh=seso6tf1ONV+Ax4YQJC8aQCMZ8aZXo9EzYwtY/MTptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6rmlX5rkXul5Wx+UEDRAM2hHP48yGvrgykj4iCP3sJKJReFdmyy28cmR3CBDaSi9aoXYgbuVdjlKR+ueAP1XCesiH1nQagniEmQJPqA34yMwNiHP2h2+vQisAK1aZG6kSV9GAq9GUunq/yNUvF/w++14zBWBDmOThcjyzNlmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAwHwc6A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768989926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIiQlCMAW8KdbZAYWGkWj8UtKVMT9BMIpR+WWMwo/Mc=;
	b=fAwHwc6ACuiiT8akBjHJg/7gHXPzfIIig8UFndbENmzRyN/NbgzzVvNm3cbGM+2OCNf/Hf
	2SdhkSlji7f3f9LHaguuDrd2w0BTblzwMqL9XXQV/5d7LYaGYtJWaovaK6howWDC0jH9Xt
	V7snAZqVGdlWrCNbQPqC23PZLvRA7Gs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-r5IFCHHeNl280JOhxL_Q_Q-1; Wed,
 21 Jan 2026 05:05:23 -0500
X-MC-Unique: r5IFCHHeNl280JOhxL_Q_Q-1
X-Mimecast-MFC-AGG-ID: r5IFCHHeNl280JOhxL_Q_Q_1768989921
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76FBB19560A6;
	Wed, 21 Jan 2026 10:05:21 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A35C18004D8;
	Wed, 21 Jan 2026 10:05:16 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 2/7] selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
Date: Wed, 21 Jan 2026 18:04:56 +0800
Message-ID: <91f905715c69c75f7bf72d43388921fde6c34989.1768979440.git.xudu@redhat.com>
In-Reply-To: <cover.1768979440.git.xudu@redhat.com>
References: <cover.1768979440.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251843-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 05AC15558B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce rtnetlink manipulation and packet construction helpers that
will simplify the later creation of more related test cases. This avoids
duplicating logic across different test cases.

This new header will contain:
 - YNL-based netlink management utilities.
 - Helpers for ip link, ip address, ip neighbor and ip route operations.
 - Packet construction and manipulation helpers.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v5 -> v6:
 - Rename variables to improve readability.

v4 -> v5:
 - Add YNL-based helpers for rtnetlink operations.

v3 -> v4:
  - Fold the "tap.c buffer overflow detected" fix into the current commit.

v1 -> v2:
  - Add support for route manipulation operations.
  - Add support for querying individual entries.

 tools/testing/selftests/net/tuntap_helpers.h | 390 +++++++++++++++++++
 1 file changed, 390 insertions(+)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h

diff --git a/tools/testing/selftests/net/tuntap_helpers.h b/tools/testing/selftests/net/tuntap_helpers.h
new file mode 100644
index 000000000000..d6c0437136ec
--- /dev/null
+++ b/tools/testing/selftests/net/tuntap_helpers.h
@@ -0,0 +1,390 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TUNTAP_HELPERS_H
+#define _TUNTAP_HELPERS_H
+
+#include <errno.h>
+#include <linux/if_packet.h>
+#include <linux/ipv6.h>
+#include <linux/virtio_net.h>
+#include <netinet/in.h>
+#include <netinet/if_ether.h>
+#include <netinet/udp.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ynl.h>
+
+#include "rt-route-user.h"
+#include "rt-addr-user.h"
+#include "rt-neigh-user.h"
+#include "rt-link-user.h"
+
+#define GENEVE_HLEN 8
+#define PKT_DATA 0xCB
+#define TUNTAP_DEFAULT_TTL 8
+#define TUNTAP_DEFAULT_IPID 1337
+
+unsigned int if_nametoindex(const char *ifname);
+
+static inline int ip_addr_len(int family)
+{
+	return (family == AF_INET) ? sizeof(struct in_addr) :
+				     sizeof(struct in6_addr);
+}
+
+static inline void fill_ifaddr_msg(struct ifaddrmsg *ifam, int family,
+				   int prefix, int flags, const char *dev)
+{
+	ifam->ifa_family = family;
+	ifam->ifa_prefixlen = prefix;
+	ifam->ifa_index = if_nametoindex(dev);
+	ifam->ifa_flags = flags;
+	ifam->ifa_scope = RT_SCOPE_UNIVERSE;
+}
+
+static inline int ip_addr_add(const char *dev, int family, void *addr,
+			      uint8_t prefix)
+{
+	int nl_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	int ifa_flags = IFA_F_PERMANENT | IFA_F_NODAD;
+	int ret = -1, ipalen = ip_addr_len(family);
+	struct rt_addr_newaddr_req *req;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_rt_addr_family, NULL);
+	if (!ys)
+		return -1;
+
+	req = rt_addr_newaddr_req_alloc();
+	if (!req)
+		goto err_req_alloc;
+
+	fill_ifaddr_msg(&req->_hdr, family, prefix, ifa_flags, dev);
+	rt_addr_newaddr_req_set_nlflags(req, nl_flags);
+	rt_addr_newaddr_req_set_local(req, addr, ipalen);
+
+	ret = rt_addr_newaddr(ys, req);
+	rt_addr_newaddr_req_free(req);
+err_req_alloc:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static inline void fill_neigh_req_header(struct ndmsg *ndm, int family,
+					 int state, const char *dev)
+{
+	ndm->ndm_family = family;
+	ndm->ndm_ifindex = if_nametoindex(dev);
+	ndm->ndm_state = state;
+	ndm->ndm_flags = 0;
+	ndm->ndm_type = RTN_UNICAST;
+}
+
+static inline int ip_neigh_add(const char *dev, int family, void *addr,
+			       unsigned char *lladdr)
+{
+	int nl_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	int ret = -1, ipalen = ip_addr_len(family);
+	struct rt_neigh_newneigh_req *req;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_rt_neigh_family, NULL);
+	if (!ys)
+		return -1;
+
+	req = rt_neigh_newneigh_req_alloc();
+	if (!req)
+		goto err_req_alloc;
+
+	fill_neigh_req_header(&req->_hdr, family, NUD_PERMANENT, dev);
+	rt_neigh_newneigh_req_set_nlflags(req, nl_flags);
+	rt_neigh_newneigh_req_set_dst(req, addr, ipalen);
+	rt_neigh_newneigh_req_set_lladdr(req, lladdr, ETH_ALEN);
+	rt_neigh_newneigh_req_set_ifindex(req, if_nametoindex(dev));
+
+	ret = rt_neigh_newneigh(ys, req);
+	rt_neigh_newneigh_req_free(req);
+err_req_alloc:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static inline void fill_route_req_header(struct rtmsg *rtm, int family,
+					 int table)
+{
+	rtm->rtm_family = family;
+	rtm->rtm_table = table;
+}
+
+static inline int
+ip_route_get(const char *dev, int family, int table, void *dst,
+	     void (*parse_rsp)(struct rt_route_getroute_rsp *rsp, void *out),
+	     void *out)
+{
+	int ret = -1, ipalen = ip_addr_len(family);
+	struct rt_route_getroute_req *req;
+	struct rt_route_getroute_rsp *rsp;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_rt_route_family, NULL);
+	if (!ys)
+		return -1;
+
+	req = rt_route_getroute_req_alloc();
+	if (!req)
+		goto err_req_alloc;
+
+	fill_route_req_header(&req->_hdr, family, table);
+	rt_route_getroute_req_set_nlflags(req, NLM_F_REQUEST);
+	rt_route_getroute_req_set_dst(req, dst, ipalen);
+	rt_route_getroute_req_set_oif(req, if_nametoindex(dev));
+
+	rsp = rt_route_getroute(ys, req);
+	if (!rsp)
+		goto err_rsp_get;
+
+	ret = 0;
+	if (parse_rsp)
+		parse_rsp(rsp, out);
+
+	rt_route_getroute_rsp_free(rsp);
+err_rsp_get:
+	rt_route_getroute_req_free(req);
+err_req_alloc:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static inline int
+ip_link_add(const char *dev, char *link_type,
+	    int (*fill_link_attr)(struct rt_link_newlink_req *req, void *data),
+	    void *data)
+{
+	int nl_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	struct rt_link_newlink_req *req;
+	struct ynl_sock *ys;
+	int ret = -1;
+
+	ys = ynl_sock_create(&ynl_rt_link_family, NULL);
+	if (!ys)
+		return -1;
+
+	req = rt_link_newlink_req_alloc();
+	if (!req)
+		goto err_req_alloc;
+
+	req->_hdr.ifi_flags = IFF_UP;
+	rt_link_newlink_req_set_nlflags(req, nl_flags);
+	rt_link_newlink_req_set_ifname(req, dev);
+	rt_link_newlink_req_set_linkinfo_kind(req, link_type);
+
+	if (fill_link_attr && fill_link_attr(req, data) < 0)
+		goto err_attr_fill;
+
+	ret = rt_link_newlink(ys, req);
+err_attr_fill:
+	rt_link_newlink_req_free(req);
+err_req_alloc:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static inline int ip_link_del(const char *dev)
+{
+	struct rt_link_dellink_req *req;
+	struct ynl_sock *ys;
+	int ret = -1;
+
+	ys = ynl_sock_create(&ynl_rt_link_family, NULL);
+	if (!ys)
+		return -1;
+
+	req = rt_link_dellink_req_alloc();
+	if (!req)
+		goto err_req_alloc;
+
+	rt_link_dellink_req_set_nlflags(req, NLM_F_REQUEST);
+	rt_link_dellink_req_set_ifname(req, dev);
+
+	ret = rt_link_dellink(ys, req);
+	rt_link_dellink_req_free(req);
+err_req_alloc:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static inline size_t build_eth(uint8_t *buf, uint16_t proto, unsigned char *src,
+			       unsigned char *dest)
+{
+	struct ethhdr *eth = (struct ethhdr *)buf;
+
+	eth->h_proto = htons(proto);
+	memcpy(eth->h_source, src, ETH_ALEN);
+	memcpy(eth->h_dest, dest, ETH_ALEN);
+
+	return ETH_HLEN;
+}
+
+static inline uint32_t add_csum(const uint8_t *buf, int len)
+{
+	uint16_t *sbuf = (uint16_t *)buf;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += *sbuf++;
+		len -= 2;
+	}
+
+	if (len)
+		sum += *(uint8_t *)sbuf;
+
+	return sum;
+}
+
+static inline uint16_t finish_ip_csum(uint32_t sum)
+{
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+	return ~((uint16_t)sum);
+}
+
+static inline uint16_t build_ip_csum(const uint8_t *buf, int len, uint32_t sum)
+{
+	sum += add_csum(buf, len);
+	return finish_ip_csum(sum);
+}
+
+static inline int build_ipv4_header(uint8_t *buf, uint8_t proto,
+				    int payload_len, struct in_addr *src,
+				    struct in_addr *dst)
+{
+	struct iphdr *iph = (struct iphdr *)buf;
+
+	iph->ihl = 5;
+	iph->version = 4;
+	iph->ttl = TUNTAP_DEFAULT_TTL;
+	iph->tot_len = htons(sizeof(*iph) + payload_len);
+	iph->id = htons(TUNTAP_DEFAULT_IPID);
+	iph->protocol = proto;
+	iph->saddr = src->s_addr;
+	iph->daddr = dst->s_addr;
+	iph->check = build_ip_csum(buf, iph->ihl << 2, 0);
+
+	return iph->ihl << 2;
+}
+
+static inline void ipv6_set_dsfield(struct ipv6hdr *ip6h, uint8_t dsfield)
+{
+	uint16_t val, *ptr = (uint16_t *)ip6h;
+
+	val = ntohs(*ptr);
+	val &= 0xF00F;
+	val |= ((uint16_t)dsfield) << 4;
+	*ptr = htons(val);
+}
+
+static inline int build_ipv6_header(uint8_t *buf, uint8_t proto,
+				    uint8_t dsfield, int payload_len,
+				    struct in6_addr *src, struct in6_addr *dst)
+{
+	struct ipv6hdr *ip6h = (struct ipv6hdr *)buf;
+
+	ip6h->version = 6;
+	ip6h->payload_len = htons(payload_len);
+	ip6h->nexthdr = proto;
+	ip6h->hop_limit = TUNTAP_DEFAULT_TTL;
+	ipv6_set_dsfield(ip6h, dsfield);
+	memcpy(&ip6h->saddr, src, sizeof(ip6h->saddr));
+	memcpy(&ip6h->daddr, dst, sizeof(ip6h->daddr));
+
+	return sizeof(struct ipv6hdr);
+}
+
+static inline int build_geneve_header(uint8_t *buf, uint32_t vni)
+{
+	uint16_t protocol = htons(ETH_P_TEB);
+	uint32_t geneve_vni = htonl((vni << 8) & 0xffffff00);
+
+	memcpy(buf + 2, &protocol, 2);
+	memcpy(buf + 4, &geneve_vni, 4);
+	return GENEVE_HLEN;
+}
+
+static inline int build_udp_header(uint8_t *buf, uint16_t sport, uint16_t dport,
+				   int payload_len)
+{
+	struct udphdr *udph = (struct udphdr *)buf;
+
+	udph->source = htons(sport);
+	udph->dest = htons(dport);
+	udph->len = htons(sizeof(*udph) + payload_len);
+	return sizeof(*udph);
+}
+
+static inline void build_udp_packet_csum(uint8_t *buf, int family,
+					 bool csum_off)
+{
+	struct udphdr *udph = (struct udphdr *)buf;
+	size_t ipalen = ip_addr_len(family);
+	uint32_t sum;
+
+	/* No extension IPv4 and IPv6 headers addresses are the last fields */
+	sum = add_csum(buf - 2 * ipalen, 2 * ipalen);
+	sum += htons(IPPROTO_UDP) + udph->len;
+
+	if (!csum_off)
+		sum += add_csum(buf, udph->len);
+
+	udph->check = finish_ip_csum(sum);
+}
+
+static inline int build_udp_packet(uint8_t *buf, uint16_t sport, uint16_t dport,
+				   int payload_len, int family, bool csum_off)
+{
+	struct udphdr *udph = (struct udphdr *)buf;
+
+	build_udp_header(buf, sport, dport, payload_len);
+	memset(buf + sizeof(*udph), PKT_DATA, payload_len);
+	build_udp_packet_csum(buf, family, csum_off);
+
+	return sizeof(*udph) + payload_len;
+}
+
+static inline int build_virtio_net_hdr_v1_hash_tunnel(uint8_t *buf, bool is_tap,
+						      int hdr_len, int gso_size,
+						      int outer_family,
+						      int inner_family)
+{
+	struct virtio_net_hdr_v1_hash_tunnel *vh_tunnel = (void *)buf;
+	struct virtio_net_hdr_v1 *vh = &vh_tunnel->hash_hdr.hdr;
+	int outer_iphlen, inner_iphlen, eth_hlen, gso_type;
+
+	eth_hlen = is_tap ? ETH_HLEN : 0;
+	outer_iphlen = (outer_family == AF_INET) ? sizeof(struct iphdr) :
+						   sizeof(struct ipv6hdr);
+	inner_iphlen = (inner_family == AF_INET) ? sizeof(struct iphdr) :
+						   sizeof(struct ipv6hdr);
+
+	vh_tunnel->outer_th_offset = eth_hlen + outer_iphlen;
+	vh_tunnel->inner_nh_offset = vh_tunnel->outer_th_offset + ETH_HLEN +
+				     GENEVE_HLEN + sizeof(struct udphdr);
+
+	vh->csum_start = vh_tunnel->inner_nh_offset + inner_iphlen;
+	vh->csum_offset = __builtin_offsetof(struct udphdr, check);
+	vh->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+	vh->hdr_len = hdr_len;
+	vh->gso_size = gso_size;
+
+	if (gso_size) {
+		gso_type = outer_family == AF_INET ?
+				   VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 :
+				   VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
+		vh->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4 | gso_type;
+	}
+
+	return sizeof(struct virtio_net_hdr_v1_hash_tunnel);
+}
+
+#endif /* _TUNTAP_HELPERS_H */
-- 
2.52.0


