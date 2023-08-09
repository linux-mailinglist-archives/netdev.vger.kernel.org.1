Return-Path: <netdev+bounces-26072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE61E776B4B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D1D281209
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840DC1DDC9;
	Wed,  9 Aug 2023 21:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC81D2F1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:54:51 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F387A6;
	Wed,  9 Aug 2023 14:54:50 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
	id D932B587264C0; Wed,  9 Aug 2023 23:54:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id D6F4060D19E7B;
	Wed,  9 Aug 2023 23:54:48 +0200 (CEST)
Date: Wed, 9 Aug 2023 23:54:48 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: Justin Stitt <justinstitt@google.com>
cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, 
    Jozsef Kadlecsik <kadlec@netfilter.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
    Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org, 
    coreteam@netfilter.org, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
In-Reply-To: <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
Message-ID: <q49499n7-54p3-1soo-8s83-7p84724o08p7@vanv.qr>
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com> <20230809-net-netfilter-v2-1-5847d707ec0a@google.com> <20230809201926.GA3325@breakpoint.cc> <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Wednesday 2023-08-09 23:40, Justin Stitt wrote:
>On Wed, Aug 9, 2023 at 1:19 PM Florian Westphal <fw@strlen.de> wrote:
>>
>> Justin Stitt <justinstitt@google.com> wrote:
>> > Use `strscpy_pad` instead of `strncpy`.
>>
>> I don't think that any of these need zero-padding.
>It's a more consistent change with the rest of the series and I don't
>believe it has much different behavior to `strncpy` (other than
>NUL-termination) as that will continue to pad to `n` as well.
>
>Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
>`strscpy` in a v3? I really am shooting in the dark as it is quite
>hard to tell whether or not a buffer is expected to be NUL-padded or
>not.

I don't recall either NF userspace or kernelspace code doing memcmp
with name-like fields, so padding should not be strictly needed.

