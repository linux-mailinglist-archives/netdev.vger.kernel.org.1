Return-Path: <netdev+bounces-176760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE7A6C060
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9626116D7F7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB622CBC8;
	Fri, 21 Mar 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUDyL3K2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68231E7C0B
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575428; cv=none; b=Y1u9bNymeTTeKywgGEebI/ucc9R/Fu29Xt/vPJ4ashFEZ5jX/CsGw/0+df9awv35Vl8wv+yt8sU3benH6KkDKrRdIEJZ1C/n1eAmdJhtZmgvHZWqINNfSiqhvUNDFjz59XAAAKMqO5XEz2cyhts6kWpCaCIiEhZaVVBNnZEDqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575428; c=relaxed/simple;
	bh=XT5DxnksYMON6KghdJyaLyC1a/cr8sHIeTev0jvqA/4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nJO/ISR1UKhBkrZi16KQcA8boNr7lylDviaBfzVyKriDJ+VDslKLLM76MQT9plEwNHyn1j2OQkx8nnI4jPIA7cMgzFdfYhxxdh9s3ZC8+PVHiLL5tx5AuMUJO/sONfk9Wjbv4SCBgX48L5e3vugKfeHmM4Qkz+kfQQs62VeO5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUDyL3K2; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c56321b22cso237265885a.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575425; x=1743180225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMa3/uT/Ntt+EN4CVXCw+6vZ7uhbSud2tfcKhXDYJjU=;
        b=AUDyL3K2g3kyt/KhI+nt56+xuqR2bo7BA1JZ+tVMlkKvzWAr0UP7b2t7BU9lHfP5gu
         A3xYgX0Q5o9OWVstip2PRlEuZAsG5FjLqROZhvWjq/Mgq362IRQU2S10x4T9s1MFohDd
         /adluBeytYs0o/RGLW5pj7ZiIVN6Pol6IQW5Bv5RDQGS+5K3rbVQI6bCHYI5ekmS2N2s
         0cbYJEJgw8kX3jcXu9P6kg5nc658XLN90EWzjiS5me4u9DZ+5JXDmB7JfTsV0wzPStW0
         Qcn3AyD+4qWK2gzMD/V1sTSjWG+SnHUZtAnJy67GClV6wMeqe8+o7aex/kMHOGYq0DSu
         8ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575425; x=1743180225;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMa3/uT/Ntt+EN4CVXCw+6vZ7uhbSud2tfcKhXDYJjU=;
        b=PI8B/CJa1lYD9L+j0qxAwYdShhvx4+JHuMLphos7cyb7msRcc5EnXuNeH21i7sGnCA
         yFk6ljNUb7luHHLbbM5q6VrD5gWhWjwYk91gvn1Uh/0ItwbyNhzcFuglAcFAICtL0Tgc
         ULh4VbLOrJpGR9fs3rtE5mqBOqT21DmlMWZ7OXnXIdFp4aqoNGZsRooH+ZGyN3LdNUEu
         nJlLxkXGGk+Nj2C+av+aAA9Rl1Tk4qIbgoGhWbsZ4Sqsg8I9TaPq5YXqAt61Ojl2g1iK
         iWmBj7LWJijSTDTj9qHIIxXLn6JICGWBvG4ZxyGgYx1Ux7VkeC+4qCBCsGCi7f122CE2
         coRw==
X-Forwarded-Encrypted: i=1; AJvYcCUNhaEfGUfkD/b4D747WP0S9qX/kwIkp5A/VGUWpQC9jMJUT1Tl0EnCRGLuOrWeIIhWq+T2y4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwH7UBzV29dZBtzxePk+FkURX4rV5mUDO0KoijzixFKRyZrpH
	Ri1d8AED4JuaJuaFtP8ie7YUIaO4v/khuDhA2hsPyyTZ/0jG2gjP
X-Gm-Gg: ASbGncua2fAmUqygxdXp+K6o1fwNRgvfmcRMlufU+Pm0jwAhaRZF76aXE8AMwhblvvf
	FvMl/Rsja0M6D8/MFStGcKNN8b72BTodYYE6OCryauJVahxHpEdhYWykjjPHm6x73Amo7U6EGt5
	gzRKf0IdDAC8eBescXvAdU5yyj9352REZWtXfakADCV/9fLSlKYJqVOq0gVrGX4Es/8RiR2K9aP
	evuhYdYRHN0fjYzZBdP1F/IFhhmNN0zgKNPU0aaJhg58mVWadP3gGEXYbTlVVFqyLhlhqKRyCkG
	U3iuYTO3UXXEXhfWoJnQkkYgSQ+YVFWUL6sYU4vvAo7olG4ldahubyrDdz17tOiZoNYB/wdGYgh
	SWVy2YGgr/WrxH6WbOu1X5g==
X-Google-Smtp-Source: AGHT+IF1YNVKrhs8XJ6rzBpGRx3qH/9WGHvrKDv6RxKWWFgEBdLznA/yM9jlN+Fap0Cw14Y+FaGYTg==
X-Received: by 2002:a05:620a:3941:b0:7c5:9480:7cb4 with SMTP id af79cd13be357-7c5b9add3b3mr541653885a.9.1742575425629;
        Fri, 21 Mar 2025 09:43:45 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d68f3sm149256785a.40.2025.03.21.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:43:45 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:43:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Message-ID: <67dd9740d9bb5_14b14029445@willemb.c.googlers.com.notmuch>
In-Reply-To: <e22492f139a67c34c639737cc54b3a57a8c78ef3.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
 <e22492f139a67c34c639737cc54b3a57a8c78ef3.1742557254.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 5/5] udp_tunnel: prevent GRO lookup
 optimization for user-space sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> UDP tunnel sockets owned by the kernel are never disconnected/rebound
> after setup_udp_tunnel_sock(), but sockets owned by the user-space could
> go through such changes after being matching the criteria to enable
> the GRO lookup optimization, breaking them.
> 
> Explicitly prevent user-space owned sockets from leveraging such
> optimization.

UDP tunnel sockets are generally initialized with udp_sock_create,
which calls sock_create_kern.

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

