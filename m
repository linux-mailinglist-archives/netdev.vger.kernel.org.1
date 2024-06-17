Return-Path: <netdev+bounces-104203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452190B89D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1C31F2553A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511919049C;
	Mon, 17 Jun 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R01Bzq0p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFC16CD3D
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647018; cv=none; b=YF30G3w8mFlXl0DfoZdA+LUv0lv85U2Oqupflu2EVyoHMDuWLn6hSiFpAKdheLFkmABPwciuc7IRet9Rjc8+3TuI7O3uG7W5q1bmX6RH4oRELqV5tLw/NNA18Hf6V3e5OgCg12ISMzq0B4KAqE5BuhbCCKlt6CnsBs5oKFeQO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647018; c=relaxed/simple;
	bh=YgElG/kLYYqsxODcHai0Njk6U1Rwapx3rdtvB7AtEUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YOA38b9VgpIi72fcNmTPNtYFGZHslET06r6h8fDyLmxtAgA1dwkgtJg4OvQEnnzwS3k11lCmu2bsfV28+4t5ySkW8tq9+iONyL3hKJ2lrRzX040v7uKRCh/NV42naQmwwneeM6P9OPSIAKSX8pFTXrJGO2qiZJvhDk2tDtgKWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R01Bzq0p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3+RmOlksDfTAFqNkTKQ0MNP70H7CNovcQRO+KHXRTU=;
	b=R01Bzq0pQGu5TSbpigvr9hw3/jdaBEUFbKGznmH/FPfulOqsGfzFngpgXGmdSI/IxBBx5P
	YzLYPMiKxtpZc7sPi9waL7+lU/5T3z2injEJNSIbvPdrBBikIR3wT+wIxW3o99vipuKYeO
	bRXVwvHnBxbsp6DA7/iX4c6Bu6jr7dk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-fOJ4-S3DPlaZpk_sfowdOQ-1; Mon,
 17 Jun 2024 13:56:52 -0400
X-MC-Unique: fOJ4-S3DPlaZpk_sfowdOQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D82E19560B8;
	Mon, 17 Jun 2024 17:56:51 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB141956087;
	Mon, 17 Jun 2024 17:56:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  Ilya Maximets <i.maximets@ovn.org>,
  Stefano Brivio <sbrivio@redhat.com>,  Eric Dumazet <edumazet@google.com>,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  "David
 S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 4/7] selftests: openvswitch: Add
 support for tunnel() key.
In-Reply-To: <20240616162743.GJ8447@kernel.org> (Simon Horman's message of
	"Sun, 16 Jun 2024 17:27:43 +0100")
References: <20240613181333.984810-1-aconole@redhat.com>
	<20240613181333.984810-5-aconole@redhat.com>
	<20240616162743.GJ8447@kernel.org>
Date: Mon, 17 Jun 2024 13:56:46 -0400
Message-ID: <f7t7cenmp0h.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Simon Horman <horms@kernel.org> writes:

