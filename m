Return-Path: <netdev+bounces-74388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C292E861248
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628421F23C5B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78B7E771;
	Fri, 23 Feb 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FftO93iA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A277C0A6
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693797; cv=none; b=WlVO2d3p26GgL4ciEDR1f119ijTlsc+qIZGs4wUgnSFq3msbj8UA9XwbyF2Ce2LEw8Kmf41Qjr3c6ZhDw8MlJZn1G9ry5PVvGTD/4D6iRkmVi2B6XSjl5pXpsvRj2f91lpcDJaDbHt9HhmPQ8OMYVzcaoPlNvVzpEabCg84XtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693797; c=relaxed/simple;
	bh=PKYuV4ot/7rptb4iOd4uJB4HimHWngq7P3JcIdxqn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EY9kiPFxObYCH4BO1PuIiQMHbBpnpU4C8YknqhExorlugdYxAfpb5UkaqyUHjdsVP4YtINXhaiblJZE4/280Nv477gYCscO8qe30uTu81ut/GB0wjEQ+24fiL+sVynhvK2pXL5NZCe30X69yis8uaQZWzOWqcqOxwgJE6jm7GBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FftO93iA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so9034a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708693794; x=1709298594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKYuV4ot/7rptb4iOd4uJB4HimHWngq7P3JcIdxqn58=;
        b=FftO93iAaQBh4c40Tp+zwcVrLESMdTaahh1mc2KhiwQ3A7RHGzVW81rPjxAKVNjGrj
         hB5dStbHbNDeyYtheOiUqPyF6KJkboKah5EfXy92Mlhr8RlhmHpguI1EucG+8qgxMpdg
         sQAxGYZdqSvHh+yb1selguV3zJvXNqVX7QSerI+GJiv45x1iDvZBR+rGBJbzqD8qKUhC
         yowPOknriSAIMZkOryKo/gVB6pnlW9Mh/aAOc3I1jTOqOVn6hAwxwmo95rJS7BO+xE2x
         AmK+Ik8XXanXYOGRhl+UcYStSj8A/EhOzaoo0lKqOBKC3mTa2Y7/Xf3J1PzOZL+AVDuM
         9aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693794; x=1709298594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKYuV4ot/7rptb4iOd4uJB4HimHWngq7P3JcIdxqn58=;
        b=Wbwv7CgNY4vOYjNgTe4aFoz58Yhi6K45aMRYF4SXMfxZHqmKePKThLwYx44MzWMx+g
         esQByX/GIMXNfPj/MzRY9gRLwOOwjU7JZ7LobvM7sr3Tlnpfd+uZe6DU4JRMeGxoUPyp
         m+30W4xU/umyNFxYiG4ul6Jq7I+l+AYFWlwi6qVlNeon5lczizlFm7YhhoxiLwRRBT+A
         oQudLWssilGA9lyvIqjGYrmtWWzxXhrqVZciOxi+8ohrTOHucegJ+gEuOCATjOnTDvNi
         9KS+bDLMY3n8msH6E9WeUkMd6iCWz559YD6PNkj5QIoq7eOGdrUR37Zb3FXn/gZLNPbb
         yn1g==
X-Forwarded-Encrypted: i=1; AJvYcCWWOY7nHClfHTtvNfnuMk+x8qEzujJFdi8TU6bjBGlCkrgjGJtkh6PrCGvf1ouevTnzKYHA2mgkvSh9MXfuCqU7rDNfenU0
X-Gm-Message-State: AOJu0YyZ+jI6/W2x4UOpWFd2biWTz1lc9XzQEIMEJLILFQ4nNfe6pH93
	ahnoZ8fCgURXZbTdazJLdXiwD9cGHxzPoLqdWIlJwR5RUPVICezTGt1I8nFTjfRT2TJK32h7+5G
	kaaaX8ygd/bj5tCF7AnVy5KAJbvLvfpKAK0sW
X-Google-Smtp-Source: AGHT+IH6kjJDLjYuKL7yGfTJA6p/0TbA8WjpY+04SP7VStAo6HSfyq4kCHf2gmH9rQw+y+17XGFE5QFQvU+JtbNoI5M=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr700849edf.6.1708693794353; Fri, 23 Feb
 2024 05:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 14:09:40 +0100
Message-ID: <CANn89iLcN_EC2A0-3LaPLrevhrApM_RwMynUriGqt33FLORYbw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/vsockmon: Leverage core stats allocator
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:58=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
>
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
>
> Remove the allocation in the vsockmon driver and leverage the network
> core allocation instead.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

