Return-Path: <netdev+bounces-183844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FAA92360
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF6B465C81
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6841255228;
	Thu, 17 Apr 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qZO7cEJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB52550B5
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909587; cv=none; b=Q+iANfkuIV9QAH+S7p7vPYF/jm4/qt3fHV4djw3uHQKSnyft8Ofsj6AvYl0a5XmMWw8XlQEHzsbI0LOEjgF54AP/8ZmLoGxrYyE5qRDxX3MvuRBieI+uB4DY5aBqt2mM+W58ZJsSOW35ZWh7mjK0jYcr7wmSRUlJ8dwF/J+Fx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909587; c=relaxed/simple;
	bh=/rayCc9ocJT3K1N38tkBInMy2zbXnfq0bzNX+4YFKNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtVMqY+R7cJtfxkSUPOOzsQgoktnNmuxUEk/0MdwETSNX34gGx1BMZ/EH2cmtPC9SGgzp17rTA0kPkfufitITH2afu+5Iy3xRvfZQ0cR+4dsCAOtclUio6DKmMLIx69WSAudAyoHDp9ybn20fnlCa7qj1NkMBnhMxXl7+A1wICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qZO7cEJ6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736a72220edso1066681b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744909585; x=1745514385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xXe/XCInddH4WV/KVFfoKsdbwZ1rzQJBQUNYtkK2yw=;
        b=qZO7cEJ61kijisuzXtc7rEeQIPG/iMvwgr3lCSu75ur8oYjseyjrCQHWJz/tzP+V2y
         6Ro0qfd2V2tKD+oaGnj2Mfi0dhJF2Uac0JXx/+yyetjj2rU0T46Yh2EtJ7sNxvcrSsuY
         F6bsto+GohhwqfQoxu2bgUz/ddQcaBsrkRpz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909585; x=1745514385;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xXe/XCInddH4WV/KVFfoKsdbwZ1rzQJBQUNYtkK2yw=;
        b=KsVe9RpvjHctcwikqSyKmQEPNAMfAEkvLsnyocmr7M8CqrKPMmZharC0BhfYIIim0y
         HpqoYMsKNzlCZgBXB9iHuzFNpgTXt+kuDmNdT5BH2LQNYVomxpYbA1NDp26o02Qh0GU0
         u05E53AP7EmEeF+Uah3MH7w+qczBU6x7l4cxAw308S61DKRbsvYnxLhxCEg5kp7KrLAu
         EXBUSRy9oCU2yvf8HCjbJVwP4GKBrFHip+U0PEJnmTZMyGmWN4H/Egp5ACR1gbHC4ImB
         eo/kZVy+xHcJ/7tVlkUUHizozjPQkrJeLQwT889iweAeF3mohxqikwyVOwd9CjxhaLIV
         ZGtQ==
X-Gm-Message-State: AOJu0YyJgi3CVu+1On7p3nKm2WEHgkLe7lbYMCTIe2doD2JlbmxEMgqY
	mcvFoA0lcqaJcYM2I1SD+eKH7r4w/qHYz7WP/Yr0p8J1S28tGnV/oTenrjwv/hw=
X-Gm-Gg: ASbGncuzqch//6MCPmyf5z6sHBqJs/8Leo+a7ZyJNm9cpzDhvkxkhZTv+S8u71sVf39
	qm7exQzFHg3dtVVJ8808UFbW9TdWBPccJhhNG6DieMEazi1UCwpKcUl8PXV9bXdJD3dYFClRCfu
	BZne4Wwh0ULGJShsHyl8b0jzdNo01mhzZVE+FpWSnlT72V00pwKbWK44OUOOdmToAMZjfrh04Ib
	beCZrfb2NrLaMLcwvsXMsRfyF0tumvFJRKdcxK1ySkUZDA2qC7uW9IKC0d39W8TaPcZqo4cpkaj
	zYeJMY6FW6HxAexccJiVgVwTY7suU4SjIMAr6rPB5C5GVOfKeItw9e2U5GrIQ/eGxJZgjICO6Cx
	XEabCQr4Qr49BMt/Ik0vlBNI=
X-Google-Smtp-Source: AGHT+IE7lJplDSFz7ARLg9Ar2ZAXnjAKyTmuyKanO9eaaZPdP2fa0Yk5XsKE81dhgmyhqhOavS+vQQ==
X-Received: by 2002:a05:6a00:710d:b0:73c:3116:cf10 with SMTP id d2e1a72fcca58-73c3116d5f5mr4731684b3a.23.1744909585513;
        Thu, 17 Apr 2025 10:06:25 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8bf5b9sm93861b3a.19.2025.04.17.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:06:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:06:22 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAE1DkYpvb1yUp5_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
 <20250417064615.10aba96b@kernel.org>
 <aAEvq_oLLzboJeIB@LQ3V64L9R2>
 <20250417095310.1adbcbc8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417095310.1adbcbc8@kernel.org>

On Thu, Apr 17, 2025 at 09:53:10AM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 09:43:23 -0700 Joe Damato wrote:
> > I think the main outstanding thing is Paolo's feedback which maybe
> > (?) is due to a Python version difference? If you have any guidance
> > on how to proceed on that, I'd appreciate it [1].
> 
> yes, it's a Python version, I made the same mistake in the past.
> Older Pythons terminate an fstring too early.
> Just switch from ' to " inside the fstring, like you would in bash
> if you wanted to quote a quote character. The two are functionally
> equivalent.

OK thanks for the details. Sorry that I am learning Python via
netdev ;)

I did this so it matches the style of the other fstring a few lines
below:

-    listen_cmd = f'{bin_remote} {cfg.addr_v['4']} {port}'
+    listen_cmd = f"{bin_remote} {cfg.addr_v['4']} {port}"

Test works and passes for me on my system, so I'll send the v3
tonight when I've hit 24 hrs.

Thanks!