> On Thu, Jun 13, 2024 at 02:13:30PM -0400, Aaron Conole wrote:
>> This will be used when setting details about the tunnel to use as
>> transport.  There is a difference between the ODP format between tunnel():
>> the 'key' flag is not actually a flag field, so we don't support it in the
>> same way that the vswitchd userspace supports displaying it.
>> 
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>
> ...
>
>> @@ -1265,6 +1265,165 @@ class ovskey(nla):
>>                  init=init,
>>              )
>>  
>> +    class ovs_key_tunnel(nla):
>> +        nla_flags = NLA_F_NESTED
>> +
>> +        nla_map = (
>> +            ("OVS_TUNNEL_KEY_ATTR_ID", "be64"),
>> +            ("OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "ipaddr"),
>> +            ("OVS_TUNNEL_KEY_ATTR_IPV4_DST", "ipaddr"),
>> +            ("OVS_TUNNEL_KEY_ATTR_TOS", "uint8"),
>> +            ("OVS_TUNNEL_KEY_ATTR_TTL", "uint8"),
>> +            ("OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT", "flag"),
>> +            ("OVS_TUNNEL_KEY_ATTR_CSUM", "flag"),
>> +            ("OVS_TUNNEL_KEY_ATTR_OAM", "flag"),
>> +            ("OVS_TUNNEL_KEY_ATTR_GENEVE_OPTS", "array(uint32)"),
>> +            ("OVS_TUNNEL_KEY_ATTR_TP_SRC", "be16"),
>> +            ("OVS_TUNNEL_KEY_ATTR_TP_DST", "be16"),
>> +            ("OVS_TUNNEL_KEY_ATTR_VXLAN_OPTS", "none"),
>> +            ("OVS_TUNNEL_KEY_ATTR_IPV6_SRC", "ipaddr"),
>> +            ("OVS_TUNNEL_KEY_ATTR_IPV6_DST", "ipaddr"),
>> +            ("OVS_TUNNEL_KEY_ATTR_PAD", "none"),
>> +            ("OVS_TUNNEL_KEY_ATTR_ERSPAN_OPTS", "none"),
>> +            ("OVS_TUNNEL_KEY_ATTR_IPV4_INFO_BRIDGE", "flag"),
>> +        )
>> +
>> +        def parse(self, flowstr, mask=None):
>> +            if not flowstr.startswith("tunnel("):
>> +                return None, None
>> +
>> +            k = ovskey.ovs_key_tunnel()
>> +            if mask is not None:
>> +                mask = ovskey.ovs_key_tunnel()
>> +
>> +            flowstr = flowstr[len("tunnel("):]
>> +
>> +            v6_address = None
>> +
>> +            fields = [
>> +                ("tun_id=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_ID",
>> +                 0xffffffffffffffff, None, None),
>> +
>> +                ("src=", r"([0-9a-fA-F\.]+)", str,
>> +                 "OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "255.255.255.255", "0.0.0.0",
>> +                 False),
>> +                ("dst=", r"([0-9a-fA-F\.]+)", str,
>> +                 "OVS_TUNNEL_KEY_ATTR_IPV4_DST", "255.255.255.255", "0.0.0.0",
>> +                 False),
>> +
>> +                ("ipv6_src=", r"([0-9a-fA-F:]+)", str,
>> +                 "OVS_TUNNEL_KEY_ATTR_IPV6_SRC",
>> +                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
>> +                ("ipv6_dst=", r"([0-9a-fA-F:]+)", str,
>> +                 "OVS_TUNNEL_KEY_ATTR_IPV6_DST",
>> +                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
>> +
>> +                ("tos=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TOS", 255, 0,
>> +                 None),
>> +                ("ttl=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TTL", 255, 0,
>> +                 None),
>> +
>> +                ("tp_src=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_SRC",
>> +                 65535, 0, None),
>> +                ("tp_dst=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_DST",
>> +                 65535, 0, None),
>> +            ]
>> +
>> +            forced_include = ["OVS_TUNNEL_KEY_ATTR_TTL"]
>> +
>> +            for prefix, regex, typ, attr_name, mask_val, default_val, v46_flag in fields:
>> +                flowstr, value = parse_extract_field(flowstr, prefix, regex, typ, False)
>> +                if not attr_name:
>> +                    raise Exception("Bad list value in tunnel fields")
>> +
>> +                if value is None and attr_name in forced_include:
>> +                    value = default_val
>> +                    mask_val = default_val
>> +
>> +                if value is not None:
>> +                    if v6_address is None and v46_flag is not None:
>> +                        v6_address = v46_flag
>
> By my reading, at this point v6_address will only be None if v46_flag is
> not None.  IF so, the condition below seems excessive.

Agreed - thanks for the suggestions.

>> +                    if v6_address is not None and v46_flag is not None \
>> +                       and v46_flag != v6_address:
>> +                        raise ValueError("Cannot mix v6 and v4 addresses")
>
> I wonder if we can instead express this as (completely untested!):
>
>                     if v46_flag is not None:
>                         if v6_address is None:
>                             v6_address = v46_flag
>                         if v46_flag != v6_address:
>                             raise ValueError("Cannot mix v6 and v4 addresses")
>
>> +                    k["attrs"].append([attr_name, value])
>> +                    if mask is not None:
>> +                        mask["attrs"].append([attr_name, mask_val])
>> +                else:
>> +                    if v6_address is not None and v46_flag is not None \
>> +                       and v46_flag != v6_address:
>> +                        continue
>> +                    if v6_address is None and v46_flag is not None:
>> +                        continue
>
> And I wonder if this is a bit easier on the eyes (also completely untested):
>
>                     if v46_flag is not None:
>                         if v6_address is None or v46_flag != v6_address:
>                             continue

I folded both of these in and did some quick testing.  Thanks Simon!

>> +                    if mask is not None:
>> +                        mask["attrs"].append([attr_name, default_val])
>> +
>> +            if k["attrs"][0][0] != "OVS_TUNNEL_KEY_ATTR_ID":
>> +                raise ValueError("Needs a tunid set")
>
> ...
>
>> @@ -1745,7 +1905,7 @@ class OvsVport(GenericNetlinkSocket):
>>          )
>>  
>>          TUNNEL_DEFAULTS = [("geneve", 6081),
>> -                           ("vxlan", 4798)]
>> +                           ("vxlan", 4789)]
>>  
>>          for tnl in TUNNEL_DEFAULTS:
>>              if ptype == tnl[0]:
>
> As noted in my response to PATCH 1/7, I think that the
> change in the hunk above belongs there rather than here.


