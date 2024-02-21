Return-Path: <netdev+bounces-73592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335E85D3C3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC27D1F24B23
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789553D0BF;
	Wed, 21 Feb 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSDDjczh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC73C496
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508263; cv=none; b=RXAgin75xAOIh9T5KV7hsbgv5Hi/PF/Qw6vomRHfenQXmzhL3YoNroOxhfVVAcUdn5Det43BS7U2ngKvY8hGCE2ituoUkzzWeo3dBECiQMr4j/gLT4kyGnWmymfU5McZP/d6bAi79WNggJTyMFQm+rttZiqvbk2SA2QRkg0Zl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508263; c=relaxed/simple;
	bh=gpb88YLQfi1KxGkLkS3Oksp4Tb27VmbzgMQ5fyzQ3QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBA6VCSKxES/bYw+cJ9NjjCgv/SFAuu4dmljN7sXY5GQZSb64u8siFWLqHA1f8u1rTkjpkqVv+BDurGv8LUTeyNXRnbOL9RFX0KFOkQ+7xgPdQ3xCCMY0xzeZtCvqb6diGsSGv+TiFtl4HswdDHke5aYMKlDMqpTnyQIDjVHdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSDDjczh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso6071a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708508260; x=1709113060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpb88YLQfi1KxGkLkS3Oksp4Tb27VmbzgMQ5fyzQ3QI=;
        b=hSDDjczh/1bQxEwZbo2hk1FBkRJM5vI+s616tu1pmNaF9JboTPucvfcB6KEnfw1YDD
         2IyJ5sM97pTlxnEXHxW+Jy64g3hN3d2Ekoz7Jo+Q/N3Qr9m9behAEF87Le2inAMdBYP1
         KY28M1I43lS5BVvDYVPzs+k+hcGxY3bJxn4MUfghbCB21vByUR38iaRV+d8UKXYWFq8H
         T8NdU68aCQUT+qeZnwC5eC1SvWYP0WTZYt15J3nuT16cUa8UjtIMZ62r7ONlR5hQQPol
         OW0IH/CFj0qI35gAaR/jLIthvuvpMsMlIdaRqni3ra2roWyU+FSQ3vjDn2QHAgatyLk6
         iYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508260; x=1709113060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpb88YLQfi1KxGkLkS3Oksp4Tb27VmbzgMQ5fyzQ3QI=;
        b=KUqcMoyI4J7vrqsGrNdiRXKCHTCAa6o5cT4ebqDajQcMIzmNMBMg2lpr7QISf2EtHv
         VkN4SgkiYU2qzJC2vMNvaYoty0GSKIHTZD/tTBbU/rUz32ZnTRobsYbCWPUgShzxP6Yl
         5/1l5D34R0zWWVFJDbFFswi0sW/92itKIyQOmXX3lL40skFeNm2goR5M+xEwOtzYZQsG
         tUTGn0qPnnGNS8rArI5KofcfTX8tPlv5Hln0FMNNWpbmpUAUIjplmcfe0NY5gaq9AiVj
         JW5LkqnnMGcfwxZsESYtY6yDUfX4liArBDvlu17JZTUi8bawDhgIDRsDH4/jnfpbbS8A
         9DeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk7gw7r+mL90QXMsHXHi6+qzyw5mWzBvG6hDuBlXgoZYkwtjN5NzCq/6f2Mxrsr+XbuYsmnau6exHTYtolLcWq8qwCoqFj
X-Gm-Message-State: AOJu0YwjssZ0wDZC5t/DBE2mk9zLF7nPZ3wldAA6Hzv01WWbmZG/Z3f3
	ZVDdAZRw7AE2iJhrb1DfSBwl/Ikg/qJBDnPtoMiMRvn8xAnW6rNDwQ2st8jj62k8Eg6SzHn6DIy
	9yAQnrvHF6gPYl9P2EN0cIXiJE9SN6AyzewGh
X-Google-Smtp-Source: AGHT+IFkWyFvpdpU4Jc8sMmjvK9RoZUXSNEN9Cm1ET6Ba2tebgQQ9cG2sxq2qc7WTEvqfjyorLD++DYjUBarWjRRdbM=
X-Received: by 2002:a50:9feb:0:b0:562:a438:47ff with SMTP id
 c98-20020a509feb000000b00562a43847ffmr133590edf.6.1708508259930; Wed, 21 Feb
 2024 01:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 10:37:28 +0100
Message-ID: <CANn89i+b+bYqX0aVv9KtSm=nLmEQznamZmqaOzfqtJm_ux9JBw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/11] tcp: use drop reasons in cookie check
 for ipv6
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like what I did to ipv4 mode, refine this part: adding more drop
> reasons for better tracing.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

