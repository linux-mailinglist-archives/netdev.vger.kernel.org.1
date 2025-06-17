Return-Path: <netdev+bounces-198713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07CADD35F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9AB189EA19
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5782EA15D;
	Tue, 17 Jun 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRIHw9tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFA2EA14C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175285; cv=none; b=t7eHJX86fEiNdHokr8lHEJPbGkIwZB8JtBkUX9A6aX4WUwbyQANKCzi3+zjRzBYf2x0JofVmfqmV+cCYxjABITmFaACtArJO8XmCBTATcDcIVZeDI6vtO7B8N1C2ZgXupFTfzGz8tKgdLEyXJYLKCouG53qi1UIgvuA2bmHvw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175285; c=relaxed/simple;
	bh=5SAHH4eQNVP3yaY4tT/lD/hyLuUsmHHCU/z25ej6ssY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=UXpCmmXpVRJn6eFVkjiWWrdjSh92wk4xsDegih3/yYRIZSj9Kmplh75E+7hHIt9cDpWW/inhpuB2D1yq+NkoyWVthZiZsfo6pLD96Iu9YijqU0PBgBjqf2lZ7C+jcn0lgOzoybBtVbjR4GAzd9JkNVB5lRprrsx0b8wLHfV+h30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRIHw9tq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-479009c951cso3828571cf.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750175283; x=1750780083; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyX03SEsZ9iOiQtVsR2qRfbhcsxh2G3N2TbzbKhdGRY=;
        b=TRIHw9tqK0tFc0wZ2c9o27kUIKaHlF1Eks4XU169zh87jfoORCYW0qMZExNCpCKM4p
         KQ7xLzTxL4bdGpc87KKxVvSxnrLeWim/taISXCsumz+yMZJjOw1Z4m747gtr7EaUAH9T
         sBiex2OZduNzh4Q+l00mQiGjKBp+dty32rBjDDYtiooMxr/a9zKaxdyQzh36RMaxbVlZ
         XuWAwciNdHBHpY9WKiXxAn4Qlh+r+CZ3XONefcoB2V9dMJYoIhRFD7HIMpKcDEsHgJdH
         He14n/RVcQAAE09k0ogXOBMabC24jSsqUATOMY8aaQSvDnQZxkkRojg7c4ETL2u8GoYW
         4XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175283; x=1750780083;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyX03SEsZ9iOiQtVsR2qRfbhcsxh2G3N2TbzbKhdGRY=;
        b=UsCi2F5WvG+x9kDZU/ZtN4g1aONCXyc/7xLLi69IkJGFGhpesRgx6JkGMDSkz1yXoH
         Eo+SFxLWXJidX+qpbS8v97cDHaSTn13zHGscHJIgk0527OTOtReijLg2b5r4ijfPVn5x
         GlnM13Vz3iWpKPbdCKiMelJ/Muan2CZkxcSINroAOzuGUsPlVu83PgAU6duArSPh+wVo
         D9Q5HOez+46Zy7e++JhQT6cgUL+B7yO/v+Zrjx9fLp+fJQEvU74UEnqzTQhpdUyjiErM
         YJdORbCQh2RdOjjrPU14ie3ZtNCLKihLqkXWQnhmwJP0T0aIgql3hB7oK04BAvQM2jAK
         WqEA==
X-Gm-Message-State: AOJu0YyPg7higzE6Je09YY92kehI+zMvblOt1Hv4Fa7r/GueNyU2cuHD
	guQcYC61DyjkdLYLSx193bnSzoUmruVIDmExbUnmWVAdWgjAHeMaToNGh3iqbMZw/wyxBtOVDWR
	Pk6s7JiXI8jdEsH/ea04UEwr27UQCxrVvKcX9
X-Gm-Gg: ASbGncvaxSTsBrwDwwc7zWTbxpZb09p9YurYIvO2eS5Bp4JBJSlHQ6KNJ/2yOMBoHXC
	tKxWfIQYRz+g/RavNDkNIMqLRvOZ2G3lBRG+PZV+zyGYKOSWVA4ivsWsoOJl3yHU6FWvJgqko7V
	InmZKYBawKCSvpdv0o50tE5uWJdsolK0VbLpOYOlEwO3UyzgUHQ7+JDxBP/Gcd4aK10Kl0Xj7/w
	9Ba
X-Received: by 2002:a05:622a:d5:b0:4a6:fbd6:a191 with SMTP id
 d75a77b69052e-4a73c4b8b4bmt79239011cf.1.1750175282819; Tue, 17 Jun 2025
 08:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613074356.210332b1@kernel.org> <20250616140246.612740-2-fourier.thomas@gmail.com>
 <20250616104619.75f4fd74@kernel.org>
In-Reply-To: <20250616104619.75f4fd74@kernel.org>
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Tue, 17 Jun 2025 17:47:50 +0200
X-Gm-Features: AX0GCFt3yEytZ5dyPIUP6NnStffaIIvAR9FrJCMB6dUTpuwBa80iaF59gOu6Lp4
Message-ID: <CA+eMeR2yEa4wsozLP94Zb2gQ67=xhC58PEdOKL8=RzaZotYhSQ@mail.gmail.com>
Subject: Re: [PATCH net] ethernet: alt1: Fix missing DMA mapping tests
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 16/06/2025 19:46, Jakub Kicinski wrote:
> On Mon, 16 Jun 2025 15:59:55 +0200 Thomas Fourier wrote:
>> According to Shuah Khan[1]
> Sorry for a non-technical question -- are you part of some outreach /
> training program? The presentation you linked is from 2013, I wonder
> what made you pick up this particular task.

I am doing a master thesis on static analysis and I am writing a checker
with

Smatch to test if error codes are well-checked.  My supervisor suggested
that

I look at DMA mapping errors checks to see if people were interested in such

patches and because they are quite easy to statically assert.

