Return-Path: <netdev+bounces-114988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84F944D93
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7671F237AE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6F16F267;
	Thu,  1 Aug 2024 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9r8WWj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821513C8F5
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520996; cv=none; b=hO9p6xnnoDFO0uzMdFc44lW6KsM6vZVyvv2uVaBpzBxnZxOM0aP/RxE58F87Sfoe6ovaTj8tnICnjZ5uxnhqP7b94FoM8aDpv32Ek7Hgm19K+czz5k3O9XVMp4tKgKAyDHEYyKk6zD9Ws4lZajQ8E44ssu6nAPGS3xBBgc23QtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520996; c=relaxed/simple;
	bh=xy3E0My4ihkz9DQv1kaCMoM3Hp8BLGYWoRI4oSSAUbo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oDuao06vy7Pj4pCKEKIeZ12w7lps9elQgnot6fB5EfQT0CjXJOW71/gtUTR+P876uJkBZpEnHI8HV5W+n/XQefeIQRqALRDtVvVPInKo3h+pceJ+JFZEnMrNyKzeY/cvLcobPBhHzXmGuf6RWSRHj4zCEGcIJte6lretPEVSfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9r8WWj1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so41033226d6.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520994; x=1723125794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFmhegINDclonjBJHvuyx3Dvk5wbxRSj40UTEuN6kGk=;
        b=P9r8WWj1+1DFhi/KV3YaZ9+x2Gn5Mc7r7jaF5/4LrSLrEKBh38cp9z3MZ1qIGlHMIo
         hhvYNb8mKsoIJIWAcAzOe7nGCvanwYfy71R7R1nvfpJo4tTOw1PWMilZ8BHXFvO9Y0DK
         OYp6eGNKOdCZmdnShNDxJXyCIqsaTbT+e0jPS25Qk7HcAx5ACFm8ND0coNGfzHxdGn1W
         Zi5r0rab38yfBnO2ZICkP0tJQCRd2BurpIAxikuhEl+4tyPdOydRRtsOjXBUxjRQFSB3
         mVHxukEo4RXOljvQ90SLh7LOOcahTUPuo5zdzwfEOaNr3QTCc4RERXXPRrPRGWEUmmRe
         rQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520994; x=1723125794;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFmhegINDclonjBJHvuyx3Dvk5wbxRSj40UTEuN6kGk=;
        b=No+ma5EpmUKBr4V6AHDplnQvvhHCGrdC2ur5fzgYwARSA5HYRbn5KzwqN8EXokd29T
         AF3w1oPduGXMi/c4kiT7nJqylHf/FbvT6NGLzyCLqsT+edo96ZetWUdfZkLSC0q+kMBq
         wGt8zd1OsdeQa6SZQMNV1hkuCdZnU7HOuWs5ot1A75E4ZhvjetMfUXXPMTragh7GwBuB
         uq12S5klhy/BO0YT5Jm/9shhXPVyHi4HSc9IUE97WdlaDVzvISNN7HNosRuR3m03pqlR
         8sciho9hsRfAbeoBjtTA22syYng9+H0+m6aUx5TerpCtrjR1tpBH1B984f4iuyIF+hFY
         vOIA==
X-Forwarded-Encrypted: i=1; AJvYcCVXD4N/2iCVCI9IZOWEM45DF1yqHYXzubDzXwe9HQHvJjae5Bq5N4QMv8CxZgtDO5YVj+Hl6RdFkJqbUbqZsqCr8Ep8WJm+
X-Gm-Message-State: AOJu0YwWkQwSP7ViwrbnSr+OTTPD+n96PhtbHo9nWnBQ9T+708xFDJUl
	Xk2+bqLofrb3OkSAW1GMjSiHhtHoxDHoHWSJvEs7RCYcvbJPqhwEJzrKyw==
X-Google-Smtp-Source: AGHT+IGtWzZxaBWZZs6YYO4QOIz+mC+AaZzg/+9sfGBKlodVd9dh7+RBzcNEn/cQlIO7lJ1ZXru+vg==
X-Received: by 2002:a05:6214:4486:b0:6b9:5c1a:f737 with SMTP id 6a1803df08f44-6bb984bb758mr1405006d6.51.1722520993621;
        Thu, 01 Aug 2024 07:03:13 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8fccc8sm85551866d6.46.2024.08.01.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:03:12 -0700 (PDT)
Date: Thu, 01 Aug 2024 10:03:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab95a06703b_2441da2944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-9-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-9-tom@herbertland.com>
Subject: Re: [PATCH 08/12] flow_dissector: Parse foo-over-udp (FOU)
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
> Parse FOU by getting the FOU protocol from the matching socket.
> This includes moving "struct fou" and "fou_from_sock" to fou.h
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Will look at the other protocol handlers later.

