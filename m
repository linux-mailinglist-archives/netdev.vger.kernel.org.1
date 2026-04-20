Return-Path: <netdev+bounces-279906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDmxEHx65mkHxAEAu9opvQ
	(envelope-from <netdev+bounces-279906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:11:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003C4332E5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4037E300D162
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782B3ACF10;
	Mon, 20 Apr 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy2gEmPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D942382F0A
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712313; cv=none; b=QBioU1PPR9+REWvPFEHe5OM00mGWJcryD9n8pakUXxRM8SjiXFYGqHOUPriPAO+tanB+dLFu4c+sfJl4LsXj1hGHTePmwOMFMYBbZqZrOlBXjy8ovbztOnXTl8Di2S2hA5lkunPjbQwy8OrooG8Di7pRdBp9ih63juaNbxXswZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712313; c=relaxed/simple;
	bh=sxZ00doArFEGSbugWyjUCS2Weg3XpDc7Tf55R5uMTOE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hqnRYeadFm4xsEmA6IHfW0ubkRiEq520XlfEfOdBcVELlm+kEFKiPm7kjdUxHzySFcg8+f3oLotY7GWpS3DxV+k6REV+k9hA8jdRz50n0e1VA/O2Kv1BL2O7Uv48SVnnYiwvaf8Xf4f4gNB+9S3CUM6sg08Hk151QbzZdHQutf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy2gEmPx; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so3186752eec.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776712311; x=1777317111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2BLM5ame3A0aMHerconHeaLCipS0GCxKfF5pU6TgVE=;
        b=iy2gEmPxl+1OSXicRpAxYTeMiBmIItu0qVgzd251mlaO8inUdXHhSxDpcXfC1GMG+P
         y9XWAffmkTLi7i8WjjLiM9Hb/iw98pVQVIWamLALxHkjtsTov9EjalYqFRehmRIKgrxe
         d2+DFZP0QmiAZcq5N0u/U2baVGcabcWnL345whdjXkOkZi88FL4mL7VUCYUQxZI48n2b
         LImZESBrPIPEIkggjKm85DYTi1MkEuaCJEH/kBjyi9saATQsXcK41HfBvolO6mkNJjwu
         NAxGO7oeHi1pSOyiXXAZKSLSHYXLWNSiwOwF592m3h/5XAvKwh8C9urp4XF43enL1i+0
         6zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712311; x=1777317111;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2BLM5ame3A0aMHerconHeaLCipS0GCxKfF5pU6TgVE=;
        b=VU+iL/HxxLksxWPY8db61AM6eU5PDP8NCHWK3CnyQkeY52PeQr0VkhWa53/+LTQb1e
         bD5jmKijyLFg1YqVrmO4Qw8nDGscN6lsfzHBgGSOnIrIVsj0KIHqVHewfmDGJKlpOajp
         RUi43NYbJ0d2JMoPybBJ0PVgEFaXFZWwx45kA8ZxYnEr1s+v2XAtYL0MZeah3pytvc9U
         +N04LHfhllVArsBLkYCq8t6UXtZtx5wxx+Qi0TxXqAHHssx2wuKrCZpKJASdGazRu7XX
         oe6Ei6l95Q5HGo4HYTvMum818EUkZyX/VPOVXAHQb365UYgqbOiRLaVaMsvdRnP/GmJd
         gxsg==
X-Forwarded-Encrypted: i=1; AFNElJ9mqRkIA9DbBOD2+EZCWi9snwoB+qxUbjqSmAabbraIXvo0QsicGMX701lGGck1rb30xabsPyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwjZWceoeljE++h2HzG/HD/Plxwe5rfGSfJqANw7da31iOwJh
	cgiXkj8VDRs0TUnvdWdMUz55UMLZ/fwJ6P1Mui+gUBc8xcdqmNik55+p
X-Gm-Gg: AeBDiesdUBJJupJVvffa8wl5cRm/vvxZMAS/tDoWtwa3LSTeEKUDu25Jp2UXI1OHBrL
	9mh6dG6+lrXQlrjfXkZITdOVj5+ubzQi+rVtxt5lsrHQufSYzsewvX61WwuYGmWDtnKAH+X4/wS
	rMjfC5wAiGm2WioAFl3yoB3IQ6gA+czPA2FM/j5jrPEOC4n0Pz4oeXHicEwyUaMRX6J0eWz/4WU
	b1G1yvUjV0SlZY/9hm1CgU0VhrO9vw+yaxztPDARRjGhRMtVmEwUFPhtsR2hCvVOxb1P3fasqD+
	J+RtZUBRpiT8JqXqr8FnNcKgx293Ot8jpcShpGlPjdSC3gxyT+fFnu0fqVcmZ0dLfbRsCSepDrY
	T/AyIGBI2IADBXFbeuJEr8V1YRJAcxeIMA2jipykNHYt6+BJxAf4iu3HwsnSOLLh0g/Frlb9mDU
	LKDGjyzkaGQzHhhBHhB2+fhuY3TQXjUrtDjQp6T6FSkSGC+o281SDSz+8Bhg==
X-Received: by 2002:a05:7300:ca4:b0:2e1:e5c0:7992 with SMTP id 5a478bee46e88-2e477c9aa7fmr6734109eec.8.1776712311175;
        Mon, 20 Apr 2026 12:11:51 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c38sm15348215eec.5.2026.04.20.12.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 12:11:50 -0700 (PDT)
Message-ID: <828acc6d-9ee2-4ac0-96a8-4414be68b36b@gmail.com>
Date: Mon, 20 Apr 2026 12:11:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, linux-hams@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kees@kernel.org, takamitz@amazon.co.jp,
 kuniyu@google.com, jiayuan.chen@shopee.com, mingo@kernel.org,
 stanksal@purdue.edu, jlayton@kernel.org, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, tonanli66@gmail.com
Subject: Re: [PATCH net 1/1] net/rose: hold listener socket during call
 request handling
To: Simon Horman <horms@kernel.org>, Ren Wei <n05ec@lzu.edu.cn>
References: <cover.1776327338.git.tonanli66@gmail.com>
 <52776256bf0fc38de92fe3edf39434538b672b69.1776327338.git.tonanli66@gmail.com>
 <20260420162605.GV280379@horms.kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <20260420162605.GV280379@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,amazon.co.jp,shopee.com,purdue.edu,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-279906-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 9003C4332E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/20/2026 9:26 AM, Simon Horman wrote:
> On Fri, Apr 17, 2026 at 07:01:51PM +0800, Ren Wei wrote:
>> From: Nan Li <tonanli66@gmail.com>
>>
>> The call request receive path keeps using the listener socket after the
>> lookup lock has been dropped. Keep the listener alive across the
>> remaining validation and child socket setup by taking a reference in the
>> lookup path and releasing it once request handling is finished.
>>
>> This makes listener lifetime handling explicit and avoids races with
>> concurrent socket teardown.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Cc: stable@kernel.org
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>  net/rose/af_rose.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> Sachiko has provided some feedback on this patch.
> I do not believe they relate to shortcomings in this patch,
> and I do not believe they should block progress of this patch.
> You may want to look over them for areas to investigate as follow-up
> (maybe you already did :)
>
> ...


Thanks for your review! Yes this module still has other issues that
haven't been fixed. We'll finish what we're currently working on and
then take a look :)


