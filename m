Return-Path: <netdev+bounces-69526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878684B894
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3628A3CD
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA5133282;
	Tue,  6 Feb 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz+RpzaC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B254132C39
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231309; cv=none; b=pQIPbBpBUtQXrL6qmrFhOEPkk/3fj/F+wUF1MdDJR6wOZPJrFvjVUAbx5ink7K42YXgqRsyxx2kMuJZffThcUnD4NCS+VIFzw6VHGscAwFTL2WwtfbiX5qiXf/AssLO+jrVl9N2tP9PcLUGCiiOlyeQVX/CpZ4dyr65tXbCZ5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231309; c=relaxed/simple;
	bh=J2Iwsw50HM4rVWDjQYtxgyHosTnC5CwIc0dI4OjzNek=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Fj3N3OGjtVamGJ52zy0juBHGpxvZo8OoduOAN+MLAdJt7K36ANdNcgYtf3FwhQv8qzzfFWyO/r46dtfe7iGojWQ5P8VPuApGjpNiMsIswMuIFTCtrxy7HAyr9CxByaKnCsWsxZLKLP2GifSXzKuhz/CDFxquKwIGQM5+9FLwXmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz+RpzaC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707231307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3vZHgUpt0p6yFhyXj5/IyI1SqXWcftyZpTnq4n/RIM=;
	b=bz+RpzaCk4+oW+I+PID5CPRDK8s/fV5ZqLnSuYTXa1cc73mJa2zMi/1QpesMCR7kJfoeWs
	SMEuGEL0UcQSIWyxhMCjcnqyOc9AM/0VlS4dEbWYEhZIbGXZNwNsfkTSNqZ7aO5K2gz7De
	BKVb0dbWqpFeF7+rw+eF2HC8GFH1bE4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-8b1w0mhMObmBvppyXNz17w-1; Tue,
 06 Feb 2024 09:55:04 -0500
X-MC-Unique: 8b1w0mhMObmBvppyXNz17w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 433643C23FC8;
	Tue,  6 Feb 2024 14:55:04 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EDFBD4015465;
	Tue,  6 Feb 2024 14:55:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B
 Shelar <pshelar@ovn.org>,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  Simon Horman <horms@ovn.org>,  Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [PATCH net 1/2] net: openvswitch: limit the number of
 recursions from action sets
References: <20240206131147.1286530-1-aconole@redhat.com>
	<20240206131147.1286530-2-aconole@redhat.com>
	<CANn89iLeKwk3Pc796V7Vgvm8-GLifbwimPJsDTudBZG-1kVAMg@mail.gmail.com>
Date: Tue, 06 Feb 2024 09:55:03 -0500
In-Reply-To: <CANn89iLeKwk3Pc796V7Vgvm8-GLifbwimPJsDTudBZG-1kVAMg@mail.gmail.com>
	(Eric Dumazet's message of "Tue, 6 Feb 2024 15:30:47 +0100")
Message-ID: <f7t5xz1k5h4.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Eric Dumazet <edumazet@google.com> writes:

> On Tue, Feb 6, 2024 at 2:11=E2=80=AFPM Aaron Conole <aconole@redhat.com> =
wrote:
>>
>> The ovs module allows for some actions to recursively contain an action
>> list for complex scenarios, such as sampling, checking lengths, etc.
>> When these actions are copied into the internal flow table, they are
>> evaluated to validate that such actions make sense, and these calls
>> happen recursively.
>>
>> The ovs-vswitchd userspace won't emit more than 16 recursion levels
>> deep.  However, the module has no such limit and will happily accept
>> limits larger than 16 levels nested.  Prevent this by tracking the
>> number of recursions happening and manually limiting it to 16 levels
>> nested.
>>
>> The initial implementation of the sample action would track this depth
>> and prevent more than 3 levels of recursion, but this was removed to
>> support the clone use case, rather than limited at the current userspace
>> limit.
>>
>> Fixes: 798c166173ff ("openvswitch: Optimize sample action for the clone =
use cases")
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  net/openvswitch/flow_netlink.c | 33 ++++++++++++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netli=
nk.c
>> index 88965e2068ac..ba5cfa67a720 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -48,6 +48,9 @@ struct ovs_len_tbl {
>>
>>  #define OVS_ATTR_NESTED -1
>>  #define OVS_ATTR_VARIABLE -2
>> +#define OVS_COPY_ACTIONS_MAX_DEPTH 16
>> +
>> +static DEFINE_PER_CPU(int, copy_actions_depth);
>>
>>  static bool actions_may_change_flow(const struct nlattr *actions)
>>  {
>> @@ -3148,11 +3151,11 @@ static int copy_action(const struct nlattr *from,
>>         return 0;
>>  }
>>
>> -static int __ovs_nla_copy_actions(struct net *net, const struct nlattr =
*attr,
>> -                                 const struct sw_flow_key *key,
>> -                                 struct sw_flow_actions **sfa,
>> -                                 __be16 eth_type, __be16 vlan_tci,
>> -                                 u32 mpls_label_count, bool log)
>> +static int ___ovs_nla_copy_actions(struct net *net, const struct nlattr=
 *attr,
>> +                                  const struct sw_flow_key *key,
>> +                                  struct sw_flow_actions **sfa,
>> +                                  __be16 eth_type, __be16 vlan_tci,
>> +                                  u32 mpls_label_count, bool log)
>>  {
>>         u8 mac_proto =3D ovs_key_mac_proto(key);
>>         const struct nlattr *a;
>> @@ -3478,6 +3481,26 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
>>         return 0;
>>  }
>>
>> +static int __ovs_nla_copy_actions(struct net *net, const struct nlattr =
*attr,
>> +                                 const struct sw_flow_key *key,
>> +                                 struct sw_flow_actions **sfa,
>> +                                 __be16 eth_type, __be16 vlan_tci,
>> +                                 u32 mpls_label_count, bool log)
>> +{
>> +       int level =3D this_cpu_read(copy_actions_depth);
>> +       int ret;
>> +
>> +       if (level > OVS_COPY_ACTIONS_MAX_DEPTH)
>> +               return -EOVERFLOW;
>> +
>
> This code seems to run in process context.
>
> Using per cpu limit would not work, unless you disabled migration ?

Oops - I didn't consider it.

Given that, maybe the best approach would not to rely on per-cpu
counter. I'll respin in the next series with a depth counter that I pass
to the function instead and compare that.  I guess that should address
migration and eliminate the need for per-cpu counter.

Does it make sense?

>> +       __this_cpu_inc(copy_actions_depth);
>> +       ret =3D ___ovs_nla_copy_actions(net, attr, key, sfa, eth_type,
>> +                                     vlan_tci, mpls_label_count, log);
>> +       __this_cpu_dec(copy_actions_depth);
>> +
>> +       return ret;
>> +}
>> +
>>  /* 'key' must be the masked key. */
>>  int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>                          const struct sw_flow_key *key,
>> --
>> 2.41.0
>>


