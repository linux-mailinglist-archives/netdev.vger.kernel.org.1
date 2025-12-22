Return-Path: <netdev+bounces-245697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15DCD5D65
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB091300BA31
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675C31AA8F;
	Mon, 22 Dec 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkHek4/R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsA6dKwd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CB631A80E
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403854; cv=none; b=dSkRCO5RA/ZeHmQfbVU8deiho9M8lpxW2wy3tnHWcMp2wuxSuFGSBsiZ2OGW950BGwrFDSUSr28RuzeK3y9faI9nuwTYy/N+Y7rJPHRX3/sCE6rXQpzRoPBMJIxy2ms8kM5JqsLh1TMW/q8G8PvDSWN5GBzMnfkHx+jVwdUCRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403854; c=relaxed/simple;
	bh=0sfgBkK79JwX8MkXUfHrCJdJ2/kUJNYSOoZ4tbCudrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrghmkJiDWmZmIpODkVpoDv5V7UAsJVZGrMdq0eXC2zdrWXoLYAu1hBffmaQzuCWJGJGyQICgQqTuBDzG8mnkOxJctrBKP9esOy2oyb2BjkOiuARs6BsJNZeBx97QPGfDWmHQoBKDwbcxzN7zwi3HFyAJIF+lsTfm+a+RF9HuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkHek4/R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsA6dKwd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766403851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sfgBkK79JwX8MkXUfHrCJdJ2/kUJNYSOoZ4tbCudrk=;
	b=WkHek4/R9MtjVg7fNmWmLeiLrYt9TzagXycA78zcHvD/jIziS6lS3lyKmbg+57pj4C4ItQ
	XTE2Y7B2LZp4EHd/zCLXl401iFFY9s8O5vyZ4SoMLB2yLMK+eD/+Y5eGKlTed5EJ2gMqmN
	awMtVQmbzHBqEiNGbZAapEYdYY0t2JM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-XMMzXcPXPvuPmjOBT6k8XA-1; Mon, 22 Dec 2025 06:44:10 -0500
X-MC-Unique: XMMzXcPXPvuPmjOBT6k8XA-1
X-Mimecast-MFC-AGG-ID: XMMzXcPXPvuPmjOBT6k8XA_1766403849
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7d28772a67so385964266b.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766403849; x=1767008649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sfgBkK79JwX8MkXUfHrCJdJ2/kUJNYSOoZ4tbCudrk=;
        b=AsA6dKwdlvaLW3pkm/oCTxgltfk6LTAOZcN1pS+xxYNWe8Ttbydm9/otCV0pxdaU8i
         kfO5ejQPYoD1uv1arAAcum0a83fqk31lwHQC3fvkJfcLatUKNFh1GTYFOHl6WD3ZIhT0
         rm7GROT9r7t8UkH0zlOCCblt45SX26nlp3O97jy9aq3THxzRld5Wf+x0wLGF+TkSVcsk
         s5RHsG6uPMLtVxlHKSdiR04+mMPckPscBTd7JvSAlV9ruFmih+SmF2bdkNs5v7mm0JQE
         bikc/ZmzkXheNArk8V1tkSiVY9nsXaQ1NGuyoaIROhllzuKxmrVvpapUkdo7bwvgD4Xp
         syyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766403849; x=1767008649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0sfgBkK79JwX8MkXUfHrCJdJ2/kUJNYSOoZ4tbCudrk=;
        b=oZv0ah3v1xNi68cpmHWx91eN1H01f6IfAOx00I15+Rks6MvLQx3yQGHxIiNd5Eeleg
         f9dCVRJf21/hkF4OmEyjJUa10/xrGzGyO5H6NEwM8mloXJEwRDEcc8IvkcxHIH+P8Ca+
         3YniaBcQpUH6aAj9sZaNhraFo4B0gqCuiFv2fG9MGO1JAewqZKHSICyZN64lbfpub3XD
         tCNZJL72XWGnF+VkGbtbz2QNo+tUq8vd8wwtCiuxao8VArU+HxCdPIVVqcNmqR4W2dPu
         4kxbh8xkXS3uPxzQmrWCx0lXIVTwC+rw9KSyCgB8jvjguONA1/F7yCrwX7mms36E42ZG
         QBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhuk99hDBRy3hXAubDfoLZPGAUb4wbHeUly6o8SCEW0F+rtbw3HM0YwySlUqt62/pRmpKXGqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdTqsf03N58wRs9lpN+bh0IEOkfl8nTBLuQL8jCwNtnsrAN0X
	LOABUsnBi3Njk67c+RmSi0ZNLZcSwQSTjq6Js6nEGyWvYhyFXK4KdJPes6f+cUTQUMKSm5vkCrZ
	Ttk+lIrL0mxEd/ATYnD00rRnaGX98ZYMrHtl2JpVZR9rRfIsmW9JGK/fw2w==
