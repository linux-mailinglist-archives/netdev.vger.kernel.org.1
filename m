Return-Path: <netdev+bounces-99678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC98D5CF1
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0411F21CA7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1E13541B;
	Fri, 31 May 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAa/H2Wj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CE14F9FC
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144785; cv=none; b=TkeuLac4BlKtIlx7eamgO665UVdhC5DT/huwy2XLQou/zz0l8Oo+8/rAMLsrVCu5X3rBfUEFYSb0iGx+Ta36T1sb2lujitWG0+tAAe1Eooy7PhSJatehGq1DenT2eXe1/KE0nyErNE4UJpD6ZmkVqHYd9wgZ6VkWkItEe6bGtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144785; c=relaxed/simple;
	bh=w2XfFgYkNyPA7kF+exjPtMJwY4LRkbNNvFZLEyfiqt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSo6D0ZbJ+OJBa3gHTu7OS3ERmLcZzEzSX6jFl7T+7xovmF0w8PbgME7LKM/KesN92X1juLqD/tX2atmC9aAqtHY98T2h8vsMOLOt0O2oJOhbriRXd93A7m1MqBzgfT2LYS9COf6dx6SoWxGceHjkBuQ4COhlXvS/AekPqRPcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAa/H2Wj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso12550a12.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717144782; x=1717749582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2XfFgYkNyPA7kF+exjPtMJwY4LRkbNNvFZLEyfiqt8=;
        b=YAa/H2WjZleYCKD2FIcETtknwX9b1bupHuDznNdAU0MonSF1UKFtnN+uBRMkpR1FUQ
         YPSecxi0LXg8bexta9YRUsV0BWlqhkZLi4FbwvdHa60M9UlYyEtYZLa0CM1oXGvYNA/y
         UeVG4m3z9lCfAY8s5QlCvQb0vMTLonh+GXifshH8qR7RffhwTb72pt0uwE8IukznErNS
         sC8C2VGq8j+LdqhEMy1Erxgd0ISm1BWxCh3luFNN5D4afOqZK+C0+CM94NhtM9YkSdMW
         XviR5mgaLr+sr/P5yfA8Z9kFjjt8PQXZkpsPOjvuCstVf/Cvzxd5YvyfQHtdIPWIcbMs
         XnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144782; x=1717749582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2XfFgYkNyPA7kF+exjPtMJwY4LRkbNNvFZLEyfiqt8=;
        b=unERlVo4IIftwLLrXEiabGbYkcVWZPHjy8lGSm9lQQYfncQ+scBNWU3G42KXvvRmQO
         F4VqeUg/6J8uSJJqJ0UJbIrySyPv5lAV1KhQIVAQ+ipqce+tDjbDUS2XpXVWtgh7b08X
         +XfYerwUMHkztmOwhSIBgFZUpPcv5vhKChh8x5V0tXSqizJCg0nmxvBrclOHVJcClnSO
         3dPxQei2R53CabQ5Nc82d5hsH0EbH+uAHX03RG0jcdYi8rL/vRlXrew1PJW5wn12EUyb
         g0bq7Dan5j31hBXse3mPTk95P6+4xmH7xYgQQ6AAAbz3KP59CoiHq69GtUhlAiWQcUM7
         Z2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoOpDmfKnSanZbYxaNNHFH77Tjk4K9UUyeAFnQSlZJvGa7IB4mqnd3BvEzI2kHH24/0Cdi/kIM1Jy3gDQRpMRHYwRYomKn
X-Gm-Message-State: AOJu0YyN+wjNvwzwZ23ZtYdXZT4UrF/guM+WX/sWXbAW2ew/fkibkyFs
	Zcm4gsCaegBSTF8A17AZfbdAMTyQb2NGWrS+ezdktn+jHs+dWVU9xOdb4Csto+SXDYcmI2O1hQi
	6KdVy4MQHcFDHKJHEZ+txk8fE0Axq5od+Zt/S
X-Google-Smtp-Source: AGHT+IGlC91skef0biZl0B5CqJE/E+DT3EStbl/d8M0bH8al4aAVUvkkc8cVz+c4T7kFsfNzVxOP5+mW0rVsbqTUJd4=
X-Received: by 2002:aa7:c457:0:b0:57a:1937:e2a4 with SMTP id
 4fb4d7f45d1cf-57a37857d33mr75492a12.3.1717144781580; Fri, 31 May 2024
 01:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530233616.85897-1-kuba@kernel.org> <20240530233616.85897-3-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:39:30 +0200
Message-ID: <CANn89iLMeZA2BAcCu8Ew6pocifddX3ddGKEZ75Zd=W6YTTcMng@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	borisp@nvidia.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> TLS (and hopefully soon PSP will) use EOR to prevent skbs
> with different decrypted state from getting merged, without
> adding new tests to the skb handling. In both cases once
> the connection switches to an "encrypted" state, all subsequent
> skbs will be encrypted, so a single "EOR fence" is sufficient
> to prevent mixing.
>
> Add a helper for setting the EOR bit, to make this arrangement
> more explicit.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

