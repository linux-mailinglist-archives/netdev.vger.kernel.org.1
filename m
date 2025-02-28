Return-Path: <netdev+bounces-170794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12E4A49ED1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B20F175A82
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC7271294;
	Fri, 28 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+oiL3nB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBC33E7
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760212; cv=none; b=VQUnlPhbvQ0wT+dDtXVWyQl26ja0er9eNmSiUnOkJCLkZHNaq7jxhoD1ufafgHh+Qjrw2vyY3i9+ebIDNfRO3ycD9thKHkO83P475O4oWgBnY+m99ofEW7IAhXHyB7r2qim981Ie0KAzTGrOKauxgekixX0k7YE/dLpf9AOmcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760212; c=relaxed/simple;
	bh=DsVHPpdoAOsrXlqvdNZhP84N7th0ylFYm9w+Tv+ja6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2MlYiB0DrqJv3NPO99vv8BJUJZYA5cZ4GXoT85kKzDHNWvHlElSljAyXx1TR76FS/9if3m3CMesjISl2J6vIHl00DnCdBLV+RGybegPKTBh//KrQxeeJJRxVhr6y3aCpBQJ8NX0du3MKOMRlzlIzy4+WRQHyLz1+ftLquWbTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+oiL3nB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so4884183a91.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740760210; x=1741365010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IygUAUjG1IOSaWGxWEh/54kvVC/0la0W+PfZqK72KTk=;
        b=P+oiL3nB4W3LP19cuN0sVOf/6tX7TLKwCi0sEOqlShJLr2/g5BNz+sIN6UG4GJNLYN
         Y8mxoUZzp9IwnUIEA+G9qBDxFB5ZOT/3SWmwy/BwfyB4c5qLTsmwvfu4c9CbCBtrB61q
         fwnoMS7Mc3yC9sVp5Z76qaNPkdXBpizXYO10qkyimpB59kBkRJ9z4opzBHucNCY9Ym2R
         19t2ViAiCg1jmaKzzFDGumgiCQbh9PfH7SSOV6ffODddzxsqIM5ctW7tX0t4qgKAWQFN
         JQ0oBKd2okryUird0HlvP67SAqG98sjxJ3MFS1AYAPyA8V5fZPRnZA4xMPNt8A6SLsnq
         6NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760210; x=1741365010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IygUAUjG1IOSaWGxWEh/54kvVC/0la0W+PfZqK72KTk=;
        b=LHTHSh/2BLi19lFCmwzpire/UjgFidb3L+Fys1BC8nq5oOqU3VCTVYbuOOpmkVU8Ux
         FpAciT8CfxgPTD/nvHH0JqjktsQJRQpTcfKBkw2O9ORz85tLUvxhJ5uFFWaIXkKhy3Rz
         NI5BBSIMqRFpGdao7FKtXi5hnXQg8wWqusT3+cV4Q3+TZyG5F8orXB5vodlHaNhh7Hrf
         tA+yjDAe9BGmdImgQBifZtirpIhDM2wwvWHXOhWxorQVT3FJRBJu3/ElQu8cj/vZrW2D
         Eb3ZU6uICksClm5A24exP1A7Wh2hovwQXavS5wFCyJYG20+VxRkYNPsKfrfkCTlTVcyC
         S2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3arkEiosLvekL+67iInsujVCcCM/uR5/52jDkpQEhrwhZpvE2FIaBo41/ZC6E9v8QFn76S40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGZ9qEYBgyjqMgKsjRCv527ul/scHP7nEpTu/8zyuWGevISr8
	RN78kgf/BlfVGDO0RGCLCZHpWYEluc1fgO3bl45XZ8x+6sw1Vtp6v+H9bFUZxU4PnROXvO/uzgk
	y9op7tCxRSA==
X-Google-Smtp-Source: AGHT+IFHDSjI3RHsIwnjZaB50DsSocX5C/rWjbGT8/BHCr5Oj31lJ8JPnzylmqKL2eaqIp7igaNt2sgUdr9/9g==
X-Received: from pjbsj4.prod.google.com ([2002:a17:90b:2d84:b0:2ef:786a:1835])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d605:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2febab2ec9cmr6247242a91.6.1740760210435;
 Fri, 28 Feb 2025 08:30:10 -0800 (PST)
Date: Fri, 28 Feb 2025 16:29:58 +0000
In-Reply-To: <20250227131314.2317200-10-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227131314.2317200-10-milena.olech@intel.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228162958.1257521-1-zhuyifei@google.com>
Subject: Re: [Intel-wired-lan] [PATCH v8 iwl-next 09/10] idpf: add support for
 Rx timestamping
From: YiFei Zhu <zhuyifei@google.com>
To: milena.olech@intel.com
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

> Add Rx timestamp function when the Rx timestamp value is read directly
> from the Rx descriptor. In order to extend the Rx timestamp value to 64
> bit in hot path, the PHC time is cached in the receive groups.
> Add supported Rx timestamp modes.
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> v7 -> v8: add a function to check if the Rx timestamp for a given vport
> is enabled
> v5 -> v6: add Rx filter
> v2 -> v3: add disable Rx timestamp
> v1 -> v2: extend commit message
> 
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |  1 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  6 +-
>  drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 86 ++++++++++++++++++-
>  drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 21 +++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 30 +++++++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  7 +-
>  6 files changed, 147 insertions(+), 4 deletions(-)

Tested-by: YiFei Zhu <zhuyifei@google.com>

I was able to receive hardware timestamps in ts[2] as expected, after enabling
SIOCSHWTSTAMP with rx_filter=HWTSTAMP_FILTER_ALL, and SO_TIMESTAMPING with
flags=0x7c.

Thanks
YiFei Zhu

