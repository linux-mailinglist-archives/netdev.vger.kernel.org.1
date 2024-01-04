Return-Path: <netdev+bounces-61394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727DB82399E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986731C20A22
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B643107B2;
	Thu,  4 Jan 2024 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6AQUhSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BE10796
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-554e902064aso20757a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 16:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704327892; x=1704932692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0V1aPbOQkf9M1l6AJH0DsJtxkNlKsJx5Ui33984NMI=;
        b=C6AQUhSv1ae5uj/gkeM9BL1MGpbm6c+SU1wxaG7yWdezDv2q7F3onbZzC3NiCGVg5/
         jQxPFCqeD7glSSACCIsktfd4i947afDs0k0ABOZFi3cG6eDfsZ5FWrc18nuqdd9TW1XD
         EUVP/ePyM4wFxl584u+fXDDvjBJvFA7RvUSrIamdnK05wWeWeSvuXW9r8an4rYM0V5SU
         33xj4ENrASnyNr13FNsMC4kFM6ioZnW0bVhRzu4Pmz1A9ObwSZMxErRwPmhmrmV6pLUO
         TJXXiY5YWrz5u1RmEBPv0n9ZfS09QyE/h48HEjsqGXRjHLTwKneRwrTzGERRSoEldyaQ
         0vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704327892; x=1704932692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0V1aPbOQkf9M1l6AJH0DsJtxkNlKsJx5Ui33984NMI=;
        b=pcYF5cFQhFasfJtWkcC1rz2j9XqJ7cIrOs/JR5DMVy2V8ahNqVtgz4zt4zMeHrE3Cl
         jWUSV9F6KofrDxPxF9jNif4KUvIsCOUD+oQsw2nnxzlI1qJzXNJ/XS4QwGaPmI8JEFCo
         DXDW6YpPjisn+FS+LKkFSqxEbZsOV1xksdfyoLpBMEnIipD8eOlgsfWONCy2EFD2UNmD
         LbPgM9ynP+WJdR6wCCLtiyvygpWLAlKu4fvsYvPAW7miEVuH4z7OP5M3iRnvzVj+CXwL
         pdV8OP5Wt5A17/fz10VOSUcYqgpvwRCMn+W31FL1UOzCY71r45r96o1SZi+Ov5AfRSiK
         ZyvA==
X-Gm-Message-State: AOJu0Yx/hH82td/pg32aivDAeMrKygxkSmVOMAya9Lxsat0/hFQX5LLt
	5mp8Cf/jtnMyKmKdC/UUPLU=
X-Google-Smtp-Source: AGHT+IGeqU48Yo4pgwVvm369E9nkv/f6R2dwI9CFe4AmoEi1dnVQVuTH0ITU8tBO/HLonYbB6vj0kw==
X-Received: by 2002:a17:906:c09a:b0:a23:4faa:dd66 with SMTP id f26-20020a170906c09a00b00a234faadd66mr9204329ejz.137.1704327891604;
        Wed, 03 Jan 2024 16:24:51 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709061cc300b00a26a9593a68sm12625526ejh.76.2024.01.03.16.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 16:24:51 -0800 (PST)
Date: Thu, 4 Jan 2024 02:24:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Household Cang <canghousehold@aol.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] net: ethernet: cortina: Drop software
 checksum and TSO
Message-ID: <20240104002449.yx43fvp2ylbxs3wz@skbuf>
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>

Hi Linus,

On Tue, Jan 02, 2024 at 09:34:25PM +0100, Linus Walleij wrote:
> That begs the question why large TCP or UDP packets also have to
> bypass the checksumming (like e.g. ICMP does). If the hardware is
> splitting it into smaller packets per-MTU setting, and checksumming
> them, why is this happening then? I don't know. I know it is needed,
> from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
> to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
> and hang unless the bypass bit is set: the frames are not getting
> through.

This uhttpd traffic is plain TCP, or TCP wrapped in DSA?

