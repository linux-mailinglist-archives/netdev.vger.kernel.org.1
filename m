Return-Path: <netdev+bounces-113611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6696993F475
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AB91C21A5B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C611465BA;
	Mon, 29 Jul 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Tqa9kfjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A113AA26;
	Mon, 29 Jul 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253796; cv=none; b=iTYarpcoGVDTnclynr+dZaDXVKOp3iKNPVL9jyRIP98gkWNdYRDnZfCwlJYyyo7yNJr18dLEsUbIDzDVmyVCwykemKGU83RWN8hYkrErp3XZnfuRAOX5jbFbtWoqgb3QSGXPvPpMvPMXaVUyukHwXJ+qU3OXJut5uXVivrGNotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253796; c=relaxed/simple;
	bh=0bRmeIZm2pIuKjjoxEJEf48Q46OIGeT+uvqjgcV6sp4=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:From:
	 Subject:In-Reply-To; b=NZO4ZHdiMgbbVGjFhak2CXnBzN4ihGnCCx55KU+ZwcePBAB7QhSPUUeOSnjWXn9/OI1S8T0fWAxr3Z/wUsuJ/IGHbX3rRPyuEweRdtX2mrwSUM8btp1hW5QAL3spwoCZDEuGpmtJCD6OFr9xQYHBdF8PkTst7h+x6ToUnpEPWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Tqa9kfjW; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id DA32E7D993;
	Mon, 29 Jul 2024 12:49:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722253787; bh=0bRmeIZm2pIuKjjoxEJEf48Q46OIGeT+uvqjgcV6sp4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<6b40e022-369c-8083-07d4-3036de1d3e65@katalix.com>|
	 Date:=20Mon,=2029=20Jul=202024=2012:49:41=20+0100|MIME-Version:=20
	 1.0|To:=20syzbot=20<syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotm
	 ail.com>|Cc:=20Jakub=20Kicinski=20<kuba@kernel.org>,=20davem@davem
	 loft.net,=0D=0A=20edumazet@google.com,=20linux-kernel@vger.kernel.
	 org,=20netdev@vger.kernel.org,=0D=0A=20pabeni@redhat.com,=20syzkal
	 ler-bugs@googlegroups.com|References:=20<000000000000f9eeec061e0ff
	 a03@google.com>=0D=0A=20<20240726080205.33661f4e@kernel.org>|From:
	 =20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[syzb
	 ot]=20[net?]=20BUG:=20unable=20to=20handle=20kernel=20paging=20req
	 uest=20in=0D=0A=20net_generic|In-Reply-To:=20<20240726080205.33661
	 f4e@kernel.org>;
	b=Tqa9kfjW+e2JOWHr48t8sntgtaStSABfcXKdp0pxdUkZXuy7ufLTUZFOzGEz4D1P8
	 CwWZ6RTYbyIYUomXOZAGy6s/phrQx66fNM5BX6tt9yXVucVpmP/cs7/B2i6Y09FGWc
	 Vyln1QXCOXd4qIwxFOdksxUel1tCAM2ZrR7hM21PSYmYxTCEvzWu3vcUGxaB5VFe+Z
	 NqBcPO6wGly/ozDNgeBNC5nhyIqQ9RoUKsWAr7y/NU637ny7RLkuG+XMg0mBRVMAHc
	 goy8TOvmE+VpPgT0eOPCBChO1eFvsb9ipTNkmfTvXyiSmT7RR2wljTXBbpHZ+zhP4j
	 lw+x7opUHnm6A==
Content-Type: multipart/mixed; boundary="------------a0gFETOsaGx0Vh41juSDYBQx"
Message-ID: <6b40e022-369c-8083-07d4-3036de1d3e65@katalix.com>
Date: Mon, 29 Jul 2024 12:49:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: syzbot <syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <000000000000f9eeec061e0ffa03@google.com>
 <20240726080205.33661f4e@kernel.org>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in
 net_generic
In-Reply-To: <20240726080205.33661f4e@kernel.org>

