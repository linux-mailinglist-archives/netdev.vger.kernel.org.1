Return-Path: <netdev+bounces-177558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D6A708B9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4D93ACC69
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F26265618;
	Tue, 25 Mar 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g07Ers3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CE265603
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925723; cv=none; b=a0MtlnOFlgigBrclzPu1pAjVviVfRX5RBeLYzDnelxBGT3ArEvc8klzYJCFdRznzSUc1iGc5RHNNPeDFJsg6hJ5F16d9ljcw/X10QFDENdH/HGw02bQ/Is1s/Ngm+7zsaooHfDRHutjqzvSDLHRiO2pKwsLDrscZjSZA87+K5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925723; c=relaxed/simple;
	bh=nBe3zGLpdVtx2TpfUjl8x3LjWqxB7g2xrrz1dY3GhSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmn0fTIKJp/2GHayZc/L1oTDyxWs+SZnIw/LmqA20KFJ8KhrqbweMwJ/eHKx9WrxaTob8bLRWD4ffrd5DrUi9KGJhXNJwswWG0oLgl0tsENOMpjTWoai2S7NCmNM+BrKUVemCasN5Cci9KV0w8DdWTUynDMU/0BOlEZzRyfSIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g07Ers3a; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476964b2c1dso110984931cf.3
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742925720; x=1743530520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBe3zGLpdVtx2TpfUjl8x3LjWqxB7g2xrrz1dY3GhSo=;
        b=g07Ers3aLpy10fsyxl7wvxxli9DAUieOpLLnidlrkYbfWxkYtdjrGiHnxqIzLdh1Sk
         uxxupdsb3vJ5NKcl5j3QbSKZZ+SwlkToY8znlfZdb3JyRVgWrs5pCL40Uv/jjLp/fene
         wPOyjoCMXH/4QCc8RmqrKTUXH1w6gwMm5MN4/qdCWAdUs8Q2ukBUTbge3GzoBrFpC7uP
         z64Y5n2dMBcsaGflx9Rx7PT0TOSmrdnBOl/bvPTrV41IkhdORaS8vpBOH9iyTqQ6MWxW
         SY6kRlQBoWGdBytFfWofgt8KApFzu99ErN6Cq4jOsH02U/WUStan2rbt24p6HhkXVux+
         HAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925720; x=1743530520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBe3zGLpdVtx2TpfUjl8x3LjWqxB7g2xrrz1dY3GhSo=;
        b=fwI+Yw9nCzcnuIp8dOEDRlUj8/VgD62W5XJjthSQqgJe6hhBmz79IQgedYpBB61PC4
         h9mRC4Mkwp40ioNnqFym4X3ueWO0W477HolxL6dInJGBU7xQZAnrqn0eww4QDNGgsMPj
         NLtGvOg7pMU08WLbtdYj+wV3ndwwlFDVPkA/Vuj9KtwpKmQJGaWd/FepVCZAm/sjpcwS
         3itUIxfVBtmbheOnQzRhUfP4TQQlW1KBxgCPCAOS+byuTF72k9nwxRlViI6kHQ1civMV
         4wkoY2iwrVuYiJiKn8EKuPem4ZBGiPlJ1chXlFqhmW5DRL4KwoSCH56xsO3wbAgTW3V3
         hlbg==
X-Gm-Message-State: AOJu0Yxhecd6me4bvv9XlUs4hnWYZxaXveXIW/LzYtUfXHKyXEdtxhEW
	i9NXpQvpAf5YNPmQ7jkFdhFSp2Hxw/GCzab6kophsH3Azv7mKPTEWZxfqqzevJehlD0eOhSU517
	ZWTnMx9Wr3BkDbcK9kUGEaJT/IJddDI+rYtE7
X-Gm-Gg: ASbGncukPaVfnTMvsFfHVSU3Sf2EVK4wXbksnWwen/PS7uol++veYnRGayOZqB1ZHFv
	UjBbtsBKUZggUxscYMCz9MGPdpfjtjyGMoJ66PjFWtF9KLhuNhPo/bqE+j4JUcj1JyQO1mcnYbE
	VxaE8oieF8MNyA2A4dBdGSl8RSLAVs8wj98gZS
X-Google-Smtp-Source: AGHT+IE2zNeAYadQKSEAu2jGcKbwREU49DEUc9mlzH2ALvVEnXaVYK9d5inWAkViyVxCTrbjFKcstTY9At7tbjntAeQ=
X-Received: by 2002:a05:622a:248e:b0:477:dc1:1991 with SMTP id
 d75a77b69052e-4771dd8a00cmr237928201cf.17.1742925720314; Tue, 25 Mar 2025
 11:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325175427.3818808-1-sdf@fomichev.me>
In-Reply-To: <20250325175427.3818808-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 19:01:49 +0100
X-Gm-Features: AQ5f1JpCMICqG_MhhZs_EeG4szfKLs9TGJweJEYGKcTu-ovyK_httNDsYhSSmWo
Message-ID: <CANn89iL9PMzJgMuObe==o=OHsHsVSVUu81_Wjp2daK92Lhu=fA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: move replay logic to tc_modify_qdisc
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:54=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Eric reports that by the time we call netdev_lock_ops after
> rtnl_unlock/rtnl_lock, the dev might point to an invalid device.
> As suggested by Jakub in [0], move rtnl lock/unlock and request_module
> outside of qdisc_create. This removes extra complexity with relocking
> the netdev.
>
> 0: https://lore.kernel.org/netdev/20250325032803.1542c15e@kernel.org/
>
> Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_set=
up_tc")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomiche=
v.me/T/#me8dfd778ea4c4463acab55644e3f9836bc608771
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Nice, thank you !

Reviewed-by: Eric Dumazet <edumazet@google.com>

