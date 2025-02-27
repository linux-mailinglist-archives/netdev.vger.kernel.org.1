Return-Path: <netdev+bounces-170204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4310A47C37
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761DA1887E46
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA42288E3;
	Thu, 27 Feb 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk9Dz0n4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A6EEBB
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655671; cv=none; b=jxZ13YSz6BbgACz8Hhu2ySBjlxpv4c8kLGrjM3kgYYYdMVVHRhpW5pS9jZZrk8o0qPy8T8QxYaExCdsNvfMRcp8z0ah1AspZi+JSv60K3q3zZ9bBsGj7YuFEAaMdPt8CndO88NcvTWFra7UbxuSQaDKeTn6Gn6R2tjABuOB+1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655671; c=relaxed/simple;
	bh=2XNVnAyDm3PjiXLwehc/rlLkpHOZbf5GmEz2365CD2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmqCHNw+FSqze9MIVa1oN4fF1Hves8VM/9ApFFRkjTilrkjCcMq0QMiA6bG9DVsRSXgUcIbBoyVn+6P2BnWWeg9ITZMQcswix6lUaAZeHYUVvVFRC0ULNTaV74i9l3PLUwCtFao3vw79YcJ6W24i0CFdpR3xdqDZSOkPEZLd+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hk9Dz0n4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740655669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3CkPQdTGCeSORYEiAZeYzr9XXq+mqqO+Vu7Eg+pJ7I=;
	b=Hk9Dz0n48m6/jz4eIG6WNKScauTv6W/osvFPnhmGm04RthDexjPGZiQLEtJBdKpof5dhDX
	2XgKy4ZV+1igcQMM68u9p6Zxj62GVPxGz92Xx4T9ZyxweLjRxUEN+TYzGpgiO8Gl1xP7aa
	MgbcuK97vBG85x89ZIvUkRgSX5bUKbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-EZmqT-SMNdmKRlEBhxc7fQ-1; Thu, 27 Feb 2025 06:27:47 -0500
X-MC-Unique: EZmqT-SMNdmKRlEBhxc7fQ-1
X-Mimecast-MFC-AGG-ID: EZmqT-SMNdmKRlEBhxc7fQ_1740655666
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390d73c20b6so462630f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655666; x=1741260466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3CkPQdTGCeSORYEiAZeYzr9XXq+mqqO+Vu7Eg+pJ7I=;
        b=aWklBTtskIM9Pb03UPmWrnDFDZ+CeVti6K522+A3TLjdvohATUv/O0jOP3z/II/cFu
         g8c+K2mCe2xNrsC4qgKAUOREivozQE8Uszlx++ECTrwtV4h0TN8ct33uM0hJvM7+58Gf
         Y4ZiCV4R1GrnOe4qQ0PBwLB7msR4NTfGkgeUiGCdRyIosv06cb9eyPVB777ZgNj+YdYZ
         y5ymUBKo6ottuOQwKUXwHG7RIgIGFB/rOKtTeRWJ3rgH8nocj/ieSFD5h4n08OHkfaAy
         RFobMEUaJW71rYKeeI38GkVxzacpIgzIEVXgXntH6Qyw590pTtVKbGexyvLaHOvlrWeM
         Od9A==
X-Forwarded-Encrypted: i=1; AJvYcCU+tzfhgorkMqlMDAvdI41MLeAPKjgB6V3PQ36w5EnZryNuI7HREFrYvyynM5d1+5qeU/B1mb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuBxiqeRBOS+9ld8EvQCJM1MjBpm0MSOTTVaKWRbOH3752gC6
	ZIy1RRFdb5Ncz4WAfoMrgwojx9bUZ34LgVqBucgKVb9edjS9ZHuWiC8y98mdbEUjhbS6IdHS3ol
	cf15yvVHzqjGO0sPoB3ikQgbLYnLuzF2BXXuIYhpqpfzUPJdBo/UNJg==
X-Gm-Gg: ASbGncsHSGl61gdKwCpCd+DmTRNcZfsa3gKWVr6MH7BNVQlQswOF4HYPLx1hRL9WJs2
	c1E5tbrSEuvYveSNBNElWksQ/S03A5/kSSg3IQSv0ICiExzxMnJL5vh3SNaU+Ik/iEcjtBlXz27
	2HmOnmOEaXhamgER/NMXb+457JtPkJJNxdbajg/ZsEgeZdNjbr42Uunmzyc3l/QMgbo2qyrqGXz
	g+PVxyh88biltbTKIh8/5fpege3X8exVSt5gddfcxezsHNsXiemCOdyoCKUUT+nPwDfV20cuoJL
	mXa4/9tuncFapCmz3TVVjLxEFYoEudPFmtMIKtXjAKRabw==
X-Received: by 2002:a05:6000:1a85:b0:38d:ba81:b5c2 with SMTP id ffacd0b85a97d-38f70854e1amr20380507f8f.47.1740655666497;
        Thu, 27 Feb 2025 03:27:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEswokDyQ8DCmCLBEiVAJ05eapAKtiYcRQ1bTYqiKrKJkSlhiC7M///9FUusM+u/YQh1Ky8JQ==
X-Received: by 2002:a05:6000:1a85:b0:38d:ba81:b5c2 with SMTP id ffacd0b85a97d-38f70854e1amr20380488f8f.47.1740655666121;
        Thu, 27 Feb 2025 03:27:46 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6aabsm1731589f8f.26.2025.02.27.03.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 03:27:45 -0800 (PST)
Message-ID: <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com>
Date: Thu, 27 Feb 2025 12:27:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on
 afs_cell and afs_server records
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Christian Brauner <brauner@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250224234154.2014840-1-dhowells@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 12:41 AM, David Howells wrote:
> Here are some patches that fix an occasional hang that's only really
> encountered when rmmod'ing the kafs module.  Arguably, this could also go
> through the vfs tree, but I have a bunch more primarily crypto and rxrpc
> patches that need to go through net-next on top of this[1].
> 
> Now, at the beginning of this set, I've included five fix patches that are
> already committed to the net/main branch but that need to be applied first,
> but haven't made their way into net-next/main or upstream as yet:
> 
>     rxrpc: rxperf: Fix missing decoding of terminal magic cookie
>     rxrpc: peer->mtu_lock is redundant
>     rxrpc: Fix locking issues with the peer record hash
>     afs: Fix the server_list to unuse a displaced server rather than putting it
>     afs: Give an afs_server object a ref on the afs_cell object it points to

You don't need to re-post such patches, just wait a couple of days, when
net will be merged back into net-next. So that we will not have
"duplicate changes" inside the tree.

The remaining patches in this series touch only AFS, I'm unsure if
net-next if the best target here??? The rxrpc follow-up could just wait
the upcoming net -> net-next merge. AFAICS crypto patches go trough
their own tree.

Thanks!

Paolo


