Return-Path: <netdev+bounces-303294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YWWPH8jqQ2oZlgoAu9opvQ
	(envelope-from <netdev+bounces-303294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D86E64AF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:11:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=FNo+1ZeH;
	dkim=pass header.d=redhat.com header.s=google header.b=cN0oTRXh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303294-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303294-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E418630FC61B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8146AF31;
	Tue, 30 Jun 2026 16:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37872313E34
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:04:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835491; cv=none; b=ipborQyVZNuM+0VlzBvSJoXRlqKOy3Q+xwqC66ReDrSvR+g603zYJ2LjIa/VsWREqGsfGs2GcYd9ojr+k9knVpiw7S8UBidNFfCXexj92UkykItLU0WEvm5KHnIjJWhwHOcW94yQxLLR9zTIZBUk6HwuiJCvsrycCRvzxr9QUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835491; c=relaxed/simple;
	bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUNnRlrpd0BSZR2oQT7xp4CUcaCOwxHpwi2L+UkSmU1kRr7oltiNhwrOW+N5wN40hEF1zWsO223keEnEqHmKNwr5zIrq1sytyKlPM2YvavKn6+nTJPDwVyjiUj1NrfXJ5RUKDFizVFb1YeHa61VhHM15LtpVFH5Rf/q1BGfn2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNo+1ZeH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cN0oTRXh; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782835488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
	b=FNo+1ZeHK5El4VYu8Vaya2/nIDVpYlKM9RAj383kd679QHml7aHiBr7kDjMbh/J9jwAA2O
	nlGSUCcgcmLdOp/PSrYhLz3D8lty/5t3xQM6vmM26Xk60A5qq/fCv+FC/TrmBOPERYH14n
	Ohxj78hWPb4r6sPZZBENOeFnEvU4h4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-vv1XTP9ZPrGyadt2h5hI8Q-1; Tue, 30 Jun 2026 12:04:46 -0400
X-MC-Unique: vv1XTP9ZPrGyadt2h5hI8Q-1
X-Mimecast-MFC-AGG-ID: vv1XTP9ZPrGyadt2h5hI8Q_1782835485
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4731a357b0aso1892079f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782835485; x=1783440285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
        b=cN0oTRXht8efcyJTON9/Rhgq3t5BYAmy9k8uEs3eUe/Oqv8ROTVgJNCw630q3NCEqE
         LOGfKF/0K1KGj/KhbDVb6OnXAvuvDm4mosadAlXpFGVHChtIfX+kpgeMZw1NuvxXKkJ0
         H/rnQeh5pX2EjpwK1C92id90VTiwP8VjqQuQz/XRYrUL7wsuKiEcr2ffkjZhqGjJlmcY
         IqfL9EA2tUmi8nYqZyQA3FEwqmEVq79PcmHDHrH5NfcIWdLz+/dqUWjPgT2/PRRQ2WWq
         g3bVfBmNTPIOE7XLRGQpzrBiPO6WQOjy7IHJx1zu0dB575x3zdlcTV/ISujAyB4iaU83
         iuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835485; x=1783440285;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
        b=oKnwL7YUtxJWoFpyRvpLhPIlhKzpAVfz4tqWp4BAemoEhqmahNGUTrWQkHxkUA/Zzg
         A23LhTGZ71gx258eqKYZQKlQkK5CQy4oEGnanYiYlAeVvUWTAOp8R08ATMnpuWDeoD2M
         ArFN8+v1MoN/ABl+AGpk5zQSUqN3wS4AEO/PFCjFeulYUAV7cDoRLn9A2bBNQeNl6Kl/
         W8MS4fYyLDvi4e7x5LT7Ui1dL9Zd06L7LhLV77fxNDVrkTtJ08Tf7xYphnc6JrxDR3jj
         sG1nqRXxziuNtjXuoGVmW/GG1YR39bI3YdRX/XG1uUTs/vC+ZQ7Hhl3tJr3w+dHmiBsO
         3oOw==
X-Forwarded-Encrypted: i=1; AHgh+Rre3psuaPGq/D3VbfLaPqCV8JSoCVu5XvQe4tm7C+tjxYkXHM4rJ/H2L21ykdFwM8r+urwQM2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVODPPQB4/U7rth18OhJxjVxow8aU2tEaT9Gh+hW9NhBE+9SVz
	yS9BZxfE8Le96etwtERSmsCJUeDCkpYDO7FWQR/1chGz6Eha716grO0sUbHvJ2IpBtYVB+eCULt
	+AR83yhr6NBCufx1MNOBZZXgdy5qNkZfTbNzQT7f0j+3VqOpqQFPk94iF7g==
X-Gm-Gg: AfdE7cm5EW2s/RnQHr3DXSV5Z5zZCDMEZxZlQ10ANIbnjp5SvpSXjGNTLuJwx9O6cfl
	rZagFcR/7EXi7a7ccfPqCQaG0DBkoG2vNEacUIWuyoRgFhWIoOskwA7RgU3OkjtHyBowcGDg0SK
	g9fsyo9N/OrZvWNFhkn7acwz7EqwbqgoMP/rAKXrY11GFphq/78oE/GOGhVIG4uzyGoB+s9EHml
	n4aNVooEHuHj61VNPMGAVniLk9j8Mtu+1MfonkYV3DidqI0CpZMJp2AqTPlV45ajZVvrMLOyLNG
	ppWXbcxwy6+D7KCvhgL+IHH3U9JZQuPGpQgnnoMP9mSG29x1vdbylkdNlLDyfBR6iiBw+hvuLil
	t7p8QQV7+RZzH7ls9xcGKIkA7/cmutQq//R6yXA==
X-Received: by 2002:a5d:6e47:0:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-475524a8385mr3587020f8f.30.1782835485203;
        Tue, 30 Jun 2026 09:04:45 -0700 (PDT)
X-Received: by 2002:a5d:6e47:0:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-475524a8385mr3586955f8f.30.1782835484588;
        Tue, 30 Jun 2026 09:04:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636ce7esm9527715f8f.23.2026.06.30.09.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:04:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 23A5E80A689; Tue, 30 Jun 2026 18:04:43 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Jun 2026 18:04:43 +0200
Message-ID: <874iik2ew4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-303294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB8D86E64AF

David Ahern <dsahern@kernel.org> writes:

> On 6/30/26 4:00 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> It does not make sense to require a flag to get lookup output. vlan
>>> proto of 0 is not valid, so it is a clear indication that the vlan
>>> output parameters were not set during the lookup.
>>=20
>> Okay, so we could just unconditionally set the VLAN fields, but if we
>> start rewriting the ifindex that would be a change of the existing
>> behaviour that could break existing applications, no?
>
> Consistently dealing with upper devices is one of the reasons I never
> sent patches for vlan support.
>
> xdp support is at the driver layer for real (physical) devices. The fib
> lookup is going to return the vlan device index - a virtual device.
> Support for xdp should not be propagated to virtual devices; it goes
> against the intent of xdp. Any trip down this path will have to decide
> how to handle vlan-in-vlan use cases. Where is the line drawn for fast
> networking?

Right, which is why we need building blocks that makes it possible for
XDP programs to do the right thing in the BPF code :)

