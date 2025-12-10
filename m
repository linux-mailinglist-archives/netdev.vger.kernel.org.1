Return-Path: <netdev+bounces-244264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFD9CB352E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D8C30181AA
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA12C2364;
	Wed, 10 Dec 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQfPExCV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ozB+amrh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877526AC3
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380624; cv=none; b=QAHH97uMpnMpC8JFdg3PTiJCwKBstRc3DbEkfGp68Jzf/oi4XblSMuZ4aCHQma4uzmeknm3aOqSOI9XsDsClWLX9DLm9p+TRpfxfNLxDWuuuSI2Jy20gREsNyCvkdeYvSZp/I2r4SNxr2iVNwHyOjaKBRvPSFdqi0vPvvOFaNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380624; c=relaxed/simple;
	bh=fKgiC27aXeEwEkJURDyda9hjIhsUz/XBgD0oxk0l2iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lgl19xOQS20uncTca7Eys/BvM7EaBnFAL+Iz2qroIc7NVnuKmmlpK/11qCL+lc7q6Ld3VUg78U8ZbldGcphjnhhyJSvSs1VDvz+bW15F+xAcVyfbKNMpWJ9U+jQW2v6U+oHT5uMlUTOV9oVotOV1Hn2SF6DWOGzklU/caYk2PhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQfPExCV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ozB+amrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765380622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+wsmW4VR7unE39vBofZpv46RyheC0as+jLhnNV6VxY=;
	b=TQfPExCVGsgd6Bqn8lhFuX9lccIFAEOCa7dLaPoayBf0JgLLO4BISmWXa337I7dg0n1jpS
	p1+Afp4fUS+bVuL+JFbEZzYWXsE0hW2KXvncDL9Ua1MHtrMjvGLy+VFZJx9t5nJdIFyMr9
	ySEvSde8AxTXyoxSggtntOsu5laSilA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-eIAWOh-tPKagROXAonFIAw-1; Wed, 10 Dec 2025 10:30:18 -0500
X-MC-Unique: eIAWOh-tPKagROXAonFIAw-1
X-Mimecast-MFC-AGG-ID: eIAWOh-tPKagROXAonFIAw_1765380617
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-649783da905so1428206a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765380617; x=1765985417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+wsmW4VR7unE39vBofZpv46RyheC0as+jLhnNV6VxY=;
        b=ozB+amrho6eXO9ykd/DvgWAzpPKaeiMHc4yyUWg86fpvh5kgNi6oU2VLFHDdEoIvVj
         qTOQ0B4B9IMbfbiA1a2imxDRmqIP8QmW8CT1TsWUm0KOcmxH7f+oBbrSTBmD5yDi/Net
         mWI6atliUF9RnSChG1FL8vfvxQpp7DWTdoFUoIhYWZk5F5Et+gcbQquqw3OXbIoOgGaD
         AOUKy9mK1dXWgkzC32E66L0KyRq2z2LUr0P/ORTIVc7qd+p60cWnsiembxVtnbKS9PIP
         qaqgOnwixg/kv+lg+t+KOhbmfA8v05BAQJxhZPBvRaL4j8GyccmkHRtuCgDFgkQ3NByq
         xvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380617; x=1765985417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+wsmW4VR7unE39vBofZpv46RyheC0as+jLhnNV6VxY=;
        b=W/Iesfkj3Shx09cPJM4/LrZWaR4KRqXqA94x0tmyrscwJH4y9lOZQFd1XoU7tq7STJ
         txgTtFhm/5cIE3jm0IsTyBSiDtjC2Im8HBnHaip8qjegYiGO8CCMKylgLa6cFXGC6kZf
         SUyOnnxzuK8BvelQ9lOzHqP7Dkni7sux52PufoOtoUz7HYudWfckV7BZxRRI28LHHboQ
         fTFK3AfhiIztXQzXTVO/7z3sm9I9bkTeBgv1RG+pvWeG2LQPTZdX9VlmMABHHqW3bpJ+
         PJ+Q5NuJzCPph0Mr3X54ub1uHl6N5CHHWKGEe2Pqgm+H7imXVqyCWrnIlwGmUQOcQ3lt
         borA==
X-Forwarded-Encrypted: i=1; AJvYcCVDNionjxHWU4YEE7lydeAnH8x5RhRKp9lopVujaKA1rqAeOX1vVkYnpIvO8xCXsAsXivrPPbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgJr0C4VvpTQIbb9LEJdRAVUDAc1+5aLX4bUykdkTkCcNVPxc
	uABY9qxg3/O9VX/CQMp72DSeedIWYuUwFjXFZIFujEK5OqSJceJRT/6kjivWS9YS5wSn1WdgTdf
	I7jAp5X749k5LUb28pQlRTeiXKXmcvRVfoRFC02DJWcuFl5QzibpYGNQLPFznZ3x94w==
