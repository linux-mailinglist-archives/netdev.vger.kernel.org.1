Return-Path: <netdev+bounces-212354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A17B1F9E9
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7023BC693
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6BF1684AC;
	Sun, 10 Aug 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK1P3zQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26471CBEB9
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828605; cv=none; b=iuuOeVh/SVyEFTDlAvNwZodaAizk2v6PxVqV2CNWpvNAYOMcMdekAoFRemKjHmpFHM0HaE77rGu/RMTCNNLVru/mILSSJutRr5MrZyKNkXmwh3T68ZzHfkw6oxvwnJP8lSIvwlBv3wC0bl3MkRj3niWFPZzA3wZwRXwx23o2Jvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828605; c=relaxed/simple;
	bh=EVtfsPd4I2wMc65UP3tFTwUuyAKqcoFWuqbrTO5hc3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGnNRqzCcJsLhjT7Z7jWE7Yq5KqqdlKtaoJhW25hHY7PcSemWC8cuar3ecBHEHjLNk6o5SPSYPD+qL8tygGEs6RuhSXb7hQf7YUpRehn7f4PVzlN0e7c9a8Y0nAgLnYFl3+Pelicp5w5SPsKhYGvYSC/uJ0Y2GFuWNOEouTfij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK1P3zQu; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e545dc7400so4957815ab.3
        for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754828603; x=1755433403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVtfsPd4I2wMc65UP3tFTwUuyAKqcoFWuqbrTO5hc3I=;
        b=EK1P3zQu9nt17fELziU8rM4hgs1ZbvJbqAhxQIj2ndk0JX/sLr15sWgSqZQipPvX7R
         PnLTRMvvt2tjvKfvC5bPuSezzAWZQXEyfhVRMxQg0PJN8Lx0EsXa9g0ytJH2LjhnfLYq
         PXADgh8vPIFS6W2Tk3W5DQPm7Gsb65AZ/SFl9pi6jvB/BjkuxiywtACU97xga6XOEI6Q
         GikYIpEi3oNQu717KH1hMjh26D2jLKkG0xKO0Xwo03EtSq4TXwzleuc0c+tkiHyMJAm3
         KY4dFUL+VXHqr4skksh1/OQJpN9ehTGHJ8GwdMO4br+fDqQ8H7Sqkl/gIgzTiYJMIR1q
         Nfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828603; x=1755433403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVtfsPd4I2wMc65UP3tFTwUuyAKqcoFWuqbrTO5hc3I=;
        b=PlTYKVHsua4uKWCCYvSlBN4hABmRsVZ4+I1vrkmWUKtq0m9z8JmBBLktTMdvJx4Oyd
         lKKdVOL9w1PCSvoIW+y+58rASD81+NY0nIAFXq3CqHuPrKEJbo0VUjrO3KfSCtZ7PooW
         j0Gd6FRdT+mYIH3AWKtpGMmpDQk50FYQa/jIOoNNdTLANBXeq/OOpuedaRS2L3sbAEtR
         QQKwJhhbXX6yf+1POBz36CknIopFj4OQ+bI8CqGjrO+vnXJnRRG31JkUntNmMVMCJQII
         nmIiWoKxees4OfjNUqNXRrx1QBzsq89PtLTNiXYKkoukuMPi27FsGVB8m+bKKsUnRKu3
         WgNw==
X-Forwarded-Encrypted: i=1; AJvYcCWOjoPgGivZhuuj8txjBAk4T4xdqgzeW2C9wrhuHxQ3k7qaH86EfGHiyM4PyCfCLh0UQjHGIlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGT1LcSa0d8MrrF4HBnIitQfQg6GPayv84FcdfoyzlmnE5l8C
	NXn2oBm9LFdKOqOvgo3qyPUGQb6qC+ELJLoxcBeZAGOML9p/Q/BC6NXOHpCx1rmWpCDVYFqmCoc
	NHVIIEIvOExFsbW1U9ADEtYV+Qiw+IMA=
X-Gm-Gg: ASbGnct/Ui9bZTGk+dMR2ZU9j5nCkxK63RAW1bOsJRgS0sUAK2qqxhDieA+OpS9OTzK
	Feshm/yp9XFPyKQ77yq8b5yJwTGPOTZcLuhTRtkeRRYo8UDlj15KXfLGyCT0bF4KRgyBCARg51l
	3xq/Ltp3STI4o5B1YJ/BUiYH61T7HylXEEm1aNJUXB9m0n75mXwrO4K/Ure3No/yNB+EZagJSRz
	AVK/ls=
X-Google-Smtp-Source: AGHT+IHNihEA/9zngYvPSNs+HownZUaFanokWYdKE2VIGwSEO56UAOstKHADV5YlIFRbtu+wKHQW5rqBGp0hc4GPY54=
X-Received: by 2002:a05:6e02:481b:b0:3e5:3521:46e3 with SMTP id
 e9e14a558f8ab-3e5352148b5mr175635875ab.23.1754828602934; Sun, 10 Aug 2025
 05:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250726070356.58183-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 10 Aug 2025 20:22:46 +0800
X-Gm-Features: Ac12FXziDhm_YRFDlpDASBNgcsyzmA3IKpNb-ySl_K0wnEuCRdLMg9D0dDCsyuU
Message-ID: <CAL+tcoAAq9ccjUybzxoYbVG6i3Ev1C098aGKWvAvKMUeFyG3Tw@mail.gmail.com>
Subject: Re: [PATCH v2 iwl-net] ixgbe: xsk: resolve the negative overflow of
 budget in ixgbe_xmit_zc
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	larysa.zaremba@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 3:04=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Resolve the budget negative overflow which leads to returning true in
> ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
>
> Before this patch, when the budget is decreased to zero and finishes
> sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
> and enter into the while() statement to see if it should keep processing
> packets, but in the meantime it unexpectedly decreases the value again to
> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc return=
s
> true, showing 'we complete cleaning the budget'. That also means
> 'clean_complete =3D true' in ixgbe_poll.
>
> The true theory behind this is if that budget number of descs are consume=
d,
> it implies that we might have more descs to be done. So we should return
> false in ixgbe_xmit_zc to tell napi poll to find another chance to start
> polling to handle the rest of descs. On the contrary, returning true here
> means job done and we know we finish all the possible descs this time and
> we don't intend to start a new napi poll.
>
> It is apparently against our expectations. Please also see how
> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> to make sure the budget can be decreased to zero at most and the negative
> overflow never happens.
>
> The patch adds 'likely' because we rarely would not hit the loop codition
> since the standard budget is 256.
>
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

Hi Tony,

Any update here? Thanks! I'm asking because I'm ready to send an afxdp
patch series based on the patch :)

Thanks,
jason

