Return-Path: <netdev+bounces-129525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD59844EA
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD61B23BA3
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC31A76D1;
	Tue, 24 Sep 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rAEnircZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781E1A7274
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177750; cv=none; b=eKISX5PJ8OaiNCylM+KFW+L4jh4GFvSYQU3pHWShu5NYDdbWVzyiZUIcDqQuhaskVUJxVpTfMbyTuLbd+Ue5qmJ9ayhzNv7weuEBrQ9+tORtlNTWd4Cw4wEbffyTj7sIvo2nInEiwOc7jYL5KMxWTRXZYCvA+tD72lLYYSUfMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177750; c=relaxed/simple;
	bh=E0wH/eS9n0uK7SX7H4BUI5+7MkRm5nGKIAGAXEzkEwM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MOstSsNlppg/n2AYUT6zV1YEvghdq5SRvF4FJb3L0JM8qQi21Vx87tpN5MOzJM/OU5J7ZCSZgbQDtCequLwjXv+uF1zh24/KYQT3HUo5DKR/Zo5GmlnQugOvQjMV33UbwEODLRvqUAcZxM+cr4H8S5V1r61iH7MgReLNGfGF+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rAEnircZ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6c3f1939d12so41461717b3.2
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1727177747; x=1727782547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E0wH/eS9n0uK7SX7H4BUI5+7MkRm5nGKIAGAXEzkEwM=;
        b=rAEnircZGCoOzMjrYK/JeZ9wJT8IKrzDQ37ZZVXP333hZ4p+ZWg4gGjd3TYm5gzOrm
         U4kMDTN94pKFqyKHs1lJ3ugxFxOEBmysBHT4V9OE1fRVdgx34vSsM4x8eQyv8huYlY8K
         6MxrAb6d92lRI0xPPCStATvGF7WWfmtCL3ZB1daOjXrtXdV6ArJHTg+GF9xyO94qlRfX
         wEj6zk0WzWMgItgRGs6RksdHdn2GYhjBt84utCW7IYwS6IUKaiWZQ7LSelLMMMZrE0ps
         1s0W06+61ObHvZSO+/ZaNWLCqcNAXm2gfsqzlPNuD8eBWDH1DNl9TajorSiKei7xwfyN
         WpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727177747; x=1727782547;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0wH/eS9n0uK7SX7H4BUI5+7MkRm5nGKIAGAXEzkEwM=;
        b=vxzA0vkrle/lh1NjSeieFaG5GkVg6pRbnDNN2p4BCyDda8QziPUUgaEXbbub9RsXSl
         w+Wk7TQtE6g496Nz1BHrh6+bK5JsSpN9GG69a4xbnvWWIYalYbLrYcESso88ri5dCEne
         5B3H3niFLj2tmxhib9vWiPWAQzRXl/1EjOQnvPFSELMVeJlIwZyAsgngpXVWhBmKPQJK
         3Eujcr+5TAPqWBOcUTTRugWE24+FdDzgHdcSMaUrvk27bAZTaNg5N9l4OcqI/Qbw+8Gy
         ++B4IB3Js6Hh7vDHza37OLW3SmeccJHwAegIhWHah4fTv0VKPPzgiGZGdTrU9omlQ02U
         Nmeg==
X-Forwarded-Encrypted: i=1; AJvYcCVSQqWuJlE3lP5bJddRfhZ0FBJb5EHQfg2wTKYmJgAWgqBg+R+ZPFZGVSbbhhnWnXhnR/UA14E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2KVXGx2+fUXj6bFwqS8hlQrIZ/GJGzasYbt6zRVY4RX/R/Ty
	ho6nhWFNGqabBcqnJGc38153dpPnJNq4CvRS3tiN/FOmK7rSYYci20AD6lFm48chtuGkS5BQBZt
	dbDulWaULb+HyWJ5SPqxo61XW00QSfqPHXTH8VuVh7TrwCBC4Aw==
X-Google-Smtp-Source: AGHT+IEbRrrHo17Ut7+bIHnJz6WHSAtgFyUW2lALhrvGGILKXpXzppJXFUaxvpUmgTNyoi8U+icNtzAs8GEeKCe7H28=
X-Received: by 2002:a05:690c:95:b0:6dd:d5b7:f36a with SMTP id
 00721157ae682-6dff29fc883mr96858737b3.36.1727177747396; Tue, 24 Sep 2024
 04:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Sep 2024 07:35:35 -0400
Message-ID: <CAM0EoMnm0yS9YCMgYhmP4700MRCYJektH5s0LypuMj2B+UbcGQ@mail.gmail.com>
Subject: 0x18: All videos are now available
To: people <people@netdevconf.info>
Cc: Christie Geldart <christie@ambedia.com>, Kimberley Jeffries <kimberleyjeffries@gmail.com>, 
	program-committee@netdevconf.info, 
	Lael Santos <lael.santos@expertisesolutions.com.br>, lwn@lwn.net, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks to Lael's extra hard work we now have all the videos for the
0x18 conference ready for your viewing pleasure!
This concludes the collection of all the materials for 0x18.

If you are just interested in the videos, go to:
https://www.youtube.com/@netdevconf/playlists
Else, just go to the sessions page and pick what you want - advantage
being you get to see slides/papers as well:
https://netdevconf.info/0x18/pages/sessions.html

Enjoy!

cheers,
jamal

