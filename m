Return-Path: <netdev+bounces-74450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1602C8615BB
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301CAB25DB4
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD493839E8;
	Fri, 23 Feb 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9dJVUwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8A81ADF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701951; cv=none; b=cEpCvEOlih2K6La4BTenJmDMAAlb2vd5cKAqHdAihu4pHHw3D/7jsVUjPAVOLLh3aQJYNQZ5IucDCj0Ept4VSxBYMsXIK2ldVXcIJu5m5Ceipanbab3oqkBDWwMe5ifsnH3XNwKeXRlbR5aBAJHdQHAvojodYnhLUJR+61nPWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701951; c=relaxed/simple;
	bh=mDS/AMv9gPRb04aidENH8qK33l4x8EJs+P9QDHRBcJ8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pWnkskD/XnfwPQyRr85MQRhd4a51jbF9ZiLsjb+O1N9MX0fWazWdXed7+KGlEWb2YZK+GoL3DFJv4UhU8yYzVTQrAEZ4i60bkuwpKuyxRqYMqDHaJA8IQDlfFkGR1pXgxiJDsYvXZvXInl688mGyhxx/rflp8FrhybavxHJ0YIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9dJVUwD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so7662625e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701948; x=1709306748; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDS/AMv9gPRb04aidENH8qK33l4x8EJs+P9QDHRBcJ8=;
        b=Q9dJVUwDuaKyq+sigDVVmzGAYACiCpmuukDxiZhNiY3gV23Ko0JTHYhHEA7HHhQOas
         8zxetY0MoB2sfWjyXZ1EuC1GiI6XWvR9/lu9hBO06KKNzcK5ay4kWoK4pE03jD5f/d+M
         yNxnceMxcvAG5UaS5eTAxCx4QEVC4gGJ82rJ6XFckd86TM40hUVN8LJDXWAiBAkIQyZ2
         5UFN3GYac23Wlg8bsRGQuCUtvSAkyWHyVqxtsddoChCfOrWMRIGpWLkh14j6hUkJ7+9K
         BzgmTRUWefcqVe5+XTKgDFOyGU39rFb5c99Wr4N8mTZYRIVWazei79UjWfFo4OM+fIXG
         0Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701948; x=1709306748;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDS/AMv9gPRb04aidENH8qK33l4x8EJs+P9QDHRBcJ8=;
        b=bik+lXWRTIJj3XlbTsOZZwk8OUhaJMRafnpkVCkcPd6/7qaRX1oRt77u0zOut142s9
         ZBDKYHW5dXa+IEG8kO5/TJY7ZR9uFqb6EJ7V38mavtyZuJHXsAGkNn3aGADw8PxoCkho
         SdovNTarS6Jr3uJEdCFsC72Xw6EPbZOjMnvEUIOGHK+XJtSFp93Jj4EUTKTNFJkxiY2I
         r1OHCHm9IX2hOqSpO6UA1T+evZd4H8Pl7wJctV/PJdRjO1qja2Dhu7/4xQn3AV55s/Ub
         UdBfLfacgBg/c5aKZuh+s6XexXe4OXHxjiWRinst87zLxpHNZqK/nDt/KsB6STW7G6ed
         LKag==
X-Forwarded-Encrypted: i=1; AJvYcCX2/9Qld5o15HtockNL0XU5/TmGFCMO0DSJ5qOYJkjBFP66O3U5VQjcwA5YHMdW+0K5VoDrncIjWodRGszGyOnN04E3Fun7
X-Gm-Message-State: AOJu0Yypkm6AcvJwAuTYyDugI7cFxG5qjSTfyj3OhRtsFMvGj4lDURck
	rJHsVPdv6R3HUe3b+OVRlTRM3dK083hTg1Mc/jHMcKBowHY3QsOz
X-Google-Smtp-Source: AGHT+IGOvwIio6b5+D3kIIJ0AkOtRcObIUl9IWuxWfiGRv1yEOv+ACQKWXl3jLY2HOMEdVwRryOb6A==
X-Received: by 2002:a7b:c849:0:b0:412:8fef:9947 with SMTP id c9-20020a7bc849000000b004128fef9947mr138847wml.41.1708701948358;
        Fri, 23 Feb 2024 07:25:48 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b004128d6ddad3sm2844180wmq.0.2024.02.23.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:47 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 02/14] ipv6: prepare
 inet6_fill_ifla6_attrs() for RCU
In-Reply-To: <20240222105021.1943116-3-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:09 +0000")
Date: Fri, 23 Feb 2024 14:35:48 +0000
Message-ID: <m2sf1jqmd7.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-3-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> We want to no longer hold RTNL while calling inet6_fill_ifla6_attrs()
> in the future. Add needed READ_ONCE()/WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

