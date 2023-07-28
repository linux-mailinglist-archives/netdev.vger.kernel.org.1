Return-Path: <netdev+bounces-22346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB676717B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4A02827E4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41914A84;
	Fri, 28 Jul 2023 16:06:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A4314283
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:06:03 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875AB2686
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:06:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc512526cso328889866b.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690560360; x=1691165160;
        h=content-transfer-encoding:to:subject:cc:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZBrTUZfxyX45UxKSf2arRiLF5RXORIOanUk1qR+SHQ=;
        b=WL6a8J+KM7FA1U4vsw/1G+vftpnDxBx+tJfh1IM18rgpCFty3HTvXuRCjsw7jsUOyD
         ejhBPTws68TbC81fPP1OAjaizcuAhXiBs4jq/mBdHPPk7WzrD6HRz67sz31J67Ilb6Cs
         MZCXNY7iueMHfHb+eRD7N4rkqrzH/jbN9qdl82MoKuOO2YGxboBQPa7TYglGAvrwU6oU
         Rez0pXGr5Zm0YzQMsSGxQcGgZEboDh3DnVu34UXjY4xcutdQsF1LdfWDJ6WxjhuYQ81P
         cVxZKiozhK9v+W/7sbQwn3sQkbRYreLcq3mpRhpHj0dU0MINGiy5O/VX/PCVyWeeaHBy
         NZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560360; x=1691165160;
        h=content-transfer-encoding:to:subject:cc:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xZBrTUZfxyX45UxKSf2arRiLF5RXORIOanUk1qR+SHQ=;
        b=Z3d8NgKDZwyGaleREG38/dl2Y4X2Io4c2Q32IqoQRTFkjtEIyuUd1N8MBzOvYcxeiy
         lXedPV99tlth8TUethrAC0hg+GzEgxCStbpnooAt2NrxAkeHWZSvcrJ07jajvnsIGEpU
         1HG+Vl0g4Z+HbIl2aZl2EYSyt2tIvaG+42AFlewymyrDs02c+6xT11iSlI1TevK3IU7D
         CFhGvnbc1svkvNFYkVe2FO8l0+5bq8kmoBKFqAlHxfNc2DX0vDlHXTvOcJucXNoZvKb8
         Z9EfQVspAenLrNlW2l5aHiCTepy6jkxfRz/uApVYOpi2bU+hX/Fx3oPbo5NjUHMkd+Sf
         q7cw==
X-Gm-Message-State: ABy/qLY+kiSgj1tiU+uGWBe72p1Qu0T2dxMuiRTRZW0jaVCvfyN/7qJW
	HLl/4Q9hFTG/RWaMzdqD2N0zLeWvz5a18qHzSHyTCg==
X-Google-Smtp-Source: APBJJlG/ykv9F11EeRkg3qaVO/6yvgVLYE3LRSZAodqjAb5RERb+24Gy4FXF2W7QWhJ2eD9UBd+LYA==
X-Received: by 2002:a17:907:a050:b0:999:37ff:be94 with SMTP id gz16-20020a170907a05000b0099937ffbe94mr2484544ejc.71.1690560359720;
        Fri, 28 Jul 2023 09:05:59 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id lt5-20020a170906fa8500b0098f99048053sm2241021ejb.148.2023.07.28.09.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:05:59 -0700 (PDT)
Message-ID: <10f49258-ae5d-58f4-be1b-8358dd00af8a@tessares.net>
Date: Fri, 28 Jul 2023 18:05:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: KMemLeak when creating netns / tun dev / sending NL msg
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Our CI validating MPTCP tree recently reported leaks according to KMemLeak.

Here are some examples of backtraces decoded with decode_stacktrace.sh:

------------ 8< ------------
unreferenced object 0xffff88800ce2b000 (size 2048):
comm "ip", pid 18556, jiffies 4296578479 (age 84.890s)
hex dump (first 32 bytes):
08 60 1d 18 80 88 ff ff 00 00 00 00 00 00 00 00  .`..............
00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
backtrace:
__kmalloc (include/linux/kasan.h:196)
__register_sysctl_table (include/linux/slab.h:586)
__devinet_sysctl_register (net/ipv4/devinet.c:2590)
devinet_init_net (net/ipv4/devinet.c:2713)
ops_init (net/core/net_namespace.c:136)
setup_net (net/core/net_namespace.c:339)
copy_net_ns (net/core/net_namespace.c:493)
create_new_namespaces (kernel/nsproxy.c:110)
unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
ksys_unshare (kernel/fork.c:3438)
__x64_sys_unshare (kernel/fork.c:3507)
do_syscall_64 (arch/x86/entry/common.c:50)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
------------ 8< ------------

------------ 8< ------------
unreferenced object 0xffff888010866900 (size 192):
comm "ip", pid 18556, jiffies 4296578480 (age 84.901s)
hex dump (first 32 bytes):
00 3d 39 07 80 88 ff ff 22 01 00 00 00 00 ad de  .=9.....".......
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace:
__kmalloc (include/linux/kasan.h:196)
fib_default_rule_add (include/linux/slab.h:586)
fib4_rules_init (net/ipv4/fib_rules.c:399)
fib_net_init (net/ipv4/fib_frontend.c:1554)
ops_init (net/core/net_namespace.c:136)
setup_net (net/core/net_namespace.c:339)
copy_net_ns (net/core/net_namespace.c:493)
create_new_namespaces (kernel/nsproxy.c:110)
unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
ksys_unshare (kernel/fork.c:3438)
__x64_sys_unshare (kernel/fork.c:3507)
do_syscall_64 (arch/x86/entry/common.c:50)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
------------ 8< ------------

------------ 8< ------------
unreferenced object 0xffff88800fb5b000 (size 2048):
comm "ip", pid 18556, jiffies 4296578502 (age 84.879s)
hex dump (first 32 bytes):
00 60 0f 0e 80 88 ff ff 00 00 00 00 00 00 00 00  .`..............
00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
backtrace:
__kmalloc (include/linux/kasan.h:196)
__register_sysctl_table (include/linux/slab.h:586)
nf_conntrack_pernet_init (net/netfilter/nf_conntrack_standalone.c:1109)
ops_init (net/core/net_namespace.c:136)
setup_net (net/core/net_namespace.c:339)
copy_net_ns (net/core/net_namespace.c:493)
create_new_namespaces (kernel/nsproxy.c:110)
unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
ksys_unshare (kernel/fork.c:3438)
__x64_sys_unshare (kernel/fork.c:3507)
do_syscall_64 (arch/x86/entry/common.c:50)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
------------ 8< ------------


