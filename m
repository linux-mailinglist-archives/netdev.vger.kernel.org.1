Return-Path: <netdev+bounces-24238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DC76F643
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 01:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8222823CC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 23:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46726B25;
	Thu,  3 Aug 2023 23:48:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8E26B22
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 23:48:31 +0000 (UTC)
Received: from out-81.mta0.migadu.com (out-81.mta0.migadu.com [IPv6:2001:41d0:1004:224b::51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E91BF1
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:48:30 -0700 (PDT)
Message-ID: <5247bfae-c0fc-99e0-04a4-55e2019bfdc7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691106508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yh7cEAAoEojDSUioTX5psDqv/nU/SkbIlB8fNvpkcFM=;
	b=XiW7JVsONnptJ4uHqkfUxVi2rj32t6jBi3aDj6IczCbqO2pMBMLNUL4i6C8O6wyt0/0Guw
	uwxOTh79P0eOSoI30Koj+yR1XtaBd5zwqRkbP/Ez9M/aZtfKlRV+y0y9LdmxV2m9Sc2A7F
	JkSw9QhkpLQ2F5uvsa82s5lnj45NYUs=
Date: Thu, 3 Aug 2023 16:48:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
Content-Language: en-US
To: Gal Pressman <gal@nvidia.com>
Cc: kuba@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
 <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/3/23 4:10 AM, Gal Pressman wrote:
> On 22/07/2023 2:33, Daniel Borkmann wrote:
>> On qdisc destruction, the ingress_destroy() needs to update the correct
>> entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
>> Therefore, fix the typo.
>>
>> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
>> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
>> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
>> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> Hi Daniel,
> 
> Our nightly regression testing picked up new memory leaks which were
> bisected to this commit.

Thanks for the report. Can you help to check if it can be reproduced with the 
latest net-next which has a tcx fix in commit 079082c60aff ("tcx: Fix splat 
during dev unregister")?


