Return-Path: <netdev+bounces-171073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D718AA4B5AD
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 01:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1614A1890784
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 00:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC142A94;
	Mon,  3 Mar 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR2LCS1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9D2A1CF
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740963501; cv=none; b=jV17UMzgwKv2NDUWJ2uCuzoZBFRleAgCTPHx71bjVFeuGNAGCs+LibkmfzGQqsOSTdkrU57MxPRkwmRQMAyL6iV/KjmU3kwnhrqyVoAQ8C54sJEYGn84In94yagNlGiL16hrxUWnJEf43Ow3o7gSA/mwWB29xpgO7mTDX3g024o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740963501; c=relaxed/simple;
	bh=JK9Na0ESTQTgA0777cNwvKPnttUmDfcGIQgnbsk4YSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFnAw6JDgOPApKaVNFTyiTASq/d9N0UinmwtnyFnNfDKbSNTCwIYKFUJuFTyz4BDtqDvrFJs7Y1uE6Ou5Q8fTfxhIqr+c6DyErRBxDMgVbhcpHggfB74zvhthtZrubvLy3/LH7F68jDMawgqvkq4mR2ntx68F10v01N+DGY7IHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR2LCS1Z; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d2a8c2467eso14842565ab.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 16:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740963499; x=1741568299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dnCOXTeXOKyzXZenmkTt4JujL6mEz0J1s8FTxj079I=;
        b=HR2LCS1Z0L64IcMOgLNyZPk926+9sM9/2pCYZ8lzKZgVgoUQW7TdJAvf8cGkifs+48
         Bgq63n/InB3sM12GFmyDDoE/Q7d7y69+ol8ixdWKDvmjEqtVy+ymMpKHz2ys+LSjxK8n
         0AhjgCZJZJwJP8sGl501BppHPTjlWaabPCIhMIIfZbMv5iczsJVadRJBoS3y0EuA3pSH
         yBTIZPEke7B90jW2gzgireEKQO1LBcCyVqFR1EEXTSmYwhEsvmM6rExr/qMvecOXa+N9
         ohzPq2BZWpW0p9+wD2yO+3FPQa2PpvQS+QVbFFfXF1aYh9v0L3CYFz0EonH5dc5v/WSN
         yxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740963499; x=1741568299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dnCOXTeXOKyzXZenmkTt4JujL6mEz0J1s8FTxj079I=;
        b=iiqFFPajfzanOG9ZGqL4QYlymngT9qJXpvHuJrn4QfotvFQboI00SfWQRG2tY88jo/
         e/2WElYhfWkHsU2i7h+OSbL5Q6u8dSCKq/K3V1G3h+6vIiaTMude77A0L+tvYLJ/xqZO
         03OymglDYc0QBLodgNk0193TDeGbckbomRHCd0ybZP5lpKFMAuqGzW32+641rHfzt3Un
         oik/8AOM+YKojVXYxyfZZXXM6j6e4KqelfRFgYBJraigMnS43t7IGPYzhEqfq6xsUtL+
         X6Z67En7/08ZMtgtsy28v1Q2XrlZZ7km6lN3RVkxYkMW+mzdn5ms2uyZV+/yv/8eH+fk
         5Vlg==
X-Forwarded-Encrypted: i=1; AJvYcCUM7eYg7z1E879ipo/ABVD3Hmf7HcbKMpjoO2pewXtkIh3x/tsMTe/XRUVDaVWP/m5p118jdeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSJkcoR1r8n67czaK/O5Vk+w3VbCsAiRrIMnr0Ea6X5Wjhaaj
	iC5/OptZVaNDcPJPpoBYBKSJHjH6ixOcUARU8U1tdK3KzLxv40KM/qjDSGRtUIX/fZnWhBOjOZV
	QKur4R00wYrSNNZj2WSzqVdWYUZM=
X-Gm-Gg: ASbGnctv2TMHv/wzfqy+Fqt+h31a8mmoKS4nf83TES1jdq9SxHOTtHHkuxRf5kFIIGD
	5k3uam3Rasi1W+cLB3lIpXENLvyxtenji5yus+ywiPPEtAYge6wabT+21gIWKeoq1cETxAkhQ0x
	M2YoXuhHYGK5D8U8LX5hh+2YrxcQ==
X-Google-Smtp-Source: AGHT+IFae63bdy25NJQHBAxOWd92tEC1h65RefK8q0N/B+i0ivlOicSxQ0cwadK1ATnOzBfJqX6gMo6S/v5z0Vxlg4Y=
X-Received: by 2002:a05:6e02:b42:b0:3d1:a34b:4d01 with SMTP id
 e9e14a558f8ab-3d3e6e746b2mr108096405ab.8.1740963499349; Sun, 02 Mar 2025
 16:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com> <20250302124237.3913746-4-edumazet@google.com>
In-Reply-To: <20250302124237.3913746-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 08:57:43 +0800
X-Gm-Features: AQ5f1Jo_t3KpVDfLp3vMSsCK0q0IxTdSsK2GtCSYnF9NXAQ0_DVrxaDQDUel1Ig
Message-ID: <CAL+tcoCAq_80eJvtbJKq89MMvZMeh4c+F_=QL=Y_5RH2wYALXg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp: add RCU management to inet_bind_bucket
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Add RCU protection to inet_bind_bucket structure.
>
> - Add rcu_head field to the structure definition.
>
> - Use kfree_rcu() at destroy time, and remove inet_bind_bucket_destroy()
>   first argument.
>
> - Use hlist_del_rcu() and hlist_add_head_rcu() methods.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

