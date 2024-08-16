Return-Path: <netdev+bounces-119294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2995514E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE41F22690
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FF1BE861;
	Fri, 16 Aug 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwlTPPgl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE46F30D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836025; cv=none; b=bQrd8biD2brOk/kuELXaUFZJEzj1OC6EWDYayvwJiEsjuaNYRnafH9uXJJg94JNfBpbcGR9Br3q7E1Xb82cuITanFh0bIgauhcrHwGErcXR8c6b03FE0nUA3CdR1vpQmpFjU8wdHNM3wp3TUwzFs1oBYkRbcZnXL8IJrKDY3664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836025; c=relaxed/simple;
	bh=pLGWEDfvmHGrw/lNiSkWqg1cZ7XJg686Wkn8UDJYN48=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=raq+1YhfBpsOG5wqJy6VXYKVeAJNz3dZrQEHZC96VEcZ3p1VmAgfEzJ3Y0kzLfF3xJ4Gak3vTgWgwSe35SaNmRDiXDvBPc/JPo6ENB0ZyWJzYKlvw7+uglLItwVxSfIeUUr7joS7XHHhtVTbSSk3ADymSQH6+x61WjJ0tjghwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwlTPPgl; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-451a0b04f6bso14581091cf.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723836022; x=1724440822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLvkWuacobdtATJUjAsNG3HtQ/VI5iX0pFxIX95DyyM=;
        b=iwlTPPglyj2J01hqwr8D8D4oyjOos5E7JUV1WxUInRwUcrDY5NaE0hTGvAyAttOf5o
         CaNAYabxHca1rXzT8UCimfXCeqFHqxGnoPqkb64ZDfuQLeMcbv0U9+zI0JTYM2DHI8RY
         xW5uIlD34Ry4ajoEcf3GwcjoWJ4oh8yQi0FdW89NJPD4rY039GlW5c2uaSvAOsGxjArj
         n6afDV8DrdKkc2RBLOIIPl5OPlemmDX+m2iMoDn4IpPbzDvRXoToBfvXItqnf2lC9AuM
         43xuElN0QgUR0FXiJlJ+D1NR7bRIZD2bW50t9G+lzMeEgXiUW9SZI7W3WuLic6e7an6k
         ZYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836022; x=1724440822;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLvkWuacobdtATJUjAsNG3HtQ/VI5iX0pFxIX95DyyM=;
        b=D37WeNytUV1+PrBDjMbGe9EVKVAwpSfWrTDXuoHEN59kvdn0/rqPIGznyrJjWTr2vb
         z0fXfFdmr18wZcm8I7N/HkupRFPLcsTqt/bOj34eqcCNBmWx2gGWWqTLxRzjWwH3Horc
         v3QVtbJsPsPXEDdJJHzAUVX+7VgF0EhlmFxvI/dUOoyCcj8BItH6FPWn3yH27TGlFl5e
         5mfmm8bDElbDEvKG427ImO9mZlA/rh/y+mhH0T8ALi0nXcnvLKCKQDr5q9hu5Q8zNvpH
         6u/nxE/RrSR3ZmcvLi329yWIXVVGOgLbZfsQFCkk9aYsZq7mtb1krcAZKvEe9C8qv81l
         0L7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6j266gkEVp6wpppwViu+MJheQdn2JuWOae4yG9K879EZoDmkaDQCPHTcOJwPuyNBIX0cAqyz66mgiyiiY7CZvoFxzVHMb
X-Gm-Message-State: AOJu0YwOKRUSn+QP4S9K/mG+cgkMhKL6SIfHBmXeLx9WCxb+lJxbJK5z
	wwDtOZgTVcaqkTVHvl9Ot9f74qln7qOipjQRAZPVMp8YNqqsmNwG
X-Google-Smtp-Source: AGHT+IH6UESdBYCmR05i2VDzlkZtW0/BioWlb5s/XT+Z7EGOdeP0yfczekg8QzUfV7B/vMmZ2c4dHA==
X-Received: by 2002:a05:622a:2b0f:b0:451:d61a:c8f8 with SMTP id d75a77b69052e-453742a2dadmr44583391cf.27.1723836022539;
        Fri, 16 Aug 2024 12:20:22 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a0795c9sm19448051cf.82.2024.08.16.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:20:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:20:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa675902ff_184d662944b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-8-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-8-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 07/12] flow_dissector: Parse ESP, L2TP, and
 SCTP in UDP
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
> These don't have an encapsulation header so it's fairly easy to
> support them
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

