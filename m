Return-Path: <netdev+bounces-44672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4197D912E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D421F223B9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232D1401D;
	Fri, 27 Oct 2023 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A2RH0TTZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C313FF5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:21:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890501707
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rWLG7oGEz3mb7seEbO+Y/GRckIf+nT+0A/50EAXrgTk=; b=A2RH0TTZ4ghyr8bQ/W9XF2XuQV
	YeDRYw6x7J0uEzlrvD/rN/q57LlSeWdp6DwQ1A3QiSIUXJ/Fz8T+7hlN+UzmlXM2niSbVK0ANYM68
	QMtsUkQWI4Cx0C28nJ+EfTyOjEi4fUh7hCXXIQwnerzepKns4w6VKkKxwn1AOLGk6dfOHW8gZBpQ8
	csJ7jzoiSOzwTxyvaBQqGMVWVa/tRy609yZ2WUHiYBluurjH7UtMy2ew359PFIAo4rUcJY/Xb9SHq
	EOZ/sCqiyHLbcIolLbYmbzzECW2AP5GmYvSdibzF5h+VEA33BQj/V/ttpj93UJtZW1xvMCOVkLPkR
	e7rqmqTQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwI5a-0002NX-9y; Fri, 27 Oct 2023 10:21:06 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qwI5Z-000CCd-Nh; Fri, 27 Oct 2023 10:21:05 +0200
Subject: Re: [PATCH v4 net-next 2/6] cache: enforce cache groups
To: Jakub Kicinski <kuba@kernel.org>, Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231026081959.3477034-1-lixiaoyan@google.com>
 <20231026081959.3477034-3-lixiaoyan@google.com>
 <20231026071701.62237118@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9d3c7b53-a6f6-1a60-7c7e-a5f83e0e4ae9@iogearbox.net>
Date: Fri, 27 Oct 2023 10:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231026071701.62237118@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/26/23 4:17 PM, Jakub Kicinski wrote:
> On Thu, 26 Oct 2023 08:19:55 +0000 Coco Li wrote:
>> Set up build time warnings to safegaurd against future header changes
>> of organized structs.
> 
> TBH I had some doubts about the value of these asserts, I thought
> it was just me but I was talking to Vadim F and he brought up
> the same question.
> 
> IIUC these markings will protect us from people moving the members
> out of the cache lines. Does that actually happen?
> 
> It'd be less typing to assert the _size_ of each group, which protects
> from both moving out, and adding stuff haphazardly, which I'd guess is
> more common. Perhaps we should do that in addition?

Size would be good, I also had that in the prototype in [0], I think
blowing up the size is a bigger risk than moving existing members to
somewhere else in the struct, and this way it is kind of a forcing
factor to think deeper when this triggers, and helps in reviews hopefully
as well since it's an explicit change when the size is bumped. Having
this in addition would be nice imo.

Thanks,
Daniel

   [0] https://lore.kernel.org/netdev/50ca7bc1-e5c1-cb79-b2af-e5cd83b54dab@iogearbox.net/

