Return-Path: <netdev+bounces-94734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E408C0780
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 01:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132531F21EE8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5738DF2;
	Wed,  8 May 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iryWMkxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB52941F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209443; cv=none; b=tKosVWkXYcbSM2CsP6llQIE9D+9uJHWlQLyjsJWbF1cfx+8rUzhpFtYlN30oNaLDa8wIpIVb/OaU/1XdU3eyB6tNK3phMQIlX29ThWvedKKkumMB9++1NosizClJHwXzhTiWycRzibeQ01/HI6u6iBFbH5c1NtAHFkwyganU9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209443; c=relaxed/simple;
	bh=WxC6ObwssH5ydq0YCne0+j9kjirSuIpSeiJzWMRfJ5A=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oQUjXkEaAheWBIxXFMgfDtLB7mmHc8oqrlit3/M6M1HtLJo6dVT13mPGHO48Ce0/ZA9GsH7d89uDWMyTozDEEGYFcxMbTgm3R2l9IQnr/heBT/bX34p0uGM1cHL1fYF+RkQbC/FiFgp8kybuRFVBzQnjGDUBgx+LVC1sY1wellA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iryWMkxE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b6215bcd03so103224a91.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715209441; x=1715814241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDkJpEEynbnWDfOcm4UiC1rzBAepvc3+xe+0/yT4lZQ=;
        b=iryWMkxEj+8AXV76uUwRnDE04+TJIaa2jw1Lu8JNmUTRQA61SUQKpCMh4qmKYO1lu6
         IsYMzhJBjuxG/CnCBVwtK0SqksKqneAnHNRaqgV6xoE7n08Cxtm47qoJKgzl7ETmkUDH
         xU5vKyyCLaa0d91vImnpq0jZAvo/acp++xTeHmqSVDt+NoJR5ZlBDbFDOb7nn5ehPD4r
         aUumKe8q2/5rM5cucfAW66z0Jp6Cgff/38bJdpw4iIkMrGhLRgajw3CX4Y+eBfqrgEPN
         MwHW1nkiAk04bFrYrkwMTGZ+RyGZC8QQ+01suwFRVaYkr7/UxYFIPsaa2VuC+lmvP1Bc
         e1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715209441; x=1715814241;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rDkJpEEynbnWDfOcm4UiC1rzBAepvc3+xe+0/yT4lZQ=;
        b=NcIuAJ/kpMm/1NOVfgTdGFvBb6uDMMCZ7rEPOy5wd57skugz0mT+elqgUctVAG/hX6
         QtHKgZyta0I4R+H1uIN/ecOf4oUdqkf/AOlCgFhNF4CjQ3eq2m2592CUkE+J/e8Nukre
         9kLRM/35IYSlAA6GUqA7PSinBD64IxIFHUod6MIbfU7uj7dwLh3IfMQIdHgCtPKJDtLm
         Lo3DkpioR1ZCQwGg40tqP5tT8fPouWDENXdy9R3EOJGpDGIXr2phtUy1JzGQPr3CtPSu
         vIKM66PJGAJpDVWeArpboXkbHRW1d6ozrsBusL9Gnk2U2N4woiVDo8DMwsRGdtyI6FFp
         dnFA==
X-Forwarded-Encrypted: i=1; AJvYcCUcojkT7MjIAp9XY1A/JBGFFpRd1ca+oA0MurKCaKzk22aFaSd0/AyF/POvIsiSa9TYcAQwaED9Qleh7BwFTlDcNLZzBReC
X-Gm-Message-State: AOJu0Yypl4+a/riPZIjTKobWTUoFblsVWUoEQvVrF8ZLyAjahMqIVUMj
	48BKzZH20shU3cLsen3APhAqfeQKn/LIVTS5/qxdNpXH1ukAka56
X-Google-Smtp-Source: AGHT+IF+B/5R2Q6vtwTu6sju5aNquIo92cL26Xv5Ak6+7Z0Gdnoy+7DVokdGIXDG1u0RpUdwUWOtzA==
X-Received: by 2002:a62:f901:0:b0:6f0:6d93:2089 with SMTP id d2e1a72fcca58-6f49c1f5dedmr4154935b3a.1.1715209440840;
        Wed, 08 May 2024 16:04:00 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a813b7sm104818b3a.51.2024.05.08.16.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 16:04:00 -0700 (PDT)
Date: Thu, 09 May 2024 08:03:55 +0900 (JST)
Message-Id: <20240509.080355.803506915589956064.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
Subject: Re: [PATCH net-next v5 3/6] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <bde062c3-a487-4c57-b864-dc7835573553@gmx.net>
References: <bde062c3-a487-4c57-b864-dc7835573553@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Thanks for reviewing!

On Wed, 8 May 2024 19:46:05 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

>> +#define TN40_SHORT_PACKET_SIZE 60
>> +#define TN40_FIRMWARE_NAME "tn40xx-14.fw"
> 
> why is here a new firmware name defined?
> The TN4010 uses the identical firmware as the tehuti ethernet
> driver. I
> suggest therefore to define instead, in order to avoid storing the
> same
> firmware twice:
> 
> #define TN40_FIRMWARE_NAME "tehuti/bdx.bin"

Ah, I overlooked the firmware for TN30xx. But TN40xx and TN30xx use
the identical firmware? On my environment, seems that they are
different.

$ cmp tn40xx-14.fw tehuti/bdx.bin
tn40xx-14.fw tehuti/bdx.bin differ: byte 21, line 1

