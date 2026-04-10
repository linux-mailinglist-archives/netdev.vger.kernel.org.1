Return-Path: <netdev+bounces-277265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOQ7N5GX2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011F3D2BBC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD450303A853
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF98235B63E;
	Fri, 10 Apr 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQAwuurF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28A2F9C37
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802150; cv=pass; b=JtxDnMtjB0h1Ov34jlnDneSfDimTaQ4c+t1bauPpIPP1H8RFNLBu8SWtP1tj0Blw+OfDtmw/EjiC8pYH2wZRujm0X6mphjv2SPP/bi6kyHP43sPNzEf5z7WXy2SaZKcABG6SOjAwoGFFZx/9s0ItZ7cNbXq1kmy4ige4atYF7kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802150; c=relaxed/simple;
	bh=85uhO6a3UX0RUPOdgER5qc6B6LT1jAnA2i1DKn1wxlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6PaEg0LFp/RfKAirYBP1Q1gLGxs5eGPCn8Uk7azxYwGw4b7/KfTOcNTkHSWTvy38HN1tbpaW/bOuJAvUEDffF68c2HWjDdONgJiTIZFoESnAXQ/tb1DaCRZkphqqZDmMbM7RySoBw7NJffLnGoRxC8WoAyf0ZUXj3btWYnMAmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQAwuurF; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4b77adso9762652c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775802148; cv=none;
        d=google.com; s=arc-20240605;
        b=LwCOMQB3PQjzB1F2Ey9V2ZpPf3P3ROssressEvlQydZX/Dvh0AfhxrxLjYSKkd5tfp
         Dupjts7HiyvC23kNf/WKU2Xm1Os86GKowRY0qTxFlaWZ0uoA92vyAdGc97RvHCTJXbLO
         6fl5CUr1gZyHC/Rtsxy9N5Rw5lneBmfC48qwBzJKM0Y27Lt9irLDosQ6/XLzdXs9S+NT
         uhYe2J8zOVUV1zZmbtd8yc/tSF5wPxRBKNn7us8W2365SwD9h4FbZs0DOaN6vA5WXio2
         Bw3+hBIowmFvLOqH1P737LAxEOyohB/9EGfb9zCFASUwECU7StNcYwqCCn8JbmQ/QbBv
         sBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85uhO6a3UX0RUPOdgER5qc6B6LT1jAnA2i1DKn1wxlw=;
        fh=UtmlBLGrnpSPH+om++TvhoHKBgbP7iY3vUX4lzfhqpc=;
        b=hqronhFANAFH5bx0pKsBLJAOhi8WA8G/uv1iyocHDkGXdpwQnfAGw30aIvBWKIA1oR
         1jrVZgPQjfTLO/XKjhkQ2FBG8kQmA3bXLoMkdwoI8TNVLn7IJqgQ3E4Wo8O85AqTpVgd
         Dgo6vsiCs6ifhOUGm4k7OXX0Gj718518Gm5xhckGi45tOnx88gC+itgzC+6HvStkygqJ
         GqSlXfKJNfw+glH+30VlnJVaptkKsb/CEH3sMqaoBU12dr32962YIXxu6J4ieb/Roeum
         1oz6vIwlPRm3GF9ZQVEVGbC6cMB+PL09mUldo8GuzSMcbH7MZhjXUl7VIF2EGEKqokQW
         mmfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775802148; x=1776406948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85uhO6a3UX0RUPOdgER5qc6B6LT1jAnA2i1DKn1wxlw=;
        b=EQAwuurFVQq/KqC4mz49Qdtwl1+sEmISghD8BxtphBBh/aEUOPIXvqt2GtLjw5SMiU
         6LBFqb4kEFvHs6noNsANQgCL5yaj9dnlLUKKUM7SGnh4ePmKP0Cl4stUoCHKddC/tkwE
         UbOtXOCTXFAtKoC8JrZeLUT4jNaKzOFB/+cQborT2Ip2mOWQlc1DZN1mVFGr3kFf+L08
         7ScMJuaRFZyu0mvSq01UAxKkzWYXVVCI2UHjjuq+X077f2QvjjTm9cU8Vt+Lu1VPdyYR
         idkcNP9CwLS13R7VDPdJLycIF6PpQOZSZG+U7TRVD3qNvmeUchKYNGYe/W0f2JfxyVmW
         0eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775802148; x=1776406948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=85uhO6a3UX0RUPOdgER5qc6B6LT1jAnA2i1DKn1wxlw=;
        b=qZx152Le0sNjz/cLCsryEOdgecuAUKErQByiwRTxabBBp4emuJZLETp9LAttDbEbmZ
         0aJ+Ix5aG3fG0kpx+SmUJZkenNC9yXdz3TdO2Vs1E+NawDys9PWbW0AQJSSTbdyXVspC
         q78xiKbvSHYODpokVhpA2zrQmp7l0cdOEVa9I1qDnKgDut+gqnl8mrY6vlPUIerKC3lb
         tAzZrx1wP3aWJIxx8bCOjLlmSAlkRzAZ8q6XPc4BEUOltvnnaVlP+OOFc8DLlMInfrCW
         J+dgmhwjSsCBVPUTaSt5Sm0x8EB1YAYNnm7ZXez6OFzZxdMHd0aJ97NAsE8HFc5HDpyG
         B0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5UE0QzvJD5nBBKGeUifwgmgqNvxMnRhGXgfbXM3sA1QnCkoNvIXdrf+NlIKhxU12C3SA9tQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzfcGN4nFb360Xf5oHU3nEu7/JaQclaJdbeVBfIRRweu0g0zK
	gj+WZNqFtLnvHqFcewXg4dW9zvrZfhLXHFRj+28NH95fwrdbz6/U9D03V1ZRjE9mJ18SdbqsuD9
	19zWCAzz5gvNyAFMUf8GSLvZhjhZ836gJlIBJzcNC
