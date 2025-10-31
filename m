Return-Path: <netdev+bounces-234674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CDDC25E70
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A99B1898DF3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6D2E8897;
	Fri, 31 Oct 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW1y1hBy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FA274B34
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925975; cv=none; b=r1YnUek8XrHx3Z6bFulDHDinq5sy/Ylp5dp7KMntihTY0eS1tQWq9bzKlWeSTHPPKRFIYaMOw53T0HB2Aj6OB0ikub0WPo0oAeh26oXYZ2VLQOf7fypbgseq6lw7NHMesQqxCNRcS/BAiJWeB2+7mF/L4u+xOxuWnvYwgN6uniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925975; c=relaxed/simple;
	bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNdgNpH8CSN8bSbMiLk20s1LV6VS3ZtmE2ySjPq5fZ7Hk6mrskNXLrfSD8QsV/tmfa8Iz7a4VOinWUaISLe7C28uAwV6i2pt2Uj6CYkZ6rmDlZjqSrwpNwZHea4HIHrVNcb/GyQ7RFo7/j8D3fVU3pw5pfB87Ufvu5LSBzk6KJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW1y1hBy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a275143acdso284461b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761925973; x=1762530773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=nW1y1hByCT2EIHH9AV+P7YhFHTr16flibe7lFxEPZjFF9sEM4YK4IDxKBWBnHv0fBn
         C7qDsWCFMzwaY7srB3BrDeORL8mX12cCxp1cYQtoK3xRyMoq8n2RcLYpE8A0/qDMGXxo
         7FKc+nTuS1tYiUm1w6aX3Dj9xBTIgPyb8NowM4OXBz24OdtifEewA+3pa3OYpjc2Rn68
         9zdirdZhsBFkWXcFdA9TXj9AoHa/ZLBR2wbzupP3C3l6tA/Jmzxx8U5j1eflmkcHz5W+
         cQGj1Jh/W58vQnoiwEbgaqF2C+wdYZsqOQ+Jt879P7eY6pEPDSsgII76tqdys9+4a7DL
         tOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925973; x=1762530773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=rMssNZdjWofS5uPZA5BLjAk2jzcAueNM44vpMwdZGo37jUg2iqwtgbE94EXLnUIejj
         npwSXcxcDmE24C/M0LGksQ+WjvZ0+3+Pj4hwT5q53mCg2hp2QQg922ylcxk0toD1LdOE
         WNmNKHlmyAdQfplfA3dI/i4AC32hkiCMEKkFwPqMKk4r/XL7LdDnTqHndz7geyPoIu3y
         1JJb19ktSEc+eT7p5Mas651iftYZ3t42DCDDlF8Oz0AlvVpo4jKxQv6gTO2vmlMu2w2t
         SXkICMGzGu98mMcvD46ZNj/itYfaBPND6bdx5pZA8DVEAqhfc8TxrOjiy/3haaBzEgYA
         IkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXBeK350pzEjIGCtvz24DGSVZZ1y6/gqCdJHj4SZmA9C7XQhLd99bYOcQP/FPZmhfcV83VRyKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKSFzd9pPBQUXDqhC6ovEHM+T0SkObABQzYsRWewzBBInicVt
	7lznhWHH31v45hI/csXo0leIQNB7nyMO896HKH4VXE43PLGvmpJUslZ7
X-Gm-Gg: ASbGncsHow0fKNBKDLJYO4LTJojrXnecplHMxL2dS2EwEOGIoMOhao+U21WtPHFsMxG
	4bFIvSiHaEwf36e7zDm4NcW80AEO7KVzD4218tNM2FJrj/gLbXcOzOJ2wQcq7tcJ/4qwJvjmHDw
	7grLw7fIMAVU43NQp3MHXauO1xnKS20K6y7X1aVjCHn361F6kQUkJlAM0b3zy6VuVnr68mHo/+p
	KRiYdloWBYMppZOvlHoj4yWaqCXA8YBkWECJ/hclblOw8Zq8AuOPbv6dcLyUVPx8oXc+KGKCaVa
	uHGq3VIHsd0HV80Twb6ZMY5nZWzmmFwH3jnhK4/za0gPA6PLIGZDwT0Cl8qa3hGUR8fVl2D8PBA
	x1VFP2jxI3SXh4fdDOM0VaTSWJ9C9XQoPiXqhaBJnOSZ3su0IUSJUTy620vT/Rp6kyNQDRP0cRC
	9nlFMCzlL6isu+LG+wG7pdCcjNN4ZP2NoTK2483LWzuJvM8xwuqD9V
X-Google-Smtp-Source: AGHT+IHBQBstMXUUtNmpXOsCsPligClTf1NIDDX9ASsY0non7XP6tWdlMRv0kdvynqZ8iRRCPz8/Yw==
X-Received: by 2002:a05:6a00:1946:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-7a7796c3cf8mr2650391b3a.6.1761925973162;
        Fri, 31 Oct 2025 08:52:53 -0700 (PDT)
Received: from ranganath.. ([2406:7400:10c:5702:8dcc:c993:b9bb:4994])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a019csm2608577b3a.42.2025.10.31.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:52:52 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Date: Fri, 31 Oct 2025 21:22:33 +0530
Message-ID: <20251031155233.449568-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
References: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

Thank you for the feedback and response to the patch.
I would like to know that above analysis is valid or not.
And do you want me to test this suggestion with the syzbot?

regards,
Ranganath

