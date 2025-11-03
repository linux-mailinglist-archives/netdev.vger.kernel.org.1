Return-Path: <netdev+bounces-235210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD5C2D800
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBF118990E9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82931B131;
	Mon,  3 Nov 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbk+w/iT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D027FD7D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191484; cv=none; b=OiyYduvUc+F63Vxbouly3rJVCYyAIvopk0sUI1VpjFbVMNVybu1NhTSl/nghdICBqZ1xvOLAhIBBxf+ktT/+5owgrKfuJF3QYvAkzUAxgEQZz6qup/IrYITU2il0Y0FOaanuEndVtXk5imYQr/A6pTq1vV3v5yjq9yR8xmTQHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191484; c=relaxed/simple;
	bh=hQ5VC0/dQba0Gh3YD68I7IxwQy+aFc0CdnyEKTGdTOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmB5bBUnx3CTZ9Sm2rp5bgO7vLomSCJjKwl028XDQPLa1rU876GQrr7sGTa5pwHa2AnUdpZuO5dCmaJ0N1MaIPyTSVOqk4TnvBXaJsTnHFeZzPZXxl+/KFMvjfcTnftgkzW51jqopm3TgrxyWMsipRZD7sNSIwCszcZ5qtpkCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbk+w/iT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59434b28624so235e87.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762191480; x=1762796280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ5VC0/dQba0Gh3YD68I7IxwQy+aFc0CdnyEKTGdTOs=;
        b=kbk+w/iTTdldwu+NIE5j38lnYvQvYRPwwZtKP1pUxKBbaY755k1qP2RYWnltbhNHb/
         PqLeq+OhRkrfF3ydnKF+gfWQUYAfkmnEXCY82lzWb826FXEOWBzRsKpnnPQ0wYmtTTyD
         DSUsnP9CS2lIOxH+YSyEHPtMdtPhB9ivuYD4WDtVgMRzkt1WLjgqkrfZ9Hu1aJjgyLPO
         2p2XAMfy2oXQeGMFUf1LDG55WgYu5kTzA6Ml9EUCR8tUvgc0XnGrz4bAka4/xEm5ey7K
         gHSXfyiLckkBpACMCXxDsHOLKDq5sV3WmoLklFD0xVIGPxI7wWgS69ZN9Waup8tn7KVc
         1t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191480; x=1762796280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ5VC0/dQba0Gh3YD68I7IxwQy+aFc0CdnyEKTGdTOs=;
        b=Ve9sBBBv+5IepXAJ2875yESkYRsGk/Gsf6XWCrJz3igRXqXbGvVBvEKsgDWV23NAWX
         nCnWfUDJYXDjexvwEvuiUNKqs50x5PDn0QvM/3CeCxsj3rygYH5kAeXhynXSJI3xkahj
         4venm6bs7I+NSxiTpVraKcAT90br9LltwNzVp2F6RQ+ovOR/Ze1ghCy85GbVxUW0L5av
         Bb/RzGoul2ifMRGRxo1JALVJzPnfoI5//3g3M6DJ9jn8o049Oaw/snZ+Jo3kSa/FzB9T
         Nz3bh5Ot7dQz7m+TXJqgOqkRFOS9h+lZgdz1KffwL5SDZPTCqod8dMp8I0F33soCqgfr
         h1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX53q/mOKcpx78WCHfveqbbeq4R0DezVlg/2u5hzO8EYPW+uduKrdpEYcjXvfMHGZtU1CGmmCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZh7QhV2gfsFdExWOPR8o4DZRY2Fz04Fob9Ix/YkXMV1xEB9EF
	Nzu1WJJgU4Lnlg2fMv0Nvd+/07gujl5axavzzeRJSnHXGs1NXJcAIDITaTSmItU9C6XsOxuVI6K
	uGLqY1FEn6Ba/b45jn4pYNrMqAmH31T2Vnd8f53hI
X-Gm-Gg: ASbGncuS1PZI25Q52XJvP6lrLXN8Oq8WE4hMbAlnd3qpdOfENt+6bqQlSxThd5enN+H
	RcMO4aojkbVttr4JZGaXpq3e17TU7RlN4nyzCCwrST2uPooGnoiNvbcS8BBcSh5Ywg67cvN8D7T
	RsiFY3kTQwwXSYJUtfInbgS5DWnWsbAeDIQRheu9ts5fIOCe1xAB3Ya6AJRWFSlk0MVAVi7ouyr
	5yRhoeEy4HnMBBDsvii5G1lf6YgX1gYq2bGGQMduDmlCkLa93uLN9w5Z4Bj/WWW2X0Nh2SCkhq5
	QuubuyVFU4NEPC3/99hV0X2LLYwyMbfilXp6
X-Google-Smtp-Source: AGHT+IE9UCICLFPcWntGA18am6x99K6fPgsXAsFiBEHX+FYgiyl8C/S7j9hn6Tifv1E1doUNTdSI8Mntwe4yrMFluYQ=
X-Received: by 2002:ac2:5e31:0:b0:594:24e2:54e5 with SMTP id
 2adb3069b0e04-59434541f82mr35129e87.5.1762191480263; Mon, 03 Nov 2025
 09:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103072046.1670574-1-yuehaibing@huawei.com>
In-Reply-To: <20251103072046.1670574-1-yuehaibing@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Nov 2025 09:37:48 -0800
X-Gm-Features: AWmQ_bmjeIWccYnCsAlpHCIicEVqLOMZ8MWgDqZ2I-CyDLIm1J3m7sQO4camekE
Message-ID: <CAHS8izPf5+97rtUiknXKkxpBUu4ENPUb=-MyeBD=eEAay6NwUQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: Remove unused declaration net_devmem_bind_tx_release()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 10:58=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Commit bd61848900bf ("net: devmem: Implement TX path") declared this
> but never implemented it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thank you.

Reviewed-by: Mina Almasry <almasrymina@google.com>

I thought about asking for a fixes tag, but this seems trivial enough
that it does not need to be backported to stable or anything.

--=20
Thanks,
Mina

