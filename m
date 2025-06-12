Return-Path: <netdev+bounces-196930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785DAD6F5B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC21710C5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51E1442F4;
	Thu, 12 Jun 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmuqqqCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95C2F431F
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728828; cv=none; b=uwnkZTl0zMY9KxOyxdBtrMcIcWTC1rxfQM75IWz4Rrysh8ZFceU/ik5swU7O1HgLPr6VoyXYc2MNzYLpIYxPz5trVC3LWFxXzpzzsUG33QQoxFMnJG5zjfXx3s9xj4E0q7JaqEZXsTxxbhK4ms5dFzb+QPGE4THQsS/Z8HR2LfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728828; c=relaxed/simple;
	bh=LNt4jF9PV7lQgcKdp+6BLnuqei1S13tt2i+HtSakjWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7WzXqtsl4CRi4GfoxI25VHk97CIOb07agH6ISqpeI6Jcmnz5X0H3mscQ8fxTZ/ifOQPxpUdj3+0LkW4jZITryoraj2uz9afWyyemt55bozTrgSe4IEkUUeRBafm/fXEfitSMoyroJsQ0bVSn/3tsej9XX2OMyvrnomvoOhsgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmuqqqCg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a720e806so7599751cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749728825; x=1750333625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNt4jF9PV7lQgcKdp+6BLnuqei1S13tt2i+HtSakjWM=;
        b=qmuqqqCgg3cIql1/8Guf9JFF6OotogJQr1ee5PP4puJkvIDSexIumm8UBMRwudknqW
         gWbDodU6Mad5I4K9NAEdY8GOBYLw6xW4Pmgeho64PMZlZtQTpBI52dJp7W3BPn+Ok8Vf
         U8cT1kyKjgHc0flIUMDU0stFKht2LG3tS9Vi54Y0sOXgNdmnHsaLdKEH6jAqhJ2wybPS
         XPyfq1/YZLlp0VE/wXfS1i9j9LDdgL3hJOzeDum7VdJQ+6jIdFwCV4XtXPlzBINrClyg
         jTt8zcgGT/nt6pN85lCEIrWcn0qv9aokkfZr4kqpQOVZeXYpmCRpJUFOlUMYEjsO1viX
         zaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728825; x=1750333625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNt4jF9PV7lQgcKdp+6BLnuqei1S13tt2i+HtSakjWM=;
        b=MYN4YQ2bIhgdsNI2XXIk5K3lNQ69uIRWUI2Y39DPJz9QS65tsMteQpw+Jrv6n3cOyu
         ZaAyPWcJv7FDRZ9T4JCX02qNDRlZfaZj7zOFjIBu5SSGTd9LtmlqYcmzbUjyMPYGkDUC
         orx96vGwADA3BCRz3oA9YLKxkgXrLR2gPdIq+0n7hKKkxCmtSaJ9/Wu/TADxysAnoDVX
         b2Sv9HhYTDQQsPiBwxUdog+BGGl9YB4Q6cetW8cvM49K0zKMkHrFZpuOkP2s4w7OfhTj
         rCKyHZP4V3cCayjsTD0Ozq6/lmofwHfyay9E2APdE/upzM2ONgDFSJE1LB69Ur857S6A
         wBuw==
X-Forwarded-Encrypted: i=1; AJvYcCXVcFgr+ZuDTyAl03YwVk08/5XQpTEHP5qdkn2Fo4psL9rl0W+XTKwXs1HHWI+82COv1GmwDVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBBywqARttrJyedAzrEVOH5qQxnQv4pVAIxGwz2kw6qvAVLee
	ORv7GFYtjQyRtw3a33vKnW+ApY6rW8hdEmtAQXZIqWsVgX6yGNN0b1GTHP4nr4InlUrxnpHVF0S
	KZOehnkmLDfO4mz9i9d4ukTF+Q9F5QsWl1Sm/dpB6
X-Gm-Gg: ASbGnct5k0R9Iu05jd+qHYMid87sp1zAstsgI/b30WGoXoEVtYWP4VaFIzqL7xvq3ja
	vMvNiP303PcHX1wcHTjIXkpei3klSCod7s8cHpAx29cPIIOTXBIRKaHmc7GB6SbRBwQ4/kNNOmC
	G0i+KMrCTbUDxH5ZhwbBYte2W9drimNmm3dWBQwIULQpo=
X-Google-Smtp-Source: AGHT+IG9Wsxh+unO2J+GWRYKuv1aogxaRNWaMeLrWHKU1we9JArFSRAwoUBnACwzauC8hVYp4BWVXeojfO+FAxlvuPU=
X-Received: by 2002:a05:622a:4013:b0:494:aa40:b0c3 with SMTP id
 d75a77b69052e-4a713b8c1e5mr93280831cf.10.1749728825288; Thu, 12 Jun 2025
 04:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Jun 2025 04:46:53 -0700
X-Gm-Features: AX0GCFulWMcYms8cKd1RsB7q51NKEFMAN5xspZcobWdjgSqu6AyODEBgvXOqLIA
Message-ID: <CANn89iLQVzEYND74vSPRVpedodME+F-+HME4YmhnA46PdFuwrw@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vladimir.oltean@nxp.com, netdev@vger.kernel.org, 
	v4bel@theori.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:17=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> Since taprio=E2=80=99s taprio_dev_notifier() isn=E2=80=99t protected by a=
n
> RCU read-side critical section, a race with advance_sched()
> can lead to a use-after-free.
>
> Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
>
> Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMax=
SDU based on TC gate durations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

