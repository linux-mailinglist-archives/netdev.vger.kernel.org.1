Return-Path: <netdev+bounces-131252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D279A98DD06
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC53286D82
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3161D0B82;
	Wed,  2 Oct 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8YKaRd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E61D0B87
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880112; cv=none; b=o56qJYKa2fO4LkOCE4pdEI92+qyqvhRTBPV09THYCVp/IowoPjghgcwRUbUBivkZdV/g0eTBVIt6y2b6oFsrWRlPbaYa8n/u9drfruR8hJF5Tuo9ekGDYopz+avvD2VfOpUDfGOheRcsE3vCg6J0gBPZbDKwUcUgLCJ8uGpnks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880112; c=relaxed/simple;
	bh=ulb3R5Wfk7/ubPSlaFlhZCU4V6Gp2LxB7njIRKnYloM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfpBU8LIA/AiBdwBqvoIv+9i8HZA1JGAfWTxEN4a44x/kGfYBFUQq18lDewwvb2v8ATx2oFfBiMuudbdc4sWMTrURZGcS66z1WWwyLVjw4OMi8Lw6lfxkz9YfJVILJ4W5HgEopyrdR7nFBU8yk1eB0psjqs2cs1S3xzjvZ/NA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8YKaRd0; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso43996521fa.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727880109; x=1728484909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulb3R5Wfk7/ubPSlaFlhZCU4V6Gp2LxB7njIRKnYloM=;
        b=C8YKaRd0rRrrqyi0SSn37dBvCt6yL9iu6RR1XcZUD1wKiKXzeM39lvN8rhTFD1zOSQ
         tNkypuwf/kbtAfPIAEKnBoDkJO1Y+1c6sjan2/ibyPgHE4iPELiq0a/PscGyEvLMmYpS
         hF/kU9HkCW0/+gcZNstoqxls/qWMQkNm2S8P1sQekzNZInOlKa5qNXHRsuwzDW64aPD8
         baAZXb1WtUUnCXvovjhBcII/oaoPZY4GHz2BA5Sj6Sl3ANr6xQGZJGxKpFxq9/O+yESd
         cTypZcxqeH10wtFsKM4d3VjbbxMHNBn/BbQazL/9zn5x5xZWBS/JYLZRjZh8PqHXsBI7
         Bn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880109; x=1728484909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulb3R5Wfk7/ubPSlaFlhZCU4V6Gp2LxB7njIRKnYloM=;
        b=YBgBOsumFfp1DiLOW0PqTlmu68I4DnxZHi7x7KNQeXoRNv5LbCBAokA8hsLX7Zc/7p
         SK7+xw2kS48IZvGiu1OpnElku5tOkxvt+BIaYEQ+zDbCx6aM24C2gEQCWT/jfk/ofrL2
         p16REodAQ3pnVStpl94O7ehWNRLPT4qxyqBHamAVBRWFIi5MOHqCBr/QXehuckl/uBp7
         k+mrIvina+u5dGrgzDixrGH1T3x73s4/Gck5qyPrRBZzdKDfirXeLIFRNVIeQgNl72yk
         wllpmL3HPcdyqwcqVjwDD0SHo2FY3huxllwkc9QQbnq4k8JY39MI0AzTeO5hGf8YvzwO
         u5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjr2LgLFTW6aZa7r+nvb0LiDOvyalpxaD0Eejq/NV5lwlUdnmrp3o16u9mvpA7Vx+e92qJyhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnH8My0DA2jRdgW7vC3dNsVX7R5QefUXa4ht7o6U/gjShRje/
	RAQjtssivvRErVq7AMbzEgUD/BQaz4pEdyDBwni7FdbY0Ax7707VgYRQS0uLASemJE3A058ehnd
	1kMnOvyLJMMpdBgovsBtAbdFpfLyRLAaOcG8M
X-Google-Smtp-Source: AGHT+IGyuL2o/MknenVgF1lAABe9b/kTAQZt3zG2i1PYFGkUcadVLtLkBU77pk1O0Ev1wH7hXvbAkcQKVEkkB/IhGZs=
X-Received: by 2002:a2e:be13:0:b0:2fa:e4d0:eb61 with SMTP id
 38308e7fff4ca-2fae4d0edccmr13111291fa.32.1727880108666; Wed, 02 Oct 2024
 07:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001193352.151102-1-yyyynoom@gmail.com> <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
In-Reply-To: <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 16:41:34 +0200
Message-ID: <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org, 
	James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:47=E2=80=AFPM Moon Yeounsu <yyyynoom@gmail.com> wr=
ote:
>
> Moon is stupid. He doesn't understand what's going on. It makes me upset.
>
> https://lore.kernel.org/netdev/20240919145609.GF1571683@kernel.org/
>
> Simon did the best effort for him, but he didn't remember that.
>
> Please don't reply to this careless patch.
>
> Replies to me to remember all the maintainer's dedication and thoughtfuln=
ess and to take this to heart.
>
> Before I send the patch, I'll check it again and again. And fix the subje=
ct `net` to `net-next`.
>
> I'm very very disappointed to myself :(

LOCKDEP is more powerful than sparse, I would not bother with this at all.

