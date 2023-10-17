Return-Path: <netdev+bounces-41793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C17CBE72
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D75CB2113D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BF3E480;
	Tue, 17 Oct 2023 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="e1OJTntW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E238FA0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:06:15 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3BB93
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=K/X4DYiA2b9YXHa6Ga+bUVu68Cx6rCgZ3ldEe5PiePs=; b=e1OJTntWmza9xtaH84f0dO5fO/
	9xn1SmsS3Ao2Rp/l/J6ulpzxIVixz4J/1dafqqH/NXTJwNbGQc1dxk9htKbPokayEtwiJCaO3UmXH
	oW5+7lbM1Clg0jNIOakcXgy0xpWWKx3EvhWtYJC3Ehh7ydK+JLjRUJPfQIobHZvwDFSMJnqquMxZI
	KyaFj/yPLKp2eY6jT+dtduozyldAdT8W99rSvqqknR4Wku7gkDUAMzcdjdtoFXnvx4AX9U5jD82yb
	4kv7GwEHLumH2c/SKl3+ZVWOx12qFqQ6ROJM768UYVLGXHHZeMIAie73fr5+HWmoiyK+qSBmY5QAr
	9A+uyiRQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsg1f-000N3J-AG; Tue, 17 Oct 2023 11:06:07 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qsg1e-000QEv-V7; Tue, 17 Oct 2023 11:06:06 +0200
Subject: Re: [PATCH v2 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
To: Florian Fainelli <f.fainelli@gmail.com>, Coco Li <lixiaoyan@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <0807165f-3805-4f45-b4f6-893cf8480508@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2d2f76b5-6af6-b6f0-5c05-cc24cb355fe8@iogearbox.net>
Date: Tue, 17 Oct 2023 11:06:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0807165f-3805-4f45-b4f6-893cf8480508@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27064/Tue Oct 17 10:11:10 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 5:46 AM, Florian Fainelli wrote:
> On 10/16/2023 6:47 PM, Coco Li wrote:
>> Currently, variable-heavy structs in the networking stack is organized
>> chronologically, logically and sometimes by cache line access.
>>
>> This patch series attempts to reorganize the core networking stack
>> variables to minimize cacheline consumption during the phase of data
>> transfer. Specifically, we looked at the TCP/IP stack and the fast
>> path definition in TCP.
>>
>> For documentation purposes, we also added new files for each core data
>> structure we considered, although not all ended up being modified due
>> to the amount of existing cache line they span in the fast path. In
>> the documentation, we recorded all variables we identified on the
>> fast path and the reasons. We also hope that in the future when
>> variables are added/modified, the document can be referred to and
>> updated accordingly to reflect the latest variable organization.
> 
> This is great stuff, while Eric mentioned this work during Netconf'23 one concern that came up however is how can we make sure that a future change which adds/removes/shuffles members in those structures is not going to be detrimental to the work you just did? Is there a way to "lock" the structure layout to avoid causing performance drops?
> 
> I suppose we could use pahole before/after for these structures and ensure that the layout on a cacheline basis remains preserved, but that means adding custom scripts to CI.

It should be possible without extra CI. We could probably have zero-sized markers
as we have in sk_buff e.g. __cloned_offset[0], and use some macros to force grouping.

ASSERT_CACHELINE_GROUP() could then throw a build error for example if the member is
not within __begin_cacheline_group and __end_cacheline_group :

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9ea3ec906b57..c664e0594da4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2059,6 +2059,7 @@ struct net_device {
          */

         /* TX read-mostly hotpath */
+       __begin_cacheline_group(tx_read_mostly);
         unsigned long long      priv_flags;
         const struct net_device_ops *netdev_ops;
         const struct header_ops *header_ops;
@@ -2085,6 +2086,7 @@ struct net_device {
  #ifdef CONFIG_NET_XGRESS
         struct bpf_mprog_entry __rcu *tcx_egress;
  #endif
+       __end_cacheline_group(tx_read_mostly);

         /* TXRX read-mostly hotpath */
         unsigned int            flags;
diff --git a/net/core/dev.c b/net/core/dev.c
index 97e7b9833db9..2a91bd4077ad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11523,6 +11523,9 @@ static int __init net_dev_init(void)

         BUG_ON(!dev_boot_phase);

+       ASSERT_CACHELINE_GROUP(tx_read_mostly, priv_flags);
+       ASSERT_CACHELINE_GROUP(tx_read_mostly, netdev_ops);
+       [...]
+
         if (dev_proc_init())
                 goto out;

