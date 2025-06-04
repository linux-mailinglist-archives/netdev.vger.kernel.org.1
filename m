Return-Path: <netdev+bounces-195061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F95ACDB63
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE583A4DF9
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C2928C022;
	Wed,  4 Jun 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThaFZy2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCE224AF2
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030552; cv=none; b=Mmwrvb1iMnA3j2EWT2QQ4J5qWbvd246aN06Zu0H9ZaFcCAUl4TdXKiikLCWMAA9GRvOlKIhptcAb+wEVvp9IH2nEiyLZlQGvt94woAo5Ja/QQJmcAIxmhuoLJiFBeGu9FFomaizoa9fLMhI2UkzVO8QfzR1YKF4aUv+tGjao6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030552; c=relaxed/simple;
	bh=3CXLpyKzyKD3FD2pp8aEVKNjuiLBtIn0GNRWsJPiinM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jHZ8JU8HrlXFacjYs1sHeeFURJJqHfHEGX+ksFCNcty5ScHli33i8ME44pe5aZ9o73cSVyfFautZQ966PUBEMBj+2N9ctQywP0LXwZvY3pxTtuWxIQD4hJw/VI1eAx5B5USpAh3uU3vS7DnJN3G7E3eB3nwKuHUeRQrB4ANh9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThaFZy2A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce671a08so42386675e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749030549; x=1749635349; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CXLpyKzyKD3FD2pp8aEVKNjuiLBtIn0GNRWsJPiinM=;
        b=ThaFZy2Aw/fsAgmN9zNlLK3GGmN9tJVBfbsIZJNTmVa0fMHjHWpG0SuLNZRRQscj0w
         KSF+NPG8C2ZueOdGbyB+e7j4YNmcWUJ/zLXWaQX0RNuJ7J8gBPfQDFXa+NTa6ysJqcjx
         jUS1SJmjjU8drA0Q+Pe1fj96S7/NhlyDT8eTDGu49Go8fzXJm7EDEZI9lT2zcXXCTMPf
         9rd/3/LbLiCzzluWPAUnMwqfYjbx+9BYpiYaZ9QsJZpHRHeT2wthZ2pXM3xnm34Jwxmz
         4jGTbfIpiqAweMZWdoc5kIvNQIFUuu6m0MPmH3FoWNPe46HxvCHlvimWtWct7i1bhpvG
         iJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030549; x=1749635349;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CXLpyKzyKD3FD2pp8aEVKNjuiLBtIn0GNRWsJPiinM=;
        b=q/kbEIM5uwGiLxLvixSBmeIREt0sZH8zTK3DVaLCEkSvioQ0xsguX/bqlxYIODKMJX
         1Gq1D3hvZEjzjHzw4VZFQihFAubVn6I+kE/Ukr9R/0LFdnUt3izTu9IIq9YwdtqLhmR2
         wmYivRKWKxxUoxdm8LbN46QpsKxYc/tzdZTDneeJ0yXtcrbhUpbzsfJ77A1323npuMDs
         vQ1h9PKmXlscs8ZILK1SHyiL74rrdlX/cJBf5bdfGLq0uYUd0JeStjuMlkuel+S10H3S
         IHsTfJwlTcekebf+QnCJvSEcLz87N5V9fY0p14RzI7Yky8DGMjGnoWx50cpQF/DXPGhn
         snxw==
X-Forwarded-Encrypted: i=1; AJvYcCVA7gUTubndrfkku2jmqozxcEpeZRptgR4jlJ5EDT9KekWa6DA3Mm87bSpDDPOMRYcPJNtxtXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NlW+CN4NKi/Yr8ljV16dto5Hp7k2NtBL4UxGlhSIgQOJ4KVv
	PZ/YoCZhpmjTsCwiDbU+5PUOipQPiUoKG50Pd0H1HqZgStUq+fzMjNFd
X-Gm-Gg: ASbGncvQcz5ySmviG5nVV+gbQQBaug+NB0ODA/H/U1c6ZoGYaIkppXTGbrQOZO0Oup2
	R5/eSqV63AilzlQFx4NuVipUy4Bx9VjGUh7b7vW/fHh1fAT6CxBRbU861P2OsxiFin8GoqHBIL/
	1MrEZhAMybabJGmJBGVDFTQPNv5bWtjiVfTYxjKZLnoT4m5Z+J3UJkS1avsDoGMXJ+/moG3MHCO
	aT6Eolo8LpjHl4wcJN9Btcmlfcr41CY/D7EAonKfcIkl1cn4RyVaw7o0OvcuFCAgoIW59tgxDWs
	856MGRFapbkwNI2tVeBsEaKFmIftvTylyliG8OjmnrZP6rKr7J6wm+8rTiO9+PU4
X-Google-Smtp-Source: AGHT+IHBszuIaTrLHjyGLh0AOYn2c7mS3BSi66w6+3CnmtiRo3y3KzGRrwFFv8YK2ZK2HFymNApAhw==
X-Received: by 2002:a05:6000:2886:b0:3a4:f6c4:355a with SMTP id ffacd0b85a97d-3a51d984213mr1632298f8f.57.1749030548836;
        Wed, 04 Jun 2025 02:49:08 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3176:4b1c:8227:69ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a0421sm21396047f8f.97.2025.06.04.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:49:08 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  willemb@google.com
Subject: Re: [PATCH net 1/2] netlink: specs: rt-link: add missing byte-order
 properties
In-Reply-To: <20250603135357.502626-2-kuba@kernel.org>
Date: Wed, 04 Jun 2025 09:56:21 +0100
Message-ID: <m2tt4vvqa2.fsf@gmail.com>
References: <20250603135357.502626-1-kuba@kernel.org>
	<20250603135357.502626-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> A number of fields in the ip tunnels are lacking the big-endian
> designation. I suspect this is not intentional, as decoding
> the ports with the right endian seems objectively beneficial.
>
> Fixes: 6ffdbb93a59c ("netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs")
> Fixes: 077b6022d24b ("doc/netlink/specs: Add sub-message type to rt_link family")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

