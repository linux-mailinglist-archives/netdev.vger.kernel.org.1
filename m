Return-Path: <netdev+bounces-248849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BFCD0FC87
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D86E302FCDB
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229521883E;
	Sun, 11 Jan 2026 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmtByQrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF21E7660
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768162798; cv=none; b=OdzEKrnjOlOGx953wr1G8s0PncKrL+v26BYe4GG4gpAquHk3V+UXNF8mvjBTel6MQfaG5+4huDI1P3ppMot2r6hFvjlTGGyE7UnL/csLezBbSQ9LuhyOgUZtyt8ZOU6AAoVsQw8mSdwK8n4P8cwqA3TEyAnS2rs+IexdtYqRXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768162798; c=relaxed/simple;
	bh=Aqq6VhtUdZ3ZivjrFIlzF3Gnxc2ceWxGLrMucjvbmW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw7kY2aormb2dcmY/JRNLlB+k3qcW9VV9LMB73eg9SsAf9EqihZVwMsdCWJasMHvSAosLvPlIK1zSNAaeo7eJ5A+cOfzIbKwPvl/jpU8C1AqWGDHYrfG8ey+JutUqK9j1oaJEhhKyQcx0Pq+uKxzrS6sI3aydXjjQOU4/EgMekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmtByQrB; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b19939070fso4853475eec.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768162796; x=1768767596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8iDV6V2+NGOTnD0NKZZ1W48lQquPba44K9+tW4aIAE=;
        b=dmtByQrBDdYanlSHxkKT2fTyDOZDakdvbzd8XAdTw+q+59XGPpBiO7/SEKP3URv0sq
         4wMePZWSbCwK70epeEmF23VyZCyePzXuOn9HG7IdeQi9yaovg1V3FXM2/nNlsB4Lab5I
         Qq4+m9EEz1MhFswTPuh5tPaJqhZLeuA606w2S9FBItHOpRLd4O1fA9Z+6Uq0nOrzFXWl
         SCKAVeNVauxUK7sp0A7IcujpUriAL50hnl6I6v5qiZR3erBxSY6DDPKxIDUXPuNzXoo8
         oBGKSrxCvr1HeV821k0h0Q0Z3DWFkwrTj+kMtbMOb4vz4Ssr32s97pkdgMgaGHxau8eE
         tl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768162796; x=1768767596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8iDV6V2+NGOTnD0NKZZ1W48lQquPba44K9+tW4aIAE=;
        b=dg6dYJmyKlm67pf9budHM15NCePcCh2QYPuHjQCPqTYNKTmFKp1aFX7R3nm0zZ2NTU
         qVuc8WC+lm/gvd/x0mA66W8+3mLmsU46ZudvHAbFl2rGvKeS9qTIHU0CHu66oQMZYoNR
         tsR84ImCf/nuWPlj+PIayszJ7/EqoMnIo0KnjTRmWV0grYOu4by6tpcirWDdVCSKbFoT
         s00lPhxvtAu0S7konkKKgU57x2k++C4jnOCe59e6Yi9eYn/iiFjzqd9Kw/xQkp2OJxEA
         fwLMAVtgfBOUh2SpOuKChbx9GgmmchjvAIZmZxZO+xUHJ150L7wVC1mRe+SiXgvheYP/
         CZoA==
X-Forwarded-Encrypted: i=1; AJvYcCWn/mijkHyCE7znDbVj5pcq+A5+MU0rDRuNrm9f4UzXtUmmKU+K5ihcEqOXbGJEC+8E7RCSGAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjHIFJzHew9rPZppW5mF6ux0Du7wYwoJ2sN+JYukE0GNsnL9O
	nvfD9VK51rFDVT0pjoxJdCyzVT4oJTab8H0unlUfBEI/Fx490huVjBI=
X-Gm-Gg: AY/fxX6VyzE642EZwzhxlx9ExqzPQe/GTLCiIMtgnTO43rcW0z5bhOoVx4LqMUnGO8c
	HVeU3v2AK1HAVCzyPktjpe1mUrTkFFNqdapo4wYXVn1ejl7n0m42HbtUUSecnKCNKEJAxlzNqin
	Y9g1X/fFiCYNLiSSD4+Ze5l3CUOebtGoYD0erNp8+M5LbWYwQG+MriVAABvoJr2l2m5V7hfWQGS
	IlY3gdo2zFDHSGJAm0WQ6tYtL9ZUDfUcz6XcHHO7GjjwGBKuFxsH7DUDFFrk5u3mZK/FDkCDli3
	HIgfiQ6yX2c++OnN1gE1/PiQpPAAZ8KZPEqqWNf5B8ipwAqBzwEj6/fcobzcRrY3gW0Euosxf4n
	GVb/AlPxSw3G2QE6uRh/eavFgdMuAfZXdbbMmOJYuA73gGor2rTSGSFl4trT4taq+t1s06Z6jw1
	0dqK8JG32KRtH/WAKGIpiB0CO2A+oOPIx3q9C1wToRtOcPsXBVsPd0mxxnzAYcz/+ka8sVY8Nhl
	jcGCw==
X-Google-Smtp-Source: AGHT+IHI1pe1VEQ2hmNsY9IQUfdmsVPYr8vwU5a4B7AF9xqbng/okQTCRr18B/xkeKKdUSDl44Jo6g==
X-Received: by 2002:a05:7022:a8e:b0:11b:9386:a3cc with SMTP id a92af1059eb24-121f8b6f402mr16868426c88.45.1768162795861;
        Sun, 11 Jan 2026 12:19:55 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12316f2db84sm4043169c88.14.2026.01.11.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:19:55 -0800 (PST)
Date: Sun, 11 Jan 2026 12:19:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, donald.hunter@gmail.com, gal@nvidia.com
Subject: Re: [PATCH net-next v2 0/7] tools: ynl: cli: improve the help and doc
Message-ID: <aWQF6k1KW_iC63nZ@mini-arch>
References: <20260110233142.3921386-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110233142.3921386-1-kuba@kernel.org>

On 01/10, Jakub Kicinski wrote:
> I had some time on the plane to LPC, so here are improvements
> to the --help and --list-attrs handling of YNL CLI which seem
> in order given growing use of YNL as a real CLI tool.
> 
> v2:
>  - patch 2: remove unnecessary isatty() check
> v1: https://lore.kernel.org/20260109211756.3342477-1-kuba@kernel.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

