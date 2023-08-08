Return-Path: <netdev+bounces-25489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE217743DC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D72280D2E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075131DA54;
	Tue,  8 Aug 2023 18:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050891C9E1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3C125A8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:01:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C918BFF803;
	Tue,  8 Aug 2023 18:01:42 +0000 (UTC)
Message-ID: <40427d41-dc23-e777-4536-6bd0a8c1cb33@ovn.org>
Date: Tue, 8 Aug 2023 20:02:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, aconole@redhat.com, eric@garver.life,
 dev@openvswitch.org
Content-Language: en-US
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20230807164551.553365-1-amorenoz@redhat.com>
 <20230807164551.553365-2-amorenoz@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [net-next v3 1/7] net: openvswitch: add datapath flow drop reason
In-Reply-To: <20230807164551.553365-2-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/23 18:45, Adrian Moreno wrote:
> Create a new drop reason subsystem for openvswitch and add the first
> drop reason to represent flow drops.
> 
> A flow drop happens when a flow has an empty action-set or there is no
> action that consumes the packet (output, userspace, recirc, etc).
> 
> Implementation-wise, most of these skb-consuming actions already call
> "consume_skb" internally and return directly from within the
> do_execute_actions() loop so with minimal changes we can assume that
> any skb that exits the loop normally is a packet drop.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/net/dropreason.h   |  6 ++++++
>  net/openvswitch/actions.c  | 12 ++++++++++--
>  net/openvswitch/datapath.c | 16 ++++++++++++++++
>  net/openvswitch/drop.h     | 24 ++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 2 deletions(-)
>  create mode 100644 net/openvswitch/drop.h

<snip>

> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
> new file mode 100644
> index 000000000000..cdd10629c6be
> --- /dev/null
> +++ b/net/openvswitch/drop.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * OpenvSwitch drop reason list.
> + */
> +
> +#ifndef OPENVSWITCH_DROP_H
> +#define OPENVSWITCH_DROP_H
> +#include <net/dropreason.h>
> +
> +#define OVS_DROP_REASONS(R)			\
> +	R(OVS_DROP_FLOW)		        \

Hi, Adrian.  Not a full review, just complaining about names. :)

The OVS_DROP_FLOW seems a bit confusing and unclear.  A "flow drop"
is also a strange term to use.  Maybe we can somehow express in the
name that this drop reason is used when there are no actions left
to execute?  e.g. OVS_DROP_NO_MORE_ACTIONS or OVS_DROP_LAST_ACTION
or OVS_DROP_END_OF_ACTION_LIST or something of that sort?  These may
seem long, but they are not longer than some other names introduced
later in the set.  What do yo think?

Best regards, Ilya Maximets.

