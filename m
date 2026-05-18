Return-Path: <netdev+bounces-289034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLgHADsGC2rt/QQAu9opvQ
	(envelope-from <netdev+bounces-289034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE1256CA98
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E23F302E933
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FB940B6EB;
	Mon, 18 May 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ATutRfXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB4405849
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107214; cv=none; b=izzlIteuK51jwKfC1yTWgXgjMMRygB8XqmrPFh110aEA4djm+w8avRrUj1KlFwEddKlin7WiFcoY3NcPA+YOEa+b2YzSxIDcpI18JIHXCnOmZwIVRVKjON9UEwKznD9bXO2ceKbA+mD3omqTynz3RYmqxP59boEtf6OzlDcK03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107214; c=relaxed/simple;
	bh=aSTIccs+v3BOXNzJps3pGcZ+OSMa6U+1upRu9QgbhdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVXXSb03rqwq/MZzxPkk4cgWoKZ5G+ilXEdy1JiYQOSyJs7QK+l46Y3lQ1dBXilww8uiSKNv1e+Dkyu6nf+JCJQ5EPfG6hC8YXT6Xy0rwmp5hQpG3gV7hGpyPVmBB+Ey789kMRD4vEKLBT6EOhTPjpY6Ox1ti3QQaBp8OqVJReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ATutRfXn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so2341375e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779107211; x=1779712011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K7f4p9DDizh5dEM+ARpNcE58XjtZwhJ/w+0XvXwelXk=;
        b=ATutRfXnY+gIvP820ugX6IERpTKx8wkYMtdmDpqClNp1jpIz9cazMnQ/0394O45yV7
         5UHgs0yl6y6DAIW2zlEMFhCJX6r/wpI9Ju16EmFYmZnKuDg5OiM2an9iN+66Wp62whKV
         WL3H1fp6jAAlVk56ZAEyOoYHdjcsRTo9ApEGofBYGN9zY08/203ZDnvfGV9zDhv4ODGC
         kee1dUSUzG7tdtlaX4pqYgZkzBoCx9P/9h8mV9R/MK49EkBMd6c+DMrkUKn5G3wCeqc3
         7XUzH3EFmjeK+9VqzsvplyjUIFthwRGctUbORHBHTcxFN7J8Qmsp4yMaBqRo+xrSk2Jb
         no+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107211; x=1779712011;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7f4p9DDizh5dEM+ARpNcE58XjtZwhJ/w+0XvXwelXk=;
        b=Vo6z5DD7mJ75c8Ae6onOkSxXldb99RFXiaDgwFV/FOZv8ntkVT3x05yKcSJuAA2ZSo
         NHcCjRMgNT0SU1DZUPYsXnEJixgFa+utuzzAZiXkrgcYAF9Uo0jHlO6SlZylVnVws7D1
         RzRkUK6ICojCw5i/scThJTyw/ZpNNmHNOHIcUtotJBVyhPEyAQc9TmkxtlKrIsN9J9UR
         6Y056Pjnw7apovZ/jjAaTphFJTzVf8hHxwwrWMiadiuW36HkGiMcJ94wKC3IrYv1t+pb
         6vtVVfflDmCdp5gcD8RmKfuttvDecb6EmoH+4epctHoGp7+1H3UqfC4HqGRcb9tKi02e
         4/hA==
X-Gm-Message-State: AOJu0Yxjhmgn/PZf0KXgTBO4tIs978E0A1bxa1eFWswKBAqnvNJEJBmh
	tjZlvCUcwNAgNdYGkD2wUWAX0h2FYBos/0x2zWN8NKsrYbze0/AEd/ENE3YpgzGnm4Y=
X-Gm-Gg: Acq92OF7H6T3SH6mnJ5EzTN+WMIIvPvL/HrInq7T6ZcyVvJWM3UuM9YkHLFD/kYz/+7
	6qQNiGpWFWoOlz6cG6HojXDgvAMtr8UvgEHukjjHzZTuF7vVffi45Uskh13JRW5iMGdC168DbpV
	xrOGJqu+CheUvCUbATyAJneeydhdb2d+2xrlKdPshYCqy0CcpYYc1OdUvj1yMgiiQmJ1q6ZwnHx
	ZkmteZ1W6mOm3iDApRZjvNMMjO5s73h3nuPS9UILhDDWdqVrdDlLCHhHZuZJfQOtT+smpx8Velw
	hVWBXbEcgHnByukNuPjNVefMS6YpEwh3Y8ea/UCQn5eiVnmwIXzMyskxJWT+iwwe/clpGrfmb2o
	lkB7/TU0rq2xwUacKl2eY4JTUh9Gf8+AZ4wWdpUqSuvp1QX1iMMsLiupZuTO9Qm5l72uA9mufNk
	C6Toajw3Ut0GvhGiE+6+ftfn/mCZaZiOTKiM/CjJgUfMePWhOPgdf3fozZkWbOQJ556fCtq3dYB
	9Y/
X-Received: by 2002:a05:600c:3b07:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48fe63099c6mr122267235e9.2.1779107211132;
        Mon, 18 May 2026 05:26:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab818sm261195405e9.14.2026.05.18.05.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:26:50 -0700 (PDT)
Message-ID: <596094fa-4e41-4ffe-9261-47089ff92f74@6wind.com>
Date: Mon, 18 May 2026 14:26:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
To: Jiri Benc <jbenc@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Matteo Perin <matteo.perin@canonical.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-2-i.maximets@ovn.org>
 <20260518082138.37522db0@griffin>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260518082138.37522db0@griffin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DE1256CA98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289034-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com]
