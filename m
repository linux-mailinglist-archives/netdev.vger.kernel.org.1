Return-Path: <netdev+bounces-77451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5346871CEA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A101F24686
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA85676A;
	Tue,  5 Mar 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLR22iE/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8C55E77
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636778; cv=none; b=alTm9PuLJ9vaImnIgpwWhsK5w0eGzDCfKvg+Qt5aMqYnscQcZCdE+AU4B91kM9HlFd4nUn/y+LcQD2UkkztdlC9Cfj/ddf7e1XSxvn/m1Lq3LXqfQ9P4QkyOnffUmaBrNJDbz9r789BWqR+lmQgyOO4s7Jm3x7/iUcRF8rIzARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636778; c=relaxed/simple;
	bh=7xnpzjxM6/NEHgW/NOarVY0dEBnE2FCoE1IA+PqvuOc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=VlAaQH+9E8vCAb8+IDBtv7zSdg3O+x0G33BXmkdLLJYUxPn7Xk3NdEV0MSxOEMqAYNAKER8UanxONlfXqYd5j86CdtuwUQa2fuUlwlqE8uoOWnqVxughBNe321FL97r9zYLLYcHNEok80++aMyziVT6LzvfIl1vOS6gipTqiQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLR22iE/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e84e87e6so9863775e9.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709636775; x=1710241575; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap1HyArekBVlNslZqNEJOE7DV8vkxvdLBAH4q3yRJS8=;
        b=gLR22iE/q7mxs+SI5keqQBszPe3RtEZNIYuu5QnAr+XPjdAtS2mi8IdH9Ss4QIH+Lg
         x9Uep7Vn1P+7DfZrMNM6kkn7n1eFamWQGU8u91FdjTDz2FYT6vcD0AhvIHSnoEs618SZ
         7gPy0qODtioQQLMg7SiWhnuss9G01/FasQZ2S+tiM//aEjmHYNN+pWWOEWVi0dcpPH3Z
         jfFBpFoOAFEyZYwwWP2nR/Mzs81+VTlSUOkG+wPr+NnIWBRsFNz81gIpTtGrpUxWSvMY
         LZA1Vm21TOC4AnPk3Ch2JYgDpvKXz8iX8sXSghm2gfNex8JxsHr1kZFe1GoBN/M4W80r
         urvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636775; x=1710241575;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap1HyArekBVlNslZqNEJOE7DV8vkxvdLBAH4q3yRJS8=;
        b=IDb618qfF1Vflqei2O/coQcTv6RyJ0P8lEftlXCocLsRvTgDUpiRUQlJJol7bsvPpN
         HSMfHJKM4MMlQgWpRkBg3tvgy9an71q6gZ5OD8SqG6Y5sSI5nyuSb8tbD0ek9p4x98Y+
         iyp2X1ZmZusGnUay/X0lYgl4aCNnyiqwnuJHaClRvjKhXQfqwgku/sQqqKHLhKMNkPd8
         WdQgKclQtgRW48A/OMB73YvyXJSsAIM84mnPEsSjFHW9EpanZydpKMZZ5ifCEowZFERj
         mx7FTKjz8u0KRpu68UNhSAy8gDknhkaf1AP601Ty+ywfUwyIXIBX0HVfEC7sEmOVldFN
         b2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWElD2BMK2BfOBhmE815tVtxXtp4RgIaJZqkcP9ptQkPsw1jCXeIp/RaacHbJ5sbOfmeQqUejw5Cz78wOHxMQAUuhAhoQ3S
X-Gm-Message-State: AOJu0YzvbSAoGd+zzA9HYOWRy0kQLMMZEh8svTIgz02nv8IYJEObO2lY
	Hh2o914RJ/qbI1tCZ4DUW9tKxJd9ymV7o1oRx4owGo7/fTpll9qI
X-Google-Smtp-Source: AGHT+IF4sJkea/Bavg+EEdtgdIYtJ8+4ZkdTTmMIZNA0fwsKYsVSjhofAnLXP52cKjanlP4AnccutA==
X-Received: by 2002:a05:600c:4508:b0:412:b6c4:ac21 with SMTP id t8-20020a05600c450800b00412b6c4ac21mr10511867wmo.41.1709636774837;
        Tue, 05 Mar 2024 03:06:14 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:554f:5337:ffae:a8cb])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b0041294d015fbsm17535931wms.40.2024.03.05.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:06:14 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next v2 4/4] tools: ynl: add --dbg-small-recv for
 easier kernel testing
In-Reply-To: <20240305053310.815877-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 4 Mar 2024 21:33:10 -0800")
Date: Tue, 05 Mar 2024 11:05:38 +0000
Message-ID: <m2a5ndhrb1.fsf@gmail.com>
References: <20240305053310.815877-1-kuba@kernel.org>
	<20240305053310.815877-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Most "production" netlink clients use large buffers to
> make dump efficient, which means that handling of dump
> continuation in the kernel is not very well tested.
>
> Add an option for debugging / testing handling of dumps.
> It enables printing of extra netlink-level debug and
> lowers the recv() buffer size in one go. When used
> without any argument (--dbg-small-recv) it picks
> a very small default (4000), explicit size can be set,
> too (--dbg-small-recv 5000).
>
> Example:
>
> $ ./cli.py [...] --dbg-small-recv
> Recv: read 3712 bytes, 29 messages
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>  [...]
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
> Recv: read 3968 bytes, 31 messages
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>  [...]
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
> Recv: read 532 bytes, 5 messages
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>  [...]
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
>
> (the [...] are edits to shorten the commit message).
>
> Note that the first message of the dump is sized conservatively
> by the kernel.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

