Return-Path: <netdev+bounces-122126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0203E95FFAA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 05:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93938B207E8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B817D2;
	Tue, 27 Aug 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOPfV0jS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C54A33
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728642; cv=none; b=l8g6JQl8cN+4UK792W9fmFfEvsUFx1S6uNUnUv1N7llkkNzAjp4ngYi8/eHDM7V1c6S5NGidf86l75A5ua8vpOT+mVYmsw9/Gvue/ktTpWvsGP2ohDKmU7SFFYP5NxeOuG38WMijzTfInltF98luv9QL1iprtJtyCPp4d5sECbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728642; c=relaxed/simple;
	bh=zXbdGZbg8NlKHYVP1qZwXyuYpG0hZ/gp+Wa8X7omRiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIV6G5pdJRwbhvPbWgOxDFcSx9FdkcCfP9jNAVv+nO3XRPVlsMvCh0KOHdWVLi0ft11p89neLv+chszo9DmGNeqonWeKDv//AHInit6OgjzznW2Yj4fg9K3P25KAqZgaGz+MPgUr4icwsGJppBJlPcpd75D9gHMB98E5GmIrZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOPfV0jS; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8f0197abso250676439f.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724728640; x=1725333440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXbdGZbg8NlKHYVP1qZwXyuYpG0hZ/gp+Wa8X7omRiw=;
        b=nOPfV0jSQ/h2oDYuTDlUOtLY9t1pEk9cxqPo9tjlBhE/2nODaxOEjm29wfqQSniwEZ
         HI6tZhK6ZcpxmPQu2lV8tj4CFL0V+F0NG37RIMTW+ZcJqFK+1jAsM27zCHSiUFuldm27
         SSHEFURhR9Yfq2aholhnErzKr7+mQh2WSw5LCESHr78JNDbjU3z0GYrtND3CbxnxNQvu
         ArOCK7o7v94i/tmLXGSSNFnNNF0Gi8AyTKRc1UBQt99M146H2E51rpnzN7edp35Krwg+
         IaMzft0AWS1rcKvUbBk8Vec/Gq5SoAGiFZkyqk5Btv0HGzzxqRSmzdE/si1Kz0MYuUiO
         cJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724728640; x=1725333440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXbdGZbg8NlKHYVP1qZwXyuYpG0hZ/gp+Wa8X7omRiw=;
        b=V8oWhvcEE/8YK77ntuHLA4408pWQYrBNdsBJYn4t0c17AOAwwEOm78LrPxF67+eVJP
         C54ty5BSGyRJsna+rYEum3n0iTEBDVifachh2SJcKPThkIPmfXOVPwgutVb/GFwdD3NK
         8SXyGnYSmj/eVvdaZgIKHu/eOpk//3JQWuOECRQrVa0tRYBiLo1CtzfoJB6Nwysa+C6N
         r4sqUEPYYHdrV4iy+fzWbl5QZklBbbb1ZoGjpzK5CeIynEtFsrIJ3rtx60rgTR+giuOE
         9SDXF6ltQq8MBA9C+gD1qtjed33BfEy/23NXxvUiN3II0OBGZvmAvVEb2GKKwq0+LJ3e
         4C9w==
X-Forwarded-Encrypted: i=1; AJvYcCXw1I3DeaGPNfm+pu3GKNqRT2VCdx59BgSakdyzBs0201PFTh0M8DZ0gBdfjR/elvMBQ4KAxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJeHaqL4JWfV+HYHX6XKpwVF2pRA5Nsuz/zSp64s9FpLyRQaV
	FISxYiUzsHwkpYTbDYsgrIBKIBYfcC6szlfplOvMBv9leqIvUUwLXxmkcNtx7DLhymmXJanAscm
	mP+V3jZ1omSpg9OQQNu4m7Qqop+o=
X-Google-Smtp-Source: AGHT+IGNLbqEiSubJjssK0FpDDgB6TgkC2I9pU3tw9W20+o8W2jPG/L83doG2p28JMI3tRuR73tFPMkOSJQSBDkW394=
X-Received: by 2002:a05:6e02:1a63:b0:39d:2625:b565 with SMTP id
 e9e14a558f8ab-39e63eeb58amr19329285ab.19.1724728639977; Mon, 26 Aug 2024
 20:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827015250.3509197-1-edumazet@google.com> <20240827015250.3509197-2-edumazet@google.com>
In-Reply-To: <20240827015250.3509197-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Aug 2024 11:16:43 +0800
Message-ID: <CAL+tcoATM_Gkj_wq+myVD-y1JQ_NOeiCpxgV=dZLxgn2-woS4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: remove volatile qualifier on tw_substate
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 9:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Using a volatile qualifier for a specific struct field is unusual.
>
> Use instead READ_ONCE()/WRITE_ONCE() where necessary.
>
> tcp_timewait_state_process() can change tw_substate while other
> threads are reading this field.

Yes, it can happen.

>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

