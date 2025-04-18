Return-Path: <netdev+bounces-184129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216DA93644
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94908E4F5E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10EB27466F;
	Fri, 18 Apr 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4uTHd/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED4275852
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974013; cv=none; b=NAMYiMVvckbVfLrGzXf/SssVZu1SiHKtYq445FIuvkZHzSFBz9BUxb5oMooVgMiwimVPfxZ5Fjlu2hCXPxSuUAZgqUWBxNAZ5c35hygGMChZ4jWHSIGpMP71ioCm0tVgZJDXFvTlJrVJeG/5/rE8owxoEQwXY0W0Xo7rl3ktL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974013; c=relaxed/simple;
	bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ZapsB8ym/PizqDlHQ23OJsAwa1m/c0f/PF6tIbNv5iqPqohAY6v7UDsL6nr9Vm9sCRGjm4fEb6sSiRXXq26+XZus8GirrWKGi5mH+MwM4tvs0PxqWpJaB/P7KD+orahXOaSq+qKmDYcBdWB8bowMPp5yh8wJihdmyq21pcKjZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4uTHd/m; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so1291559f8f.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974010; x=1745578810; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=K4uTHd/mUOsMeFJQQoNra2rnkTV8tsYjcPcryUgGY7wpKdEg+mJqnWhhVRphfEvCus
         ek0+9eB6+wlwWtRvHssLO+3w0PlRNCU0USwyVeXwt2p+i3Kx593cfhrGS87DczuZ5VH0
         M9faClZSLbY8TlzgU7JJWMkeJ21BQkgkeK1d1E3YWMYoPf4ALOHpdPegwcMCMDeB0usP
         cfd9zDIT3OxSotFQ+qXshxzUHy4hklLVr/AtAfUmt5pJZHaZmXe3yo8CLpFgBZPSsCtS
         q21OvryRYkfrHyDP2YFKVhvLYEDl1epwV1XMchqVXgwfRID9bemhJL61NaFqTZKb8g+w
         Uk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974010; x=1745578810;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=mnmJkiJ99HsTwFmoNxGoANiQVrcnbTg3eg8EaC1WVcKB3M6LT+VmjJ4X9YyoIKBbDO
         /iAt4cF79QfNCSxlO1KzKoXqeOoMXDDkkL7gS+DJc4CsT5VHveOyR9lFW1Qy8TZBXods
         Rhjs6S80jytM6JlbseiCpq0eS6BaZBlBwQLnSzezlFJ9821TZs4d4HIVAagXKL+KRefx
         ii4l9KuDVIuXLFPmmNihdTJT1AX/VlVtmt09K2lACbT80YPIZD+lv4jNXG6IMUbadHrd
         dJ8PG5xws5ik/Nw3fiwsjbVfak4Cy1GJYntxysmPXaXSy5o14RxDVGFC9LbDJ8gpCVwq
         Freg==
X-Forwarded-Encrypted: i=1; AJvYcCWULcjDbeeihi5QPgwfyqc32GWCvptoOLi/mRjRBYGwk+JF9KOCyYDVd8sz+Ddckal7mPjMoCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrX8TCHequQLvZbwELtPl+zkxmNgHaSK4N4cG+NAaXE7C+zBpB
	+C8Nd7v4hAvFNHwjCrvOH2Y4rkG302Z7eYy5W7/v0pNupvKIr/UV
X-Gm-Gg: ASbGnctvrEkn7VYMi7DmcxD6RI200Avuce3QmiWt2ziMJWHZOJQU/uy2JX8vMwUaplE
	rvgu2M/rO/Gyl/csQZtkBNJrwH9UQV+ithylCuVLsYEn8eQlLmezz9ve3pUCD2bZo6oiZuiy2Cn
	JAWhV+ZCgJgCuqTMnH3czDU4Lme2jUy48Il/0jenl/trlxUS1v7+vFungVnRPd8vDHr2XCOrHpp
	Ff8cq0eunV8xyMehKnUxxTuzCLPk1OBfp9c5+elPJCjeE/E+SE2hVaVgJzLzNmjNoXJMzJdRMJz
	vRIwOxS1zaR+TVASy4+YRfcDOVkQ1kaHWd8/Dtp1kxj24FddXtv6yoG7+dc=
X-Google-Smtp-Source: AGHT+IFAG4tv1GH7xMl016iw6+D4U7d9c3TU+vwORtCNcWrqtSnbJ0M6RVShwsUUCgZKE6aKssxo2g==
X-Received: by 2002:a05:6000:1ac5:b0:391:122c:8b2 with SMTP id ffacd0b85a97d-39efba5f0fbmr1744420f8f.31.1744974010067;
        Fri, 18 Apr 2025 04:00:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcdasm17957365e9.20.2025.04.18.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 12/12] netlink: specs: rt-rule: add C naming info
In-Reply-To: <20250418021706.1967583-13-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:06 -0700")
Date: Fri, 18 Apr 2025 11:46:18 +0100
Message-ID: <m2y0vxhhmt.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-13-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add properties needed for C codegen to match names with uAPI headers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

