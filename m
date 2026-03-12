Return-Path: <netdev+bounces-266964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK7VD6+KsmneNQAAu9opvQ
	(envelope-from <netdev+bounces-266964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:43:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00426FC46
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9086130AD655
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921A3B47C3;
	Thu, 12 Mar 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="habS9Tvi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIfEsEl4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FC3B2FFA
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308451; cv=none; b=N2UMR+ACBoQ5upVZ2z89eNgUOev9rzEIlXr/ijIYax8iWeAk/D69/sgsIUfTV/NsJ62FyotpFH3DTBj7aCHBlsIfaeFfjUO8Jr8v4dnVbFgmkBVkL1F2lcMdH9aZiGKcgwwkByrNq1YCnaiB3RfYoo0WBBLvk/JAeyqleCsNarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308451; c=relaxed/simple;
	bh=ddEVo4L1jDTJ75CDuotLTBCt2IwHCurzLzGzvhrGLB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbmigLvF0dlapTrhpw2t5MW2/suGhecpilnTGWFDqvZwHuQId9fjz7XZ1A/WYhaqCZCfUSN+TqweuGlQdrc+YiCauw1wvOAMbCp2TEM2WUTtQzvlawYMI930EMAGGSeUQxxxOVURGKJ3ena7DRhmtP8tKXdwZ/PtNnL7og+Y+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=habS9Tvi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIfEsEl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773308449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6EdyD35EC+SpPH1TY5bENOyft6Ge/0pFEQiQDyadAk=;
	b=habS9TvitoXdA0y1Ol2EBDShvBplk6Z9I7msfNJw56LwzALTv28ogf+TP4aGY64qGBQlnc
	x6AUi36K9fjLu3y64VX9m1SJPFkXyKza5MpwVXfOKO/vNmdp5kYZHe909By9qeN/uCMg1b
	2KwPMaHAJBtVm0/6ILBOMt2oh5zXen0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-BRNIAlXMO-SG1AfH1oNmiw-1; Thu, 12 Mar 2026 05:40:48 -0400
X-MC-Unique: BRNIAlXMO-SG1AfH1oNmiw-1
X-Mimecast-MFC-AGG-ID: BRNIAlXMO-SG1AfH1oNmiw_1773308447
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439bab2d095so467458f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773308447; x=1773913247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6EdyD35EC+SpPH1TY5bENOyft6Ge/0pFEQiQDyadAk=;
        b=eIfEsEl4s9AAZ3jWXp+IHQRc/xX60iWLK1BBo3LsBX0iINPerVsaHlOAoFCoxvRqIT
         efIMsFpmroymfPY0xWCP+MfiIpwQolNJG+g0Xg31bkI0Yew+sH/BeagEfmp/nnMU7EIW
         JR4HJa4aP76PDj1hkhFyiacHe1KbOWxFpTRq2zx2Y8MNUMgYAwk27fO8uyOkLRSmxTj9
         jsCGHcLpstxu0Y5vDNZTYStzZHqMvrInAWNz6lJEcN2n6PZE/eeNdQVfCWJofQUtkJ4D
         kOw5THz6NTYP18uE/OOlHu8PkZQDxGgXIU+6o1LmScEMDt7IaVNKhjN66+3yuA8g1BjN
         9ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308447; x=1773913247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6EdyD35EC+SpPH1TY5bENOyft6Ge/0pFEQiQDyadAk=;
        b=jLwJGitZGk5uMdIKVSJHBVol7F6Cmy742NlNJKEE2o9Zr0hIQKB5XibXOaguNyj2LN
         pf5AYrQnjkrUb153YB8b7DJak+TnTpW+I97m8AylN6JkWIlYr8ZJ7Nq+2BF28nDgOpGx
         LcEnQkd5VY9E95+LLO2clrcJL9VLKltuCd8jEJbx7h1DcyZJoj8FjQR/Yt4zFLbrshLN
         z8++09bqBBckAtEWFmEJx1xkq1VF1jhLPvL7VHiwUKIS1nRrOMyRp9uq4PY0KBMo5Pr2
         pT1uP5FVtnuUtTAMxNz9R65pLmP2SEJAm8N7WtmDktgXwgRhJvnSUsjblh/fJln8aRjt
         ppdg==
X-Forwarded-Encrypted: i=1; AJvYcCW4VdjpWzyYGm8u4HcNJV7/Icgs4yuDjcSHnVG4iHi9jf9f1c6XNCV/+HGsJVNfAuqmubCeYl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm02QWJBVYyxUWT3yUxBL6NEih2ZemXe34wff9ViPzJE7nsDDX
	xSRerhGrq8YR3ne+eHP3Mz3OoaREjVKfZmoBvZo4j4rWD3aMyQEpNDN9v8c3E1WKwjJi3WICMcz
	DPCjOsDfqfxmRY4oaCVaDU1209v+7dVO22Z3gQvT7L1o2SxFbYWpQEVFOJw==
X-Gm-Gg: ATEYQzwonDwmUYOxX/xQ63qWjdKIQuri7b38C6fg0mVpxcroGNOxXlPjAqETapQLW5O
	GglhdWjh3Z0wBgWGv+JVexmw+aqmrIMOESFOgoCSpeQggHKAg/xlxmW3c7wx/0MTmy32xx8wvLy
	0nlmyXM8N3qWHVFivANk6SHeRf1biVoxZs3HvSuzgI+gHuJpSDwadkumovMvp6uIUS47qVFAqsi
	b0YMhiBxlcownh4xap1RF3HgSwWgNbiB8CHw2g1TeSXhHwZplbnEzeaj5TMrMQKID0HhOteqg3Z
	mH0fTPJfJ+U+h7/q1bJ8SJf5lP5C3Dae+w2l6puagTYbTNoJCIp/6x3KKdbLoxZ3loW+5eGJOpy
	wfik8Rp1Ks6xyWNxQHyci1W6/bi2InbKvqJNYCfpLyv/JBT+EUYMfgK8=
X-Received: by 2002:a05:6000:228a:b0:439:ca64:967c with SMTP id ffacd0b85a97d-439f822b9d9mr9932340f8f.44.1773308446716;
        Thu, 12 Mar 2026 02:40:46 -0700 (PDT)
X-Received: by 2002:a05:6000:228a:b0:439:ca64:967c with SMTP id ffacd0b85a97d-439f822b9d9mr9932296f8f.44.1773308446263;
        Thu, 12 Mar 2026 02:40:46 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22f3a4sm7155566f8f.38.2026.03.12.02.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 02:40:45 -0700 (PDT)
Message-ID: <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
Date: Thu, 12 Mar 2026 10:40:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features to
 ndo_set_features
To: Sabrina Dubroca <sd@queasysnail.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
 andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us,
 jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, razor@blackwall.org, sridhar.samudrala@intel.com,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com> <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora> <abHcP3GTO29rfKML@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abHcP3GTO29rfKML@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266964-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[queasysnail.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 5D00426FC46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 10:18 PM, Sabrina Dubroca wrote:
> 2026-03-11, 00:47:41 +0000, Hangbin Liu wrote:
>> On Tue, Mar 10, 2026 at 08:17:01PM +0100, Sabrina Dubroca wrote:
>>> 2026-03-10, 10:02:09 -0700, syzbot ci wrote:
>>>> batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
>>>> hsr_slave_0: entered promiscuous mode
>>>> hsr_slave_1: entered promiscuous mode
>>>> ------------[ cut here ]------------
>>>> err == -EMSGSIZE
>>>> WARNING: net/core/rtnetlink.c:4421 at rtmsg_ifinfo_build_skb+0x218/0x260, CPU#0: syz-executor/6496
>>>
>>> I'm not sure this one is caused by this series, but either way,
>>
>>
>>  rtnetlink_event+0x1b7/0x270
>>  notifier_call_chain+0x1be/0x400
>>  netdev_change_features+0x95/0xe0
>>  __netdev_upper_dev_link+0xb20/0xc80
>>  netdev_upper_dev_link+0xb0/0x100
>>
>>
>> This patch calls netdev_change_features() after __netdev_upper_dev_link(),
>> Which trigger a NETDEV_FEAT_CHANGE notify and calls rtmsg_ifinfo_event()
>> to fill the new link info. Maybe the event is a bit early and macsec has
>> data not ready?
> 
> But this would still mean that there's a mismatch between
> if_nlmsg_size() and rtnl_fill_ifinfo(), and your patch is only
> revealing it.
> 
> I'll send fixes for the stuff I mentioned, no idea if that's what
> syzbot saw since we don't have a repro.

It looks like even the nipa CI is reproducing the issue, i.e.:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/554921/17-rtnetlink-sh/

more failures here:

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-12--06-00&pw-n=0&pass=0

the fail in mascsec-offload looks quite deterministic, could you please
have a look?

/P


