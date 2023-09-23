Return-Path: <netdev+bounces-35946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109F7AC1B2
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 14:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 99EBD282189
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE130182B0;
	Sat, 23 Sep 2023 12:09:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5A179A0
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 12:09:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316F199
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 05:09:09 -0700 (PDT)
Received: from [192.168.1.122] (ip5b41a963.dynamic.kabel-deutschland.de [91.65.169.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1B97A61E5FE04;
	Sat, 23 Sep 2023 14:09:05 +0200 (CEST)
Message-ID: <bc7bf168-2a37-cd8e-3cac-cfd7ae475ebc@molgen.mpg.de>
Date: Sat, 23 Sep 2023 14:09:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: netdev@vger.kernel.org
From: Donald Buczek <buczek@molgen.mpg.de>
Subject: question: ip link "dev" keyword deprecated?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I've noticed, that veth(4) (from Linux man-pages) missed the "name" keyword in the second usage example:

     # ip link add <p1-name> netns <p1-ns> type veth peer <p2-name> netns <p2-ns>

which doesn't work with older iproute2 versions, e.g. 4.4, where <p2-name> is silently ignored.

I was about to send a man patch, but actually the syntax works with current iproute2 versions, because special coding has been removed and iplink_parse() interprets the non-keyword value "<p2-name>" from "<p2-name> netns <p2-ns>" as a "dev" option (with "dev" implied) and sets "name" to "dev" if only "dev" is given. So now for the same reason we can do

     ip link show lo
     ip link show dev lo

we can also do any of

     # ip link add <p1-name> type veth peer name <p2-name>
     # ip link add <p1-name> type veth peer dev <p2-name>
     # ip link add <p1-name> type veth peer <p2-name>

But this looks like inherited baggage. And it doesn't work for older iproute2 versions. And veth(4) seems inconsistent with its two examples:

     # ip link add <p1-name> type veth peer name <p2-name>
     # ip link add <p1-name> netns <p1-ns> type veth peer <p2-name> netns <p2-ns>

And even ip-link(8) from iproute2 itself doesn't talk about the "dev" keyword.

So I want to ask if there is a canonical syntax which should consistently be published and used, even if some legacy construct (like "peer <p2-name>") happen to work?

Related: Is the "dev" keywords generally deprecated?


Thanks

   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

