Return-Path: <netdev+bounces-148477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAAF9E1CDF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75295163F30
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F081EC011;
	Tue,  3 Dec 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tm23qbGR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E016BE17
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230753; cv=none; b=jXic/hTe/ARPUzjLycDn3JkyeM7EYqjbVIwSILghIYIbi0IfKuCrZBKLfsC+H9JM806TeVt87Fa/uH73MqkcI5VEcDM8+SkOMG94e5HWwkgdhMyKb3SYlygXIYdW7B6gzBB1cxZf/dTEDvZ5t7aYpCzY+rbph3BNzWMd8MCCjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230753; c=relaxed/simple;
	bh=s7tYr3uE08Gbo2wRdYGlktCLIF3YVGbvoLNE67Rol/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO/IqWBPCb39rPGQlGxRJ3dGZDu1b1VO+gOSOy3zdZTybCM0TM6CAzcDvRyDkdpHjsvDvyVSngU/6+ny9TqkhH9nCeZGYpJBhDxwaeamcTQGZ9Wnq0TFt+fvwqtMzsrmfuWsv08EBgnM1R/kv5Gs9qMXLqpdjce1rS6aikP53xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tm23qbGR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa52edbcb63so1134977666b.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 04:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733230750; x=1733835550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7tYr3uE08Gbo2wRdYGlktCLIF3YVGbvoLNE67Rol/Y=;
        b=Tm23qbGRyJap/BtoY1Nc37iGMXoSLnaxr9Ea35D64yqv9bxJYI567oJGT93tZyJTty
         z5q8Y4QafEubn5Wg5Q6/+4PZvwEZcf5vybwIpqHSICwYKvMF0mS1P02mFnfMyit6eCxX
         A3yXxXNX2rx4s5q6+SP/zI09BsOhdNYbhkeoxG4x22GqrShhUjUJydHyNAo+9AVKCkfT
         V3MUxcFR8BiJl8mJAzQmUAy3GUNaxWbUT0gTaofRSTEsCRaa6jweLlTzCrA5Dp9qfPK9
         aXHMtpR2sXVU9OhgWMhQ79nnHZd6h/6wVbIVeRtTMzeYACfiwOjTgC6R2VGWTbn5yGec
         FM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733230750; x=1733835550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7tYr3uE08Gbo2wRdYGlktCLIF3YVGbvoLNE67Rol/Y=;
        b=owiM8XOQ5g0FYkXDm912IcXECTw89tTFHH9tvVtwQCRbEobG050XRxusALBEQbVPkW
         D6YyTnT8wAXL0Ucq0LxsJNgXL01J4EYTqFuCL5gD4fypDEeITZ+/CIraYsTphYJDcS30
         IUrsHpTKjWs90upE7H7e5qrieJqH3Ni6URwS7Ld6DxbmiseSZ+U3pxFrBSfe0zLT2sfB
         +l5Y8QllLbeb2Yy4wdx/MlMqk9tY6vaDu8G+1TO86DsVBEWtOtCP5H53C/yAkq81CaQb
         dYqmqYKxODBRlKx0FPdq7yWtnccVMvL13/pIzMkvMBPk+hTnhMYZcjByEWLDxTUjcVnZ
         OcXw==
X-Gm-Message-State: AOJu0YxfxJ9QoKlSkGAJ4Y3k65wNwjBXC3cUDSh1UWy3UPO6rgCZq2Y0
	BiGNueI6RVu34ta2Of4BQl72RHLHp7E3h81YKskTepYbzeO57qXyHjXg06ByeUoKU3yMxBBU3P0
	xnVjnSr6oeGXaPVA7Hv6E0ETaD7PoqBePb0Si
X-Gm-Gg: ASbGncvG5gmaqlW0JBZabktX+6H9cBSkLSnpWM8eWKhutH0yw+bxzpBa+MlZR3oL7UZ
	0313mCreMgpx5Hui4ZAL8iQOhBy9UWMQw
X-Google-Smtp-Source: AGHT+IGEJX96d3dle/hvbe7BFoGdFLSTQ52NIyeRo09QBpIHC0BwWnfoEuSq70JhnArYT8TdAbdSEQBeqhsQMvfLyQE=
X-Received: by 2002:a17:907:968f:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aa5945dd00fmr2552313366b.17.1733230750444; Tue, 03 Dec 2024
 04:59:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202155620.1719-1-ffmancera@riseup.net>
In-Reply-To: <20241202155620.1719-1-ffmancera@riseup.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 13:58:58 +0100
Message-ID: <CANn89iLQQ0_Wdt=W6Rd1uQJdnPVb_tK9tbnpE4JOkZmPUXEcOg@mail.gmail.com>
Subject: Re: [PATCH net] Revert "udp: avoid calling sock_def_readable() if possible"
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:56=E2=80=AFPM Fernando Fernandez Mancera
<ffmancera@riseup.net> wrote:
>
> This reverts commit 612b1c0dec5bc7367f90fc508448b8d0d7c05414. On a
> scenario with multiple threads blocking on a recvfrom(), we need to call
> sock_def_readable() on every __udp_enqueue_schedule_skb() otherwise the
> threads won't be woken up as __skb_wait_for_more_packets() is using
> prepare_to_wait_exclusive().
>
> Link: https://bugzilla.redhat.com/2308477
> Fixes: 612b1c0dec5b ("udp: avoid calling sock_def_readable() if possible"=
)
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>

Reviewed-by: Eric Dumazet <edumazet@google.com>

