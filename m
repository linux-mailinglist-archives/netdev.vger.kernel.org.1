Return-Path: <netdev+bounces-223292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E1BB589A2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3271B227A1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C418C933;
	Tue, 16 Sep 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH7nllJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63C2032D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982852; cv=none; b=YuoIXC4yUz2/H93aCqgk73NHinkeQjHIZObCdWA3Undc8ima02xWV1Y3g/eriSWbVQ12HbVEoyGgTFZi4fDINlKlNj6DEoVqY5dv1CJO/o0GJoRX9nROIQh9FwEbF5CZN3pV4MsmKxtogQ3qqgTlc8pn3L8LvTl8SDpPN8hO8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982852; c=relaxed/simple;
	bh=sDVawro9p00LTqe7c+Lp+ZD+SMWiULzE0k3J0VNEc4A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kZ6n7FJy5N8j2iWTgma6D/P/a8/+rdmxfDfYdGx1IVz4bEozMt9U8V2ukdxz394JeYHP6Ml2FML621oMdCHWRad0TlSguMV/PrwqS73FGby6GZNX3+h40M6aO0269HCYVAFiwUj/X+rex4mUGLiSZgrBndyHeVvcNFEZLzVpKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH7nllJm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7997a43ceso26237481cf.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757982849; x=1758587649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+5NwP28sr5fb/80uCv4rqvtNt3VujNBkpwom97yF1s=;
        b=WH7nllJmDRoTgb1dm6wFyOSlK7tUhAQUZBaBQZrE+CYerv9Zn6lxDYcYY0bv4Rigm6
         HZevqp9HqkXtlEMZtqW4DBGvAMhQR04FCcAaqduc0fz/gVcm0Od+z65rKtKOqqyHKa8A
         Yh5oeR8Gh9dpsiitppoSPszpSyRli4hbkmU64UCH13xn5N2imiw5p/uzBRLSh5QCFgyj
         qwcdbMs4hJ49IQw9nYP/v3dFY8LBIhJNORpVz8YAU7iEcjkT5wYNarkvfFvhjAqITpoQ
         KTi/NW2CiUKmtFqqULEJ8qRHoymsHakWLwhw6/wuUiFBmHh1OP4jgDl3VwMKMUbJo/Jt
         R7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982849; x=1758587649;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+5NwP28sr5fb/80uCv4rqvtNt3VujNBkpwom97yF1s=;
        b=VdZwhJSbXGr2PnWBVblQzzWHSTYPJszk17pCziVu/cOVMvb7pLVR4QooZIWJ2PeVZd
         tveWmBzBI/VUEDitSKnXHKny1rZUWWGCfHdWPM78QO5vq6eKcSi5lj1HoWZMDgvno2j2
         EYt8g1jSr/NiIQ/nE5V6RLOrba+qEgsrxEtjzKo+Nq09JYLqr91husT3AZd+rX39/nRO
         ph+MimoIpc+q12fLrdOtpMLCdONk9JiPmGOMzZtcK/GhuktCH3Wr8YZD+sY/ABe2lMjW
         f6Fsln2ZHG7GzZAgCgqQVNCRB49OGlMPnb+mEyuMUp+ex0nzZlejkNac+8aGi9UazVW/
         Us6g==
X-Forwarded-Encrypted: i=1; AJvYcCUkEuxQqJczJKcVO0hijpb5B9+xbdaqfWkMLD8qnLciH2Vrb579+Lm1Qe2BsRkVMF92rF3kkHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW09xFc5qfVDsXjvUmjhRqgn5rXafqicVoSgK8kUVkPKneffzf
	Du4qbbTWI3C4KGhf1BO2hakzxoqG2qm7tWivD1VGcn9gnxce5lf/E/Rg
X-Gm-Gg: ASbGncvjIRwVN7vFUyUVBG184TzwGDuw6jPfTU+NoMJ2jb+vKImXtUUp/biEQJAn3/i
	yUi7aYrSRg9SlnO9Tk5GJDMQ4Yb48/XnIOzdwaikjYIcW2R9Yq+sPAgQ+5TgIxrRb7KBDtK45pU
	tlF5EZ6Hkbmh/tJI9L8BLMVXnpqPAr0leL7+FiktIx6Bx14IbseinCJFWjSmKpZ3TqdEHkAMG2P
	9vLRkJOM8n/7N1P0wkyjyFjGlfETaaWIkneeW1d8fCDB4p9YVuOJw1xNZkTVb+I70vljRIX77oX
	KffzGVL8bxLD9z+kc+yQCl/lc5j49RTrj4nLa9nrvtH8BxwAv5kbo2ISeBQ+vPydVLDh7P9eMbM
	eRE9UqGJwlVjsBuv1j08iB55kR7XWVTDZrlKQeQlMLrpkFNrtuwWAi7jXItXAYixA+dpOkMLTBQ
	dB+GBDNxoYBUVv
X-Google-Smtp-Source: AGHT+IHqEpffw/GbFtTW2ljkbOhtFN8NkS3JEYAxkA7MZpUcyloe8Kcaz/yLQmHPxx3z20rra2gswQ==
X-Received: by 2002:a05:620a:390a:b0:7e9:f81f:ce70 with SMTP id af79cd13be357-82401a9600bmr1798659085a.70.1757982849154;
        Mon, 15 Sep 2025 17:34:09 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-827e59af540sm472056985a.35.2025.09.15.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:34:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:34:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.14c591e08d91a@gmail.com>
In-Reply-To: <20250915113933.3293-6-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-6-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 5/5] selftests/net: test ipip packets in
 gro.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Add IPIP test-cases to the GRO selftest.
> 
> This selftest already contains IP ID test-cases. They are now
> also tested for encapsulated packets.
> 
> This commit also fixes ipip packet generation in the test.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

