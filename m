Return-Path: <netdev+bounces-255776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOrMNplegGlj7AIAu9opvQ
	(envelope-from <netdev+bounces-255776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:21:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D86C9A46
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C20B630099B5
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528234F27D;
	Mon,  2 Feb 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RkKpUwWl"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F334EEEF
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020500; cv=none; b=NIfWbq8kWhisersRlnq+NB9oC8vFusv7AaBC+BBzqb5xl/1DZhOwz2Cxrj+5t8L2YuGmV9NgRT1IfzpSnBvvXBBb9Z5wl5oF1onypqkmkTghwOfDjHYQipaEGopmaifj0owsAXxJfWAyaidV0ipOH5HB3u91UJqzKy33bc7YCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020500; c=relaxed/simple;
	bh=Ytude5VpmmT8Tjs3NwchwRr4Ow8u5knol16zZLcVPiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H1iPxUBwwUfRBL0OA9m4RSwCyz1Ewev0L5LZJ8ihSGeM0a8mPAT4BHtTd1zfUofZlYuqb0XzryMZd0ri98/O5uRtAALBOZCrpMvmUD33uUM/TEQnc1A/kIWezodpBMP2mBehXIHKb6K4kcgPbGWrxGCW21U6UyKvK7bx/c604/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RkKpUwWl; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yNXaZKiEdspsdE6G10/eZji6b8ctVhXyA2sgP8bbjec=;
	b=RkKpUwWl8Q+psXErxx5AeEpKUQIpRCzLRVjUlEvP30FvTlKIyOoWwMIXwCO8thkkA9SrV/Wsv
	WY0h/647vwIsZPKUowFbHSA/lqwZ0GIEQq6HNVhkIBBaGkw1xOmVPYBd1cUgtBF9tt5AckFHCKK
	5rIZ+I/BMHNOnrh2HJqNrxg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f4KGp3VX8zpStQ;
	Mon,  2 Feb 2026 16:17:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F2A740570;
	Mon,  2 Feb 2026 16:21:29 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 16:21:29 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 16:21:28 +0800
Message-ID: <c63047b5-3059-4176-8d9d-5465d557e605@huawei.com>
Date: Mon, 2 Feb 2026 16:21:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<fengwei_yin@linux.alibaba.com>, <zhangchangzhong@huawei.com>
References: <20260131212934.2547995-1-edumazet@google.com>
 <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
 <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-255776-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,alibaba.com:email,prot_hook.dev:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86D86C9A46
X-Rspamd-Action: no action


> On Mon, Feb 2, 2026 at 4:16 AM YinFengwei <fengwei_yin@linux.alibaba.com> wrote:
>> + Chenchen as he hit the exact same issue.
>>
>> Hi Eric,
>>
>>> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a patch.
>>>
>>> Real issue is that (struct packet_type)->dev needs RCU protection:
>>>
>>> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
>>> to get device name without any barrier.
>>>
>>> At the same time, concurrent writer can remove a packet_type structure
>>> (which is correctly freed after an RCU grace period) _and_ clear pt->dev
>>> without an RCU grace period.
>>>
>>> Fix this issue by using proper RCU on pt->dev pointer.
>> Still can hit this issue with same backtrace even with this fixing patch.
>>
>> Look at the __dev_remove_pack(), the pt->list is protected by ptype_lock
>> while prot_hook.dev is protected by bind_lock. Could it make sure the
>> procfs interface see either the list element with prot_hook.dev not NULL
>> or can't see the list element with NULL prot_hook.dev?
>>
>> Regards
>> Yin, Fengwei
> Please share the new stack trace (with the symbols), or the repro, thanks !

Hi, Eric.
I encountered a similar issue.
https://lore.kernel.org/all/20260128112348.3950437-1-dongchenchen2@huawei.com/
we can reproduce it using the following method[1][2][3].

I think the reason why using only rcu to protect dev cannot fix this problem
is that pt->head.nxt is not protected by rcu.

list_del_rcu
__list_del
     next->prev = prev;
     WRITE_ONCE(prev->next, next);

While traversing the ptype sequence, once the nxt pointer is obtained,
pt can be concurrently deleted or modified. When pt->dev does not correspond
to the list that pt is currently in, the list head detection will no longer
work correctly.

CPU1				CPU2
ptype_seq_next
     nxt = pt->list.next;
     //nxt = ptype_head(pt) = dev->ptype_all
				packet_release/packet_notifier
				    unregister_prot_hook(sk, false);
				    //no sync wait, pt->list.next not change
				    rcu_assign_pointer(po->prot_hook.dev, NULL);
     dev = rcu_dereference(pt->dev);
     if (pt->dev) //check fail
         if (nxt != &pt->dev->ptype_all)
             goto found;
     if (nxt != &ptype_all) //check success
         goto found;
found:
     return list_entry(nxt, struct packet_type, list);
     //return list head to seq traversal

-----
Best Regards,
Dong Chenchen

[1] gcc packet_type.c -o packet_type_test
#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <linux/if_packet.h>
#include <linux/sockios.h>
#include <linux/if_ether.h>
#include <linux/if_arp.h>
#include <linux/if_tun.h>
#include <fcntl.h>
#include <sys/uio.h>
#include <sched.h>

#define TUN_NAME "tun0"

int tun_create(char *dev_name, int flags) {
     struct ifreq ifr;
     int fd, err;
     
     if ((fd = open("/dev/net/tun", O_RDWR)) < 0) {
         perror("open /dev/net/tun");
         return -1;
     }
     memset(&ifr, 0, sizeof(ifr));
     ifr.ifr_flags = flags;
     
     if (dev_name) {
         strncpy(ifr.ifr_name, dev_name, IFNAMSIZ);
     }
     if ((err = ioctl(fd, TUNSETIFF, (void *)&ifr)) < 0) {
         perror("ioctl TUNSETIFF");
         close(fd);
         return err;
     }
     return fd;
}

void tun_set(const char *dev_name, short flag) {
     int sockfd;
     struct ifreq ifr;
     
     sockfd = socket(AF_INET, SOCK_DGRAM, 0);
     if (sockfd < 0) {
         perror("socket");
         return;
     }
     memset(&ifr, 0, sizeof(ifr));
     strncpy(ifr.ifr_name, dev_name, IFNAMSIZ);
     if (ioctl(sockfd, SIOCGIFFLAGS, &ifr) < 0) {
         perror("ioctl SIOCGIFFLAGS");
         close(sockfd);
         return;
     }
     ifr.ifr_flags |= flag;
     if (ioctl(sockfd, SIOCSIFFLAGS, &ifr) < 0) {
         perror("ioctl SIOCSIFFLAGS");
         close(sockfd);
         return;
     }
     close(sockfd);
}

int main() {
     int tunfd, sockfd;
     struct ifreq ifr;
     struct sockaddr_ll sll;

     unshare(CLONE_NEWNET);
     tunfd = tun_create(TUN_NAME, IFF_TUN | IFF_NO_PI);
     tun_set(TUN_NAME, IFF_UP);
     sockfd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL));
     if (sockfd < 0) {
	close(tunfd);
         perror("socket");
         exit(1);
     }
     
     memset(&ifr, 0, sizeof(ifr));
     strncpy(ifr.ifr_name, TUN_NAME, IFNAMSIZ);
     
     if (ioctl(sockfd, SIOCGIFINDEX, &ifr) < 0) {
         perror("ioctl SIOCGIFINDEX");
	close(sockfd);
         close(tunfd);
         exit(1);
     }

     memset(&sll, 0, sizeof(sll));
     sll.sll_family = AF_PACKET;
     sll.sll_protocol = htons(ETH_P_ALL);
     sll.sll_ifindex = ifr.ifr_ifindex;
     sll.sll_pkttype = PACKET_HOST;
     sll.sll_hatype = ARPHRD_ETHER;
     
     if (bind(sockfd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
         perror("bind");
         close(sockfd);
	close(tunfd);
         exit(1);
     }
     printf("begin sleep\n");
     sleep(1);

     close(sockfd);
     close(tunfd);
     return 0;
}

[2] add delay to pype_seq_next
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 160dd729178f..73f5a20ef57c 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -230,11 +230,14 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
  
         pt = v;
         nxt = pt->list.next;
+       if (pt->dev)
+               mdelay(5000);
         dev = rcu_dereference(pt->dev);

[3] run_test.sh
./packet_type_test &
cat /proc/$(pgrep -x "packet_type_test")/net/ptype &


