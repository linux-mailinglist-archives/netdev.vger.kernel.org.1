Return-Path: <netdev+bounces-185463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B67A9A832
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD843BAF40
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FB23A989;
	Thu, 24 Apr 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hhQ79utJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CF236A9C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487070; cv=none; b=SFuWBqscMaySf04WTS2tcz6IclttQmefRvz6etqJTO7xjC0LKETD2nMzadmlyhhUpE7Bm9Otb8cbfu3YKAm5jRbfCIWAF9Y6WIieyo88/+hTNCHZo2z+nB8upenaqoFjlP4ps8CbSSRyqTXUcLCfMVyCM6/hnwHo3tQb63Zesr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487070; c=relaxed/simple;
	bh=/OFUtc6E14wdV65P9yIfONJCg9qWhxxWMsqL7KKETGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyQiZIY98JItarx+zgVryWBEP615WwTGGk4T0P2rAKEWF05ibkLZzvmtKghStQvJJpF2X8yWo9lQuGMZ/NRNIDA6861nFc1uFumfQ8CmJ8lkdKCQwJs6lolgABJo9+EsqQ0gVevR0Od89AvBi1oXLdZd24ycNdV+FgnMUU+5aIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hhQ79utJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so809973e87.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745487066; x=1746091866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OFUtc6E14wdV65P9yIfONJCg9qWhxxWMsqL7KKETGU=;
        b=hhQ79utJ6AyqNM94SbvQa3jNwOeZIZQKoqPqEc9fAHh170tSKY8T7jb5rk9hag9dVc
         m1Wm1mHGviWpjAdZThvM2F5Wn2wpVlov71sXRQiqN94pn9aGPaCDNy0zurOSvgExBHwp
         /s3KlWdVTWU5bY4/RIzD2yTnn6Yoy6NBCy/HvPjAlZerBOung7sGqAAk2gMwN1/l5a8C
         ptOJT4fILOUa6ULFhnuXkzdyWxzYaPMpL/obFpmye7aPqB6Eq0Nl7neLS6cYaZz7RaxC
         9QYwK7URPiXnA6Dk+EQEaj8xzVMwY2DblWmGhfH5IJQ8hhP7J5gAo5bDqHLRdY01s6GR
         86Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745487066; x=1746091866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OFUtc6E14wdV65P9yIfONJCg9qWhxxWMsqL7KKETGU=;
        b=FbJ+3XurKfL3mrrHr829I1KKpjl27+pBExsTecR89WtIct5ODgFHsIgeBIhCO1iORV
         SJo2SQEXo3as0hy7DjtLtFIfsc78qdmPNpnBEX5qwhJeF/mCq55M2TezMFwcdBVvpZrO
         +uYGoQV+PW0J5HX7cT/f3ttRqAGv0KnMoQ3PocyHVnVkdqZySjOBJ3BOr4uU8R9BACkI
         cE3myHuyhaGfhjo0yJilgy+BF49x/pjZPKL1Zm/GahkAiXyViKlans5mMmvBMzH3ZgHY
         v5Xr4M4iO+er/0s62XStX1mTmL50UgB9uHlEBSzwE/9bu+R5/efh5ivMvF+BUxUYa5Lz
         Y70A==
X-Forwarded-Encrypted: i=1; AJvYcCWetsbR9QGwGpcH/jAYGjdSZuxYHlwPDh9bpUxKVw5btemUZZEijzK9nU95q7cbPOUa9An53+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywI2e7/EGuiNSl9IDGKBbVzYuH5LBu5VpDhwQDdA73X6KDmBL9
	J7YTBPHzUfbEO6Zjp6wgdY45fH/EeZMcz5NbB8jk2PSY2OHSafsQJX1rqJIJw3nZOKg5wXEXfvI
	4VPdZUQCK7yrQt4P6a12UztCeR92vRQhsliGY/g==
X-Gm-Gg: ASbGnctYBqMA1pYHOMD1M3yJU1HWBiiyZYyU7ySGmJU3H8TyaAEWEvdtfnWqRwrgZZ6
	jog990G2Ocv8jyZHO83JjzE/hA/j8ITfTJV7lGZ5rzZMhM7b77P5CUqgJTWHjTxoDeDQdzGbnC/
	2sQ3RDib/fJfpIcEr7MTv0LQOq4DVnLj/7drtTGcDJTWPEYdqMtZtHQA==
X-Google-Smtp-Source: AGHT+IHsrcwDupy17KAeauM93eCNYxhglhW02BiNTpc5bBXPbxtFIaFqSommlAPszsE+qNtEV18lQUWNZqxLQ8RBYlo=
X-Received: by 2002:a05:6512:2249:b0:545:2953:1667 with SMTP id
 2adb3069b0e04-54e7c3f2750mr606356e87.13.1745487066171; Thu, 24 Apr 2025
 02:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
 <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-1-f3fde2e529d8@collabora.com>
In-Reply-To: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-1-f3fde2e529d8@collabora.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Apr 2025 11:30:54 +0200
X-Gm-Features: ATxdqUEmwhcixS5po8qzLJ1UaZ3b5-0QLF1L8tULREqHXKqmqmDdo2m_9ncmEOo
Message-ID: <CAMRc=MfgfZnQ4SarQGqNXF_f+rOQgiS49AHFKAKCtHTmStxZrw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: ethernet: mtk-star-emac: fix spinlock
 recursion issues on rx/tx poll
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Biao Huang <biao.huang@mediatek.com>, Yinghua Pan <ot_yinghua.pan@mediatek.com>, 
	kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 10:40=E2=80=AFAM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> Use spin_lock_irqsave and spin_unlock_irqrestore instead of spin_lock
> and spin_unlock in mtk_star_emac driver to avoid spinlock recursion
> occurrence that can happen when enabling the DMA interrupts again in
> rx/tx poll.
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

