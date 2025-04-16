Return-Path: <netdev+bounces-183215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980BDA8B699
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB9D19042DC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80782459EB;
	Wed, 16 Apr 2025 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdRktzv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6C2459E6
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798691; cv=none; b=Hf3O1GjZAGLCYM8fINeAw/u3FduMNkn1VLrJd4SrCs8DQ6+zdB23NN0G6z+KGCcYsMhZ800WPNj4ooUESRZR1WiKolVUsVj1wCcHVxrmSpXXrJJnIV7t/TvsR/B+sZwrcAw8Xu7xNYo7rSFw2X8E/OtcUT+SajbAQEY/JfkVPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798691; c=relaxed/simple;
	bh=pmNHbK768ffBBoCDx/GONBmI8dGSU8eanUlT1Ql9V5A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=R/McKlw54pAWh0Xoj0OPwmSq0GSZx1NoI9EN2cBpO0rWmYp6ek6wscqADeBKAVCKOaS9PWhxAp5f/4ZBGmZ1eQcu7BeDmQB8yebI1VyhfiSOF7Jg7jzjpThxK0bLY1JRgZEImeNHOW52hdCArtHnG0yD3LLFuUW5n8RbIHyU5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdRktzv1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so3924543f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798688; x=1745403488; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmNHbK768ffBBoCDx/GONBmI8dGSU8eanUlT1Ql9V5A=;
        b=CdRktzv1ebQVCOOcug5ST8VO2DlCCebWsaW+lxnkUVyIv9pWLThXQ4CKiDsQcpjItr
         Jh2t3niMHDpDfRE7UP+GQxtHmn3T4igGNbITQZjbYqej5d1fctHoUzaxBJbI/KwF41xI
         BEGTS8zZ+ReHVJaVCSRtDsdzXIKAeknA+gPicRcFrv7PuuQtCe7a6SK4AwOMpbWeX/eN
         im0MUc9g05QJ1zdxE/3CWvH684qk7ywaPGgveQaF4sFoVvqh+sVnKCmL/11t5Mm1+5j8
         gcHyfei72/OR0ScQaiQxdnXZdui2zfuaObp4BK9ixO5aDSNxwOs68dHwYZW0AVzSZcwU
         z0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798688; x=1745403488;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmNHbK768ffBBoCDx/GONBmI8dGSU8eanUlT1Ql9V5A=;
        b=OnjhalLTY//Xiztfk6pCo880oYM+NA70nxtybIEdWLcytNFFISsGrpOG+EY9u0Eq6r
         EmX9gyAQtqhz1wz8C7zYseRzAjXTYOaKhE1k90E69W2BsqPIX0jBbiqg2klay9PfWGdg
         CkQTwHOTemMDZB4PpPEAYV3FTsG85vyHae8W9wBnUKNGF0hD4aHhG38SfYW7/N7QnMSj
         crY3smgS8Fb2IS049/SFluWyupr91cSphQXzgNx+/uLZz206QbjLrO57EyFlb3UIs33K
         NxeuPUjIdxb+bEm8TPjQagZWnWR5w/25UlZFYgrS6kbpGT3sIc+3rBDrMkcxAE1ENtCT
         KdPw==
X-Forwarded-Encrypted: i=1; AJvYcCWLInWZNcieWxNlzdL7s9e1oBFwgWXd65vSZgjeIu/jp2nXZaYE0wu6ooHp9TlqgSPH+KZpvag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqmSX8L3+RnOdHZBBrjCxvZsLrbPw3Me+yoy5NlJnQrvMaDW1
	ILnY4L8Q0QAODIMj0wpZKIOVmqayVJSPan8qk40OCkz1a1M9uXJO
X-Gm-Gg: ASbGnct1cQTR6yuDDZ85odGzeD6/Tx0rpS9LECNdRSrrK6zGZ4D9uXHS5EDqn0QutQb
	0Bxh6b+yqhcvS4kfkdXkpknQqjz+a+1BySHt+F97DdchS0oHVW2918rSDa6q3ac8B7C6KTZSasr
	rCMRE1phuvPEh4x1CmW43b2Wul5V2yk37Pl0Jltql8k1JUXan9vxiLW1tBNaGrKVayFavLHHDUj
	Lj12t6Erl09BA5HfOBHn3REc4bJNMhAFeIlrKdbfo8JCEM8JmvR4IiyMNzJjjAgu/S54SRmGtnR
	I92LW4rFpvR1IXR+Bdn4iDht4ki949wyiHjsZKSgDRXeidn7z4pRCdyoYw==
X-Google-Smtp-Source: AGHT+IF2Ndzn66tPqrpHPNXMV/AhBR3kVUKR39kWPSR8BBgq5odLXTi1nmgFnbvyZvj3ZNWvz2pHKg==
X-Received: by 2002:a5d:64c3:0:b0:39c:1258:2dca with SMTP id ffacd0b85a97d-39ee5ba0704mr990895f8f.59.1744798687996;
        Wed, 16 Apr 2025 03:18:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977513sm16504522f8f.42.2025.04.16.03.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 6/8] netlink: specs: rtnetlink: attribute naming
 corrections
In-Reply-To: <20250414211851.602096-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:49 -0700")
Date: Wed, 16 Apr 2025 11:09:50 +0100
Message-ID: <m2lds0l8nl.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Some attribute names diverge in very minor ways from the C names.
> These are most likely typos, and they prevent the C codegen from
> working.
>
> Fixes: bc515ed06652 ("netlink: specs: Add a spec for neighbor tables in rtnetlink")
> Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

