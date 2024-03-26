Return-Path: <netdev+bounces-81951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D1388BE2E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2D71F61EEB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB8745CB;
	Tue, 26 Mar 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO4rKBSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095A495E5
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446056; cv=none; b=McclGkOC5PHIPg1PCcL6fT4trU+VKZAPZrWZQ41zFhoK+s/Ih2eP30mwNq0PC/khkLH3eu843hGRiEyRKOJUGd4STnl7E0yZGocWRoRtduR5tHk66mxEESbfz79CpqFPTVWQsdbfe2X1jDLHp19a+Iq3VRlb1Kv5Y93NMHvk914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446056; c=relaxed/simple;
	bh=8MmFCKkdWXObBkao951JP0Qf66WDOmnKn9SArgPQn/Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UrTDUA7+/zsvlAj1vCd3/FYqr117QBVJf1ityStHblaUgsMNntgSTCFAape1DERs8PpHvQhhvlhWOEwqAmScRSMENjAyJ3pO/jGQJ+rzVHA1kRuAaCIe1EKXH9zgUhd1pvA5XAcASTtaLYsi3KJUU/lbwHoOOLe0fj9EmVkp4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO4rKBSr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4148ca200a7so5572405e9.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711446053; x=1712050853; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MmFCKkdWXObBkao951JP0Qf66WDOmnKn9SArgPQn/Y=;
        b=WO4rKBSr1t5YPBUl+UuhNCXCSfuFlU31DI2QabVYhrwrB2TgBwWZv8SLSeCJwOLwVU
         zVZKS5RHyVYrAVsJCnhO2EW4rbuRI5Tlp6NubWZf9Fe/Zj6Fy2nvPC+S1YFwVZoNSRsZ
         gdgElZyweW8pbbAEdNxr70eeqMxumwKgiy67nvC7p+wx49KpBD33Mi02vndsgmJnwKfk
         CMZKqZrVZw5xcD/ghcC6CNMnqSI3VDKfFzhO1TF3v7DnSrvvQHYTDceYeXPC6z34a2ZY
         JSMirqTT4O5n/T6Kr6CrQcsYKJiMurTBS7PpaxKr73XmFxRyQ/o7dSAr6Sud+qfmyqZC
         d7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711446053; x=1712050853;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MmFCKkdWXObBkao951JP0Qf66WDOmnKn9SArgPQn/Y=;
        b=JemQtZSOhsCFdJ47YrqqOPX5DSFavHN2pQEzOxwgmu2ybvpPeIRKCQBuTghK5ls/om
         Qaei6MwG7SLH69dInmqpau7SYcGVxmPzyJ4ynnEId9sE8qlNxsSBPDOHfhiy9qQ+UPbY
         MCJFyc2IlEZUsPI2gA8pdkoOzCamDgxPOpTnwYh3D4Yqth5ym1o9whvrEyiRGeZ+WwTd
         oId516wGs5f01xaP1RNDfX4Dl1lOj6UhKWQaZ6AWBSyrng4T1WOzx7c63lQdd4aUGCv3
         FxiERUQFybcVJLhDIiTnc+pOPWfYQJdr4f71p5fMh7LZpS257440fYfvM5r2Oe2RGtvE
         hrag==
X-Gm-Message-State: AOJu0YzZwtjMb6vV1KLv4n4r1rKClocPfedyYpqj0qEv0qdSJexGpI0m
	nJI6SXvInUp7TstfSN0R+hp+XyOYl8c+R8f3owhF8f3mQCBXQVMS
X-Google-Smtp-Source: AGHT+IHnfT/cQRHCA7n+zypYuaq7xi3hOipyugPqkisY83Mw8s65wXKRNaHpxxbaBj9fHFiBwZb7Pg==
X-Received: by 2002:a05:600c:4fd1:b0:414:695a:bc5a with SMTP id o17-20020a05600c4fd100b00414695abc5amr490045wmq.37.1711446052878;
        Tue, 26 Mar 2024 02:40:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c315300b004146a1bf590sm11052353wmo.32.2024.03.26.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:40:52 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv2 net-next 1/2] ynl: support hex display_hint for integer
In-Reply-To: <20240326024325.2008639-2-liuhangbin@gmail.com> (Hangbin Liu's
	message of "Tue, 26 Mar 2024 10:43:24 +0800")
Date: Tue, 26 Mar 2024 09:13:29 +0000
Message-ID: <m2sf0d1hl2.fsf@gmail.com>
References: <20240326024325.2008639-1-liuhangbin@gmail.com>
	<20240326024325.2008639-2-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> Some times it would be convenient to read the integer as hex, like
> mask values.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

