Return-Path: <netdev+bounces-223297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0096B58A91
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65420168ECA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2B199935;
	Tue, 16 Sep 2025 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESYbNM0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF0199920
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984632; cv=none; b=eVp8FxyeAaTnTjAi6OuJSJURpsaVQ28KIC1reK0c2AAyxcZoOZfQTWUVeTWOp8Di3EYdEPC+GqVT25cXf5+4xuzZftT/9dnCm+KnofcKegZ+XVO0pIvjw09V9X47kUHiJ6co/baAESD5ds4ZEUevCJJqyP47UjCgY9rhLPEQPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984632; c=relaxed/simple;
	bh=PyD9tFabiPyt6k44PDHVW/3DRPPYLG2L7qxqdcs6P6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icpqpjiCyEm3RQb81sG/LwyKsTTYhpkt2xpxBMzxkiWwL0WUn2CTJfBwuMLxlHXmPReKDa5q8e+XUP15L7hnKAr3g6t76MjYPAkITbEvW8etaHG2Vj2eZaO9M0yLToXw2z5lvEQUEEWKsR36TOOSuDngMsrmEGRryAyioKfRMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESYbNM0Q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso4166147a91.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757984630; x=1758589430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTTqJ1PzYlN5Tf9LOZRyEc/wEnKH/fR6iyZ4aVL4EiQ=;
        b=ESYbNM0QIBBCQnFT920tIXTXl5fFijzfQDXYf1ZZH6OrEOrhVHJt/CdHBrKuV73bZp
         bDVoLMMyouiU2iuvCAxss/oCqIiXQpw2+WDIEt8qmDcGiousdyK1tfRg+JOexxFGe8gl
         3JClKwqWhUnjaCPPD1K3/J6nYoxqWSLCDZG1vIt0GBnXPrYoxlILtR1HW6AFxYRgKFX2
         2payqmDq9ibXbxjDILs1RdCGPMRxbD/vOVwMrw3st2f94tO2rL88Wr0thID9lqj/ukPb
         JHGs802FL0ykv7EjA7i2+rLjVxMgbhLuoCi77GSD3lYwwNr1yUi1E4qtsuJfAnPPOq63
         2qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984630; x=1758589430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTTqJ1PzYlN5Tf9LOZRyEc/wEnKH/fR6iyZ4aVL4EiQ=;
        b=Q2OcW1kcxUFoxnrP3sYNgDFmqOPzlRSY5PWQVQUiYok/1HrORpHT2ySD0Y8y4vgeZW
         H4cTsUFL/86k+MmoESMGT6oSU9rspQUyET0TkIXc+xfxk+f3suz03HA6L/3ic9z8PcDR
         da1D3JQ+2H9G8gznNo/9Ii2UPH5L7PICe11nx8FxF/Z4LGjKQcAeOH4mxpcyOqJt17hq
         0rvy3iIQkUTfw0C4wraFl9I2wqtwVRrz8MHHT+685J0U/4/UYXkH7mXlU1aB86M0z2JY
         +05PTuTa3lTJXWS8+qA0k6YrMK6Qt2kegeqZuHdNr7S7aMkgRQ5oavGwUokh/B0J12Hg
         PVyQ==
X-Gm-Message-State: AOJu0YyNC9JpsjEK81xSifWIztl3PsRcXL/ykNbJ0rTPzItnRY+Wc8Wf
	MG0lANAIl2wPPu9wilr+hdeuBZAIwDCNU/V8uHke8tcK594j0qrlYOPO
X-Gm-Gg: ASbGncukoDndN9sGQXMUFgOzEbdphzjpDngkonjlhv1Nn0nvoslmuAadI7NHQnkQj3l
	NGZ/CKK0QOshvQBiaAG7/iyWryHmIZZW9WTUQUejEwcq3TL4hxCvOuWAQHpmHtjkqFgYXDvR7jf
	wepznhXV63AYT5RLnrW36Vww1/FAX629KpYOpqlDerV3EQeiEcA5gKq0JMEgCtx0Wz/b22nOBw/
	PMzwr2cMHW49GKthOx01tt2lkCugXReNLivNtC8xK8yYluqvPHMrPZe58sfKjg9yHFqf27SeXvS
	T+jpQAAw2QgZnSlZBSht5fTe0GLG/l2CeAlRxVkuS6RI/SzU9+kGVWlmXUGaXBPXc3+C6bNLyYs
	Vjms5ODmw5M2V7LC6ngmrCEu7P8Q=
X-Google-Smtp-Source: AGHT+IGsrrWACmY2x5NwzTWtkLaNRfykuTFOCxWVyvnZeymkbbhwpyyNZO3It9swEPkiXiS3QXUkzg==
X-Received: by 2002:a17:90b:3148:b0:32e:a6c3:67d4 with SMTP id 98e67ed59e1d1-32ea6c369b3mr345922a91.15.1757984629817;
        Mon, 15 Sep 2025 18:03:49 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea3c6fefdsm272384a91.3.2025.09.15.18.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 18:03:49 -0700 (PDT)
Date: Tue, 16 Sep 2025 01:03:44 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net 0/4] wireguard fixes for 6.17-rc6
Message-ID: <aMi3cB7Epg-I7tMn@fedora>
References: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>

On Wed, Sep 10, 2025 at 03:36:40AM +0200, Jason A. Donenfeld wrote:
> Hi Jakub,
> 
> Please find three small fixes to wireguard:
> 
> 1) A general simplification to the way wireguard chooses the next
>    available cpu, by making use of cpumask_nth(), and covering an edge
>    case.
> 
> 2) A cleanup to the selftests kconfig.
> 
> 3) A fix to the selftests kconfig so that it actually runs again.

Hi Jason,

Sorry to bother you, but I have a WireGuard self-test update [1] that has been
stuck in "Awaiting Upstream" for a long time without any comments. Could you
please help review it?

[1] https://lore.kernel.org/netdev/20250527032635.10361-1-liuhangbin@gmail.com

Thanks
Hangbin

