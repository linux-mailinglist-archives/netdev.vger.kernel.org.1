Return-Path: <netdev+bounces-148631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EC19E2AD7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49445167A40
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE821FBEA7;
	Tue,  3 Dec 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2mDVeSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEED2500C4
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250567; cv=none; b=kv7i6ETUm7iycpbLwUO2Z/37Qb1m4b8ET7XNeHf/gtBDYIURXGw7pGq82cFe4EVFHfi1tHlDH422SOOId79NQDZeeXjinsvJRox3H9ZjA5JGs+zpJhcbE85Ozy5urODLZ0HpHmypBfAe5msW3DBzoJ4QFXCRYtZKfuVHLRKkDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250567; c=relaxed/simple;
	bh=TcXkRMgHuiDoUboNK6dri87PYojRYGSj8u8wGaDm5Yk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eeYi7htb9JGA2W3xnjQkJkKKDGPie8B4jxZH2kvyhPacgaB6EqEroQ9a1S61GApXeZHvwGRJ1MR/rI481g4CbgW20+8oN6FJ2iIEft9s092dq/8wxxcNyFw7P9/Uax8tOZ5CgEKD+zdP6+PNSghDt+INwKdXsWyo2ELZCFG1m4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2mDVeSs; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f25da4f999so505747eaf.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733250565; x=1733855365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qoxy0SQLK77e570UrDk72iTCj4CR4wR7BY9j33VGVWY=;
        b=E2mDVeSsJfsy3+QolAcQpdX0BVDvGPL0fzCkjQbDHU3R2l5eXzSo9dvggBi5RSZ9MC
         2d3aQUBNJaoTvnWrrJPAF/ikqVlShIjz/NMSMhuloZ+uTuyRHAa48g1tNiPUr27As2+K
         XFQXrE6ZIK5vwk2r+8HUpIIeKOJShE5w3mQbmsTTRg/a76MBIlbrDL6VMsgwn8agXUqn
         4D8lIu9B0nUwrdtCAaW5ia9IQ414mkN4GGEHlw2g1gGONW12GQiMmTQi3Ib0u0Ipa30V
         l78MqJUlmrnl6T9oUsD/g0IR/OjfQ1insTDcawqUFW0x49RVkpFTy52mTDdeAIPY4Sol
         DA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250565; x=1733855365;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qoxy0SQLK77e570UrDk72iTCj4CR4wR7BY9j33VGVWY=;
        b=aWL7rackAcEhBP+EPXKxjSndMmbKxNNOlaxetiusBXPI8q4mnpn4hbikIUlpKHcCLs
         HicaziPrdy+EJCVc4E6vFCbJXJ7bDf22vP06TAW6B2jAwxZkepHdqP8Lg4Bc1U6qytaJ
         rvvjcPXcXxGHa6cRsQHdCTOaEJE1gzFGewxuVGn4guEWxGCAs6sXZujv8+Laa5I6z1hK
         4GKKTSQvP3XVPTgUkl9MDoQoosDE54h+HOo+R+V31O/YIqTrA1FGaTJelm1bfFnwGNYV
         L6NfTcrLH3iP3ipuVQm8a8gsjS+jo9qo01lm6w1MVcpNRZHxoidVsbXzqruhQ9mtQGTt
         6Zyw==
X-Gm-Message-State: AOJu0YzimCkivYxvB+qwqace8Zu4P/mr5pimk60tsAyPPwARTxApy1Vp
	yg/PNN8tns1FEudTYysqY7kmJ48+POk42Kuh+ITq7ijZ5yWyTepr
X-Gm-Gg: ASbGncsSqFmGWPG5tohrD2a/Ympe7iRNE0pdYLYRB/NGdTkUfYkF1NAE0LMkYnRoN8V
	obdlu0hDwDkZt7mHior5GGe526zEN86DLAmovvz2ZBWMQaZmIwZioJDbgkgi5FlJjmc7XIRfo4i
	rLDHcTBkC97Eh+B0H0CeuFA1BTLa+vsWZLrZem4esdGrimTaWZtY02y0hrKxaExdmkFFAL4/CZv
	J06/Y22JpGS6d4W3CGVXWJFrI+tDO+y3CbqahCeLDXdbz5VvnHXOkga2H5ctWbnlvfMJdFcuVbL
	Qhlgi67E8lcv3+2pDqXWAA==
X-Google-Smtp-Source: AGHT+IHPJ3121OYZ0xcG9EVaFsSJnU5idyMP8jdR4Wj/46D8G3UhomIaKwCXgmjRWMPDWJKOSSFysw==
X-Received: by 2002:a05:6358:d39c:b0:1c5:e2eb:5aad with SMTP id e5c5f4694b2df-1caeac02f27mr379802855d.20.1733250564886;
        Tue, 03 Dec 2024 10:29:24 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849b6d11sm534565585a.99.2024.12.03.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 10:29:24 -0800 (PST)
Date: Tue, 03 Dec 2024 13:29:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Brian Vazquez <brianvv@google.com>
Message-ID: <674f4e03f0401_2da692949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241203173617.2595451-1-edumazet@google.com>
References: <20241203173617.2595451-1-edumazet@google.com>
Subject: Re: [PATCH net-next] inet: add indirect call wrapper for getfrag()
 calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> UDP send path suffers from one indirect call to ip_generic_getfrag()
> 
> We can use INDIRECT_CALL_1() to avoid it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

