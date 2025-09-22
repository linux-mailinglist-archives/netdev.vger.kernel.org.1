Return-Path: <netdev+bounces-225439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C3B93A6D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92232E1564
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6D42FC00D;
	Mon, 22 Sep 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaTDfys1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB7255F28
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585339; cv=none; b=rZhve/YwSwJRBvIgv8cxn8pO3tBxWzAxfb0uGExPLq9shRRZA5WYe0h+Z71If9mNmcbbXFwhjDAuA45AqIx1WV/hyemsytOtOiYmJDUwAJz2h+9SHBnWi+b193WydcJBh+R+n+0oO+fbwGaaV4FIRUGwP6JJyEsUm+LevBnj2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585339; c=relaxed/simple;
	bh=kryvH9N6dLdV7ingYCZJVRz0dF748cjeyzlG56w1Lso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPTchNwr8KI3OEf1KSt1fVqMBVJ6fSs4whig72YXyl5gyaM3YMBpi8Yu798DBAtnPpewFVGae4kYeGAouP66D2A19paLkQKv1941oD7mrNqZ13AHn+IP8rpFtwRYE5cn6MoN3qNxyIQY4ZBt1xhM01LZ/aWKX4Y+vaU93/LawAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XaTDfys1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550eff972eso2966513a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758585337; x=1759190137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kryvH9N6dLdV7ingYCZJVRz0dF748cjeyzlG56w1Lso=;
        b=XaTDfys1gpJ04p8R7Q749q5zp8uFJRgatBPKFSv8VpeaILPy2E1BqYmRnwC71W3ikQ
         In7d3sh4nTPyWITJrqINmKrAkO84geNwETBphyLUgugsYPIPZx/mTAbgbztIw/SnosgX
         XNbCPP+GtgKM0rHc/4Ff/3xb1PJh6vZx5vwrLmRlQPpeaBk+7vn/Sp4NFsdm7XQtiifo
         sPRl5D/PGO4zQ2y5q6KFa2vO0RC1MMuv+4Ji7tKyQDFjLUk2kxs+ekotVW8KdMQlS/2h
         QPaVq3+zMXyKgDlAluD7U/iFCjOyVOT6nBMR4ZlHXMlz0l2Xndukr3HSsY/lh7dA7pBx
         iKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758585337; x=1759190137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kryvH9N6dLdV7ingYCZJVRz0dF748cjeyzlG56w1Lso=;
        b=chYGbYwcEbMllw/CC8Gg4mTwV5Hu6C8S2xlS8gj6ZNl8zNSKuvvXhZIdfOgFZb2V6S
         Vg8B4dm/WtfoHL5kPbJ2r21Coiz4AMxj1XRO1kSuCZiS0WOLj64gxzI9JFk5/h04oRZP
         SCCmeLqo5ZXrY41uoK7kya8MfrmbPjVdUndZ9kkDmqsGrKqj6zyUzRm9sVyijgNnLA9/
         6KDGpUlryuCCK8fHjFAq8i/Qv2ngwfoaxYEBhNW5xLmtKo/LuXahRstGGlY3cxrzvfZE
         GVFUV83aP8DxVS6UQbwA4Y56m6AQKLvyo9viampjRKcNEK01HyYgnlBuEwqPyibkezDf
         nxxA==
X-Forwarded-Encrypted: i=1; AJvYcCWceTS6VzRIQGktxQL46HCCp4jdwnc2joGPLvQI8kPWU6PsZeoKctLl6ShXHgYBw1NGe+dBYOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz157Bpx915zamfw8fvN/LxTcAd1sOiaqtmnJ/7bdyTh9V+pWpb
	RG+dwbLhjWqfh/eOBmdvmaLrEuMbc0bd4aVR4/vC4hFyKdsFrvmj1DvT7MBJtDM70WBBBZgehy9
	jqSe/Iko+myee7C7Qjot6T5fbw1luhNbNHzJjAUeqbPmUPUzHLwwgTFS8DPA=
X-Gm-Gg: ASbGnctHOWFXjA2PXFzG0jYQ1ac9zNaD6sgF8cvzcDjFzUoznVvBJcUpXFD8pU7/Pfa
	X2X45wQ7tDApALu2lnh6yCFA37Jp2DmEM/a5I5QbldeCXMTJkBRtKrOQztSkmgB6jMLEWbiFAIU
	OLLpyWIi7XXdZ7/f+3Oefm0Q6AF4SeYXId96KtFWnCItDit4XjQGhV1rbqG5Y5OJ1lbgIokNgjo
	nKZ580JpJp/PBAfuva26girfsUMvU867yCTXg==
X-Google-Smtp-Source: AGHT+IFku9hYt9umXljjkcTMPzev9bmnZijZ81HWpP+EyQsocwmPnpUtIH4ErpvtfAzJgAKQjwftoIpivwgLlHvfldw=
X-Received: by 2002:a17:903:33c5:b0:26a:f69a:4343 with SMTP id
 d9443c01a7336-27cc09e4125mr4456655ad.4.1758585337408; Mon, 22 Sep 2025
 16:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-5-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 16:55:25 -0700
X-Gm-Features: AS18NWAfFMjuICQe5DfSWyhWtOCNQdN9qdFrvY3QY9gqByy-cRwgsmS19Q7Wtt4
Message-ID: <CAAVpQUB88QjNYoC3h6s7oe4iT_N4OKO00Oaa7gCvXTTLTqU_7g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] tcp: move tcp->rcv_tstamp to
 tcp_sock_write_txrx group
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_ack() writes this field, it belongs to tcp_sock_write_txrx.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Confirmed that if snd_ssthresh was not moved, there would be
a 4-bytes hole.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

