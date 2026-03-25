Return-Path: <netdev+bounces-271486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFHtJka9w2kRtwQAu9opvQ
	(envelope-from <netdev+bounces-271486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:47:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A1323417
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCD6301589E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976C3BD228;
	Wed, 25 Mar 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JECRANR7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tX1Yx76o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BA3A9638
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435140; cv=none; b=QH1gfg9y5W0xeYz40x98Zn3a/ABZtBJgXjgU7Frv7LvA2Z0pDEuOlqcte9S8mGXrGeL0+f+VmZtXojv9N+/DYYoDxDIBNfvHZZBnBwkZpof+0Qalwdx6aAIQseuWcgYB3JvHRTGrhry8ApQvicJ2DO+1xzU9Df12xYrS0IDLMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435140; c=relaxed/simple;
	bh=q/p70rTE9Tr9jRBWaqCRufUFYPNnysoMHcnbGBsmToE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhKawMMPjlK5bdwFeH8FSBsf+ZkRRs6je0MH2snEZFWwGTl8T9I0AuHded1RnBF9+o6DEBiDYoyozJA8UmT7hOpVmHPP9Xyv2ZUlxfIL6NTiduE7c9rqoeUhaWTC7qJ9MRL/Asgau3T5oNLIVaFDtSfSTUSmaQFQhkSZrqRtBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JECRANR7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tX1Yx76o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774435138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/Si9+s7QxxoCBvO+kz7sMzfMBjgo1CChr0Lcp9Yhl0=;
	b=JECRANR7LQ7u2eVo5bvLR+Femsn9xTzMv2tkgm5u+aYpmqDa694ovwyjJyEW2AEAIB0xDF
	mRNCqey+qA2qHgvuKve2X3qSv7O3kmJ2wZH5vdDRn6rK/PK5jPcYRlXyIH4XDEHB/v6fj3
	uKCfXzUcySPlm0mZuzhA8huAJtAho5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-kflZgumsMxaPKXKqiCAddQ-1; Wed, 25 Mar 2026 06:38:56 -0400
X-MC-Unique: kflZgumsMxaPKXKqiCAddQ-1
X-Mimecast-MFC-AGG-ID: kflZgumsMxaPKXKqiCAddQ_1774435135
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48534941525so60565605e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774435135; x=1775039935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/Si9+s7QxxoCBvO+kz7sMzfMBjgo1CChr0Lcp9Yhl0=;
        b=tX1Yx76o4hh+qmR6PRkMISJx551kneyHeKyzY9Ebz8VQTodyf2ZdgZsF1W6SQ+0VkC
         kVEirBg3qt0Uc8KEBoVQ0zQgCtpTNMB9irF16uygKLtMPQzbhBvz0wV7hs82XD2WF0Sh
         tcVwwnByJqVp2mz/Rx7TB306oiwQm97j518f/kOOn1RnWU4Sb9FDNS8uolYJt7x63rfc
         Yp19PlrZWf0X6aM7Fvub5ltAjcvvq28fIk1dcbVsjXhDDQ4XI/tuhSqiOEw00rE0B2gC
         C5i6Liq20iEae6pFGmDXdkJdAasqiqE7aavx56AirnURwq9Nuus68BKCo8dufEphpP0m
         PZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435135; x=1775039935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/Si9+s7QxxoCBvO+kz7sMzfMBjgo1CChr0Lcp9Yhl0=;
        b=T4U72o0W3l0NHsYw9rp+BgdwueV86SDn6yrCBtkBLFEEeMmKYID2ux2vaQ+bkMcWqJ
         dA4oUsxq552FAcnEUt1mJMU2Lo23S1vPEUxUNqbW9ougeUSCS+dgnXvpRhJNqW9xm0Cv
         EQyXxefMbux8PEwxl57GkOizc7oy5lFZd/L/Nss4JsHn2XTAlLdwdDMLk7p0zUA3W2aD
         tqG0dxHFwbbigBKqnnVbbNsP5OaEFrVjTXYtiuzQeHtM/o6Wu8+NRxjjtyuO2GKSQzhV
         46oTX3AvikpZ8D3nP71UDrvcJas54FukLEtKwTFB3s58FgPwLV0EfQ0wPZUYwG6qoUf1
         8xCw==
X-Forwarded-Encrypted: i=1; AJvYcCWmKktuyVACJK4+5h5ydRV7cD75F8UyVlmXOKapZwIO77R9dASHvewDG0Qi6DbKPiWItj7vcRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYq0CIZddL4+OAHVeJduKeh0kNV957L7mCM5ukYlxGnUsYxPua
	Hh17a1p/OstNTngdxuPcOE4MD6aol7T8SP5Mn36cj40RD+0SYLYNQUqOJB1YmylucdqX9fOg2sp
	wKwNdk1MfmjdxbO2IZfYTDJSZt34N9jZXFKe9wL2MwRbY5vdNV8FoXdNRAA==
X-Gm-Gg: ATEYQzyDRTCSZJMf6cZJ4m/RMvB7MXVJqPAZ5EwxMFIxHmGhorrT4OO/knTazlBw5Eb
	p060ca58RIMzMX7CeOOk2UD4ke60OrPDQvAFuw8jdqXavsQWLsBb7nEN9sobiep0q7Q9Ktsk9IV
	ffpQ50YmnOM5ItUAeG1DyfZ681+UWWtnHnj/55HZ2n1363M/6QquTHjXHV6m84Ytq/CNyVsT8Om
	UnzJJ1m6ZtJ6I/PJBUSKZYClPLEurc0A2fUBdYj/+1N3B9HqK1fQM2zwld5VZxhYkcL4+D93K2a
	6DCkM9ZJQRzi/7Cb/7He0By6bla1dej0PBK2HXRnQj9+V4sHX1poDUy5WeQ4klbIbmg32bk1DdX
	EvD2zpslCZxrcDxcLRzwpy/FfNqjNdl0lseF02bTyGPo9CMLr
X-Received: by 2002:a05:600c:3b22:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-4871608dca6mr40636995e9.29.1774435135320;
        Wed, 25 Mar 2026 03:38:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:485:35a4:939c with SMTP id 5b1f17b1804b1-4871608dca6mr40636315e9.29.1774435134601;
        Wed, 25 Mar 2026 03:38:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2cesm122268625e9.10.2026.03.25.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:38:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A9015A4A85; Wed, 25 Mar 2026 11:38:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
In-Reply-To: <401134e3-2a2f-4c23-8ba0-3a4cc901d6a4@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev> <87ecl9mc9d.fsf@toke.dk>
 <401134e3-2a2f-4c23-8ba0-3a4cc901d6a4@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 25 Mar 2026 11:38:52 +0100
Message-ID: <878qbgmbwj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271486-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,vger.kernel.org,fb.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,toke.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E0A1323417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Leon Hwang <leon.hwang@linux.dev> writes:

> On 25/3/26 00:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Leon Hwang <leon.hwang@linux.dev> writes:
>>=20
>>> xdp_has_frags was introduced by the commit
>>> c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags lo=
ading the ebpf program").
>>>
>>> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility c=
heck")
>>> was to ensure backwards compatibility against tail calls. However, it
>>> missed that XDP progs can be extended by freplace progs, which could br=
eak
>>> the backwards compatibility, e.g. xdp_has_frags=3Dtrue freplace progs a=
re
>>> allowed to attach to xdp_has_frags=3Dfalse XDP progs.
>>>
>>> To avoid breaking the backwards compatibility via freplace, disallow
>>> freplace on XDP programs with different xdp_has_frags values.
>>=20
>> The problem you describe is not actually a problem, though? A
>> frags-aware program can run on a non-frags interface just fine.
>>=20
>> You're messing with long-standing behaviour (since 5.18!) to solve a
>> non-existent problem. In a way that completely breaks the frags handling
>> in libxdp[0]:
>>=20
>>     Running tests from ./test-libxdp.sh
>>      [test_link_so]                PASS
>>      [test_link_a]                 PASS
>>      [test_old_dispatcher]         PASS
>>      [test_xdp_devbound]           PASS
>>      [test_xdp_frags]              FAIL
>>           Kernel supports XDP programs with frags
>>           check_load_frags:	FAILED
>>           check_load_nofrags_success:	PASSED
>>           check_load_nofrags_fail:	PASSED
>>           check_load_frags_multi:	FAILED
>>           check_load_mix_big:	FAILED
>>           check_load_mix_small:	FAILED
>>           Test test_xdp_frags exited with return code: 1
>>=20
>>=20
>> Please don't do that.
>>=20
>> -Toke
>>=20
>> [0] Run 'make test' here: https://github.com/xdp-project/xdp-tools
>>=20
>
> Indeed, it failed to 'make test'.
>
> Will drop this patch in v2, as it wasn't an issue.

Great, thanks!

-Toke


