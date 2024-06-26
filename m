Return-Path: <netdev+bounces-106864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D312917E31
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B4D28153A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3E180A6F;
	Wed, 26 Jun 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhZr6B1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735917B428
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397748; cv=none; b=DQDY4JUe89uIJoZ9wornYS1HQK6l9ahqfJBTBBhzz0jsCZuTeYX1V5Qn6qA6ISO1q1YjRlrFloGL0EkRR/ioMXRlprFlahcUuudAaO8/CkevGkvmGuhvZBH9jwvnaINebRI6tr/LgPENIiecIu+KlPTEX3VyMCt+0enf/uCwlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397748; c=relaxed/simple;
	bh=mMqJNm5pg+CpAzskhKBm64JeZC3dj0pEo7U1/ATXe2s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aMm08WO2Y5tWNHqYE/fp7iQIsK+RhKdUtX6q1ZX0CHX3dGSP7BS1++a6fins6OGgufiNoPBnawqw3kTZDz590BeVYFvboM3eWQhPX6QSqxqZzq5rHGNfHsHTnChO5L44EANO4R7Toq8QC3raoQHwHQpQZz5uMqihSfNm7OE80WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhZr6B1E; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79c03dbddb8so168675885a.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719397746; x=1720002546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIm2OCePs4dz9lsRduDf3vRwY2zfTmFxbnXtvcLvM+M=;
        b=DhZr6B1ESmlU4KmdmiZ9EViARupAJb5rzjQ5HrAKJ40MJHu+V85xpdHCGji+kMpuai
         CFeryzQgfn3QHW9ngb5YD106k5lnLItGD7q6hjwbluvAeXqjq1PPLTGrYF0LDByETc3w
         9frCvacq+kL/uFggPZPTiemWzIdzxPGALaTNe74lhEPuooL7yKwpB1C8Y/wumvg3mbA2
         PwEsXBE4ggUsiBXIhMr+hbHDrECHShUIN96Ok2V0nhnUHEaQs99lsn4+d/rhF31uE7US
         2c0djEHLr8ERSnfRheAqFiKEGaJAZFvDI4K4HI6IAvQjC3KP6Pq3VBUIdfYr5OmEuQa+
         tamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719397746; x=1720002546;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wIm2OCePs4dz9lsRduDf3vRwY2zfTmFxbnXtvcLvM+M=;
        b=Kg9KQMKIQCxZ+PpEXKjcQpaoq8c3othHubyzabJCwzaU+X8RCiSDBFiKhRCY5JUXW8
         QCRh4HO0K4WrssS0y9ftXKKKkgRGMHCyr6kHEKaVw7in5DoEs4a/K1XBCRgIuBXSry97
         kh808YN2Wnbu/ZMJbgpKsK1hgl+w8uU+sZbt5AxSm+fGi8NUv0Ti3PpXsL50t0xoJmO4
         S/CWdFEG3XdrQLQMHe3uudi+36BkuqacFuL17fQvyFt/Cb4j+wAcA3vGPvj7c7ZRRAu6
         J/+VlGQJH0FIBNc3dps6d+0YYMgPpRtxneqR5e7NUh8wHc06sO/XqDoptcIMiAzT3VE6
         qINQ==
X-Gm-Message-State: AOJu0YwM60YXT9ErAszZKPx1/6yjeQb9W+VkrEucO/0lqA3Tnq/6eEbD
	u4h1D0NBj9XiJCpwnov18ysVW/JZrE6FFagyhYRmjaJSWkmZ6pLx
X-Google-Smtp-Source: AGHT+IEW/kHEafLbWl4pZBxpLVlkyjWV0Tx1yrCwQ91ov2kIQMKYiax5CkqnCAUNInFDQUm2MvGRzg==
X-Received: by 2002:a05:620a:2955:b0:79c:ae2d:34ba with SMTP id af79cd13be357-79cae2d378dmr151845285a.26.1719397746308;
        Wed, 26 Jun 2024 03:29:06 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b18fbsm491085985a.39.2024.06.26.03.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:29:05 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:29:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 dw@davidwei.uk, 
 przemyslaw.kitszel@intel.com, 
 michael.chan@broadcom.com, 
 andrew.gospodarek@broadcom.com, 
 leitao@debian.org, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <667bed719d151_3cd03a2944c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626012456.2326192-3-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-3-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 2/4] selftests: drv-net: add helper to wait
 for HW stats to sync
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Some devices DMA stats to the host periodically. Add a helper
> which can wait for that to happen, based on frequency reported
> by the driver in ethtool.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

