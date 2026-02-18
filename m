Return-Path: <netdev+bounces-259359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ8mMpEklmn0bAIAu9opvQ
	(envelope-from <netdev+bounces-259359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:44:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278B159801
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2445300DD45
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52352334C2C;
	Wed, 18 Feb 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2f2CI2p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ph9OuQob"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11498345CC0
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447439; cv=none; b=h4OvpJS9uIGGqYk4vLCD04MdXYrKQ5PwwhlhLhIAxSuYWCjTsH+Y9cqepl5XPRyVQXgIWJLF36QdtScLuXDCl4LmwyPKZsq65bou+RL+fJ2b42eFkwmzQIGbH7anY9Odph8UwsIHpDwBAobVVxfhhh5EKG911eVueqToM/UQuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447439; c=relaxed/simple;
	bh=3SD23ztjGU0CipDWmeweCOMJbvb6lsrcMpKisWD63EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvadozu0r5lbgF/tWZOvoQ10BF6RmQn2A549DomOVYccB7XiHC+nAulasIBFBB3AGt/JgmXiha8vLUQbS7oE9QnrvdS1xbtI5khw/10Cg+8Cn5xxvw73hPrwK7ijuhI5WvNTyNi4gAqQp7CvOrQxmjfebx5LEt5f6yQA+FmOWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2f2CI2p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ph9OuQob; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771447437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqKA8CHYFzyHn73uM1L1fd6DrsmMfhftBIbHR2KLikg=;
	b=V2f2CI2pFNNmMra++KegTQ69BVnqMyrfuBbvTvBjMSyCUqM36yZe3bRbS9qTjmE0ny64hs
	e5v40z2H6Dd2fKIQt0mmAW/x7skCvCLAAT1Vhxro6OniG870PGLNXFIg+6MXzcSA917GwP
	7AI4wK0okueDQxaXT5svRvk03g9puf8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-0Iowey4XNNKft7PRKW_PRQ-1; Wed, 18 Feb 2026 15:43:55 -0500
X-MC-Unique: 0Iowey4XNNKft7PRKW_PRQ-1
X-Mimecast-MFC-AGG-ID: 0Iowey4XNNKft7PRKW_PRQ_1771447434
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso157473f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771447434; x=1772052234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqKA8CHYFzyHn73uM1L1fd6DrsmMfhftBIbHR2KLikg=;
        b=ph9OuQobOEwEJPbHJD/sJZYlcaKXsy764lwqvfSDMUBzrs0Fg+Lm2O2QmWs+VwD4lP
         ozAJKayZfFpO6iW7vxSYif9Uq8MPBnfuL6asM+Wr7bYkYn+xxxjj+pCo709xd4BkJNxb
         VEzKTPcufwOto1zJjCu0men41OKrg5dQpVjVrRMkwFUS2hZTq3cfwxcHKw9WT7p9R3iB
         7VrfKlIdDF4SyT3aQMJ79RiEyud4PKwaVJ+gCZM2kQOcuhju8vDXm8QJOkZL+LTsYay/
         a3jG5eufGJoqPZmlWaeDOrICukqaae6u91Q1+HmkAPk7+OqK7GF6dSYZJLxuAhQG5zX9
         AF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771447434; x=1772052234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqKA8CHYFzyHn73uM1L1fd6DrsmMfhftBIbHR2KLikg=;
        b=a2SxmxgahqY18J+YFKTf+25CsjERvUNNMgUBP7CQbXFnqr9A/gNShLUK2iqNQc4NAu
         yy39YDKy4kwnnEzJM6+Ay0iAAQK7voJMy8gi3c7+u8WhIGNPRyHxMPI3TuOBb9BTnXdx
         O5I5/0PVC+ViiUS4Qgu1Avj6C9schFcdQTQkOAdG734Zl6xCLuLksUDUMJau9l+cqHYe
         j0yoX5xB6FIks+xHXwYAoFCjkstwthezon156xzhrAOEsWhehUQY2VoTz6CejG4JdDdC
         SeCMcUDpHc3j55vC5VT7TRkKNBYiRM9JGwkamhL2ilUBsPKpqMQLqRh5XcnQQNjbWsgv
         iEHw==
X-Gm-Message-State: AOJu0YyoncjqBcIhn0/PSwaNrcjdBhTsiBS2cN2zBJQz/BzC5UsxqYJj
	kfGc6Lj7orpw8+GjDATsEGOg2Mx1SkaArzV+urYjDCoZKB8pSBqBd4u1TfBI1JS1fvD2tya97Ld
	EPWCuMK/uZo7OZ6V9zzsaoG6V2+OTDI97lJGbWLUEzGe0IRPJDW7TZx/R6w==
X-Gm-Gg: AZuq6aKVh+3BnkICXHB/P5RDdRDyIhlKf9qY4iEDnHr5VN9tiCAy9QVzILL3X6vR7VP
	Hal0raxXiSJKHqS3ruJ4uTeLJbo2uO8ALOcWnOVquv7Gc8CRBX4SbYvbHzCQ9TGp0Tw/iQdpY20
	k+u426+dhlSQECApj5moqKeh4Xd507ZbiAoU2mXmrMZVojzjSMa1h/Msx2In6xb0srE5UoeCBwh
	XIb424X5oxDWegL3YuC/YZ5SLMXdJf4NPbdLXRMqsPgeO+WxeLMhjuip6c5xCWTPTXtWscczupd
	pv5cAXZzXgqRJl550vmhucXwEhBVyv2OIi4ST8DgbYn2qcLRFSuZyAy3khtNtJb/CLcwcXbiG3H
	ODqcuQNT5gXihMAbBpXWxhyMP
X-Received: by 2002:a5d:5d05:0:b0:437:771b:26b with SMTP id ffacd0b85a97d-4379db71b34mr30839793f8f.26.1771447434242;
        Wed, 18 Feb 2026 12:43:54 -0800 (PST)
X-Received: by 2002:a5d:5d05:0:b0:437:771b:26b with SMTP id ffacd0b85a97d-4379db71b34mr30839746f8f.26.1771447433725;
        Wed, 18 Feb 2026 12:43:53 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm41093173f8f.7.2026.02.18.12.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 12:43:53 -0800 (PST)
Message-ID: <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com>
Date: Wed, 18 Feb 2026 21:43:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Jamal Hadi Salim <jhs@mojatatu.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
 <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org>
 <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org>
 <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
 <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	TAGGED_FROM(0.00)[bounces-259359-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email]
X-Rspamd-Queue-Id: 3278B159801
X-Rspamd-Action: no action

On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
> On Wed, Feb 18, 2026 at 1:31 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> On Wed, Feb 18, 2026 at 11:15 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>> From a user's perspective I'd prefer if RTM_NEWTFILTER just fails when
>>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
>>> for the application that makes a request and for the user if they make
>>> the request manually with 'tc filter ...'.
> 
>> The challenge is actions could be created as a standalone i.e "tc
>> actions add action ct..." then later bound via tc filter. Don't forget
>> actions can also be shared by multiple filters (which could be a mix
>> of egress/ingress)...
>
> Actually, looking closely at the code - this is doable. Let's see if a
> patch can be cooked.

I discussed a bit the topic with Davide, it looks like the thing you
mentioned above could be handled. The problematic part is AFAICS the
additional indirection level added by (possibly shared) blocks. AFAICS
whatever check we do at ct_init() time, shared block could later
circumvent it - unless act_ct is always forbidden for shared blocks.

TL;DR: I think admission check at init time can be implemented only in a
quite (too much?) restrictive way.

/P


