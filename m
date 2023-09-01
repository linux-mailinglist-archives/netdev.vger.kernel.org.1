Return-Path: <netdev+bounces-31677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B378F827
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 07:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3570A1C20B5B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 05:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08143D82;
	Fri,  1 Sep 2023 05:47:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20323FD4
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 05:47:00 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813EAE50;
	Thu, 31 Aug 2023 22:46:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id C8080E0003;
	Fri,  1 Sep 2023 05:46:49 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Aug 2023 22:46:49 -0700
From: Joao Moreira <joao@overdrivepizza.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 rkannoth@marvell.com, wojciech.drewek@intel.com,
 steen.hegenlund@microhip.com, keescook@chromium.org, Joao Moreira
 <joao.moreira@intel.com>
Subject: Re: [PATCH 0/2] Prevent potential write out of bounds
In-Reply-To: <20230831182800.25e5d4d9@kernel.org>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
 <20230831182800.25e5d4d9@kernel.org>
Message-ID: <00d4a104c17d92562f03042c31ea664b@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: joao@overdrivepizza.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-31 18:28, Jakub Kicinski wrote:
> On Thu, 31 Aug 2023 18:04:35 -0700 joao@overdrivepizza.com wrote:
>> The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
>> unsigned int num_actions (line 10) and later traverses the actions in
>> the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
>> 
>> Within the same file, the loop in the line 24 compares a signed int
>> (i) to an unsigned int (num_actions), and then uses i as an array
>> index. If an integer overflow happens, then the array within the loop
>> is wrongly indexed, causing a write out of bounds.
>> 
>> After checking with maintainers, it seems that the front-end caps the
>> maximum value of num_action, thus it is not possible to reach the 
>> given
>> write out of bounds, yet, still, to prevent disasters it is better to
>> fix the signedness here.
> 
> How did you find this? The commit messages should include info
> about how the issue was discovered.

Sure, I'll wait a bit longer for more suggestions and add the info in a 
next patch version.

Meanwhile, fwiiw, I stumbled on the bug when I was reading Nick 
Gregory's write-up on CVE-2022-25636 [1], which happens nearby but is 
not exactly this issue.

Tks,
Joao

[1] - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

