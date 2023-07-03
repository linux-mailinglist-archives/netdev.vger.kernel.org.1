Return-Path: <netdev+bounces-15065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877C745776
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E61280CD6
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1417F8;
	Mon,  3 Jul 2023 08:37:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94451371
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:37:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B193D1;
	Mon,  3 Jul 2023 01:37:18 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QvfN74vpmz6D8cQ;
	Mon,  3 Jul 2023 16:33:59 +0800 (CST)
Received: from [10.123.123.126] (10.123.123.126) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 09:37:14 +0100
Message-ID: <338bba9d-6afa-7c6b-2843-b116abb36859@huawei.com>
Date: Mon, 3 Jul 2023 11:37:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v11 10/12] selftests/landlock: Add 11 new test suites
 dedicated to network
Content-Language: ru
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
	=?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC: <willemdebruijn.kernel@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-11-konstantin.meskhidze@huawei.com>
 <20230701.acb4d98c59a0@gnoack.org>
 <4a733dbd-f6e2-dc69-6c8d-47c362644462@digikod.net>
From: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <4a733dbd-f6e2-dc69-6c8d-47c362644462@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.123.126]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



7/2/2023 11:45 AM, Mickaël Salaün пишет:
> 
> On 01/07/2023 21:07, Günther Noack wrote:
>> Hi!
>> 
>> On Tue, May 16, 2023 at 12:13:37AM +0800, Konstantin Meskhidze wrote:
>>> +TEST_F(inet, bind)
>> 
>> If you are using TEST_F() and you are enforcing a Landlock ruleset
>> within that test, doesn't that mean that the same Landlock ruleset is
>> now also enabled on other tests that get run after that test?
>> 
>> Most of the other Landlock selftests use TEST_F_FORK() for that
>> reason, so that the Landlock enforcement stays local to the specific
>> test, and does not accidentally influence the observed behaviour in
>> other tests.
> 
> Initially Konstantin wrote tests with TEST_F_FORK() but I asked him to
> only use TEST_F() because TEST_F_FORK() is only useful when a
> FIXTURE_TEARDOWN() needs access rights that were dropped with a
> TEST_F(), e.g. to unmount mount points set up with a FIXTURE_SETUP()
> while Landlock restricted a test process.
> 
> Indeed, TEST_F() already fork() to make sure there is no side effect
> with tests.
> 

  Hi, Günther
  Yep. Mickaёl asked me to replace TEST_F_FORK() with TEST_F(). Please 
check this thread
 
https://lore.kernel.org/netdev/33c1f049-12e4-f06d-54c9-b54eec779e6f@digikod.net/
T
>> 
>> The same question applies to other test functions in this file as
>> well.
>> 
>> –Günther
> .

