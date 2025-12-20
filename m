Return-Path: <netdev+bounces-245585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A88CD3142
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7374E300908E
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4A2C3271;
	Sat, 20 Dec 2025 14:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951F2D061D
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766242642; cv=none; b=ipk0PPhILkvIDrYacLfL9U9Xo8m7W+YblQ966593UXsM2R9LS0uyQv9g0P8GvAsGtW9NVo1WIJ5arz11H69d/FrUJpbHyEEfo0+yydEz12UsUE3gd7JxvMYvjDpSNaIXedcW3A+LNPOdRnkoxlTIw8zvfr9q89S+QdQkCeLRV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766242642; c=relaxed/simple;
	bh=3vt6uOKAIKiUqg1JxVaQlDVdsp7i8O4CIqLounDvN0I=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=Wv27AVV2PnwNhMcJ/4OPMz6iPmWJvsvbLVzDQuz2UN6FHEaoTLeWetcjcBIhoAR7mmeZSGFCe6KMONXs9IaKCyR4X6r09P74ZYODi8CoAbvw1lxB4GTxmPQcAqme+Djjq9TetNob1WLuuKGnl6bLfH1GW7z/kdniWlQNhFgq8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BKEv8Ha087269;
	Sat, 20 Dec 2025 23:57:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BKEv70k087266
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Dec 2025 23:57:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Content-Type: multipart/mixed; boundary="------------btIfSDusQku0MRu4n31ChAqq"
Message-ID: <d943f806-4da6-4970-ac28-b9373b0e63ac@I-love.SAKURA.ne.jp>
Date: Sat, 20 Dec 2025 23:57:06 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [BUG nexthop] refcount leak in "struct nexthop" handling
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

This is a multi-part message in MIME format.
--------------btIfSDusQku0MRu4n31ChAqq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting refcount leak in "struct nexthop" handling
which manifests as a hung up with below message.

  unregister_netdevice: waiting for lo to become free. Usage count = 2
  ref_tracker: netdev@ffff88803a65e618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       netdev_get_by_index+0x7c/0xb0 net/core/dev.c:1008
       fib6_nh_init+0x791/0x1fb0 net/ipv6/route.c:3590
       nh_create_ipv6 net/ipv4/nexthop.c:2875 [inline]
       nexthop_create net/ipv4/nexthop.c:2926 [inline]
       nexthop_add net/ipv4/nexthop.c:2963 [inline]
       rtm_new_nexthop+0x244b/0x87d0 net/ipv4/nexthop.c:3277
       rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6958
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

Commit ab84be7e54fc ("net: Initial nexthop code") says

  Nexthop notifications are sent when a nexthop is added or deleted,
  but NOT if the delete is due to a device event or network namespace
  teardown (which also involves device events).

which I guess that it is an intended behavior that
nexthop_notify(RTM_DELNEXTHOP) is not called from remove_nexthop() from
flush_all_nexthops() from nexthop_net_exit_rtnl() from ops_undo_list()
 from cleanup_net() because remove_nexthop() passes nlinfo == NULL.

However, like the attached reproducer demonstrates, it is inevitable that
a userspace process terminates and network namespace teardown automatically
happens without explicitly invoking RTM_DELNEXTHOP request. The kernel is
not currently prepared for such scenario. How to fix this problem?

