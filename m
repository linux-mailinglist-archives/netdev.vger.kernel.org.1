Return-Path: <netdev+bounces-119297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17981955174
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A788CB22E9D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591AC1C3F12;
	Fri, 16 Aug 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8i81S61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80378C7D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836481; cv=none; b=Ta/v+5t1seVdh3c5ys0iFsSHoUm5SK6Baau1iXvHbWOsl2WpfNWKa5IRW2vIoH0FvBf9a75IkP/y4riXzqRt9nHv7jqm8Lz15nI1cCJ3ETTrGgGOgx3dE71wKCLTMPSMOuokkBWYGaXGetNPmbtm1pVymy/SyEmpPSzZ9GdyiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836481; c=relaxed/simple;
	bh=L5zM2BpH+IY+s6uxI/576soaaUWpoK2VY4AoIM3B6z8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Xm6dczMqlAGqiYu76QkMkFqSwefIta/5GsJzFD08AV92K425NaTpn+cP7TCtgbUP+9LVO0Dc8wDWXT1w3oD6uOAxDoDcGPsr1zBKkfN9kkgNcYPWUNCNEqikeXRJZJDBcHb3nxKS5VHbs6GCrdXpdTVXYNNJiyoyyYBIfwUfOYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8i81S61; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5daa683b298so234930eaf.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723836479; x=1724441279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKMcp2+WtbBJ7ho7u8/Gyh3X44zwF1j9QKz/GwWEY3Q=;
        b=J8i81S61ihL8tpvAJLGvOrViQ319BDIcJrwOzZowvnpcDrQAazbDS9NFd7E/5mIF0L
         OGHSSoz5x1vnATF6D0mvyMZlPMlF2o9JQEBvZrwDrae5appxyBObLDUAUaWvXKxQAPcD
         Yk3lyFHsDUPHRsgR30rDCiO4dE3MU1t9Uub8jo0IeUHleTQlWR7LBERKCSb/OwlMykyn
         yw/LIclujXe9nEXAFm8lopA/Y7jC+w0UPHJCvRl1Pz4XTIMoM4Rx7CVshbCm13A7Oy6V
         3F/gS4P7jBPf9d1tQR71kkVZsWqXJrCnPFpLCVkDCQKuYj61mC+wtNMR0MAJ3avJU2iY
         1SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836479; x=1724441279;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qKMcp2+WtbBJ7ho7u8/Gyh3X44zwF1j9QKz/GwWEY3Q=;
        b=EUxAI0V5ETNYaPeQVvquV3zBvfQTJz3f0LZfYP8Xb4HpTdvrzUbIyosXgk9S0wzQjc
         Sr+mCUb3lriHpmCIJSNhOrvOqXzhGBOCAbhS+fPpDphKiEz6WFrtsevNzowUYjfLm1l3
         zuNSluAAAjPX7SU82XJI2RR69M1f8CO2/QyGQgZhqE7HAEjv2g+BR/zfv8QJlLoDcvYx
         pmMi8OUpKPYgppdq91orMXxmwXDCOSsbIiOYwHaVJMkot6H6hKWWtSQiJLkSSBi3PP16
         OPRs6CJ9OZKw4NKO4/ZU5enFYEbKMN+QNAuGsYLN2TFUks9yjRqFndxn5HLmlC1Q5K7p
         twzg==
X-Forwarded-Encrypted: i=1; AJvYcCUY52SN4ueCOavAxp7Fsvr8MqiKYw1YlAAv2XqLO0QDwDXS/aBVkhXRkYhACrMWAYk3BRC3E73IixACyZBPxLxq3aSaV2kf
X-Gm-Message-State: AOJu0YyZ77DMVdGfiIaRvYiV9XhJGZqzsXq5vKZ/2KIZPWce6zngXy8o
	NxqFxlJZDMsMHi6DCLyIiaS2V4ftw4ky8DIfg1Z9/QtlH1bsC7wn
X-Google-Smtp-Source: AGHT+IFSKHyv42nJ+y/PDgrQ7f2QJSgehybNkbHfEJmBllxcYCao7unkVYzPDXV13YxMXy4xD35yBg==
X-Received: by 2002:a05:6358:99a0:b0:1ac:f2c7:eaad with SMTP id e5c5f4694b2df-1b39312e27bmr509863055d.5.1723836478817;
        Fri, 16 Aug 2024 12:27:58 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff051635sm209601485a.31.2024.08.16.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:27:58 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:27:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa83e9575_189fc829483@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-11-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-11-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 10/12] gtp: Move gtp_parse_exthdrs into
 net/gtp.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> gtp_parse_exthdrs is a generic function, move into a header file
> so we can call it outside of the GTP driver (specifically, we can
> call it from flow dissector)
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

For this and next patch probably directly Cc: the GTP maintainers.

That said,

Reviewed-by: Willem de Bruijn <willemb@google.com>

