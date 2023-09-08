Return-Path: <netdev+bounces-32609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A929798B48
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48E1281C3B
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99813AFA;
	Fri,  8 Sep 2023 17:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838B63AB
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 17:10:54 +0000 (UTC)
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 10:10:50 PDT
Received: from iam.tj (yes.iam.tj [109.74.197.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C2CE6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 10:10:50 -0700 (PDT)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by iam.tj (Postfix) with ESMTPSA id B1AE6347B9
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:02:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
	t=1694192520; bh=7IriNvaZOGEoRGJTO700UsAz9snUm/tlg1knkCA6pcU=;
	h=Date:To:From:Subject:From;
	b=VlX9LRqXsXgJXL8aT55d901JIZOoBtOLeBZ9gtnbCNYxqr4Km9HzLIzxsXYxnTR8Q
	 nPOMSafkfIRO+HXw2npGUaU97uRTWw6bOe03Iy5RNMq044emBBvU1PFUFae8dCq7uR
	 sf8FvCz7sTvKdiUIRvf0drPfWiCG8kLrKFQ/M7DYtblRABJuXcoqYBIK6zferx7BbM
	 IxrvfEOlyoPI41r54ZM4lafGFAnYiqW6GLwnIDEjpKcmEqZzJ6Vvhlq/+Xm1dAs1vP
	 7+2cLs7W5aCfDblWSojB2tPaqhPpBOqVn8rFaKEybJI4C9cFSN2HnLyKNhZTidQ+Tf
	 q2FlLABJ3Stww==
Message-ID: <f878ef3c-d11b-b1de-fa02-d9617308d460@iam.tj>
Date: Fri, 8 Sep 2023 18:02:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-GB
To: netdev@vger.kernel.org
From: Tj <linux@iam.tj>
Subject: IPv6 address scope not set to operator-configured value
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using iproute2 and kernel v6.5.0 with Debian 12 Bookworm amd64 (tested also with v6.136 nixos) setting scope on an IPv6 fails silently with no indications as to why and the address is configured with what appears to be a scope based on the prefix (usually 0 but for fe80::/16 addresses scope is set to 253). Doesn't matter whether using scope names (from /etc/iproute2/rt_scopes) or numbers. Similar command for IPv4 succeeds.

ip address add fddc::2/64 scope 200 dev PUBLIC
ip -N -6 address show dev PUBLIC
...
inet6 fddc::2/64 scope 0

I used `gdb` to trace this expecting somehow the scope was not being read correctly but it is:

2577            if (!scoped && cmd != RTM_DELADDR)
(gdb) p scoped
$22 = <optimized out>
(gdb) p cmd
$23 = <optimized out>
(gdb) n
2580            req.ifa.ifa_index = ll_name_to_index(d);
(gdb) p req.ifa.ifa_scope
$24 = 200 '\310'
...
2607            if (echo_request)
(gdb) n
2610                    ret = rtnl_talk(&rth, &req.n, NULL);
(gdb) p req.n
$25 = {nlmsg_len = 64, nlmsg_type = 20, nlmsg_flags = 1537, nlmsg_seq = 0, nlmsg_pid = 0}
(gdb) p rth
$26 = {fd = 3, local = {nl_family = 16, nl_pad = 0, nl_pid = 2381950, nl_groups = 0}, peer = {nl_family = 0, nl_pad = 0, nl_pid = 0, nl_groups = 0}, seq = 1694191286,
   dump = 0, proto = 0, dump_fp = 0x0, flags = 4}
(gdb) s
rtnl_talk (rtnl=0x5555555f7020 <rth>, n=n@entry=0x7fffffffe140, answer=answer@entry=0x0) at ./lib/libnetlink.c:1170
1170    {
...
ipaddr_modify (cmd=<optimized out>, flags=<optimized out>, argc=<optimized out>, argv=0x7fffffffe478) at ./ip/ipaddress.c:2612
2612            if (ret)
(gdb) p ret
$27 = 0






