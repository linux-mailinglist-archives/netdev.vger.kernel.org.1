Return-Path: <netdev+bounces-249328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34218D16B50
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48E8D300462D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F973587C9;
	Tue, 13 Jan 2026 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi0P1HkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBFC35771B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282464; cv=none; b=agljxOt/gCZwK4cSY8kLl3RH/73XtnC2zBwG/THy6mF/OeUhB89OIBnTYM7N0dKyz3iHlEGRQCNhpApdI61gN1Te0eNvWpaJv5CJsPLhk8P0PS0qZCMR0fP7fxY71FgS/rUQ8VuYEOJ0bRIfCcsWbAJQWXFvXTddT2kIbMMNyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282464; c=relaxed/simple;
	bh=vksA+EIfpcr5nEbE3T0odlE0kg9ymd6yCaeY6w6Gv5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kraqhdh9z1+ODZOUiuL9gPSHpJlH8XMQ3mYaH9Hj7a7D6d8M5EPK+AiCFozDpmj6ePPaHF44TYTaP41tZoSf/9zpAxqur+Gj6UKv96gbiVyLYnnvfzwE7pUd+pMZnP3FZMUIpR8vmYNkcPeBiPbwfAErebO9+pP0RkG2x4yH2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi0P1HkH; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c76d855ddbso2357110a34.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768282459; x=1768887259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vksA+EIfpcr5nEbE3T0odlE0kg9ymd6yCaeY6w6Gv5M=;
        b=Qi0P1HkHLkIYX/JKQVkF/9qm9c7ufOIH+uEmfizwjWJ4PTEqwJHPc2VNxHpPMxD2iY
         uQCalXujiFI80t9M+Ay/IP2k0xuFAxQyrzc4I8xv2WIw2PUqr6EcVnzKwln9Ozqzn0bu
         RKZuvEw5L/Ovrd1z0DFb0Af1Nor6NJsy3bDL6+PkgpHLgYDK/cJHpjf0JBKGoQ44yLw1
         HlCRlOVotht318coQf8ZOtnIFB9UllhAo+ngh1nLhmT+2a0Slg6PsXw4UIeazVlTSbMu
         ghzVHvEEZLDGgkDtkHQdbijjNFPXuPqWLglbfEQ0CmnBiEtHAecTiwML4tJxjolZoWWM
         2CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768282459; x=1768887259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vksA+EIfpcr5nEbE3T0odlE0kg9ymd6yCaeY6w6Gv5M=;
        b=ROZKWANrMisM80qGWhHWzaHbTFbPMz/W7WpOHNaZsL9GNHl3bJn5u8SjNMf77wTRAT
         ljnFWAdvQa8A2Nd96Ws594Pc05KSuBUmbx+qltwi+Vdl7n2mpNAaWMTj1zr5CC5r7dXl
         lWLm73cHRDet40E8FcmWeBCYPx5uVGdo2+bepcKIyrFc/08GY+FWDpMsZhM9XQtKNdPY
         2bh7mkLZdBgrm5WXv5bvLEPkLtoeIJ3fZ0irItF5p6Pb0udvhUUF9aKLW5SfoMV4BUcv
         HROJtBoka+QwTz3WJPsIzK/+/LQWd/9Sp15JNUn7C6mBiJyXVzD/hzDP009Q7D6y5602
         g+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUWwIoy/RE3Q4dmxYjWelo7XDcTx7cjv8AyxPg8CdsbXe/ZQSZ2cuD6DVUEiSoAKvJZhyugxPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstUMUc/zHuthwgdZ/bGfPGlOjRMF0EfnFLZSISuG+EzneWAP5
	9bnLWLkAFC2lMu8U8TiIRMwa/H9cWY1K8TVfljx82TrtX0InMGNmTEMougbQQ5irNRWm6j4xOQ+
	VmHP8B/3M3OPHQwuifxksRiFIcBG+AzM=
X-Gm-Gg: AY/fxX4f3pKZju1kRiJw5Vdd89SueI/dIvILp7/are8WzycLr8gt9BhmAuCDm2UsOzb
	ebC0XnKCwIvx9del2Ga/D/EeyEcxw1yK53syHikq7IfGXwC5RIn/39Q2YL8t3U9fBOLYKyzNvF/
	JiwOQux2Zi34bUu1ADKwI53NRpvYDwaC88p+E6N3iA/wNlXOwe2uqSoh5Fq33ZNaG7bwTuLZSbX
	vndGw1CiJqd6GAkGHDPmPsrKx5nfTZdBeGeiI3qgoSmkFP1NAi6YJlxc+UWiwxGcI0qfzo1H0NM
	qBzSbh4=
X-Google-Smtp-Source: AGHT+IGUWvJNZ4ZkTAUw4qdkc0PCAeA1Ef1SChvyzkxPUurNCVcqpq8VZPOJBJoics8U1EpcygF6TSKigI0mES/zmgE=
X-Received: by 2002:a05:6820:2282:b0:65f:7470:38be with SMTP id
 006d021491bc7-65f74703e4bmr4185292eaf.61.1768282459515; Mon, 12 Jan 2026
 21:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104012125.44003-1-kerneljasonxing@gmail.com> <20260104012125.44003-3-kerneljasonxing@gmail.com>
In-Reply-To: <20260104012125.44003-3-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Jan 2026 13:33:43 +0800
X-Gm-Features: AZwV_Qia6l88ADQNzz1m_sO2YC4k30nIzEfbrxq1JjMEght9dQfip4Vy5SfFItQ
Message-ID: <CAL+tcoDgNWBehTrtYhhdu7qBRkNLNH4FJV5T0an0tmLP+yvtqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 9:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> We (Paolo and I) noticed that in the sending path touching an extra
> cacheline due to cq_cached_prod_lock will impact the performance. After
> moving the lock from struct xsk_buff_pool to struct xsk_queue, the
> performance is increased by ~5% which can be observed by xdpsock.
>
> An alternative approach [1] can be using atomic_try_cmpxchg() to have the
> same effect. But unfortunately I don't have evident performance numbers t=
o
> prove the atomic approach is better than the current patch. The advantage
> is to save the contention time among multiple xsks sharing the same pool
> while the disadvantage is losing good maintenance. The full discussion ca=
n
> be found at the following link.
>
> [1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@g=
mail.com/
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hi Magnus, Maciej and Stanislav,

Any feedback on the whole series?

Thanks,
Jason

