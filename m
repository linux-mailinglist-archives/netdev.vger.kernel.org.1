Return-Path: <netdev+bounces-173375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D3A58899
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431E71693F8
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8919DF99;
	Sun,  9 Mar 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h64L8BAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A716B3B7
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556745; cv=none; b=k5mkGAxqs8MHXAbXm7klHbWfDgjs72Xz+JxZm92/GY2jHHBjwMAyls1sCgUKETFNP/m4qE9O2jweMpxhsi6MMAlbzd5rR0x3X9jBkqMwhvoCvtXvxPBlNFOd8AsGLfwu0HkrBM/OTLRppk/cIJkMsM63ZVT4r59WUpTBEHDAcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556745; c=relaxed/simple;
	bh=UjdLDNfjbZvoQYCHSA/AD9KtY2qv+NY2QQT+7K8wSrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnvihaFmRrR58HRmuTQ6vV2p8ISFBdzCrX8l8cJ8n0ymjcSV/mYf6ggUNIrMmzCiRCKCjV/Fj2+oxN9qUvsU1sJMRib3wCq2PYSq9n9lv1BhlXoXU8PIr3A+Q6I+qC5B9hojSN9S6hT+80GqAojHFKNq2WJHGnW+HouLkwT+SI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h64L8BAR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225489a0ae6so140485ad.0
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741556743; x=1742161543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjdLDNfjbZvoQYCHSA/AD9KtY2qv+NY2QQT+7K8wSrA=;
        b=h64L8BAR87gJeNR0t001HrO4twm2Y43YEKSSsxrAZUiig841djqS6rAbyobupTiTld
         fqaJoKAjrKj94T+SKiyHY6Elg+F5hEyPDnoUaIhOmsfo9X0E4BZRwjKa3vaUCceYYdsC
         VQc0Y0Jza5Q8y8eJn8FM06HXM/VaRrYHprLgtI7jk7f+wU6sEPYwWNR3u4QhWS76CGNl
         vk8kbHEcPKzNO5Vncr3SILeB3UWgYHUS1gspkTpsQ/ufiWn8eRiSdRxHEvdOnPa90UcC
         GuQkXbxulAphHzDHWQScwNoWUBKHOusVZ5Zp3GkLh9fyY66SgTc5AAs4i/lk8taSjEof
         oArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741556743; x=1742161543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjdLDNfjbZvoQYCHSA/AD9KtY2qv+NY2QQT+7K8wSrA=;
        b=wtOtUQhGBmQ+0eQ1tLSr5Xr8B85TLcr3iYI317TNVdfGtqVzWTw/5962PBJsyh9dTG
         5fBTtRKxlZknqaaPuLbIT9thwHoaZD2tzNrSGvJIN/cJMwiYn7V/C0721ZZs+ARYxQ8x
         oC8PxY//t+eUIoVjUt4lEkTPgzlmBRaZAsjjHufSaqSMBjvygDNNTAqdTOOSC9iOfKDX
         PQLb4bRqX/xkwxMAV9l79SFjgpb5kBt2bw2Bt53ipJYfmYRK2+d8HGVpTHA7OSbDEWHN
         X4WjAEhKuOZsM+YXadGrQ2cP12+SHHD5IInFeJieNxhZ1KE417X10EIdCb8eiprpHtXg
         5YYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW55BGommOkE/k5hlYdW1dobUDSAt1LaBIgULRIjEOd0+iZ8gnZ/JRm2CieeqjZoPNfWqIdouA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhO7Xvuvi9xqoPrpetExtNbX+ucnY2pRHBnJEdr90bvO1X81vn
	xkHvaKNRra2rm2EuRFJeUF5Qhe7JZZZOmTMY6ICX8f/Uuez7FKxAuK2VdB16gPyrJgWFwXu1jGX
	0ieyb8nsZf2SqFALwWg3ZK23M2XhhPHpe17uA
X-Gm-Gg: ASbGncs0B2wNO6ml9b5LCnt2PdPx8u6I7HhcmsKcsANaopyNqqK9HvcmtJwCRX1fHxl
	VL6C9ntGhMVIG8A4MzNOUjr0X0wxzI7QMCF8B06/tEpmXfBFGsoAZuMWR7/upcWDCdysrL2PdZa
	VPF10hXPaTsSlnGkApKg/40RsMJNc=
X-Google-Smtp-Source: AGHT+IE2p+jDsD0j5SnKQKAip/If8+BtHqBaY7NIMLZUZReCQUCINAqK67F79wf3FLZVxZCUEpde7fx/HaA1cATafu4=
X-Received: by 2002:a17:902:d490:b0:223:5696:44f5 with SMTP id
 d9443c01a7336-22540e5c2a6mr2765455ad.12.1741556743264; Sun, 09 Mar 2025
 14:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309134219.91670-1-ap420073@gmail.com> <20250309134219.91670-8-ap420073@gmail.com>
In-Reply-To: <20250309134219.91670-8-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 9 Mar 2025 14:45:30 -0700
X-Gm-Features: AQ5f1Jo1n20Hcbf99zGlYqtQvtZAYKwrLd33MKVPaIwpybZWFt1Sr6yP1JEeOLs
Message-ID: <CAHS8izNe4NBbTtordf04uE_+4fz9ut8rcgmNTuCiiZtDdy2M0Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 7/8] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, willemb@google.com, kaiyuanz@google.com, 
	skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	somnath.kotur@broadcom.com, dw@davidwei.uk, amritha.nambiar@intel.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 6:43=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> When devmem socket is closed, netdev_rx_queue_restart() is called to
> reset queue by the net_devmem_unbind_dmabuf(). But callback may return
> -ENETDOWN if the interface is down because queues are already freed
> when the interface is down so queue reset is not needed.
> So, it should not warn if the return value is -ENETDOWN.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

