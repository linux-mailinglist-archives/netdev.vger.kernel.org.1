Return-Path: <netdev+bounces-201614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F8AEA0F7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9881416A57E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668512EB5B2;
	Thu, 26 Jun 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8j4cH/K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59338FB9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948416; cv=none; b=mpTL89ZEHg13/Aro79RnD85fjlo2PRSbNmRwEXhIMKdZeywdmV9JgZWsJvd4Fupxq897MHAPsDG4XdWyunkBtoBfyr82SVa37yzPUgpEz+R14kwNhIAmahZtgGiZZ2jGW/4NASdiGtR5uQ54Fh077BCKwJ5yrfQUIisSdRVCjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948416; c=relaxed/simple;
	bh=UCRjOz/czwvEQUOshwEwRXt4XTxf8MbrevXm9AXtABI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6xZU9yJCyyhDySsB/AWKHx2TMzGEK5acAHtNfOHxdgA7evr+rfyZqk8Ggb0UV5vq36Z70RsHrmIXbIaNDaFjM4LJmZ54FBLMwfVTq1L4nr6CJZ91wI50VghbhCLHmEXGk2caGc2d7IDnmk5z+B/yHG2fIk3JAfq/K51LkNfMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8j4cH/K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a44b0ed780so15604681cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948414; x=1751553214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCRjOz/czwvEQUOshwEwRXt4XTxf8MbrevXm9AXtABI=;
        b=U8j4cH/KUWVbst7FeuwHQ6/60qt7oyy3nGMfGM4nl1f9jMfDYW2k5n4/r1/vfOYlKs
         TushYnfA3IJmgXCRifWMzoadFnDJWotDg+2n2CRVZmvXjVMmm7HiXaPzgTYpWiSA/GTL
         tcax2Ni5X6QmiZM+JFwAYDmis3/W2gO/G7iwm5qJE/euJJljzQ260HjxmtYiyKI05gc0
         HQ3dRCZc67vuZjTK+IaAo4J6azKk7Nc/wfkt4erOdUpuFCWvfy+TVNZWPMCv9OHVvYEY
         OaoXYqqLTD19CwPYs5Cb7FytsEa4g15gysjsvIzeDV6UbGwZAxL5FT4d1gvMRC0medve
         3nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948414; x=1751553214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCRjOz/czwvEQUOshwEwRXt4XTxf8MbrevXm9AXtABI=;
        b=kBeTogXims8o8vX4dxobzgcV6Z3ud317p7vlzdq4BhQE0p82k0MQxykfTraYMcm1oT
         DhyyF4eaolYgSZ6GIfYWF2ZJRDoGDnsAckAQowysiGqihpwVpX9PjSKnzz/0LyqhR7/h
         wM/U7lejmi/SU32802NsHoBzKa112Tuhck5R1btQzk/zQKGebu+oj7uNjzYHhLqHnY7P
         6KJJybc729tJbVQIcQKYqTLh863cITYLgj9CTnBPjFkbp3MKx6bv+4ECQiosKyTUsLD3
         cr2l9kIU2JhloJsnOckr7adY54+nTniNBGUcqO37S4X3qxAdho9EirN4BghoDR+quC2t
         WhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVwKHL4bgNMoFqwolv8NBZLr/V/6wPCeTxQTGYo00Imb1Xanj5ew832aI2cu2GsK04vUy9ejc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADkga4aHP2r3DAAIi/mPWrzSU2eOh0/WIaNkTNl+yeRa0nipm
	rwRESVBs3dXWGX6p0RGqmwaUjo5Cyj8WfIoAYc+KDSdnFqksrP9bGkyEy0+6lIIAIh6gi+PXZ2+
	aAShtF7TgRFTHc6aTfGwsuUcilqm0qrdIDGG5+exu
X-Gm-Gg: ASbGncvkLPzXVz9eAqgtRW6ZjXGMO24xaIz1w4o2gM54uWJg0apmKE3ztRBeC7/Kr9R
	GTY1FA2Rw8cNDm0QxHtVORwl26FBJwAoLHYD4tBrBzQQo+vPQ8mFvY5ylNqu7aC1Ihwup/M83Kh
	km4KcuUUp/mkEXdxuRsnJD1X9/RiXky45ywz0SdpkxeRw=
X-Google-Smtp-Source: AGHT+IFe6QGC5zEApMUdIEkXASDqguwmBTk305elthDLRcrv7vn0SImE69PFL4sj+tOeh5G6CxZF/HhWkbH3A14neoI=
X-Received: by 2002:a05:622a:13c7:b0:4a7:f9ab:7885 with SMTP id
 d75a77b69052e-4a7f9ab7a95mr21456721cf.38.1750948413447; Thu, 26 Jun 2025
 07:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-6-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-6-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:33:21 -0700
X-Gm-Features: Ac12FXxEPAOmszvJ_jEMHzFVr4GqL4KZsh4EpFS5C0uwWzHweaAz_8PpWOQYSo8
Message-ID: <CANn89i+WfErM=qvRbQGmHR7xC-aJdCJ2r7efcUvUko_y1EfAdA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 05/15] ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> As well as __ipv6_dev_mc_inc(), all code in __ipv6_dev_mc_dec() are
> protected by inet6_dev->mc_lock, and RTNL is not needed.
>
> Let's use in6_dev_get() in ipv6_dev_mc_dec() and remove ASSERT_RTNL()
> in __ipv6_dev_mc_dec().
>
> Now, we can remove the RTNL comment above addrconf_leave_solict() too.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

