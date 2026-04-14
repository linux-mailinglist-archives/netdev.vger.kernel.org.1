Return-Path: <netdev+bounces-278377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB9pNjES3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:08:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3D3F86FA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A270307EB4C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E593BC69E;
	Tue, 14 Apr 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Llr35qQS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qIur7DTG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D63A6408
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160979; cv=none; b=YeUylyBUkfq8vhFsnpSNGGugpfTW6ZOCnoKDG62rk24hB6u3lCTCvQzmSpNPWUt+gbAlSc5//irxAzUQZEGiVy82c7mt/CC0P9HbfSwUpXTGmu0vYQx1PlwcK+wu5mk8kwhnnYVfCfnQglp860p2nRELvXfYBujRoScfqsHti8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160979; c=relaxed/simple;
	bh=TMGznutSelPaLevV10rNrfK2Z8Js1xbIKFp3HaQ8RAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgjCcxuUz0IMWKhTCIKrmddBWNJCgedHAkoZHw08KHX/P7/DsBls7fpM0CWsfyKLq6iWQA2VBxNqzMHxlPP64pVBPDWWroCAamvYVUQNEmm7IMK1vXcxdt67Gv/5ehim9sY8AGlErEuMLwUCw4Vm0J7PePTLpMLwSQNpYBtlwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Llr35qQS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qIur7DTG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776160976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4rwg9mtlb7HY5lOaSaHKUxubiv+YU0hUCTj5zDJcuQ=;
	b=Llr35qQSOkxPuOYXftNaYuSBnJuW5ErnH3ZlpT7JvFc/yvzxFuQy5h4UQ4LxCgLwiePsP0
	BnDP0bkMaDlJTlC+L/LSbH94Q21uMnij7RkTaR4Q+eOOd63KkEbXcuqAsdyDUVrn6vCuTy
	vOzRw+fJFRW+Ynxa580yOyFa3OuHopc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-mOHLmqKWNtqa6pcHDsTh5A-1; Tue, 14 Apr 2026 06:02:55 -0400
X-MC-Unique: mOHLmqKWNtqa6pcHDsTh5A-1
X-Mimecast-MFC-AGG-ID: mOHLmqKWNtqa6pcHDsTh5A_1776160974
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488e1757205so13956805e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776160973; x=1776765773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4rwg9mtlb7HY5lOaSaHKUxubiv+YU0hUCTj5zDJcuQ=;
        b=qIur7DTGkFVJwrQhV2L/vKSK9a6hUEvJ2ku8+1eAY45MOCDIdOyup/85KS2Y6BiEPb
         LW8+U7U/7kyhtW7uNX8PwfKHu85m3P4JszNH+u8WRyXMVpoQYIAhwSUdIKZha5kzB7fa
         m5VG/Qm7bjDgA/9zGBWAAclDDrVISdTIrGHbHnrk4byUJf36g3otKunRJqqXKkAAwkup
         7lAzJllaYsTCEw9VErwNmNZFDxvpWAwEdqWtpMpSGsORmosJgJRxBBO99b3I8SFDLGyG
         GnhdZhltvROPdngXntFl+aEcIvHggp5tO/i5hTCVNMC9lclCN7ow/qTJm095U4czjQvu
         x0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160973; x=1776765773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4rwg9mtlb7HY5lOaSaHKUxubiv+YU0hUCTj5zDJcuQ=;
        b=NlK9eZAXpjfZ/sfHkYpwOuyeaIqLK4C/vexZW7YFRtF+SMQptPBL6t++/uWgy25IjO
         T+zXaDyTl/Dddbra5crNH13XlR8Uy9GkQyyoSnh/StxNuPqBmU21MMPIqm7Ab4iMmOiF
         EueE8aNQ5yNXi2Lp52JFnZornq4Oo9KRkipUq91wgculjbcfTeYA4FeE8z5JLqNQi/CG
         jlH4igLZBeYxx4gvQEfqVHpSRvj72DAb8Je8/b8tnPt6MTBkIlRGbMXi9ufzx+w8oYhl
         udD+3ReJ1JKImRF2n5KAEVDxrT4DRi0nwuXjqoGwlPPlwuJWCVtD3ZDQNU+GT05Ymjxo
         XJuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8qKSSKSIFXI1zGQSJS8Srj+0eAnCdEWV42rDUdzN3tRyzNG7hc+20ZHRR3VE/YbsxslyupXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9XgaNfSWS6OATZvmni2KUn3g3jzEKChyhPL5V8M7yjNBWy0l
	xgNSxl9wIzOSCe62zh7h1Co4P+NJZ1WQ4z/X5S7e5H0E5mtoXMC2nuNa7/CnqVEu6Rmc3II0/g/
	8CrNi4UtsiVPIlg3Y0FBeZzsc5RiehnpsLiegW4YaxnUxPrU7CgRhHk2oOqfCVxOYWw==
