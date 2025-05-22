Return-Path: <netdev+bounces-192616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510CBAC083D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DCF3A89E0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22332356CB;
	Thu, 22 May 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvGl6UE2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427B14830F
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905090; cv=none; b=Ki+XAvGkNIEJYsZaBV2PYIh+MkuOoI0Png/cV58XxjyCYGcFiqnbJ/R5NWUwyYtSIkC7Sytln8XffoYbpgSATAzRppm74x7qALRXPJtNJVXpmt1IoRRrxWaVLhkk4EnbiLwKnqlChVOOlKzxCp0ndvUfQnSSV/871R83DRUwRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905090; c=relaxed/simple;
	bh=ZDC9x4MYunxqEojxt2QMnAUa/sa1GbM7hsgeW5aenQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPAV9jQLPqapWP+NUW87FFAG81MeEsPL6DLexQkGqJ/EbjY5SCvsy7eOUT4bgiq2B7XWiil8FNTA1Hw9pL0owlkORk6jon9G2NNeVGcBvyxEqdTaodpDtSxgsUK4jIHqonwcvPSIaM5AmWV7NtINhzEydp2zgv/rDQasZYiHmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvGl6UE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747905087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Efw/xOoBR5JtsAGWTbkGb39F5QrJRSJy0Aiy1rPkylA=;
	b=SvGl6UE2mvKUj/EYtR7dqlLngb9Y9PvIzgjBJnM6olXbHJnSObjmb7ownL5ehNbyaEXOfY
	yd5cxQm/DX/SwzAyhPZSdDtPBcW9iBAOgSK2XEk/i/+HNHGXmpa+1CLeBCAMapOhitwC9N
	t5nL/1jyCatLoTCATUjbZc2WxZlC3xg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-uwjRg0vMPji_u4vCkgYAqA-1; Thu, 22 May 2025 05:11:24 -0400
X-MC-Unique: uwjRg0vMPji_u4vCkgYAqA-1
X-Mimecast-MFC-AGG-ID: uwjRg0vMPji_u4vCkgYAqA_1747905084
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ea256f039so60909945e9.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 02:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747905083; x=1748509883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Efw/xOoBR5JtsAGWTbkGb39F5QrJRSJy0Aiy1rPkylA=;
        b=eGexYxJDTcb383AWF6tTQBjzdDj2tU1SIGEAy5NGpgsANKuCtenslh0uF/59YrwoJX
         clYQpioGdjaA347ODHAt8U59z+pmS+rakT/ApKTVcabjGl22yBY1CAW/uVnDjz3DpdfR
         MKNSlpN2wsqlWTAwrBnGsGMhrIc5pEe3Z/nwMcYrLVDH5lkOFC25RPF69ujQlSjEzl6H
         pvGE1Aw0bDYC5VDqA/BjxykJcHO5ggWC5tolHMQLyGAslUsOKJf/Qg6o8L9JXdUWsjgs
         WjVuFWedWR8Aq11AWkjEUP+GC/XQwdXsuYNb34t+GIgel86TxkGOBq8gwEnCh5wWhsPW
         TTZA==
X-Forwarded-Encrypted: i=1; AJvYcCVqUvDbdSnsaFJqdHJlAzn0DQ9oecGlHxgjdnv+SypjWhxs6e4rnoQl8mk/Xo2ySLPhBw0TK9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bmKg8nnQQ77CnZ0vnXkFKX0eQEvrprF1y9XRPyR7J/U9g0lO
	U9K6tEWE9lphg0K7Ny0jTjYlNMM9McEKSYOgOoB868PiiaI6NsKn4xmH8fVHivE5pKBMZEGt52Q
	oMS96RsIdw2CAmag2KCxKr1AiXki2707aH5pZvPCe+WgZ4GThYrJdLzTClw==
X-Gm-Gg: ASbGnctTEzMrMlNy7/daJTLej7C08UjzgYwTJUOhhkRcKdxXATfgac6QzhFmRKMaoyl
	iub/paTkm+DOYhz2XeQH0wHI3/j26RKaw25qV3mAb2LgtXFJ8sDDEi0mYhYRLl8xDwnG8kw63Hm
	JiDr0qjEja8vV+BBKSevKDpeXgHwb75b//R09Fct5VHuc/I6ZGfBDeafs66MN03BDWBYGpztf7Y
	CIVtsPJkvb3FDlIc3Utg7D2HI0Kp3xhT+UsKqOyBsRQT+R/PDTtoN3QjgdwDWk4qcJDpaootVJl
	Yz/Ga0lySyemmvawrtY=
X-Received: by 2002:a05:600c:a016:b0:441:d2d8:bd8b with SMTP id 5b1f17b1804b1-442fd622c81mr247895235e9.8.1747905083659;
        Thu, 22 May 2025 02:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEciTJ/zcRf4AXElu0pqBhYj5jKqeehae3NT83Gy64LvlkBARBipL5idMvjE3WFf06oe/P65g==
X-Received: by 2002:a05:600c:a016:b0:441:d2d8:bd8b with SMTP id 5b1f17b1804b1-442fd622c81mr247894945e9.8.1747905083275;
        Thu, 22 May 2025 02:11:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f05581sm97329145e9.13.2025.05.22.02.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 02:11:22 -0700 (PDT)
Message-ID: <f8640da1-c442-4704-8f0a-8d498e1b7e16@redhat.com>
Date: Thu, 22 May 2025 11:11:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 5/6] socket: Replace most sock_create() calls
 with sock_create_kern().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@lists.linux.dev
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-6-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250517035120.55560-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> Except for only one user, sctp_do_peeloff(), all sockets created
> by drivers and fs are not tied to userspace processes nor exposed
> via file descriptors.
> 
> Let's use sock_create_kern() for such in-kernel use cases as CIFS
> client and NFS.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

The change makes sense to me, but it has a semantic change, let's add
more CCs.

Link to the full series:

https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/

/P