X-Gm-Gg: AY/fxX7GJJsUOMWoBu8yaI/3hB+MSsdYbifiz4MpsPiwDSDmcMH3o5X96rj/28budq0
	qU/p8X+F6fvj8Fe+B9fkru6QSW5BeuJMldkcufxx2pmQjcKrpWcC0gkNH+YVmUpoAQaFUYCmz1y
	Bp6K8Mhw7UCy8o77Sd8KIOJX/Q7stVEUeVqVvE0FWos7L96eVtj4JQ4lr8fdHWsedfNijtGdiEF
	57JiJHOHHVpZsw+6wxwvEDziqbWwRSiAHwx0eUdS/IluQKwp1urK9z7szy0ZHVd3KvwzKX8iDWn
	3XCwArTOtFQVpywG2oG6rfT6Rl4bE9lNUPL4f2wv1eWuQ3cuCH7m8f1WO+HGOELS5IMEnrEwGfm
	BdTHiARIHs5G38QhzsO7wFMQFP7yv5RrAJ2oBPG7savZ03e4EXWt4P3E1uA==
X-Received: by 2002:a17:907:9622:b0:b80:18f1:2815 with SMTP id a640c23a62f3a-b803718028dmr1134701566b.51.1766403849138;
        Mon, 22 Dec 2025 03:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWTPUmIb6vaxjcRtNN7UibXUB8o+Xe+TQCcaOYlIqPLa3/hTmfsQrLh95ikYqN5KlBr5XfCw==
X-Received: by 2002:a17:907:9622:b0:b80:18f1:2815 with SMTP id a640c23a62f3a-b803718028dmr1134697566b.51.1766403848648;
        Mon, 22 Dec 2025 03:44:08 -0800 (PST)
Received: from [172.16.2.76] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1031163966b.57.2025.12.22.03.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:44:08 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
 Adrian Moreno <amorenoz@redhat.com>, Aaron Conole <aconole@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Alexei Starovoitov <ast@kernel.org>,
 Jesse Gross <jesse@nicira.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
Date: Mon, 22 Dec 2025 12:44:07 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <961802A0-4E7F-4D11-8944-46B35EDF83D0@redhat.com>
In-Reply-To: <edd72057-61b3-4bb3-b2ee-446d71e6f427@redhat.com>
References: <20251211115006.228876-1-toke@redhat.com>
 <198C2570-F384-4385-8A6B-84DCC38BB5F5@redhat.com> <87qzswklc7.fsf@toke.dk>
 <E6D49A6B-A0F7-46B6-BC32-A5C4ADAFD6DC@redhat.com>
 <edd72057-61b3-4bb3-b2ee-446d71e6f427@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22 Dec 2025, at 12:29, Paolo Abeni wrote:

> On 12/15/25 1:31 PM, Eelco Chaudron wrote:
>> On 15 Dec 2025, at 12:58, Toke Høiland-Jørgensen wrote:
>>> Eelco Chaudron <echaudro@redhat.com> writes:
>>>> On 11 Dec 2025, at 12:50, Toke Høiland-Jørgensen wrote:
>>>>> The openvswitch teardown code will immediately call
>>>>> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification.
>>>>> It will then start the dp_notify_work workqueue, which will later end up
>>>>> calling the vport destroy() callback. This callback takes the RTNL to do
>>>>> another ovs_netdev_detach_port(), which in this case is unnecessary.
>>>>> This causes extra pressure on the RTNL, in some cases leading to
>>>>> "unregister_netdevice: waiting for XX to become free" warnings on
>>>>> teardown.
>>>>>
>>>>> We can straight-forwardly avoid the extra RTNL lock acquisition by
>>>>> checking the device flags before taking the lock, and skip the locking
>>>>> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>>>>>
>>>>> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
>>>>> Tested-by: Adrian Moreno <amorenoz@redhat.com>
>>>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>
>>>> Guess the change looks good, but I’m waiting for some feedback from
>>>> Adrian to see if this change makes sense.
>>>
>>> OK.
>>>
>>>> Any luck reproducing the issue it’s supposed to fix?
>>>
>>> We got a report from the customer that originally reported it (who had
>>> their own reproducer) that this patch fixes their issue to the point
>>> where they can now delete ~2000 pods/node without triggering the
>>> unregister_netdevice warning at all (where before it triggered at around
>>> ~500 pod deletions). So that's encouraging :)
>>
>> That’s good news; just wanted to make sure we are not chasing a red herring :)
>>
>> Acked-by: Eelco Chaudron echaudro@redhat.com
>
> @Eelco: your SoB above is lacking the required <> around the email
> address. I'm fixing that while applying the patch, but please take care
> of it in the next reviews.

Thanks Paolo, no idea what happened here :(
>
> Thanks,
>
> Paolo


