Return-Path: <netdev+bounces-83335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069D891F92
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD751F286C3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357913280D;
	Fri, 29 Mar 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndj+0JXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BA1386DF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719479; cv=none; b=KAka30uTPASMYT4/fvHf0gZfHg2hVnYMj3K7epTMxgYRKQg4wtWiXlvUzZvAAjlGKW9miv2QAwMokjO0UyhSVzc3/nW1NZAeZ/GHKjGomS+X7vnVhRmzLBP6QyKyBSNIMUZNTuLekYUALZgi18TTjpJEN0XQ3+Dr+qDUSUWC5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719479; c=relaxed/simple;
	bh=tfUUWCNoq9kFJLfvUTTjKmqN7g+6jThD/f2anfKUYv4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MXk5Hbnshb0p3GJa1/74fn/d1WT9vm4user6875qaqwo4t384ackHhMfBsk0IjeoTnUKH1XikolXCmwjazkGVQrlQ50kyCviJ1Qh+J1JV4t1cJYCLxP2CZi17uSAd7SNz6p7W9deakheCS1mZ+N7kbq1+Apes5hpu7k3pwCAIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndj+0JXz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34175878e3cso1471603f8f.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711719476; x=1712324276; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPR+823zDrd6O3LCyJcV/VFZ3iNVilyhRfEvKjg5OPg=;
        b=Ndj+0JXzT18aYm7wwtVPsCpSdp4yNUl/fpyFf1xqmI9iFPbGSruARmVVzSEW4ZXdgo
         8+cTgUFT5gr8c0AH4uQeaNfAGld+eNlpSZp7ZVHPtZS+Y7NbvP7oVjnYpXbyqMi4H8+m
         in0YoBCTiYICTbY4GRIvJcJiDdGWZEQaJpCDKU4ifWGHY6QruyhQVXlJHDftaD5Hqpsv
         0ZcG1QJvYEulxEi61AddHgoxb+hjqeo1a/fHUZwAgf+zhi7QQEoNumKHmQ23GYSO0IWY
         NrV+WHgDAkuZn0tGIvzvs0uwuRPQAoXU94S8SlkSHlNjgvgsh9a17jAnW/e2WQeXikSQ
         46uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711719476; x=1712324276;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPR+823zDrd6O3LCyJcV/VFZ3iNVilyhRfEvKjg5OPg=;
        b=tCAM2qJ+V0HS/NyiDnq/y9Yo5BxbM9JMBif/SVA/8YQd9iFuKRk3tPkZdw3lZtgchV
         QWGdC2QKt6yI/WkfzqLYiN5Xtx0+Q6Zq6hTAncyHJxfYPgkD/YL26PYn4eG5E7xEhfPl
         lTWqWlsDEkctHyaD/dS/OxnR5932HrcfrdiT6+m3XsUVVtLgdev2STq1WnLRgT+QfCUX
         qCp3ivSucLWLNMoLdl3MFyp7I+5HImmqR0PXAE7YmPmrK8+izQLDnQmknL9xNHt3md7I
         6+OzOsE6WXnZqrMuHbzRejuvQgyGl67799/KMSplKOEm3GRNntCrrainP1U76rC1rO+Y
         0N8Q==
X-Gm-Message-State: AOJu0YwyqWiGZevuqWvITPdP68u/bo10Sqec2Ubd3PcPYY/ZOeOqc+Qz
	Q/tnU90RqjNorEut7tNr61c6fiUB5cX60OKArnodkQMBRZjW/1X8
X-Google-Smtp-Source: AGHT+IGcTDyKQOc8ugksjUPFMI5nTxRIK3e0We3VaClVLCd9sFpk9EaADAgD75gDz8d5u8QnWpbp6g==
X-Received: by 2002:a5d:5888:0:b0:341:c766:fbc9 with SMTP id n8-20020a5d5888000000b00341c766fbc9mr1582160wrf.1.1711719476078;
        Fri, 29 Mar 2024 06:37:56 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0034174566ec4sm4217204wri.16.2024.03.29.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:37:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Breno Leitao <leitao@debian.org>,  Alessandro
 Marcolini <alessandromarcolini99@gmail.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/3] doc: netlink: Add hyperlinks to
 generated Netlink docs
In-Reply-To: <20240328183844.00025fa2@kernel.org> (Jakub Kicinski's message of
	"Thu, 28 Mar 2024 18:38:44 -0700")
Date: Fri, 29 Mar 2024 13:05:12 +0000
Message-ID: <m27chljiif.fsf@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
	<20240326201311.13089-3-donald.hunter@gmail.com>
	<20240328183844.00025fa2@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 26 Mar 2024 20:13:10 +0000 Donald Hunter wrote:
>>      return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "]"
>>  
>> +def rst_ref(prefix: str, name: str) -> str:
>
> I think python coding guidelines call for 2 empty lines between
> functions? There's another place where this is violated in the patch.

Good catch. I'll fix in v2.

> FWIW I also feel like the using the global directly is a bit too hacky.
> Dunno how much work it'd be to pass it in, but if it's a lot let's at
> least define it at the start of the file and always have "global family"
> before the use?

I will just bite the bullet and pass a parameter in everywhere for v2.