X-Rspamd-Action: no action

Le 18/05/2026 à 08:21, Jiri Benc a écrit :
> Hi Ilya,
> 
> IIRC this was added because Open vSwitch needed it. I'd expect most
> users that need to deal with cross-namespace detection to just switch
> to the given netns prior to issuing RTM_GETLINK; at least, that's what
> I'm doing in the tools I wrote.
> 
> On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
>> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
>> requests.  For some reason the code checks if the original device
>> and the link are in the same namespace and not if the querier's
>> namespace is the same as the link's.  So the logic becomes:
>>
>> - if NSID is not reported, then the link is in the same namespace
>>   as the queried device.
>> - if NSID is reported, then the link is not in the same namespace
>>   with the queried device.

I don't agree. The expected behavior is to have a IFLA_LINK_NETNSID if the link
part is not in the same netns as the netdev, see d37512a277df ("rtnl: add link
netns id to interface messages")

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d37512a277df

> 
> I'm not sure I would call this a bug; the original idea was to use
> IFLA_IF_NETNSID to switch to the point of view of that netns but
> without actually switching to that netns. Hence, the netnsid is
> relative to the caller's netns but otherwise, you get the same reply as
> you would if you switched to that netns. If you think about it that
> way, the current reply is consistent.
+1

> 
> I agree the side effects of the self-referential netnsid are
> unfortunate. But that's an orthogonal problem merely uncovered by
> IFLA_IF_NETNSID, since, as you correctly note, such netnsid can be
> created also by other means. This is (AFAICS correctly) fixed by patch
> 3/5.
As said in my other reply, getting the self-nsid of a netns isn't complex. An
application should be prepared to handle this.

> 
> So, I would argue both the old and the proposed behavior are valid.
> I agree that from the point of view you're presenting the proposed
> behavior is easier to use. Double so since you're arguing from the Open
> vSwitch POV.
> 
>> 4. A seemingly read-only RTM_GETLINK request for a different namespace
>>    allocates a self-referential nsid for the current namespace, which
>>    is a little unexpected.
> 
> I, however, don't agree with this argument. RTM_GETLINK has always
> allocated netnsids, even long before the patch adding IFLA_IF_NETNSID.
> There's nothing special here. You might call the netnsid allocation
> unexpected but it's been part of this since the very beginning.
+1

> 
>> A research across open-source projects doesn't show any projects that
>> rely on the things that are being changed.  I couldn't find any
>> project that uses the reported LINK_NSID with cross-namespace requests.
>> And no projects that use cross-namespace requests seem to even parse
>> the reported LINK_NSID.
We (6WIND) are using this behavior. It's part of the netlink API.

Regards,
Nicolas

