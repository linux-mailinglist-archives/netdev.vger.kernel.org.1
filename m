Return-Path: <netdev+bounces-113521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4593EDBA
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB11A2820E9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CE84DFE;
	Mon, 29 Jul 2024 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaFwSpip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BF82869
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236358; cv=none; b=SWClawj4+VNC256p/Adm9A9V+0+InrHukU/nm0vBXTatv89BOFJaZPDQXeYYRincxC7B//mTLQ5BfP9LG0rvN/gsZr+AGBg5JmB5b8sj9vd3HxUINmUWFpuOB7r1p52UKBBORD1QIXuThASjYk4dsCCv+ASvOR8/dFChRyUfEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236358; c=relaxed/simple;
	bh=edwCJhxecjvtKuO3H+gYlYf+6fk1qPu7FMYWC8wSNFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRys8Vd+J92sCpWG13Bxxh0da6GCidmeOL1rqOTeWcStXdU87kvDOPelFjQcJDUqTldyorhEQMmnA/yAC4On4ermG5eG6ziJBNddW/3MnwUp1G0DdS7U+PjBlZgEX3z5Njh/VuTZa4jUKlgWALrnDTXaxijf++tkOmZmdPuvRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaFwSpip; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7177a12.1
        for <netdev@vger.kernel.org>; Sun, 28 Jul 2024 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722236355; x=1722841155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edwCJhxecjvtKuO3H+gYlYf+6fk1qPu7FMYWC8wSNFM=;
        b=HaFwSpipMGtyKlJ6/xbhfcnD97D2ZsHi2UA2VdRE8drBDMlRPT7nLdQLhcHevoBpuT
         A516iw65yU/BSYeaB5Dmi8GzqdBAi/ktRMg/dmZKrawmKVJbY/s2bmffQImBqkmYs166
         XBr2sYnIIRzxDle1xfHHc0ekZ5YR+xe0qw9vzRwi4/3DRqx5SehhCEfIJq6k49E316js
         n/Xu7EwoNmfO/QnCROK5bkXKbh4QnT4Pl7na7z5cns2QBEqWKq3RPvTK9udXKAL5YBjo
         xFhOrUi8pTJm6YgWOPQOeD+Ye7M0dbDhg0onr9RLEjwwuffTNQ/5dneXTUExxhpYsC/0
         6gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722236355; x=1722841155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edwCJhxecjvtKuO3H+gYlYf+6fk1qPu7FMYWC8wSNFM=;
        b=CjJFmB6LNVfVeLDmcaCkMxpa+v2KZ/vGQi7eKtGYK1iSgDcqje4kzIU3PtNWbi2x/u
         3qg/2G+QfAPPrfH1d+A4rsfq+03Fjx/eCFWrGdBNvChJc9qmVqiwqg7DSuJOHjqJhXih
         wyrx7Qp384v1RPsduVnbamG9wbWGE5dVX6nDH01TqRqQH5gKU8tYHcMGhEQEZ1af2kex
         PTBKol35CnhFicob6TTq+ctUKw3mA3i/m+mxXD0rmyawBfBEfZgZiXmRaXtNRL00QIUU
         1/Ko0OreO6Ie+B8FACA2VpgjI+LNMQh7vzBn57ewMTrVCkJ0Ry8JrrD/FJgHopLIu6zY
         jIJA==
X-Forwarded-Encrypted: i=1; AJvYcCV5G2Av8TGqCEUxaGdkX7H8+WBx7BI8tCU2LB/84upV8cMwIc7PCyfGviEDA5i08eBTy4YpNb/jhPW85DGTgGYP8Dbqz0Gq
X-Gm-Message-State: AOJu0YzMdS4gRxA/xUCRxxmlKZ/YjYPhjxiSOPmYWtsjiTiXH1J7E3OR
	+x3bajWWBEZSinRqWV834ejyFlopP1m6fiEPhe4DYslc4dFVt+FHIUznrrM788aWgNdvR0heZDA
	YFcAz1jjtXb7jU+S4eFAu5zE7uv9wT2VWFFiv
X-Google-Smtp-Source: AGHT+IE07g0i0En7/YfPz35wfItNG3rb2ji/GN0dWQzrHlp2L3hOePlmGu1U0eFUgaOGbmPxVdlqLyxM7k4A7bHp01o=
X-Received: by 2002:a05:6402:27d0:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b03425d578mr214793a12.7.1722236354931; Sun, 28 Jul 2024
 23:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726204105.1466841-1-quic_subashab@quicinc.com>
In-Reply-To: <20240726204105.1466841-1-quic_subashab@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 08:59:01 +0200
Message-ID: <CANn89i+56C=o-7FLxdPhDe4eEPffV_MySOPpmTmmkBNW_Tx99A@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	dsahern@kernel.org, pabeni@redhat.com, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:41=E2=80=AFPM Subash Abhinov Kasiviswanathan
<quic_subashab@quicinc.com> wrote:
>
> tp->scaling_ratio is not updated based on skb->len/skb->truesize once
> SO_RCVBUF is set leading to the maximum window scaling to be 25% of
> rcvbuf after
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> and 50% of rcvbuf after
> commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
> 50% tries to emulate the behavior of older kernels using
> sysctl_tcp_adv_win_scale with default value.
>
> Systems which were using a different values of sysctl_tcp_adv_win_scale
> in older kernels ended up seeing reduced download speeds in certain
> cases as covered in https://lists.openwall.net/netdev/2024/05/15/13
> While the sysctl scheme is no longer acceptable, the value of 50% is
> a bit conservative when the skb->len/skb->truesize ratio is later
> determined to be ~0.66.
>
> Applications not specifying SO_RCVBUF update the window scaling and
> the receiver buffer every time data is copied to userspace. This
> computation is now used for applications setting SO_RCVBUF to update
> the maximum window scaling while ensuring that the receive buffer
> is within the application specified limit.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

