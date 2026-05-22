Return-Path: <netdev+bounces-290692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIQ2IdcEEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:25:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F905AFF45
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1BB430144FE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D038CFE4;
	Fri, 22 May 2026 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Zu3HrMPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26F49620
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434708; cv=none; b=H4w965NQNVCGJo1FCUnajmZ5X39cYhroGA7g4as+WlYIiytGzzHNnyBQZ0anhWfkNgRI+6JkD+QyhzlqW33dNabt4XMERPE8urEgc9TUP9HC1mXdBTVBVFJQhtP42+q6N9cICzPvnirYEXiuVKIqxG7RsUXNRUFvx/1Ql0/nMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434708; c=relaxed/simple;
	bh=iQ3tetTMi+a2kZrr5h4gIqji7vNEElI8JHrIlnprQaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG/Ffx5Em4AGAnRc7LVAJFA33LFypgeohP1BCEx2CJrlz9Oa1FpR7STN/ck6STOwfgqQ0CxWh1god0T/5VvRAJWa+0/3k7v7+K0LslAyNgbwcRblY9JfIsev4RCTXx9Egjpd2iclbyNZWX08s05sP8GpYClMamzxONeu4Bbojow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Zu3HrMPh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45b030a5696so718836f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779434705; x=1780039505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PihRExIv02FwK9YpxdWEvz/FAv5EgvHDNQzIFK5zFNI=;
        b=Zu3HrMPheO80VdFc43+KsQxmqnK+0G3vjQBDSTyU4dai6eC3lgy4se/OA9phlDPOk+
         VIh1FBhiuMTWtcB4iaQ42MjnY/n5fw3nN+u4O31rYc6hZY0rrj1YAgAC39Dsi4BOypHm
         PBhHJ2FBP6NB1VFoP2zJeSgyO39yyeQrkS1tRxWRY8URoReYvD28h65LEpLDCYimchtG
         QGb8yQch87JJP/mW68AE3aF3UZY/gXal5dif5AA0UHX1GkF2zPs2S0p6780cg3NOFJr+
         ObMyK92Tgz+RYxzgUOsXDjdnbSkuCdBxOoQaZO8U5NiZVzE94ur50EwYcizhjyTyVUkl
         6G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779434705; x=1780039505;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PihRExIv02FwK9YpxdWEvz/FAv5EgvHDNQzIFK5zFNI=;
        b=s8DcOfVD9Dfa6MF4OLHS0lIab+wK8RvCHRKCt4h/b3JqR3a9LHjKgBFSSAy+UCeudx
         szR8kwbFiw58hvy/GUh4r2/0g8ew+sVsJ+D6yKb/lrEzzYdpaYAfSxdu8wlzwA1hzHXS
         VSQxJyWrFY8MU64Du0Tdd8/+sV6p8BWb4VsK9jBmHWWUQUPPEj01833coYPXob6GGw9g
         471d5oF9TnYQQb/7+c627KFAEnb8I4udnHTetFeugDD3xerAF1yIS8MM+TCEyJbmxzf2
         OfWL2j2wde6zQVorkqsCHf7tB4+f94oNsStweLcy32THC7d3uuXsfTOiOdqdU0UplWw1
         Zz5A==
X-Gm-Message-State: AOJu0Yxw8w6Oi91iIRkNCs7F50umTJpciM46PkNKRq/05PY5bUjS24Gu
	WdK9C8jM6fWHvObjrdP8a5GaXYMyc0C+gZI+71dHqVs+8CBXp5IShFvO2q2WkDhXQVwuqlCsuwx
	Mt4chLLYz8A==
