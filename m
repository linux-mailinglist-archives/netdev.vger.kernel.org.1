Return-Path: <netdev+bounces-258717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHXDJ+ifkGnkbgEAu9opvQ
	(envelope-from <netdev+bounces-258717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 17:16:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A013C711
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 17:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0BA430055CE
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9669E2EBBAF;
	Sat, 14 Feb 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAbHQKyz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B72DBF75;
	Sat, 14 Feb 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085795; cv=none; b=ERE0hj+0gmgAhkEJrquYOegQn9DxNPh26refv2PSnsbbOMrT7KNNAY2Raufe3o85/pXhyiUkFNrfLOCzgf+funbmyTZuSjBjvitVOdcXPh0VgseAkF8oYyEP9wflFnwDD0DgPy9G9riHHwFYLC1KU4toqw0f8wVsFxyD5EEyaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085795; c=relaxed/simple;
	bh=v2cxWJ0WVa3FM/4hmjOWImfq5uRj5p+r0ZK5T2lnejg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab5q8xqkFdgD7F55/gJVZEnuWnwna6zVvFl31VfbBqg//7oFSuU+XQ5Guq8U4hT5Dql4MUxVIldrFzd3kVG5jh9NTCVpd3/JZBFDIYQgfn48KqWoXlbL5RAVANZNZarbX3JEv+O1IdWA+JjnUHQQTLO+ayeJcxy1fZlHvkEN5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAbHQKyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D448CC16AAE;
	Sat, 14 Feb 2026 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771085795;
	bh=v2cxWJ0WVa3FM/4hmjOWImfq5uRj5p+r0ZK5T2lnejg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jAbHQKyzgFx5/+v5t9D4pb8Qqk6fCDsrGKS0Pf6cBNVl5nIso3h6XHPyXRp362eCp
	 R55ds/BvQOt0fnzTjdXRGvDQErMNwbe9ZHRDfQVuSlJXOV75x6mMte/NMPnljvdYa7
	 NwrPOf8abtqKPaaTIFYSN6Qzj+TrhIrz+VqrhIOh75RuC4OEJTDMOt5HUZgfA+Ti7e
	 7tlty8xeohvPpITkZBl09d85wT29HIZeA5eDXHWluTc876tKDwpGpBKKdX8RBhYcQB
	 c30KE5oqSaMWQYOQyCHVB4CjJckwX5+MEolfMwDxYvRzoIAiHqTU9SvM6cTjKFP8Bk
	 NESFNtOh7tWQQ==
Message-ID: <5c2aae9b-b0c9-4fe4-bc92-45ada8f7cdc1@kernel.org>
Date: Sat, 14 Feb 2026 09:16:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Potential Null Pointer Dereference in nexthop_create_group
 Function
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, =?UTF-8?B?5Yav5ZiJ5Luq?=
 <23210240148@m.fudan.edu.cn>
Cc: davem <davem@davemloft.net>, kuba <kuba@kernel.org>,
 pabeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <tencent_5E937E37585390AB0DB7DEE4@qq.com>
 <CANn89iKWn9i5TJNEiU1e1X4km-aK-J1dAvJSLbw5YOD-5EvY9g@mail.gmail.com>
 <CANn89iJvjpBNOjV6cv08bE+uBgur-5AHpyhB5P-s3Jzr3+SLWQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJvjpBNOjV6cv08bE+uBgur-5AHpyhB5P-s3Jzr3+SLWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258717-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81A013C711
X-Rspamd-Action: no action

On 2/14/26 5:37 AM, Eric Dumazet wrote:
> On Sat, Feb 14, 2026 at 1:35 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Sat, Feb 14, 2026 at 1:17 PM 冯嘉仪 <23210240148@m.fudan.edu.cn> wrote:
>>>
>>> Dear Maintainer,
>>>
>>> Our team recently developed a null-pointer-dereference (NPD) vulnerability detection tool, and we used it to scan the Linux Kernel (version 6.9.6). After manual review, we identified a potentially vulnerable code snippet that could lead to a null-pointer dereference bug. We would appreciate your expert insight to confirm whether this vulnerability could indeed pose a risk to the system.
>>>
>>> Vulnerability Description:
>>> File:  net/ipv4/nexthop.c
>>> In the function nexthop_create_group, we found the following line of code:
>>>
>>> if (!nexthop_get(nhe)) {
>>>
>>> The issue arises because the nhe pointer may be passed as NULL in certain situations. The statement passes the nhe pointer to nexthop_get without any check, but nexthop_get might contain a dereference operation on the nhe pointer, which could result in a null-pointer dereference.
>>>
>>> Proposed Fix:
>>> To prevent the potential null-pointer dereference, we suggest adding a NULL check for the nhe pointer before attempting to pass the pointer to nexthop_get.
>>>
>>> Request for Review:
>>> We would appreciate your expert insight to confirm whether this vulnerability indeed poses a risk to the system, and if the proposed fix is appropriate. If there are reasons why this issue does not present a real risk (e.g., the NULL check is redundant or unnecessary), we would be grateful for clarification.
>>>
>>> Thank you for your time and consideration.
>>
>> This seems legit, I am not sure why syzbot did not find it yet.
>>
> 
> typo  in @nhe. Should have been
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 7b9d70f9b31c7ae6b2039cb321845b852bc81a33..36c58e4d5f0044e43498ea915ee2079864fab1e2
> 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -2742,7 +2742,7 @@ static struct nexthop
> *nexthop_create_group(struct net *net,
>                 struct nh_info *nhi;
> 
>                 nhe = nexthop_find_by_id(net, entry[i].id);
> -               if (!nexthop_get(nhe)) {
> +               if (!nhe || !nexthop_get(nhe)) {
>                         err = -ENOENT;
>                         goto out_no_nh;
>                 }

rtm_new_nexthop - called with rtnl held
- nh_check_attr_group_rtnl validates all id's in the group list
- nexthop_add
  + nexthop_create_group - rtnl was never released, so if the id was
valid earlier, it is still valid so !nhe is not needed

This is why syzbot never found it; nothing to find.

