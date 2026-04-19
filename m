Return-Path: <netdev+bounces-279576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UgAmI8+l5GlSXwEAu9opvQ
	(envelope-from <netdev+bounces-279576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 11:52:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7E42393A
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 11:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 380C43002B50
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40D22D6409;
	Sun, 19 Apr 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY65m+fa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99772227B8E
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776592329; cv=none; b=haUYIBG3nmfAZ3VTu1OELoIHohD02hhbxrdZ6YHRgkFejYHHH5fdCzTkhO/V8Iti5fgPJMW2kQQJlSXkb0dLasWnZKpKo5Pg9Ftoj1jHAU78l59V2K//xH251ozVBnYqf6lpqzpgGluQa02kxpPb8bWZfRa5nwBfeM/NeMs60J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776592329; c=relaxed/simple;
	bh=x5IouHTJtW3DfdyihFAOCdEe97drV7RtXJLrh8Dbmq8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fvAm4wXODQZtBSuqNZLuk418exSesaFTi0Dl5lnT+CKCmtAGtrkSvIAeNh4sgNePcRMoiGZxigY3DRNZSUgw7PjnE603pBNh92IezOk50XQqb6OLiLVT2pBnCSYy3cnKrBeb10qF2joXP94z9nDS3BMwx28W9mK/DAWLd6zdmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY65m+fa; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d832f2f44cso2310399eec.0
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776592328; x=1777197128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNbDpXxBmda7i9Siqc5i89PbvpK5U76PasTjM+CK90c=;
        b=HY65m+fav+FT95aJFcWjAYVEG+fbdk4/PC+ArfN3gjYNopgedG+N3A6jpHUkgP4yW0
         F5vjuyfV5eCwsRYYDlWH5jD42hijtW48dEasC+r6Y/QwHRzxkzC5KXmnG8HmdFLPMTw0
         zkX7vlWPLgfkQibSYPbOcvNFmrobcMNm59fh6lxCIQyUZIPHJKwbqyxyRbl7rjIdoMAE
         ZdblAUR1eBiw93PimYM3YlMAnT3VE/EnReBo+BNbpiHqCtq/Ov29JiSC8CBpxV1HUjZl
         EvWHpUS3wBp+mEyN2wd6SHTY01HNFHAb+riSWaEQERaM57FMUb0UIpqbGk6TFn3XRKoF
         nidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776592328; x=1777197128;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNbDpXxBmda7i9Siqc5i89PbvpK5U76PasTjM+CK90c=;
        b=JjxbOWVvnjJfBbkcI4klL6I6KcEPUZFUSFO3U7sJ01uYPP1gkzKAhEh+akV7Oruau+
         kbEkS4FlD1XLiYnJMA7XzfDHsG2iNJMqvmqnlUHduwtRlB5bxPuGsXJU1PUrJS81RC5/
         z+ebxX9X4U7WAahXlhqJJI/2vRMv8mSXVYltf+LDZuZQdNLyWZImt+p4jzE+KcRv9JLx
         XYypJWRAqiOSYtYx8uoQnmsv1gFvdF/Lnxc0ulSQIgoCSmMPyF10fM6ve9Mm+w+rNuMK
         6f67TnQf23CAybKpzyVI1Y5ngQkgFiOxrwJRb//phl8kxEi4ADw2PFFjW3e9EsDXzem5
         Iu8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+pPF+7g5eNE7rDDiEb9O+dKV3qu7c5mXwbp9OYQHv0ceVv7ZjhfBmGBI+34tOPBvEVZFIdws8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKs6qZp0E4CqoLQYaR191yFXw461l80iZ00Gz/0C/ngtQ3jJ+o
	RyU2alb6E6L6m9/4fMaIzdU/SBZFR0QomUyRS9Suq/0C5H5m4ZMrC45w
X-Gm-Gg: AeBDiesZ9VGp5Vcpkv6KgnJnyWNWVkGQ19S3Ra9296JQGECcA3Hx5r3zVUV/oa7ZSwx
	obYDWMCFG5glg9LjuH+tsM3EocfwWBuq1V3F8jtVPE7b2lb1LtiQTCibyY5+UBY/5IXhF2T5zcB
	V47+osRW4jmRSmtg8TYIGIiquHTg0ZlAfB0cHlMo6Ntj/PMk/Csi3tFzyGywTOxwm8d5gPmRlCL
	7HV8wNKkq+kc3Wp1pvwIiY33qXnu/Vp5CzNRB6eJuPE5Ee7XmiPl2nAk6BvAqXZTGWr8uJrF1WU
	gpkOXKs6YXSo8Lwu9jnclvmcM0vlsDfztXP/q+E7eHFK8lMHokW9JifgGq8/bd7kAfFKFiGKIyf
	w26hsW0x8UtyIKFQquMCHa1kDwy9YWUGqOmHSGJz+Xv7Zq4/Bp1/Gjh6WDaWMp9rHESBbzkV/an
	duyuV7BVgQ2M5Vj7OUrrWKC3CGK1hXTlkFs1ZRvBBbjmL2R9w=
X-Received: by 2002:a05:7022:12b:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12c73fa8d16mr4469503c88.34.1776592327435;
        Sun, 19 Apr 2026 02:52:07 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm9967262c88.3.2026.04.19.02.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 02:52:07 -0700 (PDT)
Message-ID: <05a19f8d-360e-41d1-bc8a-0b4caab3d354@gmail.com>
Date: Sun, 19 Apr 2026 02:51:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 daniel@iogearbox.net, kafai@fb.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com,
 enjou1224z@gmail.com
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning
 reqsk
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Matthieu Baerts <matttbe@kernel.org>
References: <cover.1776149210.git.caoruide123@gmail.com>
 <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
 <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,vger.kernel.org,lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fb.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 64A7E42393A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/16/2026 11:48 AM, Kuniyuki Iwashima wrote:
> On Thu, Apr 16, 2026 at 10:45 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>> Hi Ren,
>>
>> On 15/04/2026 11:31, Ren Wei wrote:
>>> From: Ruide Cao <caoruide123@gmail.com>
>>>
>>> TCP request migration clones pending request sockets with
>>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
>>> subflow_req->msk, but the cloned request does not take a new reference.
>>>
>>> Both the original and the cloned request can later drop the same msk in
>>> subflow_req_destructor(), and a migrated request may keep a dangling msk
>>> pointer after the original owner has already been released.
>>>
>>> Add a request_sock clone callback and let MPTCP grab a reference for cloned
>>> subflow requests that carry an msk. This keeps ownership balanced across
>>> both successful migrations and failed clone/insert paths without changing
>>> other protocols.
>> Thank you for this patch!
>>
>> Indeed, it looks like this path has not been covered by the MPTCP test
>> suite so far.
>>
>> By chance, do you have any simpler reproducer using packetdrill? (the
>> MPTCP fork)
>>
>>   https://github.com/multipath-tcp/packetdrill
>>
>> Also, I see Sashiko is pointing to a potential issue with MP_CAPABLE and
>> the token, also only visible with net.ipv4.tcp_migrate_req=1:
>>
>> https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
>>
>> Are you also looking at that?
>>
>>> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
>>> Cc: stable@kernel.org
>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
>>> Tested-by: Ren Wei <enjou1224z@gmail.com>
>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>> ---
>>>  include/net/request_sock.h      |  2 ++
>>>  net/ipv4/inet_connection_sock.c |  3 +++
>>>  net/mptcp/subflow.c             | 13 +++++++++++++
>>>  3 files changed, 18 insertions(+)
>>>
>>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
>>> index 5a9c826a7092..560e464c400f 100644
>>> --- a/include/net/request_sock.h
>>> +++ b/include/net/request_sock.h
>>> @@ -36,6 +36,8 @@ struct request_sock_ops {
>>>                                     struct sk_buff *skb,
>>>                                     enum sk_rst_reason reason);
>>>       void            (*destructor)(struct request_sock *req);
>>> +     void            (*init_clone)(const struct request_sock *req,
>>> +                                   struct request_sock *new_req);
>> @TCP/INET maintainers: are you OK with this new function pointer?
>>
>> Currently, MPTCP is the only user, and "req" is not used, see below.
>>
>>>  };
>>>
>>>  struct saved_syn {
>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>> index e961936b6be7..140a9e96ad58 100644
>>> --- a/net/ipv4/inet_connection_sock.c
>>> +++ b/net/ipv4/inet_connection_sock.c
>>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>>>       if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
>>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>> (Maybe TCP with fastopen could be this other user to call
>> rcu_assign_pointer()? (net-next material))
>>
>>> +     if (req->rsk_ops->init_clone)
>>> +             req->rsk_ops->init_clone(req, nreq);
> I think a simple direct call is better.
>
> #ifdef CONFIG_MPTCP
>     if (tcp_rsk(req)->is_mptcp)
>         mptcp_reqsk_clone(nreq);
> #endif
>
 Thank you very much for your suggestion. We will use this approach in
the next version of the patch. Would you like us to add your
Suggested-by tag?


>>> +
>>>       return nreq;
>>>  }
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 4ff5863aa9fd..5f4069647822 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock *req)
>>>       mptcp_token_destroy_request(req);
>>>  }
>>>
>>> +static void subflow_req_clone(const struct request_sock *req,
>>> +                           struct request_sock *new_req)
>>> +{
>>> +     struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(new_req);
>>> +
>>> +     (void)req;
>>
>> Note: if 'req' is not used, and MPTCP is currently the only user of this
>> new init_clone() callback, perhaps enough to pass only 'new_req' for the
>> moment? 'req' can be added later if other users need it, no?
>>
>> With only init_close(nreq) in a v2, or if TCP maintainers prefer to keep
>> it, feel free to add:
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>>
>> Cheers,
>> Matt
>> --
>> Sponsored by the NGI0 Core fund.
>>

