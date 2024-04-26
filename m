Return-Path: <netdev+bounces-91566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F328B311D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B45A2838F8
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDE713BADA;
	Fri, 26 Apr 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QB6dSOoz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C913B787
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115586; cv=none; b=ZFA9lgXr1IwLec/CVx9G3M8w3e7sezOHn0m317GLVuzTOsnGXQAhqJYprManl7/05XnnDpp6MJfBsu60RobZ5a4AzguR2C2Gv+c16Qh0XZLmQwIOrWGBF0afZIAmu2RdnpKR6tcyTNJh4Qcz6zOLr3vm5EzYhEhT4awHY0m41qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115586; c=relaxed/simple;
	bh=Z8twm5a6rAU6hoLxYkCo6bCzS4fAeUn80m/9Y8e0lV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLtFd3ytPE2TbnebUWk/M4tZmJj896H1UT/+e3f4gpRfJlLWX3kfA4L4qBrBHfn7cpiLxBpnYaDJVn8l/ApEQQNnKwoBiZX0PPL4Xq/3aQ/4Dd7dP/qAXvVbow/1ttvQhBgazAuOTltnN9nlOW7YpTSgblxE1zUnIOFlVokCPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QB6dSOoz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so5932a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115583; x=1714720383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpBsRzG2GqU00foP14AueqTQMyi12MhjyWao42xVQ/w=;
        b=QB6dSOozqOJuAmjzgaAyNgHjytKVTm87+20nepEhisc4yWwXzULb50xXZZ/p0IHhVw
         huwW3ma573NA2TXBQJ2JiqVEFFakGBc/TApjYEWhYfc2TE8YnZ12sO0KQpXncpmT1L0a
         ZLazgiMCVzqymdNu1xH2/cld4n920M5WTbwpUXsDs7Agc1vt+lNEmAM0fBcUsdmP28GI
         p1ME9Euoc5RWuK0Fkw2r+QWFHv9duYf4EBUItITy8DmfAGjif2ICTqLgz/3wIqCmg7lp
         Dq37FX/yRyKdqDaHmOcJzZd32K/bGhjgisgKHelWxksBbzLGbReEPzyDgzgw6e60CU7X
         nDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115583; x=1714720383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpBsRzG2GqU00foP14AueqTQMyi12MhjyWao42xVQ/w=;
        b=mfnEJ2Uj6BZP+wOH6zWW/LRwraBmt83HrLvGFISkMN+3CmgdB10LmHwPvLADoi5q3k
         XF66kyP82+Z/x8IVLRTeaBI5rWuWu73eOplsDXzWGFFKl/fLJopeJAC4y21HGx9NbLMh
         0GklrPPzcOd/SycnaVDzdNbqH4Z3F5Ph0O2GLrKmnPF92AXi8tiAN68DNwtj3ESGwKRa
         5eF/KAFMEOnjiukEDESYQeKSmbcuvs3QTdaBcazJjMbS736oyph4SMyE65wJmTLlHu3E
         8Su6U2kEEPxhQCDoGoadp0OWFFfVj3pteSysokQY3Xa+PtVxVpNge7IbXpEBQZQZy3sq
         9P8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNZF06UJ1Dwzlm2M5JhQ+Bl2BuP6FG7zP5LU+CIWiQ/CndYzf1xXRxcW7I1PVEUC9OPsw0V3jOU1dAgNuvyw7bzdIBBOuE
X-Gm-Message-State: AOJu0YyJVIDbap7yie1v+jGs7dyCV6KyNgnn79Ng1t1EjPUcEJhXw1oJ
	7RI02goek4yc0E1OzaHafpOQJ4VEdnzRMmynpu63AkINFk9Rj9AHNpJadhMVwWm6+A2NBAjIzhP
	OZRTiND24SOYxlOS1clDXwEhjionML9VSBhhj
X-Google-Smtp-Source: AGHT+IHasITeURyfkVcPH1fs8JhvuBeC0DqAQnZkxIkO2RqgOhfI3UQSj8vllz7Y/diwljBek8rJh4/IAjV3zO6mCdo=
X-Received: by 2002:a05:6402:3139:b0:572:554b:ec66 with SMTP id
 dd25-20020a056402313900b00572554bec66mr60527edb.3.1714115582637; Fri, 26 Apr
 2024 00:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:12:51 +0200
Message-ID: <CANn89iL=eyCvykHUvViQEM8iM_y66-acuhZD4M33o+JySV+HhA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/7] Implement reset reason mechanism to detect
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:13=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In production, there are so many cases about why the RST skb is sent but
> we don't have a very convenient/fast method to detect the exact underlyin=
g
> reasons.
>
> RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
> and active kind (like tcp_send_active_reset()). The former can be traced
> carefully 1) in TCP, with the help of drop reasons, which is based on
> Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
> RFC 8684. The latter is relatively independent, which should be
> implemented on our own, such as active reset reasons which can not be
> replace by skb drop reason or something like this.
>
> In this series, I focus on the fundamental implement mostly about how
> the rstreason mechanism works and give the detailed passive part as an
> example, not including the active reset part. In future, we can go
> further and refine those NOT_SPECIFIED reasons.
>
> Here are some examples when tracing:
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNOT_SPECIFIED
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNO_SOCKET
>
> [1]
> Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10Q=
N2WBdr+X4k=3Dw@mail.gmail.com/

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

