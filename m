Return-Path: <netdev+bounces-14984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46294744CCA
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 10:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9571C208E2
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 08:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25978138C;
	Sun,  2 Jul 2023 08:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C301369
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 08:45:58 +0000 (UTC)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D401A2
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 01:45:57 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qv2hK0xmyzMqB7Y;
	Sun,  2 Jul 2023 08:45:53 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qv2hH73qwzMpqLW;
	Sun,  2 Jul 2023 10:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1688287553;
	bh=vIvy7ZzQotH8aB4hWVGY+ekZa/WmcUbiE7I18SPLKqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O6Xv7856KQQ0vird2NPa6riLkOe27PkIoI9pD2Yi7M9Md2ictlTp7CtDAM3kd3m4h
	 3ZMoWn5Dj9NBcqWTvFcn+kX6OyZ58FWSqc3qk7fwraTY0qiWbPxiMrqkRabejdLGeP
	 cN0iDE7SXRQctL6EdwvCtHAFFuRTKyYATeKC7o6c=
Message-ID: <4a733dbd-f6e2-dc69-6c8d-47c362644462@digikod.net>
Date: Sun, 2 Jul 2023 10:45:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent:
Subject: Re: [PATCH v11 10/12] selftests/landlock: Add 11 new test suites
 dedicated to network
Content-Language: en-US
To: =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 yusongping@huawei.com, artem.kuzin@huawei.com
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-11-konstantin.meskhidze@huawei.com>
 <20230701.acb4d98c59a0@gnoack.org>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230701.acb4d98c59a0@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 01/07/2023 21:07, Günther Noack wrote:
> Hi!
> 
> On Tue, May 16, 2023 at 12:13:37AM +0800, Konstantin Meskhidze wrote:
>> +TEST_F(inet, bind)
> 
> If you are using TEST_F() and you are enforcing a Landlock ruleset
> within that test, doesn't that mean that the same Landlock ruleset is
> now also enabled on other tests that get run after that test?
> 
> Most of the other Landlock selftests use TEST_F_FORK() for that
> reason, so that the Landlock enforcement stays local to the specific
> test, and does not accidentally influence the observed behaviour in
> other tests.

Initially Konstantin wrote tests with TEST_F_FORK() but I asked him to 
only use TEST_F() because TEST_F_FORK() is only useful when a 
FIXTURE_TEARDOWN() needs access rights that were dropped with a 
TEST_F(), e.g. to unmount mount points set up with a FIXTURE_SETUP() 
while Landlock restricted a test process.

Indeed, TEST_F() already fork() to make sure there is no side effect 
with tests.

> 
> The same question applies to other test functions in this file as
> well.
> 
> –Günther