X-Gm-Gg: Acq92OG11BY3I2abebY6JyOb9Vcj0DRJSej3SXTQw2nQRGNea/HfYJdZ2/4rSW0QT/N
	cam/2NVDeMTqQUKSUEx7Wt9wpEFwuAqaHQxPZoyWMdaI6hpmLSVALKCHwLI83gy++W0UdcXp6HP
	B9dtmUR2hZVPg8EKRmIRi7kFMpMe273xOGc1aE7FHmqvd7zWHTpRoPDzfaOT05jSJCho5/0Vwx8
	uAonVHfmdXGat27cy5XaRhS0X/lQC0nTDqm21AJgTI/+YhpwS8HhQ5FXQebH2FnKHvkiftRnODk
	D9qlmEc4uny/frTTK3EAGKnJpWsfF6YMLYh6Vb7W3JJNfrl8thm2gRq/hWjNs59J1t9qQ0umZX1
	A5ZcNV/QaPC46uLq48DvvRcNkxSYX5+QU27KE7LOiWr4zWFBn/ayyXA+X5PS93yn18UFzNh7ThV
	0U705oaP4X4Y1VXH+p+8SdPnQTo36EjTRT3P7agdo+a48X2w9rXvqrie0JfdY6po6Eg0xs37hEp
	QQcQOnWI5xvCpk=
X-Received: by 2002:a05:6000:25e1:b0:45e:89e0:ae71 with SMTP id ffacd0b85a97d-45eb38a6244mr1310137f8f.2.1779434705412;
        Fri, 22 May 2026 00:25:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm1678678f8f.25.2026.05.22.00.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 00:25:04 -0700 (PDT)
Message-ID: <76280397-a1e8-4194-b02b-76ccef2732c1@6wind.com>
Date: Fri, 22 May 2026 09:25:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/4] net: netlink: don't set nsid on local
 notifications
To: Ilya Maximets <i.maximets@ovn.org>, Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Matteo Perin <matteo.perin@canonical.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-3-i.maximets@ovn.org>
 <bd9c0751-55ea-459e-8b22-8bd24abf235c@6wind.com>
 <20260521160036.413771e9@griffin>
 <9e7b7aab-dad4-4b72-87cd-822e67b27afe@6wind.com>
 <b8183167-9e8d-4c75-b340-bc3437a14ea0@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <b8183167-9e8d-4c75-b340-bc3437a14ea0@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-290692-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21F905AFF45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 21/05/2026 à 18:01, Ilya Maximets a écrit :
> On 5/21/26 4:25 PM, Nicolas Dichtel wrote:
>> Le 21/05/2026 à 16:00, Jiri Benc a écrit :
>>> On Thu, 21 May 2026 14:36:12 +0200, Nicolas Dichtel wrote:
>>>> I still don't think that this is the right "fix". The app is broken. Even after
>>>> this patch, the bug could be easily triggered again by a third party.
>>>> There is nothing wrong with assigning a self-nsid. It would be a lot more robust
>>>> for the app to assign itself a self-nsid when it starts.
>>>
>>> On the other hand, does the patch break anything in practice (as
>>> opposed to in theory)? It makes live of several apps simpler, which is
>>> not a bad goal.
>> I'm not against the patch, it just look like a workaround.
>> I'm trying to understand how NETLINK_LISTEN_ALL_NSID is used (in fact, why it is
>> used if the app doesn't "understand" NSIDs).
> 
> ovs-vswitchd works with NSIDs of remote ports.  So it does understand them, it
> just doesn't expect the self-referential ones for the local namespace.
> 
> openvswitch module has a minimal support for cross-namespace operation.  Ports can
> be added to the openvswitch datapath and then moved to a different namespace (it's
> a little weird use case, but that's beyond the point here).  ovs-vswitchd learns
> new NSIDs of those ports from the openvswitch module and then it can perform a
> limited set of cross-namespace operations on them and monitor their status changes
> through notifications on an all-nsid socket.  It never learns the NSID of the
> current local namespace, because all the local ports can be directly accessed and
> openvswitch module doesn't report an NSID for them, as it's not needed for anything.
> 
> In the end, ovs-vswitchd knows all the remote NSIDs it needs to know and can
> recognize them in notifications.  But it doesn't know the NSID of it's own local
> namespace, as the openvswitch module never reports that for local ports and
> ovs-vswitchd doesn't explicitly check its own NSID.  So, local notifications with
> NSID set get treatment of a notification from some remote namespace that we do not
> care about.
> 
> We will be putting changes into ovs-vswitch to work around this issue, simply
> because it will take time for the kernel patch to propagate to distros.  But this
> code will not be useful for anything except for working around this one specific
> case and so it would be nice to get rid of it eventually.  And it would be nice
> if future applications didn't need to care about this behavior as well.  Having
> the fix in stable will speed up the process significantly.
Ok, thanks for the details.

Regards,
Nicolas

