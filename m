Return-Path: <netdev+bounces-201997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D90FAEBE83
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256A01C47859
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090CB2EA491;
	Fri, 27 Jun 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkVucV54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1912E5D
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045808; cv=none; b=DZ4AdVs5qHw9UIs2mh+hsDXbatzoGEks9nixYJ8MEO5KkSLPHbG3CsVvstnNo5ZDEpPRYnknO3ZlEXnF78MyvrCkW2UMfMI780hTvSRVT//V7yWLl7tX7G+1vG91e1dkk0Ur5rC0TYnpwEF2JFSPkNEBfzectQLd9dUAr3qAEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045808; c=relaxed/simple;
	bh=VNuwDTYah//kjNU1zV3GykAXUMIpaumNaVBGp6eObfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kweNU4ZQYEwA04qt08rmHdI6N3wY8pGpd5wQvGdFHMgCtzNoo+is0cZyldEZTYsyt23ddqF6kUhQg9UKq7e76RWV6fQ8tvB/uwSnAj0djDFfJbSgvbNKN0zTUWNaczxz7W3hGAEX2rb/JIu/3vZNn2PjQQtTf5g6653+C3ps1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkVucV54; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34c068faf8so2787155a12.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751045807; x=1751650607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNuwDTYah//kjNU1zV3GykAXUMIpaumNaVBGp6eObfM=;
        b=BkVucV54h9pECtRo4kjNds9uL7KrMy8h2JtS9/ZwGDZ/BuslsiwHTWp52U5arU62F1
         MHndUrbfwFAe2bbykSXssVIs1/uukWpMX5lQi8JkF/3azKGTGAlYKIe3d78056z1JHSR
         E1AURdsL8ykKzCM0PwdNoEdrdkozwAG5CwVlagAw7TDT1lrqfZrUid1yb8biy2/pWifG
         LYxEoWurpTFLSj1RXNhBetJte/8hVxbi5w0gMqCQxK7oMt+jyzBypM3p+y0HPip0PjTO
         Qc5xx3S7epzjkwzTXCOdfS9xVrMxxKvumz6XpxTROJcZNRPYBCCqFFsciSIvpt8avULe
         doUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751045807; x=1751650607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNuwDTYah//kjNU1zV3GykAXUMIpaumNaVBGp6eObfM=;
        b=IPeWM7RQeBFehgHxoiNEtkFV5nhAYahpMQsTBRLTBGdQfp8S0BHooN8dY6w2W+1Ycc
         owzO8QlwAUbpt1i7tMcTgYGxDFwEh8Wac/YtlY9grdpDkta7FTErLBNPBOsabFPe6akY
         A4VYlPtlB7BHCRr6nx+aNT8XhtG8VrbvHAYeFXC6+ukSCvaUg+UBTlrtfYqBpAhmEuLZ
         /eo3631JEtBZupWgmabA8OCARzpWN8EWGNE2v2BiOlAzUpzt9Idt8UlMD/IlPrcb3RmH
         frU2b7hNSQK/klPFD0DLUbGZRgGP1s+1W9Tc7sde3/OKioU//HCRcTmZdxJVufLas9zx
         HA8A==
X-Forwarded-Encrypted: i=1; AJvYcCVDpLSCIN0pP4vcPI+TEIbxmg9oAFJcsz2XxiosboZeHWhQywlzumbfXRAdWjcZ1brD4Yq24mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHETtr7BFV5JlWLMyVu8gI09fj5pQSHIeIyDwp/YO8zaUyQX4
	pZV4m6cXCMr21/XIBdgVnKP7EaGMs8WJw5kqA0sa8PvKqbHWOEpveSrPKKL7a/9gwSc2oGkQxTA
	8AC6rjqgUKKOejytG5vjetwsQYSueVzo97IpiIr+C
X-Gm-Gg: ASbGncuw3xcTHnRorl9uBeXWvJG6yFZz/0FR0IQ59FXeRJ/KZDKqMm0QoAgD7avzQJ2
	llKYf49sPKa+adUe6XqzgtcubHZY9FD444qlBYV6SCwzU4iAl3IOnjsaBEfVdsgcfwrpz+dniE7
	ds5BgL7GfEoZIInAlP7+xH1qnpd6BRJ2DALTHhFgw4dFceh8yqav9cbg3wZ4N834P3fgQkCxn3s
	Q==
X-Google-Smtp-Source: AGHT+IFd2vj0npGcC26DmTNBqgs+E+ZseknEfgF6MXWCc0b//4AGoQo78TxHGtkng/1N+W9mg6RDtw281CbU4Mp+2mc=
X-Received: by 2002:a17:90b:2e90:b0:313:d6ce:6c6e with SMTP id
 98e67ed59e1d1-318c8fef0a9mr6607233a91.8.1751045806746; Fri, 27 Jun 2025
 10:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-2-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 10:36:34 -0700
X-Gm-Features: Ac12FXyaCjsjBCpMK9F0kmgXSzsh0RVG53SDJPiAa5ptPE8eHHCxFsTNfXlpl8I
Message-ID: <CAAVpQUAsDH-PRfM16WEZAqQtP_agzqJB7VwD-wmUQwYB1x-4gg@mail.gmail.com>
Subject: Re: [PATCH net-next 01/10] net: dst: annotate data-races around dst->obsolete
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> (dst_entry)->obsolete is read locklessly, add corresponding
> annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

