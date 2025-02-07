Return-Path: <netdev+bounces-163871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DEA2BE2D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72434188C8F9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4EC23642D;
	Fri,  7 Feb 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDRTNj2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78641CCB4A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917440; cv=none; b=C6PxFGCw3knlvCz1MI9R1FYIR09FsQR+N5kTP9sRND3Zt/DDOPWb390CXlAhYdRtR7kIGIZaOt6zWZL8wYqiMfXqT+FizRUm6LaHeQhFMyy3TY9EuVByTOF+AzLIXuLeyBZVDxSBOjeIw3QxIutMpSuzI9powEqE+/y0k4N1qQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917440; c=relaxed/simple;
	bh=TraCmKYzmzNZhF/MxI7oCeQGHN1qI+uL5FrVb80nHfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvJ38v0e++D/wZLWR6II/3bS7zVXAoVJnwMHmgurjQAnptj9zkZqX0t2V6baqGWI+aeaAJMviNGzd4VzHAOMPeJbqLFBAE3NV7kj5HRf2PiHXoUUgI8pb4VJd88GBrMFS1GoM82ubz3ZOL8VT7f7dHym2hhk7PThxCguwcCaBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDRTNj2A; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab78e6edb48so43891566b.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917437; x=1739522237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TraCmKYzmzNZhF/MxI7oCeQGHN1qI+uL5FrVb80nHfw=;
        b=PDRTNj2AWi1djYRmoeKa6BpewDqL9PiEYAJRkMIK06qt2hRML/Q07gxw9SozUQyvW1
         CPitxuWZGRme1QX/km7QOJ2MUGGRfmX+5vOl0RI+bcnrm/y4E0Ypnt+Vaw45JbGEHxO8
         p+A5GDZ3a2SeRnVZCPbdlWFBMYRVq2sz/T7FD4eUhj5KSQ3rxNt2tNEH46DWzSPmHZzo
         5zJRSyTvcNP3xHr0yYI/rmZmRYm87ReCz/mhnj3OQgHRk+RydxMxr5vXAaKyi6DIrr8b
         xOcfAKtkoVSQtckq/6Ka6tVC1wTK1W1WORajdwJjiGk7Tg4BU53BSN8eUe1U/Ul04F7M
         VaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917437; x=1739522237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TraCmKYzmzNZhF/MxI7oCeQGHN1qI+uL5FrVb80nHfw=;
        b=YB3GLL/mI5zuIReqjgEd9JbcNoiMnHutfl2+ZD5fIKCduPzXKciuFDB6o7U5UZZ2g9
         T2D2Wi5YkeycMMS5w149GrV9wFStJYatiNNamwVM7TgCPx4D85ZfdXQUa3JYgiNe6ZsH
         b87BgZ32QIR0lxl52r41d0nsVfqOmp/RTVFikiN6NiV2cawibn6Q/qPP+KvVXxJwJS47
         CtgZW15V8XeQlSCTdBUEIzq5kP/AMCcPVAennz7NPM2fF0qVQkBXPCkZBxjWh1jCCf/N
         IsbqdMN0FUE1tNkEZZFlFKsyFFYbZ/qskmp51r78H10lw6zpeoREJss5CP3lbVRcBdfX
         C6rw==
X-Forwarded-Encrypted: i=1; AJvYcCVxBqhnZj2ROArtHdtGkTW+faXREwNOIeM1+l1F3QizcipMRyjB/ctIWu0Xv15YLHNCQOSRcFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHKd21Z8sY6Mf4pDqEhLowIfT019VOXrkIGmRBZGyoIiON1mF
	Q2MLMYrlyG4x0Tcec9ZcYsyEFY95u/fQW59wZ02LbHzADGMs32FMujhjBuKbnGoWkiWQNFlTaBN
	4aH2znT6UwFROA9bFAUVI2L8ZEgeLS6LHPsx1
X-Gm-Gg: ASbGncsMqkp/bTsKCp0OmW66Vh484nCdOFFl8n200uhQNL0LYnVV9rhoVobKsZTUhrT
	3UBXjSez/IGgBqHF6uzOJ0gvz/MODii6u5zCjuXapc5FOvbx+h77HV3U/7oSz8s+Jgg7ZBDGc
X-Google-Smtp-Source: AGHT+IG0V29k92cUOT5TescX7ZAJdn0GZBGZH8nvhRUvXv3C3CjTyN06HEf7WjLzlpzy55RLdfdC7A7HrkzYfmIwcgw=
X-Received: by 2002:a05:6402:2392:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5de4a8b4fc4mr2675053a12.32.1738917436894; Fri, 07 Feb 2025
 00:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-8-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:37:06 +0100
X-Gm-Features: AWEUYZmCOounvmTwOx6u1elusNFXDzhySWZhAJSK1bDRibS-5BeTPapxCO0vIJA
Message-ID: <CANn89iJGWU8tqi6y4-j2HtyiW5X6jxHpn+bYAxU6A0cpn+Zk5g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/8] net: fib_rules: Add error_free label in fib_delrule().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> We will hold RTNL just before calling fib_nl2rule_rtnl() in
> fib_delrule() and release it before kfree(nlrule).
>
> Let's add a new rule to make the following change cleaner.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

