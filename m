Return-Path: <netdev+bounces-65507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B483ADE0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA9528C4FF
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9347C0BE;
	Wed, 24 Jan 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq9aO4XF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5F40C1B;
	Wed, 24 Jan 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111979; cv=none; b=uq5o/ijGPtbKkD0bZqiLoYf2U7EE8832khPQqMq4G8cFJbRaRwX3/AQfA98r3eY3adQfeUq7p4woArM71s71j2bJINFxLvwUIxOmrSUPBNo/TffuIYzRAsHWgZ6nnWtuUlfq3zpfr2n6dZ1zyJwAj9BtLqDLpiFfrxc8/QLUC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111979; c=relaxed/simple;
	bh=le5yI1zqBybvy8PgXK+4c64XzgOBWk6RNaTq11nCS6g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hJ9Nul4xYvouXxlTxpFg+awZqBeQrNATpUsK/G2QsKPWkh3Q59lJBLZFS9O1xwNNOnwlg9hGe3YL1GMgdij9OufaIF2Fz0i91ONVQS1sVBXf1+geYqlfYWyC+HIzToVW4CiJ9+xggTJ4KTWi5Ex3nhPg1Z9Mu+irMSgQjfWqMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq9aO4XF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7831aacdaffso495710185a.3;
        Wed, 24 Jan 2024 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706111977; x=1706716777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhoS+gnzYMYHM46CQ1Qi8dAe8/eLLUPm5HlJmdnXafY=;
        b=Bq9aO4XF0+ib0b58PdqTbzpa4AC6YQkEr7bbM8/VGaytZSs6Ir8QDA0Dj9OwJcJynw
         hMy95aKHaRSuGC7ygaZ9iNYE3jFlriZuBZtMIi9dplf46094oFNjVa6FFoWxuMVpW5Bi
         8DwbQAUVEEQz/n2L+qDO+Nv2CsIOol0kaYchak0Lpn2PCBRRAOAdkBvvVu0HPrWv8Qll
         0/+710Jvt7Tmrb5v5bN0VpwzwCzwpATGnStI5a/OqddkTQXTZnfGRwuZjHQgYGr0fZIH
         2aVzc90zLtkbVROqVkaJdR/htJ7sLG2VHnXX7t8yxDaPsI861j0ghXHmzOyq7qXPCLvJ
         zaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706111977; x=1706716777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhoS+gnzYMYHM46CQ1Qi8dAe8/eLLUPm5HlJmdnXafY=;
        b=aVOFKNehjNH7u3PW9jKXnpIWBJyhXEuWOmTqYPpUvjiW7WPsIfeFcVtKpfeBWaahTe
         Rx5zmrZl5I1S8JY5hVRTM+Ay1+Q4vaPsagkG2hfgbIBaaDeAkBDvWo+f4CEPPdxBUWPf
         +Plp4r/V/Dpg1pr2AVFXk1eHjwecPd4V8mdeSvfUw+XgQdsPGkLUeAC+b8mxhx1DXMMb
         zOFqn73Tlk7kDGgT9sxiWLpQAdc9DjTlKhPfeEYZWEpDK0lCojNawJf2XhI+xUXrLhW7
         g5RjEz/X6X1OZLfwIw6Zvzx3ynipPrjsOPtsLgMJXCfib3C14J3056y4lMy8jfJqcRQG
         5I+Q==
X-Gm-Message-State: AOJu0YxN8ssPCgnTdRNykQ3w0gtWD/dbarbcJes4NqtVyqbJl2JiySZe
	qS1OwSXktGC3sHU/8Oj6iYylmePEVug4i9kJnteyN3ggx/yFwZ4p
X-Google-Smtp-Source: AGHT+IHFc3BJv5HeMu4s4ypuc+x8E41PadpQnKrW2Xf7xRWWG/9ZnxBl1gTs6g7f6D1Gum0xuR+FRQ==
X-Received: by 2002:a05:620a:838b:b0:783:aaea:12ad with SMTP id pb11-20020a05620a838b00b00783aaea12admr3519423qkn.122.1706111976982;
        Wed, 24 Jan 2024 07:59:36 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id vv11-20020a05620a562b00b0078343592844sm4174595qkn.15.2024.01.24.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:59:36 -0800 (PST)
Date: Wed, 24 Jan 2024 10:59:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Message-ID: <65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
In-Reply-To: <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
 <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
Subject: Re: [ANN] net-next is OPEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

David Ahern wrote:
> On 1/23/24 8:20 AM, Jakub Kicinski wrote:
> > On Tue, 23 Jan 2024 16:45:55 +0800 Hangbin Liu wrote:
> >>> Over the merge window I spent some time stringing together selftest
> >>> runner for netdev: https://netdev.bots.linux.dev/status.html
> >>> It is now connected to patchwork, meaning there should be a check
> >>> posted to each patch indicating whether selftests have passed or not.  
> >>
> >> Cool! Does it group a couple of patches together and run the tests or
> >> run for each patch separately?
> > 
> > It groups all patches outstanding in patchwork (which build cleanly).
> > I'm hoping we could also do HW testing using this setup, so batching
> > is a must. Not 100% sure it's the right direction for SW testing but
> > there's one way to find out :)
> > 
> 
> Really cool. Thanks for spending time to make this happen.

Just to add to the choir: this is fantastic, thanks!

Hopefully it will encourage people to add kselftests, kunit tests or
other kinds that now get continuous coverage.

Going through the failing ksft-net series on
https://netdev.bots.linux.dev/status.html, all the tests I'm
responsible seem to be passing.