X-Gm-Gg: AeBDies1Fv5lK+J2QX8DivQvGjbsPRN7k3uqWRL29Ji0z/w1nVtbzHMSlJHmJuiCsql
	YloxbuJRz2AZLBaQ8KearJhpYQX6ZxG2p5Bh4oEir89Vg1xB/009Mc6LKczs8nHEoeIwWFSJv+x
	ZObvvCTaMYtQHMVBt3iV9ka/WyW9LMxHtFfnMNM3ZxgHwSRinr2TWSTFJusAX1sGclnlY8rcY7d
	nz368E5Z9sYrP0nbouDg93+5BAlkC2U1Ts1Dce4/WAv846Cr53kpnwcK4f5vRxdIWHqyQjyTYi0
	6cZj6iHd+iA5mMj1m4YozQo1XE/y96RcdeCQOb6um3/VvqM0sFvjDpF6ApZZTeZoeBPkZaB+Apx
	9jpNn6COBDD+DxZEY9z+fM0uwCpyG14bhFrSBYZdiizokWBSF76UCbxra
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488d67ce664mr221527485e9.7.1776160973502;
        Tue, 14 Apr 2026 03:02:53 -0700 (PDT)
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488d67ce664mr221527035e9.7.1776160973016;
        Tue, 14 Apr 2026 03:02:53 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm121156575e9.14.2026.04.14.03.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:02:52 -0700 (PDT)
Message-ID: <bbf6f2ad-9fea-445a-a5d6-d1e242df6937@redhat.com>
Date: Tue, 14 Apr 2026 12:02:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: em_text: require NUL-terminated algo name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stable <stable@kernel.org>
References: <2026041150-task-path-81dd@gregkh>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2026041150-task-path-81dd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278377-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,linuxfoundation.org:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30B3D3F86FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 1:10 PM, Greg Kroah-Hartman wrote:
> em_text_change() copies the user-supplied tcf_em_text struct from
> netlink and passes conf->algo straight to textsearch_prepare(), which
> forwards it to lookup_ts_algo() (strcmp) and request_module() (vsnprintf
> %s).  But the algo[16] field is never validated to be NULL-terminated,
> so a fully populated array reads past it into the adjacent
> from_offset/to_offset/pattern_len fields and the trailing pattern bytes
> during the string operations.
> 
> This type of pattern is properly checked in the string_mt_check() for
> xt_string netfilter matching function, but for some reason was not added
> here, so fix this up by doing the same exact thing.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
> Cc: stable <stable@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, my tools flagged this, so I fixed this up the same way that
> string_mt_check() did, but if there is some other way that this should
> be resolved, or I got this totally wrong that this isn't an issue,
> please let me know, thanks!
> 
> 
>  net/sched/em_text.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 343f1aebeec2..24a8aa21971d 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -58,6 +58,9 @@ static int em_text_change(struct net *net, void *data, int len,
>  	if (len < sizeof(*conf) || len < (sizeof(*conf) + conf->pattern_len))
>  		return -EINVAL;
>  
> +	if (conf->algo[sizeof(conf->algo) - 1] != '\0')
> +		return -EINVAL;

The addressed issue looks real to me, but sashiko found a problem with
this fix:

---
Is this NUL-termination check too strict and could it introduce an ABI
regression?
If a userspace application sends a valid, NUL-terminated string that is
shorter than 15 characters, but does not explicitly zero-pad the
remaining uninitialized bytes in the tcf_em_text struct, this check will
fail with -EINVAL.
Prior to this patch, the kernel's string operations safely stopped
reading at the first \0 byte, correctly processing these shorter
strings. Rejecting previously valid structures breaks backward
compatibility with existing userspace binaries.
Would it be better to check for NUL-termination using memchr() or
strnlen() instead? For example, memchr(conf->algo, '\0',
sizeof(conf->algo)) == NULL.
---

/P


