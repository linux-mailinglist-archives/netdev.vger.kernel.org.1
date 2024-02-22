Return-Path: <netdev+bounces-74084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B7785FDE6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4890F1C20E3F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626514E2FF;
	Thu, 22 Feb 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gz14V5DE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3C14C5AB
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618834; cv=none; b=F2eW2Hfzd0cRJ4Jrs5TN02OrC6Lth+OTVtQRjF5Zj4ESTbQKP2Rf3ACQW4I94mNg9HjcFiand3AnfMx6wN0DG89sTuMtH2gqPhIBfGw+I9doP6Imeg0iof501XIB/vC+c8M6e/f7ZC3uZGuNN96xq8UDiKCFGFrqpQXBOm/dBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618834; c=relaxed/simple;
	bh=N9W6ECxZDgauEAPER5BLcHFn89h7jOnr5jjAdKzuNMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwWfV4sEVRyEg0kd23ld3n2USYwpdZd1gsHCQmDNxaeAm6sidx7dEjjIDLPg0ZyV2hSjbAIjWPmMSuy+lvBMzSBE2MZncyfuC8EV17+1pSRT43N9MTV/OgxOAHgYw6ds19RHtAr/PxZ3I9Gb0GCFEoXFkBjVTp55HFIMC2AmPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gz14V5DE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512cba0f953so3210510e87.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708618829; x=1709223629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9W6ECxZDgauEAPER5BLcHFn89h7jOnr5jjAdKzuNMY=;
        b=gz14V5DEFIgli2igAwmiY19rKeCxBqxXSkHfOhCrR46DJCuqn7CL1n0q0PXsrUQ/Ux
         /pIPHB5wuDgA7JoqLjzv//iXjQ/sV0qL4bNO+PzhwESUnUXV5QK/80UuvxsCq3+JVq5a
         7sDSpICxBYdcjUdPs/H7aI0nZtOyGS04HojQqIg1VGreJWOQm1uzJgsjMCc8z4a3NbBm
         l4uJ1pLUoEy/EEDLExZ3eSc62fpisH7qEM4jV0OqhqhqvjZnm0gBkjruWWHx4fyBjPN1
         YEGhfu/Qgui5zOK7MzYzQaCYemEWz7/ar1C34Pbj7FYjIQB8jDDiZmjftAqm5zg28vzS
         NsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618829; x=1709223629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9W6ECxZDgauEAPER5BLcHFn89h7jOnr5jjAdKzuNMY=;
        b=OMvPT9XpBR1blfJdJypKkMAAJx3H74Uga24srpPJUNKBJdYexk1pmLSn4hywWJuqjQ
         lqeSVl3z4LNE2CdJrcIrrkuWOasBRdxcAjTR09ijr43XcwtYgmVRiWoOuEgwBsy+TPHD
         CRnAItyicU+Z5tTy2a56A8TZDjb/EwIA3yAXlgSD4P95nBtwVmiadPZdeNGmPhUFnH8u
         YXWC8Zybf2YKvoN2/dgEa1QGrUpWK0oPLOD6NDbrBQHNYh1fwvvboTzVM1MDIAfIGu2S
         s+9VlEEXlroONgl9I4UcmjpBcKSGOQA29w3JyQKpnY7Qk3nWlG+NkO2rRKFWt9lhp2/i
         mf0g==
X-Forwarded-Encrypted: i=1; AJvYcCVRC4U8CvtehMxjE2jGkXMN9zR1jMRLv1tXqk3M7LO0k/+v57uNqdi+F0KAeGT8xJTw9Z3VWjpem4YGSdwtcOtq/mPdZKUx
X-Gm-Message-State: AOJu0Yx+qeZp6xOFx2bwKGZ2m3e6tbHYhs2ufGYOefhjMrnxi9hBAlDU
	A9HJPJ+u7A1METupk2LvBeOCeJbU5r2nDVX/5JH/c2yGEBYcrYBMHzrUyFjNBAo=
X-Google-Smtp-Source: AGHT+IEn7iRtL/wDakg8JOpqhBQQwwDZT93R5JFXaYIbtmFxHsYbF2zypJUjAsgXeAm6/5IbLiwzqg==
X-Received: by 2002:ac2:4ec2:0:b0:512:aa8f:ddc3 with SMTP id p2-20020ac24ec2000000b00512aa8fddc3mr9019209lfr.18.1708618829254;
        Thu, 22 Feb 2024 08:20:29 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b0040fddaf9ff4sm6551205wmi.40.2024.02.22.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:20:28 -0800 (PST)
Date: Thu, 22 Feb 2024 17:20:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 06/14] netlink: hold nlk->cb_mutex longer in
 __netlink_dump_start()
Message-ID: <Zdd0SWlx4wH-sXbe@nanopsycho>
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222105021.1943116-7-edumazet@google.com>

Thu, Feb 22, 2024 at 11:50:13AM CET, edumazet@google.com wrote:
>__netlink_dump_start() releases nlk->cb_mutex right before
>calling netlink_dump() which grabs it again.

Yeah, I spotted this recently as well. Good to get rid of it.


>
>This seems dangerous, even if KASAN did not bother yet.
>
>Add a @lock_taken parameter to netlink_dump() to let it
>grab the mutex if called from netlink_recvmsg() only.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

