Return-Path: <netdev+bounces-206388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA732B02D43
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314AB4A3EE4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7222A4EE;
	Sat, 12 Jul 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fir0anLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC422B8B6
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752357260; cv=none; b=qxzEtoeB0a/04+Qp6bwXrKZA+FQmeymec1Y1IAy9sQNzy2r62TmOkXClYkWZLMj7L2D82zRXDxiMMLcBPfrKEQFgB0CttE7+qimw9qvszThcE9qyf6sHstwKRYc09OA9hLl3mUbKNkeZCRyW6RTxDLkKRq3we97HUxam1fGWPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752357260; c=relaxed/simple;
	bh=tpuGuTXlQCNyTrOocAPpYHLMJwQi/B8RJ1/alZXJThg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECI3ueD/kIbuXQq4IcXbddQYAcNpvyWMvSWsT4Pxgje8D7zTBTvtx7TATrPAiXKc7VPqnBWBPC3tCWeuROknLEvoLh+FjupuTmCBezx5GavtTHMIqtFPTksol+zA7k8lk0fw5NoixNLjOBBMhBENEOePHHYsjVLwTwTOa9JDZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fir0anLn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313910f392dso2736345a91.2
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752357257; x=1752962057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpuGuTXlQCNyTrOocAPpYHLMJwQi/B8RJ1/alZXJThg=;
        b=Fir0anLnllubkLTvScQi382iwMANiHGdlmnXUlTSV8ALIgNgHQOLEwhFNSBLT8Q1/j
         qLQ6cmR0ho72dxDRVOBJHNmXe8ffou19Knu1fdaRSTi/3ZX2/vLvNxVc1g1OiSSf0EPC
         YqeysXQytYxerR/dVz//0Xd9O26L/0n6Z5BSrZoX13Z4/Qzsj5+ovLIdZ9rOJxuI+oLo
         kuC/rlnktZjlogWHaFVtWEZNsnY5VmygsPTbA+j2NpOK5TkEuT0PTOW7MV02SUjcSSdP
         LkzzIZyTRk1JzWOWwlzeYVueZA3TffPzt8ixjM+GpBTQQZE6/UJ2UujKcyy/kDQtA/qX
         SeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752357257; x=1752962057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpuGuTXlQCNyTrOocAPpYHLMJwQi/B8RJ1/alZXJThg=;
        b=wSsgRAvRS2OqISjjWU6ARvUtOhwxKS3TaWvkxyikAdtpH+Db3sAZjT1NdvkhGALq+4
         fLs1OS22q7exAz3IDySYl3mCOkQEJKI4aYXEpemw7S7cYILZp+g+6UnaRBgXGuA5GmhW
         zhL3Wzk+ipAkGVwoA6RXGirdyiAydNp2OOXMJRgngOmfe0KdxRDGyWLY0PhD6gmLtt57
         WuUKaNgAjqACyIBbYPDt8iA8V+QyHxTvL801dDDYRHLfgaupwzMjLaa1qsyvuDPtuoeM
         pYNIgRb5Xl30oMHBq+XDuIqLs38LCc2SrroiYeXUtA5KQmENyv65ZISZeOrcDIrNnBvU
         TqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmeRD9JsW3oFg43jkhuRwks76dWBxQ4wJGn64nIm2d7ENOCFWqJWHmpR/8XI27/+oqQ5SmRDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoKivgAJjZA0Vx8HceRmog49oE+/y6BUEi7ovUePZAYGin6nH
	7UckKA6H8fALgiZmfZ7UuaQkgDabeOQoGIQZA2jwrq6aEx3k0ZLa7c2rvTj8wGaNQPDyEw9N0kZ
	21dfN503N5f0BUS4+Xa16x+QSjTouxqnAhTl6HWWL
X-Gm-Gg: ASbGncuibFfeNg6yEp6uBVkrDtaiLr2asVC7oO9xaV/4Ou+pErb3ajnRRhrwPyYgwZx
	CzF8iXX0w1nbm38KS/U3ldXKwZ78/Hq6Cj9IA8yunw0D4/kP9lQMxP8LZfLQNhWTkO20GG6iZcc
	qhrOcRhsAIRK4roGoRDP/LAcT/VjUS+aReoZ5yfO1XJcQzURD3CZJobF97QyVIhY+rVZWPafyFl
	JJTDEfdfdv0rnRqJHrjVCXplCfjGI2T+ELGeUG3
X-Google-Smtp-Source: AGHT+IHy4x26jHdziJXVtA3UNjY7yRBnbEp+99Y10n8Z5MpDxnFfrSwTp7WV4Coo1XxlgIDka2vJHoYnJuKqyCRHjO8=
X-Received: by 2002:a17:90b:4a45:b0:313:1e9d:404b with SMTP id
 98e67ed59e1d1-31c4f49ecb8mr10393995a91.2.1752357257182; Sat, 12 Jul 2025
 14:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-8-edumazet@google.com>
In-Reply-To: <20250711114006.480026-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 14:54:04 -0700
X-Gm-Features: Ac12FXz_W7fBRYBy6D9fQ-L-Uy4ZC3KugznFq5RbvY0-rVk161VdKQXtD20DldM
Message-ID: <CAAVpQUCLjVrRRCY=NiwDifvkAjsRduPm_4AKpCK50Jh+1LX+dA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Currently, TCP stack accepts incoming packet if sizes of receive queues
> are below sk->sk_rcvbuf limit.
>
> This can cause memory overshoot if the packet is big, like an 1/2 MB
> BIG TCP one.
>
> Refine the check to take into account the incoming skb truesize.
>
> Note that we still accept the packet if the receive queue is empty,
> to not completely freeze TCP flows in pathological conditions.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

