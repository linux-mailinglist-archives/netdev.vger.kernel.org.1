Return-Path: <netdev+bounces-23011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF476A63B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23851C20DD4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA2815;
	Tue,  1 Aug 2023 01:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887197E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:22:58 +0000 (UTC)
Received: from out-102.mta1.migadu.com (out-102.mta1.migadu.com [IPv6:2001:41d0:203:375::66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B310D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:22:57 -0700 (PDT)
Message-ID: <4421c143-0295-8e82-1ccf-f2acfadb2a3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690852975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6rCJdjq5ipx/cW8vDq+lTsukuUKbUzQHMFtEytYyYw=;
	b=SZ+XrceBOKutNtmCihypVF2AlqwvfsVaY8kIqBYr8SAIRzPly+lmLsWLtaYqJlA1cseKMt
	4i+j1nBANWQO9wnqEv5rSRU0rJ8P7Ejq6+2EMJ+OYBmJuqht3mw75s+zQaTeG9yLBIy46n
	Fku4p/JgahCniz/NcWEc1LBVjrsfCpg=
Date: Mon, 31 Jul 2023 18:22:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix bug that strp_done cannot be called
Content-Language: en-US
To: Xu Kuohai <xukuohai@huaweicloud.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20230728105717.3978849-1-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230728105717.3978849-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/23 3:57 AM, Xu Kuohai wrote:
> strp_done is only called when psock->progs.stream_parser is not NULL,
> but stream_parser was set to NULL by sk_psock_stop_strp(), called
> by sk_psock_drop() earlier. So, strp_done can never be called.
> 
> Introduce SK_PSOCK_RX_ENABLED to mark whether there is strp on psock.
> Change the condition for calling strp_done from judging whether
> stream_parser is set to judging whether this flag is set. This flag is
> only set once when strp_init() succeeds, and will never be cleared later.

John, please help to review.

