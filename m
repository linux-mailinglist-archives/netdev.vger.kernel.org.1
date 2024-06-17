Return-Path: <netdev+bounces-104190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597790B774
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BB82837A9
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17A16A92E;
	Mon, 17 Jun 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjGP1Uvw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D316A927
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644048; cv=none; b=UsTzp6Nf9W1WFaYAYRqIuoMPBhdwt+WVcg3k+yRppzMiWnrNIUeOgRgz+ugzc9W2J5XnuFFNnnhK9UOhHT/MgVD8WHQhF5XDze1Es9nGpW610Q/ZYNwf0/aAlVORFytvq7WelVPUQaXqtj/lpalWMSbgPMSxIqMeBxECX5SViRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644048; c=relaxed/simple;
	bh=isAef4kyo+aqgSX5kMYIHyN6cxW5aJLQ92JaKXfmtkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fay+AnWQbTZXnupYHO87mpH+vvTIhMnBruS+KWfWRYxzc1G443OXCh6SUb4zxCJ7e1AmWl9N+o4UUh6QerZfDBtzcmtTYFe93FsC/NZIVrvVtOs8Vrb+lYZtlwCjmlewEs7/h9o8TLat21CfgPBY4Eh/zLgI+PB6rP01P+KPB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjGP1Uvw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718644045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0q3UoheA5039wyfgwL1xfkXawhxErq/3dVfP7AVeXQ=;
	b=AjGP1UvwpVmKgetTjvI3aJhjgXS7THGG/NyypUxAn2RczyHwwSjnLNHDOGw1jwRZ6I7zvd
	W0MDhxobDxh5kZbe3RAVLXpSyGHuDlhY4UWqVkWUTZVKAx0SlL83dgbTl1aRRrj3Tn1eYS
	2MCwmDkHCNioQpjopeQkdUUHunmDhR8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-g7cW8nOoOmK9fuDaVkw4Jg-1; Mon,
 17 Jun 2024 13:07:22 -0400
X-MC-Unique: g7cW8nOoOmK9fuDaVkw4Jg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DD3919560A7;
	Mon, 17 Jun 2024 17:07:19 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 496BD1956054;
	Mon, 17 Jun 2024 17:07:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  Stefano Brivio
 <sbrivio@redhat.com>,  Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [RFC net-next 3/7] selftests: openvswitch: Add set() and
 set_masked() support.
In-Reply-To: <CAG=2xmM_z28JA1hm_PxATrUxB96miqpVRT4-WO+MHfFeaYZwPg@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Mon, 17 Jun 2024 12:18:44
 +0000")
References: <20240613181333.984810-1-aconole@redhat.com>
	<20240613181333.984810-4-aconole@redhat.com>
	<CAG=2xmM_z28JA1hm_PxATrUxB96miqpVRT4-WO+MHfFeaYZwPg@mail.gmail.com>
Date: Mon, 17 Jun 2024 13:07:14 -0400
Message-ID: <f7tfrtbmrb1.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Thu, Jun 13, 2024 at 02:13:29PM GMT, Aaron Conole wrote:
>> These will be used in upcoming commits to set specific attributes for
>> interacting with tunnels.  Since set() will use the key parsing routine,=
 we
