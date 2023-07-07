Return-Path: <netdev+bounces-16073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1574B4DB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B42281608
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538A107AD;
	Fri,  7 Jul 2023 16:03:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EA1FA7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 16:03:57 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943541BF4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 09:03:52 -0700 (PDT)
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD1BF60002;
	Fri,  7 Jul 2023 16:03:48 +0000 (UTC)
Message-ID: <dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
Date: Fri, 7 Jul 2023 18:04:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Eric Garver <eric@garver.life>,
 Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron <echaudro@redhat.com>
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life> <f7tr0plgpzb.fsf@redhat.com>
 <ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
 <6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
 <20230707080025.7739e499@kernel.org>
 <eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
In-Reply-To: <eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/7/23 17:29, Ilya Maximets wrote:
> On 7/7/23 17:00, Jakub Kicinski wrote:
>> On Fri, 7 Jul 2023 12:30:38 +0200 Ilya Maximets wrote:
>>> A wild idea:  How about we do not define actual reasons?  i.e. define a
>>> subsystem and just call kfree_skb_reason(skb, SUBSYSTEM | value), where
>>> 'value' is whatever userspace gives as long as it is within a subsystem
>>> range?
>>
>> That already exists, right? Johannes added it in the last release for WiFi.
> 
> I'm not sure.  The SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE behaves similarly
> to that on a surface.  However, looking closer, any value that can be passed
> into ieee80211_rx_handlers_result() and ends up in the kfree_skb_reason() is
> kind of defined in net/mac80211/drop.h, unless I'm missing something (very
> possible, because I don't really know wifi code).
> 
> The difference, I guess, is that for openvswitch values will be provided by
> the userpsace application via netlink interface.  It'll be just a number not
> defined anywhere in the kernel.  Only the subsystem itself will be defined
> in order to occupy the range.  Garbage in, same garbage out, from the kernel's
> perspective.

To be clear, I think, not defining them in this particular case is better.
Definition of every reason that userspace can come up with will add extra
uAPI maintenance cost/issues with no practical benefits.  Values are not
going to be used for anything outside reporting a drop reason and subsystem
offset is not part of uAPI anyway.

> 
> Best regards, Ilya Maximets.


