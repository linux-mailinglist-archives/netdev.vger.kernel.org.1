Return-Path: <netdev+bounces-191095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A110BABA0C6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F71189FAEC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB9D1B6CE5;
	Fri, 16 May 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0f1+EmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2717A2FA
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412926; cv=none; b=TaKcAkOYznhd6FdnScfOFVi07y4Bkdi7Zd6vZHW4+QOK88Sl5mxPtCA2d6BH2QkCC36UKCbEWXHkENPsYxYzk9lAgVQzz9vuzYdDohGs9gMprK/ILZkKZ9moD2zDsoaBIJA/BWD2sph/AXjHI/d8bE50mNUoGazowPsOVSUOcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412926; c=relaxed/simple;
	bh=12jJk8PjKBWEJWh4MJJRvoeBv4yMrlwVqNP/mWcj98M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=L0qP7Qf7GMrQHycpqSUeVft1ZXyLTSJHrNBHSiwn3HMSF49miH6U0qVPDoNyGqaQQYQiPXX3NgkF9FCbEjX/4qXChcgWgGbJsz4j1z/hGhzwuEUDYTw4WRR0H4te0bJclGOmt9OEzhl0TPsAgkL8APVqnNddOHzesX9AEgMdC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0f1+EmA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47662449055so14152701cf.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747412924; x=1748017724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpnKU8rcxqV1PYcW1dAdERQr3S2BS9SK69v3htVHaiA=;
        b=j0f1+EmAlPfpwpQXaBdgCYZRIbBin8/jIJlu+tvrvn7zvy4PEfy6M7yhPHvhQEAbRc
         TggK61UR7vjYGWs9CQT2Esc7g4Xi6vhpiXKs98INNSbloqJX3gybn30I6xJJNm5sg+LE
         UznSZm7G0tGvSk2ox/PNlGrBMVyrVGhjD4Jm85Qx+hi7B6pHNzEocqrYpjIDDwSJmDu8
         SLD14EwjQ+LXVuYBCiG9CuzGQy3+LC5WXhXlLUG5JN1tok9o/uL0FqoJFRvkdto2PvI3
         B75wk/SwZkjUrC4y7IVdwqx9s+3MtimbSazPGNDeJwEQ3yW7iCIjiiwBVlfijD3Sj1t4
         MTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747412924; x=1748017724;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PpnKU8rcxqV1PYcW1dAdERQr3S2BS9SK69v3htVHaiA=;
        b=RKD9MWwfaDYzUjIpipyUWqepgJ4Mr0+kzcjnIa5HfPs6PrJk0qOtcxAaQL+BOw3Om5
         SVrSb4njn/mMn4S2zocTby1TsP5JL1NwqKI7XMqtnp23jgiYWdv/wNHlijUD2b8UuoAP
         NFIi/4ypkw8Zu/ifPqIDsMKxOceuhzNuSS1PH00eSyiKilx4bkevLTp9W38t6PGzN8ig
         9DUompjfOYkiwNq3+Fn0BVFgiI7s0phs4gLGIfH+3LYDKp7FEM+dUnVOU4GYCwj4h8nW
         j+92XIb07zWhDDJYKWIln7Ew4y8DkctAtjoOR6nHCzXcWhvGurNoaqZEoi/kmAwgMMNE
         5Zdg==
X-Forwarded-Encrypted: i=1; AJvYcCXZRVl5toSRIKHQEEg9FIwJIP7/4gcOck11C60bq6hkIUQLd+cgJVDqzHune+jkSRtp26r09Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6tVunHu4OLNtvx6OnZxdVZfansBSBKwLyZI5CFeCMzSG/Wwj
	5gNI6yFrGAqmouafdbKEsKfmrbHXnS/N3G4A98RyE+TJres/2rA48zhC
X-Gm-Gg: ASbGncv2pccOGFzsrQeOTv0LSsp1FSna8jKqpmjjiiUabDfSDTFS37x7rjvIk+ECBVM
	qh4In7ocRWuK3Su66zi8JCkCKPvQf716tZ/AjvAFecLs3rEX9pKfCKxOUYM6Jlrw7KASUsleuve
	i+EW/mlSk45AQEDM6AtEcmpdOTXk5wMOg2KnI9Ymoh8YLnISVEAEGSXSM+g20pfyKDAV3zMVJru
	/1gMjHSdp8KpGEzG4P6m3TdDUa8gWKCmMarZUs2TQ14N1kxq+5HAlTvcIFqUYYRzW4i5ef0um5B
	csWz/n4eBN/0TnJgnb5TYAAWhbS593mP3wnmUkl2UMjcD85l31bjhcZFmrSlzk+yfZ1mTcQwYhB
	PJC7X8EWm0xDtISJPB+SHSsU6QMz702w8dg==
X-Google-Smtp-Source: AGHT+IEhBmHD5YkVBdR68OuCG8OdpnJIJyzjBFuolYEDDU6yhJ5UkXcc7zTzHy4yLI7nEqQWHXGzNQ==
X-Received: by 2002:a05:622a:909:b0:48a:c90f:ce6f with SMTP id d75a77b69052e-494ae350c28mr68595361cf.4.1747412923725;
        Fri, 16 May 2025 09:28:43 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae41e35asm12897411cf.33.2025.05.16.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:28:42 -0700 (PDT)
Date: Fri, 16 May 2025 12:28:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <682767ba63501_2af52b294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515224946.6931-2-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
 <20250515224946.6931-2-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 1/9] af_unix: Factorise test_bit() for
 SOCK_PASSCRED and SOCK_PASSPIDFD.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
> are scattered across many places.
> 
> Let's centralise the bit tests to make the following changes cleaner.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

