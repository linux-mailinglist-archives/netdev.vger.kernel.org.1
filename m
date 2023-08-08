Return-Path: <netdev+bounces-25500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A37477455E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339E4281740
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036814F96;
	Tue,  8 Aug 2023 18:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626813AFA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:41:48 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD4E14B92F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:09:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E81E40004;
	Tue,  8 Aug 2023 18:09:19 +0000 (UTC)
Message-ID: <d3eb91d9-7ce5-8ac9-e718-4212ab838696@ovn.org>
Date: Tue, 8 Aug 2023 20:10:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Eric Garver <eric@garver.life>, aconole@redhat.com,
 dev@openvswitch.org
Content-Language: en-US
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20230807164551.553365-1-amorenoz@redhat.com>
 <20230807164551.553365-4-amorenoz@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [net-next v3 3/7] net: openvswitch: add explicit drop action
In-Reply-To: <20230807164551.553365-4-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/23 18:45, Adrian Moreno wrote:
> From: Eric Garver <eric@garver.life>
> 
> From: Eric Garver <eric@garver.life>
> 
> This adds an explicit drop action. This is used by OVS to drop packets
> for which it cannot determine what to do. An explicit action in the
> kernel allows passing the reason _why_ the packet is being dropped or
> zero to indicate no particular error happened (i.e: OVS intentionally
> dropped the packet).
> 
> Since the error codes coming from userspace mean nothing for the kernel,
> we squash all of them into only two drop reasons:
> - OVS_DROP_EXPLICIT_ACTION_ERROR to indicate a non-zero value was passed
> - OVS_DROP_EXPLICIT_ACTION to indicate a zero value was passed (no
>   error)
> 
> e.g. trace all OVS dropped skbs
> 
>  # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
>  [..]
>  106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
>   location:0xffffffffc0d9b462, protocol: 2048, reason: 196611)
> 
> reason: 196611 --> 0x30003 (OVS_DROP_EXPLICIT_ACTION)
> 
> Signed-off-by: Eric Garver <eric@garver.life>
> Co-developed-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/uapi/linux/openvswitch.h                     |  2 ++
>  net/openvswitch/actions.c                            |  9 +++++++++
>  net/openvswitch/drop.h                               |  2 ++
>  net/openvswitch/flow_netlink.c                       | 10 +++++++++-
>  tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  3 +++
>  5 files changed, 25 insertions(+), 1 deletion(-)

<snip>

> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
> index 3cd6489a5a2b..be51ff5039fb 100644
> --- a/net/openvswitch/drop.h
> +++ b/net/openvswitch/drop.h
> @@ -10,6 +10,8 @@
>  #define OVS_DROP_REASONS(R)			\
>  	R(OVS_DROP_FLOW)		        \
>  	R(OVS_DROP_ACTION_ERROR)		\
> +	R(OVS_DROP_EXPLICIT_ACTION)		\
> +	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\

These drop reasons are a bit unclear as well.  Especially since we
have OVS_DROP_ACTION_ERROR and OVS_DROP_EXPLICIT_ACTION_ERROR that
mean completely different things while having similar names.

Maybe remove the 'ACTION' part from these and add a word 'with'?
E.g. OVS_DROP_EXPLICIT and OVS_DROP_EXPLICIT_WITH_ERROR.  I suppose,
'WITH' can also be shortened to 'W'.  It's fairly obvious that
explicit drops are caused by the explicit drop action.

What do you think?

Best regards, Ilya Maximets.

