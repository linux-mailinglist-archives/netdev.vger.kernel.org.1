Return-Path: <netdev+bounces-36960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030027B2A65
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 04:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 294A1282040
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC053187E;
	Fri, 29 Sep 2023 02:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC417D5
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:53:23 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11D1A1;
	Thu, 28 Sep 2023 19:53:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 19D8B20002;
	Fri, 29 Sep 2023 02:53:14 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Sep 2023 19:53:14 -0700
From: Joao Moreira <joao@overdrivepizza.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kadlec@netfilter.org,
 fw@strlen.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rkannoth@marvell.com, wojciech.drewek@intel.com,
 steen.hegenlund@microhip.com, keescook@chromium.org, Joao Moreira
 <joao.moreira@intel.com>
Subject: Re: [PATCH v3 1/2] Make loop indexes unsigned
In-Reply-To: <ZRWCPTVd7b6+a7N5@calendula>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
 <20230927164715.76744-2-joao@overdrivepizza.com>
 <ZRWCPTVd7b6+a7N5@calendula>
Message-ID: <77df92a5627411471f1f374d41ae500c@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: joao@overdrivepizza.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-28 06:40, Pablo Neira Ayuso wrote:
> On Wed, Sep 27, 2023 at 09:47:14AM -0700, joao@overdrivepizza.com 
> wrote:
>> From: Joao Moreira <joao.moreira@intel.com>
>> 
>> Both flow_rule_alloc and offload_action_alloc functions received an
>> unsigned num_actions parameters which are then operated within a loop.
>> The index of this loop is declared as a signed int. If it was possible
>> to pass a large enough num_actions to these functions, it would lead 
>> to
>> an out of bounds write.
>> 
>> After checking with maintainers, it was mentioned that front-end will
>> cap the num_actions value and that it is not possible to reach this
>> function with such a large number. Yet, for correctness, it is still
>> better to fix this.
>> 
>> This issue was observed by the commit author while reviewing a 
>> write-up
>> regarding a CVE within the same subsystem [1].
>> 
>> 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/
>> 
>> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
>> ---
>>  net/core/flow_offload.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
>> index bc5169482710..bc3f53a09d8f 100644
>> --- a/net/core/flow_offload.c
>> +++ b/net/core/flow_offload.c
>> @@ -10,7 +10,7 @@
>>  struct flow_rule *flow_rule_alloc(unsigned int num_actions)
>>  {
>>  	struct flow_rule *rule;
>> -	int i;
>> +	unsigned int i;
> 
> With the 2^8 cap, I don't think this patch is required anymore.

Hm. While I understand that there is not a significant menace haunting 
this... would it be good for (1) type correctness and (2) prevent that 
things blow up if something changes and someone misses this spot?

> 
>> 
>>  	rule = kzalloc(struct_size(rule, action.entries, num_actions),
>>  		       GFP_KERNEL);
>> @@ -31,7 +31,7 @@ EXPORT_SYMBOL(flow_rule_alloc);
>>  struct flow_offload_action *offload_action_alloc(unsigned int 
>> num_actions)
>>  {
>>  	struct flow_offload_action *fl_action;
>> -	int i;
>> +	unsigned int i;
>> 
>>  	fl_action = kzalloc(struct_size(fl_action, action.entries, 
>> num_actions),
>>  			    GFP_KERNEL);
>> --
>> 2.42.0
>> 

