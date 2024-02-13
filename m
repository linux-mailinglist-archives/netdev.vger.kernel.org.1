Return-Path: <netdev+bounces-71411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1425B853384
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0DD1C276C2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECE57897;
	Tue, 13 Feb 2024 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX6+pRih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35856748
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835670; cv=none; b=BvwSErb488vuMED/tkUpLgMILniTCfyzpdNhv1xH4iUGxYG+24Z852JRkC2K/3zq4RecjtFXpGrO5hL6os9l3txjEY8fHYWZ9gsUwXhckbs8M0i3pI1BV6xezw8tzzDM9uhDzrtTdpCcGJ7pHSVHVtk1uQ0hwjakQt/OjOmAGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835670; c=relaxed/simple;
	bh=vKWhpVbhSijrcpCmmrxwl8hhJ761iK9y8m9/eiVobxc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I6/EyULww1KcgJHInITw/iEjrDNZuEOb2UpZvnYzmWMiK1NSu1xCAr7f7YW8tvBXcXcquIG1mMpaNFZQ1/1xYa5SU28cjPmjKHVMeDLb5IUCLx7e5QMp+NRkPJ3lhXdofU3dE6EVePeI3IXskypnrO8+LOXwCZrTReI8j1PM9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OX6+pRih; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78717221b97so78960585a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707835667; x=1708440467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVUZ7I/jSdraKjFZNF4Ll7YdJ3CF+CJy1oC/eYfVxck=;
        b=OX6+pRihIY5midDlrTWOQZ9eoB+Gs8ESmBPzWY3E9Tyaqhsg4NaX9u6xjyI7YgrHZE
         qWVSgueRQ5c37eywqqvRV7kupQKCGrE+bIHRMzuYEcwj5DLwYq/N/pKj4hs8+hhJnqlb
         KpAOnAuh0KJZttdchYvIrbo4d6m+qkiffBRKDrR5IV2Zm5mjuV5LEI6B8YCENHvfGNN3
         U7oEXCKQ2Vk5daB5XR9tQ6wbeY86CMq+GdVHqHZlMlNha93kWdxuh0LftzCn613H2lQc
         daIDl6FbHM1gKvZ+fJ0FzI/HlN3Mxl+2+Od49I64ZVx1umPOOMUEc0Pu7nMVDHkOkOuC
         78hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835667; x=1708440467;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVUZ7I/jSdraKjFZNF4Ll7YdJ3CF+CJy1oC/eYfVxck=;
        b=g4hV8nDDaZAQPfcXT21ilN0q2G7G/nj0ooY6GJEYIacfWDMsdVL1WwK6QFPo84sIDN
         yuEEaBbCriIzd/44L8ZmQJNPWKeWCMEhW9VomcFd48rR3VegeacBawEVk7ByKo73i507
         hd3aYswhgZV+Fxs6VOj6Q+7O3EAEPIMQqFyS7qyqsPbhGBKGUzqE14UkPlbsmfLxeYYR
         sgvRS14kKyP6gLmdw/7Xe5KGob3eWOwaIO0slWkp20iqjJH3rhAgGu6qERRFfRbgn1yY
         V/d9y9E5W7UhNtuWeIFDFEOnh5HyuFpYNzcXNrWivexrmOKAtWISXtR9/HF+9EEbtbAP
         PvsA==
X-Gm-Message-State: AOJu0YwbmonJh1ecjqcKILBK7WyJQzcDyapuqhCH087Jd8bRpESDhKzW
	5KmV+Pv66OfTxelI6HNWXEoYO+gHtehaIRVTqeUXYgw0xpwJvfK5
X-Google-Smtp-Source: AGHT+IEZtD74nbb6awAX7Ujizc3dxiuCu9/hOCFsvA2J2lOMlgfKz6Rve7Yr+w0x5+HqCiRn47j1Og==
X-Received: by 2002:ad4:5f4c:0:b0:68e:fa14:4653 with SMTP id p12-20020ad45f4c000000b0068efa144653mr650268qvg.6.1707835667616;
        Tue, 13 Feb 2024 06:47:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXc84JAFz+LRSqjYL57t1dGToZhm65q0EWihV4UOL1IykT7y7QK/7NDzm520Fh5pJI4If9Hr25oLTqZ7QfP555LnN8+HSBCp5fRRLKtt84+Q/BONAMMAlsBdqW8piEMFzpr+1SM4v2qbh50LXnEsfqLFiJtS94fh8JYX7Slq7EAJCJXgCwkdhGFbGmAsHJE2iiohGvgEHvNjsiHK8HBvDFORhTQu5ascUeuuCsV8g+TjfsEzUynzxYrNFEQ4XuFXPcTeEgWmAoCYH12zMt2KsvFw==
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id ny7-20020a056214398700b00686ac3226ccsm1300519qvb.114.2024.02.13.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:47:47 -0800 (PST)
Date: Tue, 13 Feb 2024 09:47:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andy Lutomirski <luto@amacapital.net>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <65cb81133b8_2220892948a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240213110428.1681540-1-vadfed@meta.com>
References: <20240213110428.1681540-1-vadfed@meta.com>
Subject: Re: [PATCH net v3] net-timestamp: make sk_tskey more predictable in
 error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
> the sk_tskey can become unpredictable in case of any error happened
> during sendmsg(). Move increment later in the code and make decrement of
> sk_tskey in error path. This solution is still racy in case of multiple
> threads doing snedmsg() over the very same socket in parallel, but still
> makes error path much more predictable.
> 
> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

