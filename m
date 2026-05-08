Return-Path: <netdev+bounces-285883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKVPC7v7/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BA54F8499
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DC30302837F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8C3FCB3D;
	Fri,  8 May 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtvgRmfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F33FB7D1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252515; cv=none; b=d0MjacImHVEY5LC6ZibRMJh8J5z6G/pr3ocoNmBELwuqQ1GhB92yajqqmEONuHMaN6YHE3U1JUtE5rc2Z1mWnLcXyxDIrlqPdWvkFwYj0f7Du5Kuz4XAkIpOHKW4Jeac0E58mZMefTUt9bPWypqWd9R081pu6Hw39eVIvUCk9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252515; c=relaxed/simple;
	bh=d9whpuIEMfnGfHXELXi5THs3ikD/M+a2M1VvwY0qAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYxVMWZbjAvvmOrqvFlGOAWyhjQmDS4a+lmW8uekNYuOWhby3QA0lHYmP/eScRW00YTbwE2H2U7ASs1a9u76/d5LU2c0GXntNI2BSPbfmfxssaOS+PPXoh6yi4qd4p1bsZWrRHzF7oc7Dww8sx8ZPUvy7pJhZJeB8SkE1ta+uCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtvgRmfN; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so1093232b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252514; x=1778857314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IgYMYGpVzi0WUd6069NetUOnbBf7yLrDGRB7C9U8+o=;
        b=WtvgRmfNtVaJWb1dPvdW9jp6oi3NamOj4+9P48ymK+bqqRyouUpdPTrba/wLO+tjNO
         4AhSo5jbYrbhQdyezHA4o0U+hMRAK+XfltKwW4LUQcQZNnWyWlRQO6Dz+Jl0e6mdY+q8
         izDrvlHHi3/hccRHk2waSpaSd25Q3m0d5aoSrwPzuqwmaZXK79xy8tkbQ0Gzkr6cAN5C
         HPRLW/VWqnPyLBLwEleEWC4aQ+pVuZgq39QtNNHoLVUK5VlxT3m4dH4wOl17sFPHicnl
         Hl07PCo9kN5Ir1Rp7QNaR9RlTj8cbmEnXTC8D/+U2eNawBuCdA7gziEWV45+c0zOBbC1
         HW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252514; x=1778857314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IgYMYGpVzi0WUd6069NetUOnbBf7yLrDGRB7C9U8+o=;
        b=VgWElVJdUrf4GJclocxJaq25RodqvQ2edfFUW69XrcyOLcsHrlx0yhecSaaM6sMOQM
         JRmBcm0eKvhrq05cI/j+5iPYWQljh/GzWe4mvX1LZupOfy2FQlPM868H+35OoR/Qq+Z3
         ZWh9uzmC+zx2eYzI8MV3l/6X30vdIdZaCZ6PmCdYidFP9XZiPltLhjICM5JMFfJmdgLT
         TYHpJ3HWTm4id0zHPvsrBCaQ8Px/oeGiAQWpXcwqnXvw+zTG464as0lfMKk6BpI0vRq2
         pz33/5q5pr0nOlLNA6ZPhBKXhKrQlZT2T34k0vSZX7WVJ+ZvJMF3xQff/+x59OOSuK/R
         Yepw==
X-Forwarded-Encrypted: i=1; AFNElJ/0LDLn61/LpWMF82B/lRi8j07U0yzomGb5gYfWKfJlzW7j3OJczgLAWT1vCTL4eGt6yeh1tcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFqyVKQfY7siNF5aDKt5xgkpqJ2sdRnlbaA58U5Utbx+ffF6C
	uyF7GqKEGMpYhwzNTQHc3iysrj02vy+P5PdT02jHJZnNKzsuWpepqAbe
X-Gm-Gg: Acq92OFoBWNoDCUa/3iBNyBuL/T1OKkehpDtO5FPnJXC3385WEciV7uM31m4nPWJ2En
	C/rnM5rmdrVrCfhqptllYLZ6V7sthdGsULZQjfHdjB/dC8iS1N1aVMvL/5BZnUi8NGFE3YIa+po
	Uu661NBE0jv2FZTf7MvOzFFIqO2gvrLvqe9C/V40z3V3UXE+e6BXQxWJLFrFLR+0Fdj70TSmmDR
	h6IEwFQZ+XBlY1DtXMaFL9AuI+3aKpf0VwrHVA93grpiVFkljlpZTV5XJERKWMxcbNIrSduOZYV
	zysLUCh74hhOFWS+fquloZdBKWUVdgLJcXJ6Ktq4BWjAtVrOwsN7qFBO2M2i1af0cNJMd+hh7nT
	ztjBFFNhLKDLqI81TymL0LTv/nfoQQSmtc4LRgShGIRp6Gv8cd8sTAUoEnchjO8hVJ3ZCD9P0zk
	Tr/Xe3I4kXYrN0H+a9
X-Received: by 2002:a05:6a00:4b54:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-83bb7cb6c8emr5917960b3a.19.1778252513119;
        Fri, 08 May 2026 08:01:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c1bsm15730006b3a.34.2026.05.08.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:52 -0700 (PDT)
Date: Fri, 8 May 2026 08:01:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 5/8] selftests: drv-net: make attr
 _nk_guest_ifname public
Message-ID: <af362BZdBFooC4mH@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-5-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-5-52821445867c@meta.com>
X-Rspamd-Queue-Id: C7BA54F8499
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285883-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,fomichev.me:email,devvm7509.cco0.facebook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Subsequent patches will use the _nk_guest_ifname as a public attr for
> setting up devmem. Rename to nk_guest_ifname to avoid angering the
> linter about the '_' prefix being used for a non-private attr.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

