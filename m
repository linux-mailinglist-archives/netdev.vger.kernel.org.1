Return-Path: <netdev+bounces-188952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9666AAF8C7
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB92D7AFBE6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB622256D;
	Thu,  8 May 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5sZKSHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92056221FA5
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704104; cv=none; b=LNIgL6rO1JSigixXbobexgjQLTJVJ7yulIqDmfWODbAbm8+4zyYDLuJHfXlT9dWMUhYTf74OSDHFD1gZRusMcxx3LqYFh+iftvCrqSxuCezwn6za3BoN2kdr4dxp0MflHhlwKgPuDDCgSpRpnV8TeJe1IPrHdv5Y2Vn1qiNHab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704104; c=relaxed/simple;
	bh=ugl16vbon1G4o2z7qQsi5VcDG/dOM71g7eKjgaRyFuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVpKBeRk86g9IsSlqd40SyJ8cHbADdufiI9s9/lQ0yCT0oO1VxiBrrTbQWImFBtB30Ri2x2c8GYp4cDYDuneqg+7lR95QjUeOB2ecXHNroQSptJiKz/DQeJEtNExbtZtuw6BWIIzh1qG+ziCIJQWr4bRqOuSyI/C/X5zyW+V1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5sZKSHq; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-401be80368fso313908b6e.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746704101; x=1747308901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ugl16vbon1G4o2z7qQsi5VcDG/dOM71g7eKjgaRyFuE=;
        b=T5sZKSHqwIcngTperMEGfOVugbtMgEnaGLD8n+bcQJmwLuzmv0MuzlD21hn27/CAQw
         uIUYHIBjHZ07LBZ0Kw5Yz4VxCeBfO0eTOl0V23hFoQWRcus4qaajfvgN7kUuLbqU7HSs
         Yox3HwLitR/kHORtomV79ac+FoV7JNC73a7DdxSFkB7qtGyEk9lorcJSjt6tyxJMT5CP
         va6ClytK92hTUojucM9L6ovUxzwbyTt+M4D5a2OqQli4CMgtXetDdnadjcrdrwke+s/m
         5ZlccLuwbrJ+x5q5k9llPisR/ZSQhyl1Lzmi32/mcFt3pW8JHcMhk6L76sV8MmNn6Dak
         bZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704101; x=1747308901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugl16vbon1G4o2z7qQsi5VcDG/dOM71g7eKjgaRyFuE=;
        b=hvK5vYiBbSgQwAzB6ikkMCVldeg5Vp2s596fzAwgglY/9VWV0wnHSXUMocaY9Pj/c3
         ezQIBIh2L5SWQ91VHqYJQRfAs3+tK2D9x6+bhc5vh+bH9snmqa+Aw2rOsfy8Dfvmlqx6
         KqU1fzXzk9zhQis0NKxooZIbNWK7VxS3Q2kpSjPieBIsVUHy5cxMuiTYvmw7/7qiVd8i
         AdFROKZW93GXo9AWK7s9a0OYmfKv3YHHjWlwnGWG1qiz4XPMlHZ3s+yybE3APXWCKE5k
         D8zAG4atqTWk+0T4jGA+3Y8JHPUQ48MaV2TgUlYzax3E++m8N/YKTyj5FkcSxVcQICms
         ATUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7KAysADuXyP4WSeuk/HCncBkatezCnm+hTuHho752+ocqW56TbZgBc8eIw3O6pl0LmfRZB3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9u3UQImP7Nk5oPwYsKe56YoQuMBQ8TB3oDUbneCLX1LvHafzK
	l7eKcxn9szZeGXWxDd7++KbWVqDExP8K2Gt/yOOjFxLUVal0HZNeC0xZX7V4ZLFXk6BoTZw9VWB
	9RZsIEKXuKXvrQ4XGZVi5YDJx5P4=
X-Gm-Gg: ASbGncvJr6DmyxKTt/i4/nBkptBbWeG7f6baJI+3WAFDmLwrl0dhWnEXK82sA6hZ2M6
	VAfw1BSSg9e4PbQnvkE+eQJ1kL5lOvx+a3pjr5l8jj4y3OZwu4BZrmcxRJE4OLeG+eZqbZwA6+d
	IK6Juo7WyJShG8COPRy5uhRfxG1NT8UJJpj/OYwg5lYS721sjUQfhk97tBZEnQ7Pc=
X-Google-Smtp-Source: AGHT+IEUSNUjKL2Lkjsl9WAR12Pz2YuGHcXGJt+5O1GAV6x5Pf+krwj23Nm1whMNGAZ7WhlEe68iBGlF5hxd1dnCm0k=
X-Received: by 2002:a05:6808:1796:b0:3f6:7cbe:32a0 with SMTP id
 5614622812f47-4036f067e18mr4031406b6e.4.1746704101591; Thu, 08 May 2025
 04:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508022839.1256059-1-kuba@kernel.org> <20250508022839.1256059-3-kuba@kernel.org>
In-Reply-To: <20250508022839.1256059-3-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 8 May 2025 12:34:50 +0100
X-Gm-Features: ATxdqUE-c3sYcvOI_-Jy6bOCsr38RYBdbgIByhHCt5Pvntf-Rwgo8uQpWke6Qq8
Message-ID: <CAD4GDZz-Qhqnk8U6FZY7zf6wxVuw5TGd6d8A6f-PFUmOQppqfA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tools: ynl-gen: auto-indent else
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 03:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> We auto-indent if statements (increase the indent of the subsequent
> line by 1), do the same thing for else branches without a block.
> There hasn't been any else branches before but we're about to add one.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

