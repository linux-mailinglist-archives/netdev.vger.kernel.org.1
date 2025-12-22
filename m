Return-Path: <netdev+bounces-245686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB19CD580A
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528BE302AF9D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E230F551;
	Mon, 22 Dec 2025 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fShz/GDe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi3r9m9X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44523C503
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398170; cv=none; b=WM+Px5FkOchRsSwT8Soeb9SgeLEFvJB5qqgqHA48FMM17gs0e2/XnZ8C5jTnXqWW00ZyJnnGqeA/1S1I4ESg8TBZtjH2xGikrFtz8mou6M1xYAMpr4QvDx4hrCOckG6yKsAMoWwcZmfkpRqfXJIckmnY2vztZRAZAM/lJZIfOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398170; c=relaxed/simple;
	bh=4aB2KHV3diaOeIh0bf0wcXFqQKYBy2gXfmpdn8MH0VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbNDIuNDiCBCmRL1IpP3bHBlO13FOkSEIfz3zkDV5eS5gJ9slsZrKBsK6yBLdQD0LLv4MtX2GRClk0lzcT5Ts+8hcYzXfa2sPppm9QQ9PiRfR33G/xp3LieImRYGMc9M3ceyBrZ07aEmOnoveyHLbJiKroEzPttB9i32iILn7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fShz/GDe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pi3r9m9X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766398167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2Kov4VWYZ5Dx8gfZ4Waiw4nK8Gr4+aNf/Gv8KnDDK8=;
	b=fShz/GDeXvrCkQ88I0bUGlExZsIYZkz4C+uo1BSHgWSguVr0RACx2VwgcbxYOvqeBehwzp
	7j6WYcfMtGz88iIt3wL+sXt2ZMWHBYbKTuVbKWHrNJP56idtFFnvaDisqX1G4Y33adeIOE
	QaLRUmZ4FfrbNbSPvdJo3ZMgqk5uJs0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-Esv7A9UeOESyq73hbUsLOA-1; Mon, 22 Dec 2025 05:09:25 -0500
X-MC-Unique: Esv7A9UeOESyq73hbUsLOA-1
X-Mimecast-MFC-AGG-ID: Esv7A9UeOESyq73hbUsLOA_1766398164
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso50561765e9.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 02:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766398164; x=1767002964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2Kov4VWYZ5Dx8gfZ4Waiw4nK8Gr4+aNf/Gv8KnDDK8=;
        b=Pi3r9m9XaiVg975KR56vqCF3dG9VVKMAycy7MC2LrmyNMBp5yVi+/tGr7ITDaWohjx
         fUVzVY89FzYoEjIHXpOn/Q4jQgxgpIWkVsMTBKJgKtKHcV7pWM6nxTUtScdau8nWfcH+
         8hJmMkCBxInf5TE9NCz2lUk+j5ztr4dBhk1y93XCCj8ZbQUnZXa9ZuybfZadQUYnIWqK
         5fUS6+SxPldkeHu+IbES9bRKq4PCub0o5GN6guNG83bh9XRnfqF8WgTy/1I1nkw2BprN
         7+8PhHkNgPcpcM/JzfMc89CFE6YKDH21PVTGbkaqagu6yWrO+helZU7U/DkEJJ0zlbbN
         iFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766398164; x=1767002964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2Kov4VWYZ5Dx8gfZ4Waiw4nK8Gr4+aNf/Gv8KnDDK8=;
        b=wpRWmTToB8ge5pVimtKm54hyof9QGXm8TuG5Sr0BWCHcPI5ZTD9jofAgYqmS7WVe3x
         ak89JDeXFqJIDceuR1JUwKB/HbMekliT5HoFq4D5q7QbB0TYIDdrOJABBeCc77nh85vQ
         QkJMIbiiifovo7WnqweQGyv/SizS3u/lJXI89XhVRZEm4R386iKh9civJxIYj97Bi/HG
         W/inn4oyUl1EWPMSofkTlNlrW7toTd+68RmB72VZmuNb9VZfAwMqVWuVpcBsrsygC9vS
         YBcoxyGgrMeanCpQ2K9OOO4PE1sRJH6QiSf51u+D2DFx9rNj412HoOrQ7isqw6o3s7kk
         oPjw==
X-Forwarded-Encrypted: i=1; AJvYcCXAbO7ufqLe4P0ZkORuYEyiuHcxoLmVKr3cUmUdzPatediVdGv/U4KoJGQK+rMqfIiCHqdiTs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRR7uvrd0tmDoEqXOX57MPo7wxrkJyvd4WOJQWlQqpT3zH59ci
	qOBpEIeLQIZONdXcjD/LS8INlAjGdgtZ0Te0Pe5gEd8c99D7zqZxVKr3DvWnHvTBLqEp9rX/192
	ETG/jl93P9xlHoplmNnATQH6g5u34zRzCoQ0ZhWSm9nz8y243HUKhDeshSw==
X-Gm-Gg: AY/fxX46vvcPMrzJ9M5wVPHcstt/5mmN04zT2mvBJJWdfmbC8W0+wey1t//p/+CWvAY
	yz5Tdo4JyKJ/CmBA89qhk/Rora48Nqz2UoqVPj+LgQL5WudgHg4IL0mwZ7Toxb597xG/fy2yx5A
	N4ypCfBxM4vsdThW2H79yU45FZyNk1OiegyvUJ6Wk+kemMn9kzQMqA649f2Mo9UVqwTxYY1tjhR
	pJvkeG0sqlnFljs2+lrJLmNc0ugN4z+OBcn67nyFzfRfw4UHcU6fbdHwkh+66vTU3/Xel3yv343
	oripH3+7a5Xp6UDG+JFn4w4SiADxwbL0fjRknbS3zq5qNZWbYweRHnYnXnZym77tDz7QCTdb+kF
	43B9glZjoae3p
X-Received: by 2002:a05:600c:8107:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-47d19595f6dmr112817455e9.17.1766398164166;
        Mon, 22 Dec 2025 02:09:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbuVg3S2TE5ZpX+Nl6uJIdUOr8Vpx031bAtQ0A8sYRc1cjsVe0FgtY9isbuLT7WqRTK7yXaQ==
X-Received: by 2002:a05:600c:8107:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-47d19595f6dmr112817045e9.17.1766398163791;
        Mon, 22 Dec 2025 02:09:23 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a2b419sm96782625e9.1.2025.12.22.02.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:09:23 -0800 (PST)
Message-ID: <e0410b3b-c831-4c9c-9ee9-351315759291@redhat.com>
Date: Mon, 22 Dec 2025 11:09:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for Linux 6.19
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Tim Hostetler <thostet@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <20251202234943.2312938-1-kuba@kernel.org>
 <CAHk-=wgG=XFsHgMhgZpOM-M-PMa1cuz5=jExFv0KbajJ4JXN9w@mail.gmail.com>
 <221ba5ce-8652-4bc4-8d4a-6fc379e32ef8@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <221ba5ce-8652-4bc4-8d4a-6fc379e32ef8@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/22/25 8:48 AM, Oliver Hartkopp wrote:
> There's already a fix tested by many people which is not getting 
> upstream for some reason ... ¯\_(ツ)_/¯
> 
> https://lore.kernel.org/netdev/20251204123204.9316-1-ziyao@disroot.org/

Such patch has to travel 3 sub-trees (iwlwifi, wireless and net) before
reaching mainline. Also there is a relevant patch processing capacity
reduction due to conferences and EoY celebrations.

AFAICS such patch is in Johannes tree right now. I'll coordinate with
him to move it forward in a reasonable time.

Cheers,

Paolo


