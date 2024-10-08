Return-Path: <netdev+bounces-133019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26C9944B7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C801F262C9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40785192D7A;
	Tue,  8 Oct 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCmQJyuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03518BC19
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380909; cv=none; b=ritT6jAmpRlJQGgmuEIMURn/p9b5PZPOaFlb+Qk47Tu5Qhof9UdIRN1JVT1xOHny/bgESlJnNtdqASwEgZM3yP3uO1kj22Yk0oNpbxQnVuiLnle3ud6QoUv5ZY0mVEy3uNInAX0SphDc/SHqguwQ58CAr+qL4vzYaLmVRaLZreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380909; c=relaxed/simple;
	bh=N8CYO6QPTSLwDEqv4tdy5bBmn751XJOsucRrT/fANaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm40EddCU+388ylA5qea7fYyA5AJW/nk6EggoXBjbtfzyTYbd03SnckC2duCjRyS9SeTrAMuav81Gkytk7/42vRZ9Z6mzdDRpggeq2QXZXPp/UKLMKpyw2w7Ck9R6KdX/xfbfwCYXM75PH2gZ9jG/13uPeCqtc4ANHicnef9PNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCmQJyuZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99543ab209so253900466b.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728380906; x=1728985706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/4TUtGT0qF27zzldT6VQeAk/QB3sw8Q5sHlbOD6kdQ=;
        b=QCmQJyuZwvc7zX6ptveY6RAe/aZjZzGRaRBvPhpvGPpZXvzed1ucbcIi4fya0rPwvU
         mPRcoeckUJfRfdi9vHukBM+PNiT3H6PncjZpYtbiORF61nago6bUjEwB757wLzPxL0DZ
         P/XdioBOaYRe2qQz6/4PNMamR8/TzbhlbuWRnvPdRzQVZztSmayWgdVPNH/bS7HfRkX4
         zpoukJGaS1fFQLJ8sO7dFYAk2ufBkMuLVB95qEXR5tqXekVHujWxsle6HLsKamBHHlDd
         1K2OeZ/yhggxhY+PtEZR1u5ZVTPkj181nJvy/duDZTkm8KqNLLs26IvDjTNhvL0GbF0w
         sf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380906; x=1728985706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/4TUtGT0qF27zzldT6VQeAk/QB3sw8Q5sHlbOD6kdQ=;
        b=wr8Z4WO5DoXT+uD6Bf25huWjw2OytlutJOwdh+aAY+9FVhQIqzPY6O5DUbPTAh7Clm
         A0+qbFBew37CUAI5T4aq2TDQwVojvGtXXtQwA2lwnVJ/ayHzcxRoKzPcekT8Zi7dF2HC
         f+nzGmhMaUS4GudP5osqnhT8seZCqoWMLNS8ghoBQwCkeHVUOohENTsOAxtxpMt05L58
         3gc8pUu1mclEEr2ZAh7XCHlMfPOlY4Qhl6WsTsunNmPeiAyyjsq2CTxMhcVMkwFlg4Va
         3LBB6wmn+KyDbPdRFTcpZ4DBRsV1DPfBszw5sDefTGbWFKXjOeMrUPstPf2qgaa4reNH
         HYUw==
X-Gm-Message-State: AOJu0Yxhf12yeYuYbkUgY1gN0ziRbjDY9JRnIsBPBsBuue6JFB2/A98P
	nXpOqwEWejPdEmrfYihoLfMF801idCTo/d+lFKMDQx+BWoXfaTr7UwqewcCf++EYNNIvD2908/i
	5w3MrAy3qCNE9yECL2q0jzm321HxNNZjGoLR3
X-Google-Smtp-Source: AGHT+IGg5Y095mOz9yt/6P5OQ3BIvNF5S9gD0jJRLB8FN6Ha3aQLmZS/XnMabK45M44TzGsj5tRx9hhCkjevaoq5RtE=
X-Received: by 2002:a17:907:ea7:b0:a99:5ee8:93d0 with SMTP id
 a640c23a62f3a-a995ee893e8mr395959466b.27.1728380905400; Tue, 08 Oct 2024
 02:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008093848.355522-1-edumazet@google.com>
In-Reply-To: <20241008093848.355522-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 11:48:12 +0200
Message-ID: <CANn89iJ7ts91-pEqL3wAHAu9Cco6MDPZfr++fUjTUxY8Qu3L2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add kdoc for dev->fib_nh_head
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 11:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Simon reported that fib_nh_head kdoc was missing.
>
> Fixes: a3f5f4c2f9b6 ("ipv4: remove fib_info_devhash[]")
> Closes: https://lore.kernel.org/netdev/20241007140850.GC32733@kernel.org/=
raw
> Reported-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3baf8e539b6f33caaf83961c4cf619b799e5e41d..b5a5a2b555cda76ce2c0b3b3b=
2124b34409d1d69 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1842,6 +1842,7 @@ enum netdev_reg_state {
>   *     @tipc_ptr:      TIPC specific data
>   *     @atalk_ptr:     AppleTalk link
>   *     @ip_ptr:        IPv4 specific data
> + *     @fib_nh_head:   list of fib_nh attached to this device
>   *     @ip6_ptr:       IPv6 specific data
>   *     @ax25_ptr:      AX.25 specific data
>   *     @ieee80211_ptr: IEEE 802.11 specific data, assign before register=
ing
> --
> 2.47.0.rc0.187.ge670bccf7e-goog
>

Hmm... maybe not needed, I saw Jakub added inline:

/** @fib_nh_head: nexthops associated with this netdev */

Thanks !

