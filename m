Return-Path: <netdev+bounces-237744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9DC4FDBE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EBA3B4016
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58F2868B5;
	Tue, 11 Nov 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKBZPXhV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124A29CEB
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896810; cv=none; b=lmwihkATLZF2dVgc3Hr5xLhMM/8oYNb2JYTkDMYF3Zf54YaBwGs7dsw9n7VhaZPvYrKGO/3YkhtuD5DlJsnBhzGPtLIaM2EEBy9KuSsN7359Ab9keVKfbx8ynfHDrZ6krdGmr9kdYNGSkfO/REk398EBX+pQHapiVXv6uOtFewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896810; c=relaxed/simple;
	bh=n8jBxOVUAalxgN9ZJKKX3w+ZBPp1hrcpr4OyAmkpbUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHOyNDksRdT9BvZFCV2ezyBThkg4u2Te+jhDg37VVJWMrx2Ol71ZiQogWvqVfBZiYZZgd84b0Q1GaXbRPwW76f7V1ZyL1pC5pMXtGkoiXxv4yav+A2ZhPpLKu+czjL5NYdbX474akWYZv0iZi+JJoJPFPArRleS84XjgJ8KOomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKBZPXhV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso131666b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762896808; x=1763501608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPY55/bpdwpo8ENjAlg3aY2f+XiE/1nDxT+sAWUAluc=;
        b=OKBZPXhV6zkQZnA5yzUcFbmsbWD97ukwH2cf4u2b0kv93lQrRxt59N3K3UAenjzp5g
         nPevkxZISA1Es/UypUtDNUmIfdkZaEMUdmFs/WFa5/76WrBRXBx/fhnRLItZsC2ak9br
         3rynAitpCeOWPNS6ttFPzTnnu44pLkWrKevdiiescOWw1NZLZJdb1SS/HPVNGLVteX7G
         v4nryHrXDTqWQMl/t1Zs+GRjgra0qMScd599usGOvvJ0U5yyQC+Qgw/y3wdiRNuzxrBf
         5khYooUkPwCmq/0nwEv0oAcEjCzCuS/iZ7jqqFxJRlnwRx0GGotCb5SaRaHeC5OKvM6B
         o8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896808; x=1763501608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPY55/bpdwpo8ENjAlg3aY2f+XiE/1nDxT+sAWUAluc=;
        b=IcAyAAC0VP7qZyTS8iymI+SqCJ03LfccnJxjjCPF9gOerFDcyBzmOSQntaZnzix0vQ
         MPUAQGP5MZcuMyK9Hsfbefd7LunR8Wxx0GiwaHYCOkXA2k2fsUUqjn5uD5Cfh57oGw3A
         Pehbij3qwZvxIylyVlhgLhApQlsuiCwjHxGM/vJtsAKnqDisOeCKsogyz6g9TbZtsi3C
         dz/DZRwysZ2V1AeFnWkIHOEDBSYD8TWVfSPVIm/GbajMFMd5lzzf2gJ6n9keicFFS8D/
         Ezqbq0YMQ18idpsP8lgegjv12mFFashlx6vEMOcHRh12qM6vdIngIJpdFVu3cBZd0ysH
         i80A==
X-Forwarded-Encrypted: i=1; AJvYcCWxIe+y4dSk9ZQc/UmczA+96GdG9J5KXV/w3YNEPQJUPiY/vYhWLyuxRuqT5ZdlzMSNegEchhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywclhdh5YZW2C4shEPKzsOZMBZMB4bWSTbDaINZfg8CX1PoNk+h
	F3zh6+xG0iGzJ2sz7JEo++6RArPJZHeL7xb5IBL33lWP/INj8Hv7XBs=
X-Gm-Gg: ASbGncuVe2lmfiqvxsNlaqlVWxyxWqBxSWTYDlUz4dYkUbX/nUJYxe+uB03GvJaYb0X
	1REe0URSG2k7onIFECo9TNIU66wecT5JV8O5VGCJOGKHnkslJQU0Tm62Blr8yv4vUpwpJizDPwa
	3V/Bk/5yvRifvE5zj6AUh8Y91TgWXJZi4d61KeaBFx/GUKRFW+Gf7J33prT4JezGnge4Vgr0GuJ
	eHU8myG6FA8EaLcS/ofVhSGK8hw712UCxJ8BD7QtlMOk0/WXGU93dxETmiDKFJWO1o68NP1OaqJ
	2mfW50o9PoFNAtGU61WGV7tMHvlta2+CMDbbVg7f4QZSrQdTSdbrRt9iuwKD0DH9zX/+kYOTcC1
	JO7UfHg/J7gRUPD/V4WAG1UrDYoomRLFP/SRxwvVunBGTrxDeTt7YNRivGB0y0h3BDIBgdQIS+H
	GmaFLoJfDCW7dnbuEe4L0LsCVZpUl3Va/t/kc5nNgNZAwPIvl1csFYqOWi5UVQ+UsTStxEC+yfv
	UMKR3XlWH0x6baK5/o4nlK1rDDCJy7QJgMaCzNmHAk57FtACz0C7i0C5jlrlIAFQdPHfGkQYQZ4
	gw==
X-Google-Smtp-Source: AGHT+IFmUloyq7MbFS20aHmhwaS/ZIXhwA3i9cNOlBiqbElYJKGuRWylQsrzZ9ukHucm3MlWyESEpg==
X-Received: by 2002:a17:90b:3e8d:b0:340:d578:f298 with SMTP id 98e67ed59e1d1-343ddde89e7mr728496a91.8.1762896808241;
        Tue, 11 Nov 2025 13:33:28 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c0ab7ccfsm1592190a91.6.2025.11.11.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:33:27 -0800 (PST)
Date: Tue, 11 Nov 2025 13:33:26 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me
Subject: Re: [PATCH net-next] tools: ynltool: correct install in Makefile
Message-ID: <aROrpt1Dn9gvoR26@mini-arch>
References: <20251111155214.2760711-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111155214.2760711-1-kuba@kernel.org>

On 11/11, Jakub Kicinski wrote:
> Use the variable in case user has a custom install binary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: sdf@fomichev.me

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

