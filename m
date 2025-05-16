Return-Path: <netdev+bounces-191024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E0AB9B3F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B859E504913
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051C23C4F3;
	Fri, 16 May 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0uNdWyM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8F238C1E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395563; cv=none; b=qxtgijKcISLu0iW9cRMBbPcZQ/u/4rT6xD8IYE/+OkdkDf/jL51t9tzku3BeJ1Q5ctDpMv7lUeS8KOwE9974HGPVAe2pGlo4zqIatM1t57AA436rTNKs4FER6pQl1wUYWmC2dUlkZ+UNBDivqDHP8B306UGG/f90SWS8I9w/B4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395563; c=relaxed/simple;
	bh=5UNA20zlcRK0sxp/mm3fDo/6mVcC5dCeEMhb/BOeqEQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Ulu7W2PINRek/jVzBw5cddHFJZKZ0MM43eBmR8Kp/s2ZZDgEZ/2WH7vqQ7E0hC/u1I3w1zRGmq+hv1Ww3NTJfpzpUEVhqDlGvkU9ICgSRBctGccQK37POQ/tXyFtH2yIB0BKA77yvE/1mkp37wMks+UaULFfm1nIybO2AGqnJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0uNdWyM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so1362305f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395561; x=1748000361; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UNA20zlcRK0sxp/mm3fDo/6mVcC5dCeEMhb/BOeqEQ=;
        b=I0uNdWyMAmKuo0xBrRj7lEw1Phca++glDEQQDwhPI9kqEjHcJ37WX32Msfg02TOz16
         gyIP69H6jjzCT/Ercl2wFFqXvPBd4JNaqY5/AuWMKQ1NKQU5bSje1AL6huS0qWutTbox
         CQrYd6s6jG5eDuwgGI+wyNB/8pbi8jJxi5pxWxy1TEVbdHZ62v4zJjJ8kWLVSglObOps
         Q0uSdyMD5mcOHvnaiibMnB8vbYKC4Z6m4cusLsWa144ZefENr0DzkBOfLLziYIyvFMOw
         fAUzhfVVDwZsaeHpyRIy4pHVDr54atPoVxC/Y3Zj2GSk4B4c70CBd2SVO+8oyVZdcLib
         8nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395561; x=1748000361;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UNA20zlcRK0sxp/mm3fDo/6mVcC5dCeEMhb/BOeqEQ=;
        b=UZZEyb+5WcD0/3hm8UTfwa+eZCWvoe7+6SUUQD31u00PEfw7Vb4BSolR6fSN78a9sH
         9+975AOcdq4AjweXJfs36P3yUpNf9HUTCMakeF0c9o+m0NCxE7zEzvKu2LMYKdZdDy1n
         zL6Zi1xyLlDa1426WGwXKr66pvbKLOnVeneUO7FTCw3JFh/C1KAGmIWmrO3N62zpOIWg
         xWdjJ7XaQ+yRRVNt/IPqbmGBKFtJcnuzlWojC8A5oSJ3sI2j5KoMolsnzNGm4au6aO84
         1y2tRRfd+zPpAMbx4Jbl9vnssvrVduCqRk3yzhZb8dAIr+TY3tpy5TpjFTvtZJPY/MRs
         VLZA==
X-Forwarded-Encrypted: i=1; AJvYcCWqQAuRIz1pRlArJMMNDn1gopG4kQMkMsgGG1zZbLblk6iptjnHUa9eJw6THoCwEpzs/gDwk6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLrnLS2SyMS6tqw2m299GisoHYw3cM9uj08RkbIQPEwb0NEZs
	Eq0rPl1uF5DDmIlYartMEZ86/hSK8EDnItl7H82f1wHyHRj7NNue/wdO
X-Gm-Gg: ASbGncs9R2Dz+VwNomHgJ6L8VeW30hdCOV4obFDF8ghdEU4IORWk90/JsTAB7f2s77Z
	kO6tcbp4swas6yMmWvqyY+cd1B5F7vCispf4U/OkhB7MahcSCCczGqYbpEQzPqdk6Q3wIIGHeg0
	QjNH0V4waORR14evvGRPVghCBzbLgotW4yuMMAPhNMTu5GNMp8cTLRlZF8Ko7eB4TY2W4QcTylk
	UKyIq0qA0+YHHoZaJ7qdlWR0TDKMuoczX76VizzWvjTPdaVQ7O2Rw9VG7W38BYyHWYXTNVSU7uj
	kQCurdF4VNgWZ4RP5DE++vlbX44NqsXevD0zCvWoOSDqEVNvRsoDTguSDjitUEPy
X-Google-Smtp-Source: AGHT+IEgsQH871/erC+HDaSOtjqDsALh1imsp6wZO+B+LtQ6ATXS2cBm5iUZlAQqJdr19Z18Mryp/A==
X-Received: by 2002:a05:6000:2203:b0:3a1:fc5c:f8f9 with SMTP id ffacd0b85a97d-3a35c83a219mr3435556f8f.16.1747395560428;
        Fri, 16 May 2025 04:39:20 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62c65sm2671964f8f.57.2025.05.16.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:20 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 8/9] tools: ynl: enable codegen for all rt-
 families
In-Reply-To: <20250515231650.1325372-9-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:49 -0700")
Date: Fri, 16 May 2025 12:00:58 +0100
Message-ID: <m2h61kn7kl.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Switch from including Classic netlink families one by one to excluding.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

