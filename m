Return-Path: <netdev+bounces-124733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE4496A9C3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A3D1F2404E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5BB1EBFEF;
	Tue,  3 Sep 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSmRQjo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3661EBFE1;
	Tue,  3 Sep 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725397748; cv=none; b=c2d/5Pm9hp1PKgDQb7TDo1XM2HxDakOBDNkkfUYjTiI63VoRIN+/AY5XoFK8xiyrWYNa9xmD7hWBOt3Pb3N+DK3piXHt8tUYCWFPxedNDGy7GZAUSdfNFT+DS/7+qDTZmpXEBf+HT9R+8Yl4Bq9oyghoPy2IfxzC/JL7uEUv7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725397748; c=relaxed/simple;
	bh=C9rqR5d0ngajWirJwHMBnN8WmVFnDVKK0a1KRgD6wyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czavwKvLR1Bc7kyAEOeY9scAefwfUszijBLmNh5w2hLVpIuZARIiFtgWWhboe06KLkpkHQ33ySjs5yYqZ4OI4hWRX4/2p3NChwYy0kisBRGQvh6GL2lvEbphSjFViykb7V/mqFy4byIhM5HoF18g2rlLUz95YXO57gboHzqD3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSmRQjo6; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277e6be2ef6so1414254fac.0;
        Tue, 03 Sep 2024 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725397745; x=1726002545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9rqR5d0ngajWirJwHMBnN8WmVFnDVKK0a1KRgD6wyU=;
        b=iSmRQjo63r9L/FzE13DY12MXc49VWrDDjh3SHb7dB8WFn4REEn6FqqnpIWyDlNQtBm
         CUAWewQcf8bzcuugLxOgkIJnCd9MOC9MsOrrwjx/aFme9RK60WOoh15I1BYaVOxAJJ6G
         MRxf4m3n00pocVFaBoSVbWKpFRbQhnF23HUPrA4Wj7Lyaqs6HPSfHglOyKl3qMHTUwo1
         GA9yyRu0aD2YZ2yrRfnlF+EC8XkiIVJd7XdyjOnrvFZ8lyDWz1zaCRMuPJuQdnqo9bPi
         sH71JIO89tjbfChpmLa90ZLO/bkU3g+BLPqTkvitKpqyK6QqohoJEI3q45pTUVUWF2V+
         xJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725397745; x=1726002545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9rqR5d0ngajWirJwHMBnN8WmVFnDVKK0a1KRgD6wyU=;
        b=WmFT/nvF7g6oe48d3w41+464M+1KGe/YLyotk/FiTfaO17cM38HMxnDw6Xwbz1oFnz
         KN9yd604i4Jt1tKMQFQZCUq6NJj94BktFFYagk1oaQ2AMutjgfFj2DSI+s4u2Ufl3u9A
         V1V/tVeX2G928L6qSkHONNGa4zYid60J1gFvIMw9dKcv+yuAD/onp3ta9qehhMhjJ/46
         SOnEI4PbWTPP/+8FpLHFlm+/6DTiXH8HeXrkyGtLHzwl4JluoqOY+tyMPKSQX4296dup
         a9pGbEYO95o9bs2OPsW06dvq+PI7hNr35MJP4Ftc5l7KP9yArhKyyLZB48XdiQFg2z4i
         t7CA==
X-Forwarded-Encrypted: i=1; AJvYcCU2enpUt+6l/aLsjyffbFryJuu4ONZXPCTFkBREQb31bwGiuDMfwgkhjaUysxSnzfZfDIrRH6VtIT5PDyo=@vger.kernel.org, AJvYcCX56Ps75CrZ0623N1fOJWqwx2+xPhJ8srMNFy16HRc2Dz4JJDAoPQzVUlnxzyApYFLT+WZrti8k@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYkUpzfik/IVKFN7o8Q7b2TvzdC5/q6hmuiWC2sXOey12P6M3
	q6LQ4+DOZ2XAoW5v2i4q78xkbl7Y1M2WDkOzdc6Tb+k3i0pxDIMWaTP7UTI8eympgfXLB1ha1ff
	DW54WhnsZt2V8VK9fGHOpAnog9qiBi6QD
X-Google-Smtp-Source: AGHT+IF1kaMRbpDQdao8rhQHs3bGzprFM9ki5kv2cEFNVsd6aGSJq2B7h8diX+uWOv+t6ygigdi30WQLwlMowZ1CUM8=
X-Received: by 2002:a05:6870:330c:b0:277:e6f6:b383 with SMTP id
 586e51a60fabf-2780032b29emr7789768fac.24.1725397745554; Tue, 03 Sep 2024
 14:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
 <m2mskq2xke.fsf@gmail.com> <20240903130121.5c010161@kernel.org>
In-Reply-To: <20240903130121.5c010161@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 3 Sep 2024 22:08:54 +0100
Message-ID: <CAD4GDZySRpq97nDG=UQq+C4jBdS-+Km4NjGNob7jrbtBW+SmOg@mail.gmail.com>
Subject: Re: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, 
	jacob.e.keller@intel.com, liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 21:01, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 02 Sep 2024 10:51:13 +0100 Donald Hunter wrote:
> > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
>
> Any preference on passing self.rsp_by_value, vs .decode() accessing
> ynl.rsp_by_value on its own?

.decode() accessing ynl.rsp_by_value would be cleaner, but I am
working on some notification fixes that might benefit from the map
being passed as a parameter. The netlink-raw families use a msg id
scheme that is neither unified nor directional. It's more like a mix
of both where req and rsp use different values but notifications reuse
the req values. I suspect that to fix that we'd need to introduce a
dict for ntf_by_value and then the parameter would be context
specific. OVS reuses req/rsp values for notifications as well, but it
uses a unified scheme, and that's mostly a problem for ynl-gen-c. We
could choose the cleaner approach just now and revisit it as part of
fixing notifications for netlink-raw?

