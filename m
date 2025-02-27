Return-Path: <netdev+bounces-170314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C7A481E4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718DB3B1FBF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899C23A9A6;
	Thu, 27 Feb 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBPu+ydk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619302356BD
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667420; cv=none; b=RujL4um6cTvvSsxdgi2m0U+LRTmdDQva8wYD4FQKzalvyFIjLLwMkpeiZfn09+MVNQEgQub6qSNfn1W5CYRO8+6eNmNBG0Cpo8xtbcJHlgD+ju8F6/YVlcIvrbU7nei19KbWNSp/1TZdFyLfQ6HN0r9pe3MCGW/2PYdJBR1we94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667420; c=relaxed/simple;
	bh=SFThVowJlqQktHJLgxbc5ykucEGjsXXMh/7UDNM/BO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdWopGRbbGV3GZlqUgxjhjrjuUNy3yORAeCnAwFIgw3hLcFuBL4BXi7FXdz0ZiUq8R/8PsU/qaVMomZmQvCgK2qLhJVqFvDBdlT5TWVd7Oxv6K4mYvB6H7sz5NfutrbpHvYiN51FDoLSGbOVf/EmLbsIurnVpM+z9CBVu2Bst8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBPu+ydk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740667418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGiCMh885+JkNd7xet7ImHZf0tupK1uK6dAAvNVNafo=;
	b=XBPu+ydkkXmEtOA6vShfQ1RaStdhVRRjFABamTWb6JbOYy5m02EJaNMGa4+vmsInWV1KeQ
	ZdbbVR0J2fx9gFt/LCXxsXgoRhZJLKo/j2Krn8MEEwMxwiH5XNOEuueDm5zL2NDWjIEGPr
	K3Wtgwqe6CMUxE2+KAXby8uxXJAqf2Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-fCdsMT0XMX2TrcLeF4mJpg-1; Thu, 27 Feb 2025 09:43:36 -0500
X-MC-Unique: fCdsMT0XMX2TrcLeF4mJpg-1
X-Mimecast-MFC-AGG-ID: fCdsMT0XMX2TrcLeF4mJpg_1740667415
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so671190f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667415; x=1741272215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGiCMh885+JkNd7xet7ImHZf0tupK1uK6dAAvNVNafo=;
        b=rx/EGak8FbUcDvq9fphFuT/08TktxapULrjIt2aF9AtdqXtwNvoWgwwXgcmuCigQSv
         zG1hopdc6iOQ+bRVoMEeA3kLHVMlXLhEheOwhrxmSXoJ2ZvNoEEjNOJIP8wUDrk30C7H
         gR12/Os0cMhJf27fncqyDmkFAaCyV3m2h1BTqypqao24G1H0VwsoFyxANu28QmAykz6Z
         i0Hd14qnx5ykJmVUWYdAgkAXZ0ffjEfYK/KgX3yuSdEUX6ltu6rGK2nx67kevHIP99p5
         /XNajxKfDquAP/gjk3O8t6ERWm8/aSRBNztoX5euPZVa1JuixLaANQ7eenAzhHjnGUD6
         fHlQ==
X-Gm-Message-State: AOJu0YxJOif3+sMdhlsNPk2er4QFkQ1Z7tgkchD96nzPdbQnjBjuGszW
	a2khQjUhFjBvAq69i9pbksnFfg0lRjH6pY/+HFc5I4H8K7a6g8BlBl4rKjdHgQbeo0H9nwYuGJK
	KLZ662COmhSwWb0JeMCrY52RK9ZVTlcwIsHlZTKjttNRk4UgoUswCHg==
X-Gm-Gg: ASbGncvsIvRd8tLBviP9ZuLxOxeRM/YHiDCaX7Y+2OAHwXQikoKFRkjYapd/4aNePgJ
	PvLNuvtKwcpDhV3vUQSm4djGoIRnjhhVkrGuHXGShA7MW4bB+GzueBEb5Ws55j74VTP0Vp+tXyl
	XnFNIDsxFhc5N7ZIyMfTNIyR0nWh80AlTDMmgSdVWy9rn1VfJ3ygFBvEanU1HS3Kx26qdhxiK03
	IejKQDSl5TPL577qkcE90bV6TIUm9+Lrb/jqTnIkztCfInZnaBYLN3uhMED5s6yZ4/dNS4/kDsl
	nZKHqpDoJSh9gyzjKR822ydoGrZIoLMUryogNoysO73xxg==
X-Received: by 2002:a05:6000:4014:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-390d4f3cab3mr7399940f8f.15.1740667415265;
        Thu, 27 Feb 2025 06:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENhybFuiGZlHBwyKhH7QHjSknwxNyGmC2Lpy8aCMSt3PxeScxP2D5rAbtFR0j3oDHU3vaSsw==
X-Received: by 2002:a05:6000:4014:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-390d4f3cab3mr7399917f8f.15.1740667414916;
        Thu, 27 Feb 2025 06:43:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7850sm2304944f8f.39.2025.02.27.06.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:43:34 -0800 (PST)
Message-ID: <da1d5d1a-b0ae-4a40-907d-386bd035954c@redhat.com>
Date: Thu, 27 Feb 2025 15:43:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on
 afs_cell and afs_server records
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Christian Brauner <brauner@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
References: <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com>
 <20250224234154.2014840-1-dhowells@redhat.com>
 <3151401.1740661831@warthog.procyon.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3151401.1740661831@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 2:10 PM, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>> The remaining patches in this series touch only AFS, I'm unsure if net-next
>> if the best target here???
> 
> Yeah.  It's tricky as the complete set of patches I would like to post spans
> three subsystems.

Possibly sharing a stable tree somewhere, and let the relevant subsystem
pull the tree specific deps/bits could help?

/P


