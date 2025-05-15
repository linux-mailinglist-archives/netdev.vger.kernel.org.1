Return-Path: <netdev+bounces-191016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89CAB9B35
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A549179417
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252B231846;
	Fri, 16 May 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyEGTlms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810673E47B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395552; cv=none; b=SYCJEm5K9Y6h0T5R3EPDOpX6/v65wBRZYJluWSi1/CDaGmtpCtr5tGARpvR1bRvr0K6nQ88bkYnlQGbXrtXh/cS/7ZNkmZjkLXinO/WlpEnXsCGrqwgnTtpdSJAFy7O4OfIkn4Y1AOeQSKxbx9kN4XArWkB53XVYaPcthROjZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395552; c=relaxed/simple;
	bh=owQ7b15DdeQ6lEWW9gXxTuFdVO9N2yluLH301f68ftY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=hUI+2Bw/sG0KJ9lLawkzWyz+/nvqqpW+k6Ii270N74kF29suP4LeHSnXCjP7f7/+YLcocqJ+mKN+8UJvHGil74wpgukpMRokWv+nz0wPd9V0q+VORvnhV2qYOWtsxD7k0Kf/9kPrNAGekoDe2Ooa/YCEwkbu+0GEY6UvQZRoRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyEGTlms; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso19577525e9.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395549; x=1748000349; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owQ7b15DdeQ6lEWW9gXxTuFdVO9N2yluLH301f68ftY=;
        b=hyEGTlmsa4ScDwxLbmYOBKQ1h+u49kBuCBhZPXvdjlyqWt4pZ0iFfp0YZGn4kSGZzu
         YMWQrmAtn3/mWx3QLjuNeGLzb7yMmDjAS0a+sdVAedTrwtb0amdjoC1nGDXSLOSU+Hwv
         bOoi1kcS37COxpHR9XBAyPZam5p8u5L2nyckqvroWkE4dgwwnXY/ytom1GqvJrbPt9C3
         m+L3GzoPMz8AMQ/Wox5y7s03Ux/3remKF9gDtAAm7yxJbgWmpkRizWPJqyCi3QIU88RC
         fSdpWSvhY+mbRsss7DBrrMRrQjCC/czurOTAdIIw4MRpoFwe27OfIwNTof4tZhloYUDx
         JBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395549; x=1748000349;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owQ7b15DdeQ6lEWW9gXxTuFdVO9N2yluLH301f68ftY=;
        b=N1tjogq85CrODDQlRGU98t4TP9pcl7O7pa+U1dNDceuDHbm45BI09EwzlorUswk62H
         yxEClL1QIsL9mgCJAvBXx58cSaB1mtCbpC5dY2eO3f6srFDaLxg0OHmu7GdjxfZzFoEv
         9DS9TeqfmzLKJerLgbnScS4s1eUicjH04rIsprHv3TPaAT+hJsy+UpZ5oExTYqCmkaVU
         4xMtv1OkLjWedzvkhdW5Q4zSERnqi0BkuiDmQDkyCc6ZQ+iDFrMZ2sT9/KXVU3M25qlv
         S82wJpW/HiDfGsDk2ay8zqAGTzuLcGxrnIDFulALqU1QRCP6oNUBM8HAWg0+sAK+Cr+9
         TcKA==
X-Forwarded-Encrypted: i=1; AJvYcCWfaXFGZGQbZPO0dyq69qDoqX+urOOkoUv/591JxEDxOMPagXHu6RztJl/GgnworinSGSKynbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRy3PQsKeX+wEHPWA7mOvqb4NEw3x59EDFvXZ47/4LCCbYWm79
	0Gi8OsULgA408eaCCTKchmvREvWezPxO+XLddUzeaNtYks2CSJvC42kA
X-Gm-Gg: ASbGnct2nFlJOIaNM/OVIrOCHYKWWQuCM89hX3fbAmSSegw1wCTNF2HDxwXctKEk0pa
	5OMlhYzFjLyHq10odCg6ertRGtupvYWqwzNm93Vo18AGHpgeINU/TBs/sgEdQH3PDvtn0hgOFVv
	ttT0/rQvXL4+pX2IhI+cuEKFds5jvovad689Rft246d4KTTY8/HfBuC+zefk/gZkd7OrQLsLIGW
	Wh3dC0ZiTaxM4b90M11plVVtzYErD2UNQ/T5LbKb3Ua4iRryTaXhuY6tdJIK6CeiL9ozuUanHuU
	rwIoPoUR7QPpwdHMC4MnNubg+PfpwYSlS8EEIESkQV2xyBcvtr45SsHRsD+Pp/6xe4CECv3SB5E
	=
X-Google-Smtp-Source: AGHT+IFzi4B+HGVANh/QRaYTwGjyw6YuTfER/kH8G1pVKW8f4qlf3DNY7FxoafI83ONki41hzN/QaQ==
X-Received: by 2002:a05:600c:4e0e:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-442fd606b72mr37993805e9.3.1747395548471;
        Fri, 16 May 2025 04:39:08 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef832sm102302965e9.40.2025.05.16.04.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] tools: ynl-gen: array-nest: support arrays of
 nests
In-Reply-To: <20250513222011.844106-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 13 May 2025 15:20:11 -0700")
Date: Thu, 15 May 2025 08:51:08 +0100
Message-ID: <m2frh6nwgj.fsf@gmail.com>
References: <20250513222011.844106-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> TC needs arrays of nests, but just a put for now.
> Fairly straightforward addition.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

