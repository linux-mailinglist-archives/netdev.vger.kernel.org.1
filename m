Return-Path: <netdev+bounces-103085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932590636C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A236B23281
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00C13541B;
	Thu, 13 Jun 2024 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfzFvjns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC47132131
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718256372; cv=none; b=CqHad+HLnFrHb1sqplp+TYYOuPG2dYIqWcp6HqsGH6YV1sO0hCesJrg5nCgAMv2ZgYa89XvtsV7CHRIO7BpRuMeDn6K7UMKxb4Dh745jHaXvd6grvQ182abCvQDgp7dIHg8EETrwcDnqptA1vlUDP3kdYsTuPfAtiCGn6kW0Xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718256372; c=relaxed/simple;
	bh=tHFa1t91Xew1H+X2YO0VufRF59MOqN4kWhvpghlnCdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv6mWMDBKElAyo1lk3BSpDt6yT13Fa4ylt0I6XZGRmbALBKVYfMY5I2UEijA4udPDzLyeSP7isa6yoZd6RIo5d43RcLPMw5q6m82Xm65k5xP0oJays7miJ5rzlL5TkxCt/eRnIC+ZUklpkT4ZtBqpAYgnxPxqSCbC5Qn+y8FyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BfzFvjns; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6a3652a732fso3179606d6.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718256369; x=1718861169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHFa1t91Xew1H+X2YO0VufRF59MOqN4kWhvpghlnCdY=;
        b=BfzFvjns7qsZnHN8NQgWwBTIE8Crslq75B1U32kmvmobA0uYJNRz+xeBdugvSQmHDV
         JyEI1KrkQCG54ccEkd8FyQv04D5g8uKVtxT/ZCm6FXCrdaFOrcZ6rm09nWn6Zg90z6Du
         ZIBvvQzAxIalHwLmapkLYGamZYfOp7dTeIUN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718256369; x=1718861169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHFa1t91Xew1H+X2YO0VufRF59MOqN4kWhvpghlnCdY=;
        b=u0rtCWUEYlx5ISyML4igvbq/GL0IvssxVkQizTr3KWoEXpRnbyvehmOdJtGb+vYZ8Y
         ZWgnmfUDY8nbKzfTfaOTeFuqeAfC65S5vEidv0KiJdbcTEK/nBLnpbh/1H2y1kAk9IRR
         tZfwXaOUZGd56XvyZqq+5pptgCBiVmxq63sCBp/9iZgQX7BMQhNB46defn/aOLbBOSIv
         Vqt718mLY0pCYPbJLXLDPIdi2AdKJ6m017bUkrPi0sBupBX9jKw03BHiJjeweiy/Ht7E
         eF0zCVIxHHKDArH6VXn/Q4l8sQfQsu8gIhKNYAHvdK2aKcZlKc5BLV9MTueSS2iFmWsk
         dr8Q==
X-Gm-Message-State: AOJu0Yyh7FaLyLL0bmGN5Mc/oHn9lRwruWR4a+j3TGxnM2G2ri9KjOlV
	/LmIgAgoFRAd4vnp5Rtna0790OK7jyeu92oOzNZPOEsQ6x13EI9CypHQfH6yGfsLSzITyfuPI17
	jxQ==
X-Google-Smtp-Source: AGHT+IEAhS79WVij6fIhH3VOzPHazev80niAii4Ziw1CUfg4GAuAYZPfF3yrqF8sBxj6AV14k22U4g==
X-Received: by 2002:a05:6214:5d03:b0:6b0:7d9a:79fe with SMTP id 6a1803df08f44-6b1924ffd8dmr38851146d6.35.1718256368902;
        Wed, 12 Jun 2024 22:26:08 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ef93f3sm3200596d6.129.2024.06.12.22.26.08
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 22:26:08 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6aedd5167d1so3235586d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 22:26:08 -0700 (PDT)
X-Received: by 2002:a05:6214:4383:b0:6b2:9e53:fe3f with SMTP id
 6a1803df08f44-6b29e53ff56mr33050596d6.30.1718256367755; Wed, 12 Jun 2024
 22:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612204610.4137697-1-druth@chromium.org> <5fdae342-05b5-481b-894d-3f296e8ea189@mojatatu.com>
In-Reply-To: <5fdae342-05b5-481b-894d-3f296e8ea189@mojatatu.com>
From: David Ruth <druth@chromium.org>
Date: Thu, 13 Jun 2024 01:25:32 -0400
X-Gmail-Original-Message-ID: <CAKHmtrTkTJPHS1ken=ecx+C4z-LcG0OW62hoE6pAX3FUeX_c8w@mail.gmail.com>
Message-ID: <CAKHmtrTkTJPHS1ken=ecx+C4z-LcG0OW62hoE6pAX3FUeX_c8w@mail.gmail.com>
Subject: Re: [Patch net-next] net/sched: cls_api: fix possible infinite loop
 in tcf_idr_check_alloc()
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

> Hi,
>
> Thanks for fixing it.
>
> Syzbot is reproducing in net, so the patch should target the net tree.

Ack. Will resend to net.

> Also missing the following tag:
> Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in
> tcf_idr_check_alloc")

My understanding is that this issue is significantly older than that
change, and therefore does not fix that change. Should I still apply
that fixes tag?

