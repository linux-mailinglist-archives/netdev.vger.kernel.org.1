Return-Path: <netdev+bounces-249162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F9D15352
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D4193004290
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387C326D65;
	Mon, 12 Jan 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+JI/+ck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49863168E3
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249572; cv=none; b=B/LTXVWzrzZFPQ9eXg1AopPHkfmyivvroI9ZhoKv+7NVp6uKvOcZK5Hz8tMPmCyBXFoEleaMGBOEet14tU+iD1kyFN29tDWwiHbG9QMPqvSnvCZVsNUZLaxG+JKO8ZYgf+g5EVBOeq9+svTLQiYa8fXlomj+4iIpjA1FjMEK10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249572; c=relaxed/simple;
	bh=JieHi0qplEZ3gfW65F+2v3toDZ7Up6bQbcj9mEHQhCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbAZs6sxs2UdsdKAVYiSF8gef6JflBhGuS6dUCwI6lz0oPdLYRtgzRcDvJHfgWwgnddzlZstgMnygQ8p/8KYIAcZ2HtgjaufSjOFNoZXB2xNfz0CnXpBww1WroH2/+CMcMDRoMKNLaGUG7TmZt0rmn2rVQtk+kW735pt9W9FOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+JI/+ck; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee05b2b1beso66253261cf.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768249569; x=1768854369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JieHi0qplEZ3gfW65F+2v3toDZ7Up6bQbcj9mEHQhCc=;
        b=O+JI/+ckZse4AQfVv9ACnW/b2NFGBxq2WW7AaKhFSoWZ7nG97Z5laKI/uuCNVt/MP7
         VddwIKyZePWc32q+sGHB1TkwX7IyTdIQZVEuVZioVrxoiIQVL0WtwHBcXJ+gq64AuvP7
         aUqcM3PFGO06OeVYbSmfPo/NkW403sTWAAx6xjyB0NBkvnC7vIpcqnhLe0ghRz4o7NkG
         +6sBdy2LEwSrDxS4eq4uWSPbNPRGlTg+fGFK9goAg5fX64PX3PZEHdmmT0bZwpH+ktn1
         e6dIbeYN82vzq3p8cRBCwwQF+8iF/AudtbdFxxRyD7QJkxZOk5DxLCiDsRMD3dqPt+vD
         u30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249569; x=1768854369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JieHi0qplEZ3gfW65F+2v3toDZ7Up6bQbcj9mEHQhCc=;
        b=beOmwMsHkUeDbV3H8+NObRZf/51sFbn5wbSEDndD7+Hz+y6ySBQtBx9AzVO8m+4Tob
         ROTWalIYSmntk2A1qNHupI1v2c3vFVfZB0eSSQNPsU2F98CHiePJnNBHI+z+rsI0P/Vu
         tkFKxwDIbasxsSOTHzfkQauvM4PgtdTfKewy7XG9yhTIw10uNAlCPh113QWy3KTAti9q
         5pAnDgSk/hs8KMa+SvVtbCwjGnqYr2AtkI9q5H+xixFWcwvGKqZUvC5YIstS21IPTdNb
         17d6dbT+on4/qLz6Dnu1ajyufa1AtRm8TTqB+r4KAv84MRElVhb0QG4egOmk+S8BmBln
         Mj0A==
X-Forwarded-Encrypted: i=1; AJvYcCXOQYAScNdGX7JaI+tQh/4/rhPZua7ZRu9udWXf4CRVF+jk/Hk14Icf9mwmKLnrof6G+GbXiqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiQf+T56U5hm5unRZl2WHQAn7dh3AVuWDJeGxB/n8inkJobmN
	6tIRLtRsQEHuM8hDIYGH18mxVmjk/ip10WjLM43fsJdFwyrGEhSCu5HWI1MB6MwX6J1ROPdPIXJ
	wEz9B1UNTCkuy2y6FjjYs+cDZfxUYOhd1e15ayaI6
X-Gm-Gg: AY/fxX7iAEYiuD0RD28GBjk0QmCIMU0nI2J7iYfojf7PBZg3ps5Y5WIfc67JVfXobVP
	AIRLu4H3AaTMB0/ACNWhHiQEifL6/hJrC8/jRvk2ph6cdAtN/5P7JFHwMAJKSn/zEvIhHDGip02
	56aA+bVNJZZqbbn8hbzTbML5jsclxm/dbfR4F85mVtUXy2D3OaAW4E2d/o1GwH5jU7d0lgB4lOf
	TymtmqzFlH1pbBqjDErG5BrOFVPLTaDE8nOszbCJfgrZPHD1hPJZCTpUcmVkprbar24qGRp7CbU
	WqTuyg==
X-Google-Smtp-Source: AGHT+IFD1TbokyIzZf6nQfBjSe2x0pY2LKII47vmxcN8uUVptT5gICMohMdV4GcIIOJARTzSSho2tN4S3XH4ycD6i+M=
X-Received: by 2002:a05:622a:1301:b0:4ee:1a72:cf84 with SMTP id
 d75a77b69052e-4ffb4958e8cmr267319541cf.27.1768249569176; Mon, 12 Jan 2026
 12:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112200736.1884171-1-kuniyu@google.com> <20260112200736.1884171-3-kuniyu@google.com>
In-Reply-To: <20260112200736.1884171-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Jan 2026 21:25:58 +0100
X-Gm-Features: AZwV_QhAmxsJ3gNFpjVFGyEGoYfobF_PAnoHvRvGA8z0I4EUYQq9iHDPN9n7rZA
Message-ID: <CANn89iJxrbDkUM+MRParMrvJzDY3DS+OFmXecN8oq+cKMp7zJQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Tom Herbert <therbert@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 9:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> fou_udp_recv() has the same problem mentioned in the previous
> patch.
>
> If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
> fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().
>
> Let's forbid 0 for FOU_ATTR_IPPROTO.
>
> Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

