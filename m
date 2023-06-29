Return-Path: <netdev+bounces-14587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9947427E8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF82280DCC
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 14:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802DC125C3;
	Thu, 29 Jun 2023 14:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D76125B9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 14:04:28 +0000 (UTC)
X-Greylist: delayed 10624 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 07:04:26 PDT
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9C1FE4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 07:04:26 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QsKvD35f0zMv9Sj;
	Thu, 29 Jun 2023 14:04:24 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QsKvC4gyYzMq943;
	Thu, 29 Jun 2023 16:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1688047464;
	bh=zISBIrJvCaHLRpaYZPXAza1RbGmkHK5jlpXQyEL+/wQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=G2IKbxTJjSTE0YizDdZocUBqMS5TGvHnP9teKeK6e5vwKRUm7vo+LJ1rdcQebD901
	 qR9J7+6nFp7i+256OKDUJSDcPWOqov00QGjywo4UflTjIWmP2+Yep9oMHPU4y+D48z
	 c8G7ySgOMc66YXaURaFnU8g7PvlLl/M1fmnydrN0=
Message-ID: <62715f92-96ec-ca8b-afc7-a1ae85f4141d@digikod.net>
Date: Thu, 29 Jun 2023 16:04:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent:
Subject: Re: [PATCH v11 08/12] landlock: Add network rules and TCP hooks
 support
Content-Language: en-US
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-9-konstantin.meskhidze@huawei.com>
 <167413e7-c69a-3030-cd72-4c198158622e@digikod.net>
In-Reply-To: <167413e7-c69a-3030-cd72-4c198158622e@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 27/06/2023 18:14, Mickaël Salaün wrote:
> 
> On 15/05/2023 18:13, Konstantin Meskhidze wrote:
>> This commit adds network rules support in the ruleset management
>> helpers and the landlock_create_ruleset syscall.
>> Refactor user space API to support network actions. Add new network
>> access flags, network rule and network attributes. Increment Landlock
>> ABI version. Expand access_masks_t to u32 to be sure network access
>> rights can be stored. Implement socket_bind() and socket_connect()
>> LSM hooks, which enables to restrict TCP socket binding and connection
>> to specific ports.

It is important to explain the decision rationales. Please explain new 
types, something like this:

The new landlock_net_port_attr structure has two fields. The 
allowed_access field contains the LANDLOCK_ACCESS_NET_* rights. The port 
field contains the port value according to the the allowed protocol. 
This field can take up to a 64-bit value [1] but the maximum value 
depends on the related protocol (e.g. 16-bit for TCP).

[1] 
https://lore.kernel.org/r/278ab07f-7583-a4e0-3d37-1bacd091531d@digikod.net

