Return-Path: <netdev+bounces-140067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E615A9B525B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913F41F2400B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E3206E92;
	Tue, 29 Oct 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfIurEp/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8320604D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228543; cv=none; b=AgPabD2wpmtUDfKmQGAtUabKlRdmZmKSjtT6biA03xzkkcxiQzrhpoP58iZZMemaplfs/OWAIyCU1fnUg7SCfBW+WEtG/rq+YpJOUx99Lqaxux7ZPoC0KSHa//87vWNE4LGsqL17ZBG5sa2YUHzCKu20vzLg2IXSo7+C8EJ9aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228543; c=relaxed/simple;
	bh=KjlQZ1Gv1yL4gXu1X6hUwgK6fbUlX4cKS6CmWEbCjrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADfkXFQRnGtKeh6+14bYMZiJvdMrY3mPnYi8/YZm1+6q6eZ7bLa7XqgFrODlBgSVudDLZMsX/kUHLVJlMyCUQAEbZweSRxlVFek6ZgZiacBgLL7reeYUweWx2f4wTs9vvtczSKaJPfuw65RhOo/GVFfKOqTk7hACPe9GI+Kd6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfIurEp/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so43136391fa.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730228539; x=1730833339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjlQZ1Gv1yL4gXu1X6hUwgK6fbUlX4cKS6CmWEbCjrs=;
        b=VfIurEp/KD3/rCOMK/p8S5PSlK8lainQvKjjzI+8v+bX2AJfEATWYR9xjHaSTx6XZo
         fv0o2+BT+a66tDaxuot5XJCdEA2STuNtTbCbFBPJNW1XuzGVYWUfDvk9ePGS/E1wWsL/
         X9QTjUwJT/yfek7r+VcaCJBkPB0EBl7HTq9UsefyaiIay5t25rQk5KgWCXMQ1fle7NyS
         z5QqFr0JRVEhSPBZXorE+COJyJRQ5zKru8cK+qjxk4R5IKvNXcP08WmRQb90ia11DWuu
         a9JjABttiWg6nEpENZXmZUuSSB6SPMzDdcwdoNDQh2XvUqRGrkdjzmsM1w6J+pnYbwDO
         wcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228539; x=1730833339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjlQZ1Gv1yL4gXu1X6hUwgK6fbUlX4cKS6CmWEbCjrs=;
        b=V0U6pPoH8jrFPY2JJX9ZtR/a6QSLYhfJdhnYWaU+Df/S8/tvgU5253TQuos4eEGKXr
         DNq34ufYbIjPRdJDk27myYgZFN/O/ubr6kGFUc+RhJySu8WpBTL44X+F7j3N20WNDHN7
         y8e43/gAEIBprF2YgDVw3aA1DsNRzux87zaJv87IIca6HRuE77VG81aFJTq4DqtHbY0U
         m1hUm2O+MjTEpbpV2IdDuOgzwEh8+urVy+e5Uf1drVpxZLmpnaKXppuIIFaTP/hp/D0T
         c+1Msbtin2n45th2aV2sChLj1W6HvWhxJ4XEm00OA/mBatLMjneHGQrbQDCHdx4iAINb
         SDkg==
X-Forwarded-Encrypted: i=1; AJvYcCWypavrn4Wpmwq4moRCASPdGb99J3H1fHMffhE9sg1qYuv/wj8qWs1e48pcJdBc7cBrAA7+Vzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3nZmPeN7s9KTlBcOS9tysozL8Y4qFYzbhlnSLKUb/BHPt9eS
	3RaooxOR0iDrbQ7fTn9fhSb/6hb+tYsMiWi44KNcjSf2pCwszQGEebgZQ/qgNh/SXw9Ct3nUZls
	9vUGoYktYUa04JT1y8kdUFW4PbboE7dmUfvKG
X-Google-Smtp-Source: AGHT+IGlQKynFIg/6AkltXaZedQLOizW/ZHUaW4WVMStWQrf/UL6qsSkWEP1jKmIeAetbQS4AUGF+zYaT9Jbv5qPkEE=
X-Received: by 2002:a2e:811:0:b0:2fa:bb65:801f with SMTP id
 38308e7fff4ca-2fcbdf76eaemr49678631fa.10.1730228537367; Tue, 29 Oct 2024
 12:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
In-Reply-To: <20241029182703.2698171-1-csander@purestorage.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Oct 2024 20:02:03 +0100
Message-ID: <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> If RPS is enabled, all packets with a CPU flow hint are enqueued to the
> target CPU's input_pkt_queue and process_backlog() is scheduled on that
> CPU to dequeue and process the packets. If ARFS has already steered the
> packets to the correct CPU, this additional queuing is unnecessary and
> the spinlocks involved incur significant CPU overhead.
>
> In netif_receive_skb_internal() and netif_receive_skb_list_internal(),
> check if the CPU flow hint get_rps_cpu() returns is the current CPU. If
> so, bypass input_pkt_queue and immediately process the packet(s) on the
> current CPU.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Current implementation was a conscious choice. This has been discussed
several times.

By processing packets inline, you are actually increasing latencies of
packets queued to other cpus.

