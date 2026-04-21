Return-Path: <netdev+bounces-280031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKjFK+Er52nv4wEAu9opvQ
	(envelope-from <netdev+bounces-280031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5391437D73
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C09C430131A7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE331F9B4;
	Tue, 21 Apr 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="X0NCrz35"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A21FB1
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757128; cv=none; b=LZmjyNrRf9YbsC2xfnXhrmsQw0ZGsAuIZVIrlwuqa7XTsxmKMpBuLTMORZKctpEWriRt7aWhiwm4VQAimXGKLNn5NOcYIsGVryTzujsNIf3XJNjTgTMrORvq4TiNrK0YzIbLiFGaT+Ca4QeY+Wu1dJP0LjYfaHeY7i6gcEnL0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757128; c=relaxed/simple;
	bh=T8+txFGJbSd7pqG0VM0u/AKNe/d5ZsR4Somkcg9M2hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwEza62N8/YRMIXtg9K+VwKvashtBOrTZAzVTDAlfwGnDNDQxCZ48sHGMdyhqXUTUXvGnvnxeDYkAbDcKAZqHCmX7vuPvVrp/sq/8JGBLGBMvNr45g3oxpkg/c2IvPVNyj8WDlgCe0QM71a+gKXTB4cyfnXC5bCglcU95vNf3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=X0NCrz35; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mmzYx+XSlrG3aJoi8HyzFYPaBUsofyWO1FoGWRs4/P8=; b=X0NCrz35DxRc9cRkitFAhH9X6+
	yk0poLY9ubaIC47GPvnNOYZARrrokzT9TwogccnvZnREFWG1YF6hPgH+PlHhFUqbDPA8V1ZzHQXES
	2yOS2iuoHi1p0Dl77enCvaQEczjGjK3NkZ3C3Tl+4TqUlXs2Gi63ZOtISNPO0RPXcJGQdTzWvKRq3
	gaQR8gWvZPErN6dphtYDT8Q+80+h6TMIY68syrJqrw2eqLfXTAPf8Unml/3UT+LnSYCL2ZKffhnZy
	okSxRecHLwU7a522hCB8J22sUBS+c50a70ItvPNkRYaxzTkDNz95Rf2PfyNYZ8CcpUflwLUDzYmzl
	Sd9MDNrg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wF5gy-000DAd-1v;
	Tue, 21 Apr 2026 09:38:44 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wF5gx-0009jm-27;
	Tue, 21 Apr 2026 09:38:44 +0200
Message-ID: <c97b3bd6-e79e-4f78-a29b-77d4fa20e32a@iogearbox.net>
Date: Tue, 21 Apr 2026 09:38:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Justin Iurman <justin.iurman@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
 <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
 <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
 <CANn89i+Y0jctj8=tCHFP5jDSJBAWR=RvNfagammc-WqU6EdPRw@mail.gmail.com>
 <75d98880-afcd-43f9-8bd5-b874fa5690f5@gmail.com>
 <e084bf5d-99bf-4e23-8dc1-3e7e13c58a2e@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <e084bf5d-99bf-4e23-8dc1-3e7e13c58a2e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27977/Mon Apr 20 08:26:26 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280031-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: B5391437D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 4:15 PM, Justin Iurman wrote:
> On 4/18/26 15:46, Justin Iurman wrote:
>> On 4/18/26 15:15, Eric Dumazet wrote:
>>> On Sat, Apr 18, 2026 at 5:50 AM Justin Iurman <justin.iurman@gmail.com> wrote:
>>>> On 4/18/26 14:26, Daniel Borkmann wrote:
>>>>> On 4/18/26 1:45 PM, Justin Iurman wrote:
>>>>>> On 4/17/26 19:18, Daniel Borkmann wrote:
>>>>> [...]
>>>>>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>>>>>> index d2cd33e2698d..93f865545a7c 100644
>>>>>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>>>>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>>>>>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>>>>>>>            .extra1        = SYSCTL_ZERO,
>>>>>>>            .extra2        = &flowlabel_reflect_max,
>>>>>>>        },
>>>>>>> +    {
>>>>>>> +        .procname    = "max_ext_hdrs_number",
>>>>>>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>>>>>>> +        .maxlen        = sizeof(int),
>>>>>>> +        .mode        = 0644,
>>>>>>> +        .proc_handler    = proc_dointvec_minmax,
>>>>>>> +        .extra1        = SYSCTL_ONE,
>>>>>>> +    },
>>>>>>>        {
>>>>>>>            .procname    = "max_dst_opts_number",
>>>>>>>            .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
>>>>>>
>>>>>> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
>>>>>>
>>>>>> +1000 on the need, but NAK on the way it is done. IMO, we don't want
>>>>>> yet-another-sysctl for that. Instead, we have (well, not yet, but it's
>>>>>> about time) this series [1] to enforce ordering and occurrences of
>>>>>> Extension Headers, which is based on an IETF draft [2] (FYI, draft-
>>>>>> ietf-6man-eh-limits is dead). I think we should enforce ordering and
>>>>>> occurrences in this code path too, instead of relying on a sysctl.
>>>>>> Let's keep both code paths consistent.
>>>>
>>>>> Hm, that series [1] should probably go to net instead of net-next, but atm
>>>>
>>>> +1, would make sense.
>>>>
>>>>> hasn't moved since a month. I'd still think max_ext_hdrs_number would be
>>>>> useful given it has less complexity also for stable, but I guess ultimately
>>>>> up to maintainers..
>>>>
>>>> In the short term, I agree. What worries me is that we end up with a
>>>> redundant, or even useless, sysctl once the other series is applied,
>>>> which will only increase user confusion.
>>>
>>> Given the amount of bugs in this code, a sysctl is safe and quire reasonable.
>>>
>>> No one will object when it is eventually removed (or has no action)
>>>
>>> For the record,  I approve Daniel patch.
>>
>> Fair enough. If there is consensus on this patch, then let me just suggest two changes:
>>
>> - make it clear in the sysctl description that it mainly applies to TX (as opposed to the other series [1] discussed earlier that applies to RX)
> 
> Sorry, I meant it does not apply to core RX (ip6_rcv()), which is what series [1] does.
> 
>> - set the default to 8 (which should be the max value) instead of 32, as per RFC8200, Sec. 4.
Ok, I'll switch to use 8 as a default limit and I'm looking to also cover ip6_rcv()
path as well in the next revision given its also affected but less severe as the
icmp6 path.

Thanks,
Daniel

