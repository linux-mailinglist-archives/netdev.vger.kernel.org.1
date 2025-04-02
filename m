Return-Path: <netdev+bounces-178754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7FA78BD1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC4C1893E8B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C923370C;
	Wed,  2 Apr 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymdv8SWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3320764C
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589177; cv=none; b=YquTB6KibDOyrQ4uW4bin32wsdb/Tgf+SxyB9ydorcnMlP1vPdWmSaDrPECAfBbfrX+p4hcs5grjeuRbRXaqqFvMp3ph/L+KecHjQaWjnRccaeiE4zYaGed8okAcef0dFIEAvCeVwfFeMLzvtOIH/62H+vfxm0bwTizM7DjDEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589177; c=relaxed/simple;
	bh=YWKoDaCWMuDN9R2MNxZ8oj+4NZYgHo0qSTGfYB3VYQs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=BX1dp0oTzFNjhRlqDfLguBW0EP5embsfJALR/EV08U8xrdaocn6jAxAEdgk25gQS73KWzS70f3S5gNRd6LN62RJA3ofhxYdofLQJJHfZqv8tYENncjizujsxVePh1uTktQ10Cm2z0XuOhGZNIoVgzCq5BLTb8DG3BUmaYxn4U7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymdv8SWe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso4811805e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743589174; x=1744193974; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFjD2QrnVua63eX0X19FdrEBBQmGU9xgIwchmAw74Y4=;
        b=Ymdv8SWeqj9UL+HIurCBaCHn+sqK6fOq3F+zQtKS6xHFhLLhyDC+WHjU+TWE4xPo7A
         8vHSSVUWZg5ijlq9EV5auMky7VkApWBk5MEL4lQLTohJZ9FToTjzJYnfkRrBb1zAW3lA
         KuIcC5x59fTZ4rA1KyPeAgOUfRBNrB2jOFQJR9If9WfUkOzlabNkZ/3ahHsHp8qmqIaI
         G2RfTGDv50Sw8Q+VCIAC4fn1dhnYeK7CEInyUMrAzmNgJJKFt2T009nBq2L2v9ilggtN
         JhwiomFpNMYz1lwFL1IUdqhAYw2xkMrMj97YSqeE9a6c8HeLGlZYjQHuh+PneRE3vzOh
         8iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589174; x=1744193974;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFjD2QrnVua63eX0X19FdrEBBQmGU9xgIwchmAw74Y4=;
        b=m24ox7SROrN2YqxOC+KnZYsTq+GHWrfsN2IIntIgq45s0FGRLxAHCvu63CCGSiNrDx
         mvPThyeZZ7XsIHA851mBLtMiRL+nDet0mwsOmtDwlBd2mpxfJALTWVcVyQz0uUEfR+Lv
         bjla3V9hp2Ht8j2g9J5DzEQMpid1Y0IJTmyk6BhQvV1VX2AdcnTD5i0kVD9scXGZHJfo
         ilqBNIgIMUe92npQcBvr8AfCj/HoE51uc6js49E4ZhzzSkZl/Be3xKJvEj/xOgPK32t+
         pCUZWTcEy0WWCAKlc6j5BHZNwGs+zS/Itczm93AveRiPyF1Nc4quRDpZIx+aw2H1UhaY
         eawQ==
X-Forwarded-Encrypted: i=1; AJvYcCWinuJAKUfHaoefgHbNCUaYuQZd6ZuWsUc06Q9VitbuYkLdmIsd6pl8totfN7Kpc7SDTvuLBnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ckmcAeVqIpYGsfiEqyVsc+1bne23s9F3ZIdpdpaap09FF3xb
	Hv0/3VdlKhlDuhmIyxWEVIZxJrOzV1VaVVdxIM4IOdHXhXs6gNkt
X-Gm-Gg: ASbGncvF0J2u6iA7Ieq0eNtSKRODlZszEM/lZvd6iEhRj3Ba0aPQQ/tRo6N65Cw/g+w
	qCjrIZqv0ikx0TOQakadatFAvYGPgQmZ9+9V46/dOJq8OYcNX26rHOacS/qRfoSUTDhFaj2H9Fu
	pHFS7Q5fP5yPV0gA1VQdCNpH1+UP/tTU/+Mso0QR9IifrDTbjbk4MlKNK3ZqwyuYARTCazdRDNk
	kBxytstWNHbZIDGZh9EAtJaHRTh2IjEkNWSu9mLSuAh7uEb5/BF51RZA3QN8ae70VvJAWnInTOG
	PuAzAYVfPGgR3m8ipMEbX6M5eoFDLn5kJVSgMgfUAhxvF9x/MJWw3ZlcNOYi1uwxMjjc
X-Google-Smtp-Source: AGHT+IFbRGYHwWW8eRm17jkHQP6aiPkAcXWmuPkCErVYgDp8Y6K1X9NP4p9VRy3RjwjIQRrRyKBSvw==
X-Received: by 2002:a05:600c:3c8b:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43eb7161d1dmr14066545e9.5.1743589173596;
        Wed, 02 Apr 2025 03:19:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:15dc:40df:e712:c569])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fc1be0sm16237665e9.4.2025.04.02.03.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 03:19:33 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net v2 1/3] netlink: specs: rt_addr: fix the spec format
 / schema failures
In-Reply-To: <20250402010300.2399363-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 1 Apr 2025 18:02:58 -0700")
Date: Wed, 02 Apr 2025 11:08:44 +0100
Message-ID: <m27c42j2oj.fsf@gmail.com>
References: <20250402010300.2399363-1-kuba@kernel.org>
	<20250402010300.2399363-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The spec is mis-formatted, schema validation says:
>
>   Failed validating 'type' in schema['properties']['operations']['properties']['list']['items']['properties']['dump']['properties']['request']['properties']['value']:
>     {'minimum': 0, 'type': 'integer'}
>
>   On instance['operations']['list'][3]['dump']['request']['value']:
>     '58 - ifa-family'
>
> The ifa-family clearly wants to be part of an attribute list.
>
> Reviewed-by: Yuyang Huang <yuyanghuang@google.com>
> Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

