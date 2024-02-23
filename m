Return-Path: <netdev+bounces-74447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D178615B8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B271F22A53
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600382D75;
	Fri, 23 Feb 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHw7j6Cg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A535FEE5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701948; cv=none; b=SeRcs5FZD3KU9V1mjyHMcXWQlk9L7HEzjBQV+zMkA39q48elIb/patai2eJ1R5oxK3ulakYprB+RE+r/HK7GNoKnn+A+q4BwcvCB/rak07G8kCHQCe8wMG/2v1tDEtx1YJDqNj6PX7czvObfQFMLMFLBfBz6BPnx5S4UyW8MS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701948; c=relaxed/simple;
	bh=GO2CSq1+Ines/OBru0SgmMfnf20aCSsbBZSiFrjrFSc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=R6p9H2xUSBOmQ3EZuvRkKuRef6dzN9Tb56FOpaHfoNI9Q5d1YbvHWTZfBZLdF4p1mZ32eb82Pi+bc0RHlyKQQ39ArkKVCxGhkHV5Bcp1+MqJvPFdgp7iIdK5fdBqIFWN3TU03nSuBY+eaWgeF8wfH1KSS7LyFACPoWIC6fGSUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHw7j6Cg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so5673961fa.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701944; x=1709306744; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GO2CSq1+Ines/OBru0SgmMfnf20aCSsbBZSiFrjrFSc=;
        b=aHw7j6CgymFXFWGc8Q4RVRd1RkM1s/fXGd13RMAwjeiJDiCAeBnAK+SU+mKuWTLxKC
         m99afobQUh822wCWOJVLeYZ9HY2sz03h9LfG7tri7Wncg8b3447bfrbBXI9Qu75PqVlf
         NRUm5SB2/x7y0OKC2+xbGT3dPXQd4B+cWPjHuFG8bZ9lhPN8XyJx5jo37uB5t8ImCzKm
         ZwbokH2VxNakO/vKsaw/t+DiH5izpFvYgcUsYt/vMFHzzJCdr5HNepf31rlkJKL6akFl
         H7ZmlBefXgusfZFN+rf6s4WAuMx+k06B5xwMAuVl0o0No8J6nboCTtfVMtHqkdVyCxEs
         q/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701944; x=1709306744;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO2CSq1+Ines/OBru0SgmMfnf20aCSsbBZSiFrjrFSc=;
        b=Dozm9xgrbydFJhnd938bKAcG1XCD8LtStXPS8a1kOxoGFNls6C2hCKAaQoZocLl309
         kM7wP6Vzfo+WvCEl7hRf+xsC9kmZPAdYVSW2FYiOjbzIBXVVcw0U9AOaz87aQVZqyYKA
         AE2hegBeYWuV7zdGDwCN9TNnfZ0BRxZhHzo5/JfRIli7/RElXJZt9xPNfEaZiEgtfZ4S
         hpe/z3i1p0mmfHXXexJ1yMCsgdm1aE1qO1Fb40pcRfXXLHyi1lT2U1LHR8UDPNcEaBMa
         M+ExTa9phNIw21mrQt1ciIWRXxeEP/zV+7OyclkLlyNA0oSBgZ/mD7gMNM5uQl7SCKLX
         kHOg==
X-Forwarded-Encrypted: i=1; AJvYcCUPGBMEG2VwN4swQeLxuwwTJ1z5oa13386bRAqjnI4qjWWC6i/4WDijY0QofL8ITH4AAI/UWk75QDQAr1ykNyQZ81l1kXEH
X-Gm-Message-State: AOJu0YwE/rpzE9lNsjx2Cq/kS5fmGkAC0aAGN6vDynpnU5bPwxgGwkH0
	DAeu4M+JnTcgskZehUekypILeURxcPBLuH/FEshxtfd0HZlOI1BP
X-Google-Smtp-Source: AGHT+IHn4ixpFR/rAp624aWM7VqeYYeEMA6GlN0Vte/VNr9Q0gIMUhzfBjHuZRXgUULM6yH/PjmTuQ==
X-Received: by 2002:a2e:b16d:0:b0:2d2:75ef:3445 with SMTP id a13-20020a2eb16d000000b002d275ef3445mr106736ljm.48.1708701944228;
        Fri, 23 Feb 2024 07:25:44 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id jt2-20020a05600c568200b0041290cd9483sm2690757wmb.28.2024.02.23.07.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:43 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 14/14] rtnetlink: provide RCU protection to
 rtnl_fill_prop_list()
In-Reply-To: <20240222105021.1943116-15-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:21 +0000")
Date: Fri, 23 Feb 2024 13:03:10 +0000
Message-ID: <m25xyfs581.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-15-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> We want to be able to run rtnl_fill_ifinfo() under RCU protection
> instead of RTNL in the future.
>
> dev->name_node items are already rcu protected.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

