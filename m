Return-Path: <netdev+bounces-216567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8EAB34911
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A738C7A77BE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3C22877FA;
	Mon, 25 Aug 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0r2xmBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48062221F32;
	Mon, 25 Aug 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143659; cv=none; b=nenCQgq5g9+VPfJgR1y1IfVvPiGumSuaLJ4K1YhCjUS18yS1F1IZcIqdJeKufMqWQU+NVmJlj/OE1d+cxknNNoxDsZJ3vNpg5gJWXT9MdWQzEtIbA/FEJ9PmZVR/r3/+u+3VueRKoiZ7OpbwaHJ6TDpf9Els4s/Y2Cf5vxsLXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143659; c=relaxed/simple;
	bh=EePKVazDHk0zLLlZcjQ7KTrD/d9vwPmLdJBvvtGO6O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6dflc1/GNWKjuxkjCTbK9DqEaiPziLl+hbebR55vQaepCe4mFihxfFNoapdI6HvDd81PyL8GR/jFW35WVsSgMrS9JPuYEPMfY1XFTHgr4rNyn8KjlpheWJYbkVWH6CBMwhYqer9UZPidI3ZWnWA1ZHR9CybsB9o+kZuHTa2rMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0r2xmBU; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53fa87d437bso666175e0c.3;
        Mon, 25 Aug 2025 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756143657; x=1756748457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9O+V4Dq1sbmSy7X9m4img8VETFnwGACT+BLxqajMHug=;
        b=l0r2xmBUyeW+suzxoidD54BVbgUp8LTLz54ahfYqWucNgtK3bA+y0v8XlWFxcnMdQC
         cZ0lRHXRUxqpsapxB8n04Rsc761MsPn0QXcGuH8YxvZTBjbqvv1rgEq/VTT0L3Wualwh
         4jxcClvroBob3rsK1YXuFKueJmUago174gbbitq1FDhNZaBFc5VOZFxDmrJholGa8Ao5
         L+zlmR09S0YGSu1t+lL8ZsyOMPhlxV3qkY1HEwDp1dORZG35LmaJGWElj33XqV/XI8/m
         z/fkE34N/POxQWVAy1ypgHVvhnBMm6Jr+I8/ywxOQNe4CGGCRvyQb7JoYoqhmhmWOQw0
         rjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143657; x=1756748457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O+V4Dq1sbmSy7X9m4img8VETFnwGACT+BLxqajMHug=;
        b=QUGJDb5URegq/Cp810XPeTeVnEm15uK/VQk/nmmD/y+ZOqzkDsG9zP3WFdZ+F06jjm
         Xx+h5gTQRUsyE7GZBWgtiQy8ErQHI174+lnxUwpWX1k7nSzGAsqT2zZDC+IR8aIqodwq
         nThJrHiUbJ+/JToegmRkmji/qfuVbm9SJ3oVYIsFyWpqByFL7vsW9z5RrK3lq+saQVZG
         0TpcjJ+1q/HkMfjgzxoak0mS0TYJrnrR20z8q38Wlx/EsAZuQB3zpX0CXAQAGqPKc9E8
         waOEfbYMpALzHUDLM9KV299d1BKzs3AxX5Nbl1Mf5a+7fjA22QY6ZDkbra8lEwFmS1aY
         TqGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj2MDjAqeTQ3JGHD2D7JuSqmrzLDwGLdrGp4llsc6TIBuZiWQEB3nvEBmherEMSr65hheedZnwFS6hk0Q=@vger.kernel.org, AJvYcCWoE7hAjzxZBE/3gIg6bJ5EZdHGwuvOF2iZ8Y9gFfvZv8l5E6DcwlHLTt3nAhHfYeJPEF+8oy96@vger.kernel.org
X-Gm-Message-State: AOJu0YzHliQ9NumyICtbHXN4YHn7Kv8Za3dlJBOu+uE0omGfNHx380zM
	XSHfdfQ8HzVPyPBj/cryxHLqacix++IBYDlHfKwxvUJx99+L8qvG/ThLqGZ+7y7aHRdyqkxVuFZ
	M07vKh/PVT/vP+/HtrNTdkUGa7mabsZY=
X-Gm-Gg: ASbGncvfbbNPxI5SQ5pqmhB4/VQEwTNlq3QCyyqennRWNtVniBOgZE/Q0wmXN5FXSdW
	etoZ238r/Hb4r8jejrAeQMkEsj15Ck2tOG9xtNPX3+8uKk8t/w0hVABo2B3NnDgSCh39SpA4tgW
	DVgEga7xISDkfyyWOk7ZQk5MOyS86gbaZPfG4VYzNZpxDgI0y9cxWsR1noZfIpSwKT+Ow/B7bQ0
	YMUdPXETFIrzA7hBn9/Gl4oxoajXMhRTLEjRFWK
X-Google-Smtp-Source: AGHT+IFY2DOWJQ9y7UOJ2CuQdXLiXGzwE0UkGTy6pv96Se7XdZdVeG2Gmoc+QD+IbAackPBdqjgWRCdwPWE/CUfv/5o=
X-Received: by 2002:a05:6122:1a85:b0:53f:8fcb:b630 with SMTP id
 71dfb90a1353d-53f8fcbc13bmr1822566e0c.4.1756143656893; Mon, 25 Aug 2025
 10:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825012821.492355-1-alex.t.tran@gmail.com>
 <c6c354ec-e4fe-4b80-b2e5-9f6c8350b504@gmail.com> <6214363b-0242-481d-9b93-2db9e1ba5913@lunn.ch>
In-Reply-To: <6214363b-0242-481d-9b93-2db9e1ba5913@lunn.ch>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Mon, 25 Aug 2025 10:40:45 -0700
X-Gm-Features: Ac12FXwjzcnhrb3wEVYVL5CehQGWbmO1jqgeZah08W4sZZ669qT88QOCnL5heag
Message-ID: <CA+hkOd72gg-8VVfdpNpATbunJt-Oc7Dujor9crQP7sFiDj_L8w@mail.gmail.com>
Subject: Re: [PATCH net v1] Fixes: xircom auto-negoation timer
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > You state this is a fix. Which problem does it fix?
The change was originally suggested under a FIXME comment but it seems
like more of a cleanup.

> > Do you have this hardware for testing your patches?
I do not have the physical hardware. The change was made based on code
analysis and successful kselftests and kernel compilation on all yes
config.

> > You might consider migrating this driver to use phylib.
> > Provided this contributes to reducing complexity.
>
> There is plenty to reduce. There is a full bit-banging MDIO
> implementation which could be replaced with the core implementation.
>
> The harder part for converting to phylib will be the ML6692 and
> DP83840A. There are no Linux driver for these, but given the age,
> there is a good chance genphy will work.

Migrating the driver to use phylib sounds like a good idea. I can
rework this patch and send in a v2 with the changes if you all are
fine with moving forward with this.



-- 
Alex Tran

