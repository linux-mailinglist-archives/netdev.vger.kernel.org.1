Return-Path: <netdev+bounces-186698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61875AA072B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB367AB6C6
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3732BEC41;
	Tue, 29 Apr 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwFYiZtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69E2BCF7F
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918843; cv=none; b=o1HH7uLYL0QOo2UzO6/OyGmoZxsu/ZkqvYO8mfe5fdNz3gZmh0bYa1OXyJ7BYUW3Xt0ky6Ylpdjsz0jwTalid8ycw+MucdQ09Y8+qlsuhAn4c/KLrBQmcmF9cXYZI/AgJOKYNjj84rOlgoyKPtsfm2Yt4nUBz2BudNl8yrCwIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918843; c=relaxed/simple;
	bh=NPZFW1EGcg+u4WfomQBKRU57V83L4435KgH7jUmDsqs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=N3+1UsoZLyMvphidbubLzj0cRc5hv+akeYqUZLpwYIgbCrvCZvdwh+dyPjjPACV2SopFxF3Akx1E5KglVcici3DJFJcEVnoYa+62WaFCu9w8atuTyL3Go2OW7s9hDqJTB48pgApHF/GxrOOPBBgwXBCLHghxDOCR1q+x2hgI9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwFYiZtq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso38344385e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918840; x=1746523640; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPZFW1EGcg+u4WfomQBKRU57V83L4435KgH7jUmDsqs=;
        b=fwFYiZtqlRpI9qV0+foOUrLwlhh1TC5Q8RGSWlVca6cSd6VZaz7GXWooDvgNKIYSNj
         zw5V9Y5N/BYzvUqGCl+5Y5yCJFSPnhCW37sgw7rRFN+TOMl8IEe2uEBu0kVpmLMRFQwW
         lY+yI0CUCx438YdXYhraDjuWfv+xoE0e+q/USt2aJ2H7/r3jkJD9RNt6ooiUJKeDANUx
         zdP+j8ygX109DJeeWwgViB5bj9rk/oOvOojVEBN6Fou+LqHJMeUeGHmXbmqexce40jpr
         UROV2wtiOV3yj7303FeDRPW4EUVJH5XP/hOTkFpmKaUfJ5o1tf9RKOecIioLsRD4jpWo
         bZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918840; x=1746523640;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPZFW1EGcg+u4WfomQBKRU57V83L4435KgH7jUmDsqs=;
        b=lwhs4lwTWPDg9jTySb9XDRrt7DkoYBj6ugXgoXlMSzWGGC/5dSenjR+tGAyx7Tvt7m
         R/gTNJu9TGXcvhPsEe67aj4B6r3JGRgBLxPbXPNcfW9Dhgr32fH8yBdKlrpvEJZT2Rt4
         diEHAArxftwGumyy8Xg6k5/BCawmNAZL3uVciT/2gi2AUfzysGWUWQdZUvn5WaTdIbWp
         W3PwjH+ZUAdeMTTnEzXLsC6krk26G/kKlVX+hLBON/yrcIsx8cDKDxygPqmwzsHVkPoQ
         gZ0RsroH9uf9DmPZell0IfSURl7wca5g2EVrFDY4xRdAgqaks8Z4Ah5HZe2Q/LXfpn8e
         Ex1w==
X-Forwarded-Encrypted: i=1; AJvYcCUYs57r0UQl1mFBQnJRfGfyPVTtcUruXEgEiA96MWb5wQc5SUdawo+tYmbPGGqwvfjgPLGqjhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76HD0POAlVl7ebniZUDdUkC+dgGTBtlVB+5AMeyXBWsehUulO
	1CKSuLuZcc8QpP5yIP1z11ZOLCSofZRqfX4Z0jzXOGD5YfWm8WKX
X-Gm-Gg: ASbGncvB8gn+JNo6fcXz8rzrT4ECmNhulKlbUSfhAm2eO7hvvOejKQPHbCJOiB/6P6Z
	5rXpm4s4VdZfBC0IdN40w6MemBuVrtC9D3CJi0m7Rr9xS7Kbe5ZFh7U+S9Tiw6M2u9yzyPJ/WmQ
	Huv7RJ/bO79KdPQUQupvuQsGgqi76UDBypIdf/PWuaMR6v9DdkJQpC4BnoaBTBJdYHgIjxhSg4d
	tnn6vazl5vYbjvbF0kH1nBvwPhQxdp3spqngyfCorM+rzfsxtgqAJrBcyOeHyYU7cKr4CDqTG4B
	GVf9vVqEgdoO41mWW7qZ9vVo42ai3RXn3sWA1cHIoyyLVXspI8fDtg==
X-Google-Smtp-Source: AGHT+IG77qpynjhJNuaYebZ0THUmKcPIyVqUH6Lzh7lvBRfLdGFbIE9o6S6y8z4LhALj8TRQh4yG5w==
X-Received: by 2002:a05:600c:1c18:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-441ac8ce1abmr21676855e9.7.1745918840237;
        Tue, 29 Apr 2025 02:27:20 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8154sm181329005e9.30.2025.04.29.02.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:19 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 02/12] tools: ynl-gen: factor out
 free_needs_iter for a struct
In-Reply-To: <20250425024311.1589323-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:01 -0700")
Date: Fri, 25 Apr 2025 10:09:01 +0100
Message-ID: <m27c38sj4i.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Instead of walking the entries in the code gen add a method
> for the struct class to return if any of the members need
> an iterator.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

