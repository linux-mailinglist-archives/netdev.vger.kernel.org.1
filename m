Return-Path: <netdev+bounces-201038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96923AE7E85
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D8416F4A0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FEF29E102;
	Wed, 25 Jun 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkO6hpkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E81F4CA9
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845977; cv=none; b=WbRDQ4VXs5tDblaAddiaKgo+yvm4cjMareeV4it/4wK8c6e7PhlW7iUdSOGv2IgjoAzzB8cjcy6ryBHdbbwzj3D842a4hMAE7NvqNM0Gw/pIDKLOYkJCEhP8PPrN6yIwbslygwHuTSln63d9jQo5Hjcb1ayubPwXto9l+ev5Yzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845977; c=relaxed/simple;
	bh=wk3t8QEt4p9vzkrFwkkcTvfaJsxOptNg5eZrYJ4bUCY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=c13Hoog+QH6azEiVuNJotj/+ijUakbeKF8B+n2YlYPmBtDqq+7W0sBHVqmEGah3QDS5RxXGekulC/Budr815D8WSMxqlBeXBuJzrkowFgVZgziaVsjJHIJTvFnucH9cZd4aY0crUDfKQpscW/UNy+zvPE4DeIH+IXBvvePJQHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkO6hpkj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4537deebb01so9797185e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845974; x=1751450774; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wk3t8QEt4p9vzkrFwkkcTvfaJsxOptNg5eZrYJ4bUCY=;
        b=kkO6hpkjOwmlFpvVfjAti1I5MRpIa6RifBktNDBcNY/TPpV/phxpQDvfM8HVlRlp2r
         2HPeyd90/KigLqHyJJWipNSYMdHAIfy5DvKvLZqeuKVqmxEv9/vf36ox4VDDDX4xRQBl
         HR+6Ysu3BbuYlrZo232X2T70eXFR18+/fTXIT6nnptNpddIWYrd1vBdr/aUH4a0YOS2h
         AJAFHBgC/xCpBGTKvQztjQPWJXJWTyVudVbvs/C3KMDo2ysIEcNZjuZlMOxTKn4rVt9o
         4uLig2/lJrWvRTiQW5Oehe/vRvBocDpFvyRsfG0Iz+H7JUfzm3nXH7imwTEp6qvCdezq
         wliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845974; x=1751450774;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk3t8QEt4p9vzkrFwkkcTvfaJsxOptNg5eZrYJ4bUCY=;
        b=PMxteorPmP+jt/2odTM5M/26SUurmv7gnZZHfF0mzRYL9lZ+Czv+kPAEcLqmVlYaWP
         FW4/GeWyfRSy5Pn362Obn0lpAgMfQ3/6po84K6f63+E7Lkl+9n8/Zohu9WNxyJ/mHSYO
         2K+Y+jHdGIZjy+6MVsjIxTKB17hI3CxUd9p6Szpf5I8hBtEzow0Tgjp6e2acAWEpWmUz
         KdaGFM2adGVcTbs2bc6gnEXJAwvge8isQHnKnmx3M/SFoa6zKlZMtjatSm4Ejal7pql9
         hNnIeDBk7uPCYKc4Deh6ofbTr5lb8WNh0PBQDOdZijHCsYRMYwpJb1+TYEqEhCQ5wnKn
         0BwA==
X-Forwarded-Encrypted: i=1; AJvYcCUAkjLBMBkqtEW3WL++TJ8HjaFaGpI013I+oeqYvs9BMn5F40xA17zz3/en0jXBh3zz7NkF9KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6Hb9nYpraZCCdEwnQ0fEKK823EzSI3yQX6AU4F95M7Z4XWn1
	/q9d4jVW0Wz794pbGgikldERltiCVVOqU+XyIo7Cinnc79j/lzlKupyz
X-Gm-Gg: ASbGncvHLXwiXMvmY5bjlNiV6YXCJigdJak1yvRV1F42feVafHjJASKRGXRuNJcIbRq
	FJZEXZGMyefJNEHMLjwAmd6LSebeMjS4+Hv4Efu6p01M32aa+7Fr8bSeBM5mmDd96rCPhgps9hg
	I7bsYl5GrBMm9LcveTxhOicWwAF45+eyelQ6bMrMQIyl4CQrz/VE3BDa4e9URbzNSMCdVluohok
	1BvfKqa9J0+Y4KB5t3s4I+GgyaYhImQpUO6gx/6IQj/PuoCPCZ8RmLrmjPEVZjVVYQjtiAKlNCp
	3vMWluJxXt8q9XEkpoaN2AkKdYF7X7uJh34CKlveQleK6NuG9WkgS5lVdvc6DMuE/oHZPCC7q94
	=
X-Google-Smtp-Source: AGHT+IFL+9Q0FSZHRbnhY1d0EucQKPMCMeEbxo0kwWMc+Uv9TtpQMADBWHr43oA9ACVi6QZvHEKZkw==
X-Received: by 2002:a05:600c:8283:b0:442:e03b:589d with SMTP id 5b1f17b1804b1-45381b132f7mr21175595e9.24.1750845973913;
        Wed, 25 Jun 2025 03:06:13 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f67c4sm4231818f8f.62.2025.06.25.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:13 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  matttbe@kernel.org,  martineau@kernel.org,  geliang@kernel.org,
  dcaratti@redhat.com,  mptcp@lists.linux.dev
Subject: Re: [PATCH net 07/10] netlink: specs: mptcp: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-8-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:53:31 +0100
Message-ID: <m2y0tgb10k.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

