Return-Path: <netdev+bounces-160989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEDCA1C84A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CFD16391E
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA141537AC;
	Sun, 26 Jan 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YnG1MiVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAC13C3F2
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900708; cv=none; b=gs08Tj5jTraaoHbYamIK/JKGwZDMcIYn1sfWFgvQjRpvgPLGgVGiVauxz9mxzCXXCH73ykklva1WcjVP3FCyH5EX/Jo6JfX/Dl86+Lr0Yvw33EYgzLKYvcEidXDu0NLtSkgzg7TjjoRL5kw3AKL8YVMXIgVrkMeM2lUgx4ovgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900708; c=relaxed/simple;
	bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMDV2TXvrU6QRM05NlxM59428CrPrdTQeckUb7sVGCD9EuHqWREQpspy4FPd4Ha5Y+pyfqLfacRuX2rgQ1UXIW206BoKLTBZQOJ4hxWL2ODAo0cV5DrzstmVCbxJxktLbmtYyvybqr0tAY4OxgpkA7rGEsNwgMy5105hl0CNR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YnG1MiVt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab2e308a99bso704147066b.1
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900704; x=1738505504; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
        b=YnG1MiVtxyeJ9r3CsHAYBUzy6KfIIQIxoxtPSVTXES1p+HdITODLJiD5QC+y5BSJ7d
         KajWhHTVVXt3IWoyhJ8lAxgZwcwvXxHWtiZjyk9hAfsgDsHCWnf2AJyUzVsiVVm8ZaTA
         uZGcoHiSLNZla1Hr1K0aaAwlQqCvVRYdzApWQPV6rruZmtA1LwXS/EYurf2Lad+YKPVw
         9Gvp5+vd1rT53HD98Ki9zy2uOttRweItmMIgYfU52AcABSQw1PGdFS5S/CGKP4VpOwxd
         xbD0L4A3d1yJZFead6dE2ueuMWMf2kS/dnJYZ+yytcM4ThQjrwoW3cUel0n/oEayl9k+
         YIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900704; x=1738505504;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
        b=MaAbFPfDZk37y3YrVZjakqvLnS9PjfvyfE2aFFufqNc8SeiYTa+GoeGyLf2JgBVgiB
         AFODpJO3I1rkrgDj3Bqn/kcbREtjyS7fqvbHTGT5T5xqb3tADv5rOFUuKROm/cPwVBPg
         0QIKVAq1lXTsaOZmmdMJOHMshsnVU1CJ6SMO1IDBrRtJ4WD3gAHqV/MjFRJgb/ADzNzd
         jFGDAPJcTKOBBs0sr/Gy6CJwkkLrnO4LICUikE52tkRlkEkKHCqAjyDr1JQY2RTLZJjh
         zZkNc7pMJoiJt+vTG/O7D3JJSC9kn29ZoJa1ivOxcfvUwM1Knfq6grBQdVPJEdwNCPg0
         WuzA==
X-Forwarded-Encrypted: i=1; AJvYcCXmVrsYSF+MJAMmPHGI4kUDrHaiwewppbdG2K0W08nOc+gnkIzYyFjgeDPtzNjN8nZhh7bZmL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8Ytm8pbXrUjNuaALQynE8LQmAmkXrszM/hPOjPDSGlmyoLgY
	0Hlu2G1Td7Sy4IeFIACYG9RUSilhAvSCqrctpw5IN2KlAgppQKJo/a1X4futU6g=
X-Gm-Gg: ASbGnctFxJB/f+w9k+oS10L3nYK4p/IkrlD8fVrE2zNc24RpmQpV3vkylmgpeTmH4ce
	Y7W+HnJFHq7SuUDf/M4ybOefFmzt08DxMUefEeTp2MisvqrtKKbC0MGmYAgJZzp4FTjWHckNiOO
	0vvPnrq908eSy91qU82Z8o1ElLlhxFIulP9nsXGNUQz1aU6F4qGhP+APuHw9IC3a7iy+93MT2O+
	VcFVOcIIzbyV4ZCriVHyXrVG9CT2vZ7YrC2RYfLujHQB42nt5bmZPrOFv913+leo2HceVpIsw==
X-Google-Smtp-Source: AGHT+IEKSJdD2dRwqzzBvy9ISrqzwSE8h91lW/SaOjyNpZpNcIf5gT5KiPiOM2vkBbUPwNzHl+oUMQ==
X-Received: by 2002:a17:907:3206:b0:ab3:a4f6:7551 with SMTP id a640c23a62f3a-ab674600f00mr739626466b.13.1737900704480;
        Sun, 26 Jan 2025 06:11:44 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e64dc9sm420223466b.45.2025.01.26.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:11:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 3/5] bpf: disable non stream socket for strparser
In-Reply-To: <20250122100917.49845-4-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:15 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-4-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:11:42 +0100
Message-ID: <87jzahd5r5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Currently, only TCP supports strparser, but sockmap doesn't intercept
> non-TCP connections to attach strparser. For example, with UDP, although
> the read/write handlers are replaced, strparser is not executed due to
> the lack of a read_sock operation.
>
> Furthermore, in udp_bpf_recvmsg(), it checks whether the psock has data,
> and if not, it falls back to the native UDP read interface, making
> UDP + strparser appear to read correctly. According to its commit history,
> this behavior is unexpected.
>
> Moreover, since UDP lacks the concept of streams, we intercept it directly.
>
> Fixes: 1fa1fe8ff161 ("bpf, sockmap: Test shutdown() correctly exits epoll and recv()=0")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

