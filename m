Return-Path: <netdev+bounces-235565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60624C3271E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2812342DCD
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C127815D;
	Tue,  4 Nov 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpWsS5Kh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D2329E4D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278701; cv=none; b=hL2c5gHZJFJibe5/Vh/TVaK/NuXoxU7Ryqrk6Ws/YzkMqXPAE6iMbtMlul0w2iCbn3YvMV/8yfLuqaaJQPHOE3G8E4umeOFatST5HBdVdnZTsguO1Cf6tzYmAhwj8D4GUMnUuDD16G9A8Jyt4UUm1QmW/29iidSal9+XXay251Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278701; c=relaxed/simple;
	bh=VzlmOF09BE64iQ7u/gRDVDEoEiDdEvtMCD+PYiMIg08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAaIjyEPl/YvWJ11U6BHa1SuMKgdvzEfxFAijLrQSN3QTUS5FAHqTpDo8JjQQwPY4rk1E4q2OBkwsMZ8/Thks6nxMbvCALg7xaIxNyzWP1H0zk9+scp/5mdKbI1Goxwtv0U8ERD8e37W6DJBWNdhhzKWkXFjjHhQKE9zc9mht9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpWsS5Kh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88025eb208bso50706486d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278699; x=1762883499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZJr69Phci5PyJkjkQwB8R4isHzUb1qqOylu4CgEdLo=;
        b=VpWsS5KhVlTxbjxeuTbwfhMHzay9at+Sf2mLqdM/dQaF5l9Y0ni9S0vYIhYsS60aFE
         Zt0yKw3gWFlNGU7STmsljsg4VxUlv/232O3K3p6zpjVXp0sisahrzJbJ5Q1a0AlEJWDi
         QOqnlNx88oE95iHmJTx16qFEj+dip7fY/sKC4PR1gi5/TD+pVIPmG2hmfeUFNbh5Uu4A
         PPOW/y1uLo6I0HBmADnogTfU4JYHLfVFTpD235t5PqKTECJYTOC+ra7rEIaYqrcRRPJN
         a1ZOggQdsZG0ylsrVxtTcQU/x5/4X+cOHx//oBTTeGuARnCfl+UpeblMfmttLxR1HEgF
         0ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278699; x=1762883499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZJr69Phci5PyJkjkQwB8R4isHzUb1qqOylu4CgEdLo=;
        b=s1tvVQjy86JbC4oz/YRPVB7sLLPJ8LtuSsB/RHk/RDKUHBcg+V1du1Aa7d0HRSrb37
         qeT/R6hszwI3+nnyOCigf7lzUbV8h+DHAwqQbugcCCiar41neRq1J1saiYFmjfNJYriL
         j9T9qRYspel+m2c5pXpPx689C/KVGByY4NxjRFHk19iGqW5EhhGaLs2GXL9yOJP3jqXH
         hJGdzULTupfLGLw0BGpafi+5rHVKMIm+qVOuwY/wnQk3Ad2llv3UjMpVwDSWvLvDpUPW
         F6+EMkNsKdaYBq2PvCsY81sVhTjNzm97F/auWX5PbgfVtmLYmffJj+6qp+lbocbRWJji
         m/OA==
X-Gm-Message-State: AOJu0YxSU5SxyzRMb6doPTez/z7pgNay4kAiZrIeWvlg2Qqu45AsrVvN
	3ncDqJofQa6I23xjvPuzUWm7K3r2veZUzQmL3qUUkOvdwqVc2f0MmpnkcgBoOjxg3FGROJSPWHX
	n2jlG/e2Z68Zivt7HudLK9BjkVhxRY40YkVzWAVIG
X-Gm-Gg: ASbGncuPN6nDozlIP0MEEKiz0TjnasfJLYenNvwf6wnel6PtEn7Qmbm3GCzGNLXszWd
	Ba/L/0fbnP3yu+q0i3zIZS6aggTAz8MGXUuTG/FlDysq/9CzeFQMZWgUqRRf5TkJB74o2/9tY0J
	1M8D0Ofbkfe74w5j4HqfWHGc72dss0YOOZEK8I3EQ+qHz3Mj1HHPHWkrgiI2iHBqjnjtzSZoUBs
	/iGu+sYn2x6SVP3weCWjyF/YXkHWmvD+pq+PO9QwHTxx/C8rZCKK12iz4p0bTqSSmVLGEK1qJIN
	8KIcJGML4Q73m7N406tKw/4n9nM=
X-Google-Smtp-Source: AGHT+IGPt188Ryb1cGz42qniu7G/vRksUxBDotU4Hds5QSKeWlIiIaGvMVDTXvwxKSJLjEcL8+q+8krzNyeeIgtIdNs=
X-Received: by 2002:a05:6214:d88:b0:87c:2559:fa28 with SMTP id
 6a1803df08f44-88071170ac0mr7357766d6.43.1762278698168; Tue, 04 Nov 2025
 09:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104144824.19648-1-equinox@diac24.net> <20251104144824.19648-3-equinox@diac24.net>
In-Reply-To: <20251104144824.19648-3-equinox@diac24.net>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Tue, 4 Nov 2025 12:51:26 -0500
X-Gm-Features: AWmQ_bnuYtFZ6YwZAtPz11w3oMT97JSDts7xHOj2mTR5KLG757HdLok81qn7cSQ
Message-ID: <CAKD1Yr2maTnjEjYYFn9MNG-R+Mx7jw8wcxfowbAk+h=LCZE1pA@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v2 2/4] net/ipv6: create ipv6_fl_get_saddr
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:49=E2=80=AFAM David Lamparter <equinox@diac24.net>=
 wrote:
> This adds passing the relevant flow information as well as selected
> nexthop into the source address selection code, to allow the RFC6724
> rule 5.5 code to look at its details.
>
> [...]
>  struct ipv6_saddr_dst {
> -       const struct in6_addr *addr;
> +       const struct flowi6 *fl6;

Do you need an entire flowi6? In this patch I see that you only use
saddr and daddr. But flowi6 has lots of information in it that
potentially duplicates other inputs to this function - for example,
the ifindex could also be in flowi6->oif. Should you pass in a
different object than flowi6? Or should, for example, flowi6->oif be
updated with dst->ifindex?

Similarly, do you need a sk? I don't think you use it in this patch.
Is it used in future patches?

