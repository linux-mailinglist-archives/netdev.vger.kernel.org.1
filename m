Return-Path: <netdev+bounces-278996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMKIAvO84GmTlQAAu9opvQ
	(envelope-from <netdev+bounces-278996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541740D030
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FF133022048
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3039099B;
	Thu, 16 Apr 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD0nFv01";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeY2f40p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6581C84D7
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336112; cv=none; b=VwW9KFJqSqufRIEXZWEvPITUksdI1gHAVmKCU8gN/9j8LJxuFh2Hi+SuslzBA1ko5kZxWMyeR/V1kSnH3MDEazrdbmSsy8kXAW/QZaC4BNeI2r32CvyaXWnDt2nFMgRKeHe7saiuijEwwmNVs5vrGCVcLYX5wbaG5bFAbB29Bkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336112; c=relaxed/simple;
	bh=uReS2x8I87OhnPC5farRpTTckVWcZG3FD+2YlAAqim8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbRmuwUB7R191Prf/X91IlXqrKYi7ySaPOb5iSGXcFHdWAMvBdrkse5Ly/F5zsT5BRe44m84dAUHel+MXW4iJBDRwZQNpMvb69M6ZrRBgRg5hhJMNFgHVlknZNuJzcyQBa7VTQA/qQWdmzbPR72M5O5cwvPATjj+ZdEPpIF32LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QD0nFv01; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeY2f40p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776336110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imp93CAJrgx+PsDLj+uCQzy3UK5uZ0qd7nXnz+Lrivs=;
	b=QD0nFv01ExjBy2uvgZC4G8CnA8Tq4l5+E+me2epvBHD6FkNHUmlHZj9D0R62ak/YXPzf3e
	SVXKwRrvZyuyWTnTlg3s3P45WtITs1my9wnsS8Rco9qz4kqJdZgSnoX7Ohj5VOuy68G6kW
	WzPO2WEHipQZgT5ou7a0Hp+ACm3F4i0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-nhM_v0QWNPKWDZeabKG0yg-1; Thu, 16 Apr 2026 06:41:49 -0400
X-MC-Unique: nhM_v0QWNPKWDZeabKG0yg-1
X-Mimecast-MFC-AGG-ID: nhM_v0QWNPKWDZeabKG0yg_1776336108
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so4908944f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776336108; x=1776940908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imp93CAJrgx+PsDLj+uCQzy3UK5uZ0qd7nXnz+Lrivs=;
        b=WeY2f40pRJB/BkHrNsQ3FrgPqQ4GXmKP12vbt25R/+1n9gX7ye4+9a6xBJHBrCIuOG
         Xvon499Ddpvqm0uson1VfyzBnpZrb9QyIQGLAFuIftScAz7Fpeuz21+S5oAQKqWjqjXa
         WlG/O/pWBdPJaGOrhNFEZzyX+Pi9vxzyM1cDD1HFzRno6TLFR9VSB5ISuGbq3lUax7lZ
         soXUwtKtVXwnVuT3j409jz4y7OZxrrSLPbAbr10+NtbvCoZF+W8au/9eP62tIU4aqt58
         TzWJEwiixMPfNJ8Z92jNFoFYTqPAf7zDZGMYhwCzfPFdetuV6sMkxdVBr/nTrseM6pq+
         4yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776336108; x=1776940908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imp93CAJrgx+PsDLj+uCQzy3UK5uZ0qd7nXnz+Lrivs=;
        b=Ip9wOk0gFWGWF1xPg7GHk9jgO+gPGWuOEbroLGG5O2CKSY927JYabbkzqkYyqWMOcs
         8Mhl9AwEKOXfIP+cVbdazBD9XC9ucxXb+JsbUxk8MONEirNIVOkxRu04QSpc70bIggx8
         tvBJ2zhpJcip6pVLYnfgUT8MNQVkZ/9yiin00xe8uWwAN9aj5CIUYnZMbL/GCWo8oUHE
         03m1a2gJ74qm46YJpald/AlrehAac//1zPfkqGqANBnfe7GSDD0Ia33/MCi71p9534If
         L9xuELrKeEEdqdt23tos7KhTHJ2Ygk/R0d+HLtCOs35jVIi3fiiwrDGshygqE1dcjFBp
         1CQw==
X-Forwarded-Encrypted: i=1; AFNElJ9COcSLzW1VebMf4mw72j+LvxCihEK+QgxXmRJKOHAZccevddRsxnQ6wYetme71xVvZXyZzW0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1FQpfe/lh6ekInqVQNlUsWURoAVpF7ym44qld9Dd16S+C+Uu
	Xi5bdupeCxim42va0sAQrs7P5n//kSAwM1yTCr+T4nybjx3mFJf8IL5kFn9E/qy8DMNs6tLldBS
	qRTuoPre5RleNViQDKJdrU7lWX/LsfaPrDcw9ybiTkjTb4VaNlyVISx64yA==
X-Gm-Gg: AeBDievr9QoOZE1GNDM/Otg0k7z+kJajEZsW+dsaNsB2KofC5PhOkdn8q7Ziysy7PVf
	VIucWIVWVARa/R+38LIOZ2CMulY4x4JbgG+rpwC088/UEqtvGg+O9Hu0Jbpi0Ds8jkTuhikRNcU
	CtxA1Fagr1y3Qqq19zcD6id/JI2Te6zl1H1Z1j4U//NYIasp6yvfNHyNIRTq9D0AWorloh5tI4z
	C2XMiomMGecrvZrPtjiWqXlON9C0JP0ssd8TzpFVPONcAbKUCMoBnKTk+xD/vK23Z/ao9KOxm5J
	vyCvhIcYWBSpVi3hflNXLgMdagE2B0ySdFPCPl6pOygr6dKMtEJ5Fh1MxidUTcI1BH8PbgXSYCE
	EGYDZ0wsLgSAa8qWaoB7PZkcQgpz11i49dn971s1ACdfNaU6y8gM0RZgnCiTw/WB2AuM=
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bda5 with SMTP id ffacd0b85a97d-43d9bb5bfccmr16874151f8f.40.1776336107770;
        Thu, 16 Apr 2026 03:41:47 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:43d:9bb5:bda5 with SMTP id ffacd0b85a97d-43d9bb5bfccmr16874118f8f.40.1776336107307;
        Thu, 16 Apr 2026 03:41:47 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f11sm13702339f8f.18.2026.04.16.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:41:46 -0700 (PDT)
Message-ID: <83d4b4b9-7bb4-4395-8973-a94fdc908b59@redhat.com>
Date: Thu, 16 Apr 2026 12:41:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in RCU
 readers
To: Ido Schimmel <idosch@nvidia.com>, Ren Wei <n05ec@lzu.edu.cn>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, vyasevic@redhat.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 enjou1224z@gmail.com, zcliangcn@gmail.com
References: <cover.1776043229.git.zcliangcn@gmail.com>
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
 <20260414074722.GA321402@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260414074722.GA321402@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,davemloft.net,google.com,kernel.org,lab.ntt.co.jp,redhat.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6541740D030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 10:05 AM, Ido Schimmel wrote:
> On Mon, Apr 13, 2026 at 05:08:46PM +0800, Ren Wei wrote:
>> From: Zhengchuan Liang <zcliangcn@gmail.com>
>>
>> Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
>> updates `f->dst` to another port or to `NULL` while keeping the entry
>> alive. Several bridge RCU readers inspect `f->dst`, including
>> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
>>
>> These readers currently load `f->dst` multiple times and can therefore
>> observe inconsistent values across the check and later dereference.
>> In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
>> `f->dst` after the NULL check and before the `port_no` dereference,
>> leading to a NULL-ptr-deref.
>>
>> Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
>> affected RCU reader and using that snapshot for the rest of the access
>> sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
>> with `WRITE_ONCE()` so the readers and writer use matching access patterns.
> 
> Sashiko is complaining [1] about missing READ_ONCE() annotations in some
> places, but I can handle them in net-next in a similar fashion to commit
> 3e19ae7c6fd6 ("net: bridge: use READ_ONCE() and WRITE_ONCE() compiler
> barriers for fdb->dst").

I agree they can be handled separately, because they don't look harmful.
I think a 'net' patch could be used for such follow-up (data race)

/P


