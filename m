Return-Path: <netdev+bounces-160057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219ACA17F92
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D897A2253
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306FE1F3D46;
	Tue, 21 Jan 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ACp7ShVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1E1F37BC
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469170; cv=none; b=jLjat5jA91QFUarwgkPWs/7rZ7/ymQ4Q0O+sgLf1Ihs0bDqFXnsy53WN3NRmEx69AGC48+45qzN39qPjMjX/5KYm+q+4R2GZmRnlepQODp1l92UACRgMEcIL4iw1yDRJDLsoAbFPqmS8cLFS6r6xTQdjCyzpKTfjBuJ5eXhz51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469170; c=relaxed/simple;
	bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABYaaLnFMgBDIXPXP+1FCixzALvZuiF0JTPzH8o3zZqE0KQ6sI9aeMCV9XGBvJT+0tm+zkqaBhJtK9E6n1WsnxolKRsS0UylG85O3Un9rhbQOU7nkWA3dP9pZ5VIwR7fND6Trgc39ISCdb8VfJ9LC73J+zgzNZAUMDO19U1GWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ACp7ShVY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa69107179cso1079574366b.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469165; x=1738073965; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
        b=ACp7ShVY8p6wbYZV1w/a9PNrHT4GNgkND/j6PYlNu/rMLaHPfd4IfBosLFdAn861NA
         f6R9shDB2p9bWdKh6jfIAOgPjukJsCoKn0dfAwlk1X8gic4hHPKfs+tXE81XwO8Z6kf+
         zJH29XSGdGveHAITM29sZ5G1xW+wAIeGFeAa+iXm6E6rItVWvP+kjYjveXhc1WYXohPL
         tQC8RfUNyODeJ2wWUuyc4rK1F0Gu3ZYonyLxCrgZKkeS6MZUqHnP9p8MOTNDJ8GVloOS
         m1uSXTPnyAVAYxPGZLx2g2RcQZs/mMjq8ifd62b1MNUQV21ngv0jg98uctqsgslwgZ9F
         aT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469165; x=1738073965;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
        b=Mn7T0bNBipnT2WnjgHwA94phSmLxNzBDfNbBOEfdSmyLbiMnWQbpCqvy5dOvstvCqD
         mQMr7yLt8eG3B/Wl65AwPwY9IQhlGnLjWqd0XF1DLr1fhYjO1f7TNqqebvimORqYz0Wt
         jRs3NM0omlXsYYCFDrNjiwrQ6hZzvVXz9rx77LZGy/sPym6rusN6wD14t2LIr9SfUgfv
         WeKc+SGCF5jPM8onP5eClq4Au+Vs26iXEOE25T70fseJ659YnV98L8D4U3njESfMu3Ze
         kR1J/IHgxZL3P7bENrFO/rkec2EKaim8RWHi/kJBUrCOxwDgO+OpGEZziSNS58mX45wT
         LQsA==
X-Forwarded-Encrypted: i=1; AJvYcCV3u0dV6f4hepzLFEzG4cQ9+WGyoR64w4mNZSpg0AUpwaCilK4lnJx41b9ZVKfJOYSQmzD1fGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTY8n6dmawD76GIu5bTpQl1E1KUc8k+lrLPrMlaoaHqLabipLe
	nVxCs480T7KtIBs52k13vxE1LJDacyV8JHgoxfrWmA41TDLRRGXc2/vQelWhvVA=
X-Gm-Gg: ASbGnculMiaD0cE7V8mCPXSmUM2r3i/YTyq9CRTMswnaKsmM6ceVwF5azMn+heOiH18
	tfm70IGxqHeE5EJQuvYd5Y1IuiqgXeuDzMBGu0MS/f+aevRxWRUJwwrwDYbCjcWe/TPb1EeLOA5
	NAkhx/i2/YMAmRKR8LNskDM2YiizyhTGLhCUZoGk6UvwnivM9A3UVnQTYZFEEdphg4bIwizj+H1
	7fjCc1uB+CoJYBS/sbvSlSUUIG52RNk/AX8Ij+ulot1NYM9UH6NXRGiG2/31IM=
X-Google-Smtp-Source: AGHT+IHqoZlch0NckMiqj2j54cDxGsvFFhBkVOqSDvHro+EPMUw9uzJs74fAnODhJFiV9d7n5h2OUA==
X-Received: by 2002:a17:907:930b:b0:aab:c78c:a705 with SMTP id a640c23a62f3a-ab38b3d4253mr1645512766b.52.1737469165234;
        Tue, 21 Jan 2025 06:19:25 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506c:2387::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c61388sm753778666b.20.2025.01.21.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:19:24 -0800 (PST)
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
Subject: Re: [PATCH bpf v8 1/5] strparser: add read_sock callback
In-Reply-To: <20250121050707.55523-2-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:03 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-2-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:19:23 +0100
Message-ID: <871pwwi710.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

