Return-Path: <netdev+bounces-267014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLzNKTmXsmmKNwAAu9opvQ
	(envelope-from <netdev+bounces-267014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:36:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3F27062D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3532B3059AAD
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A323BC688;
	Thu, 12 Mar 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp0hcXsa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKZbzCrh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C13BAD8D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311789; cv=none; b=s9wgYNpq8UJvI7uHPLCLjSjwAsHYBV5bg87gBspds7SRzOqeyqOCDhmBweZVoegKWcs2QGGvhEMYhhfvCcrKcTa9qHUFFSYryXEm0NpaYHIMfcdjAYNdlyXfmHzNLjptl8I1tEGta4etXWEmYDkFh6HHOENDMh2m8gfNDfNTvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311789; c=relaxed/simple;
	bh=U4scEkwLlZ0VuAmkLypf9F9edX/OF61hxlh8178UWxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+H9ce6uk/RwJf+/PruZHuPyZ2or7bIqqdJRMYpsDl/we7ObLs81zslL/tzBPPV/chHaNqiApMY2l/EmZWhlQ3ZEDtUXk1HPtoBwq8pmT0wpYofJscyu1l2JfWxfJJAVhPUagN/4yPRC0HhnnoO7eErL1/j1fzbkXBUF37l/W8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp0hcXsa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKZbzCrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773311786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
	b=Xp0hcXsaen/FaUNGVnwczL4Z7gg2isaP7WLifGG3FOJCI18vkH+BlO8yRpoY5uEyC7aIFH
	1oWAnf/upkKtwDF+Mf4FdweehBBqucQHirXcqev4NFTsJ8tYfvEvWdH08yWOKfzSXKoYF+
	yviCDCDdoH+bVYA5cAAiSNPzQ0hoxMA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-aO4SVcp4OiWAB_hesitAdQ-1; Thu, 12 Mar 2026 06:36:25 -0400
X-MC-Unique: aO4SVcp4OiWAB_hesitAdQ-1
X-Mimecast-MFC-AGG-ID: aO4SVcp4OiWAB_hesitAdQ_1773311784
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439cbfcfc21so970420f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773311784; x=1773916584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
        b=SKZbzCrhAwNnxZnaxQFPdwxbGklU0PMxnb0TP9YQ+rHtghOeCcW0NolpUNwZsj/n7X
         FLFNvNc4tU5O+JM+tmFX1fMwiaYt75Px7FmKOT0I0qB6WBhec9j1LeXablK4Fldl9Xcb
         nUYgQ9dKRjBr3Vp7apb7+KOQ+hLPosi4+cyEco3U3OFj8sQHq/9p1KDI+hRJAgD6Uj7I
         DrcyA28xIdZHoTB9Tc5EXzbpCHTKm1dije/06zL8YdQ0PCbfi+uq4NIoKmPtlVkJdvw0
         AieWLzoNp1q2dron/zgAIHvoA/Awu/maejeqRTwKgB2paHGGeQ2kHKPI31DhJ35MYfh+
         Mi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311784; x=1773916584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+iZcW0Vr1rZJU+b396wxsEji96fYKMPY7NwZ0isYc=;
        b=jib3AN/6yIz30CW3TelYbOWBMhtsJZOChHN0ECW187O2GCsq1Kb0njWcqBmhvNBbBt
         zs0xTly6jNZeXtuLl8FRkUjMSuUHdBZ6TrHSkIgqtqhLtBI1bbb0FUhZnjJ/iieKCUVg
         9rCx0SJlupCGoFhV0c0WbDM0aU0ZYAW6eY0+Qsw6K4L1yiMJYQ7lBT45xQSvykfUU5i/
         Kz1ay+3GUFmIdo3zXFUwccDeJgU1nnVMCyhzn9MSIMLtu/2IAJ4Sq2TxJMSpKF6kI85+
         9jpe83p4pMFkxkyY44ts0eCPfRLTWkbmIx0oKfyS6/d2b0ZhOfbVqePp6j6H4R+gclBb
         9ZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU2GiCGHsCSRMJWkZ48Xm5nHBWgdedxtS4TpaWC+HAZl0AKe9Dp5Pd9gxLTwh0FmglPGqA6Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypeZNc6pjtgcIzUsjvtDh80sacLsgVv6J9OcW/qJUnT0L7L1zG
	LgLZXJetxp76xPAJUAyokYS+o4uZTnWmX9OVp28KDQ6mfTMqvv3m2Lw1VcQAYHuA4ADTcDICzCv
	GshfaCga+8dULInqGDW/RlPwAkBwU2fd0B3XsBTqwQxQ6kpqIpHlbtQOWSA==
X-Gm-Gg: ATEYQzxs1wPZoMLcdb/Av2EHeTUPJORqZ8TUXg9QT55iGv8lvdub/0K0JuaGxa/RJRW
	j8+U4CrVsXqIop5BgUo9S3KZ7DQEcngZpKufM40cY62cm4dwzXozJewkplXDg+SRd7bfZSyKfWr
	3GpGRUsigpscOinqI0OtfiWroS3WgsyP9o1syxLMwj1erfRQLDPwDEmr3wzZruoldBL1rvZoTQF
	zcs3ocXCm+M4AcHrXK5yGEJ7sq5CYlJn+lvatCQOAgi82GkMRqyxHowve9GCcDYdY1zqKFdKLG1
	XZojbpxSX11v3Ih7d0HbQCi6TYfLZLjeitxHxMSi8IUZkOlesFOYtTjM9WdYh73dRwcbh0ajO9n
	PmC/1zEdK74q3YvVu4uEkWd+AgKLY0ENq6SUEdl6c+2EHH+NpAjOb7YY=
X-Received: by 2002:a05:6000:25c2:b0:439:df60:f87a with SMTP id ffacd0b85a97d-439f8434264mr10631517f8f.46.1773311783605;
        Thu, 12 Mar 2026 03:36:23 -0700 (PDT)
X-Received: by 2002:a05:6000:25c2:b0:439:df60:f87a with SMTP id ffacd0b85a97d-439f8434264mr10631438f8f.46.1773311783136;
        Thu, 12 Mar 2026 03:36:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c0b4sm8118630f8f.25.2026.03.12.03.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 03:36:22 -0700 (PDT)
Message-ID: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Date: Thu, 12 Mar 2026 11:36:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Eric Dumazet <edumazet@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abARG4sHFdUNqcRV@penguin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,goodmis.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-267014-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DE3F27062D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
> On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
>> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
>>> <razor@blackwall.org> wrote:
>>>>
>>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
>>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>>
>>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
>>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
>>>>> when the bond mode is round-robin. If the bond device was never brought
>>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>>>>>
>>>>> The XDP redirect path can reach this code even when the bond is not up:
>>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
>>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>>>>> interception is enabled for all bond slaves system-wide. This allows the
>>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>>>>> reached on a bond that was never opened.
>>>>>
>>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
>>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
>>>>> never opened), fall back to get_random_u32() for slave selection. The
>>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
>>>>> publish the pointer to the XDP read side. A plain read suffices for the
>>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
>>>>> under RTNL lock and is the only writer of rr_tx_counter.
>>>>>
>>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
>>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
>>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>>>>> ---
>>>>>  drivers/net/bonding/bond_main.c | 9 +++++++--
>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> This is Jay's patch + the unlikely change, looks good to me.
>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>
>>> Orthogonal to this patch  :
>>>
>>>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
>>> if this makes sense
>>> for the packets_per_slave == 0 or 1 case to haves this kind of
>>> randomness in the first place.
>>>
>>> Perhaps we could use a
>>>
>>> static DEFINE_PER_CPU(u32, rr_tx_counter)
>>>
>>> And :
>>>  slave_id = this_cpu_inc_return(rr_tx_counter);
>>
>> I also have mixed feelings about this patch.
>>
>> We probably should detect that the device is not ready before hitting
>> something deeper in the stack.
>>
>> Sure, a NULL deref is avoided, bu what happens next ?
>>
>> We send a packet while the device is not UP, I am pretty sure this
>> violates at least some RCU rules in device dismantling.
> 
> IIRC when the redirect continues, the packet should get dropped if the device is
> not up (checks at a few places), but that's outside of bond's jurisdiction and
> after the slave id is needed in xdp master redirect's path unfortunately.
> I'm not sure it can reach much further, it just has the master dev's slave id
> generation in its path.
> 
> In any case we shouldn't crash in the slave id generation in the bonding,
> that ndo's only job is to return a slave id.

I'm sorry for the back and forth, but I share Eric's concern. I think
the approach suggested by Daniel:

https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/

or the initial patch form:

https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7

would be better. To respond to old concerns raised there: the check is
IMHO bond-specific, as control moves from the lower interface to the
upper bonding device, and the code is under an RCU critical section, the
device can't go away before the xmit is completed.

/P


