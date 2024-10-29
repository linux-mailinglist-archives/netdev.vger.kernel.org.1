Return-Path: <netdev+bounces-139809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D559B4443
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FF91C212DB
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061B21F7565;
	Tue, 29 Oct 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvnieTJX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE31DE4D7;
	Tue, 29 Oct 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190650; cv=none; b=GNN9DLF8NqMkUsLzMyQ5iu+Kh/bsUGxwyNVHFHLcY0POGz9CP9/AJJz114roV3ch1qygLxR5/3yk8Ghi6nzVG490cqPN4V0PMrPuimAc3XfxrPuFDQ4fAdJAjC3/TngqQ61CbwpzxPMuLzcptMvTz4JVm1SN2hN2ifQtOQeQv4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190650; c=relaxed/simple;
	bh=eNkNxLj45Ty1QNj+Lcl1YKeTRoDCdMcs3/LdHZTZhpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzoUYQSMgDrkjcv4joBAVnwuN1GAhhjlqUare5nRRtdtVMPtUYuasowVeVzoVLpFln7lsMeOir+Du3lB4oqsVnscAwrgoEzBG1sZkXN/adl9oI7uoYWALZ+ZnrNRJcrAVqC8vmK3RdcB3W4fuVL5uHBB+Tvm57/lf1oo/DApV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvnieTJX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so54979216d6.0;
        Tue, 29 Oct 2024 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730190648; x=1730795448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eNkNxLj45Ty1QNj+Lcl1YKeTRoDCdMcs3/LdHZTZhpI=;
        b=DvnieTJXwC4TIokqhvclh/FGlE7w7LwlMAOrNf9jgum0xc/1UfV4ixOvEuXadFYOHs
         kXd6p4EXT1GcSDQz7Y8MxiTdb4t91JoXRkvDuolOTM5j9kt98B/+jE0IjtZPQ5IxCt9L
         9+Lcv1LBp7WU6xJSNN4tk/8yojPm28Fz4/B2IGZqobj9G/GHOlzAGBicSd400yby5rml
         BT5AsHLGgvE30itjLqn1+QgoEhAH6KPSYuROoeodeSOpcKhRgtFJRY7bhWlrZRhOH0ru
         rbeFtlsAa8RmcTUYL042edGaA2hei+JZjCBfggiONls+zxlu+aRjNnhavqqz949fQnPx
         BXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730190648; x=1730795448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNkNxLj45Ty1QNj+Lcl1YKeTRoDCdMcs3/LdHZTZhpI=;
        b=EbHmx7f5x0Y0W7BwXokUi9eKcASnQflexA2jVWvSzTDW2c47FwSAyKPdZDLQB3IBp6
         xRsi1+M6iKy3kqcHDHNBUGEhy3xu4z1PTiqfuudLop73Y5Cel61HpsiQc2slnPKzOOat
         WbP4POAUucw/bUg7A7LTjMxo8cUegjk1cgRFXRHVH+QLllY9VebPF9QGe9/IXOTtCDsD
         il6dEVur1aRD1VDQ/sSvtseoIsQsJewCPQF67DhqeYf2VhHgDTrR0vzBKr5/LkEw2Ou+
         p/+qiGdW5mNZWV/Dj5VmnZL3qN64yufz4VQmAfIkI1sPRiIfl+45jtoFmWrhG2/38keU
         c87w==
X-Forwarded-Encrypted: i=1; AJvYcCUJnGSbr8FhyffgCvG36TDS340TmdHdS8CwobSXfvTSxdzEAdwU/zTuO7wMDnGFrXOPRTwsTzd/QMIEnbw=@vger.kernel.org, AJvYcCVJKDoI5Z9IWy4XWEE17fhqEHsBv3kPyZ80/oXXkz7nzjrKY+XWTZiRGqxdvBQ42+apXxRLSdPu@vger.kernel.org
X-Gm-Message-State: AOJu0YxF5+YTjdnwqrOKXF8ahZwk9U7ssKDNDrd1DalNUWTekC3gh0Tt
	AEsmeygtVarCv0UOMJCmo6FAzzpiQ9KpQ+8P+BIb9503QoAA18sMtVcs0AB8KjHfcJw2NUhxNbh
	22zMQ/TxwDE6HUhwIyM6Oz1dlnp0=
X-Google-Smtp-Source: AGHT+IE32jkSS1akYBGmZ0r/AYo+xFrV5TO6SVyM+kX+A3WFY01+I4oINmI7KZYjA2M5qwugyNCIIFvO8gwSMH9xiuM=
X-Received: by 2002:a05:6214:5d0d:b0:6cb:3ac4:a2f0 with SMTP id
 6a1803df08f44-6d2e72503c4mr23487166d6.18.1730190647944; Tue, 29 Oct 2024
 01:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026192651.22169-3-yyyynoom@gmail.com> <2502f12c-54ad-4c47-b9ef-6e5985903c1e@lunn.ch>
In-Reply-To: <2502f12c-54ad-4c47-b9ef-6e5985903c1e@lunn.ch>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Tue, 29 Oct 2024 17:30:37 +0900
Message-ID: <CAAjsZQxAqj=r4tJkWnZKxY9MC2a5d7_7HsVTcmJk5kjehT8uGg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dlink: add get_ethtool_stats in ethtool
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thank you for your feedback.

I'll post the next patch with an exact explanation of what is
happening here, especially concerning the deletions and additions. As
you pointed out, there is a considerable amount of code being removed
even as new functionality is added. Additionally, I discovered some
duplicate logic that still remains, which will need to be removed in a
future patch. Apologies for not catching this earlier.

Regarding the RMON statistics, I understand that you are advising me
to use the structured ethtool_rmon_stats for RMON statistics and to
reserve unstructured ethtool -S (without groups) for non-standard
statistics. The documentation[1] specifies grouping RMON statistics,
but there are other statistics in my patch that are not part of the
RMON. Would it be appropriate to group these additional statistics as
well?

Thank you, Yeounsu Moon

[1]: https://www.kernel.org/doc/Documentation/networking/statistics.rst

