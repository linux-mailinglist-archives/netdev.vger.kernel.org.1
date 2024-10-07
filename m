Return-Path: <netdev+bounces-132870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8EB9939EB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C91FB2141F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DDC18C911;
	Mon,  7 Oct 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms1JPyy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C443FB9F;
	Mon,  7 Oct 2024 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339314; cv=none; b=oFKA0XD7KvKohPzOkgklOSGJyQKmVtjXLDAv7ZLIXZy+8d7YUOGryP7mkH4GDvTKb4Ji+ZhjUICB+bXspYfNmtOLrGX50O6cjw/eq8Tu1NDMP0WRXkvoW1QETNCJI63SAHAd7oZ6LHtmGMwKfcAu1hT/60y1fe9F8XvuFfNsu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339314; c=relaxed/simple;
	bh=PwHBL2tmLP/iKw8yTI6QFHoPHBqTu1hlGPo8hJwVPJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=knMsIvKaUF+eWmzq1y3yzs8ZRtF6AIH2LycaJhAow4Ktc47n6UcvscKcjgzhHz+6XWxfTLoaDPmEiKzpehkTV5NLD37Jr7FkwZzUOTSMCF2TqCCINgULY8bgyVf0QH/AbUzJ8e/cdDaQid+gtIHW0wy4wl+pp8oAkjI+NgywmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms1JPyy6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45ee18f05dfso728141cf.3;
        Mon, 07 Oct 2024 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728339312; x=1728944112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glbFnK+D6da1CPW9LPaLcHnyyMHhWuJt88AcDHZ9Kaw=;
        b=Ms1JPyy6NMDEV5YKH8TUGQvBNN3y52Zsrz76Dr58yoJsd3uueR9GraC/8XbEooAdLg
         VJQtUHV/8ME/sstzlaxTe96BJmIbA6ose6o7MzNcE4XLuG9ceIbcHESWnZqT4SMdo97j
         wZ1Ep5/1oRG9F8OQTxEhHe3aJkFU6yS63USDLiuGHHNQws59ymiR1SRh0cff5wM6TzUp
         kl5rPD9ne1ic0TeHopTkiSoYJE9u2vE0h9dPkf1DgGOyzhoWmuraOi5M9a3ziVnojJl7
         t0pAhV7w76UIUCwK8sTNjWYoCK3D5KhNr7MbHIgfENlmZnQ/xpasNN9WK2+vcpVcxg5s
         hM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339312; x=1728944112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glbFnK+D6da1CPW9LPaLcHnyyMHhWuJt88AcDHZ9Kaw=;
        b=SINgubeYAtxAHi3T1jOaULgrK0cfnqQ84beqdKyunY3X8SfdlSTMV6lSXxvY92WWQr
         sM/ykUZtFPBbzV+3U6vX8MUFOp1lIzgaYrhEyuysH39G6DjWidmYS+p7N8tF4WJ5ntIC
         sZiyDKAsOwJeEHOPGoJpyevJ7kgCViv+yYg/1/5h2laRVNZdIhHDbutyx2iZDAi+gxBA
         tC2OucDrDAoHx4Nk0cw/Tj4yqCsu68t6kmW0jbb2iDZ3fqyQDj/68IdKeZxaEcAdk9VY
         S9rquXh4HgepSYJYNYptOv2pRGbwpZ1w7Oqp/TzDRfar4MLWS3uECqS6cxI4r9JM4CB2
         h+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUY1njIDAiX93CMN4+5axvw5uYXvBNmDHgUSAoguytahKfni2FkaglsHgQxNM3jAohLzjMJXwxP6JNg33g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mPSnLKoEsHh/T/52pSSCBDuDBleVPE8byiJTJMW63W968Oe0
	r6rLIx5FUmgBOerikeG7Aw+Syk/sJhReq/UITdOTPiq3/HE98uerQjI63Q==
X-Google-Smtp-Source: AGHT+IGvfw3Bs9JE8QQTlS3c91E1xTAtTyFVhTNkfgT6Imv/vshDUTNbm13LU9uXwCfWrPnnZKcTvw==
X-Received: by 2002:a05:6214:5f12:b0:6cb:4a06:2e01 with SMTP id 6a1803df08f44-6cb9a2f58bcmr183026746d6.16.1728339311830;
        Mon, 07 Oct 2024 15:15:11 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbb413a2f9sm13743746d6.104.2024.10.07.15.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:15:11 -0700 (PDT)
Date: Mon, 07 Oct 2024 18:15:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <67045d6eb9340_1635eb294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <7b2cb791fb402b88e22013ae012363d596befb50.1728303615.git.gur.stavi@huawei.com>
References: <cover.1728303615.git.gur.stavi@huawei.com>
 <7b2cb791fb402b88e22013ae012363d596befb50.1728303615.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v01 3/4] selftests: net/psock_fanout: restore
 loopback up/down state on exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> Minimize the risk that psock_fanout leaves loopback device in a different
> state than the start state.
> 
> Restore loopback up/down state when test reaches end of main.
> For abort on errors, globally replace all 'exit' with 'cleanup_and_exit'
> that restores loopback up/down state.

Luckily tools/testing/selftests/net/run_afpackettests already runs
this test in a network namespace, so nothing terrible will happen if
it leaves lo down on exit.

I'd like to avoid this many code changes. As long as the test exits
with failure, it's fine if this particular state is left.

And prefer separate set_loopback_up and .._down helpers, rather than
a toggle whose behavior depends on current state.

> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

