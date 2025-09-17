Return-Path: <netdev+bounces-224064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E6B8056E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D56A04E251F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3EF3397F5;
	Wed, 17 Sep 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSHoKG4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DD3397E1
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121203; cv=none; b=ZWFw1toADOKeLpmTEpzjI/d56xwyVrj9sNWXi7bBJYvempI+qLREd015hgsajKWYIdHT080QN6OgKwcYoTxY5atudeWrcKywfoRe970jqUMCSiwi0ggwF/Ca/iJO9zURzN3O0TYfLpil8zRKBoWCN5vwyzWjH2KHTPWEMUlqARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121203; c=relaxed/simple;
	bh=GoRPCD40BFDDrmtCUIPDL+dL22IZSYCwcnWhn26vjeI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LU4URTXHW1Ee6v/Agp42blgVQpaKwDzkxv60DmsZC3qJ59KuDz/4Z7YCzfTL4YA3LVzU6kQVQ0VaAEbT2OIDrMyWtTENESvaLDpbjcwLS5HVaaaO2Cq1NNH68lgzjrBDQzUSxWslGAB8UlVRtyQ5Lq/k8a2S36YWjumwjwPe3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSHoKG4A; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b79c8d1e39so43637871cf.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121201; x=1758726001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRxHV+7HOBAU6pzya2G1QIcc+HSV24X4ulMf0QCXwIQ=;
        b=OSHoKG4ABkE4+2SA94wgkRCiW1fMtxmvteS3oVtlaOQwUef3fmo06QqPumbss8VN/D
         mJzD9DC9eI6jX8XF71jGnCkOmsvThd3rWj9GS0890amEkVE4+4qh9VmEezlYqk72r7xF
         MtWW7RT9J5TRkqM1Pe+81ZmxZB0+43XXOEGBRoafKR8H2n3emQh2o3LQW/9PmEhKpBFn
         Pa/eEmNIKNPzSdyS4q+UgGif9sxuBe0eFLtHSqvQGy13wScs1W9Hn7DBbMzadNUtFiPh
         BsDC5CYTTuboF/pnrP9yaLs3zlEZDPEXuVLF9zJmFRM12ja/r5jDUemZu8NjkRF9ZJ0s
         QJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121201; x=1758726001;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRxHV+7HOBAU6pzya2G1QIcc+HSV24X4ulMf0QCXwIQ=;
        b=UOa0gSYFT3RQwbP4dfkeq01PzXvKnHmEkFwHYyU7iylgt95J0k4QdIhwYebArFTg/Z
         QfuHpivQ/oPdeh7iu13fzvH/OaxCXylYV4p9Kz9WZxD/2pG4YurWZBysiyDK+mS1fwtW
         ashbaDlGODdLeC8Wbmwbow5IoLcvv54Uq7OxBJLo6voSiTe1A+laf8OpdX2/DGQB9dYW
         vvKunjyiYOKWBZjlkB5cbiVL1XYk2bgMK7AHqYpN7ZSM7NGB9bOGnv7o/X/ShBEr09yp
         8qs/aO8A/LrvKC6y13uop4IEaoXcMkugiXsmEmk11fy/B0qGRc/mt9d5FHSp0u4O33Jo
         TAuw==
X-Forwarded-Encrypted: i=1; AJvYcCX1RXRYCiF7thyH7FfgE5u3GjtahMfUiNx1erXqp7s+/7anaadSKMUitGFCpvUsyilWri56DT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNtKvtK1K/PSc2jjgzjdmjH/8jOf5X3oTd6o4efwfxCws7M9j
	1YC/iRe0uVL2hhz1k1lA0x+j/+BnQFnFZRKW5Ws3qsRX2CnATPgU7jN6
X-Gm-Gg: ASbGncv+ARBFk5XFN4ETMFO4uuE9MFZ008g6UWOPhcKaE+vbn8X5F9icC5Zj7vAuVco
	obHSwCMu722KK5gGbB5nNuhkCEXNtwEMQ0aPjEkfZSdpE8E3uGos7BRbfPmcMq4YekFtcZmrOM3
	kvOMlVNafwB6It8ey8F9H0oow0sKaw/W53hzQ7minBjtGfOQGNOm4hqm/KLAnrM/lGoinoYqd9x
	26YE4bdOCV13iMQ4Kn/i8ZfmtpQ9qk+4xSgyLaLPqX/GtJ5gesgc30wx8057cY9KhoI2jjyJWkq
	5ghd+ASiX2APoHnnTAkQauF0XdhNV0J+4eNunM7Bz6QAnFxkDzhEkoIarSHmiZcbvoxbtf8Elx4
	Vw4lbehtEO0Zg4BG+2J0M7VQ68+K8yk9eyhZFYnTQfLDaWdwzrP667NdL+7BJbk0Y0MPP3d1iS1
	2YFQ==
X-Google-Smtp-Source: AGHT+IGfW5OtIrR75WNUnXsS+kgKVROTTewTbRhDvddl0CQZS0NB5iZwbVL/B/E7rPG9/Jj98/ubsw==
X-Received: by 2002:a05:620a:25c9:b0:806:7c82:fd2f with SMTP id af79cd13be357-831162655famr299046185a.75.1758121200936;
        Wed, 17 Sep 2025 08:00:00 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cf00848esm1149346985a.62.2025.09.17.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:00:00 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:00:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.bbb5c373debb@gmail.com>
In-Reply-To: <20250916160951.541279-5-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-5-edumazet@google.com>
Subject: Re: [PATCH net-next 04/10] ipv6: reorganise struct ipv6_pinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Move fields used in tx fast path at the beginning of the structure,
> and seldom used ones at the end.
> 
> Note that rxopt is also in the first cache line.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