X-Gm-Gg: AeBDies2hAiiXiBZPdbwcHgKbjPbqxwBjYvEboPICA+3hSpeTrtoE7olay54HScRio8
	9BxiT7UYf18BLUqYnRaswn7GU2AV1i5c2D+IKriB7drHOIBiU73pnO3EpWJxIehgMkrYIDbmVa2
	jqwfOzbcXPOvNRwnrlilsTnAHKm/96TKGHsPfxoNOL4ay88u7tQpDF2QL9cj6Kdh4YmhDdMy1tr
	4Z3QIuUlmZZ/sislh58CUJxhZ9c/NqyWBbHm5FmPafBS8pfdp/eYvgar575R95OJB+uRSJ8tErY
	gigO36JrKNBrK3qOX+oDQ289b0/gPHUk9h2Ne3v5ECatNtUvE/6Qg3ntbs3bVIywKlJKWaW1ZGH
	zDOSOJO0=
X-Received: by 2002:a05:7022:2210:b0:119:e56c:18ab with SMTP id
 a92af1059eb24-12c34ede9a4mr1042759c88.19.1775802147879; Thu, 09 Apr 2026
 23:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-6-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-6-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:22:16 -0700
X-Gm-Features: AQROBzDYbL64JYoKRFKy3IJSAfw3hVgsqBRz8HK8WdsFdVBHjeQyIk_Aq7IUKjE
Message-ID: <CAAVpQUCd9jFcuRc2iW-A6od6rO=iSvOsoyDFKfVyV6CdKAxP8g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/10] net: team: Rename enablement functions
 and struct members to tx
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277265-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4011F3D2BBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> Add no functional changes, but rename enablement functions, variables
> etc. that are used in teaming driver transmit decisions.
>
> Since rx and tx enablement are still coupled, some of the variables
> renamed in this patch are still used for the rx path, but that will
> change in a follow-up patch.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

