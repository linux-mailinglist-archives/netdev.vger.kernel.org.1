Return-Path: <netdev+bounces-179867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A18A7EC86
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3281890F9A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3F257450;
	Mon,  7 Apr 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlgnq9Fr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E1257AD4
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052161; cv=none; b=LzQcW9RFOXTlo4CrmT3lEjttNwq95abF1ErhoARuzOVRK1PnM3juo0RHsLvcMaG7nloejvf6+33jEcSMh6g3cXcpdjUHMak1dn7ejy0E2sMWcCam5QEmlYa9iifi1KbF+XCe7leVhNpfCnfzdx3V2vJQp0ANRnrsbaU/h3ZqYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052161; c=relaxed/simple;
	bh=D5+pVjXuPyWORQJ1vSJJae2tTyVhxZcbuEWK0sIQCCA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Vl0zazfePJZKSml18wVeg8cISvkHvyjN7NGfFP/N6wZNyZb3dmmTo/AxuscRZOu2eecLK9raE0SZ739YkM+PC+h948o6ccOu+xXKNNDlew824BDYCVAjXOi2MoxDOuB6BaFTg6Gxljrv8Ti0bcQCK+VZ+g+bgk+yVxU7lJsezDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlgnq9Fr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0e135e953so454439885a.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052159; x=1744656959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvsaQpNRG1mcebI3JN4ne+mJpL/giJ86nN0tXnCAKIA=;
        b=Rlgnq9Fr/a/tji3Em/Ad59HFIop65q1VVYWmQXNf+GT46dTNg5/syCDRovV7akSml8
         M4/VnwjXhFkUs0Xk0nvZB8qONrjEHsZ14l/B47YS953A5b6jFpptjdRJq9mCZnTpbmsc
         /v6nCadI9xjNu9huq47Rhlw0/vf+CSYfu81y1RlIPNUZ6d75+8azrupDda+n6y0ONSDF
         BjwghLFqEgiAd8larSd1DAwcvZvuwPmGlBt8gvLmP/PBxdgOFlrMBOPBtEJmp2NZfXBr
         c4hw7noGwZG73J061l7Qa2idHWiwWE0E57iGXSytEEKOo6YyJ726UcIs6npWFgnlLLHL
         Lm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052159; x=1744656959;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HvsaQpNRG1mcebI3JN4ne+mJpL/giJ86nN0tXnCAKIA=;
        b=W6Scu61o7lGuq+bzjm575oeVwo+ejy16mczW/a6J8OVZkQbpwjfU4qgQgbAIuoF8Po
         yIbqlAigOxsgFAfmDeAb4fkiQS+1erHd80b/guxNZ9NSu6fkI3H6OxlYI4mBS7BekT28
         hH/iPhvCZYHcWcDXaDOrxdxMIZ2sB7kxxbmdJVITl2J5Cvfcp5qwYQ7QAhp1kKj/e6Ff
         Fz7uf/KnT1v0M0heV9cqNfPNx52At8yFx1QbB+dhjhmnjubMSyNelsezzMF9p17z73Ke
         qikz37toyi1rt8cGn4FAtW4De3wDRFsRM4YqsLb8NvLZsrT9omNyPbmbsTQsSriTOhgB
         i+2g==
X-Forwarded-Encrypted: i=1; AJvYcCXXJznLcWH0HM6PHUKXvJo4VbtxLr9cnBnIryIyjFspv1jhEan9IgDQ+JxeDPBUiiWV21WJeh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ESEIVU2f9MlKoqcCuxaleX/YGC/ZjHsddPDqj0WikvDqjkXp
	//pWzjUnkzqi6C7byGoBjFsITH4VoxArHI6dRhlzIakgfbgmUWCM
X-Gm-Gg: ASbGnctbjfoP2qq63DA+1diAnr0cHkAstb5My0v7+GDP+76EgSCp1iut+akHOchuWCW
	uUe/IFJYFhry0OQFram71FIpPdnxOwvIcdXDDlOlu3logSjEkG98FZTPP6mCFcEu8ntYoHUHtXw
	JodEwHAYLSgPQfhGGMdZ1yHHoRC8mAFeJQ5aVFBizpvqPFVkmuln74sm7Yv8/TFbCO6f/n0AUbv
	TQ5Hd+KjzUbh8Opoidz8ODwvqt0iHMC10JyKYr2CJArLM6I9nk3p+uSip6kbJtBKsFRy8Iw3JS3
	VAmaJOEHrNZmb0pLE4FGho7RiYM1dcgcRE6Arbn6cIBCkkdoagwFTvpS13FUtsv7Lm/+76s6gq2
	PEJYyRki2d0pGzmj98mae4A==
X-Google-Smtp-Source: AGHT+IFCe7+0/ZtD0L6w1C7XQuSla/MhCAnOE29KAaZVVYfEPLAWiTOSksHvJlEULyaalJdrE8Xu3A==
X-Received: by 2002:a05:620a:1a83:b0:7c5:af73:4f72 with SMTP id af79cd13be357-7c77ddeb3b3mr1451179485a.42.1744052158683;
        Mon, 07 Apr 2025 11:55:58 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e96fb3bsm634355385a.65.2025.04.07.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:55:58 -0700 (PDT)
Date: Mon, 07 Apr 2025 14:55:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <67f41fbddfb31_3a74d529487@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250407163602.170356-3-edumazet@google.com>
References: <20250407163602.170356-1-edumazet@google.com>
 <20250407163602.170356-3-edumazet@google.com>
Subject: Re: [PATCH net-next 2/4] net: rps: annotate data-races around (struct
 sd_flow_limit)->count
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
> softnet_seq_show() can read fl->count while another cpu
> updates this field from skb_flow_limit().
> 
> Make this field an 'unsigned int', as its only consumer
> only deals with 32 bit.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