This is a multi-part message in MIME format.
--------------a0gFETOsaGx0Vh41juSDYBQx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2024 16:02, Jakub Kicinski wrote:
> CC: James [L2TP]
> 
> On Thu, 25 Jul 2024 03:37:24 -0700 syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1625a15e980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6acef9e0a4d1f46c83d4
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/fea69a9d153c/disk-c912bf70.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/be06762a72ef/vmlinux-c912bf70.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/6c8e58b4215d/Image-c912bf70.gz.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com
>>
>> Unable to handle kernel paging request at virtual address dfff800000000257
>> KASAN: probably user-memory-access in range [0x00000000000012b8-0x00000000000012bf]
 >> ...
>> Call trace:
>>  net_generic+0xd0/0x250 include/net/netns/generic.h:46
>>  l2tp_pernet net/l2tp/l2tp_core.c:125 [inline]
>>  l2tp_tunnel_get+0x90/0x464 net/l2tp/l2tp_core.c:207
>>  l2tp_udp_recv_core net/l2tp/l2tp_core.c:852 [inline]
>>  l2tp_udp_encap_recv+0x314/0xb3c net/l2tp/l2tp_core.c:933
>>  udpv6_queue_rcv_one_skb+0x1870/0x1ad4 net/ipv6/udp.c:727
>>  udpv6_queue_rcv_skb+0x3bc/0x574 net/ipv6/udp.c:789
>>  udp6_unicast_rcv_skb+0x1cc/0x320 net/ipv6/udp.c:929
>>  __udp6_lib_rcv+0xbcc/0x1330 net/ipv6/udp.c:1018
>>  udpv6_rcv+0x88/0x9c net/ipv6/udp.c:1133
>>  ip6_protocol_deliver_rcu+0x988/0x12a4 net/ipv6/ip6_input.c:438
>>  ip6_input_finish+0x164/0x298 net/ipv6/ip6_input.c:483
>> ...

This crash is the result of a call to net_generic() being unable to 
dereference net when handling a received l2tpv2 packet.

The stack frame indicates that l2tp_udp_recv_core finds that the 
packet's tunnel_id does not match the tunnel pointer derived from 
sk_user_data of the receiving socket. This can happen when more than one 
socket shares the same 5-tuple address. When a tunnel ID mismatch is 
detected, l2tp looks up the tunnel using the ID from the packet. It is 
this lookup which segfaults in net_generic() when l2tp tries to access 
its per-net tunnel list.

