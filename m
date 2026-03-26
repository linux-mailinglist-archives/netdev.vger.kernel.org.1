Return-Path: <netdev+bounces-271989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJTBKKIZxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:33:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2828334934
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA0B30C8F2B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD073A5456;
	Thu, 26 Mar 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiImXy1Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rza7LlTr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B017B418
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524402; cv=none; b=mP2XkwQlAC7qWbDl6g2NJTieSFJIcjfnOBAMaxcl9WYQFcX58sukoiRt0qlhY2jGH2TNaoLmGy1MEBbWmFIVG/2sfBPfawDea6hmBeSqjQJ1VsdARvykM+i6El0jpCBOjnhZTtrN0+stw5dQJeXbI74A2a4Nl7YqnyUFyLaBoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524402; c=relaxed/simple;
	bh=7phvMY4sTP1Ow9gtIbhvtA9o3K6+Dxv1oLOd2pNlQEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxmfVhd4NHtnwK5K4Eb4Ecjw0IcwLbKsAZzUkDR+aG4qdvwLGXPGP5tD5kfDL2YcCotfwpjLRRhETCOZeHA9XINEql4VyX977IM7VzniRHsMLaLGOTvfJFFAXXlRZ3vwlOGESWC+z5CluMak3qm+K+SRxKcigFVQB8QaZ2RTHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiImXy1Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rza7LlTr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774524399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMKh29I+H42fUtZzwyv2ZkPMuH5LtQjk3V+hrcBFLWM=;
	b=JiImXy1Z8f0ykFToD6tlQmvzKH28uZmeMNalwAnZboBzPpnssmVauc82uBXo7FBs3RUKB9
	Y/FxFDPWP73NRnT+b/TP01wviVSgEaJrlRWxu5rtCBqhrr6shLBYI1fqyXb4QpJnFJtS2o
	wdmoCU/gD5bY4LJ0ncX27GICDnYszGg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-M9QRFTy-NLCE_oeN1FFEkQ-1; Thu, 26 Mar 2026 07:26:37 -0400
X-MC-Unique: M9QRFTy-NLCE_oeN1FFEkQ-1
X-Mimecast-MFC-AGG-ID: M9QRFTy-NLCE_oeN1FFEkQ_1774524396
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439cbc5fb4fso926604f8f.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774524396; x=1775129196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMKh29I+H42fUtZzwyv2ZkPMuH5LtQjk3V+hrcBFLWM=;
        b=Rza7LlTrkukgPLTB5Ufnrq8PSv01tbwu8mqK3gojY1d4ROW08567HkZuXd+rFLUDX6
         MtEk5BhcGAkAwkZgayQ9249/4EUAkoPm4j1Ylb5ph/6IdszfyUgUKWHaY5AHJV/ZAJQR
         oFRpYb8+HNfKyzVN+T6UJgvrzqSQLv98Y6eT+YcIaKlsIbLn/n+KFovNXknIXZZotmjJ
         N7sS+x33LnCgYMl6RwWCyMBuTzqTP6cRpsV5NelIPvQCKCqm8sLw9/JGujOwFxWoqVbO
         zbClYaH3l/58rZi/pe0eEQlDCdbLKJ0suPuoNffWSVhS6HEeAayW4x1CX71OcMwGWULr
         6tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774524396; x=1775129196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMKh29I+H42fUtZzwyv2ZkPMuH5LtQjk3V+hrcBFLWM=;
        b=MOP7Un9LPzT7OngdD+yv/iv0gFI7Gbcdt1U2h4iTS8IMEJFAAHTA1ybTkcwEukUTGD
         8lJ+0O5wry+lrtW7xoYgENrBI08RYmbii2UrTKHXZGX+8izMqxm8SBtY/UViTuH4lfFb
         tIa6/4U6sZG6LMhDu21dp67wxTmVgisf0NRihBXEydfwUzmIu0DbO9w5MyIbYcMyOw1C
         0oaYvN1IeNfAvjgM8Xasthgp/p0dWsZnJqPsMYqwT7zeeBxefk6WdXDz6eZ+l5R+S2Be
         ylh/L5hjPsqeSzhIA3JHYwh/JT8a8ZdYGqz0fxuRQX4F2NCf4KGvHOhMN6qkj6SsJ3E/
         t6ew==
X-Forwarded-Encrypted: i=1; AJvYcCUK/+G3Ve5DEVAtu0VQssxbYdNCXAz4AAoXlsHvFvFs5Id/OaD4b3S2JthVZTV+LeeQgi6plK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9w0Iq8InwyV/XQOQbJJZGAIrSwjNNHU7Lkt2p7s8quaPAoq2
	QQNjBA2XtIGApxGHq4P1fd7Iy0Ops9TjLt56zQvuP+oZPoew0VpTBuVahuzgx/uA0Q11xCVZKWx
	yilq5eparBoRBWqYFL9jwny9ZzmsZOT0t7iTP31GQ0LGSlXnxUYn1Dz/tY+sMDGHNFQ==
X-Gm-Gg: ATEYQzymffmW7XdmVaTPixubYKviOeKqFntHFk5h7S9Afa9kzS5t7eHQcDrzylSHkXA
	HV2mjvf1/5CRec8TDuddz9I09aET+pTgLVn1fGKKuQ6eZ0GEI9Sk4G27hJdwoaXuKT6+d4d6vZI
	SigM9++N2tndEvypV0jv4xVlSMeUGSRVSaknqh6roOBoPgS+lwQq/pfuFxcl8qeMy+vZ4pdWl81
	XbeLDle6Bt37X3I9ULa7ynwh69/VG6C/N4Z94HOGHIyqfEjI6UdavwyS3DnRQEibbfIbARIiYld
	15bjDxV3H0RKKc5VFzxIbbFABNEoqqc3VI1C3WkjZsqoijJlzyJ4CQydRDxapAYqTWBwRYSaCem
	E+a6VfdFuaA1UR9Mo4hetjXjalIbFuoXjXD1eW02LBMqrpQBPdhMW2e9d
X-Received: by 2002:a05:6000:200f:b0:439:fd13:5c4a with SMTP id ffacd0b85a97d-43b88994f7bmr11009541f8f.6.1774524396119;
        Thu, 26 Mar 2026 04:26:36 -0700 (PDT)
X-Received: by 2002:a05:6000:200f:b0:439:fd13:5c4a with SMTP id ffacd0b85a97d-43b88994f7bmr11009474f8f.6.1774524395569;
        Thu, 26 Mar 2026 04:26:35 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df7dcsm8216445f8f.27.2026.03.26.04.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 04:26:35 -0700 (PDT)
Message-ID: <cb8280ad-fd08-4201-9faa-d8b1bc4f0bd7@redhat.com>
Date: Thu, 26 Mar 2026 12:26:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v35 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Vivian Wang
 <wangruikang@iscas.ac.cn>, Dust Li <dust.li@linux.alibaba.com>
References: <20260323074441.91691-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260323074441.91691-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-271989-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2828334934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 8:44 AM, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.

Unfortunately sashiko fund more stuff:

https://sashiko.dev/#/patchset/20260323074441.91691-1-xuanzhuo%40linux.alibaba.com

AFAIK checks vs malicious values from the H/W are not due, but stats
endianness, 32-bits, truesize related concerns looks real.

As for the acceptance criteria, we should not merge code with known
issues. A problem with this driver submission is the size and complexity
which allow LLMs to dig different things at different moments.

/P


