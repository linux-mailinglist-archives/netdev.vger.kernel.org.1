Return-Path: <netdev+bounces-102055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574C90147F
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 07:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A14281E9D
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 05:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0015B3;
	Sun,  9 Jun 2024 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk/Zx4gV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D428F0
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717909597; cv=none; b=oWAxE19m5OJMAhG94fH79EGUjfHYqafON+K0nqV+KcT9ihJZ3sBNVZRGAJnBFn7MZLM+dnXwGe/vRj4+K3LHEm+6ZpwbRupLw+kE/3Hc1W+PIr/y8kp4l64rNQaTmpqGUHjzv+zLtbehAOHrlZ1EKti71vmxVkmPwIzYy0IJaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717909597; c=relaxed/simple;
	bh=6fUOoAyXFC5htI1k75ExBqERUsMFn52fuPsuZIPcpIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3Y2XYxjxxXJ55uo0HK8Co80VK1UpAkFeQNkRmxvRTCv40O51d10huHX0CeLRGI72Fx7YiRrB+djGUPuOwy3v+uSOjks3D0H9A1Q2mVsuWv84TKb7KadDOOqGaler+r2JT9Hu+VuuZ61//xatn0HQyi9Fsole6Bfz3G6cHJG4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk/Zx4gV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c6cb1a76fso4927a12.1
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717909594; x=1718514394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4bOBR0hIvkUqQy+TxyEWYtDZTlg/7Ycen4g+Hrlt8k=;
        b=Fk/Zx4gVVGL+Nci23yuGYrVT/yM6uReZieW5hjY30ZG3pqPX/63bnRkbKvFn3DsZu1
         Lr0vDmNkZf8pl51SnfaEcq5tiXyK072ywVsKgPexsz0SR7NlhDDt3ppsRcJAYXj9W/Pi
         PE3nL2P7NJYKcdyxGIuOElmAnUbl1RhFTNVh2Amyzj/Z1YLQx3OOoZYgIGrwgoGRs9ay
         regfL1BB2LoK/FafQ+lkNmmY//wtFS2WumZO50RGrW1nu77afzMiJDKvz7Q6hyUB2luh
         AFGGI0Z5innkelqN9rcXo0xrp1Jz0SGUOcC3qDbNCoywqq67IumwCS6O8e80CU6TywEm
         XPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717909594; x=1718514394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4bOBR0hIvkUqQy+TxyEWYtDZTlg/7Ycen4g+Hrlt8k=;
        b=KZhwIXyjckEZloOKzGmxUl/94tnbXQvZq2BZdc+/qg0RcQolFvsPTnjxvUiS+QjTCB
         KuUU5KsFShgHPVaMe5uXivOj+kWFLyqGY4+7k7unTxoMo7zrppYP2KnBzflK5hsT2RMl
         QcHGj1rhrb8sZhv1gjf7gPtKJH7719QGzQ5jpbSh5LR45WvA0Ga43/UzsE/FLMukB+J/
         AX0ZMaCabVL1BM+Qhi0fz++2sG130cOM8Kg54Lf+31lT5BinuBKbcrptpcQZFrLsceTf
         NDZuM0LgSkMilZiLSw0LuP0UP2yTJcoGMTvBihlnWcuQbxH8hwSx1W+z71DB7yJepMH/
         N0Yw==
X-Gm-Message-State: AOJu0Yy5f5Yj82iQlIIBMQi5ApMiqnlCPAutLS3pL5+QOAYN6M7lPYyl
	9PCLewD8d2WyloWMJsrhvLachHAWq20SwbVt+3XF1wdhEFmZwpsSCxZxxeXee9D/R/g1nkUUxih
	GBTBfLaicTlqvhFUu3rVWl/7nc4NXZiyHFlgt
X-Google-Smtp-Source: AGHT+IEutz59Re7pjU87nFTc5WKUrAFeOZ1Va7tCfb09eKlKhtRuD8QT7Gi+Xwao1HHqBL5t7Sjqwcfe1Yokf/s9LMk=
X-Received: by 2002:aa7:c98e:0:b0:57c:57b3:6bb3 with SMTP id
 4fb4d7f45d1cf-57c6a8ea8d4mr165376a12.6.1717909593551; Sat, 08 Jun 2024
 22:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608221057.16070-1-fw@strlen.de>
In-Reply-To: <20240608221057.16070-1-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Jun 2024 07:06:20 +0200
Message-ID: <CANn89iLN0+XRV1YPF8BHYkxnUPmc0VHKPEFb5pq99jws2zdSSA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: flow dissector: allow explicit
 passing of netns
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, willemb@google.com, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 12:20=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Change since last version:
>  fix kdoc comment warning reported by kbuild robot, no other changes,
>  thus retaining RvB tags from Eric and Willem.
>  v1: https://lore.kernel.org/netdev/20240607083205.3000-1-fw@strlen.de/

Thanks Florian
Reviewed-by: Eric Dumazet <edumazet@google.com>

