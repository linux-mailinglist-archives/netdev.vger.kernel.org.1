Return-Path: <netdev+bounces-211683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2BB1B23F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F1C7A29F8
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D9238C04;
	Tue,  5 Aug 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR0Xu4AX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29FA41;
	Tue,  5 Aug 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390906; cv=none; b=a/PY3QqgdMxWgkhc8fclNQAIXcYSUSnBoBwvMIwjJMpAgvKYRs2kQIrhZur/ya00j4SZDZajuWZo6ev/WOToyhOKtrd8UjfR5itWiTY3iAFMzU0UmjjHS68s7aqNhOo0aNT/CEIIJh1YgvSwKMp8fpvrvyybS5e2o1eU6F1jdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390906; c=relaxed/simple;
	bh=WGVS5ezly+moX5D6PQd+oukCd6IzVK1WbUbYtvId5HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIdtuspRLOUtkfEg8vXH7D6tOMFFQ+jEikomIIu5DM0hD+AZ5h4CyzohGdeiZ7VMg4enpQfnOKBc+sr+zA21E3PcoUNd0Hc0aKH6Re8T4y65Y4Ee2Ouay7ieCwek/WtDODQhuUa6RMGyizSJ0wM7VEDRuuRuV3PgRiyQBAMlNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR0Xu4AX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459d40d16bdso15135895e9.0;
        Tue, 05 Aug 2025 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754390903; x=1754995703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eFjhrBEqlkaveJaCgIwUUbswLHsCvi6mC7lTuJNEgrA=;
        b=QR0Xu4AX8hXfCZbdRiMucEeOi0JQaUNLcubwGSxQVI77OGITcVMXLF4cGOH8Xd0wTh
         cebYBxQVAo5k2vmCoywBIwdsBD4ZM8iUKYSUOKjkKLLOXiLMJCZUho34BnlSmqSDr0Gy
         rXSvkmGGbFSz0AGDfBWJhKSagKFIk4EEpQP+R6Br0Ue6AFkBgSs4TTUfAteYeU6DMGvm
         ADVqpOdXCKC1XErHvAaO3TdMqaurWte2uovwcFAC+x6a6hlEW6rpQtmmLwSVwwRRuZGY
         +6fazUQrHOYED1IVXnAOo2thoXzgJ/KYduY4fpH+Dyl7GqRM2J64iZsTTaU9iJFz3ePA
         YwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390903; x=1754995703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFjhrBEqlkaveJaCgIwUUbswLHsCvi6mC7lTuJNEgrA=;
        b=H3/FZHfEctyI0omeHnnDoXUnr9MmdL68CToOYjTKt8oo2nKZjIDQ11v+JZ2O5sGTbK
         7EvvSOoJfOQYLeyj1MXX9PVVCBoDxDib+f5wvchP4n8MSc+nhjSq7KAXMO8doSOYHDXi
         bOR1zS4jR6BHTbQcNDW9fxzKU9DnwrXq73OQ6z6fXZPraRisjV8u9CbBLqT+e57jyuuj
         b+Y1IZEm1SweSU1rTwlp/VIO4BkDr984/fVatk7BulccoXN9vhd5uCaNZGaBHGiVOswy
         aNbIz6MSIdzBb4OXe+rufnANHZNaufKP+E+oG1gw9AYivvOf33y8Hc5KWFwKuECmAR21
         EPrw==
X-Forwarded-Encrypted: i=1; AJvYcCUVCZTPMzvEcvVGDMzabqhAKYA/zXrLFmXF9mWQiFA1YcrjXQdOpQBg4Bp5OPK9jYCxjCySRH1INwTwy84U@vger.kernel.org, AJvYcCUmUo6UNNBJe6xGPxehogg5uo1aCmmnGpTduBAA13IYQFBCe636woMuHzm0GjRcCIAPmQo1bZyrV79G@vger.kernel.org, AJvYcCWJ6+WecCYMiIEzLDMkH/CWJIrQ6f/q9QSoxmFScBiY525ShE/LoTBL+ZDPFbALH2Y/aXeG5nM3@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpzZ6nOWWo7OYbr33lPRnBeuHGACSyiVCD4vs2mmHzz4E9Igl
	jz9UEbo0hnLW5t13/GMtmuoRcjdzYDWgyftcDPZJ6nG5JBEi0Ot9J+9O
X-Gm-Gg: ASbGncvi+TbYDnjCQqk0pDTBrUoy2bbm8woErV7IyFiGHWzhRX+cm1xDJFHNKaAEfmn
	PDohG98ERL+Ht+NYW0CDq+7wgyRp2DKKhgIAU68rEOs6JN7cs/3pjQd+at4Je8Yt59wtFwFu1Xa
	E+q3AuVa7S6MYIWeI9+domlVjvnhYipj/Aq6F5EEtrhzcwlXJk6VS65rrrUJIvuzi5d7XfJXBJm
	QMPg6TQwe390F621hmQqOahm26+lgq+Pl40PuLeoVglwQPH0zYBA3adbpw3bF3MQJBs17I4Uvtm
	F6iJPObC8B9pIyPG1BzMk4gvxClYbz0S4Z0+wwxFxXKtQBww9MaFFexqu/KERCGgcpu/DVOuf2r
	9SK6agxx1hcAO4w==
X-Google-Smtp-Source: AGHT+IEp1B/j8vOHbyW62rr111CZYVZiRClUs66HrVgWJ37G/YiM74ESAOC0+IZA231Mi/D4WOjiVA==
X-Received: by 2002:a05:600c:4505:b0:458:b4a6:19e9 with SMTP id 5b1f17b1804b1-458b6a03d43mr102866165e9.13.1754390902838;
        Tue, 05 Aug 2025 03:48:22 -0700 (PDT)
Received: from nsa ([91.205.230.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e3315a74sm15225375e9.6.2025.08.05.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:48:22 -0700 (PDT)
Date: Tue, 5 Aug 2025 11:48:39 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Cedric Encarnacion <cedricjustine.encarnacion@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
Message-ID: <mjeyywrkyhvhhm3v34ys4kgtn4milx3ge65ztdmxh4qovllo3s@lfzjtyysg447>
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
 <20250801131647.316347ed@kernel.org>
 <895ad082-bc6f-48e3-ae1c-29675ff0e949@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <895ad082-bc6f-48e3-ae1c-29675ff0e949@linaro.org>

On Sat, Aug 02, 2025 at 09:43:13AM +0200, Krzysztof Kozlowski wrote:
> On 01/08/2025 22:16, Jakub Kicinski wrote:
> > On Thu, 24 Jul 2025 13:37:59 +0200 Krzysztof Kozlowski wrote:
> >> Marcelo Schmitt, could you confirm that you are okay (or not) with this?
> > 
> > Doesn't look like Marcelo is responding, Marcelo?
> 
> 
> Maybe we should just remove support for these Analog devices?
> 
> Cc two more recent addresses from analog.com.
> 

Oh sorry, somehow I missed this one! Feel me free to add me...

I'll ping Marcelo internally.

- Nuno Sá


