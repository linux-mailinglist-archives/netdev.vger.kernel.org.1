Return-Path: <netdev+bounces-171115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C6A4B941
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2591889EBF
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418061EF080;
	Mon,  3 Mar 2025 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcC+gJaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B321EB1B5
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990461; cv=none; b=n2fmOPykLLUIwldxxD7dQbgf+tZ3JRScz8o2d3L+0v6HpO77q5iGI7h+veYcTtwix43joZDZPt4k+BN94btxD2QZJcgiZ/fbrrHD1tPr999zpUqH/2Tn5au8+Nx7SRKgxZouVpcQ2AmGwCq7RCOfRKF9MRyhjMOCxEGX6PyRm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990461; c=relaxed/simple;
	bh=OKAKd68EoQJIgLaXDj9Mv2dwO7eVp/2BdjUu3B8CRfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfGlUbmhMCZSUi73PzEtAJnEIlAtkJmVHwRcnP4oJVRocatYzbrlChkNduDIcusXNQxrR8YDYkkLsfVcTMR3B2KHkBlIGUBoy+KP2Cf593JoCe2pdEwiCm2sDG5L2mfkRybViqm1eCbHSHMLLP8lNmOA5wz1434fqxNcnenu0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcC+gJaK; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso38236695ab.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 00:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740990459; x=1741595259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKAKd68EoQJIgLaXDj9Mv2dwO7eVp/2BdjUu3B8CRfA=;
        b=NcC+gJaKSk/BebxIynscDVjD4tANsdg8gV976sJkToH8jh5O/5dyQX7OBtYda3Mbyz
         CIWypYsfmnGReslWqw8IYzrj4GAgvGAqpsqyz+wiXbm0hzHjrF5B9/YtnZQnVPDe+uZy
         KGZTB1ANgeXOdnvgG1AShJ9STKIUYkTSsSfUSS3HxD5q6mjPiSPRExnpNSIri8C01OFs
         Y64rYOR5r6uvwFO4DESIY05Z4IiPZaasNrUOhxm5J5fmTHDQOnzvhrI4cUy9F3fblKv2
         b/au4KQWQzRI57nbtboNvyORzpeiFaLJT0a/AsOgitvu/jOHf4+6XAb1Kl1TmbsFjE9J
         Eoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990459; x=1741595259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKAKd68EoQJIgLaXDj9Mv2dwO7eVp/2BdjUu3B8CRfA=;
        b=YLOM9QIVk57L+VxhYzbOU7ECn4mUtBE2DrbAT/yUBefvXuVV8b0VX1t1xjktJcJnW1
         heaAXsRePnXIUXpyAlUCIyvkNA919/0IYY+QdLw1ldMaZVMWAMbSdYhOUS27FdTzMdQ5
         M7zYQMze6MOe/QXxLo9dzEnq9SRvKK2OlnTqtqAuvg7ieoi2mYES+vyhcCbfXY92gx7m
         uGCL5MfmdzsRzTFo6HSZfh0+r5H79W13SwcxFQKKsY1V0cmj+0sg/cvk4mx08Cig0m89
         MLk684KyXCFR67EvzCSZl63VpliR1yp8fF8z1n+J17AojzOUag4cveIwDmRi5293Q5zH
         TJtg==
X-Forwarded-Encrypted: i=1; AJvYcCWs4IuxzjRo+1R3EU2EpYcgx9j/h/pvxVYKhlCRyNfywP8+ZsJkd+xD6yzN67tCyiI0BUjyKqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzjmI1axG200HU6MDb6nTVSCU9vB654KQ/a6x6C+b1X0ZJY8be
	YUHydaAIDZUcgOqP4prFppc6BZu9RRq6AD6cyInvun4aiMyADXclwdRIZoAWTVTZ70TJG3S3lfB
	niaHYZEr5O7JAAigpKa8liLi1HR0KzdDfvyQ=
X-Gm-Gg: ASbGncvy2PpFdzXzn1ed9Tt4EIKzU79A3QJyov3k06ucBrg5oGHtxAmG/BD76epdOlU
	z6eCHZMtiOd0WTWKJZz6B5gjkUwow/Bb3S2uTjwTAuDM93wyGLBs5QUeJ3M1C94EAKGvufqdftY
	Vy4XyLYn6TW/fs2qpqWRFm2Iruhw==
X-Google-Smtp-Source: AGHT+IEW1gSn9xORIfRuLZjBTix5OseX5vVu6WBFt4sChVjlYe3WKMK+uR9HBSeCAxYO/93zd+FJ6iHrPADIU/R3Mw8=
X-Received: by 2002:a05:6e02:1:b0:3d3:e536:3096 with SMTP id
 e9e14a558f8ab-3d3e6e952damr122448775ab.13.1740990458871; Mon, 03 Mar 2025
 00:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com> <20250301201424.2046477-2-edumazet@google.com>
In-Reply-To: <20250301201424.2046477-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 16:27:02 +0800
X-Gm-Features: AQ5f1Jqws2KP2gNV5kLpwdapzJ_TCQt5fVm-siC-7XGeWjHoCtlHEy5Z7SnkJRg
Message-ID: <CAL+tcoAXv1ySF5_QR_TD9Nt591reBpDt6WPxUcuZsDgL4r5cJw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/6] tcp: add a drop_reason pointer to tcp_check_req()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 4:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> We want to add new drop reasons for packets dropped in 3WHS in the
> following patches.
>
> tcp_rcv_state_process() has to set reason to TCP_FASTOPEN,
> because tcp_check_req() will conditionally overwrite the drop_reason.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

