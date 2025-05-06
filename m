Return-Path: <netdev+bounces-188304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E62AAC057
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09B93A49FB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE81255E37;
	Tue,  6 May 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5Z4txiE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492923E347
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524793; cv=none; b=SXJ20+VUQLjgFSSEuxyd36XA+ThyURszBsEKxh456gy8eclZU3vtOqhmJefyGrpRHgXbwZyVVfxjRJNTOgqsO9pI6yGIb150v1ac/yAmm7mGYd2zS0hjchlthmGU/2ilyiPG1YuA+9pqdrUkhVEQ6rO9IlZI2Ja9MjC4Gj0zdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524793; c=relaxed/simple;
	bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSeIVC0qLNkKM128pbew+MATbm0//QOjdLHfVnYRPN606cmiYh7xZqAT1EJfTmex0+wVfzqIk2dHQTlu/4IQKmGpuS+J1Za7jNTDkjGE5WfZdJOQXc9MmRw1Y3j83jRH8bKwqpLeuYs/jt5HW919FJsMIHnfaRYRSSOOLChlhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5Z4txiE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
	b=Q5Z4txiE6zU5A1wtsG9LwyaJI9hrpzNCXjlw0QmLvRdaIaA0lmHLUW6v0JvR6xGUnjkQOq
	VvvR9EbW2pKx/FBROOAEkpcXzH6Cx1PPCg/Lln452ifcO+0Rv+D7cv78hlPOac5yghEieC
	WLGJHsg/swCtoc3hXYd42ZUhlpO1fCY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-7UQsMzYzOpKHQZTZh7QYgQ-1; Tue, 06 May 2025 05:46:30 -0400
X-MC-Unique: 7UQsMzYzOpKHQZTZh7QYgQ-1
X-Mimecast-MFC-AGG-ID: 7UQsMzYzOpKHQZTZh7QYgQ_1746524790
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7082e59b9b6so79697737b3.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 02:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524789; x=1747129589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
        b=Oj45Rz0styFzBub2zubU5tN84IdIcuR8O6ARVncUuz0UXKQAKlEZDhKUSqg4MxvaaQ
         4bJjguI/9oy14+uIBJz8ywXXb+oEb8nWH7zKUc7LDeUstFVEMofPi5VNIgkjpiEBzAad
         AKNIOwH80nJRm6bvCkbAHdS+UuK1fURaGyrYI/+q2N1TSHbCI0pBuxLGcn0fp4qElQei
         yl2rua3HHYCxMEERrkHnB770028KWqdEJyklm2njHQaj4TIqCSk9D+2H0noaV9BethMU
         Vy5h59sqKfh99mlWfRg9QBExO/4hHQ968s1USAGSoM6bOU2JePhfume2iSSUM+tEmV+S
         xHYA==
X-Forwarded-Encrypted: i=1; AJvYcCUgTkBogO8aiQcBpTBkUGsRVY1CBcMk+p4szuR+SBccUm9YqfLr1RQ+qJP72tp8gXPuVDx6lAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDDqYRNM64d32wojyS43Cpr8zP/CMgygkV5eIynejDzfb4h18
	B67V1nveWVOeW/9h5iSbxyHLwcxLkl0LQ5BWA7rda8PqdyrO5G/aizP3p0wuBz1TUtjivzPdD25
	EJzi/YYGhMIXQp8vc9RB4A+eJ1qizJPmGE8WVYhcdNzqfDW0X8pqarJ/Dtps7gTunqA1xWVhEA9
	msw1eT0DMjfIiDq0xA1W0LjjZoDPtphnkRRvpf2bg=
X-Gm-Gg: ASbGnctzdHqQBu4K/lT+PVWqeSDHO7Y+neK40VG7ZLjGbaIWiE45WOcT6oFuZprPeGE
	Y2dhznDFX7QhZkV6dL0dXZ5q6fFF7f/3jjisRKdedtVvEzxTlOlAzMaFL5RcaPrqqY6torpg=
X-Received: by 2002:a05:690c:881:b0:708:b7c4:89d9 with SMTP id 00721157ae682-708eaed228dmr161341797b3.11.1746524789549;
        Tue, 06 May 2025 02:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SnKlOiGYxAIgFjpIz/3a6Amq4RJJRae2tHMUWHhFAEAWBZQzJ97jvAOQKqp6vtJokq7tr543XXcIaZE89NQ=
X-Received: by 2002:a05:690c:881:b0:708:b7c4:89d9 with SMTP id
 00721157ae682-708eaed228dmr161341627b3.11.1746524789214; Tue, 06 May 2025
 02:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
In-Reply-To: <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 6 May 2025 11:46:17 +0200
X-Gm-Features: ATxdqUGB2JgQGBx1SBATpWkN34LfUWNEz6bg2h7UGX2v3-s9HEuTp1ypMzGQ-9I
Message-ID: <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >There was an issue with SO_LINGER: instead of blocking until all queued
> >messages for the socket have been successfully sent (or the linger timeout
> >has been reached), close() would block until packets were handled by the
> >peer.
>
> This is a new behaviour that only new kernels will follow, so I think
> it is better to add a new test instead of extending a pre-existing test
> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
>
> The old test should continue to check the null-ptr-deref also for old
> kernels, while the new test will check the new behaviour, so we can skip
> the new test while testing an old kernel.

I also saw that we don't have any test to verify that actually the
lingering is working, should we add it since we are touching it?

Thanks,
Stefano


