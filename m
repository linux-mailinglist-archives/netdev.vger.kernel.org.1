Return-Path: <netdev+bounces-112746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F193AF8E
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E931C20D7E
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3168B14D293;
	Wed, 24 Jul 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFankBZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539D13B585
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815468; cv=none; b=X1wRIvIEoCqvyBhhB5pzfnsShtj3L2AfM1FeIqm85+5Zhjq+qmcjTjwes/8yef8YGKGzeGwYk2ZnH3H7iH8eoDeZIPOipZxErVrKQgMGelCb31otGedc0dyeGKJCegPElC+CoQDaT2S5zyD6+CID5uNcTLAq4L5ECNgHYHtdiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815468; c=relaxed/simple;
	bh=0ry878GYOIw6TZ5+EtsbRvu5e55vhpxkxNMAAdNzsds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckMbtmbj4NbB5b3DYi7HeJ1xPx0q5rTnPWC0/cQDsc3u8IUTwkF8WCTuY58Z4Rw/iK4oZwoLUSg81SdLMiG1cnhpHXFZH51R+wEWXi8Aoc2CJjyJ9yGiDBQHzHRbfWs2eFB0tqQQOGdaBFeWENtjY97T5uo13mo0jCoJmoy0gyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFankBZG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so11187a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721815465; x=1722420265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ry878GYOIw6TZ5+EtsbRvu5e55vhpxkxNMAAdNzsds=;
        b=wFankBZGuwtSyNoPFQBmld4LqNqI9KBS+o+8Cc4jR9KwLoCuG56CTxeOMRpBK2xyKh
         9BaXqED1zm+6fKtGEMn4XMNc7zYQPc9FWrdixsYLP1uGKFlaGcPNvMCld+zLkMPkV/uB
         xqdFbxsmfZDVf4D7T4frOs2U/QOa9AwcH6sedpTnE1wcPwFAr1wF/Xnu5I393SBeNjt0
         wr9l0yq6qvoA204tErMoPUANRvzS3LRavFBUxS3rxNkw04a8zwqzPl8ouQ0t66oLYn09
         i3KiYPEBtP/twK1QvRbhgXgDxX1kzwD6TVsRpBYnqAYgR4hzOEh9iDXudATc5qU7u8J5
         oMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721815465; x=1722420265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ry878GYOIw6TZ5+EtsbRvu5e55vhpxkxNMAAdNzsds=;
        b=QO0o4R53JUumq1vI7IZP6EL7HDhqzYKhZZvzsYWXDt264FUQEz9F2qDXgKPkreCer3
         cNpq81MHYxBBVsYPTRaA74gtJdmZClZSSFAhHjZ/X0jttSx4mfa0Ip9htPoEozFg/8oo
         rTqVHzgdMsc7Nmh+riw/c2EnWrZqtNiyrbAXCKNwVrl8WymEv2Vrt4sTWNqWsjkDtwgT
         91nFuIFfBaLjw7BIxeBTPo8V8POCC0UwV81F3e+IahA4W9pNKljgZO9RwTkdTkoYPOUu
         md0QGK/gXSim7uBgvKICPJTlPhYUFxJSr7IBLX1I2eHCLqGgTZ+o6IMlqLO3HdjtevLy
         yIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6rglPigKYfelCQ1i77ALB1jDM3V5KCMcNzIi2f9aAGfM5i36Lfeh1wLFvMC8z413jAmRHEJ9mX0pCj/E2PdZZ3wWuiKvA
X-Gm-Message-State: AOJu0Yxk/WZKJ/aTepQAn4g0dlcAo2mrfiqhc4tdV/itq96L8UagEGdJ
	5DlYihjC4N44Wqr4YvlVM7AA/75KouEYGO7Pr274nPCo5mAJjwEHViCYZWcNo4smxvSy1jaV1TF
	Tqb5pZLqx9E0trGnCA2lw0bHnJsrtD3jNvMA5
X-Google-Smtp-Source: AGHT+IEdJ41Amqd1U+VYaV+EHraFq08EiG5z+/hezqT1qwO8csrJKX+iy6AtC9wIeKNmElPRqZnvAcO68SIb9kkEW5I=
X-Received: by 2002:a05:6402:51c9:b0:59e:9fb1:a0dc with SMTP id
 4fb4d7f45d1cf-5aacc18dcddmr188773a12.6.1721815464424; Wed, 24 Jul 2024
 03:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
In-Reply-To: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 12:04:13 +0200
Message-ID: <CANn89i+C=trNKcg0WNW35t=dM=0Qz_G6o1XzfDM-7JD+wFmL1Q@mail.gmail.com>
Subject: Re: [PATCH] net: Provide sysctl to tune local port range to IANA specification
To: jiang.kun2@zte.com.cn
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn, 
	zhang.yunkai@zte.com.cn, tu.qiang35@zte.com.cn, he.peilin@zte.com.cn, 
	yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:04=E2=80=AFAM <jiang.kun2@zte.com.cn> wrote:


...

>
> Co-developed-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
> Reviewed-by: Peilin He<he.peilin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>

This long list of reviewers, and having all of them missing the
net_rwsem requirement
for using for_each_net() is alarming.

