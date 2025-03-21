Return-Path: <netdev+bounces-176729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D09A6BAE9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7B7A9733
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09239CA5A;
	Fri, 21 Mar 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="d37SEBEi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC005229B16
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560904; cv=none; b=Bp40N9T7WEiaIRqRxG2ZXs0XvTPNcXIoVUoiKtHUt+rsVkfdhE2h3fXpshMZGt58m1NjOyhrGsfEC5auVKbrrsMdcSU5xs42ZKUiaRmQsjMoQcNxUWDIqMUyzbDDu445sWOapFzyqrgKHLqFy9Zs+1Qo1fWnyQNvCzUUdgYireI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560904; c=relaxed/simple;
	bh=7iwcahJKh8X7Dx8pwOCze4hLBZiB6f2TqSPt5+3rpEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PC2OhpTVK921OZzatCpGgcV+IFRiNpy7wghqS002ZBeSciEkH1EMTN7MF+mNZbiaEX1p8q/5AwNJ3uexYlYQakNqsuP/jIPnIL96smYl9lSlj2OAC1yKBrzvf5Yr9OMB6C8+OPBkiHYb0PXY31D3ZF/XrqR/5E+IugHy4ha9MOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=d37SEBEi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac345bd8e13so346111666b.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742560901; x=1743165701; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4jrOkgKaZGtp4YuQru8PRgkCQ8xkKX6XJlRryj/uOw=;
        b=d37SEBEivapZ5mAGmhDUql9y1PfbcmTXSywYaaUaWysTbYUqGctlaARPCzsU2rEHcq
         27smEO7qXgFVEXsBm6U9sDBTcQXraRcwZ8yBctiNzmF5e6Mu+GKuV8fKxzqHJ82fXtyc
         jiAlQ4Fk9DfN+QKnZ++UkshAVwkfxsW/8+oZ/Od/J7jv0OdKeq0JjasHAEjBwPBPO0gk
         zjR3Whp/SQhG5xshnwiAKmZ+ZIpGDXIpImcyn88lGQjDkOqDHHLg94Tgpic9NYI4Bzol
         NKQOI39HQu5AlPuv+PZLMEOBdgP7v7zA/he2MA6PfL4UR53JInP3NE0GDGMxT1AvmUYE
         q5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560901; x=1743165701;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4jrOkgKaZGtp4YuQru8PRgkCQ8xkKX6XJlRryj/uOw=;
        b=d9muV9iBrmKty+pc1U69iVci8kAIs66MgpVCohomVTSJkNJqwcknhuRUOiGLOqV+DW
         fFJ8dPwrGafUs/Ian/sum2z9NyRz9M1kApt/HOC+N7/sKtZe7Q+5jdtrNY8KUc2GsEPI
         wa8xDMSfiIlWJAAv4X3Kjzqvi6fO18CCnvc24/QP35TdKJyshU+YK8DS8Mgr9LYS5PeP
         rdunu1rw2i1njdb/VF2mSGlUvcwqFz0+9jxq9pVWvCMRB77DsH29OhyowcQD6d903Yrt
         lojc6R04fZ8MrceLENzhPgdCNJLpBKPsb/w4M6z7MHMvUUP6JWUhvEHjC+waQe7ZV9i9
         E5lA==
X-Forwarded-Encrypted: i=1; AJvYcCWUoVgmyJg9Z//WwIXL7L0P9WmGnhVqhkA6fNAwtP4b2Yg20EkGU+rPWc9FXwrBTQI0uvknT0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gT1osdoP4r/bBoBTvVmI2cQjemH4Sdwe2PoZ3dxYSIG8JQaK
	4TQflGXrUTLZbNhxFDH/+3g9omc8MlqvR3a/bHuZU3Q6N+Mo2PS9X5vUT6XjlF2a1dthtRA98sO
	3
X-Gm-Gg: ASbGnct5h3mIsNPRaYUCojBJYajIMyxQNZQbiViLaTrt1D9fZAdrOzQGH9U+cEi3vyZ
	cioe3o1qIzxpilv8pKs967k90zd4E8d5467sQ3gFz7bjYBqFCL8gZfDBehVgiQC26XOT8W2oStQ
	EukWjBdIEllcv7bx5isbxnjp86UomKdG37ZeYLRNELWqygUs0qVaSIUPbpPbxuKVI3sV1pq69ka
	DCW+K+kWNsOuN4N5GCT73oaMYKSMrqnqZY49GJv9ysetqjoQSTw/AysvkH/eOZ34nA68r8euSP7
	I2WLVRb60WQ6ZbqlsM59CkRHRDwfDWGP0y8umXynfiIjUl5EFL/gliwrprhE4Kfiz4rLQRiulqw
	=
X-Google-Smtp-Source: AGHT+IFVsYMS0of3s7CrCm8+CjqSExmmbbmfa3VkBFfs8N9PagGiYbvHzqCZbcRz2Ad9bCgPJuly0A==
X-Received: by 2002:a17:907:e841:b0:ac3:c7c6:3c97 with SMTP id a640c23a62f3a-ac3f1e16b61mr328496166b.0.1742560900617;
        Fri, 21 Mar 2025 05:41:40 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb65871sm149047466b.96.2025.03.21.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:39 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, maxime.chevallier@bootlin.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory corruption
In-Reply-To: <3f2f66ae-b1ac-4c87-9215-c1b6949d62c4@lunn.ch>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
 <3f2f66ae-b1ac-4c87-9215-c1b6949d62c4@lunn.ch>
Date: Fri, 21 Mar 2025 13:41:38 +0100
Message-ID: <87pliaa73x.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, mar 21, 2025 at 13:12, Andrew Lunn <andrew@lunn.ch> wrote:
>> +static int mvpp2_prs_init_from_hw_unlocked(struct mvpp2 *priv,
>> +					   struct mvpp2_prs_entry *pe, int tid)
>>  {
>>  	int i;
>>  
>
> This is called from quite a few places, and the locking is not always
> obvious. Maybe add

Agreed, that was why i chose the _unlocked suffix vs. just prefixing
with _ or something. For sure I can add it, I just want to run something
by you first:

Originally, my idea was to just protect mvpp2_prs_init_from_hw() and
mvpp2_prs_hw_write(). Then I realized that the software shadow of the
SRAM table must also be protected, which is why locking had to be
hoisted up to the current scope.

> __must_hold(&priv->prs_spinlock)
>
> so sparse can verify the call paths ?

So if we add these asserts only to the hardware access leaf functions,
do we risk inadvertently signaling to future readers that the lock is
only there to protect the hardware tables?

