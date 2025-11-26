Return-Path: <netdev+bounces-241720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2FC87A44
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D53AF77D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2A1DD877;
	Wed, 26 Nov 2025 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGRoUw4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153A25A62E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119313; cv=none; b=sXXIq56l0IJ9pSTbkt8aEy3TE6mh9hJ2j7pJLr4huQyVh7C805fngeaniZbLgR4q1pFYKapJGFvbUXJie54WfH3MedUTUkHmCGgrSYd0mfoj4McTarlbXCMKJx/2F5gCBpJY7ZwSke4TaRMwpMYQO/ukk9zNLXihPsn2Nl0ypcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119313; c=relaxed/simple;
	bh=qGR5sefQg32LQ3hhTnRZYyhaV7WKbliA5YNanSMxxwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+LfeuZIpRxiyV4Dz14vNg9SmGOoAufgOtB9729mfrnjVAkltYTtxUck5pGtkaGka18GUVVAVDEHft6tFj5g2FJN8VHY0dtTfNtp9chAodS+M29JpPc/MxxUx3BCHUHtZDRj1gE7603rT1yL5ChGneYble6LWGuSUil25K4q6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGRoUw4w; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5958232f806so6518221e87.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764119310; x=1764724110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPke9ePUWIJpnNLmmVA+cr1L6xKsPBiMVIzyNRr3D9I=;
        b=iGRoUw4wsYljZyVbOJ7ZCdNoF9ngRojwLLXrLdV4niLovcInNsgBEMRXtjUnFHPoBu
         g7TX5ARZBJVtstFyVrapqggeG2LgrCut5rmcEk57/mS1uCrhERO1wh4wonX6mcqiCpOu
         o3+Y9vrPTIBCJ3K6ps2xZdVjiioMC67ZrHLDsW2xue/F1dzhi93D3xSt+QCy90QjvHLq
         zoIPViJoNzWLWYRLHLrA+Vf1ZOTu2kZBNx2qEmZ1wv8cy8vBy3odlztr68cFciasedQ4
         om7YQXGqEfQ0xAV3Gp8Wekss4eJ0PwlG+Pn/U/ssezxbwp6ea/ESJ5LihMThsCHFSlT0
         Vexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764119310; x=1764724110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPke9ePUWIJpnNLmmVA+cr1L6xKsPBiMVIzyNRr3D9I=;
        b=E3fZLVzH7E/Wr/vq31H8HF4dq56xH1ihmDDcYeCyguskrB2TTtLXgl1d0EAge2QDQD
         jjWucnSRiT2jwLTanOxFzeqJ0NdeEKpUQiu+sKuOtyaTD0vOJKB8Unof9qrxXoN+ymM6
         tgB8V6Pam7tXaLcYkxPSHWnOwZOwTWyRT3QYHQvMe63fv1IXKn3UIpgxHbcv/MMyzEum
         x2AnOrcafmNmakOzEsIIPw/WhDoyVSYrDgPxZLaB/Gx9LUosxuH4mpURxFnIbUlLJEku
         3PcWYzdSiSq5iTy2Z9KgKR8WZmFxROnb1ZuEP3EsHFRSM93XU1u9gW/N0YvmztgU15Hz
         lmBQ==
X-Gm-Message-State: AOJu0Yzp240V5HfmkRi7lLDgzzq2jQYjzc95Z3doQlBaYhiSehCZX475
	306Yl8f9SdmeOVUbLiZ+UF32MhatQKFfCaWSEaxZcmG9Btwc4jq8qOsCzgY62+RmCXILoc4WSQe
	fJMtpmk1178cGS5Ft1aU5mscamTj1skU=
X-Gm-Gg: ASbGnct+AblsCzt4/63BYpEh4cP0l/4h1+HvlnzRZCD16MUm3AFSzM488F6GU+pLDPY
	Of5KE0Ux1yAc3TNGreODzGu2Sb5aIEJPoptEmwXCyFB5bkIWAa17hr6wVjOBtWeCZ+CssDuyN/g
	UE35IhFnIfYU62YEzNnTmyBkH6qgCHSpbWg/JrXYfpNWQF48jZrC1xMaQh4JArNsOx6aVzAHcHc
	0e10cviYrRU+Hv4x9jqxhbwvrRo72i/rTVTTZIZwkyvmElzkcEVNeVjmic2GPlg9ezo8SybtjD2
	HGzU9EQ=
X-Google-Smtp-Source: AGHT+IHE/HsOueEOnqyeixj2onqOHgnn9FMVGbhVt/9pSvUtRuiaOaEnwQmonHOEqIinS/NE0/4Api3s+LV3xZ2ZMT8=
X-Received: by 2002:a05:6512:ad0:b0:591:c3f1:474d with SMTP id
 2adb3069b0e04-596a3eac18bmr4863543e87.15.1764119309708; Tue, 25 Nov 2025
 17:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015933.3618528-1-maze@google.com> <CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
 <20251121064333.3668e50e@kernel.org>
In-Reply-To: <20251121064333.3668e50e@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Tue, 25 Nov 2025 17:08:17 -0800
X-Gm-Features: AWmQ_bkqs5856q_ExMgqNAtj115endk8-jgZ3MeYzOr0ypePgHpZa5Y_Vk-wTQE
Message-ID: <CAHo-OoxLYpbXMZFY+b7Wb8Dh1MNQXb2WEPNnV_+d_MOisipy=A@mail.gmail.com>
Subject: Re: [PATCH net] net: fix propagation of EPERM from tcp_connect()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Neal Cardwell <ncardwell@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> FWIW this breaks the mptcp_join.sh test, too:

What do you mean by 'too', does it break something else as well, or
just the quoted mptcp_join?

> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/394900/1-mptcp-join-sh/stdout

My still very preliminary investigation is that this is actually
correct (though obviously the tests need to be adjusted).

See tools/testing/selftests/net/mptcp/mptcp_join.sh:89

# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
#                                (ip6 && (ip6[74] & 0xf0) == 0x30)'"
CBPF_MPTCP_SUBOPTION_ADD_ADDR=...

mptcp_join.sh:365
      if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
                      -m tcp --tcp-option 30 \
                      -m bpf --bytecode \
                      "$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
                      -j DROP

So basically this is using iptables -j DROP which presumably
propagates to EPERM and thus results in a faster local failure...

Although this is probably trying to replicate packet loss rather than
a local error...

So I'm not sure if I should:
(a) fix the asserts with new values (presumably easiest by far),
or
(b) change how it does DROP to make it more like network packet loss
(maybe an extra namespace, so the drop is in a diff netns, during
forwarding??? not even sure if that would help though, or maybe add
drop on other netns INPUT instead of OUTPUT).
or
(c) introduce some iptables -j DROP_CN type return... (seems like that
might be worthwhile anyway)

I'll think about it.

