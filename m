Return-Path: <netdev+bounces-258854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB20Drnukmnr0AEAu9opvQ
	(envelope-from <netdev+bounces-258854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:17:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9C14246F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D59B4300F118
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18012FF65F;
	Mon, 16 Feb 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7KQ7QFO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="noJ1yL5D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10542FE592
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237043; cv=none; b=T9ISTw0eJzV0NTRlAST5WLY7t3hFzR3CCmyJCQqS+/DeBoarmOpYtZR/O3nKyNHE9ttpTu2Aachjt/5v44CxMPtft0jTnSttk3LQIBcHA0XAaJcZdoJmWcNWvbOiceOgTSLiE+1XMExtOjcuAywmRBMmWweYFO1DKNXU4T1F2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237043; c=relaxed/simple;
	bh=0zDHtfv8qspxQYglmq0oiYODqhTdn6YBLZILaFyNRTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpXMwK/I4B9T8t/3X41ikAvPc7rHyZpDHbw8GB0S7gvOkvU2GJfWwDx4vsevInIBlzHyfNqxuil9cRz5oBf0b4yQioFsuLZLB2lRnUNBBptpHAU4jn4bGRdrjIdw0C6Pp55/9xXRDBFcucs4/qeG1wxp39izg1lpXj6ZimpJgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7KQ7QFO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=noJ1yL5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771237041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yb7OGgpTNEFfkjx4Rmk1WWreqSU+Z5g79yg5S07yOL4=;
	b=O7KQ7QFOEOVmloXDuv6QMYRxhdpYmcTjdwQtMYTRHojov77I7/EpWtXBU5mArvJUJhk0xb
	JVQbLqbFYNcWdoI8QUkuz9vdOmw+uLl1r5xH/huoK0qux8BS1sgYR9PbTy3mCyKMgbneL5
	pZWJ/s1Kt+OCeBJ97yDDwugUGW39jOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-qOnOK3ivOKisscaEDQyaGw-1; Mon, 16 Feb 2026 05:17:20 -0500
X-MC-Unique: qOnOK3ivOKisscaEDQyaGw-1
X-Mimecast-MFC-AGG-ID: qOnOK3ivOKisscaEDQyaGw_1771237039
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so15140805e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 02:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771237039; x=1771841839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb7OGgpTNEFfkjx4Rmk1WWreqSU+Z5g79yg5S07yOL4=;
        b=noJ1yL5DShH49tqj8pw8ThCApinB6si49HmHqaYMojXXlAOd/wIAXypd4qFwZ/6NRg
         URig8zGiMsTRteRPJLZyXcElIZyWHN2vDO30R+exOQnUy+4OTPLY5uRVTU/8k9w7brWR
         5eGNy8N2z+PGiNvunA4jisgd7851XzmUwyAXjs1Z18nI5eTGIRJU1ZvtfFy4HYQNBoUw
         Yjpd+fokiPcowOzmCln41pAKQmvzGGNyzjUDg3px5gv53RU0aujWdLnmKcZqRalJUUTK
         HT2zlnZTZ6iXhOKDz+Rni2fMHMhe5B4LtBy5AEtd7En/re/txmCN9o43z43eolyehALL
         HOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771237039; x=1771841839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb7OGgpTNEFfkjx4Rmk1WWreqSU+Z5g79yg5S07yOL4=;
        b=d8hvopMQsXxmDkgatcAgJQlUZBfP/aIc3gxox3p80KlN3f7FUlx1g2NcGPrOBQ1JTy
         SJpJM1EWIulxQ0YTZookZ6p9jpUU1O6A+Fo/Hxb9B8h+hKcjX+H2O9OVbs1O5SJ5GhYO
         AvSdfleLm3xDTE11Xlr+k87ebT0LnvyXS/lv/68jeMh7eq+0BDFz+pLMZMLSs8RmHkOw
         +ycNI8LRFH0x/JraOLbyRwS7en/VmGoyR3fcpZAazweMnWmutFCSZpWBpt/nc7QGnSge
         p18EqHFU9ltTGZJUIEnTHIPHrmCbvP8fC1mj+HftBI1BrJLhOnJe4mr7pV11rtk7QOhI
         0Esg==
X-Forwarded-Encrypted: i=1; AJvYcCW7M8Nh6jtFqOhWtW8m4aNF+6vRFxUMm84mtykJyMtQDWb4MH1nZutR1z7R7P1U5LLsy9bMQdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVabW5OAt6SfL5dRTbQBZZepytQCtM1KbioIibacE6MHrSobLW
	jTYYpMEWuTH+lqKQ+BoKVEAnNgVOEq7wqhtDCT+hrFtu5bXCI0RhGak0zQDGj5o9yYfIwb6RR9s
	Ln/RYdGkwvMhoUGCWqT2IupxKD1wKtnnSFqFiRepDv26fG94nmWYNs+05yg==
X-Gm-Gg: AZuq6aI0w6LPK+6Dzob8ALvKm7O8z5TCLdihc5AyTjV1fh3tE8TT6AWi0kBjTKXRFDA
	5UfThfvU7a+VP4U6xV8aswXAwTMNKeoEAyiCC2cg9lVlir26Lx9GH41Ti2BUr2MR861HC6wsqPf
	lUNLQthho4Zc7MEQ0LBw20YqaKKhrxy6lroQgYdkOBylKip2vNglNtbH3nnTsUqBFYpizt9zQhI
	YxYi+9olcdG37pYp0v+kYlDVKk7Tz0RbDTiCCF7nw0YGlCr9nk6wGshmB82H0ivpoAlwr07vnh3
	MFq5r4Qij3io/3CShJimgkVXuWj39hPwFbNymzjg/Z3oWE8qF55FfMFHKqZRglCyQRIZiWlGMIN
	hlY9rff8y3Dc5uApmmGEWyfKgPg==
X-Received: by 2002:a05:600c:1c25:b0:483:54cc:cd97 with SMTP id 5b1f17b1804b1-48379bfc340mr112130285e9.36.1771237038807;
        Mon, 16 Feb 2026 02:17:18 -0800 (PST)
X-Received: by 2002:a05:600c:1c25:b0:483:54cc:cd97 with SMTP id 5b1f17b1804b1-48379bfc340mr112128895e9.36.1771237037128;
        Mon, 16 Feb 2026 02:17:17 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d834ebesm450987525e9.13.2026.02.16.02.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:17:16 -0800 (PST)
Message-ID: <965db568-f5f0-4b66-a5c0-cad96c5bae0a@redhat.com>
Date: Mon, 16 Feb 2026 11:17:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Potential Null Pointer Dereference in nexthop_create_group
 Function
To: =?UTF-8?B?5Yav5ZiJ5Luq?= <23210240148@m.fudan.edu.cn>,
 dsahern <dsahern@kernel.org>
Cc: davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
 kuba <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <tencent_60BB14B216A3DFF94F6928CE@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_60BB14B216A3DFF94F6928CE@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-258854-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90E9C14246F
X-Rspamd-Action: no action

On 2/14/26 1:08 PM, 冯嘉仪 wrote:
> Dear Maintainer,
> 
> Our team recently developed a null-pointer-dereference (NPD)
> vulnerability detection tool, and we used it to scan the Linux Kernel
> (version 6.9.6). After manual review, we identified a potentially
> vulnerable code snippet that could lead to a null-pointer dereference
> bug. We would appreciate your expert insight to confirm whether this
> vulnerability could indeed pose a risk to the system.
> 
> Vulnerability Description:
> File:  net/ipv4/nexthop.c
> In the function nexthop_create_group, we found the following line of code:
> 
> if (!nexthop_get(nhe)) {
> 
> The issue arises because the nhe pointer may be passed as NULL in
> certain situations. The statement passes the nhe pointer to nexthop_get
> without any check, but nexthop_get might contain a dereference operation
> on the nhe pointer, which could result in a null-pointer dereference.

Indeed even this one looks like a false positive: the id existence is
previously validated by nh_check_attr_group_rtnl().

The false positive rate in your reports strongly discourages any other
feedback; you should revisited your tool, do much better human review
and provide much more and better context information before any other post.

Thanks,

Paolo


