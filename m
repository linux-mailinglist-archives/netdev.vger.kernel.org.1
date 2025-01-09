Return-Path: <netdev+bounces-156715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453EEA07946
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C43A1465
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A340217652;
	Thu,  9 Jan 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1qH/aBwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058A14F98
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433152; cv=none; b=cd66cs0IrhOsYJQX1x8MKHBvCAumO7dcVOl7sWw7jRSRK+6sa7WhCr0K/XSAIyJCQ6XLNEck+IubhoRh6tYf1hS/8AAW56bcgN1l3zoN/5tcYJj/TTMkvfYpZdgRMkCPAW+/kmAx/LwuorvIgMlkINogvIpomdLcZyIJ+8Mk7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433152; c=relaxed/simple;
	bh=KxTZnEfavT7pg2KOoRcc+5ZtkU789ccZDAiLumc3pwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2rXGYuIBtctSuMB/yc7hYUBBW4XU+Pi/W8/i9jffdGWWdZoVgdps9uND2wgzTGfHG17vmA8TavmWdzbI7Q6ajMts8pO+HGeWRwEHE2iN7fCcjrb+UckDmmxvDAWejXxQPzCHENiX+5fzuX9Ruj6Gu1pqU3I2b/HONqEKoPpTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1qH/aBwQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216401de828so15653785ad.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 06:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736433149; x=1737037949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxTZnEfavT7pg2KOoRcc+5ZtkU789ccZDAiLumc3pwI=;
        b=1qH/aBwQHBP/4FIjW3U0Qq4vMTYX+bFbeIXQrZtuiab6NM2eQg6m8I3TGS3uOjwyAO
         9Xq2uwMxUrSmQJInknl47wPirXtL6g6d62dvGp1eibGLg6AEy0ZjE1s6TipnjFUKGgKW
         /dUxxfi3u8IGj+BuYWpS8WRvcXHl3ie8pPCNM1RYSbSCZKJ9rOg0WMt4R9SdHHZ1F8pt
         /vrcGOqkXR8jk1C47dTz3nbV1+bI2TfLP0uItzntzX8O65DId8+SNABgEpjo4lryJDut
         Rhy0avgzj3ijQLJ4f9KZRSrRkARCRoTsBzWQy9GxIZ0jwcewvULxp7UNm4qC7yiFP+0P
         oNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736433149; x=1737037949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxTZnEfavT7pg2KOoRcc+5ZtkU789ccZDAiLumc3pwI=;
        b=Y2mqjkA3vwQcn92/TbC1W6I9dl+v89t9uGzi1kOgm+x6PYieqqFmk/t9yxDg6lfezA
         eQVOqMnWofx2H2q6QZB4cbg8E0wfhALtWAzKhuJRl1uwNkQDT7RfBIrgdbFtDZvaKGXZ
         +pzRTFtlCgNPw1RS8MBCD0RLjFrqHP9sA0YE5pHibEsgbRT0uHvHka5sPSbzrCx6nhA9
         yCI0za/gV3JLhE6CM5NdlLlallYFySxWULKT1o2WqN5BPY+k4VYtSrSFUlAb8ILwTc0o
         JpVZclwytrwAdWKy3PKg7R9Fq1z4wMX7sh96M1dPbu+eXi3POMMRK4iGQ1KXcfXdvcaA
         BwLg==
X-Gm-Message-State: AOJu0YzYjuEG+0VFRUOCkpCQVxnu6rO4+sAb8hEYNMA1397P/Oc/sp82
	C4xOpbRPs88HsfpUR93Q8o/sN3d0G6j9rB2DksX3v1b3X6Jr8zeA17q+zqhMYZCibmhFcQVMgT7
	rvQ5fdMJ6CF8flSX8nx929TRFAxElIlZnm8GPOR6/Sg2Gntc=
X-Gm-Gg: ASbGnctbo+Eo/F5WHa6nEM9PbE3OhYf40YwOZgP87wnFVIaqE7LiHiN5NxOrNsjYtQM
	si2grb9/H87Q8immPt01aYGkQiy3UMEnpdx3L
X-Google-Smtp-Source: AGHT+IGspp63HSB/P0bXEWB/X32LrBcLlRxiMnKqrFkn+39lRHa6XkCEdXhqPac/6QUIAaOTl+GpkXVvtgbkgIYznd0=
X-Received: by 2002:a05:6a00:4485:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72d21fd8b84mr10078554b3a.19.1736433149197; Thu, 09 Jan 2025
 06:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109142143.26084-1-jhs@mojatatu.com>
In-Reply-To: <20250109142143.26084-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 9 Jan 2025 09:32:18 -0500
X-Gm-Features: AbW1kvYZpO-qOFWNrv5wxeBNRb6r20IiD6ZItf83hybhWRu0J8kXR7akIgaP3Ts
Message-ID: <CAM0EoMnDOeUGtxB+rCvEV6aCXVDQ95r5MbtJiw6QypAZ5+3FAw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 9:21=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> Lion Ackermann was able to create a UAF which can be abused for privilege
> escalation with the following script
>

Sorry, need to resend - forgot to cc security@ and init leaf_q, at
minimal needed for consistency. Sending v2.

cheers,
jamal

