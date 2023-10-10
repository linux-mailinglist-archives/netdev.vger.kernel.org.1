Return-Path: <netdev+bounces-39420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853577BF186
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 05:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9C3281966
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997115A4;
	Tue, 10 Oct 2023 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF9390
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:31:39 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8059E;
	Mon,  9 Oct 2023 20:31:37 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S4Lz92qtdz67NNV;
	Tue, 10 Oct 2023 11:31:17 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 04:31:35 +0100
Message-ID: <fe08c515-b5ab-f93a-a7b8-22f48c6b76a5@huawei.com>
Date: Tue, 10 Oct 2023 06:31:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v12 08/12] landlock: Add network rules and TCP hooks
 support
Content-Language: ru
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
 <20230920092641.832134-9-konstantin.meskhidze@huawei.com>
 <20231009.Aej2eequoodi@digikod.net>
From: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <20231009.Aej2eequoodi@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



10/9/2023 6:36 PM, Mickaël Salaün пишет:
> On Wed, Sep 20, 2023 at 05:26:36PM +0800, Konstantin Meskhidze wrote:
>> This commit adds network rules support in the ruleset management
>> helpers and the landlock_create_ruleset syscall.
>> Refactor user space API to support network actions. Add new network
>> access flags, network rule and network attributes. Increment Landlock
>> ABI version. Expand access_masks_t to u32 to be sure network access
>> rights can be stored. Implement socket_bind() and socket_connect()
>> LSM hooks, which enables to restrict TCP socket binding and connection
>> to specific ports.
>> The new landlock_net_port_attr structure has two fields. The allowed_access
>> field contains the LANDLOCK_ACCESS_NET_* rights. The port field contains
>> the port value according to the allowed protocol. This field can
>> take up to a 64-bit value [1] but the maximum value depends on the related
>> protocol (e.g. 16-bit for TCP).
>> 
>> [1]
>> https://lore.kernel.org/r/278ab07f-7583-a4e0-3d37-1bacd091531d@digikod.net
> 
> Could you please include here the rationale to not tie access rights to
> sockets' file descriptor, and link [2]?
> 
> [2] https://lore.kernel.org/r/263c1eb3-602f-57fe-8450-3f138581bee7@digikod.net

   Ok. I will include this description.
   Thank you.
> .


