Return-Path: <netdev+bounces-65730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A783B7BB
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C8FB257BD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23C1FBF;
	Thu, 25 Jan 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMamXgnt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA838826
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152634; cv=none; b=OvVDvW5fy99rIVp4cYPA30YG3qt3kqEw7eBQUtF6XHTA4vEEzgRVezFCktq1rjlfVt+a09K0B/cFWGYaazgG0F42ZWWGBJagh1RsPa/6ch6tPgLR7M1P03h/yklN/zWs6qB0ZqzTP/yCSWwInhb8ErHaVg/QpAeP7Osv2V3fDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152634; c=relaxed/simple;
	bh=gMG+PZu1Q6tIAsDZEa3EEoxCREKFYimeJPty3NdkwT4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Gxy8khOrnOd6FNTOT4tZM+gsXluj5jhhL0O4mQwxZpr1+B+GVtVSOX5FG3f3nXmvEIDZeW5F2C3tLREMXjvG+kjFzC0NGYB0wuaxEPz+noTLIQozBZ33gn4kXuj39CmIwwNRuVB4a+DjDzUrZj1BBW21qi6KwvbqF7h7Iydnzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMamXgnt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783b5aea9dbso75257885a.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 19:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706152632; x=1706757432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCiYhDA2J8P+csXeUZjIuzrVBbJYBPRsCAXvDdhssHY=;
        b=mMamXgntevy1RzYzYnhrzXpv1FlwufEsG/KOgbbURUM7CWkxhH7CGnzm8KNQpM5Bfb
         NlLiW41nQE3dZmHmroQPY6CE2mhBT2Cb4ekVu5yhvM9X2NwD/iPjMEwzIB8depIapz3O
         1pp6siLjnEL2lJNz0I7ijYFSoUjFpLcLuIUXLXp7vi1J7aPT0JcAl21m3f45YMhrpTwT
         VEVixyNzMEgJ0hWVdPTjd0Fvoib4D5arCGRDuVo+MznTx20IJ+iANxH2E1DHPNlbP9du
         aiFBsApEKMutocyI2tE7EwQVDNl21ySHetEjv6xngipX9/NXJltg9eAquCLy3Y0tbXiV
         NEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706152632; x=1706757432;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCiYhDA2J8P+csXeUZjIuzrVBbJYBPRsCAXvDdhssHY=;
        b=NGOMMLCfHegOec41CSz3KM074Q9kyiO/HKzCyCDZJDyPfPGbFDq7+L6ljNG8EvehW4
         5wBIdi35AUFLp3jUlOjRWxe5iSVlj6LNIl9mw8hndhH99eyud3uKjkyrxi5iTclK+FEX
         jF/21uzQGuTR1XTSw4t2U5CQWfNkAZ6zh83ZEjBQh9hxlVZyrARsFNotWgea3xs7V7U8
         OLFMGm7ntqwMe7QIPMPmC4pgAcHEioAN0vRXkmNDlvwZLiWSEsp3aHY4ZOcqPms9uqGl
         GOnKiY6/6GsYh4p7jA3EfFV4jkgtWB48U+UAqRBT2/4MU17/Fyrfn/FyuEPrA1JH1n9I
         of7w==
X-Gm-Message-State: AOJu0YwxcZ6OTvl7HXv67h1P4RpehFZEF/h9Ro0TejTrzXDzhzkOE1OX
	Yi6WSdStIZBVLicElwd90bsWPFLaXsjJkCvqbwy8o3ottC37Iqev1i/bgcEU
X-Google-Smtp-Source: AGHT+IH77XI+xfh/ckZi7tSt+HmYT6upRD2lDI41lNrG31gzHOl7380WAB1PjyIRYm8YuSd+0ZOCHA==
X-Received: by 2002:a05:6214:c28:b0:686:ac5b:fee5 with SMTP id a8-20020a0562140c2800b00686ac5bfee5mr316873qvd.24.1706152631827;
        Wed, 24 Jan 2024 19:17:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsEiOUUqRt5qvNHOeSyTGwvg6uychnxlfvYFpu/kxlBNR1OqQBn/pTqV2hkwmGb5wr4HYDKlMumz68xsZONDhpCOhWGmBdo1vraAvEeFVssPcu0XHPAWUSmRKdg+gqDjbJPRAYrG30JnMVs+vHnJuh3Hidg7hIwLkcKLTnn3h8E27/gBrYCJc=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id mu6-20020a056214328600b0068602f8966esm4685663qvb.111.2024.01.24.19.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 19:17:11 -0800 (PST)
Date: Wed, 24 Jan 2024 22:17:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alan Brady <alan.brady@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Alan Brady <alan.brady@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>
Message-ID: <65b1d2b755e27_250560294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240122211125.840833-5-alan.brady@intel.com>
References: <20240122211125.840833-1-alan.brady@intel.com>
 <20240122211125.840833-5-alan.brady@intel.com>
Subject: Re: [PATCH 4/6 iwl-next] idpf: refactor remaining virtchnl messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alan Brady wrote:
> This takes care of RSS/SRIOV/MAC and other misc virtchnl messages. This
> again is mostly mechanical. There's some added functionality with MAC
> filters which makes sure we remove bad filters now that we can better
> handle asynchronous messages.

Can you split the part that is pure refactor and the part that is new
functionality?

That will make reviewing both easier. The first should be a NOOP.

> There's still a bit more cleanup we can do here to remove stuff that's
> not being used anymore now; follow-up patch will take care of loose
> ends.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 933 +++++++-----------
>  1 file changed, 375 insertions(+), 558 deletions(-)

