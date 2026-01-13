Return-Path: <netdev+bounces-249434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBCDD18EDA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5B58305C609
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A0F392B7F;
	Tue, 13 Jan 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NH11nssh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0F3904D8
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308050; cv=none; b=iQnwCpb+zVUPV4oLcBD0JlNtUcXfUVQN+xvZ6WjtZoDbXLUPFyLw2EuraqfHJ68dMA40rCOczUBT14w416agF+5NQyOC2CFgONBb+D7mVexl8h7ftYeR2VrKxxFuJ5XZ6GB0Ihukn7neGodoNZBqEODjdOrfLQ5E8LntszfiS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308050; c=relaxed/simple;
	bh=oo3D+KUuyl/yK0+7LdxWePxgnNUD84eN60bLtmw0kwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6NYrQ3U1w/a0n7hddKZgFNis/zo87hJFGrDrrJEp4QpNMo0DlGCnSZDSlA0FcE2Vo/822teKtLc5HW1Y5085mHUNyGvS/eWwTzroxIWe61De4cnL1uwpsMUdhVX2VOZKq/qI7twJEa2MJ09GR56YSvUZuxdfNFzIMNzYlmuteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NH11nssh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so11727849a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768308047; x=1768912847; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oo3D+KUuyl/yK0+7LdxWePxgnNUD84eN60bLtmw0kwY=;
        b=NH11nssh+k22p7s8RSm9iDuub85Z70C/jSb/02d/cC24gF+iNC0atJZYnuw6hFTYxc
         LO0/BAyIwsyQtKerxaS/2Mem0wVTakN218J8wY1ULWaorNuJ7t128P+oOL30wqVkKHXB
         UpyVCScIK6a4+BaKtHXh+0Kn9iolI70z0sLaO9P4DA0FrykDQEDEpD8z3TmV1atUoS0u
         brxMPpw/JHRs9YfmKPdrriMLymOv2eSAxkCBwTeOrQysOJkSoSAZBhGYchvLt1VIQOuE
         Nqhn1+8dMiiolSPDJT+dz0T1yoSsB6MgGn0a9BvU2vwZcA8ugV+EXU6q9GFjLsdVKY7k
         RZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308047; x=1768912847;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo3D+KUuyl/yK0+7LdxWePxgnNUD84eN60bLtmw0kwY=;
        b=GL5tSWVidQ+kPfgzRahv/EhtsGBd+xf0Vux8z/fkWkgYVx26pLP0e3C13sysBIeMFA
         OujmBI2+QhPdSc4gqIIs18C8p2T0T96V6QE6zbrfVK0ebYP7MBXW/UgPfLPS7H7Yftzf
         /9J7KqAzgu2tCpPhPo7ojgHAYO2cNQAmIg0ZcijptBkHOwmduCGKGP+XnHeKJ3vq/AMB
         CCyxTmJd+8YmSAfm1am0D5Mlh9f6geVSurpq+ITLYRx+4UmW+h7KtWfxTSqT3vIMw3BY
         A8U5us7YrM39DeuxmjD0xy8u7rliplFWW8lNvVohYPHOfoRms6aoCvM0NNpZ4128MvCj
         s5sA==
X-Forwarded-Encrypted: i=1; AJvYcCXhsblKDzKxOqMoBj6MTOTn06sDnLI6hzWICAVfqRMM7q+xjv00OsEUSUlj9tZ8oWbyD47s3bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGbklmlvzpcMWIFdhhJILyTXKbeQhjhmcNpsqZXt1cTmMBNu1
	0n2OEyG1TJc4ZCvm2yw6CvJCMZFAV6TSthmyqlPZwyzv0pKB6Em8m8AwdnWELrfSmOw=
X-Gm-Gg: AY/fxX7jjSKZrBRU4AsGYXXVsIR57omOITikGJ3yaRsHBAE1qf668KGjleaEBrQQwVR
	yXwt2rtYGCYO/SxJ83r1uZuQjdM9khTAY/sNZUfQzZMgplio+35WRF8UP0UQ2HS+tce6BgYgiUY
	drgRnleDwNimYinv21rpBWn2LANZCdHncC4251TSWo2A/UVlS+vJF+AZy3prpfzPjJfQCJ2YEMn
	JjxkXvPXFEUMbRZAZUEZy7BSSrz1tWIOncqStSJZiPs/hBUfOvD2IriiY2jk0rRfT0fOv813QIE
	yv8w/Z/qRgZ8IMIzY2X64GqQGFUfKIDaLb61xch5nDpcQPIqqQ82dtDkT65RmzaYqQzFGG5dd3P
	U3mK4/onu+j8N1zcvVttmkw6A0jUoMfrW/Gmci5LKeQziPQ/dhnIOoNrVwadjoSAiyymFdQYl3a
	wCBJlCOEyvg5r1
X-Google-Smtp-Source: AGHT+IHoJX3rCd0dhCoGHhRCveaoE/dAFFrqPqKvVA8s0p5/eN32SkcJ5IaE78DU2yIQ1+O6SF/OiA==
X-Received: by 2002:a05:6402:27ca:b0:64c:9e19:9831 with SMTP id 4fb4d7f45d1cf-65097de5b1fmr19532557a12.12.1768308047256;
        Tue, 13 Jan 2026 04:40:47 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1cb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf65ca0sm19578895a12.24.2026.01.13.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:40:46 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com> (Paolo Abeni's
	message of "Tue, 13 Jan 2026 13:09:45 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
	<36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
Date: Tue, 13 Jan 2026 13:40:46 +0100
Message-ID: <877btlwur5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 01:09 PM +01, Paolo Abeni wrote:
> IIRC, at early MPTCP impl time, Eric suggested increasing struct sk_buff
> size as an alternative to the mptcp skb extension, leaving the added
> trailing part uninitialized when the sk_buff is allocated.
>
> If skb extensions usage become so ubicuos they are basically allocated
> for each packet, the total skb extension is kept under strict control
> and remains reasonable (assuming it is :), perhaps we could consider
> revisiting the above mentioned approach?

I've been thinking the same thing. Great to hear that this idea is not
new.

FWIW, in our use cases we'd want to attach metadata to the first packet
of new TCP/QUIC flow, and ocassionally to sampled skbs for tracing.