Link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
--------------btIfSDusQku0MRu4n31ChAqq
Content-Type: text/plain; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c2NoZWQuaD4KI2luY2x1ZGUgPHN0ZGlu
dC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5j
bHVkZSA8dW5pc3RkLmg+CgpzdGF0aWMgdm9pZCBleGVjdXRlMShjb25zdCBpbnQgZmQpCnsK
CS8vICBzZW5kbXNnJG5sX3JvdXRlIGFyZ3VtZW50czogWwoJLy8gICAgZmQ6IHNvY2tfbmxf
cm91dGUgKHJlc291cmNlKQoJLy8gICAgbXNnOiBwdHJbaW4sIG1zZ2hkcl9uZXRsaW5rW25l
dGxpbmtfbXNnX3JvdXRlXV0gewoJLy8gICAgICBtc2doZHJfbmV0bGlua1tuZXRsaW5rX21z
Z19yb3V0ZV0gewoJLy8gICAgICAgIGFkZHI6IG5pbAoJLy8gICAgICAgIGFkZHJsZW46IGxl
biA9IDB4MCAoNCBieXRlcykKCS8vICAgICAgICBwYWQgPSAweDAgKDQgYnl0ZXMpCgkvLyAg
ICAgICAgdmVjOiBwdHJbaW4sIGlvdmVjW2luLCBuZXRsaW5rX21zZ19yb3V0ZV1dIHsKCS8v
ICAgICAgICAgIGlvdmVjW2luLCBuZXRsaW5rX21zZ19yb3V0ZV0gewoJLy8gICAgICAgICAg
ICBhZGRyOiBwdHJbaW4sIG5ldGxpbmtfbXNnX3JvdXRlXSB7CgkvLyAgICAgICAgICAgICAg
dW5pb24gbmV0bGlua19tc2dfcm91dGUgewoJLy8gICAgICAgICAgICAgICAgaXB2Nl9uZXdu
ZXh0aG9wOiBuZXRsaW5rX21zZ190W2NvbnN0W1JUTV9ORVdORVhUSE9QLCBpbnQxNl0sCgkv
LyAgICAgICAgICAgICAgICBuaG1zZ19uZXdbQUZfSU5FVDZdLCBydG1fbmhfcG9saWN5X25l
d10gewoJLy8gICAgICAgICAgICAgICAgICBsZW46IGxlbiA9IDB4MWMgKDQgYnl0ZXMpCgkv
LyAgICAgICAgICAgICAgICAgIHR5cGU6IGNvbnN0ID0gMHg2OCAoMiBieXRlcykKCS8vICAg
ICAgICAgICAgICAgICAgZmxhZ3M6IG5ldGxpbmtfbXNnX2ZsYWdzID0gMHg1ZmI5YTgxOGZi
NzM3OGU5ICgyIGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgICBzZXE6IGludDMyID0gMHgw
ICg0IGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgICBwaWQ6IGludDMyID0gMHgwICg0IGJ5
dGVzKQoJLy8gICAgICAgICAgICAgICAgICBwYXlsb2FkOiBuaG1zZ1tBRl9JTkVUNiwgZmxh
Z3NbcnRtX3Byb3RvY29sLCBpbnQ4XSwKCS8vICAgICAgICAgICAgICAgICAgZmxhZ3NbcnRu
aF9mbGFncywgaW50MzJdXSB7CgkvLyAgICAgICAgICAgICAgICAgICAgbmhfZmFtaWx5OiBj
b25zdCA9IDB4YSAoMSBieXRlcykKCS8vICAgICAgICAgICAgICAgICAgICBuaF9zY29wZTog
Y29uc3QgPSAweDAgKDEgYnl0ZXMpCgkvLyAgICAgICAgICAgICAgICAgICAgbmhfcHJvdG9j
b2w6IHJ0bV9wcm90b2NvbCA9IDB4MCAoMSBieXRlcykKCS8vICAgICAgICAgICAgICAgICAg
ICByZXN2ZDogY29uc3QgPSAweDAgKDEgYnl0ZXMpCgkvLyAgICAgICAgICAgICAgICAgICAg
bmhfZmxhZ3M6IHJ0bmhfZmxhZ3MgPSAweDAgKDQgYnl0ZXMpCgkvLyAgICAgICAgICAgICAg
ICAgIH0KCS8vICAgICAgICAgICAgICAgICAgYXR0cnM6IGFycmF5W3J0bV9uaF9wb2xpY3lf
bmV3XSB7CgkvLyAgICAgICAgICAgICAgICAgICAgdW5pb24gcnRtX25oX3BvbGljeV9uZXcg
ewoJLy8gICAgICAgICAgICAgICAgICAgICAgTkhBX0JMQUNLSE9MRTogbmxhdHRyX3RbY29u
c3RbTkhBX0JMQUNLSE9MRSwgaW50MTZdLAoJLy8gICAgICAgICAgICAgICAgICAgICAgdm9p
ZF0gewoJLy8gICAgICAgICAgICAgICAgICAgICAgICBubGFfbGVuOiBvZmZzZXRvZiA9IDB4
NCAoMiBieXRlcykKCS8vICAgICAgICAgICAgICAgICAgICAgICAgbmxhX3R5cGU6IGNvbnN0
ID0gMHg0ICgyIGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgICAgICAgICBwYXlsb2FkOiBi
dWZmZXI6IHt9IChsZW5ndGggMHgwKQoJLy8gICAgICAgICAgICAgICAgICAgICAgICBzaXpl
OiBidWZmZXI6IHt9IChsZW5ndGggMHgwKQoJLy8gICAgICAgICAgICAgICAgICAgICAgfQoJ
Ly8gICAgICAgICAgICAgICAgICAgIH0KCS8vICAgICAgICAgICAgICAgICAgfQoJLy8gICAg
ICAgICAgICAgICAgfQoJLy8gICAgICAgICAgICAgIH0KCS8vICAgICAgICAgICAgfQoJLy8g
ICAgICAgICAgICBsZW46IGxlbiA9IDB4MWMgKDggYnl0ZXMpCgkvLyAgICAgICAgICB9Cgkv
LyAgICAgICAgfQoJLy8gICAgICAgIHZsZW46IGNvbnN0ID0gMHgxICg4IGJ5dGVzKQoJLy8g
ICAgICAgIGN0cmw6IGNvbnN0ID0gMHgwICg4IGJ5dGVzKQoJLy8gICAgICAgIGN0cmxsZW46
IGNvbnN0ID0gMHgwICg4IGJ5dGVzKQoJLy8gICAgICAgIGY6IHNlbmRfZmxhZ3MgPSAweDAg
KDQgYnl0ZXMpCgkvLyAgICAgICAgcGFkID0gMHgwICg0IGJ5dGVzKQoJLy8gICAgICB9Cgkv
LyAgICB9CgkvLyAgICBmOiBzZW5kX2ZsYWdzID0gMHgwICg4IGJ5dGVzKQoJLy8gIF0KCSoo
dWludDY0X3QqKTB4MjAwMDAwMDAwMTAwID0gMDsKCSoodWludDMyX3QqKTB4MjAwMDAwMDAw
MTA4ID0gMDsKCSoodWludDY0X3QqKTB4MjAwMDAwMDAwMTEwID0gMHgyMDAwMDAwMDAwYzA7
CgkqKHVpbnQ2NF90KikweDIwMDAwMDAwMDBjMCA9IDB4MjAwMDAwMDAwMTQwOwoJKih1aW50
MzJfdCopMHgyMDAwMDAwMDAxNDAgPSAweDFjOwoJKih1aW50MTZfdCopMHgyMDAwMDAwMDAx
NDQgPSAweDY4OwoJKih1aW50MTZfdCopMHgyMDAwMDAwMDAxNDYgPSAweDc4ZTk7CgkqKHVp
bnQzMl90KikweDIwMDAwMDAwMDE0OCA9IDA7CgkqKHVpbnQzMl90KikweDIwMDAwMDAwMDE0
YyA9IDA7CgkqKHVpbnQ4X3QqKTB4MjAwMDAwMDAwMTUwID0gMHhhOwoJKih1aW50OF90Kikw
eDIwMDAwMDAwMDE1MSA9IDA7CgkqKHVpbnQ4X3QqKTB4MjAwMDAwMDAwMTUyID0gMDsKCSoo
dWludDhfdCopMHgyMDAwMDAwMDAxNTMgPSAwOwoJKih1aW50MzJfdCopMHgyMDAwMDAwMDAx
NTQgPSAwOwoJKih1aW50MTZfdCopMHgyMDAwMDAwMDAxNTggPSA0OwoJKih1aW50MTZfdCop
MHgyMDAwMDAwMDAxNWEgPSA0OwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAwYzggPSAweDFj
OwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAxMTggPSAxOwoJKih1aW50NjRfdCopMHgyMDAw
MDAwMDAxMjAgPSAwOwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAxMjggPSAwOwoJKih1aW50
MzJfdCopMHgyMDAwMDAwMDAxMzAgPSAwOwoJc3lzY2FsbChfX05SX3NlbmRtc2csIC8qZmQ9
Ki9mZCwgLyptc2c9Ki8weDIwMDAwMDAwMDEwMHVsLCAvKmY9Ki8wdWwpOwp9CgpzdGF0aWMg
dm9pZCBleGVjdXRlMihjb25zdCBpbnQgZmQpCnsKCS8vICBzZW5kbXNnJG5sX3JvdXRlIGFy
Z3VtZW50czogWwoJLy8gICAgZmQ6IHNvY2tfbmxfcm91dGUgKHJlc291cmNlKQoJLy8gICAg
bXNnOiBwdHJbaW4sIG1zZ2hkcl9uZXRsaW5rW25ldGxpbmtfbXNnX3JvdXRlXV0gewoJLy8g
ICAgICBtc2doZHJfbmV0bGlua1tuZXRsaW5rX21zZ19yb3V0ZV0gewoJLy8gICAgICAgIGFk
ZHI6IG5pbAoJLy8gICAgICAgIGFkZHJsZW46IGxlbiA9IDB4MCAoNCBieXRlcykKCS8vICAg
ICAgICBwYWQgPSAweDAgKDQgYnl0ZXMpCgkvLyAgICAgICAgdmVjOiBwdHJbaW4sIGlvdmVj
W2luLCBuZXRsaW5rX21zZ19yb3V0ZV1dIHsKCS8vICAgICAgICAgIGlvdmVjW2luLCBuZXRs
aW5rX21zZ19yb3V0ZV0gewoJLy8gICAgICAgICAgICBhZGRyOiBwdHJbaW5vdXQsIGFycmF5
W0FOWVVOSU9OXV0gewoJLy8gICAgICAgICAgICAgIGFycmF5W0FOWVVOSU9OXSB7CgkvLyAg
ICAgICAgICAgICAgICB1bmlvbiBBTllVTklPTiB7CgkvLyAgICAgICAgICAgICAgICAgIEFO
WUJMT0I6IGJ1ZmZlcjogezMwIDAwIDAwIDAwIDE4IDAwIGRkIDhkIDAwIDAwIDAwIDAwIDAw
CgkvLyAgICAgICAgICAgICAgICAgIDAwIDAwIDAwIDAyIDAwIDAwIDAwIDAwIDAwIDAwIDA2
IDAwIDAwIDAwIDAwIDA4IDAwIDFlIDAwCgkvLyAgICAgICAgICAgICAgICAgIDAyfSAobGVu
Z3RoIDB4MjEpCgkvLyAgICAgICAgICAgICAgICB9CgkvLyAgICAgICAgICAgICAgfQoJLy8g
ICAgICAgICAgICB9CgkvLyAgICAgICAgICAgIGxlbjogbGVuID0gMHgzMCAoOCBieXRlcykK
CS8vICAgICAgICAgIH0KCS8vICAgICAgICB9CgkvLyAgICAgICAgdmxlbjogY29uc3QgPSAw
eDEgKDggYnl0ZXMpCgkvLyAgICAgICAgY3RybDogY29uc3QgPSAweDAgKDggYnl0ZXMpCgkv
LyAgICAgICAgY3RybGxlbjogY29uc3QgPSAweDAgKDggYnl0ZXMpCgkvLyAgICAgICAgZjog
c2VuZF9mbGFncyA9IDB4MCAoNCBieXRlcykKCS8vICAgICAgICBwYWQgPSAweDAgKDQgYnl0
ZXMpCgkvLyAgICAgIH0KCS8vICAgIH0KCS8vICAgIGY6IHNlbmRfZmxhZ3MgPSAweDQwOTAg
KDggYnl0ZXMpCgkvLyAgXQoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAxODAgPSAwOwoJKih1
aW50MzJfdCopMHgyMDAwMDAwMDAxODggPSAwOwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAx
OTAgPSAweDIwMDAwMDAwMDc4MDsKCSoodWludDY0X3QqKTB4MjAwMDAwMDAwNzgwID0gMHgy
MDAwMDAwMDAzODA7CgltZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAwMzgwLAoJICAgICAgICJc
eDMwXHgwMFx4MDBceDAwXHgxOFx4MDBceGRkXHg4ZFx4MDBceDAwXHgwMFx4MDBceDAwXHgw
MFx4MDBceDAwXHgwMiIKCSAgICAgICAiXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwNlx4
MDBceDAwXHgwMFx4MDBceDA4XHgwMFx4MWVceDAwXHgwMiIsCgkgICAgICAgMzMpOwoJKih1
aW50NjRfdCopMHgyMDAwMDAwMDA3ODggPSAweDMwOwoJKih1aW50NjRfdCopMHgyMDAwMDAw
MDAxOTggPSAxOwoJKih1aW50NjRfdCopMHgyMDAwMDAwMDAxYTAgPSAwOwoJKih1aW50NjRf
dCopMHgyMDAwMDAwMDAxYTggPSAwOwoJKih1aW50MzJfdCopMHgyMDAwMDAwMDAxYjAgPSAw
OwoJc3lzY2FsbChfX05SX3NlbmRtc2csIC8qZmQ9Ki9mZCwgLyptc2c9Ki8weDIwMDAwMDAw
MDE4MHVsLAoJCS8qZj1NU0dfUFJPQkV8TVNHX05PU0lHTkFMfE1TR19FT1IqLyAweDQwOTB1
bCk7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCXN5c2NhbGwoX19O
Ul9tbWFwLCAvKmFkZHI9Ki8weDIwMDAwMDAwMDAwMHVsLCAvKmxlbj0qLzB4MTAwMDAwMHVs
LAoJCS8qcHJvdD1QUk9UX1dSSVRFfFBST1RfUkVBRHxQUk9UX0VYRUMqLyA3dWwsCgkJLypm
bGFncz1NQVBfRklYRUR8TUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSovIDB4MzJ1bCwKCQkv
KmZkPSovKGludHB0cl90KS0xLCAvKm9mZnNldD0qLzB1bCk7CglpZiAodW5zaGFyZShDTE9O
RV9ORVdORVQpKQoJCXJldHVybiAxOwoJaW50IGZkID0gc3lzY2FsbChfX05SX3NvY2tldCwg
Lypkb21haW49Ki8weDEwdWwsIC8qdHlwZT0qLzN1bCwgLypwcm90bz0qLzApOwoJaWYgKGZk
ID09IC0xKQoJCXJldHVybiAxOwoJZXhlY3V0ZTEoZmQpOwoJZXhlY3V0ZTEoZmQpOwoJZXhl
Y3V0ZTIoZmQpOwoJcmV0dXJuIDA7Cn0K

--------------btIfSDusQku0MRu4n31ChAqq--

