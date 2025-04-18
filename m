Return-Path: <netdev+bounces-184123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F201DA9363F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659618E4EC8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F3274FED;
	Fri, 18 Apr 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BexskWwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A62749ED
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974005; cv=none; b=SHomVJq18OQ3b1DDcQOsVJMFcQarRPEYLyk34hCfoaEgHDK17VIUdqKBnFfzHonDU9U4v5BZb40Y5jlssNV5olqTjbWnoFXjdI0dvBBTCWsVE3foxXcJw/DXSP3SsAFKbIoloSRrt3uXxsT23WdQm1D9F2U/D1wLFivE/+4t8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974005; c=relaxed/simple;
	bh=DnsSL+82l9kBT9sxTJCWK6uqCOeHRsJvNi/nlGicOeY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HB0YFiHD3Iz7wLZIsqt6+KLqYt8TttrVBJcps71yxLc1Uzjzfr+5TDfhmn+jogKx74/WmtiWD+oPnZhOPBazkDYAP7KO/SYoquX5FXd3ExCRPHaW6D4i90gbrX7ykewW5jsms8kpo9+qV9W0VEUuR3TDbgLFfi7XQBmMo8VWeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BexskWwU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so13413275e9.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974002; x=1745578802; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnsSL+82l9kBT9sxTJCWK6uqCOeHRsJvNi/nlGicOeY=;
        b=BexskWwUpCDgLJaC4EFNkQlruficId7dZe7BO3Xr//s7xwpZsonXvkWQIvlSY76LYR
         8slMegNHtVmbxrO5IAsgc2cvyQxvlt93pgUcg90lXLw4m//d8gRIk18SuPKc7J0HZiOS
         rIHFWdb7UNzHW1NFYQc468UBxzLXDgboxLmLmblTh3Ge+chPi7xs/eKlS+lj+b6YTrUu
         govs5Zuoghr4NxV3ab1QQBaKH+FQtcKd3i97wOntdLvsoPNE0ypT9Ua0UnKrFxzHhDgL
         en3+jfJrbk2b9wBrknbj8ZCQgdpy3WxB/kQ734gyZNxd/z7PeVMC8YaLXgnMHCoQmh6a
         l6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974002; x=1745578802;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnsSL+82l9kBT9sxTJCWK6uqCOeHRsJvNi/nlGicOeY=;
        b=Lp9JpmhLskvobO2mwv0B1nRtwBldzc2XmFSW5xxMuT/cyg3n6llfRfSMAbicAaDEab
         0DbCwd41TvosdNZ+ekjgZmhdubERlqvT/qwddNvaPPYCmVSalE8lPd9dVekkmhqdOpVB
         ISd+FRU5MNHOWJ3KsQHv3Ty0OiUDDytExHKmxRpEf9G+Yo50rgTk4q8t4klmOSWJRQar
         ZKaR5hwPlNO/ffTB9Z5cuCyk1wtc46kKhMVTOKAMecRP+AbDW0kl2ORP9i70vVNs0kGD
         3w6v9VbYcsqv1qf8KuLm43VHbSO+D3KNFgbcVY56nCzzo9eb2dc0KA2WPmxNyCCMvuvj
         tUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTj8sik80gro7ta/fsQZvYpqfwYIRTcxMKujldlQ8NugqUg4Y700Rh5h8DaP5evgS1xstRcM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNjQsaMkw1Cj8rcIn8i1maLqPhZ7urpjsOnDXG2nMdbxEePTf
	RCuS108aFy7MboNloXUj39UVb57VSsH9yjp2Z7sH6zUmaQtKC/Yd5H5VWw==
X-Gm-Gg: ASbGncsoUnUnpaye0guxS6bvF03We7PAioxuGjAJSkOW9/apzPOuPpU9K9b6NWfVdXJ
	SI6+khOSMVhBlTVkZ510RSRK7cLYxqKmydvzP2zekuCsRd/AeOAMf+gvgjmbL/lge4hkQkLQLpx
	UQj6JPlrluM8Pt+yY8B9mJNE9WOHrPjXz4mtm8y/AjNEb7/30NNpYyBl3z7sN0XOEdoVqb8JaK2
	gTHUyMB4LtglYnqvCcXe8jesfZnrL6I7gnkFDgdPYCANopSJXyl3Jg/2hgIS5FRrG1tRD+tb0lQ
	9sbCZG3zH9PC1FudZNRXwzEYzIFsRyqS3BqSiY9vbok1/W0tPxewVl5g0/A=
X-Google-Smtp-Source: AGHT+IFbAYp35XZMbfM+I0X4CGyP808jDrGxJrNrE3b1Engr+A+e+DaMUh9NDKpXFA6clWrSQO/2QA==
X-Received: by 2002:a05:600c:3154:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-4406ab97d6amr16946065e9.13.1744974002206;
        Fri, 18 Apr 2025 04:00:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d74a1sm17578585e9.37.2025.04.18.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:01 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 06/12] netlink: specs: rt-link: adjust AF_ nest
 for C codegen
In-Reply-To: <20250418021706.1967583-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:00 -0700")
Date: Fri, 18 Apr 2025 11:39:04 +0100
Message-ID: <m2o6wtiwjb.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The AF nest is indexed by AF ID, so it's a bit strange,
> but with minor adjustments C codegen deals with it just fine.
> Entirely unclear why the names have been in quotes here.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

