Return-Path: <netdev+bounces-235922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171FC3736C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C57624597
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918033858E;
	Wed,  5 Nov 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caKRYsdt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBF3358B3
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364046; cv=none; b=A5Q9+TBCBCm6JCYJx387HxCYtLh6mc6FmtHBn3PxbiJztoX0mzIuvy6AezGTTWdVd6FH5xAyYUzsXydqz2ZDhAzM5XloFme3SnRbQSt9eEOSdWzvTxtQk1dAOGWrReyryXumlZBqCcmmXHMIMMeQp0I3J5bPtMmL3xZLBJoL0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364046; c=relaxed/simple;
	bh=6xrOD9swTEvrak0LhMfPK5DhY7OUNnrkGwLHcRPL30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4m/VdTGxq0keNxCrKjtKpDNSoJrVrKHBJyTQMVlehI32aaEgQCWOGeBDkHmzWyPsHxw6z4rWtRTr9YuOozgJvB0MOuUrPNF1DzPteSiBeB5rGm9G6rs66IADgdJ/SFTC4ggQtHNREy8dSjHday+P+hzkZffrBIMNwpgHOpoA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caKRYsdt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo135887b3a.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762364044; x=1762968844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=caKRYsdtvKllX8CzsiFUc4zpvhzFGohX2iqu8C541hMlaAlV/GArvWcuIUYcNzqtFF
         iZsHa2KgnDOjipZbTsQBxz70O3SdbGvGjErHJFacdd81mG28AvBExOrrIYqB5rnQayHn
         Wlp+5I0CQOH51sTOzZtXst6d/KqjDDh1X2QbZ8V7+8o8slZTSt0YSBChAZC/EWTvN8Xc
         /1bOn/adVeZxgrjzguPfyLMpPT00DAZT15nxWOuBBxWcT1Wo5M5hagVt+GO3LNGUEdqt
         7a9vvGBNhOBjTjs742uZ0lKVPnpPTnpKMyYukgbYWlYody/AKXX+XGmmQPruLqbEEbZD
         mgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364044; x=1762968844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=NGJoaejMm86p6YBqj6QAh0dfHna1x+4jlDlifu3aJWaV1u6poeyCd7wPh8uSyJ1+Sk
         0D6T4wtiK/N2JmNLNr6V3jUzvb+DcpDk7ejIP3/9NxRvqW9EQ+ThjWyoZDL+/3t+Wx9c
         4T211GMSXEusmMm8ELpH0HMtXOscYJmdEyVDt8PcrKFpv8lWepEfnZ5GaaUwwQ//FRc/
         nnWBvmqPXbtmPA4e0bS678X88y7YIvO2ehft2SdHsmWaHjctpm0AJZ1wGKe2BxhMbFT0
         RrcAkwaXC3ddSG7oPkp/4CTNz/i7Boh3TFoUNMuzuCUe+L3V4GOVldjLBPc7K6YOHi+p
         oE2A==
X-Forwarded-Encrypted: i=1; AJvYcCWYXxBV5sSu+1gVqKojAkCmLI3c354U7UpTRpIZ91/5fi+rH3r70mH448gL4K+LC7dcIF2G8eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZGGots4Vos//sA9QHnHLm0PT7JKlIB/mfhLE087qIn9fWksC
	beeqSlJiWP5YcY7jRzMw5KGWvyshrN/3DSqWCoS4tscGtc0poifNzIY=
X-Gm-Gg: ASbGncu16uDZdrCoZi2lomNR63L/10ctq6/GanlEU98Nm9j40+NIzPtpyTnBiUV1+zd
	RJTlVSgLxkxPfx5Kmc5PDIoUzwCIiBixadxEax9GK+Q9eejoIjHHPh14phQatSqghkJEMMv1iu9
	QrJ34OGN2mA368lKBX7yqJIK5gaRlr1uDuKVVfIhTNvh/N6+UMElM8iEaqhHy5eL8qAiscJWaA3
	pL2cg3l7L+Oz+CwQy3xxZCV5l6oGc1e2WAJTpvaYRs9tL0u+m7VgUxRr8ovcoPraWLllVzdJ1Ow
	UKpM7fIpSSOso9TuOyoEJFszaKUIkJuYKWXSEOJkrb7dGFeR6OzMb4319Bw1rGm8o1Kgt3XTt0c
	RVO5rZ5Ud3vUpyegrZ1nvTIzeuN/OPI6cnf73cF/iCYVtPnl+jJvFSmRttY0lDJ5yj/5sshzJS1
	93ms+aTS7mMXhkFeg6bXqt0TICUlXKUv41KVffYcaye2xJCrYwpT0FyaxeHpsvNAbDhHaBRCccP
	QKwhjW/rSNUqVOH5I+L1Apzi2HNTKI10DjjeZcUvDDVFwEIAhTdEkll4XiH/cOOGcc=
X-Google-Smtp-Source: AGHT+IGfpYym/+ciEUpgLGEk2Uo4k9tfz1NW01FXx3zpjWrnBawbwhix8S/o00+hWVYZ5LW7eOMiOw==
X-Received: by 2002:a05:6a20:7d9e:b0:341:262f:651c with SMTP id adf61e73a8af0-34f84afbef9mr4621605637.25.1762364044019;
        Wed, 05 Nov 2025 09:34:04 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a8044dsm6027302a12.16.2025.11.05.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:34:03 -0800 (PST)
Date: Wed, 5 Nov 2025 09:34:03 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQuKi535hyWMLBX4@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>

On 11/04, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 

[..]

> +Autorelease Control
> +~~~~~~~~~~~~~~~~~~~

Have you considered an option to have this flag on the dmabuf binding
itself? This will let us keep everything in ynl and not add a new socket
option. I think also semantically, this is a property of the binding
and not the socket? (not sure what's gonna happen if we have
autorelease=on and autorelease=off sockets receiving to the same
dmabuf)

