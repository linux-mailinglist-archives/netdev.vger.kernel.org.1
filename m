Return-Path: <netdev+bounces-42061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13B7CCF18
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CB4B21105
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF62E3F7;
	Tue, 17 Oct 2023 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BKsj1FUC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3643430E6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 21:22:06 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F68C4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=y2ji2Mxht9sM3qPFwwAjbCh12MLYTu7Gi/v7d0oN4QQ=; b=BKsj1FUCYKLVcECqRXoVDnPuX2
	qonWvlU5AHesHMx5Ie5Zb9r0x0hX8/HPitMmx0T388Rqq2ayMBLu5qo+sy7IeEYwxJp1sPbAqEJ3V
	u3aq0FbAzlNyZHXgDfjULWVt82thv5eNCtEBD9kudXL7KDuENGd6QamoseaQLKdVtqLARGz/1mGB9
	HhqFBQBBNkQp/FjdESrC1jkHQFOqtEyby8UML/3mw5u1Tis8CCSUQHqFtl8j9M7PJIV+SJT/HeX4X
	Bl8rQysW2QDVSsUDBSBnyTWPwoF/5l7U63C6f0pwO6zSketso7YAMRJK9TsD+Q0m9+P6P22ZUI6rd
	s4y8qigg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsrVm-0007Fi-GH; Tue, 17 Oct 2023 23:21:58 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsrVm-000RHW-0X; Tue, 17 Oct 2023 23:21:58 +0200
Subject: Re: [PATCH v2 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: Daniel Borkmann <daniel@iogearbox.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Coco Li <lixiaoyan@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <0807165f-3805-4f45-b4f6-893cf8480508@gmail.com>
 <2d2f76b5-6af6-b6f0-5c05-cc24cb355fe8@iogearbox.net>
 <CANn89iKmpFN74Zu7_Ot_entm8_ryRbi7sENZXo=KJuiD4HAyDQ@mail.gmail.com>
 <da79e5cf-a004-b1e2-9a91-deb709ca0302@iogearbox.net>
Message-ID: <50ca7bc1-e5c1-cb79-b2af-e5cd83b54dab@iogearbox.net>
Date: Tue, 17 Oct 2023 23:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <da79e5cf-a004-b1e2-9a91-deb709ca0302@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27064/Tue Oct 17 10:11:10 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 7:07 PM, Daniel Borkmann wrote:
> On 10/17/23 6:50 PM, Eric Dumazet wrote:
[...]
>> Great idea, we only need to generate these automatically from the file
>> describing the fields (currently in Documentation/ )
>>
>> I think the initial intent was to find a way to generate the layout of
>> the structure itself, but this looked a bit tricky.
> 
> Agree, ideally this could be scripted from the Documentation/ file of this
> series, and perhaps the latter may not even be needed then if we have it
> self-documented in code behind some macro magic with BUILD_BUG_ON assertion
> which probes offsetof wrt the field being within markers.

... been playing around a bit, perhaps could be made nicer but this seems
to do it & also pahole will have the markers visible:

  include/linux/cache.h     | 26 ++++++++++++++++++++++++++
  include/linux/netdevice.h |  2 ++
  net/core/dev.c            | 25 +++++++++++++++++++++++++
  3 files changed, 53 insertions(+)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 9900d20b76c2..f7e166b2897a 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -85,6 +85,32 @@
  #define cache_line_size()	L1_CACHE_BYTES
  #endif

+#ifndef __cacheline_group_begin
+#define __cacheline_group_begin(GROUP) \
+	__u8 __cacheline_group_begin__##GROUP[0]
+#endif
+
+#ifndef __cacheline_group_end
+#define __cacheline_group_end(GROUP) \
+	__u8 __cacheline_group_end__##GROUP[0]
+#endif
+
+#ifndef CACHELINE_ASSERT_GROUP_MEMBER
+#define CACHELINE_ASSERT_GROUP_MEMBER(TYPE, GROUP, MEMBER) \
+	BUILD_BUG_ON(!(offsetof(TYPE, MEMBER) >= \
+		       offsetofend(TYPE, __cacheline_group_begin__##GROUP) && \
+		       offsetofend(TYPE, MEMBER) <= \
+		       offsetof(TYPE, __cacheline_group_end__##GROUP)))
+#endif
+
+#ifndef CACHELINE_ASSERT_GROUP_MAXSIZ
+#define CACHELINE_ASSERT_MIN_BOUNDARY 64
+#define CACHELINE_ASSERT_GROUP_MAXSIZ(TYPE, GROUP, NUM) \
+	BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
+		     offsetofend(TYPE, __cacheline_group_begin__##GROUP) > \
+		     ((NUM) * CACHELINE_ASSERT_MIN_BOUNDARY))
+#endif
+
  /*
   * Helper to add padding within a struct to ensure data fall into separate
   * cachelines.
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d72b71b76bf8..7a47d43b95de 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2059,6 +2059,7 @@ struct net_device {
  	 */

  	/* TX read-mostly hotpath */
+	__cacheline_group_begin(tx_read_mostly);
  	unsigned long long	priv_flags;
  	const struct net_device_ops *netdev_ops;
  	const struct header_ops *header_ops;
@@ -2082,6 +2083,7 @@ struct net_device {
  #ifdef CONFIG_NETFILTER_EGRESS
  	struct nf_hook_entries __rcu *nf_hooks_egress;
  #endif
+	__cacheline_group_end(tx_read_mostly);

  	/* TXRX read-mostly hotpath */
  	unsigned int		flags;
diff --git a/net/core/dev.c b/net/core/dev.c
index 4420831180c6..5f6b88c2c902 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11515,6 +11515,29 @@ static struct pernet_operations __net_initdata default_device_ops = {
   *
   */

+static void __init net_dev_struct_check(void)
+{
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, priv_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, netdev_ops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, header_ops);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, _tx);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, real_num_tx_queues);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, gso_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, gso_ipv4_max_size);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, gso_max_segs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, num_tc);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, mtu);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, needed_headroom);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, tc_to_txq);
+#ifdef CONFIG_XPS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, xps_maps);
+#endif
+#ifdef CONFIG_NETFILTER_EGRESS
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, tx_read_mostly, nf_hooks_egress);
+#endif
+	CACHELINE_ASSERT_GROUP_MAXSIZ(struct net_device, tx_read_mostly, 3);
+}
+
  /*
   *       This is called single threaded during boot, so no need
   *       to take the rtnl semaphore.
@@ -11525,6 +11548,8 @@ static int __init net_dev_init(void)

  	BUG_ON(!dev_boot_phase);

+	net_dev_struct_check();
+
  	if (dev_proc_init())
  		goto out;