X-Gm-Gg: AY/fxX7W7T0XqUpysv+6cYkg9nT5IdRslPwHF0xX4mxB6X9oKE7mqYOPlA3vrPTvzzW
	qUSxfkiIahG+SZ7PgkUpLjhtn5BRyEGMXkfW/mre3VnPiyOO1RBhz2+UwG7O1SuW0CMXJZYOK0/
	aNVyCIvIhaj9xCu+DBCuJMdHlwFhG6RLuxbML+/r+u4Jo2gYB5XiN3fVcvJkoMS+yKKdpvGtj4D
	goGCsjoVs64CJrf/ij4ufpjprPhJ8IzhYN9WArbKSGZUyLOhVvy/zc0pLALzfc4icojtnLkhVUv
	PJ4vsW2Hl/Mk7z4KhG4+zgfESgWzBZx0+jpDIchI1Nvb0QOMLh3SldVb3znEyFztvnehCoIlph4
	2mtGmywvX6iqUkeSPzwbioZ4pqsXWofN548V+4zhYGpUhIc8wJ4lCNPh821Q=
X-Received: by 2002:a17:906:6a04:b0:b76:7e0e:4246 with SMTP id a640c23a62f3a-b7ce823a7edmr324760566b.12.1765380616949;
        Wed, 10 Dec 2025 07:30:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+n1oLk+lpYvSo3oxC/+zi9Dq/Bhke/wTJsYnKmfJeBSv2/uWajl8IxLNhM4rQIwoesrPtug==
X-Received: by 2002:a17:906:6a04:b0:b76:7e0e:4246 with SMTP id a640c23a62f3a-b7ce823a7edmr324755166b.12.1765380616407;
        Wed, 10 Dec 2025 07:30:16 -0800 (PST)
Received: from [10.45.225.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64956402185sm6637761a12.25.2025.12.10.07.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2025 07:30:15 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: =?utf-8?q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
Cc: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
Date: Wed, 10 Dec 2025 16:30:13 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <7C74F561-F12F-4683-9D99-0A086D098938@redhat.com>
In-Reply-To: <CAG=2xmOib02j-fwoKtCYgrovdE3FZkW__hiE=v0PuGkGzJvvBQ@mail.gmail.com>
References: <20251210125945.211350-1-toke@redhat.com>
 <B299AD16-8511-41B7-A36A-25B911AEEBF4@redhat.com>
 <CAG=2xmOib02j-fwoKtCYgrovdE3FZkW__hiE=v0PuGkGzJvvBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10 Dec 2025, at 16:12, Adri=C3=A1n Moreno wrote:

> On Wed, Dec 10, 2025 at 02:28:36PM +0100, Eelco Chaudron wrote:
>>
>>
>> On 10 Dec 2025, at 13:59, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>
>>> The openvswitch teardown code will immediately call
>>> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notificati=
on.
>>> It will then start the dp_notify_work workqueue, which will later end=
 up
>>> calling the vport destroy() callback. This callback takes the RTNL to=
 do
>>> another ovs_netdev_detach_port(), which in this case is unnecessary.
>>> This causes extra pressure on the RTNL, in some cases leading to
>>> "unregister_netdevice: waiting for XX to become free" warnings on
>>> teardown.
>>>
>>> We can straight-forwardly avoid the extra RTNL lock acquisition by
>>> checking the device flags before taking the lock, and skip the lockin=
g
>>> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>>>
>>> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
>>> Tested-by: Adrian Moreno <amorenoz@redhat.com>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>>  net/openvswitch/vport-netdev.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-n=
etdev.c
>>> index 91a11067e458..519f038526f9 100644
>>> --- a/net/openvswitch/vport-netdev.c
>>> +++ b/net/openvswitch/vport-netdev.c
>>> @@ -160,10 +160,13 @@ void ovs_netdev_detach_dev(struct vport *vport)=

>>>
>>>  static void netdev_destroy(struct vport *vport)
>>>  {
>>> -	rtnl_lock();
>>> -	if (netif_is_ovs_port(vport->dev))
>>> -		ovs_netdev_detach_dev(vport);
>>> -	rtnl_unlock();
>>> +	if (netif_is_ovs_port(vport->dev)) {
>>
>> Hi Toke,
>>
>> Thanks for digging into this!
>>
>> The patch looks technically correct to me, but maybe we should add a c=
omment here explaining why we can do it this way, i.e., why we can call n=
etif_is_ovs_port() without the lock.
>> For example:
>>
>> /* We can avoid taking the rtnl lock as the IFF_OVS_DATAPATH flag is s=
et/cleared in either netdev_create()/netdev_destroy(), which are both cal=
led under the global ovs_lock(). */
>>
>> Additionally, I think the second netif_is_ovs_port() under the rtnl lo=
ck is not required due to the above.
>
> In the case of netdevs being unregistered outside of OVS, the
> ovs_dp_device_notifier gets called which then runs
> "ovs_netdev_detach_dev" only under RTNL. Locking ovs_lock() in that
> callback would be problematic since the rest of the OVS code assumes
> ovs_lock is nested outside of RTNL.
>
> So this could race with a ovs_vport_cmd_del AFAICS.

Not fully sure I understand the code path you are referring to, but if it=
=E2=80=99s through ovs_dp_notify_wq()->dp_detach_port_notify()->ovs_dp_de=
tach_port(), it takes the ovs_lock().

By the way: in your testing, did you see the expected improvement, i.e., =
no more =E2=80=9Cunregister=E2=80=9D delays?

//Eelco

>>
>>> +		rtnl_lock();
>>> +		/* check again while holding the lock */
>>> +		if (netif_is_ovs_port(vport->dev))
>>> +			ovs_netdev_detach_dev(vport);
>>> +		rtnl_unlock();
>>> +	}
>>>
>>>  	call_rcu(&vport->rcu, vport_netdev_free);
>>>  }
>>> --
>>> 2.52.0
>>