The code implicated by the crash, which added support for aliased 
sockets, is no longer in linux-net or net-next. l2tp no longer looks up 
tunnels in the datapath; instead it looks up sessions without finding 
the parent tunnel first. The commits are:

  * support for aliased sockets was added in 628bc3e5a1be ("l2tp: 
Support several sockets with same IP/port quadruple") May 2024.

  * l2tp's receive path was refactored in ff6a2ac23cb0 ("l2tp: refactor 
udp recv to lookup to not use sk_user_data") June 2024.

Is 628bc3e5a1be in any LTS or stable kernel? I didn't find it in 
linux-stable.git

A possible fix is attached.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 
for-kernelci

--------------a0gFETOsaGx0Vh41juSDYBQx
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-l2tp-fix-tunnel-init-UDP-socket-receive-race.patch"
Content-Disposition: attachment;
 filename="0001-l2tp-fix-tunnel-init-UDP-socket-receive-race.patch"
Content-Transfer-Encoding: base64

RnJvbSAzNjJiNjcyNTc3OGJkM2ViN2E3M2UzNmE3NWU5MmUyYjA5ZWM3NTQxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBDaGFwbWFuIDxqY2hhcG1hbkBrYXRhbGl4
LmNvbT4KRGF0ZTogTW9uLCAyOSBKdWwgMjAyNCAwOTo0OTowNyArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIGwydHA6IGZpeCB0dW5uZWwgaW5pdCAvIFVEUCBzb2NrZXQgcmVjZWl2ZSByYWNl
CgpzeXpib3QgZXhwb3NlcyBhIHJhY2UgZHVyaW5nIHR1bm5lbCBpbml0IHdoZW4gdGhlIHR1
bm5lbCdzIFVEUCBzb2NrZXQKaXMgbWFkZSByZWFkeSB0byByZWNlaXZlIHRyYWZmaWMgYmVm
b3JlIHRoZSB0dW5uZWwncyBsMnRwX25ldCBwb2ludGVyCmlzIHNldC4gVGhpcyBjYW4gcmVz
dWx0IGluIGEgc2VnZmF1bHQgaW4gbmV0X2dlbmVyaWMoKSB3aGVuCmwydHBfdHVubmVsX2dl
dCB0cmllcyB0byBhY2Nlc3MgaXRzIHBlci1uZXQgbGlzdC4KCiAgVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIGRmZmY4MDAwMDAw
MDAyNTcKICBLQVNBTjogcHJvYmFibHkgdXNlci1tZW1vcnktYWNjZXNzIGluIHJhbmdlIFsw
eDAwMDAwMDAwMDAwMDEyYjgtMHgwMDAwMDAwMDAwMDAxMmJmXQogIE1lbSBhYm9ydCBpbmZv
OgogICAgRVNSID0gMHgwMDAwMDAwMDk2MDAwMDA1CiAgICBFQyA9IDB4MjU6IERBQlQgKGN1
cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMKICAgIFNFVCA9IDAsIEZuViA9IDAKICAgIEVBID0g
MCwgUzFQVFcgPSAwCiAgICBGU0MgPSAweDA1OiBsZXZlbCAxIHRyYW5zbGF0aW9uIGZhdWx0
CiAgRGF0YSBhYm9ydCBpbmZvOgogICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNSwgSVNT
MiA9IDB4MDAwMDAwMDAKICAgIENNID0gMCwgV25SID0gMCwgVG5EID0gMCwgVGFnQWNjZXNz
ID0gMAogICAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5Qml0ID0gMCwgWHMgPSAwCiAg
W2RmZmY4MDAwMDAwMDAyNTddIGFkZHJlc3MgYmV0d2VlbiB1c2VyIGFuZCBrZXJuZWwgYWRk
cmVzcyByYW5nZXMKICBJbnRlcm5hbCBlcnJvcjogT29wczogMDAwMDAwMDA5NjAwMDAwNSBb
IzFdIFBSRUVNUFQgU01QCiAgTW9kdWxlcyBsaW5rZWQgaW46CiAgQ1BVOiAxIFBJRDogNjk2
OSBDb21tOiBzeXouMi4xMDUgTm90IHRhaW50ZWQgNi4xMC4wLXJjNy1zeXprYWxsZXItZ2M5
MTJiZjcwOTA3OCAjMAogIEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0ZSBF
bmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2dsZSAwNi8wNy8yMDI0CiAg
cHN0YXRlOiA4MDQwMDAwNSAoTnpjdiBkYWlmICtQQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMg
QlRZUEU9LS0pCiAgcGMgOiBuZXRfZ2VuZXJpYysweGQwLzB4MjUwIGluY2x1ZGUvbmV0L25l
dG5zL2dlbmVyaWMuaDo0NgogIGxyIDogcmN1X3JlYWRfbG9jayBpbmNsdWRlL2xpbnV4L3Jj
dXBkYXRlLmg6NzgyIFtpbmxpbmVdCiAgbHIgOiBuZXRfZ2VuZXJpYysweDU0LzB4MjUwIGlu
Y2x1ZGUvbmV0L25ldG5zL2dlbmVyaWMuaDo0NQogIHNwIDogZmZmZjgwMDBhNmM4NmMxMAog
IHgyOTogZmZmZjgwMDBhNmM4NmMxMCB4Mjg6IGRmZmY4MDAwMDAwMDAwMDAgeDI3OiAwMDAw
MDAwMDAwMDAwODAyCiAgeDI2OiAwMDAwMDAwMDAwMDAwMDAyIHgyNTogMWZmZmYwMDAxNGQ5
MGQ4OCB4MjQ6IGRmZmY4MDAwMDAwMDAwMDAKICB4MjM6IGZmZmYwMDAwY2EzZmJkNzAgeDIy
OiBmZmZmODAwMGE2Yzg2YzQwIHgyMTogZGZmZjgwMDAwMDAwMDAwMAogIHgyMDogMDAwMDAw
MDAwMDAwMTJiOCB4MTk6IDAwMDAwMDAwMDAwMDAwNGUgeDE4OiAxZmZmZjAwMDE0ZDkwY2Zl
CiAgeDE3OiAwMDAwMDAwMDAwMDMwOTlhIHgxNjogZmZmZjgwMDA4MDU0YmRlOCB4MTU6IDAw
MDAwMDAwMDAwMDAwMDEKICB4MTQ6IGZmZmY4MDAwOGYxMDA1NjggeDEzOiBkZmZmODAwMDAw
MDAwMDAwIHgxMjogMDAwMDAwMDBhZjg2MjhjZAogIHgxMTogMDAwMDAwMDA2OGEwZTIyZCB4
MTA6IDAwMDAwMDAwMDBmZjAxMDAgeDkgOiAwMDAwMDAwMDAwMDAwMDAwCiAgeDggOiAwMDAw
MDAwMDAwMDAwMjU3IHg3IDogZmZmZjgwMDA4YTQzMjZhOCB4NiA6IDAwMDAwMDAwMDAwMDAw
MDAKICB4NSA6IDAwMDAwMDAwMDAwMDAwMDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDog
MDAwMDAwMDAwMDAwMDAwMgogIHgyIDogMDAwMDAwMDAwMDAwMDAwOCB4MSA6IGZmZmY4MDAw
OGI2ODFmMjAgeDAgOiAwMDAwMDAwMDAwMDAwMDAxCiAgQ2FsbCB0cmFjZToKICAgbmV0X2dl
bmVyaWMrMHhkMC8weDI1MCBpbmNsdWRlL25ldC9uZXRucy9nZW5lcmljLmg6NDYKICAgbDJ0
cF9wZXJuZXQgbmV0L2wydHAvbDJ0cF9jb3JlLmM6MTI1IFtpbmxpbmVdCiAgIGwydHBfdHVu
bmVsX2dldCsweDkwLzB4NDY0IG5ldC9sMnRwL2wydHBfY29yZS5jOjIwNwogICBsMnRwX3Vk
cF9yZWN2X2NvcmUgbmV0L2wydHAvbDJ0cF9jb3JlLmM6ODUyIFtpbmxpbmVdCiAgIGwydHBf
dWRwX2VuY2FwX3JlY3YrMHgzMTQvMHhiM2MgbmV0L2wydHAvbDJ0cF9jb3JlLmM6OTMzCiAg
IHVkcHY2X3F1ZXVlX3Jjdl9vbmVfc2tiKzB4MTg3MC8weDFhZDQgbmV0L2lwdjYvdWRwLmM6
NzI3CiAgIHVkcHY2X3F1ZXVlX3Jjdl9za2IrMHgzYmMvMHg1NzQgbmV0L2lwdjYvdWRwLmM6
Nzg5CiAgIHVkcDZfdW5pY2FzdF9yY3Zfc2tiKzB4MWNjLzB4MzIwIG5ldC9pcHY2L3VkcC5j
OjkyOQogICBfX3VkcDZfbGliX3JjdisweGJjYy8weDEzMzAgbmV0L2lwdjYvdWRwLmM6MTAx
OAogICB1ZHB2Nl9yY3YrMHg4OC8weDljIG5ldC9pcHY2L3VkcC5jOjExMzMKICAgaXA2X3By
b3RvY29sX2RlbGl2ZXJfcmN1KzB4OTg4LzB4MTJhNCBuZXQvaXB2Ni9pcDZfaW5wdXQuYzo0
MzgKICAgaXA2X2lucHV0X2ZpbmlzaCsweDE2NC8weDI5OCBuZXQvaXB2Ni9pcDZfaW5wdXQu
Yzo0ODMKICAgTkZfSE9PSysweDMyOC8weDNkNCBpbmNsdWRlL2xpbnV4L25ldGZpbHRlci5o
OjMxNAogICBpcDZfaW5wdXQrMHg5MC8weGE4IG5ldC9pcHY2L2lwNl9pbnB1dC5jOjQ5Mgog
ICBkc3RfaW5wdXQgaW5jbHVkZS9uZXQvZHN0Lmg6NDYwIFtpbmxpbmVdCiAgIGlwNl9yY3Zf
ZmluaXNoKzB4MWYwLzB4MjFjIG5ldC9pcHY2L2lwNl9pbnB1dC5jOjc5CiAgIE5GX0hPT0sr
MHgzMjgvMHgzZDQgaW5jbHVkZS9saW51eC9uZXRmaWx0ZXIuaDozMTQKICAgaXB2Nl9yY3Yr
MHg5Yy8weGJjIG5ldC9pcHY2L2lwNl9pbnB1dC5jOjMxMAogICBfX25ldGlmX3JlY2VpdmVf
c2tiX29uZV9jb3JlIG5ldC9jb3JlL2Rldi5jOjU2MjUgW2lubGluZV0KICAgX19uZXRpZl9y
ZWNlaXZlX3NrYisweDE4Yy8weDNjOCBuZXQvY29yZS9kZXYuYzo1NzM5CiAgIG5ldGlmX3Jl
Y2VpdmVfc2tiX2ludGVybmFsIG5ldC9jb3JlL2Rldi5jOjU4MjUgW2lubGluZV0KICAgbmV0
aWZfcmVjZWl2ZV9za2IrMHgxZjAvMHg5M2MgbmV0L2NvcmUvZGV2LmM6NTg4NQogICB0dW5f
cnhfYmF0Y2hlZCsweDU2OC8weDZlNAogICB0dW5fZ2V0X3VzZXIrMHgyNjBjLzB4Mzk3OCBk
cml2ZXJzL25ldC90dW4uYzoyMDAyCiAgIHR1bl9jaHJfd3JpdGVfaXRlcisweGZjLzB4MjA0
IGRyaXZlcnMvbmV0L3R1bi5jOjIwNDgKICAgbmV3X3N5bmNfd3JpdGUgZnMvcmVhZF93cml0
ZS5jOjQ5NyBbaW5saW5lXQogICB2ZnNfd3JpdGUrMHg4ZjgvMHhjMzggZnMvcmVhZF93cml0
ZS5jOjU5MAogICBrc3lzX3dyaXRlKzB4MTVjLzB4MjZjIGZzL3JlYWRfd3JpdGUuYzo2NDMK
ICAgX19kb19zeXNfd3JpdGUgZnMvcmVhZF93cml0ZS5jOjY1NSBbaW5saW5lXQogICBfX3Nl
X3N5c193cml0ZSBmcy9yZWFkX3dyaXRlLmM6NjUyIFtpbmxpbmVdCiAgIF9fYXJtNjRfc3lz
X3dyaXRlKzB4N2MvMHg5MCBmcy9yZWFkX3dyaXRlLmM6NjUyCiAgIF9faW52b2tlX3N5c2Nh
bGwgYXJjaC9hcm02NC9rZXJuZWwvc3lzY2FsbC5jOjM0IFtpbmxpbmVdCiAgIGludm9rZV9z
eXNjYWxsKzB4OTgvMHgyYjggYXJjaC9hcm02NC9rZXJuZWwvc3lzY2FsbC5jOjQ4CiAgIGVs
MF9zdmNfY29tbW9uKzB4MTMwLzB4MjNjIGFyY2gvYXJtNjQva2VybmVsL3N5c2NhbGwuYzox
MzEKICAgZG9fZWwwX3N2YysweDQ4LzB4NTggYXJjaC9hcm02NC9rZXJuZWwvc3lzY2FsbC5j
OjE1MAogICBlbDBfc3ZjKzB4NTQvMHgxNjggYXJjaC9hcm02NC9rZXJuZWwvZW50cnktY29t
bW9uLmM6NzEyCiAgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODQvMHhmYyBhcmNoL2FybTY0
L2tlcm5lbC9lbnRyeS1jb21tb24uYzo3MzAKICAgZWwwdF82NF9zeW5jKzB4MTkwLzB4MTk0
IGFyY2gvYXJtNjQva2VybmVsL2VudHJ5LlM6NTk4CiAgQ29kZTogZDJkMDAwMTUgZjJmYmZm
ZjUgOGIwODAyOTQgZDM0M2ZlODggKDM4NzU2OTA4KQogIC0tLVsgZW5kIHRyYWNlIDAwMDAw
MDAwMDAwMDAwMDAgXS0tLQogIC0tLS0tLS0tLS0tLS0tLS0KICBDb2RlIGRpc2Fzc2VtYmx5
IChiZXN0IGd1ZXNzKToKICAgICAwOglkMmQwMDAxNSAJbW92CXgyMSwgIzB4ODAwMDAwMDAw
MDAwICAgICAgICAJLy8gIzE0MDczNzQ4ODM1NTMyOAogICAgIDQ6CWYyZmJmZmY1IAltb3Zr
CXgyMSwgIzB4ZGZmZiwgbHNsICM0OAogICAgIDg6CThiMDgwMjk0IAlhZGQJeDIwLCB4MjAs
IHg4CiAgICAgYzoJZDM0M2ZlODggCWxzcgl4OCwgeDIwLCAjMwogICogMTA6CTM4NzU2OTA4
IAlsZHJiCXc4LCBbeDgsIHgyMV0gPC0tIHRyYXBwaW5nIGluc3RydWN0aW9uCgpSZXBvcnRl
ZC1ieTogc3l6Ym90KzZhY2VmOWUwYTRkMWY0NmM4M2Q0QHN5emthbGxlci5hcHBzcG90bWFp
bC5jb20KRml4ZXM6IDYyOGJjM2U1YTFiZSAoImwydHA6IFN1cHBvcnQgc2V2ZXJhbCBzb2Nr
ZXRzIHdpdGggc2FtZSBJUC9wb3J0IHF1YWRydXBsZSIpClNpZ25lZC1vZmYtYnk6IEphbWVz
IENoYXBtYW4gPGpjaGFwbWFuQGthdGFsaXguY29tPgotLS0KIG5ldC9sMnRwL2wydHBfY29y
ZS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9uZXQvbDJ0cC9sMnRwX2NvcmUuYyBiL25ldC9sMnRwL2wy
dHBfY29yZS5jCmluZGV4IDg4YTM0ZGIyNjVkOC4uYzVhNmNmY2YxYjNmIDEwMDY0NAotLS0g
YS9uZXQvbDJ0cC9sMnRwX2NvcmUuYworKysgYi9uZXQvbDJ0cC9sMnRwX2NvcmUuYwpAQCAt
MTUyMyw2ICsxNTIzLDggQEAgaW50IGwydHBfdHVubmVsX3JlZ2lzdGVyKHN0cnVjdCBsMnRw
X3R1bm5lbCAqdHVubmVsLCBzdHJ1Y3QgbmV0ICpuZXQsCiAJCQlnb3RvIGVycjsKIAl9CiAK
Kwl0dW5uZWwtPmwydHBfbmV0ID0gbmV0OworCiAJc2sgPSBzb2NrLT5zazsKIAlsb2NrX3Nv
Y2soc2spOwogCXdyaXRlX2xvY2tfYmgoJnNrLT5za19jYWxsYmFja19sb2NrKTsKQEAgLTE1
NTEsNyArMTU1Myw2IEBAIGludCBsMnRwX3R1bm5lbF9yZWdpc3RlcihzdHJ1Y3QgbDJ0cF90
dW5uZWwgKnR1bm5lbCwgc3RydWN0IG5ldCAqbmV0LAogCiAJc29ja19ob2xkKHNrKTsKIAl0
dW5uZWwtPnNvY2sgPSBzazsKLQl0dW5uZWwtPmwydHBfbmV0ID0gbmV0OwogCiAJc3Bpbl9s
b2NrX2JoKCZwbi0+bDJ0cF90dW5uZWxfaWRyX2xvY2spOwogCWlkcl9yZXBsYWNlKCZwbi0+
bDJ0cF90dW5uZWxfaWRyLCB0dW5uZWwsIHR1bm5lbC0+dHVubmVsX2lkKTsKLS0gCjIuMzQu
MQoK

--------------a0gFETOsaGx0Vh41juSDYBQx--

