Return-Path: <netdev+bounces-121228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897995C3B7
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C61C225D7
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA237144;
	Fri, 23 Aug 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="osoNuswv"
X-Original-To: netdev@vger.kernel.org
Received: from out0-204.mail.aliyun.com (out0-204.mail.aliyun.com [140.205.0.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4B2746F;
	Fri, 23 Aug 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383726; cv=none; b=KNa31r8J3naJYgjcF/4v/hvUQvriT3RbVARXNUYQ7qtGPN7tj6Dm6IWoI30w39cEm/tNehvA36xSLsauVGhfhKgSy4nQA0TytS15eHsdJsuGDfaxTr9mNZDE1HbSgkDXOc+wI14+pj9+88gNa3DlMOpXlGYzBmmZJTK1rEp0anI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383726; c=relaxed/simple;
	bh=7WrGdBwdzwnuMNYMSda0k56nmTqYzQi7eS0ol0uR9R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/E1Z4ArliHKAyEFv024Weya9J4toZfl832ybfphN7aC1kire8Op0retuLOVnb7hHagM0CAxQuWR0Kr2yn6xRcx+2wUE+TrVlAG1OVTrUusIAHGvyTBuCh5hw6QYeq8vG6vc2be2BT8xNRy5ua2dI6o8On/joX2lJsVL5iyReeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=osoNuswv; arc=none smtp.client-ip=140.205.0.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724383711; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XMavuY/FvLStpd2Fd6qT4oRMIwpWJC42qt2AhhfV9GI=;
	b=osoNuswv93d0x+yPvmAxS+lpNKqzSE6QkIXj7+uYT239HtU3VTYWCF9WPac/y0UclMqUkcU4S6B/VSaTzC/864DKtSo/bphm1R3QxBAN1hv6CYHbTSSHgWCqxUHs45JbTUtWOerM0rdNqRJKyRkLxOAhfyFSzGtzrl0BW5alenY=
Received: from 30.177.51.115(mailfrom:amy.saq@antgroup.com fp:SMTPD_---.Z.5FIRJ_1724383710)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 11:28:31 +0800
Message-ID: <579fee5c-fdfb-4305-9f64-231c0d8ebabd@antgroup.com>
Date: Fri, 23 Aug 2024 11:28:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix csum calculation for encapsulated packets
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240819111745.129190-1-amy.saq@antgroup.com>
 <0540a49d-40e2-45a7-a068-fd14b75584f0@redhat.com>
From: "=?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?=" <amy.saq@antgroup.com>
In-Reply-To: <0540a49d-40e2-45a7-a068-fd14b75584f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/22/24 下午6:05, Paolo Abeni 写道:
>
>
> On 8/19/24 13:17, 沈安琪(凛玥) wrote:
>> This commit fixes the issue that when a packet is encapsulated, such as
>> sending through a UDP tunnel, the outer TCP/UDP checksum is not
>> correctly recalculated if (1) checksum has been offloaded to hardware
>> and (2) encapsulated packet has been NAT-ed again, which causes the
>> packet being dropped due to the invalid outer checksum.
>>
>> Previously, when an encapsulated packet met some NAT rules and its
>> src/dst ip and/or src/dst port has been modified,
>> inet_proto_csum_replace4 will be invoked to recalculated the outer
>> checksum. However, if the packet is under the following condition: (1)
>> checksum offloaded to hardware and (2) NAT rule has changed the src/dst
>> port, its outer checksum will not be recalculated, since (1)
>> skb->ip_summed is set to CHECKSUM_PARTIAL due to csum offload and (2)
>> pseudohdr is set to false since port number is not part of pseudo
>> header. 
>
> I don't see where nat is calling inet_proto_csum_replace4() with 
> pseudohdr == false: please include more detailed description of the 
> relevant setup (ideally a self-test) or at least a backtrace leading 
> to the issue.


The relevant setup we found this issue was:

1. we setup a VXLAN tunnel and set a MASQUERADE rule with --random-fully 
enabled on client side (tx side).

2. we enabled. NIC checksum offload.


We used the following bpftrace script to get the call trace:

bpftrace -o trace.log -e '#include <linux/skbuff.h>
#include <linux/net.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/if_ether.h>
#include <linux/types.h>
#include <net/sock.h>
#include <net/route.h>
#include <net/dst.h>
kprobe:inet_proto_csum_replace4
{
     $skb = (struct sk_buff *)arg1;
     $ip_hdr = (struct iphdr *)($skb->head + $skb->network_header);
     $proto = $ip_hdr->protocol;
     if ($proto == 17) {
         $udp_hdr = (struct udphdr *)($skb->head + $skb->transport_header);
         printf("udp check: 0x%04x; \n", $udp_hdr->check);
         printf("skb ip_summed: %d, skb encapsulation: %d, skb 
encap_csum_hdr: %d; \n", $skb->ip_summed, $skb->encapsulation, 
$skb->encap_hdr_csum);
         printf("from: 0x%08x, to: 0x%08x; \n", arg2, arg3);
         printf("pseudohdr: %d; \n", arg4);
         printf("enter kprobe:inet_proto_csum_replace4 : %s\n\n", kstack);
     }
}
'


And get the following call trace:

udp check: [...];
skb ip_summed: 3, skb encapsulation: 1, skb encap_csum_hdr: 0;
from: ...[old src ip], to: ...[NAT-ed src ip];
pseudohdr: 1;
enter kprobe:inet_proto_csum_replace4 :
     inet_proto_csum_replace4+1
     l4proto_manip_pkt+1166
     nf_nat_ipv4_manip_pkt+90
     nf_nat_manip_pkt+141
     nf_nat_ipv4_out+76
     nf_hook_slow+57
     ip_output+225
     iptunnel_xmit+356
     vxlan_xmit_one+3184
     vxlan_xmit+823
     xmit_one.constprop.0+149
     dev_hard_start_xmit+80
     __dev_queue_xmit+962
     ip_finish_output2+417
     ip_send_skb+56
     udp_send_skb+337
     udp_sendmsg+2404
     sock_sendmsg+51
     ____sys_sendmsg+487
     ___sys_sendmsg+117
     __sys_sendmsg+89
     do_syscall_64+45
     entry_SYSCALL_64_after_hwframe+68


udp check: [...];
skb ip_summed: 3, skb encapsulation: 1, skb encap_csum_hdr: 0;
from: ...[old src port], to: ...[new src port];
pseudohdr: 0;
enter kprobe:inet_proto_csum_replace4 :
     inet_proto_csum_replace4+1
     l4proto_manip_pkt+1195
     nf_nat_ipv4_manip_pkt+90
     nf_nat_manip_pkt+141
     nf_nat_ipv4_out+76
     nf_hook_slow+57
     ip_output+225
     iptunnel_xmit+356
     vxlan_xmit_one+3184
     vxlan_xmit+823
     xmit_one.constprop.0+149
     dev_hard_start_xmit+80
     __dev_queue_xmit+962
     ip_finish_output2+417
     ip_send_skb+56
     udp_send_skb+337
     udp_sendmsg+2404
     sock_sendmsg+51
     ____sys_sendmsg+487
     ___sys_sendmsg+117
     __sys_sendmsg+89
     do_syscall_64+45
     entry_SYSCALL_64_after_hwframe+68



We trace the current implementation and found in __udp_manip_pkt

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/netfilter/nf_nat_proto.c#n57
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/include/net/checksum.h#n164

will invoke inet_proto_csum_replace4 with pseudohdr as false.


>
>> This leads to the outer TCP/UDP checksum invalid since it does
>> not change along with the port number change.
>>
>> In this commit, another condition has been added to recalculate outer
>> checksum: if (1) the packet is encapsulated, (2) checksum has been
>> offloaded, (3) the encapsulated packet has been NAT-ed to change port
>> number and (4) outer checksum is needed, the outer checksum for
>> encapsulated packet will be recalculated to make sure it is valid.
>
> Please add a suitable fix tag.


Thanks for notifying this. We will add it in the next version of this patch.


>
>> Signed-off-by: Anqi Shen <amy.saq@antgroup.com>
>> ---
>>   net/core/utils.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/core/utils.c b/net/core/utils.c
>> index c994e95172ac..d9de60e9b347 100644
>> --- a/net/core/utils.c
>> +++ b/net/core/utils.c
>> @@ -435,6 +435,8 @@ void inet_proto_csum_replace4(__sum16 *sum, 
>> struct sk_buff *skb,
>>           *sum = ~csum_fold(csum_add(csum_sub(csum_unfold(*sum),
>>                               (__force __wsum)from),
>>                          (__force __wsum)to));
>> +    else if (skb->encapsulation && !!(*sum))
>> +        csum_replace4(sum, from, to);
>
> This looks incorrect for a csum partial value, and AFAICS the nat 
> caller has already checked for !!(*sum).
>
> Thanks,
>
> Paolo

