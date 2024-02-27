Return-Path: <netdev+bounces-75320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808E8694ED
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B34B1F2220D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338913EFFB;
	Tue, 27 Feb 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDEHJFGC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55913B2AC
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042252; cv=none; b=m/vnI+vFR2hbtheyHvt8M6Y2H5UnSVSAFKbBzJSnHw3zcd25cJRfeLnyerWFNw9uoUC9/6UaT7dRPVG+PkXhIVCCrdW5Q6ilccWQ9SA57u54+dnNrlMMAJT8lyHXxnlA4RdNrEAteClXZY4rJG3L05nzUFUU2YzJekKTDPxhxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042252; c=relaxed/simple;
	bh=xDv9OFmYWxuIjy59LyRTkYBp0kmFLWggCj3hGkof7g0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=oCPRK93H94lMIpE24tn6cVmDnkQQg/wqgq/U3EhA+93Y1cwi3R4tk0r3h5SVFg/79F1MWloyQMusrLZhG4vokdAeUETKCuOjSP/471kO5qKSUDbrkYY09/OGGw3UTv3ZBtVo9iCER6znivRHONa/ALHdUdNuex2pixgtU/HZgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDEHJFGC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412acb93e2aso5387615e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709042249; x=1709647049; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kLDjUFBCWWGWvIF+PWLMrZUrdwseCrQ9tK6fyznzzo=;
        b=YDEHJFGC4gnNfdj6CS9WonmkzgUN7gz8fRXFg15TlQvHXEE1C4g8oyo6YIJn5kn6DK
         5eJpPfIRF9urcVhTMszfGTyn77wGj58nbDwUMVAe08P427MXBPtp4CtpehrOvaYRek8J
         5PcK7C7nqIxOZRtrGvDn++q9iUJkvIa7gLej2b/Gb6f40FDcV1M1eI4VLvEt7XSOy8qa
         n4G5H3QmmBDkOArlo4wnB5EJirTw33cgcQ4YjkwW6FvhK/V9pKLdDyHUaIxCVA3MMw18
         pWC0N3DsWBXrD1r++uHP4fQwZUKNxXdMlCuiF8h77g8rPJkejjqHNJ61hJmg6jbRQSf1
         YWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709042249; x=1709647049;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kLDjUFBCWWGWvIF+PWLMrZUrdwseCrQ9tK6fyznzzo=;
        b=pFJN0ml5ueIkk34pJ7+7U19bz827Zc0nerAcaPpVUirw7lCHgEvO3VCaAPhqFliuU5
         5yQ1mGqIxlFS4592rYPowxO3K8+G6zUfW8ieGXX88B0ltp9iMGWxNges0DooKtK801A/
         sT7VGtUnRPo1F1BFHJdATumkInbFNedWpx9FS/f86bCrtyCBBFlUMAxdYe/MjkOPkIrp
         oVORIV9/wYkig1ohj2J4IiBtPu9wM6hY7j/o3nzkqk/RA0F5Z+OQxAgpL0zolUBrxHI/
         7Kh/CodFJvIOj+I7/oTeCf/t5QnlhMgLCORDQrh75M6fOxO5zHvdahYW5WaTpRqU2wVa
         LswA==
X-Forwarded-Encrypted: i=1; AJvYcCX+5Sq1IJT0aljsN9d13EEZ4tn/MT1f6zTDJFOwIWitlooSjFGu8Oas+hjYKGji0Gbo+8slyeK67s2tczVK6++mMncR9jz8
X-Gm-Message-State: AOJu0Yz3fwuWln8+0VKs2oZTNnrqIBO7sLf13j2ezpfDT0PWLi1TkCrR
	CrNDwtddw8DRWh1oGBgOcfSxI9PrB0OH0ZBVOeTj2X4T1JNHHmf+
X-Google-Smtp-Source: AGHT+IGZ78SOAKo0eBpvA2jX0SWi2ymd5zcL3NWBMkUFEx30DJ5iJbnyfSetlfnL+3b2Xh7AtJzpdg==
X-Received: by 2002:a05:600c:3145:b0:412:7941:e3df with SMTP id h5-20020a05600c314500b004127941e3dfmr7611384wmo.4.1709042248983;
        Tue, 27 Feb 2024 05:57:28 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:58f7:fdc0:53dd:c2b2])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b00412706c3ddasm14818696wmj.18.2024.02.27.05.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:57:28 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  willemb@google.com
Subject: Re: [PATCH net] tools: ynl: fix handling of multiple mcast groups
In-Reply-To: <20240226214019.1255242-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 26 Feb 2024 13:40:18 -0800")
Date: Tue, 27 Feb 2024 13:35:50 +0000
Message-ID: <m2le76m3m1.fsf@gmail.com>
References: <20240226214019.1255242-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We never increment the group number iterator, so all groups
> get recorded into index 0 of the mcast_groups[] array.
>
> As a result YNL can only handle using the last group.
> For example using the "netdev" sample on kernel with
> page pool commands results in:
>
>   $ ./samples/netdev
>   YNL: Multicast group 'mgmt' not found
>
> Most families have only one multicast group, so this hasn't
> been noticed. Plus perhaps developers usually test the last
> group which would have worked.
>
> Fixes: 86878f14d71a ("tools: ynl: user space helpers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

