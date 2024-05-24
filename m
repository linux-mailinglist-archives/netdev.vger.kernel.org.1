Return-Path: <netdev+bounces-97930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CAA8CE2A1
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 10:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6887282702
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6423FB83;
	Fri, 24 May 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnXhSnUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A329AB
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540682; cv=none; b=je4CwdCCWgz3bzw8kLjj8v0ztlrubU2j0g4jEffnkZapijxxL5jxxxOXVLpE4ciq9QE2Lgi53DntctB1dWrATgf5tk31I29vhQVzMAUInFTX3XuL915lXwnrD7C92d/LP3kQPNc63znBw5e9tkg0SshQ+wrvqA0btyIr6J/e+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540682; c=relaxed/simple;
	bh=XUoam/qx4B2UsIQOp3b7IiYhDSNbNtLZ051kvGQF4KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcMS7+WX0bG/JEXta1ppKKLfn9uVjlahqYlMAKh9Z7lcx2CGndboCYAaoXNwWwis9PvZlLbiJjTQRvQ58O1xY0slxjhX3QVjB9M0bG75Y3oKnXuYIfuWUmCAn3vwVPyK/6iKpZ3lQIndmyzG9nlxKHSbdcpeL8oiCVXeqgPUOcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnXhSnUC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6269ad71b6so63600866b.2
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716540679; x=1717145479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUoam/qx4B2UsIQOp3b7IiYhDSNbNtLZ051kvGQF4KE=;
        b=lnXhSnUCBB9jVzSOe7dPTF6TcYvPHxm2Anpfra92a/EIBv1xIx+KgiWKEjjAQxtwvj
         fAt/KaW4uxv8S5vzS8A+elt1r/xfKtSqcGZQlkmS+dnzJoL/vBDCf38fsJp+R00tTAWi
         u8XdaPdJJyLsWmNnc99SxVpniOT5meHuoB+Gm/8zqIdSZ78PoATsExEBjIOaR9QxuLXN
         0RITOU3t6SaLw+5R/Fvu7uaOImATcYmOls99eAycU6xFYYLyyo0b2VO3fO5W/2xfU5oz
         b8XWOiYnnUAb191VxV63hht9iguyS2n00cF/1F8meCjWMDTUYk0XrH+fuOthynAtXBx4
         cYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716540679; x=1717145479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUoam/qx4B2UsIQOp3b7IiYhDSNbNtLZ051kvGQF4KE=;
        b=neQhJORdgxFLkiohI8kDMM5Z5286ahKNhI8k5XT/Up96+owVYItJTchFLPnAyLbuCc
         7/jEekiHf7nrEwPcNcSArW0e2vVpG3s7n3EjdmmVBxuKdW0TdDeO1s6/2+mcj44HYVll
         4EFYNub0cpi/XyEg2Gtea/WzJ91f+WmmT5FnriRiCGSlZlxaXFtDrUu+eBu3HIc9MfOW
         F1c6B5Rui77aWEy4DMkzwmW7FiGl4LQBaeO++fNMq1uTJpBbeh3xEVr1ZlgaZMtwvIp/
         /acFlDpaY3GpWz3hlbp4fn8bOVrOZmcfQK6dw+nFAHiiQkZW1GBpsls7sCX2pEhwDE8h
         ALjg==
X-Forwarded-Encrypted: i=1; AJvYcCWKdR4Du4iQxdeU36kkfx2OIXCiXYwuQbCkLTmy1Jy0GH0u2Gb0JD0SYtdQGT9Q4aKRUiPpSWhPbciL8Cf87RJr0YnyGWLf
X-Gm-Message-State: AOJu0YyC1RY/Vz22YCe922jubL4rdt5MCFYCacOzn01S4DsZWZrU3egA
	35f0qWecTBuRQ92M5dgNb0UjGoLwRRaa0hnZR59nFbCVlTk00SasNFTrCgkZy6cYu810VG7hTFc
	bYnCn5Z4hk9jOlS/8IXGOLq+rtXY=
X-Google-Smtp-Source: AGHT+IHWB/HPlYQ8Xm8sEvAjCjBC9TpPpSAy0CdtVqEbd7DWftS4Qd5Rz5nba7WB0EsKbhb7bNI1yuenYLj5dYnZq9A=
X-Received: by 2002:a17:906:581b:b0:a59:ae9b:c661 with SMTP id
 a640c23a62f3a-a62646cd3femr91514166b.40.1716540679075; Fri, 24 May 2024
 01:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130528.60376-1-edumazet@google.com>
In-Reply-To: <20240523130528.60376-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 24 May 2024 16:50:42 +0800
Message-ID: <CAL+tcoCmrCP0EJ9Ky2K2+oHY2+qOcNZ_qAt-w95DOHLTQCW37w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reduce accepted window in NEW_SYN_RECV state
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jason Xing <kernelxing@tencent.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Jason commit made checks against ACK sequence less strict
> and can be exploited by attackers to establish spoofed flows
> with less probes.
>
> Innocent users might use tcp_rmem[1] =3D=3D 1,000,000,000,
> or something more reasonable.
>
> An attacker can use a regular TCP connection to learn the server
> initial tp->rcv_wnd, and use it to optimize the attack.
>
> If we make sure that only the announced window (smaller than 65535)
> is used for ACK validation, we force an attacker to use
> 65537 packets to complete the 3WHS (assuming server ISN is unknown)
>
> Fixes: 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd =
value")
> Link: https://datatracker.ietf.org/meeting/119/materials/slides-119-tcpm-=
ghost-acks-00
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thank you, Eric!

