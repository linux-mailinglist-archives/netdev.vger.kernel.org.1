Return-Path: <netdev+bounces-157727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A63A0B61B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4DF18846B6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222E1CAA78;
	Mon, 13 Jan 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="a2NOQAPf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997BA1BF33F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769174; cv=none; b=SAkIWV9DCpn58RsCQTUX56Au9Dv0JTJY+UOds+jy8VRdyfToK9U7gpaxawdmRjLBw+zGPU+sBtevQyuPrycaOk+ZFOWVnhCVLezZX4PI7vRYYHjsQ3iAPxiZAdC7KctHeeVQwNzAOcrXr6Ff05ac+geYNcXd33+rfYfNN0vaEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769174; c=relaxed/simple;
	bh=tDKe/1gGfkfsCPDcW8MYrgfkhfdunQAtI4Aw7VyGzaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZekcA2ZsD01iZ39WGL4Nc8bakzx6jZG9ZL5hMh+oItLme/BzLVOz9aoIN/Ei3zQuLdYV+Lr6qCIaVatRJNtibgRnYaq1QlC3Zgs+GtphvyICz2LdUpF51SuWcc07C6pAaEJaknohHqC3fL9x4DIYfulBEVWmeoKiXftXBaJ0C4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=a2NOQAPf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216728b1836so70530645ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 03:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736769172; x=1737373972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDKe/1gGfkfsCPDcW8MYrgfkhfdunQAtI4Aw7VyGzaE=;
        b=a2NOQAPfrLtUrtGWxcpYyU8ReTvftSXcCBXCoGANZO02HbxVIEShb+4sTe39Yda3uq
         d6N1a1kaE4tBatCcMCrlkHwRCjD8s5WVnANNz/0ulqd0faniDhx/7OCDNbVVfNiV8eOb
         orF6YCk8XlNehDrwAaDJtceeeoQ4b1pqDKVa5C2L2Ai0o+PF99BaJUGGcoYbK+383w+s
         xa/nCQaAQ06mPHiBA3tkRuyKsfXPPSTXIbESXD6aj21Dx6+OegWNNNi/pc2VkqXsYCL2
         LozPB87O/B4PBSNsi/MqNHSwmAVyvTGazlnZ8VdS4eqsgMz71VRUIjpsXbEQAQ7uaiNB
         iA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736769172; x=1737373972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDKe/1gGfkfsCPDcW8MYrgfkhfdunQAtI4Aw7VyGzaE=;
        b=LZFmKml4UKPADeppI+S2tua7XzLjxxz1JQJ6iTl18jFYsVO6fy8FIBXQEXPBaV20Bb
         FCX1rbgGqoAvbBO+Y5cDHx7UNgJjCDeGIML7YgSYdjBHjY+tL5FZoO+ZFRGsMdF2g38C
         4DqEj5uE7i5An1W96g0oW6WKqY9XD1iZAbkroWA6YxRVbD0HpaoflGIvG+4ZaJ9TY4jm
         GQRsGWuSOTZJD49rffNk3mbi9NX3gjgUFZ6eq7m+j3REoxL4nOoGoVzYPjTGeOLJVwzs
         sGA/Z2ZT0DQbU+vkmXpZag7BY+AoHb3uVMEYLqNOCvMm7YevKWgYETJdtUfUrKxamG41
         nScQ==
X-Gm-Message-State: AOJu0YzZjOFnYDgDdbScYb4/0JacpPw79alRQPRfgc7AZdAFh9sTkLVr
	SicsrfC5EeZQpYUqPBC2E6r4xQWVN5aZTPzznWNtL4Bazfc5rcQFREKLs7WB8uIokPT8KuOfsfx
	3R5+w8Ke5ZBaVHwvg0bcINkfyvHkdvhxSLLFT
X-Gm-Gg: ASbGncv8qs9IsZqdd/Tq5bpf9o5W/jZBd9+onZrVbOLW3oHdKHIOrkwf4rqFprL2dsj
	J0BfQ8QjYVUzBAK+rinAVnYlhErafsZrSTenZ
X-Google-Smtp-Source: AGHT+IE/BCgpictah3ZkeTexpW7sCCkw4LFRWV3Q55KazxDV063npNwQOEdQ2JG/9aTWi6hRXkVPCs8SCN9dhNmUzsY=
X-Received: by 2002:a05:6a00:39a7:b0:728:e382:5f14 with SMTP id
 d2e1a72fcca58-72d21f314e9mr23751191b3a.9.1736769171999; Mon, 13 Jan 2025
 03:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111144658.74249-1-jhs@mojatatu.com> <87msfvq6ko.fsf@nvidia.com>
In-Reply-To: <87msfvq6ko.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 13 Jan 2025 06:52:38 -0500
X-Gm-Features: AbW1kvYxIOtUVx2TgA-XU4L8cokDt66y-8yN46GbPompiu8TLpRzoUnDpR3vcwo
Message-ID: <CAM0EoMnw01vbHoicYk-vFcWYuiUnG9PB2KrExSiPU8Cn2_2a9w@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net: sched: fix ets qdisc OOB Indexing
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, petrm@mellanox.com, 
	security@kernel.org, g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 6:47=E2=80=AFAM Petr Machata <petrm@nvidia.com> wro=
te:
>
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > Reported-by: Haowei Yan <g1042620637@gmail.com>
> > Suggested-by: Haowei Yan <g1042620637@gmail.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

I sent v4 with your reviewedby..

cheers,
jamal