>> also make sure to prepend it with an open paren, for the action parsing =
to
>> properly understand it.
>>
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++++++++--
>>  1 file changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tool=
s/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 73768f3af6e5..fee64c31d4d4 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -284,7 +284,7 @@ class ovsactions(nla):
>>          ("OVS_ACTION_ATTR_UNSPEC", "none"),
>>          ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
>>          ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
>> -        ("OVS_ACTION_ATTR_SET", "none"),
>> +        ("OVS_ACTION_ATTR_SET", "ovskey"),
>>          ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
>>          ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
>>          ("OVS_ACTION_ATTR_SAMPLE", "none"),
>> @@ -292,7 +292,7 @@ class ovsactions(nla):
>>          ("OVS_ACTION_ATTR_HASH", "none"),
>>          ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
>>          ("OVS_ACTION_ATTR_POP_MPLS", "flag"),
>> -        ("OVS_ACTION_ATTR_SET_MASKED", "none"),
>> +        ("OVS_ACTION_ATTR_SET_MASKED", "ovskey"),
>>          ("OVS_ACTION_ATTR_CT", "ctact"),
>>          ("OVS_ACTION_ATTR_TRUNC", "uint32"),
>>          ("OVS_ACTION_ATTR_PUSH_ETH", "none"),
>> @@ -469,6 +469,14 @@ class ovsactions(nla):
>>                      print_str +=3D "clone("
>>                      print_str +=3D datum.dpstr(more)
>>                      print_str +=3D ")"
>> +                elif field[0] =3D=3D "OVS_ACTION_ATTR_SET" or \
>> +                     field[0] =3D=3D "OVS_ACTION_ATTR_SET_MASKED":
>> +                    print_str +=3D "set"
>> +                    if field[0] =3D=3D "OVS_ACTION_ATTR_SET_MASKED":
>> +                        print_str +=3D "_masked"
>> +                    print_str +=3D "("
>> +                    print_str +=3D datum.dpstr(more)
>> +                    print_str +=3D ")"
>>                  else:
>>                      try:
>>                          print_str +=3D datum.dpstr(more)
>> @@ -547,6 +555,25 @@ class ovsactions(nla):
>>                  self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
>>                  actstr =3D actstr[parsedLen:]
>>                  parsed =3D True
>> +            elif parse_starts_block(actstr, "set(", False):
>> +                parencount +=3D 1
>> +                k =3D ovskey()
>> +                actstr =3D actstr[len("set("):]
>> +                actstr =3D k.parse(actstr, None)
>> +                self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
>> +                if not actstr.startswith(")"):
>> +                    actstr =3D ")" + actstr
>> +                parsed =3D True
>> +            elif parse_starts_block(actstr, "set_masked(", False):
>> +                parencount +=3D 1
>> +                k =3D ovskey()
>> +                m =3D ovskey()
>> +                actstr =3D actstr[len("set_masked("):]
>> +                actstr =3D k.parse(actstr, m)
>> +                self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k,=
 m]))
>> +                if not actstr.startswith(")"):
>> +                    actstr =3D ")" + actstr
>> +                parsed =3D True
>>              elif parse_starts_block(actstr, "ct(", False):
>>                  parencount +=3D 1
>>                  actstr =3D actstr[len("ct(") :]
>> @@ -1312,7 +1339,7 @@ class ovskey(nla):
>>                  mask["attrs"].append([field[0], m])
>>              self["attrs"].append([field[0], k])
>>
>> -            flowstr =3D flowstr[strspn(flowstr, "),") :]
>> +            flowstr =3D flowstr[strspn(flowstr, "), ") :]
>>
>>          return flowstr
>>
>> @@ -1898,7 +1925,11 @@ class OvsFlow(GenericNetlinkSocket):
>>              ):
>>                  print_str +=3D "drop"
>>              else:
>> -                print_str +=3D actsmsg.dpstr(more)
>> +                if type(actsmsg) =3D=3D "list":
>
> nit: I belive the recommended way of comparing types is using
> "isinstance":
>
> https://www.flake8rules.com/rules/E721.html
>
> Also, I don't see what can make actmsg be a list. It should always be an
> instance of "ovsactions", right?

Yes, you're right.  This was some debug code that I was messing with and
it made it into this submission.  I've dropped it :)  Thanks for the review!

>
>> +                    for act in actsmsg:
>> +                        print_str +=3D act.dpstr(more)
>> +                else:
>> +                    print_str +=3D actsmsg.dpstr(more)
>>
>>              return print_str
>>
>> --
>> 2.45.1
>>


