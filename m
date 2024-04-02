Return-Path: <netdev+bounces-83958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84202895194
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2381D1F26D02
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28460BB6;
	Tue,  2 Apr 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qLoRjEh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B104604CE
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056622; cv=none; b=bk3/cR/Sw63amudo7s/welr6zNQhBL+XC8d8OqMltrUEljAM7KBf0hM/SJBgVk+M+20WDCiZFG6oCIQc4+sgML1OaDRCnwvnBL1QMP9jh3Vgeqkk2qhqe9j37lNvfE/o8DW+EpifU+Vo+/EReIDSGRK2dGoXESqvcMxxsGUulcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056622; c=relaxed/simple;
	bh=AgLSSKVSmZ+TJd00RE4I+uJLkb4KSan/Eetpt3+KJXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5YZAXB8L29PAIrSyPVpcyCqDI2W0N1sW+gza4XaVNKvOkVItiTsYKpYB9y7Z9/L5cT227LWSOYTRZsK4FGpwpLPiiXObGpwPqHn+gTdWnf2nAXpsKQCQMicg6MPe2Xrbe3Afi+JPECh7H9gp18wT6xoAzC2ND+C9vB6qYKcucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qLoRjEh9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516a0b7f864so1902240e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712056619; x=1712661419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgLSSKVSmZ+TJd00RE4I+uJLkb4KSan/Eetpt3+KJXY=;
        b=qLoRjEh9GcHcEMjbQILykXRUOgSsvvhbXxnGkfMzP8t7n+y+qw8bt2vKlZFzGOnSF/
         vRz3KUHW992RfKu4v8YDRDsA9J/4biPdlWOseia151Vq8RQdXetgi1sHiPTmhvhq8QWv
         W5/nLEx+S6BQadjfHZxOag/a/I34ToGVSl0ElDOpFT3niq/xouShA6I/yQozFviWf9gH
         V3jkGbFV9dvUfGOuNrXlHoTdSVk4DgR46dEiDFvA36BpsO9TiUw8lJAnQa6Z3M4BXaha
         /mTSn6t6pPiUYiTqkHkUHvgRAJtoWMiAweHodBjM+dHQaibvsAldG+VSpDtL6r8y2Fik
         ZLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056619; x=1712661419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgLSSKVSmZ+TJd00RE4I+uJLkb4KSan/Eetpt3+KJXY=;
        b=HCgptiR5q85LBhOeonavLiEXU+Xnq31jDPx1bGmZGmYZO6q+Av3/w8trAK6eeA1FW9
         6WNMIDN/f5UKwZ7HC1L+9BhfQAnsrliRlCaY47SkhjdZaMzSzfUJOLT3wITNuN52CrrM
         E9EKelrmvR+DuRAw6R5XpcwxyIMIgU2hznCOuK4/dj38Tq+O7TCPoiZ2sdlSiI3kMYag
         ne4Ix2VVGthrv3GyUqjNu0rf0IdTOT/j52thUTiDlohlwjEe1pJqEV4Cawe3J/JKui+Z
         6KYpxAWJbwSY5O4wJNqPWa8tJmRnmcXXxC8gwDmM0Jc1rXKlqq47ptLVybVqUWm0nBrZ
         MWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0LL0nhbRl0cbShwlxRD6RJ6Y7ZBcuw2XXokRNRxwsCZEEVL+t3/wqJouJD59l7a4GtF0+XJ3hzeYckF1KO49idRZxpjGj
X-Gm-Message-State: AOJu0Yz85s+8L7YnS9SDQxWBhBpPQjww7myIyuML/1AkzFvlkLLcirrY
	R6L74RGO+Kbv081vEFX3uUkXm+AdeepG02tfHEJG6bdJ74I+6M82U50u5XzAHjg=
X-Google-Smtp-Source: AGHT+IHrfn5+qakoSjfF+eVmHdWpMnGzJDOCxp4hvlOHRl6xcuXO3Uw28u/M5GHuIJk6sqbBj3Wnxg==
X-Received: by 2002:a2e:920c:0:b0:2d6:87e2:e11e with SMTP id k12-20020a2e920c000000b002d687e2e11emr6983150ljg.8.1712056618756;
        Tue, 02 Apr 2024 04:16:58 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004161c690b80sm1225823wmb.13.2024.04.02.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:16:57 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:16:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: gaoxingwang <gaoxingwang1@huawei.com>, mkubecek@suse.cz,
	idosch@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <ZgvpKNFcBw-39SOD@nanopsycho>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
 <Zf097_S2K9uxGsR5@nanopsycho>
 <20240322080727.786dd760@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322080727.786dd760@kernel.org>

Fri, Mar 22, 2024 at 04:07:27PM CET, kuba@kernel.org wrote:
>On Fri, 22 Mar 2024 09:14:39 +0100 Jiri Pirko wrote:
>> "gaoxingwang" certainly is not.
>
>According to what rules? Honest question, I don't know much about
>transliteration of what I guess is a Chinese name.

At least capital letter would be nice :) But "Wang" looks like a surname
and therefore a space would be appropriate too.

