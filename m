Return-Path: <netdev+bounces-203471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2160AF5FE5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625031892FC0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A5303DE2;
	Wed,  2 Jul 2025 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/fiXAss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA530112F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477026; cv=none; b=DDllh03PgdtmxZaMaKl4VVd3tqJWw4aS/coRmGIMqKL8h2VXQMBe6A41g5N3P5gDoZTELMXcahbQJGn7XrrJvNJB1kk8Xw//MRIaZEaWE/+cfa9NAYM6EsdQgfwx4N+gUBbtM7VW84+scbhVc8PHLvFhJXY8MuV2z5ovEZ4+Lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477026; c=relaxed/simple;
	bh=0bJDOVteaT0fIBktzT/oFBf4I98xYtb/XDVZbe8sAKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEajImf5Yv4ZIEWHBqgVzx4UTIsUm0DBzjwZiqWhOPnQD18RoszsMTbo5PH9l7uZYcxCPJ+9sISziiw1CWaQFUcK07Toon68yFGeO8S22lILQxeijboUfYy8DXcWht9q3qfnzxYpXszcqnvWF8Kfuo8o3KjolyzuaA4Af/7eTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/fiXAss; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f0bcdf45so59107671cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751477024; x=1752081824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bJDOVteaT0fIBktzT/oFBf4I98xYtb/XDVZbe8sAKI=;
        b=H/fiXAssYsXurAIcIHiUI+Q/bLM68eizHy1gI2uroeN+oJ4L3yJY4p4owqsRhRt2nc
         v6nIPNBS+ta9Q0e1if9NaMpjt4KqTpuLuqkUyeQg3lUEqxNwWdfOyw8KYmvkv3ycPt4O
         f4zCT9lPFcPtWIGNZ1uaw/RnZIfeDiC7yGXqWGZ/ReRW8+es4oVB4+Yy0girZxP11Aa2
         x4yyASjCSmDZ56fohGiFa9suPGv5UtVbCaO/iodBz2gsRoBbNs6wa+fP2W/e3sKth1jK
         Nl1OO2XoSCg+AbeeYVlzJZGdoHVk1qxG959RIP720uVBHfc+3Z6/xtbOWWRhizqZka8/
         qOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477024; x=1752081824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bJDOVteaT0fIBktzT/oFBf4I98xYtb/XDVZbe8sAKI=;
        b=SnEWZpjD8PHadxtfE9iDh48QFqxptJ8EFM2Ad+1GVe/ujOJ/dFppa/FsnPVe19kUW9
         h2ViR/kBMnHraqrllJhwYU9MFgjwRPwvGgMQDm+JuKWeC6mmw1/wLX3+heE709ZLNOvh
         D4Rvp27f4tjZE9enHiLjLC9VgvTMsE+vJXlBTEQjSH0XLtdQs+KG5zchu2CwX+qcDIrT
         zoY1Q3IaTm6dhcdUxF/0jLKTC38zV989JA33tHqicHl6LXZqbC4c6IUoFTu/T4uaxEMQ
         MRwMOJL2ENfox1gvXpEn17010F9laP/EJDRJ3yzVUg0TtqthVrom/DLvIirtWr4YYJGF
         bVfg==
X-Forwarded-Encrypted: i=1; AJvYcCWVhCx+EROY0RMd3UbcV0zgPqzrgh+Xu9sm2N5kT84pEOlJ3pHnzSVoDsrV6aD/RWcjbFZXMj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3JY55SXPzcgqyUfFvINlKMGH962NAgwyK8Xjc1vt/h3RsuIy
	sXwr7iHG1WcwRRUrf1WuMG6xKYJIwyFgzm1C869S8SnaPTu8vhMan43ytg5oI9BZUKl9bPLnZ0N
	u4XIDBfffRERIPZrqXKI9EZbsCHStX1CIIkfKZTVN
X-Gm-Gg: ASbGncvTwzQ5VAcEM71nMl1DveJ4qYhiB8DZ9b5lU3925lb91Oqbyu+qVbtR1CVe5IP
	AQyvJtNhtc9+bxZnxmfUsTJIvUpvmy4OiavWcfTuhl2BR0Ek+xdEsDOQi3XgxG418xDABG9IOLy
	FBfmcSR1yaAa4XPM6i0vsjQM3t3fRArWbnipcM5G6+CfVtCMrIFLMX
X-Google-Smtp-Source: AGHT+IGq9Z584mPG2oLYqP1GYBHtqpVcMJI6LL1P1pdu+q2NESjy1sUexxwqp9IvD29zSis5S979zMhwz/13DHwayI8=
X-Received: by 2002:a05:622a:988:b0:476:8e3e:2da3 with SMTP id
 d75a77b69052e-4a987a20dffmr1712011cf.30.1751477024012; Wed, 02 Jul 2025
 10:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702160741.1204919-1-gfengyuan@google.com> <68656416d3628_25fe3329483@willemb.c.googlers.com.notmuch>
In-Reply-To: <68656416d3628_25fe3329483@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 10:23:33 -0700
X-Gm-Features: Ac12FXwOQL4yM_9cJaB5mJky6waj2AdTCqO6WQ7iiDQ5Q9WVlnZqcl6YLmHyQ2c
Message-ID: <CANn89iJdX3my-yb2Mw3OQa8OX2AtkiPeuFkHP_MsWNh0nu2yFw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: account for encap headers in qdisc pkt len
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Fengyuan Gong <gfengyuan@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, toke@toke.dk, 
	"David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cake@lists.bufferbloat.net, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:53=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Fengyuan Gong wrote:
> > Refine qdisc_pkt_len_init to include headers up through
> > the inner transport header when computing header size
> > for encapsulations. Also refine net/sched/sch_cake.c
> > borrowed from qdisc_pkt_len_init().
> >
> > Signed-off-by: Fengyuan Gong <gfengyuan@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

