Return-Path: <netdev+bounces-127017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21E973A7B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDA0284CC3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0B199931;
	Tue, 10 Sep 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9cba+8P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CE199FAB
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979585; cv=none; b=ZyeXiDkQMVb9GIjSYa6DpVr2K8lG6CagvZHL532R7/LwtB09rJ4UwT+2HvcgP+CtzeEsS4d5frVoTVxfvh8lM1hUWIBHA2zE55HFvj7kOsWkrmC/AAwtyA2aPf/wU2UwxTU3Efn2Ga7LABC3IlWQPf5ZH5lojZW6/Mt/rM81BZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979585; c=relaxed/simple;
	bh=eZA0INVIaxysifRtQ/js+f8NGdZZ6GaHJWhtEVUb9e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCueRMVuCbOONeOYD4D8OMGdZv8awt5G/Gb3+sHjpDaMcOhJ2H08ubS3q1EMUDRYDLL46JyXw7csMDy1d9IazFyycxheLMp9KDaVUusQvHwHqpzb2RdtZVXmWwe25/XMFDZYXO8Ptid2PiPQIvc3eu/4AwZ+Ijbwekb5Z9pjWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9cba+8P; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374ca7a10d4so3426440f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725979582; x=1726584382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie2tWWuG2E+Q7aPM8G4eDhGSZkXYMPi5r/t8cU74EXs=;
        b=m9cba+8PBk0B5PSgFI9bBe8fTaDXYqzTC4B9vcNx7zEI8AchBIVlgYFFdsM4cwltqj
         2/H652FUjwWEPHYnq9t8CESZF16scWTevaA64v5ZHnkxPmOUkc8kZWL9HYShUqspVyvP
         uRIK1JBZzwAYL2tK8nvZF4mXoXXo4jo346uVwA1UV8pWYafOtTNg/U5g9HiMVHiWyPVW
         2lWBRH1z07G8QGC+XLwj+HfqCKGoTSd+kU8RC6FM6SqhwA/87lHWOT7LlIESludoE31+
         S8mNWtMKXjHWWD0idlFZOZzsyLVBbFxCpW18/bpDJz5BsDneCiBetTcO+nVWwmyqTfuG
         V9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979582; x=1726584382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie2tWWuG2E+Q7aPM8G4eDhGSZkXYMPi5r/t8cU74EXs=;
        b=iLVJQ6T2P8RRDYpYl3rU8GYNPQtAxokthaFIhD96n4DGXU35uTJIb5j3+lceKiWkGB
         Tc3B5VJP3XBLJZUGWswwZRf7P9HfSHqm5tdnXCa2J5S8tuyWApdxtNv5vMFMjP1+oJVj
         1j1WdkomwJen3nuDP/bbVAKP+Nu7sor+y6tbji1FMtk/9dHNkDZAsudPnxqkZsZ0ixk2
         WG/eYHc4W3rKWV6GPGyFQoyf2iB+PUociX76uALTJ2Ob5Jmip5fMCVC/26jXjGbTW+bI
         FB0mpY+VjK228YubsIOV4n1Ccja1i8ytgOCq+iyxze7qbbR2zncVldIpAC0lCWFj2OqF
         SOlw==
X-Forwarded-Encrypted: i=1; AJvYcCWFDUz/v59ldD5/A5MbnRCHROTRdACTAdrJZXUlVY0gU/JCYKoWeJSFgWTEud8+5+n2a3e1pxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbgkUxTk3ZBhk5z1GyACIKP4j2p3RIdmqP2MQk7yRfWdDumMM
	grm1sMjSlJxOUD5ompLEAgVAevGw2myQBD5MeNVckWjAe03JDOG+RFI8rubPxTec/gh78yyzazt
	7+u3cryTyBAH6zwiNwqPOwCiXd6b47OXN/tMU
X-Google-Smtp-Source: AGHT+IFDo0mvgDytpH5FIgETsS5NS0VkC0LwE1ceohat1+4L8zu+UXVBY7Bz+bza4xIrhxdf5+XOjHx5ZC12LMqc5VE=
X-Received: by 2002:adf:f64f:0:b0:374:c977:363 with SMTP id
 ffacd0b85a97d-3789268f0a6mr6431494f8f.24.1725979581832; Tue, 10 Sep 2024
 07:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910143144.1439910-1-sean.anderson@linux.dev>
In-Reply-To: <20240910143144.1439910-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 16:46:09 +0200
Message-ID: <CANn89iJoA5XNOGr6-esswau8VymFHrrpT62+CT=nf4KLuDU-Ag@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:32=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> When sending packets under 60 bytes, up to three bytes of the buffer
> following the data may be leaked. Avoid this by extending all packets to
> ETH_ZLEN, ensuring nothing is leaked in the padding. This bug can be
> reproduced by running
>
>         $ ping -s 11 destination
>
> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

