Return-Path: <netdev+bounces-162105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADC4A25CFB
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB416706F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7020D51D;
	Mon,  3 Feb 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br8nzwO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09C20D506
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593018; cv=none; b=GfarpXbkgFqz/nuB0NB7dz3xRVFZnZ0Pt/V8HF2fzHk8MUfP0jIMCZBBEAkOm0YU97Y9KpeT3h1B4gLEod1YZxZAZbDUOH9JiKghwwNo4v+wXAZpqNXmjyJsdbNT46IubJ85dsYadwA/FCoQl0mWN7zUO9VoyurHNJziXu84gbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593018; c=relaxed/simple;
	bh=owT4tXNUJD2dzaRDTQsOUz4MD0UNZDvWb7Ie+NpMJtg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CwcjKjNEFVBeZksklbfQ7VRJg6ffotQfy6VHkgubZEuxfeIVQO0FV1CCvDREXL5Tg8iNCFwa044Dmo9E0r3TfX+qJdUsrcOWGQJBqga2VNcvuWjlFK85v3yHX3p6KR0oQd1CgiIBPlayaUGX+V+PNXadzqjLOjnsU22UB4SiNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br8nzwO7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46c7855df10so78324951cf.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738593016; x=1739197816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyo16RkUGcG08xfhOCw/x3sdFIb7wxWRzxIF20aI50M=;
        b=br8nzwO7XSrWrRPZe5+VpYp3pT881v8gq1VM/HFQEm5r8m3IGM8XuY1N9Iy/zkLISE
         G9aRyC/yYGy6W7U8dWJFj24bsVUrVOA4r5k5hiwC8egw/bYOqJ+ihC6w8oUqtngZyBut
         MYYvT0TtcOXgj4ciR6F+z+VKUBF4BoM+vrA+4FK7d6S+8XuIzfLuc34M/jW1q22okrTa
         P1+RlVd+jf49RuJRipXypE0JF66FxEvPYl9j0GkGfBz4kFdWZqNwjjqrKcU8TddumK7z
         AOomUZUuLzBcYTT/2HhvEVJpUEu51W9aUhNEKB0J0ajvukAuuh5/2c2MTs/Ea9hUMSUG
         wnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593016; x=1739197816;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tyo16RkUGcG08xfhOCw/x3sdFIb7wxWRzxIF20aI50M=;
        b=W4mE6CmS+K/oLrFVNHJR6RBRpafdMiNqWpjs5L1+gIaTaKcZGuRGDjJ2MbyaGXqHGs
         SB7aFc9dWkBJ4pYO9uORXjQnb5GbU7QYs/WFyIZUTRuvxosRiUkN1mWU4v539zyO7eY5
         hbiC59I1NiEQugABim5ae63oDQOnxtNGG8Fv8zkWBY1TUvH0851cRYZZVkZiKLp4PrFB
         RRH+ALBgCT+DCUj6MbJH8j/lDAGwqMO1eemdplSsj3Jnb6eeKOR/3Yj7sSFMd9HRN8+K
         t6NbND0R6+LY6nigyjU5qwLlDRfb5o6ut2LWsI2TIjGkM0zW7dj8D6gBha2gEtdY0OD+
         lg8A==
X-Forwarded-Encrypted: i=1; AJvYcCVgYKit+eWCwR1gMKQvanGT7C1VxARPbTFuyNqyUGF6UokBdaF/BXIY+ysy/o9v3e3TtPSyuJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/N5XvYRS/ehq3N/N3JJvz2rG6Xu7jdW79eTaHz7sbefchTekS
	tenl4J48WhRaENgGgCQ9CZFPk0GT/kjepacOLm1DX3bWN2bwW8Jg
X-Gm-Gg: ASbGnculyB+MF/e81MoJOMEQDHw7asaykPo34w6Cu9Yksre7TTI9wpEP29UPHd0cYsN
	l8MOn5UA4iUWlJXnie+n3o5E4hWjKSzSNGv/LVk3AZcuHulTKpCE1yMxgbJnncbfxKNPQ/7B6hF
	hWuHfnXPppZ+1PC/EORaUsjQaFtQ7mC9P+8uX7ap+usrYih1M4Mx4l7EARo02pz0Iy7ejsGmB5r
	UQYd3OOUxh75ovEZ5Hkb30yTspf+/depOin9zvNUsElUzGVsX1IqFnkUP08wHOpzsDghcMrt/fH
	vwohz4ycfmVtrsCrd+JhWB0Hvd8JWzm7Iq54WIzRef8mGlyIOaXbI4xmbYIXjLA=
X-Google-Smtp-Source: AGHT+IHg7fyctS2SZ5JtVN2/wwDFt3yKZvJjINhk2VpPpAgtKFkMEv2hafS3G//VQi4BN0/T2iJ+tQ==
X-Received: by 2002:a05:622a:181e:b0:467:6486:beea with SMTP id d75a77b69052e-46fd0b6dfb7mr343596341cf.38.1738593015620;
        Mon, 03 Feb 2025 06:30:15 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf172bc4sm49076801cf.58.2025.02.03.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:30:15 -0800 (PST)
Date: Mon, 03 Feb 2025 09:30:14 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 kuniyu@amazon.com, 
 willemb@google.com
Message-ID: <67a0d2f6a14a1_8d5e29431@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250203105408.GD234677@kernel.org>
References: <20250202014728.1005003-1-kuba@kernel.org>
 <20250202014728.1005003-3-kuba@kernel.org>
 <20250203105408.GD234677@kernel.org>
Subject: Re: [PATCH net 2/3] MAINTAINERS: add a general entry for BSD sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Horman wrote:
> On Sat, Feb 01, 2025 at 05:47:27PM -0800, Jakub Kicinski wrote:
> > Create a MAINTAINERS entry for BSD sockets. List the top 3
> 
> 4?
> 
> > reviewers as maintainers. The entry is meant to cover core
> > socket code (of which there isn't much) but also reviews
> > of any new socket families.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

