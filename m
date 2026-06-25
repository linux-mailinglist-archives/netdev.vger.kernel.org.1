Return-Path: <netdev+bounces-302023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9I9+ERJSPWoe1QgAu9opvQ
	(envelope-from <netdev+bounces-302023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:06:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580F6C74EF
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:06:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sRK3MyNc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302023-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302023-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D3EC3021053
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700BA3E168B;
	Thu, 25 Jun 2026 16:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AC2F8E9F
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403542; cv=none; b=mhTGG/UZrUZqxq/SrZgGKOvBvLAoRuj9BkR7uX9wgnPALHLhnJIMRkuJ8nNK7nzlKx0mDDu7qJ2lIXMnXNuYOW1QmlqC8gcPOCfBShUw+F0gtPsFqxorE9CAaNxSoxSyLzWRhVKk/GwsTR4l4vLptmdStwIIpCggyBxFAo+5PtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403542; c=relaxed/simple;
	bh=kdXheqGMEKjWqXk9H223SpBGkWGdjYjMN8SoQRRMt4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czYSXFymSFibhyuVcVstUVPSwm1aqk/FOdJZNcE4rFskrY/t0kslaiWq4a5TxA8M2vxn0/82S5uKCPZ0kmoDiKexRaRmVlxEsG8ENTdzkHOSEohg/z4TBvBwHCAh6gtEPfVwUWOKVKseaKFWkxKAJnfulp18t0kAa6AAaNCHSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRK3MyNc; arc=none smtp.client-ip=209.85.216.65
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so812838a91.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403539; x=1783008339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOvMy7bTzmvbhpj9EM7OA4F4lYQ6ooDMFisbSg0yr8E=;
        b=sRK3MyNcQoR2yF0O66R+CLt9B1ltaDT4iurna9BPxcOVSnqM9LNJA3tjCOQpsR26Ug
         jDAnufvQYY/7RhFOwQEpCVLqLfpUgJN0oS5E42+yBlHcHgiFPjYgHeyOWI1nWYvoIL1L
         k+DPslfSGUkVNVbsqWA6gO9vT5rbpzJLTE7LEhOmD9rmSg//vxd7VLJh4vo5ORA0UOhy
         ln3vj1+KyTjiBe/ZbydLyDcRUi1D1lFZTtH/G8fPLsN6t7Rq6wDoFTfuYXF/DkIWz1qS
         7zpYtY/rdyvf8FOklOLLXOTa6O2gjxdQf3/Q4loxkK5JsUuzrMdZTFHUZcmkonFKDDGC
         MRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403539; x=1783008339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOvMy7bTzmvbhpj9EM7OA4F4lYQ6ooDMFisbSg0yr8E=;
        b=LILQvfcj3/HVG9hnyZjkMdu+b8Qpu909g3aUN8WckKCZ+V/dDUUP+SpHTCBfOPMIft
         RY5oSIxN8ah4zA56h2MLev4GM5/MyycOIkR5FTs6SJZKDzFylJuI7dYgqQHgROMfVoOM
         xVYiHQiLiFF2ZQLLq6iw/HJqdMggh8qL0XzfXF8r+/+a186vkAqRsWRVYIIsFsW/9KFe
         4NV1gynwgruH/hFKH8s/Vtl6auZtUIuf4Q9lo+j9VmAlgVsYzDQWBrb/TWSFOCF/Z+Qo
         TiMzFtBMLjA6y7QwmSNl+SqOFhSj7tUP1D5k/lbL0V58UNub7fZ9A1FtfUzJaTKzw+oh
         H7mA==
X-Forwarded-Encrypted: i=1; AHgh+RpYM+AEleV2ruIwUla/HPdTFzQXNcb3/xXpK5Vk9hGh5z2uzlvDLvEohhEoEsfZ4Wf22FMHnyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfxXwtHWrcwlHSOUacL7/pQ3N79tskc1GVm1BavIRR6wa3B6t
	y7///9VRSVTF+EZZuM+1YvSfrNedUpzKVQ/WFGuokc58aWaUfdMdJLyp
X-Gm-Gg: AfdE7ck9OENPCnb4TfbmHqdtQ02zp2KmmMs1iRmc2kHR8uKRHFtisqkMtRR+UlubJKl
	BLyBmA56B8Z03ifSFFeWHGMD/koFeUr3xHjRr/+jCCDvCbJW4kS5/dxqivevOP+acP/5a5rGjBQ
	wt1iAdUujmHwmRhMpd1VgWQb5RFJ6xqdlk9Fv7vErOyszECymFKzV6ySKHQ3lBcxn2QxmX5K5W1
	NFhCWpEF7VYffufchsP/FajAWl81STi1JKcJWNMtS7GGA54yM+kG5dBN/0JgSBi3ic080dpJfFE
	rWchCerk4UHKMJiP4AhHr8feM62I2cyBafTOuweI3lPXIgYbj5LXp2yYYsM2GsnNSIkKZnUmxgs
	yoo6AJfADyb4UgTO7h/L0KPXz1cZzimbAyxpEmjTSbqCBs7boiZUBQNXXh0AmtlsvcDRpCN4Rbb
	FSRjTGwg==
X-Received: by 2002:a17:90b:2e03:b0:369:7491:7b24 with SMTP id 98e67ed59e1d1-37dcd693671mr11010056a91.6.1782403538935;
        Thu, 25 Jun 2026 09:05:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bcb9c14asm1930645a12.24.2026.06.25.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:38 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:48:33 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, n05ec@lzu.edu.cn, 
	yuantan098@gmail.com, kuniyu@google.com, nb@tipi-net.de, aleksandr.loktionov@intel.com, 
	dtatulea@nvidia.com
Subject: Re: [PATCH net 1/4] net: turn the rx_mode work into a generic
 netdev_work facility
Message-ID: <aj1NyV1bumsWaxLE@devvm7509.cco0.facebook.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
 <20260624182018.2445732-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624182018.2445732-2-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:nb@tipi-net.de,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,tipi-net.de,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8580F6C74EF

On 06/24, Jakub Kicinski wrote:
> The rx_mode update runs from a workqueue: drivers have their
> ndo_set_rx_mode_async() callback executed by a single global
> work item under RTNL and ops lock. This is a useful pattern.
> 
> Support multiple "events" that need to be serviced and make RX_MODE
> sync the first one. Call the events "core" because later on
> we will let drivers define and schedule their own.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

