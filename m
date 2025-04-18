Return-Path: <netdev+bounces-184124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11057A9363E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D29B1B65D71
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8DB2750E2;
	Fri, 18 Apr 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmeRM9me"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73C2741C9
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974007; cv=none; b=h8o9oRHV6u3SpJfi77Vkn964gOIBb//vD4dgFob0OwrgaaA4Xuj8kOug1zyu9h4xGoEgjnN7LxjT9gtN8bR26IcQ+8lpkGdxSHGSvQ4un0R4ijMoLHKl/pQ0eyZiATYN7OthnRMkQ6PqclOMBoZMll8G0DCWTx4AwzfYbO4rnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974007; c=relaxed/simple;
	bh=CJMiGFOLQydxo3sVDZpok4VKvZRgAsNB9PCSGUQZeQ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RT6OgqQy/xSbLoDGxM/xIfQ7S/rB75Vsq5Re61BDmMf46rjkuptK/SwAsstfj+bfyS3P8kgT2mvQKCaTG8KKEJ9cIp0x1RYHqrU5SCeO+E7eXN49GGEqqYUDWcUvctsaqd2Pe8gt8Ejl710Tqv4+teWuePqnsqIzLJXsO46YI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmeRM9me; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso12337265e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974004; x=1745578804; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJMiGFOLQydxo3sVDZpok4VKvZRgAsNB9PCSGUQZeQ0=;
        b=DmeRM9me/lt9BDMUQjEJqXMWUhq+AuIBI7dEmlmx6kVm33TMCMk0g241YWS/Ia0l9T
         1havaHncKiy7CgpKweZrBEBgXfE0NpoclnxQF+2eadaOUjLBpldbHwxDIwPA3Mh10B/u
         fauUgaSBP+c1d3oHlf4TJEZQlMeyeT+i/nShh9zZ6X7yQLLAKIUaXboO5RK82Lqmy9Ba
         VLREtYxdHTdV+I11tt7YClNezbavfpqRjjUGL079lSB7MUQSL8PVV3jFUazCeHvEdkgy
         LksxkZSk4YBLnc9UO+O7RULX36y1qlhAxaKtNzcW/BURA53GgnKgrz9+lIzFI+RERXiP
         +wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974004; x=1745578804;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJMiGFOLQydxo3sVDZpok4VKvZRgAsNB9PCSGUQZeQ0=;
        b=OlkyI9pkCeEDlDSaYjCBLApQA7aKRFevwoXdqJcsypHChwEKNxRyaJiPoaHtgLBlpC
         yXGNpzDClyKt96LUNEeuLIiZo1jRn96B16AS2saMIHkGGMRjKwKwCiLKiFJKOVVOsFKD
         zk1/3m1ip6QRm7w7LDvDf8D8W9AeviaoxfL10UDIlmgbvJxnSUrx0AqxMo2SRNeuao5H
         ruRTI6TOHfNPL5HTlafwHCF3WQ0a/oEtEl7Jz7EiQid2gU7O0FBFhLwLhMRgkqDOiqG/
         BhDxIrTk8xtG5+BdvQwkvrx3xohTPvG+mB/PQLYakwm6/KVxXUucpZaBVwQwv5pdJj/w
         3Mdw==
X-Forwarded-Encrypted: i=1; AJvYcCVX9Bow8LO9brDrVvFBgtlGe+euVmuDWitiCyFvKvZGSs/tayDuP+q9UhbclEeOEar9jBYq9/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9LOBYkE+oRbC3JdloUECuLyanOoxEHyNiP9TJzJEGIxsyR8G
	Afxjf2SyD9ybW3mZac5SjHdpbX5uNhL3+n21nwp+ietLpeiO04p4
X-Gm-Gg: ASbGncuuV6m5K3OG6Y5qKAMVHJ0RFe/UXWh7BnzOmmL1mMD8MGXocDAbKdFbtMgTFrg
	f+DQh6vGdMe8XYp5FZFUPRI9Wv3PfXa14QKZdux6/tkwlAQ2vSSqKuMzmUua1rtyzexM4c3PN/8
	o4aP8nqN/dfuhhwi0BbnvSSipZwQnLWsr+NciC0Qp72aTfP30+MGHV+dvICRNI2fAGQ278t16X+
	caUZ19bGApd8FU/KKUhtgtVZFvulw/QzdN7PVlS3bLwG7TAVlP3Akcs7J6VijaDPihjfLRiN11n
	6wtV3TLXPP+QEgV9v+rSp6SDKyJ/XOzOFvO15y59fx+lThu4HYcAZqJFpKAxWhVmLQJ+UA==
X-Google-Smtp-Source: AGHT+IHk6Bh4bscsSD0UuhoOKMkOAlv/HyQpTivaF2T5C/wenuip+bkt4IqSmtIGzipF5KnrKcHlOQ==
X-Received: by 2002:a05:600c:354f:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-4406ac218e0mr18364125e9.31.1744974003494;
        Fri, 18 Apr 2025 04:00:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406e0cc627sm11070505e9.1.2025.04.18.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 07/12] netlink: specs: rt-link: make bond's
 ipv6 address attribute fixed size
In-Reply-To: <20250418021706.1967583-8-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:01 -0700")
Date: Fri, 18 Apr 2025 11:39:47 +0100
Message-ID: <m2jz7hiwi4.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> ns-ip6-target is an indexed-array. Codegen for variable size binary
> array would be a bit tedious, tell C that we know the size of these
> attributes, since they are IPv6 addrs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