A helper that resolves the parent could be used for stacked VLANs as
well (just calling the helper multiple times).

>> Specifically, if an XDP application has a table of the interfaces it
>> forwards between, today they'd get a VLAN interface ifindex, which would
>> not be in that table, and the application would return XDP_PASS. Whereas
>> if we change the ifindex and populate the VLAN tag, suddenly the
>> interface would be in the table, but because the application doesn't
>> read the returned VLAN tag, it will end up sending packets out without
>> tagging them, leading to broken forwarding.
>
> I have not followed developments over the past few years. Does XDP have
> support for vlan acceleration in the Tx path now? You really want that
> to deal with vlans and not replicating s/w processing in ebpf.

It does not, no. There's TX metadata for AF_XDP, but VLAN support is not
in there (see include/uapi/linux/if_xdp.h).

Doesn't mean software VLAN handling can't be useful, though; there are
use cases other than the very high end where XDP can speed things up
even if it has to write a VLAN tag or two...

>> So if we don't want the flag, we'd need some other mechanism to resolve
>> the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, say?
>> That could also be made generic for other stacked interface types, I
>> suppose.
>>=20
>> WDYT?
>
> dealing with stacked devices is hard :-)
>
> What is the return is a bond device or a vlan on a bond device?

Well, bond devices have XDP support, so you can just redirect to those :)

But yeah, each type of stacked device would need to pass different
information through to the XDP program, and the program would need to
support those. Building a single XDP program that supports all of them
will require quite a bit of code, and would probably not perform super
well. But most deployments have distinct subsets of features they need,
so this does not have to be a blocker, IMO?

-Toke


