Return-Path: <netdev+bounces-126340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56A970C10
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 04:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810741F22077
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A51AC886;
	Mon,  9 Sep 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFz6e39k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445E1AC44F;
	Mon,  9 Sep 2024 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850509; cv=none; b=uGkjdnXmXZ9+juY1YYSg1v+JgLEMaCFDCKypwOJfmiRvVqtzhy8bRKWqygCUkRpoXLFRrDirltK5nbApAakK7ThXvg73Du9ncWKCDXk09AUarlNDaBwPyj6uIMe5oeWBqU3NaRXEfjSOYgW8CS36uqIrIg5DwE2bU09OWCvffm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850509; c=relaxed/simple;
	bh=XjbNPTdsNNijFOIZnr5m0CLag5T0LNqO7KfnCly4D0A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZjSO4htbQYGTzSqIjQGRezSFfNta5OLoPxcPs/RsbFcV1HUt/bBWZeVm+H8mbBe8uLT57E88WCeJzMf/kG9AETfI4YdKFQlxCFV+l6TrPf3XSbYoV+ovVx01W4lWKylCuvrj5qtLvxmNTyT/kFWVsvt7YSeS+Ji+4pNZ1M8ZI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFz6e39k; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a99fde9f1dso139884585a.2;
        Sun, 08 Sep 2024 19:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725850506; x=1726455306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAz7mV/WOjnhyGllXSE6KVfbHBWCJSJ4jchY0Iyonh0=;
        b=KFz6e39kRLYsAJ3iNqz1+lb6LDqxpDqOWHdiUoSe68eD+Q1JDshJLDNXpp0lh+j8gt
         UzPC8NgngzZQIyVBdq9wiOQkiR1pmKF+qZgwd5SjSzabE/MwUuCdjevpCTme6La+jV+u
         4Vqnobuw599TYkoGtCPhFoObSLKop7NNyX/jpQ08i1xRuX0QIX5qYjG6H2fZkZcPaH9S
         daUCEwvPcEH3BeP1+E4oC27rfcwW9iO0KRzdUb2xq8exReGwLmbWD/M+81CMVvje+98c
         CEa5WPkrkNRJAn9ZzXUQuL+pPJopE+Kvl5W+Z8MSdOOpjQtkOgyaj68lZsDGhcUTfJxY
         G40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725850506; x=1726455306;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EAz7mV/WOjnhyGllXSE6KVfbHBWCJSJ4jchY0Iyonh0=;
        b=JoPRj5fOBbBlTqHubDrmnyzt1GAH7K/9T05wAG0RmVUjUbPxPf1cGRCV4BMH5LcBIY
         VqaVmh61+iS63KQMTRdqp3z2tf64aHLxlwJD3blzZixFxlxe0EePQbg81h69QpMuIJqc
         kCJl9M9nw90SdfE/NGiOR/Q0zp16ZBVvFNngNm8DRuwYhpf9SBtuUa5yBIoA5/ji3WTC
         sFyw51NfhpDZazKcb27oYAUqG5IKNZwXMHx+8EFcLLcDIRIoyZ9SOxw93YGgq4WtDPHX
         x6ElEqfR/2r0SKrsf8Nqn8EIVfrXymqKfqobvNyj3jbUotMkPWcb30fwp8tJRdsfdwYj
         Gl1w==
X-Forwarded-Encrypted: i=1; AJvYcCXe7jMtkerpniq8QG1GuhbnveRhADfpbQRVj6OjFiBlVz+Hf4xm9IosDkhW7Xl0max07YyoT84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gUGXgd5tdIP4XJO9rhCPAZ4Bqb1KM+IvjDDs1RTfYde5FJF2
	Hbros3HwP1LDP3tCD3mbo5d5hVTLqWPyBQE5Us98vh0hDn+/QpPUI4DfL3tK
X-Google-Smtp-Source: AGHT+IGAdpXdMTNDiYeXR3bfdudGhKDvI3tmNwiIRSDrfsbBa441Sqeh+7FzBYHVBRCWmK6qPh8iDQ==
X-Received: by 2002:a05:620a:44d6:b0:79f:932:86e3 with SMTP id af79cd13be357-7a9a38a8226mr772546885a.19.1725850506488;
        Sun, 08 Sep 2024 19:55:06 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7867ab2sm176272285a.0.2024.09.08.19.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:55:06 -0700 (PDT)
Date: Sun, 08 Sep 2024 22:55:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 corbet@lwn.net
Cc: linux-doc@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66de6389c6a4e_bb41294d2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909015612.3856-3-kerneljasonxing@gmail.com>
References: <20240909015612.3856-1-kerneljasonxing@gmail.com>
 <20240909015612.3856-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v6 2/2] net-timestamp: add selftests for
 SOF_TIMESTAMPING_OPT_RX_FILTER
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Test a few possible cases where we use SOF_TIMESTAMPING_OPT_RX_FILTER
> with software or hardware report/generation flag.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


