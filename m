Return-Path: <netdev+bounces-211401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA4B18893
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12FA178A8B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6121CA0A;
	Fri,  1 Aug 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ed3tS5hV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143B13A3ED
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082927; cv=none; b=PQDG4mPhZipyXSrk/cT9s18mOirqeTvBM+bvu7PJ4Sub5JCcHW4psZ0HPRmfUaF27put4dfXbXBWsuM1A3kCCRgxboJXblhQb70U3MOoKiXepvRvxUuco2wIHmtTTA1iUlMmp4XhaO0tHtl4GEhCrFTb5x1rwbJvMcl65akmDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082927; c=relaxed/simple;
	bh=8Kri1HoPuh6lwB0F7qiPiOrJzYKY+av4+R1JiwsLGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfXDNOnbLCAyUd6JIulc+HDGLaL70/MEiedG4UIK1sb2sAgV3c2s0NlrWe2RuGQ4WO8TpJftKjsxAnQMCXGwgXwSrpkZNPQTP+I8DXGRBskyJCDNEX+TnE9N0GlPYm2eAi76pSi3ATLJkLBVhn8en8V62BzGIKyyZDZYfCn0fjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ed3tS5hV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1711351a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754082924; x=1754687724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=ed3tS5hVmqg27kcwp9asyn8v6l8kjsZbFtV+T/31MD/k+8EI8GJab5hp0BiLkK67Jw
         /JGfBr2tm9hlPX8uLLEANRha18elStyH2x8Y0ayiNjPefui5stg4D8CobI3v5UMqvqb6
         9wzLq52cMIgUVO7W1+9G/LhRjXzuVqDZAiWoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082924; x=1754687724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOAZkZ18mJY5AP4pAaTQp2Y2a24YFEEDzHLPHw5UlIc=;
        b=ZWEhoTDUh+rw078qlwijv94SPba6Vv5qtctL80QPs8S8qq/5+jR9XHiySlT6TTEzXT
         9oNOE85l65VwQXNNpEyCtB6ENwtHwZ7EiSw+XhU5Cyx8Y0dJi0GKhylpo9bT16yxNi/T
         V/HBdS9vYYUdcNllP5kc9lYvhjsdcE16yTLEAH6YB2ufRbP+evWSZYVK9likhZ3rpYXj
         7mEouryOHEhG87dGKHww2t9OsAZ2MQvK+3Cz8VPeMyMgLkFwhj/87EeUciQxyYVq7rI5
         4bxbeHy8J4De8PjW4R1Agc/VmdAbLO37MthdGtIS5/TPw4ahfaDxsq13UxzoUZ8Iopc5
         axtA==
X-Forwarded-Encrypted: i=1; AJvYcCVGlczKjcZ1deupbQSbq0f429TV0/brzJeHw5OtCLFvaLQSpSaeqUwnqveCZhO9OTWpB2upyjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XYerR01ssPSyyZLOUaVQf01xJAKJNjxnzRwlfLQDvdcnNztS
	XZmzdOrKD0K/aygrrXnz9ztn6C2J0ruMOsucCRX6RNegNR+BRER3aTbxkrhKiqGX1rSOUaxuIR1
	5s+nZZGA=
X-Gm-Gg: ASbGnct30oSvUt66AVXUrh/zB9TJl0+j2opMF9aO+K64sRKOm6NjZPjBeU/9rX5U+4Z
	NlbO/vU9KOhIilfdrhSR3zjEDD+mYSFPQfIXzAA+hl9VLpYe3h/5D1H5+bbUURtFmCWEb08u2Wl
	IM0Jk9BrrQo3M/qx0nEPY8u5zM0eQoV7RHn1ScNi4mS5mLQ5+mSGt0S4eWFwldXmwmyT9l0/qLm
	+U5HQylY+ovlgoFK6vUuRm8lj3gZjhCd5fFoG26VQBnnqzVQ5MhKpdlQ909kX36SLIfzaiRGq+n
	gsO3aFx90uMhlnU1hg3n20TqBzz8Iq7ZILMMq0Vymz9B9edpSM1AUdiHmYxctRg8HIEzQLKrv8r
	z5ApsxmVZERL6Lu6FpcFVfVzIjyQlQfW4JBX7r/cDIjVOo+RlOce7aNYLsIkD1wJdh7bm6TKx
X-Google-Smtp-Source: AGHT+IEFSlOKkJ2ncHWRS2v/VhQ61VqkNnQnWM1w5NIhwbWc3p+Bbb53W11TxkRlVahvAPnlW1VmEQ==
X-Received: by 2002:a05:6402:2808:b0:615:e8f0:7035 with SMTP id 4fb4d7f45d1cf-615e8f08924mr372453a12.30.1754082924180;
        Fri, 01 Aug 2025 14:15:24 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a91141e9sm3243211a12.58.2025.08.01.14.15.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:15:24 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1711334a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 14:15:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1VyiqPTcJdYj0vkTNnEyA1ws0oRxUcAcpE+cqC4MB1659o1B1/u5A+QwyrAgBDszDRl3eF4E=@vger.kernel.org
X-Received: by 2002:a17:907:3f99:b0:ae3:6657:9e73 with SMTP id
 a640c23a62f3a-af9400844fbmr144333466b.20.1754082923387; Fri, 01 Aug 2025
 14:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com> <aI0rDljG8XYyiSvv@gallifrey>
In-Reply-To: <aI0rDljG8XYyiSvv@gallifrey>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:15:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
X-Gm-Features: Ac12FXxTQNyMa37gD218OICz8yv-5X8AXqC2OjqDUUC5iyMABu84wbERpHpCWcY
Message-ID: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:01, Dr. David Alan Gilbert <linux@treblig.org> wrote:
>
> My notes say that I saw my two vhost: vringh  deadcode patches in -next
> on 2025-07-17.

Oh. My bad.

My linux-next head was not up-to-date: I had fetched the new state,
but the branch was still pointing to the previous one.

My apologies - they are indeed there, and I was simply looking at stale state.

So while it's recently rebased, the commits have been in linux-next
and I was just wrong.

                Linus

