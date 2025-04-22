Return-Path: <netdev+bounces-184905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC9A97AB9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77AA1B6206D
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42342C259B;
	Tue, 22 Apr 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fODXLTCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B81EE7DD;
	Tue, 22 Apr 2025 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362449; cv=none; b=RhPBGEK8lmj1i/atRR2GgNjZKUmSfj+FhIYo1k1cvDbXZo2Ae3biy8nuQXHJuJPVsUt3JLJHRULGJJLhzWENbdb/nEu5EV09mkyhHCiN+MHcE8DSmnaCRfwaFg5WIXdua35VvQaRTYbGUXEMBXCrEnn8UZonTd/llB1bqH3uIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362449; c=relaxed/simple;
	bh=Ph7VMkj/uhF6HzLcXhi5RdIwPE4nRmg0HHOAwOWM7ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxxEFgMNXAvjyKy4Yl+hNY2fwG2PFb8E7P5BILlL8VPD8qIIug87wn8Y9Y/wK98Ke0gYJy2ApmlDAS7GJh8bVYeu6XCDzfCjulZzSlKcJjWs+JuhsB8HA+CRCsyug61PsAWSpp6IC5kvTta03MitD/es5Znz8y9cns/+08AVtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fODXLTCz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47ae894e9b7so94357941cf.3;
        Tue, 22 Apr 2025 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362447; x=1745967247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph7VMkj/uhF6HzLcXhi5RdIwPE4nRmg0HHOAwOWM7ws=;
        b=fODXLTCzrfkwfEELzqKrNqFw6jplZhn7/KohShrczxXQm6rMJkxfK/C/4CMCHBldmi
         gP+zcsyUCbfhD/8VCUCCOwCP/qi/cVhlgH9IhBSH3LLzS31Ia49EslgseNuc+WFGT/t9
         4W37zVgHIpReBihEXFjS5pOAWSV2Q65FiMCMcXJC74lTDie4W+fWfPLTy62YaikQFRaQ
         SLWSyatbGVYUs9XjdD01QrdfZaRuXOzf8vh4BLAMiyooVr+kkNj2ZbujNe2KsfCkeZ3U
         D9ysp1t8LVZ2q2bOFAwHKdTh37ulEdxlZ2ZIc/u3zC6SX0uzwijSLCwz7AI9jrTKh/iV
         K/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362447; x=1745967247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph7VMkj/uhF6HzLcXhi5RdIwPE4nRmg0HHOAwOWM7ws=;
        b=oh8/fHDmOD5CLthBTfDRCqQDPyO50dzpbBCpZYmTcRQxVZk4Qtaa65pl5pe94PUw/+
         /Ty8IXYjhv7qv3KRo08/EffjKnAlh9vyWWvNoYttLzktM6GEXhaQfrrPoIsWHyIZjJ/e
         burPGT8fYj9MOfp7dHTx78euXfbhhcPQXO6pCh2oqUppQEMwNPIy6CqItQV+HyKbRsdX
         HT9iY5J9ZR51bOtKfrLth29x0wtHW2xLcJGSKIapT2C8KSpYRee9WzP1yXuFCDgQMrpN
         +tN2NB54Ay8lK6B4yPK4BW7KNjYlHcD4GUss1J2yqn0pu/oeXkGTEqnraGdjIThEfRZG
         21zw==
X-Forwarded-Encrypted: i=1; AJvYcCXIohRu11cA1za/ZMiBL1F9zBQTVK67XX/la7VSAn0DJ2dyv2N/g4jQLOTd822CKKn+sp3nfgySXTf/fvY=@vger.kernel.org, AJvYcCXz8iANg+L/0jTK00h6TwR8dsgaZJak0Loka6jutM2Gl9yI3Tzf3vHHiOl7p4Y6Id5PWqvJreBX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TrSalcc3IBTXqFHyMqEF/ZiGWS6xkVrx/IU1kB3nKlohBGkX
	bGnsEsaCKqkgF90SEWTgQZXHNKSkcNC/H1TlwRNHhHnicNfOxIT5hSMY7N+saRMe68TFeTGbLy4
	Xb4q7TniP8jewN4+A7TKjP8e1Ids=
X-Gm-Gg: ASbGnctPgdPftPsWUZpFXA1xFCm7JENLZcz3eiPrlSaAYPkQy2s5oYturrMFGtMgIqz
	Jo7VNlpYi1q6ha6dexm/rsxAPs3XTIxgw7dmdko49KMmWKNMP7SkmVI0oeavNBsPIUmjkEGsHD8
	tfIq0iFMio9wUMet/ZSFLXkg==
X-Google-Smtp-Source: AGHT+IEORD8ojUEQHr3D1+QFtqDuA4YeBYr8q0gJ2sylYYifJPAFNBYqPX5iT0D6RZs5dgYijoTKWzusjQflOl1O/3Q=
X-Received: by 2002:ad4:5bac:0:b0:6e8:f99c:7939 with SMTP id
 6a1803df08f44-6f2c4682637mr287665326d6.44.1745362446819; Tue, 22 Apr 2025
 15:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421191645.43526-2-yyyynoom@gmail.com> <a942be9e-2799-478d-b8c2-7a85f3a58f6c@intel.com>
In-Reply-To: <a942be9e-2799-478d-b8c2-7a85f3a58f6c@intel.com>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Wed, 23 Apr 2025 07:53:54 +0900
X-Gm-Features: ATxdqUFMdUN5qqUUpfR8CyrJIO4o1Agasa3dB2Ji18X2Ej4SA9EEkzUF8SLUQY0
Message-ID: <CAAjsZQwys95_bvKQDAd6aFeoL_LXfTKn2Pkwq=-F03uAuhVVXg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dlink: add synchronization for stats update
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 8:24=E2=80=AFAM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> Thanks,
> Jake

Thank you for replying to the patch!
I think this patch needs a bit more refinement.
Would it be okay if I submit a v2 patch?