The majority comes from "ip" when creating a new netns but a few also
come from "packetdrill" when creating a tun device:

------------ 8< ------------
unreferenced object 0xffff8880198da000 (size 2048):
comm "packetdrill", pid 20084, jiffies 4296651533 (age 12.029s)
hex dump (first 32 bytes):
08 c0 f5 05 80 88 ff ff 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 ea ff ff ff ff ff ff ff  ................
backtrace:
__kmalloc (include/linux/kasan.h:196)
__register_sysctl_table (include/linux/slab.h:586)
__devinet_sysctl_register (net/ipv4/devinet.c:2590)
devinet_sysctl_register (net/ipv4/devinet.c:2630)
inetdev_init (net/ipv4/devinet.c:286)
inetdev_event (net/ipv4/devinet.c:1538)
notifier_call_chain (kernel/notifier.c:95)
register_netdevice (include/linux/notifier.h:218)
tun_set_iff.constprop.0 (drivers/net/tun.c:2846)
__tun_chr_ioctl (drivers/net/tun.c:3113)
__x64_sys_ioctl (fs/ioctl.c:52)
do_syscall_64 (arch/x86/entry/common.c:50)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
------------ 8< ------------


But I can also see backtraces not mentioning sysctl, caused by "ip" when
communicating with the kernel via netlink:

------------ 8< ------------
unreferenced object 0xffff88801041ee00 (size 256):
comm "ip", pid 18567, jiffies 4296579097 (age 84.399s)
hex dump (first 32 bytes):
00 40 c8 18 80 88 ff ff e0 00 00 01 00 00 00 00  .@..............
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace:
kmalloc_trace (mm/slab_common.c:1079)
____ip_mc_inc_group (include/linux/slab.h:582)
ip_mc_up (net/ipv4/igmp.c:1791 (discriminator 11))
inetdev_event (net/ipv4/devinet.c:1584)
notifier_call_chain (kernel/notifier.c:95)
__dev_notify_flags (net/core/dev.c:8574)
dev_change_flags (net/core/dev.c:8609)
do_setlink (net/core/rtnetlink.c:2867)
__rtnl_newlink (net/core/rtnetlink.c:3655)
rtnl_newlink (net/core/rtnetlink.c:3703)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6424)
netlink_rcv_skb (net/netlink/af_netlink.c:2549)
netlink_unicast (net/netlink/af_netlink.c:1340)
netlink_sendmsg (net/netlink/af_netlink.c:1914)
sock_sendmsg (net/socket.c:728)
____sys_sendmsg (net/socket.c:2494)
------------ 8< ------------

------------ 8< ------------
unreferenced object 0xffff88800fee4c00 (size 512):
comm "ip", pid 18567, jiffies 4296579099 (age 84.409s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01  ................
80 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff  ................
backtrace:
kmalloc_trace (mm/slab_common.c:1079)
ipv6_add_addr (include/linux/slab.h:582)
add_addr (net/ipv6/addrconf.c:3108)
addrconf_notify (include/linux/err.h:72)
notifier_call_chain (kernel/notifier.c:95)
__dev_notify_flags (net/core/dev.c:8574)
dev_change_flags (net/core/dev.c:8609)
do_setlink (net/core/rtnetlink.c:2867)
__rtnl_newlink (net/core/rtnetlink.c:3655)
rtnl_newlink (net/core/rtnetlink.c:3703)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6424)
netlink_rcv_skb (net/netlink/af_netlink.c:2549)
netlink_unicast (net/netlink/af_netlink.c:1340)
netlink_sendmsg (net/netlink/af_netlink.c:1914)
sock_sendmsg (net/socket.c:728)
____sys_sendmsg (net/socket.c:2494)
------------ 8< ------------



For more backtraces, please see:

  https://github.com/multipath-tcp/mptcp_net-next/issues/424


I don't have much info to share on how to reproduce the issue because we
only see this error occasionally and only at the end of the execution of
many different tests, when forcing a kmemleak scan.

The CI creates and destroys hundreds of netns during these tests (MPTCP
selftests + packetdrill). We don't frequently see this issue so it might
be hard to reproduce (and could also be a false positive from kmemleak).

The last time we had this issue, all tests have been executed with
success and have been stopped when the scan had been initiated. So in
theory, all netns and tun devices have been properly destroyed (or asked
to be destroyed) before the scan.

I don't think we had this issue before this month, maybe due to
something new coming with v6.5-rc1? We had this issue on top of -net and
net-next.

Anybody else saw such issue with a reproducer or has a pointer on what
could cause that? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

