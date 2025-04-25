Return-Path: <netdev+bounces-186701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03EFAA0734
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E75169E16
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1A2BF3EE;
	Tue, 29 Apr 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtN5Xm1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7562BF3D6
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918848; cv=none; b=sMH6j9PQaCobSe3lqJKL4+kkeUeGFTKT9gIFZQcSWa1LAKbZg18X1rhppQiKoh+xUkCHAKTQakIKuzLSg4dUGuReoBAwGxG/INVtYgnpEwMewpzmKiZzS2etbNVimhqFKw9tBHHVQ7KB4JuY9kI+JfbxVXnnxEWT/vEzIZdPKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918848; c=relaxed/simple;
	bh=CMyVY1aE65XLb9xMSa5/pVHx2tGC9J1tc76+4SKn/hI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=L/ME/ugmIV2JvecDtEWp6jYP3yJ+3sn0jPArgCmiivuQowUDSXgyfUOwE/PoKvmQGFnQG7n4sVt9I9wSF9KJcbL8v2SNNEHe8k8NanUNujpdWhL3yErZVPLdTcb00VbzUVXckaEWq8AhZIIOluQ00Dw6RWTvetX5bXOx+FgbrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtN5Xm1f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso36000275e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918845; x=1746523645; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMyVY1aE65XLb9xMSa5/pVHx2tGC9J1tc76+4SKn/hI=;
        b=PtN5Xm1faqwQcCRr5DuSuVIGgxk/HDj4k0f+kcJFRM/8DqC4moQsm9PAtuiXhI2ldq
         lEejhyqP7M0ftKeWZTrEtCZE7gql8UYKCjHYWsdx01b3iPoIuTEA4HrBqaEBg2mzOzDC
         4hxozyutGzuOx6EbNI/b1D1foJgS5aHLwWSTtqdsTvRM7Fhujx29TfZ1WHH/vbfwriqj
         xUD8xKXGF8gsHTtQxv2KfRj9JxBMAQpmuPkzpdiUySMglGEkIHkzLA+voWXIUQ/pmZt6
         b4k7sKr1qfGETpBjZCcBA/zdss+sPUBjndbHxb8Mhh+VafPtnIVZEul7M44pGtuHChPa
         YFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918845; x=1746523645;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMyVY1aE65XLb9xMSa5/pVHx2tGC9J1tc76+4SKn/hI=;
        b=gYQTF5OkrViupaNlF1Lju34di5RLRKf95YmHom0FAtph3WLlC1J3fmEXug3bSXWImv
         uWMhXcEXl+9vDynw4naBnjLSZarYQ99oiTtmHeTmjSOTCHtNPZqzj61are6cOGCoCwzF
         TRVSI3zaHrgt0cN5s9Y8gMKiWgFubqnTjlZZmaVtZ3jjhWfsF8oGE06blK+DWtiONdcV
         tGfLZJyGfRN+3dWEjdJ18AMVdxSHpYuCxup9LaiiZM0hzDsYPtoOMVM23/LAWSJWKjII
         90sSDn1iG9Zju8XRyavpbLpbEveWYvgf5ISW2inMctH9h+pFcvnXZ4k3f1UFLmXDzjq4
         pnVw==
X-Forwarded-Encrypted: i=1; AJvYcCWw2l9r0zlYSJk6yRat3QGrdpf5sGwqQhEJL+ANm4O7x2V3nMFjxlszvKlyJvvsiraQa4R1Wl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zXk28J176lw1m4z0uVnUxg/+e3DY2P8qMhW91hIPgjBdn9sA
	jElylMF7aBoUTTG1O4+of7/O8D0X9iDo11ZCKYNZGgMTwJvV5xey
X-Gm-Gg: ASbGncuJIJknJZTfSVMOJlSsr7t+qtlIdEdtujpPCHUiDbokSPfJjuaO+3j2NfHyafi
	Np/m1qh4hBaYTWJIOCce6NftMt9CnaX+O6l1IFun7hoPPg+rK5+DSkTtCxWnLZgHXnhu9P8WLFH
	sNQcdHxx7FWtM5ZILogjIHeSNd+5oW2UskdoFyjJZ1Kia7G5+uvKh0OJVQF6EIGvgfswC1MaouS
	fRt6xQRpOvttmhgJteDLFIAM0tNi/DG0SO1tXzpOx+EONrlSH1s0lDE2B9Fx6rduZya88xlSU5+
	RovC0un9F4mqxFfXehfc3xIDogsA0Pz9DfPJ+FATS9Kld2Jk/ZbgqA==
X-Google-Smtp-Source: AGHT+IEz3ukc3D9PAu95GS3HayEzAO76wRuSqSKibeS5uZe6wDci4EGs4SucggQjfN1TO95qgsX3Cg==
X-Received: by 2002:a05:600c:19c7:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-441acb5bb33mr15588345e9.16.1745918844584;
        Tue, 29 Apr 2025 02:27:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a52f886csm155684495e9.5.2025.04.29.02.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:24 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 05/12] tools: ynl-gen: support using dump
 types for ntf
In-Reply-To: <20250425024311.1589323-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:04 -0700")
Date: Fri, 25 Apr 2025 10:16:09 +0100
Message-ID: <m2tt6cr486.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Classic Netlink has GET callbacks with no doit support, just dumps.
> Support using their responses in notifications. If notification points
> at a type which only has a dump - use the dump's type.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

