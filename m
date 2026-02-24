Return-Path: <netdev+bounces-260446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKAtBCx8nWksQQQAu9opvQ
	(envelope-from <netdev+bounces-260446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:23:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 668F718545A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF3B23034649
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542A377560;
	Tue, 24 Feb 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4AepvS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44230372B55
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928612; cv=pass; b=Fev8+1kAsnIK0TH+BXpN3xm66brcnypkfNXU2sd7+GDzwOwCy2G/soMmRZd9oJxiqCBUqdnJKhoJIQnQX8gn2eiJTVIQTKc1jLkcG7nCTjrTnPHGuLI/VdoLw2sIObMsWi9wZEhg0ixV4Dx37UqIVvYaD8Op8JWk24V0cgJsgm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928612; c=relaxed/simple;
	bh=ymDqEaqh+DYHAffBFXkae5tLcnYn/gYShXk2GNzvf2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNSaca6k87NYULkaoP3cycS3sDZKtouYsqacZDjpUSpcsY2vr67n43om+Bp1XRXK6Fuv51WHKwG2vA3/PDUEr2jeij9/dCkFVE5NGuk+1DP1CC386uAO52uDD8h53KFuFyrAMs9JMp+8liqR89iw0MErt+dykomAI5nqUPWPT4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4AepvS7; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50334dd44d2so64460411cf.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:23:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928610; cv=none;
        d=google.com; s=arc-20240605;
        b=fmLZOWKwcuineVRWupdhvzKf5lOOolWrF5gJqibBAI0nLr8F9tShQDhvu0YmutP2ab
         Bz48b/nBEekkGuSIEkOZDiAaMoSmupEqe15NnqROtYn138p3XoR2rPnApEft9rgla0BK
         uGr3XBPawMNLX9bhUK7Qk85+BFqG04KtCvthdpQqwL6AQVq5vSHjc80uciBT88fgUBGS
         e6z/t7LiO/l934M0IYQwz5h4Q37/fbzJj9L97ypsuyt5tw2tt9xdgerTDWpXVFNUoNGo
         IiFEGIe4QFQS/6yB4W3/3exMtxyzAehat35GSCwO8UvEZm24s/RPIM+AyD2E6rIo9hlM
         te4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ymDqEaqh+DYHAffBFXkae5tLcnYn/gYShXk2GNzvf2Q=;
        fh=EcL4liHjVoc9ppEiI915Sr/YeP3GzaDU54WMyW9/Log=;
        b=fRV/+Zr/RymwpOfbeqowWimVFKUBUQS4OdeZM65txrjhftn6ujWeAJ5v7zmymsG/t7
         wdKiCVA4Vb8AGV80nLYOovUnSYfcHAmI70s2JfDcPi3kQaEI9g6b3maIAHIhNvppvKcB
         t/w7ns6XLwPmdAnC+evMRgmcUI0fK3fMadpBQ+p+n342R0Ggn6qhkmP1+vqu4uG+A4en
         BxAQ4QfmQkqQ6LrRyxRy1tTBZsTjmlaiuqZYoAP0pMYF42LpVdaakUTdgsXx/XseFOrf
         JNBhMexpCBtpkthPbKRrgJ0Kf/P1GvJysxDmHzBDU1ZRU2sDsH5LaFWPL0tYFQON3xL3
         hm2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771928610; x=1772533410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymDqEaqh+DYHAffBFXkae5tLcnYn/gYShXk2GNzvf2Q=;
        b=I4AepvS7p4FEOxBSVC1bLUxVSkEuZxLhOsqUGfWApn46c8QE2c304CyjlBu1adzsdZ
         Xv239TauWrVJbTyG940QdPxsdr5k52pY8DDgcqo8NdZe59bKUNwBIRESU9iKSGfif7ei
         SuQ2TTw0GCUd8GNNDphvxm33Fo5ZGYBlocx4ODkPJmBG1fxVIssr0hkjG96EmNcJUeSi
         DA9MD4imouOehiflI9j/KcyoN+sOsf7Og6XL1YH89CO6/ggfgHRJRLX9SkTlgFNA0Azq
         0jcZz0TlvvhgcFBL5Vp/J+Qo4Z4vh6PLng6i950/ROc34Zdyi7ekBssmhFyRqT1lLnoX
         56Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928610; x=1772533410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ymDqEaqh+DYHAffBFXkae5tLcnYn/gYShXk2GNzvf2Q=;
        b=ooX0W/bgViP6d+n1j/nh2mCmycnHcf0iijdhYZm4tW6pVYs58afFlxuySxEatZE6ge
         qpKDccwvmRSsDNyyyEPBnd1dUEIyiAlWnuD5EE1fXimQ9r5AjbZAg7Ga+9bjunFt+Wu2
         nNWVgX6zAIHV1Ar/AhEoZUEAAbK+KejgRLlIWhar7psoBfP1SHaTmO1Tnmi0JefHjbui
         tO7FYQdeBuyjEfoxWx2IYZzUXT7FTZVK1VHVNCVi2gQQi1c0988E+/9cQqQ2GLy8q59P
         LZ+Gd+p54pzOV0czhhRuEugMtgRYn/MZbCLEhD1jMDJbfUeUviBEFMf1GOc0GewBYupF
         3Ikw==
X-Forwarded-Encrypted: i=1; AJvYcCVVxdWqR+Zob1qIPGkl0RVNdPhcZmSfy893P/H6uhnKmPubhqmFarEdWVxD0lq3iSLntB+ThyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+s3UKHWqDLJtqRkhQZ7LLmweHlB+2D2u5hiJC6rBfinausekl
	wut6qThvP+sOM3yNUNiRNcKn1h2jfzPCYNey9XyLdoDYMCRfEwEPSdntKHe+fzX3oZyqRojKwcI
	POSeIZMsi76Ss5g/SXzLVdiAxaikVjncrr7RjFHJ2
X-Gm-Gg: AZuq6aKBeMMZOUZpoWtTmSC78tTZnr03jc/Iz5FaApMAHCEvkgnOT9KkBfOVV6ZG9O4
	yXIy33UWrJCSdFfvyV73NmXZWs47+uL/DopNyEv3PBZpWFH3pOWlCMAaLZ4pZ2MwFt95bo1Cjcj
	3ovhVDOjDFiDLOKTZBh9zyFE4vtUpRdgMOtPCYN5Xs/RhCcAspCwdPjLvjtIExFPzWpogymx+xc
	iZtovlVzEjEoLKC0quW3yaZxOWFvXGBGFZTwvXtaH3yvCF4Y0yw8fD1g6EnT7dwuofY0LwTXB0q
	kOPVCuaV6tcZUmDpgU4lg9M+Uggg5Qcv03o6bF3NEw==
X-Received: by 2002:a05:622a:1922:b0:4ed:1af6:230e with SMTP id
 d75a77b69052e-5070bca84eamr178606781cf.56.1771928609635; Tue, 24 Feb 2026
 02:23:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com> <20260224-fix_zero_wnd_fin-v2-2-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-2-a16677ea7cea@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 11:23:18 +0100
X-Gm-Features: AaiRm51O2cYH41gYEaKTeYeCg89LxXcA37cvIPhJnxQvNGjzHQ_0BEV3gL6Q3vQ
Message-ID: <CANn89iKLHvYS0BqdVji+N_g4ee0h1x8w1H_XHmRRguH=M8LRyw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: packetdrill: Verify acceptance
 of FIN packets when RWIN is 0
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260446-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 668F718545A
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 9:20=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Add a packetdrill test that verifies we accept bare FIN packets when
> the advertised receive window is zero.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

