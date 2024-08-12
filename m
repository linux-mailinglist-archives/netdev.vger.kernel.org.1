Return-Path: <netdev+bounces-117782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CB594F4A6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37696B258A6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182B187332;
	Mon, 12 Aug 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2FvkcNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E215C127;
	Mon, 12 Aug 2024 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480374; cv=none; b=nwQWBnVryqxZOxGREKlT6Wh3SQPq26ATwg3W9ga1N2F7VjyHw8+ERHiw6Q1LKfHJhN/+8AuX73KBdYmYGD+XY1xndugEAyWTamtxXglUcDIaejo+ThLJbqEuAXS+g3p5xxEggaALvBifCmr7PvbOSppnLWY6COb2Foj6KMUvNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480374; c=relaxed/simple;
	bh=ymOFvrgOOD6ziq0VdD7c2aBE1giSS+9DVVT2WxCFpqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP7BII1V2BgeBqQ48gcQw2tkPzStACaqmPxhnWc/kl8cs9kGwDAuZxWhKeALt2xV59MXMkSYIfOFo5Xwf8Ie2VkxMzpDGb9iyluxEPIXnlVSKCGVzJJj7uXgZrdL5Cc9hEcFQ7v0LFnhdmBza1iu2ZTrIXpeIdvGu3p1c7esXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2FvkcNz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36bd70f6522so2486644f8f.1;
        Mon, 12 Aug 2024 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723480371; x=1724085171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymOFvrgOOD6ziq0VdD7c2aBE1giSS+9DVVT2WxCFpqI=;
        b=R2FvkcNzKMKJr4QsK1kFIHVbwhlDWfMD5lRVmc05bCCZ78+3+wKdIlupCjmVrZY1zW
         djAnRpuImy1kaMPSYun+YBlEFuwWFjXdri/dYnBjSROW5k1YIrvIsyezAt3/BPIlS0co
         8m7+zTbUay4gH5xAjDBTJbEzdn8QN+0v7fSHdvRzHbKOGpKA4AYR8wuHsFz+U49FxIxJ
         ykxLlnoacx/ADMs/He8TKG749B/bZ6VzjrIKQFrGM26FBqMwM+qkjezPng2LKFqjoPXr
         b/LQiyrfIW2ch+AJ5PY42TQvNY9z5Z+L34L/e4gxrbdqJ3JyoVkXn4rhfVfxtHKP0typ
         CImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480371; x=1724085171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymOFvrgOOD6ziq0VdD7c2aBE1giSS+9DVVT2WxCFpqI=;
        b=QKZ10T05H0vXhk2GiUB9zj+DWuArhcRo0xMl2ho4bYezFKbAgk/20EOPHQer0AIEZp
         5dZ5NfS50BCgAmroXmWJzteh7buvhDxEJbWOe6hwG/mf6Q3VA8mKbZ6xyHAKNHKy7OPA
         IGv0yDYkAK/r0epL6Ant9GKBP0ssYUKbLbRt9jc1w9NjbtJrA4IQeQLqTCVwCBRr8DSW
         KwwDYRWc3w3ZSBzvsboX76/vO6Hs6tNUbY+WztFBpNvQiYdlXi8ILpXHn9Ww/31HF3vU
         ArugiTyhWuE1wrtsjGfzB67wZZ84AT8XMl9ZHUk1trthlRspb4U8+1whCj3/T4GZwdj7
         XAZg==
X-Forwarded-Encrypted: i=1; AJvYcCUzYLaU17FCQARAgHwy3Xq9kxyYOqF2tbc7jCuHY+km2dPC1AXTpG3LcrkyfrkXyryvSRIetyfMPyK2JRw=@vger.kernel.org, AJvYcCXvV0ycRF8gp+KDP/LR1rOu9PsWizDpd/lR65sogxdh/sPE98osy5hfInPaEXmUREVTmvrhRpkX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QTpDMytLG18gZUGJOYoghuxzlIwnR7qgJOS8lw8yl4SxUKdC
	BtuF3l8Tjpe8U/dpatBTfQDoJHpXPFRyOKQxKH7KZpUAlQlfT4T123aj/9SquAijUcCzCEgg2B9
	9Iwo1Om/DSzOWTTqpdieMX1o5UKs=
X-Google-Smtp-Source: AGHT+IGju9Iel2Z2uj3B86jeJimno2vj6Gt/AdBLAsIHf1cnvOVKmade9JDnpfNOG5dqOfP4r5mCRvmtOMZpUu13BVU=
X-Received: by 2002:adf:e003:0:b0:368:665a:4c64 with SMTP id
 ffacd0b85a97d-3716ccd8e82mr764686f8f.5.1723480370956; Mon, 12 Aug 2024
 09:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812152126.14598-1-eladwf@gmail.com> <b3f2ac81-93e5-4143-a3fe-a5ff1159aaec@nbd.name>
In-Reply-To: <b3f2ac81-93e5-4143-a3fe-a5ff1159aaec@nbd.name>
From: Elad Yifee <eladwf@gmail.com>
Date: Mon, 12 Aug 2024 19:32:40 +0300
Message-ID: <CA+SN3spFyFx-RiRPs0apTojKpC7A0geAs_JyqEWHC4z8UVrT+A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in LRO
 rings release
To: Felix Fietkau <nbd@nbd.name>
Cc: daniel@makrotopia.org, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen Lin <chen45464546@163.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:34=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 12.08.24 17:21, Elad Yifee wrote:
> > For LRO we allocate more than one page, yet 'skb_free_frag' is used
> > to free the buffer, which only frees a single page.
> > Fix it by using 'free_pages' instead.
> >
> > Fixes: 2f2c0d2919a1 ("net: ethernet: mtk_eth_soc: fix misuse of mem all=
oc interface netdev[napi]_alloc_frag")
> > Signed-off-by: Elad Yifee <eladwf@gmail.com>
>
> Are you sure about this change? From what I can see, the LRO buffer is
> (or at least should be) allocated as a compound page. Because of that,
> skb_free_frag should work on it. If it doesn't, wouldn't we run into the
> same issue when the network stack frees received packets?
>
> - Felix
>
Hey Felix,
I encountered this problem while testing the HWLRO operation on NETSYS3,
but it was part of a series of changes, so you=E2=80=99re right, with GFP_C=
OMP
it shouldn=E2=80=99t be a problem. I automatically assumed it was a necessa=
ry
fix.
Sorry for the mess, I'll continue testing HWLRO and resubmit this
patch if I still find it necessary.

