Return-Path: <netdev+bounces-30204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313547865D6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 05:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A610E28142E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010C24527;
	Thu, 24 Aug 2023 03:31:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6324521
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D95C433C7;
	Thu, 24 Aug 2023 03:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692847882;
	bh=2MxDhV6CHEltlY23Xu4O5PADIqsFvP60GAhGKOsthbM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ind9fMCZOuF0I/Zri5pudAvh2EZZ2MqNKvNno6SYRbtDwJuQw2Wn6TaU2ergX2AP3
	 c0Ngv0sIvTN8Zi/a7Lgb2SW3GZsy5DN5qvAZVgtK6YrOodWk8YkzlxnrE7fZtf9X3N
	 rrkyRuGjeXCh22ckIKaAUc0I7S19PZpv9K3PMYqOg0F2UgvaLd/zn8z+3i+3wB0Ha3
	 ZNk3usAGueU6+nr42Tw+lFBdviThU8sD5OnZgwaEOTG4j7sQ4Nj/HHdZ6p1p5+xKpE
	 ZwlhlUkFYVi+njp9/b0nfKm2MJ0sFZ9mWZ+gVO7CJJwWyz5+6PeeZJ4yCHHWifTu+o
	 N6vQl8Rgpp/PA==
Message-ID: <90a27f82-ff90-f8ce-ccf3-e1d8909b744d@kernel.org>
Date: Wed, 23 Aug 2023 20:31:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Content-Language: en-US
To: Gal Pressman <gal@nvidia.com>, Richard Gobert <richardbgobert@gmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, aleksander.lobakin@intel.com, lixiaoyan@google.com,
 lucien.xin@gmail.com, alexanderduyck@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
 <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
 <b45cedc6-3dbe-5cbb-1938-5c33cf9fc70d@kernel.org>
 <d4cc1576-f4c3-a074-9bf4-937cdd3ff56d@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <d4cc1576-f4c3-a074-9bf4-937cdd3ff56d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/23/23 7:43 AM, Gal Pressman wrote:
>> With veth and namespaces I expect up to 25-30G performance levels,
>> depending on the test. When something fundamental breaks like this patch
>> a drop to < 1G would be a red flag, so there is value to the test.
> Circling back to this, I believe such test already exists:
> tools/testing/selftests/net/udpgro_fwd.sh
> 
> And it indeed fails before Richard's fix.
> 
> I guess all that's left is to actually run these tests 😄?

hmmm... if that is the case, the Makefile shows:

TEST_PROGS += udpgro_fwd.sh

so it should be run. I wonder why one of the many bots did not flag it.

