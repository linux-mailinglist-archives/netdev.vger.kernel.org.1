Return-Path: <netdev+bounces-302060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Np6sADhrPWrM2wgAu9opvQ
	(envelope-from <netdev+bounces-302060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:54:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15C6C8094
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:53:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=Rntj4F7p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302060-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6878230053B3
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8FB3EA957;
	Thu, 25 Jun 2026 17:53:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1B2F7EFD
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:53:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410036; cv=none; b=csWkSMeyhQyiPYg3QiP0SGFsHQ7W4WvhSRZAhwSUfN05Ql82QwTbwaw+YNfSVMZp3nMXAK1HG7rwSOFuJmB15N54Ej5z+5/JIkOjcN5yKhda6sM8+2GvQrKrE56t09TqgO8XS3Xp035SIpwkvG1AzEyRDh5ccF53OFuRavG4R10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410036; c=relaxed/simple;
	bh=B11ZQTvdIL93NkafABLbpIaW0vHdrH1GQy1hrBB6/9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KU5P0qzZjKuC+sFXqBiFoYJUqpQB7Lbi7eR9GWyiDiRYYh2L9de+Yx1POUEGLoKll1WGK6m40bwNZgUHrb8kmt3rlHqPCMjL00adQhp2tKLmhza4W5hS1nIHMfyBDC3a4LrUYUhsvMtgisJqVeiWKUNMGdsENuKgT50m+NYuxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rntj4F7p; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso106600a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782410033; x=1783014833; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baUOcdej9K28SalpnnlZ0AOjTR4JaafvonBsqfAXZxY=;
        b=Rntj4F7pdeV+U4fmLXnLyKjW56JswuH9yGVaFGcbgVViAEapY2fU6BpN9zay8WkKuT
         f0KYFcyqE3DDxoWc1a0Zrhm8zTuH28yMBD0dI619d9qLiz9Q6c4RUXtzavJ17rDUvo7Y
         sukQrKkyKUsFdvxjA1gfVstmWZUnBI7LbbnvMknIDjRql2Btl4vtYvCKgEhQ/d5Wvo/F
         RHfDwpnWZsY8ckBVVA/SjbunGz66G/cnENioBC9xR+tmOyWBo6z49/em2LUYvIiGamhp
         nm8z9x7MJ+sIw8OcW0ThwVGlM8D0RkTd2hK3DOv1jzkfADBP95OJqK14RUrLv0GO2rNP
         T4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410033; x=1783014833;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=baUOcdej9K28SalpnnlZ0AOjTR4JaafvonBsqfAXZxY=;
        b=LgJ1+tqYfKUkm4NfaIhk/ppQ6Vq5vfcwcGFbX6eL0D6IcMKXRo/9HX+Xsa3+gcRHFq
         Uh/vyzBMKRlyS2DvjggNqX687nDfhqQAULHJkqFAahlEmwC1xda8zLU65xdONh48nEDo
         uSVx+s76SEZqL4nZXsfmCeAO8A1YIs/3jP71Hia7DFbnsTYSEJqyqXWIvhs7jGwMrwIz
         F7ity2Zsk8gickDlcnDltB2sFXNYx9MsvZV/DDcyabx841PHNDtl9vLMb8mUjBYtNfX6
         x9/bwx87j2zGNAg1sQTTWjGgQfd179zlrEiMPJ26w6QZtEJKitsKNGRwm7jzBRFzJkf4
         6MPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/fsuuW3Bq20jEHbj1kJKO373N/FBGsR7PiSjs2ePCx8Al7iWHbV1pFCA9S7gosNqD8yXCmNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrBB9omjzQQQwOoDQWdHUj5XAHInYKwYHP+2FDdANvzRa3cVD
	y++NCZBmqvRRndf+8d2sk48d0Y62qFeTfYOmnHzXA+FjaCPbcO1NbthSk88AHIWElLk=
X-Gm-Gg: AfdE7clsyh1HkahOrcAGCbCSFB9JTgI7mK5q9WctFVUIzT+dWqicRjFk9gbqXywYGLD
	EmMVyTgKC+fwuD+af9NxveDMtUvCkPsNkOBatDMv/H7l/S7IXcWhJXFal4ZFKRUaCNzuTMGy6vP
	EDdJ87C6UNwunH9EI573lSM2kCQ5+30vTTOEgaTN2ELt1NGVm2vN3cBA1tWJcrQ0a3HcFH1FHCS
	PVrY+NovKV2fweA4pG5rDaobw/558bmWnuYddcQqLXs3tIlJcqLFlu3H6q6sEC+hs+kHaacBWn6
	QhElTtXK6SDBO7LmNDQpBUVakEw0+w95i/PwL129q0tgVIj3iGVv0zoWDmxfz1JyEbOIgyjYSFZ
	erLb72DHc7e3f2oGDcpJPz67sdWSiNQTwYoEphnyqlt3YCywaRL1HvzHpunpG0s0QrhA0b0o8Qs
	IHFKqPEr0I3hzOZeE=
X-Received: by 2002:a05:6402:278d:b0:697:b778:c2d1 with SMTP id 4fb4d7f45d1cf-69810afd14emr226075a12.17.1782410033016;
        Thu, 25 Jun 2026 10:53:53 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bcd8f7sm1838393a12.26.2026.06.25.10.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:53:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>,  "Amery Hung"
 <ameryhung@gmail.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "bpf"
 <bpf@vger.kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,  "Daniel
 Borkmann" <daniel@iogearbox.net>,  "Jakub Kicinski" <kuba@kernel.org>,
  "John Fastabend" <john.fastabend@gmail.com>,  "Network Development"
 <netdev@vger.kernel.org>,  "kernel-team" <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com> (Alexei Starovoitov's
	message of "Wed, 24 Jun 2026 13:57:07 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	<CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
	<87mrwlyqg4.fsf@cloudflare.com>
	<CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
	<878q85yoy5.fsf@cloudflare.com>
	<CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
	<a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
	<DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 25 Jun 2026 19:53:50 +0200
Message-ID: <87cxxey09d.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-302060-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jiayuan.chen@linux.dev,m:ameryhung@gmail.com,m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C15C6C8094

On Wed, Jun 24, 2026 at 01:57 PM -07, Alexei Starovoitov wrote:
> On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>>
>> Hi Alexei and Jakub,
>>
>> skmsg is actually still pretty useful for gateways.
>> I started with bpf by integrating skmsg into nginx as a module and envoy 
>> has something similar.
>> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for 
>> L7, redirecting
>> between local apps by looking at the payload. So there are real users.
>
> ...
>
>> Agree, just like we remove skmsg from KTLS which is rarely used.
>
> ...
>
>> Hope not have skmsg disabled by default.
>
> I wasn't suggesting to delete the whole skmsg,
> but to disable combinations that are causing issues.
> Like what was done for skmsg and ktls.
> I'd allow plain tcp and udp sockets only.
> Allowing unix sockets was fishy. I think we should reject it too.

For unix & vsock we know Bytedance built a proxy using it.
We've been showcasing it as one of sockmap use cases [1].
That said, I don't know if it's still being used or not.

If we don't want to go through the config-knob-then-deprecate process,
then I guess the only option is to kill it and see if anyone complains.

[1] Slide 117, https://github.com/sockmap-project/sockmap-project/blob/810d259af6e7a5793922af3991c9dc7ff502fe19/talks/2024-09%20-%20NDC%20TechTown%20-%20Splicing%20Sockets%20with%20SOCKMAP.pdf

