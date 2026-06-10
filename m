Return-Path: <netdev+bounces-297670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hEjSIdFeKWpZVwMAu9opvQ
	(envelope-from <netdev+bounces-297670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:55:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE96697A3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=ZVRVm3ci;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297670-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C249E3029E4F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42F3FFAD7;
	Wed, 10 Jun 2026 12:52:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303D3932DA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:52:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095952; cv=none; b=WrM93KiufB/kMQ0VroK8K2i/0UGgVe1qeZNHeE9nr2XMHyBBuig0QD9tH1mDqRnToHU3AQakAlXKqDST4Q2h0WUIVXjcvedKBp1mbPWMLJc1G9+076fT5EadCrpAyURRswgjZQcVWdu+TMGzXhEJm6Rgc5hwR5h5zQ/qYuNKYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095952; c=relaxed/simple;
	bh=XecexlMNyyNcVJlgcjnzYxy9anN01gCic2GIIGoAiu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T/bQ2zdVTX7d21xtIP539Laxrw7LC97rqfrXAtA1PEVOLbfqbmPj2kGcj1DLgtGNMVpX2ncMZ4LJ9r1XO0HnbRyUriZWSDM3e1p3Jp2UKhfMqKUsF7zlYNvSvEAT4dgrJPfHw0AOrH115xwr+7U0UF/2Wv9n7OM9JT21ECpD06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZVRVm3ci; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45efb698ef2so3301581f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781095949; x=1781700749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQSyOQ9XO5WnzbgsmkRWhr4mMBU2jexGb8HEghNchjs=;
        b=ZVRVm3cimIUOWhMRu+4xESmTIeo/HelnXvY3xRByYuSqiv5x7zneUoTT/45+Mk9vMQ
         cWgrMa5qRV01gun2AvvcAOUbp5bgmVMM+4tFEuZOodC62NW16WyghRWQ1bq6Sgo/VK9F
         M/G3286nAcX/bl3CCaoRX1IPn3XTVRfDmOPs5i6mrJl6yBZ+4mj/A/VZwU5ShxjyyL6J
         6dItyUcqjBn60hsGig4+vyXD/XNpCrCAXQaXODC/atT4k3loRqQP4l96hD3nxLc6cjrt
         Q1FcmPxpL80e82XEv+jBxlSbLUtf8KZT7TEm80Rs0zRtGu1ASoCYeCJ8EQAAUBc2+Fmd
         qCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095949; x=1781700749;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQSyOQ9XO5WnzbgsmkRWhr4mMBU2jexGb8HEghNchjs=;
        b=XFiJIIMa6gnNsMsLIWSk7LLeJlh8TXaxpyJxaea5XUWEGcXxti3EkyrQrUQ9bPiQYv
         xBsnlH6QQ1YuytTbjwi4wV/+U4UASSpYZxRjaA2uH7JeSlsrnd22NGzKg4+9AGJ3QPMU
         /f93FmVQxyqx6MfYNx004vgaFK3UNEciaww5cEXLX2xLP5+EM6MOtxlzGiNBhPsAjgBP
         hYlv3H4lVFTNIopXquQOz5cOab8ot2oyVYnhSoefLBn4ry2S383mqzKkexx8H0NFN9Qv
         3ZimnOTW2TZMVikgOIyP7dHZhqn6au1TFTNnJwl4MQctlLs5un8dWTleYHtgXF9BQ/dc
         GCkg==
X-Forwarded-Encrypted: i=1; AFNElJ/OS7NHyppiQxBi/83ZH786GfJGABgHj1kMqc3r5pbGJiYPrjxUemfOggZ0RTQRcy1uvsS6Mco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKT8R6GrlSQRj+2C9dL36Nm27MS4oVbtt1Q8M5APVmOP3AoN2
	OyzKOf/2akjHtQ6nXX4O1MR4ZDFmWfDBhvNwyYiORYC/SX5zEBLUAQolw7d4tS3Kh4w=
X-Gm-Gg: Acq92OGI3Qez01DMXTquyqfNMZ4ZKrS5Y/7tavFuiI17clCQCFUafdeqzu11SNAhrHS
	XOPx/IHdJZO2lSdBNxuFk/6SUyFkQWs9lXxIICpyrFMOCnKLB9LWRk+hzuCFAQJD010UPIvNRS4
	hxcjxacnoMZa6U48BbtwaJgsv9AckTHfDARnw1TGkO4pByY1X1U8CWgf6N9ZoREBRC3mboX39Hd
	ZVyHuE4FsyJgjUiv7objQjq+uQ2CX40DfPiqW8ve7PViQEMJpGr8tkAv706FPlAHKPFj9NdkfH7
	6xV8JQw8Yf9npBbxwqDFtb7bb3+d7rA6wfL4z0upQB7InP3hVkg3/Pg9ZzJDiI01pkrwIKC9ivJ
	qh+KE0d3RQ+GCy6KfE8fLXi+KiWobu3VmMT7ynV+s50Xtm7DdO7q8A8JBZrPNGWs2jReaKUHZK+
	gHJ/MLaidKjh6hOEOH38dw8yxHN2cayS7d4kPB4uhd57/zf14ZWAiddfH/XVzi1M7d
X-Received: by 2002:a05:600c:620d:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490c25fa907mr361036215e9.18.1781095949152;
        Wed, 10 Jun 2026 05:52:29 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcacbb20sm26519565e9.2.2026.06.10.05.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:52:28 -0700 (PDT)
Message-ID: <69e48cef-5c98-44c8-8855-5a2ebe615c94@blackwall.org>
Date: Wed, 10 Jun 2026 15:52:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: add sysfs interface for
 broadcast_neighbor
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Tonghao Zhang <tonghao@bamaicloud.com>
References: <20260610120812.49054-1-laoar.shao@gmail.com>
 <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
 <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com>
 <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org>
In-Reply-To: <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297670-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:laoar.shao@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:laoarshao@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bamaicloud.com:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1DE96697A3

On 10/06/2026 15:45, Nikolay Aleksandrov wrote:
> On 10/06/2026 15:39, Yafang Shao wrote:
>> On Wed, Jun 10, 2026 at 8:30 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>
>>> On 10/06/2026 15:08, Yafang Shao wrote:
>>>> The upstream kernel has supported broadcast_neighbor for 802.3ad mode since
>>>> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 
>>>> 802.3ad").
>>>> When upgrading from our local kernel to 6.18.y stable, we switched from our
>>>> out-of-tree implementation to the upstream one.
>>>>
>>>> However, the iproute2 package on our production servers is too old to
>>>> support the broadcast_neighbor option. To enable this feature, add a new
>>>> sysfs attribute at:
>>>>
>>>>     /sys/class/net/<bond>/bonding/broadcast_neighbor
>>>>
>>>> This allows enabling the feature by writing "1" to the sysfs file, matching
>>>> the interface we previously maintained in our local kernel.
>>>>
>>>> The result is as follows,
>>>>
>>>> - For 802.3ad mode
>>>>
>>>>     $ ip link add bond0 type bond mode 802.3ad
>>>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>>>>     0
>>>>     $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
>>>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>>>>     1
>>>>
>>>> - For other modes
>>>>
>>>>     $ ip link add bond1 type bond
>>>>     $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
>>>>     0
>>>>     $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
>>>>     bash: echo: write error: Permission denied
>>>>
>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
>>>> ---
>>>>    drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/ 
>>>> bond_sysfs.c
>>>> index eaba44c76a5e..24eb23634d98 100644
>>>> --- a/drivers/net/bonding/bond_sysfs.c
>>>> +++ b/drivers/net/bonding/bond_sysfs.c
>>>> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(struct 
>>>> device *d,
>>>>    static DEVICE_ATTR(ad_user_port_key, 0644,
>>>>                   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>>>>
>>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>>>> +                                            struct device_attribute *attr,
>>>> +                                            char *buf)
>>>> +{
>>>> +     struct bonding *bond = to_bond(d);
>>>> +
>>>> +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor);
>>>> +}
>>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>>>> +                bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>>>> +
>>>>    static struct attribute *per_bond_attrs[] = {
>>>>        &dev_attr_slaves.attr,
>>>>        &dev_attr_mode.attr,
>>>> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] = {
>>>>        &dev_attr_ad_actor_system.attr,
>>>>        &dev_attr_ad_user_port_key.attr,
>>>>        &dev_attr_arp_missed_max.attr,
>>>> +     &dev_attr_broadcast_neighbor.attr,
>>>>        NULL,
>>>>    };
>>>>
>>>
>>> Then update your iproute2 package, sysfs use for options is discouraged
>>
>> Could you please explain in detail why this is discouraged?
>>
>>> and is not being extended on purpose. Move to netlink.
>>
> 
> Networking has been moving to netlink-only options for awhile now. Check for 
> example:
> 1e16f382ae0b ("net: bridge: add warning comments to avoid extending sysfs")
> 
> The preferred way to configure device types is via iproute2/netlink.
> 
> 

The author of this option also had sysfs initially in his patch-set and
then removed it, here's my comment at that time:
https://lore.kernel.org/all/d0e0379e-79fb-4a95-b160-6c1ca4276081@blackwall.org/

and also Jay's confirmation that sysfs shouldn't be extended:
https://lore.kernel.org/all/1319073.1747143053@vermin/

Cheers,
  Nik


