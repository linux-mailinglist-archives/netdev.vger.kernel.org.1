Return-Path: <netdev+bounces-223913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFCBB7E6C6
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B577460277
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1453074BA;
	Wed, 17 Sep 2025 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkVQ0xWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949D309DCE
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100079; cv=none; b=VCJ0O1M9xUgQZ4ztVJWd8D/U64OKftM3d5qqd08G3cKRtZ6X6PIqwuUxhOELuc1lYbrAzFYR6ca0+g5owYQ7ZsJUm1FHOhpMg5O48Lo+RChxiyLiGWtoqqkD7APWMGkN0jFcF+jkTI/kEZ+SkqPaMqxoEgVUg4uXu8nXGY1gygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100079; c=relaxed/simple;
	bh=GNJjKrU+tZcKoWA6+3gAN8j4BgMgeBl5GYJeZZy0/ww=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=chkeATGN6cwIZNq+LJ0i1hGbNtdc8Zecn4nxitF2S5SKHix/mNRbFDif7eXh8gTRpNDO5UjNHiKQDXaQKplu+mBNgzg1Szu04VBScFRrZtNejf0VEjRVt2Z+z3Xpxc41azXevigOE4QG/gPFcNKA5UXxvHvckrsy/JxJbNoEYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkVQ0xWR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ec4d6ba12eso1219563f8f.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100076; x=1758704876; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNJjKrU+tZcKoWA6+3gAN8j4BgMgeBl5GYJeZZy0/ww=;
        b=CkVQ0xWRtXTbdzLl5UhvU3yMBYgCFreptQeefc4IORG/tIXw80Z3KP9MtHqlSrYjzD
         gb/Q+9jAVEcUcLH+hr3WjW3tQsGEIFPqv/c0yyEMZOW53E53jYrH04G0Vh7po2nMXmfM
         /13MCEcFOI3RGTK2E9kWlTM2i+KtR32jOFlz0xgeMhxJv/Y7aCEQQ4mhnI7r1lq8bkys
         ogW+wt410jscEBxQcNe2neOhRRbciycdz3cnQPxy0FiCR5/dO3F301wpMEbboJz5dwZZ
         qTOJMpYvJyH3lxMQKOPn6Ua/fQaEZ5zkIwfw+SeU742eBdi/sBQpnXBKHExg7QbpM8DW
         PA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100076; x=1758704876;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNJjKrU+tZcKoWA6+3gAN8j4BgMgeBl5GYJeZZy0/ww=;
        b=wo4hYLOrPnXsnBtpfoaYclFMK9QMOJOlA6SlOjUXQRliivjlCNYSiaSSph3mKxI9f9
         PdOE9AzCvPcr/GfDWnGCDwe3EVcQ7drWXz+FwfRN8PmxwHY+nKu4MMWCNcfOvzfkUG/M
         JazMt6F4r6lJWDWS1mRfIulEbKJ1qNFpI7dnvEZ5qzAgO9iCoc7sMn2YHnrcpCO0mkkC
         tRVyM+JYKbQaroriEs8CGGYumFPtcAdDs5lcVr9SZKUUV7S7acTReqRk1MB/i3/SKspG
         Frfi0Fvf0/HPL3TLs0tSmfDbW7vUDBEQAylzZ7OOWaSaWF4Rgz+Ly+xy01HJXte/WHEI
         kkFA==
X-Forwarded-Encrypted: i=1; AJvYcCUbuH/2uhS3f9lJX3kKnslKWo699n6mdcNXtlw+mDEzoRpVdXCMVlczCWji/9HcZlHI8nWnlvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypj4broVf+q6A1QRi5lz5+knkwx1UiT6QPu9DFyXPUAPKaeVIC
	YxdRG1/AVPY1uo38jPmwxz26FWIAv1wxkDCRZSNnWfzjGP/taNzOUupg
X-Gm-Gg: ASbGncvb+HGvGOi7zKgpT9l04/PaJ0JUo6Kqti3EDt94Tmu+l9me5NhrVx55QvaCBR2
	y2W67a8j447zmIlmhaCEIx97obZm6Bizes/aY9ogizBRbGMAvA7bfHVsYPoD3/+YdIq2Xbuf4Gc
	TsqfDBkk5Wy2NMyJ03tmkM1BNGJ36EPVef7cHsshvZRlkO2Sl4yDMiqdt05aHQwOjuTlxZKU5yT
	RhHd9RYQdSwfWNILKbQvYrcoVZRfHRTyxdF7Ek5+r8I1YS7MSHYPw5LL8uAEecwvH/UMX7hEqHy
	XZQCEgzplQGVlJ5SPZxsLaT+NlpmLIjpROjo1mApqehHhFutIklzyOUkV75nMJ9OQajsaZoVL0H
	i1PWQ+6ZYBCHWU4zcI7T502yT3Q==
X-Google-Smtp-Source: AGHT+IEpkw9iLzcJmWh+VviuB6vVHUEwbl55bF6TD3p8ZhQ8WLvCqMflpdvy0niM06/D64E8a8E9sw==
X-Received: by 2002:a05:6000:2c04:b0:3ea:c893:95a8 with SMTP id ffacd0b85a97d-3ecdf9b8942mr1046098f8f.7.1758100075545;
        Wed, 17 Sep 2025 02:07:55 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm15197419f8f.32.2025.09.17.02.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:07:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] tools: ynl-gen: support uint in multi-attr
In-Reply-To: <20250916170431.1526726-1-kuba@kernel.org>
Date: Wed, 17 Sep 2025 10:05:21 +0100
Message-ID: <m2ms6tsb3i.fsf@gmail.com>
References: <20250916170431.1526726-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The ethtool FEC histogram series run into a build issue with
> type: uint + multi-attr: True. Auto scalars use 64b types,
> we need to convert them explicitly when rendering the types.
>
> No current spec needs this, and the ethtool FEC histogram
> doesn't need this either any more, so not posting as a fix.
>
> Link: https://lore.kernel.org/8f52c5b8-bd8a-44b8-812c-4f30d50f63ff@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

