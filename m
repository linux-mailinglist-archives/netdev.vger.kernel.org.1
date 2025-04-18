Return-Path: <netdev+bounces-184121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0EA9363C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009B51B65D75
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBF52749D1;
	Fri, 18 Apr 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhfG0L/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C36274667
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974002; cv=none; b=m0lmgD/SOQq29A7CtVrOhyffJ4XUjSLb2+R6QD0kvBKVjhrxwSgfe2FhwT8cAfrZ3ZNzv/cahr5tdO05h/kvVLhdxZzsRFCu35kwbFxYZV+pxB/dcViMNpj0of3oyLHX914CVfYw67/C8xS9qBLyoNB4JkcM9fdkCspednhJ/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974002; c=relaxed/simple;
	bh=4eCZ7/dbYIWCUQA2mnUFwxckNIQl3rcV6JeOotKzn+k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=K5S9yd+vZzSsWuvK6pycUycUWrnxG8CtwGz2OZXZ/PpiF9nwc3z4Vw/NBnOJIr3sSa/Jkxe2it2cke2AWxTB4It4UG9045GnaQogef3Nutfon03rpwQRNP4y8Fz9cgNHSmT3rS41cj/qxDXVTGXFK1kx8P+F49npWZLkZi5Pm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhfG0L/N; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1182530f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744973999; x=1745578799; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eCZ7/dbYIWCUQA2mnUFwxckNIQl3rcV6JeOotKzn+k=;
        b=UhfG0L/NVhuTMLuuSKOboESm4rifJNh21Kq0s+WTdtEK3yYGHagSuzMPxhN8WwUt5Y
         5RxgOhwjD182XeY2pq6zjb9ObxVK+dXrPfniiPWI/0CT1AXJWy79QJxvfChA+9wgQT+y
         lVoQrvsLJRp4TImuxUgKGo9WrFjx3MbkAqdw8PUDv3EYkMph36PavDxzf9c7VbDn8rIU
         S/91GUFKzjjaUGTcAWmY3PKUX9pe7JphRLQlduX1jLQY4mUJUFV1ecBH515cAWj+D2CO
         juKKZKmpP5HjQMHWHYb6+P5dJcTM5qZatU3e2Xj+C4DQ7pKil5qsebZh1yEZchiM/3dq
         XmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973999; x=1745578799;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eCZ7/dbYIWCUQA2mnUFwxckNIQl3rcV6JeOotKzn+k=;
        b=VBe7VI8YzlapmVCCXm7kA3nky3CM3IW0K91dImNBFF7vQOtQWqzNjvtMPNnu9wL4+v
         R49jlIv5Qxpq3vTZFb34n5+CIxsc/iM0aRHVBridf024BEZ+wFPuBTcykF53fRIjTEpF
         T8QnTgf+MIfc1jSoqYtBLHl1nsqwx9Nm9SrIGHtuHzmr0HDvY0tyMn3IVkbMCTFoaR/C
         Lkku2LpmPJRC2BI/uK6yg+5gitl794Okw+2RMYk0S2HEeeUTrCqrG2N6thYrhxlmF96l
         +tUUZkOufy7DTww0exE68nv+cyWu+aArCbZ2s6kHxVXD4qBTtAmyRJXzLeenixwA8kkh
         eatQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4KeOpFi8Mq77eFXXtt0i4YLRSzdIVXz0CgUgbYSIAuPLxBQlDSEyAnFNsaxnwRouozYmECIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8ibU0Q6UB0yJro7/D/XvwfFHgOXJyuwFZzOJvPh1tduAr0qn
	kXwD5DmFihxPYeBZ4dG/cYkgZcaaoAMHxzXo3edLSZ1DXUQMI8Qd
X-Gm-Gg: ASbGncv2c4HWn/9SwI8A+9NG2Xm7iDvlAniFF3851ej9zbK37TPOG/xgJvr/4ZNTM1c
	JY4jU2bb3sVrndInl/91SK8m1EgbM/V5jMNePrPeO4+hUXsI+vwP82dt+ytksLJBP1NKoWfS/Rf
	Hk9FrycwzGJ3ErAYvy2AKbpJ36LNgBjvMxkT3MpC+bEiowu/l6pHXw41Cfc5+wrp9qYSA9FYJQp
	DCiYqiJDsnh62goEk5+7dKjO6Kw915s0upB7X7F1p5A117JtE3FOt/Ejy6ZM1sobUHCsUFL93wC
	9KkAkDM82qekXd+8DZoL5Jv0D8/WOUdz98857nZ0W7AIv8np7p7HoaaTcqA=
X-Google-Smtp-Source: AGHT+IGBgjvNpxgNGf9371bPQ4r464ItnJY6D0WACScNbxFY2hWD1E7TbhrOFOdGGmYTZNVgXzRIhw==
X-Received: by 2002:a05:6000:2510:b0:39c:12ce:1112 with SMTP id ffacd0b85a97d-39ef90916b5mr2828708f8f.21.1744973998694;
        Fri, 18 Apr 2025 03:59:58 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d69bbsm17640375e9.34.2025.04.18.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:59:58 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 04/12] netlink: specs: rt-link: remove
 duplicated group in attr list
In-Reply-To: <20250418021706.1967583-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:16:58 -0700")
Date: Fri, 18 Apr 2025 11:32:44 +0100
Message-ID: <m2wmbhiwtv.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> group is listed twice for newlink.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

