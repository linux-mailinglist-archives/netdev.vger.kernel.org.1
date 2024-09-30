Return-Path: <netdev+bounces-130548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BF98AC3C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E81F237BB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC2199E9F;
	Mon, 30 Sep 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em28AfDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8F199958
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721488; cv=none; b=qGB9KQCIq1eY5FUHWuBXL592ww+qq2nhi6XBvyOoLf/7fR43LTZboNuFfFLCAEcKPMQa/wIBLarSKrz4mGI4nslrOiCUjOKeUd7Tb1luo8Vk+1kWeSzNoco/iPCYAdHlFWH+zQgj063fH4ghR06agk+lSqXq3nT14VgZbMbDiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721488; c=relaxed/simple;
	bh=SvcFl3tFfJoiyr1nrUPBBwEfsRKtBssm7if3jpDgLqA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BHtLXuWqUFW38SAS2nkaNo7vJsmbhOdWExtdfTczPYAnQ2a/ceujsqPbYEVVQqW9sm/aFMuE+aqS56cEwObJlA3wnqgc3QBXSYLG+NjrDyHTIC2G8MjVnVuf2IYdi00fa2cNcKT8QpPANeEkrStkAsCbZTvlaUHJuaxLADaIT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em28AfDN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-457ce5fda1aso41245801cf.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727721486; x=1728326286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbEHva0zphHbYGlPSU6+Wj5VIeqcSvEbxsi1dQRuWNg=;
        b=Em28AfDNwYi9Ng7065P71n00OhKhX5BBB5sSkkDcZuRTvlKR9Q+QLu/6jDEpVChXur
         PtjASou5Zunci47EnRW4fq0P+EtY807yulF9UwlzV/0KB8sctZOxWGCxmdIRE2ET+nuK
         mAMvLyk6E5aq1KqVFtlFwxfCysxgtvWc2B8BKbHBaKjsa3nTAOqKOjlzdKh+/wrwfrE/
         LpR0u00dbnTlZneuBYutAS+clLRJYM876Iwb0jxp9HizGWFIzRC4YRuRGKmoDR6imTi0
         n/LgMq7tNGeqaDat03/HHR4BHYP20DiIi81YrWR6XpE1xbypvg16c6pn9x1kGCCv69Hj
         DYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727721486; x=1728326286;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XbEHva0zphHbYGlPSU6+Wj5VIeqcSvEbxsi1dQRuWNg=;
        b=anlE1eL3hXlbn7uUQAfD3e0FCCoyMhQflAQBQz68VB1Y8wtrL1y93rs5vb1PCYR/cZ
         67IVYAFCOBSvdmhlyEQmaFlznPtN1BXdKaN+zi6xUphsk2aSvYqNHUPCFtebJhUZ/KTN
         0oILqVhqsjSy8qg6t3afW9YWY8JfbGYkJlYBCH+RX2Kn/M1/2y50/qKN3iBP5gRSvk0w
         SJdtiQknwZbVgmmctkah6iubayZEgcy9efKUcJ5GivFgxeM/umHYCO0Iu4EIIaHZdk2J
         6k0p0rSxYTBj3wLT6eRwITf5SdLb+FwB3mvxhHaNF6ajec0ofPfHDzpXYcmTikga1GXj
         Zerg==
X-Forwarded-Encrypted: i=1; AJvYcCXIjj+u179N6Jo7ywiY4Ls44we0AtshbK/+8MKawqXGWhDuF8IrkpdlQCJpYeLFCIgWI5xhqDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnCCIrzPZ5LGQTheSeabrj5S7KIXgSwqo2xgwnXK+b1jsOGjA
	RIk2rsCBY1S2kXbDV+kBvpfM4Ru/ZU73vE6FnW07QT7dYgRkTlwx
X-Google-Smtp-Source: AGHT+IFudWITN4i8iZL67HmA0zfaSJtdxAw+sacO0PzB+mrCo9u1bzbIhan96Ncpd597plZUHEvDXA==
X-Received: by 2002:a05:622a:54e:b0:458:4a68:7d15 with SMTP id d75a77b69052e-45c9f287a87mr186698091cf.44.1727721485802;
        Mon, 30 Sep 2024 11:38:05 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33b458sm38323991cf.69.2024.09.30.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:38:05 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:38:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jeffrey Ji <jeffreyji@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66faf00cd5fb2_18b9952941c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930152304.472767-3-edumazet@google.com>
References: <20240930152304.472767-1-edumazet@google.com>
 <20240930152304.472767-3-edumazet@google.com>
Subject: Re: [PATCH net-next 2/2] net_sched: sch_fq: add the ability to
 offload pacing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> From: Jeffrey Ji <jeffreyji@google.com>
> 
> Some network devices have the ability to offload EDT (Earliest
> Departure Time) which is the model used for TCP pacing and FQ packet
> scheduler.
> 
> Some of them implement the timing wheel mechanism described in
> https://saeed.github.io/files/carousel-sigcomm17.pdf
> with an associated 'timing wheel horizon'.
> 
> This patchs adds to FQ packet scheduler TCA_FQ_OFFLOAD_HORIZON
> attribute.
> 
> Its value is capped by the device max_pacing_offload_horizon,
> added in the prior patch.
> 
> It allows FQ to let packets within pacing offload horizon
> to be delivered to the device, which will handle the needed
> delay without host involvement.
> 
> Signed-off-by: Jeffrey Ji <jeffreyji@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

