Return-Path: <netdev+bounces-218636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA8B3DB5E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C173A2A60
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67D2E7BB4;
	Mon,  1 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrKRSQKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F842E763A
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712788; cv=none; b=WktPmidD16Xbx7gAOTWQnZBVNDiL6z7SEJ4N7ZlcDWh0DNaT5rZuumM0T48zxMHjty4jvWKJkXvPtwHbBXmQ41VTH/H3Zi28atW6rcdx4aLtIjbrONiJ+G8vXr3Z/JK7a/ntgO5/Ncr3Y+TrFG5f2g5GgBXRWWgj4+j8PwEBZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712788; c=relaxed/simple;
	bh=yVqPrnaKEVvZZucDjrJTxx1dp8L1AOneu664tqAFLSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0k3Y96BiC/vaxA2BDJKWNnXGNpRR5zaE2euJc6d/7I9RI+OWhgnLAF8wMRr3xSh+Acqth74llChRhkaCcPCd2nhmuYuJX+OEP5056alD/wD+9f4rHmAn7NKzYpI9FlRE/JxYVwTeOXOJdfwMrGv1wWErOBnZ7kfNySJdnkI6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrKRSQKl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e872c3a0d5so411103585a.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756712786; x=1757317586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVqPrnaKEVvZZucDjrJTxx1dp8L1AOneu664tqAFLSI=;
        b=zrKRSQKlnrhTzQBkqmoKmJwnI9DETjxucdxDpudj3Vi4pIv5XOlPpPD7A374tb9CoH
         8lGIujbftYNsT1fOTdG/Ws2F8bdsOU+1N1GjWnEA0s61qPYFWv1Bel43kh+Z6gveOH/7
         K2xx1D5UNIAo90y+cZJh8nR6fL/jGzGHSj91MLtMvOfMhdP288c/wK1NAMEtVBBto0d8
         FlTlpqu07hd+Qv5HdHwJC2vBdElTzFhCtxBMDLc2+tpQX7TtBy9Qh5kw8BQLixyegTIW
         1qnL1ggww5yIXx0z0aRzeMA3Yy2+8001UGicLfYzl6gWOMuU7VIx2mSxtjkfK+JwkPOs
         eVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712786; x=1757317586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVqPrnaKEVvZZucDjrJTxx1dp8L1AOneu664tqAFLSI=;
        b=O1GeMSD8Macese8IEc9+T8oUJfmF93LmrMhrU5nB+3IChrPIo3xRsTHvvCw9fFrYjW
         KClynWYqk+1fZ+nyK8Zy19XzZvL8tsY/61KmT7NkOV09cIX/bA/v87nro/FLfugYetCu
         B09IBFJqNRCnt6dmhiezsWs9eFkv+nO9tuldNtBTTdQ+KPRMP7Pk+euPW1MT3uINEC+W
         4GRaZ5aFdYS4a2FNxMET7qoRGN8Vb+7ojUKLKqy3UGzRNYGbrAG/3cv4fVe6OTZuvx7u
         SNZ4rlhGATZHMRjVFKtPcyxtHZmqrIdg/h8VIGCpM+8r3wOPELLSMW0THujqikWvrPow
         a8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXMMKuyjqlftiWlJLyxXwuVX69ZesvvOl67UC6YdjTkL0nht6/uKftW2bhirwxaABwPZpw4ThU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5M8RLEI61dAih6kY6f/rX2VlXSfPFkCqP7xA9LMW/qD6AxSC
	HXsu6Msmw3vdkXXku6nfMxRrP7NpKqjUpKIKI4DM/Enhwm0zPubQuHjh5ZXvrwo0m3HHD5BBxfU
	WM+aaX355ocK+KlLknFajcokb2HyZCFbBzi4bVLp0atNvMyd0mWqlSoD2
X-Gm-Gg: ASbGncuX71IVm9pmvwLvO9F3G/XcnpHoRM+U8/g14ZjUyiLb11pmvHBehd7JixWfX9u
	T4bqmaRucb4BNDs5ujZcwrB8ruFDEVYHP859QxU4XwckrV3DIyA6TzrsqhqTvm4L63Ku0rEs+9r
	am4kPRfNdCoOH29ta4GyFACr8hI5H1S27XotLScw9dClyOTJZUI1Auo42qzbCuhbOQIDDf4FBc/
	psb5W6XckauQQ==
X-Google-Smtp-Source: AGHT+IGZTH19RBjUvvofErMZ9h/jiQ2Ewo/uI7zM8ow9n9zGs186Jgh1xXso0LhtJRIip1oYULbc4ckuQsRYkOaolNs=
X-Received: by 2002:a05:620a:1724:b0:7e8:123b:e3bd with SMTP id
 af79cd13be357-7ff27b1f891mr782617585a.18.1756712785561; Mon, 01 Sep 2025
 00:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com> <20250827125349.3505302-2-edumazet@google.com>
 <CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com>
 <CAM0EoMnk8KB780U=qpv+aqvvJuQX_yWgdx4ESJ64vzuQRwvmLw@mail.gmail.com>
 <CANn89i+-Qz9QQxBt4s2HFMo-DavOnki-UqSRRGuT8K1mw1T5yg@mail.gmail.com>
 <CANn89i+nNZx3QftApMcyb2PBopO=v+4rR-gKZZTbUReZjT41Fg@mail.gmail.com> <CAM0EoMknB8MwZ_nPgpjH3N50ahRLsENr4HibKQHdwNGNO5sf9w@mail.gmail.com>
In-Reply-To: <CAM0EoMknB8MwZ_nPgpjH3N50ahRLsENr4HibKQHdwNGNO5sf9w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 00:46:14 -0700
X-Gm-Features: Ac12FXyxjJEmlDcyMinOjf-WHxfWSd15XAqnHIDcph7E4_MWhcs-PNXVBFO-Azs
Message-ID: <CANn89i+onfYUtje3Nh8tqtdsKvhb+fPjeAnVP70mFrrhSWaUaw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight actions
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 9:45=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:

> action stats dump does start in tcf_action_copy_stats which will grab
> the lock (in either gnet_stats_start_copy_compat or
> gnet_stats_start_copy) and releases when it terminates in
> gnet_stats_finish_copy.
>

Right ! I am back to work and will send a fix ASAP, thanks !

