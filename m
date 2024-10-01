Return-Path: <netdev+bounces-130953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80198C35E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1824928138D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13D1C9B84;
	Tue,  1 Oct 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQ/jdD+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5A19CC3F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800017; cv=none; b=XDIU7CP5FzHzmO677NZT0YlO9jq2amy5VVcrNa24tErOsTgEUmnYM97ULih6Vu1Xi5s0uCOQN9MDVczYotXsAHoQRlDAgW3zWfKQgM+oFo7IGu0nI1JtdLSUcmP2cWQtUjixSKZOT5q+F5hxJpOjbBls2dQkDyhv3WRksO2KqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800017; c=relaxed/simple;
	bh=VrBnfLC+zVG9IFbwmPZHicLTfNZlFBrRSS5dHeuq9lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Dn3XgS+THwaNK74ToqOUlQqNFEfT/NgeYIlXeMeP4aLs6VYi/UY3CE48wggGyvNYxR+MiMXt4rM+SSRnKA5/TgzUb4X5etBmsrCPyXwb6ftIgUxpu7IORQtobcs/q9kGwIDiPQIotC7e7sB8QNjJjrj8D43xulkjfld/Qdf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQ/jdD+8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b4a090f3eso204585ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727800016; x=1728404816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VrBnfLC+zVG9IFbwmPZHicLTfNZlFBrRSS5dHeuq9lc=;
        b=lQ/jdD+8AwDRQzwMqcxcYd6wkn2V65gZXTvavuwkX7bUAQYO+TfEESLoocovZhxme1
         xUjE8oXTxu/6E5wWQxLLqTHVArX5X4oyH0ysDHZHjeRZ+at0dN/l2IzXfCPDRR6oEQ/i
         Dz18vKEGgeJy/UT6NDznZkHLjEFsVt1hZXyQRA4abiIrRCZthMdpxwTlYKnmpkpKJD+3
         zxQzefc2qBZYORE8gcBDLC1P1oZtHQNaPQMV0Ay5M1rKJ85HccKWQqI9Nf+ljYWaIQEH
         j7S2zNxqhcDZsuckgg/Sg+pWyniyLAVErPkD4Etyadm4Pg0hoXxKmLHDAkbv1wB1OAF6
         hxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800016; x=1728404816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrBnfLC+zVG9IFbwmPZHicLTfNZlFBrRSS5dHeuq9lc=;
        b=HPtmrET2BgNkLMx1d3j426wXh3UeqlTKhKt9fIQpQbVt31hHvZoTAKMDpe0C1CparQ
         U/aW++MzEsBM1LjiaOQ+lqiSXxA4LS0FmKYaUnPzWXPvutQbqzZeLMdk5POQgUR1wc7h
         Drz+M3p2jRW8ED+yr975kjVjemmnlLGLmL/XX9OfkIKBtpaQ+GLg08BvR4JyvArI/Lhw
         RpUCXmZDif4yCxj1AGzcJnWN0EgjorJe1WLao02EeGLjXiUafIv2k8QD6fTbFlk1RSsz
         hPXtJcPq9DU4qHdyolXSWy7uGIMuan8aJSEe+YDBv9XC8YN3S9i6TgSXdZBnp86r8gwk
         0Q/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9KRzQl72MW39joiMqe+FoCW2ItBZfIu+3PziLmq453IcfzXW6+4g5KC81HV8VcJdF7NmTpgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDLikSPW5rMoZmam/rLMabCABON6K/CS6nqTDUrWoCh3OKNNz
	SuJn1/u8kgErA0ABb7gGdYapAeHhSPbgfprYwhHucofqtYKMEpBYyZqqdJMsJRMVOaz/Ft/1bhB
	2OPpjwuD6co4+OAOqJmAb7h7kL8DXmfdTfLpE9UOfIDKqFbATG529qKA=
X-Google-Smtp-Source: AGHT+IHdrQbAqpejQaNhVvnlIZgEwuDo5VjmqDx/kOgnNdj+gWj66NYWwVdsH2uRpgkV2fh2pLnWhSrh6EUiZbbDSoI=
X-Received: by 2002:a17:903:228a:b0:20b:a3f7:ca8e with SMTP id
 d9443c01a7336-20bb0804a02mr2571395ad.13.1727800015581; Tue, 01 Oct 2024
 09:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905200551.4099064-1-jrife@google.com>
In-Reply-To: <20240905200551.4099064-1-jrife@google.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 1 Oct 2024 09:26:44 -0700
Message-ID: <CADKFtnQGCic1fAQFbwBZVmYsZb2jykaBzPMrOMVuvENxUSZ6bQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

Just reaching out to see if you've had a chance to take a look at this. Thanks!

-Jordan

