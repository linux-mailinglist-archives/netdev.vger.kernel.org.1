Return-Path: <netdev+bounces-107062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388491998D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09E7B231A8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374114D6EB;
	Wed, 26 Jun 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lH3XanB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AD193060
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435673; cv=none; b=ktLKFEgSy03nBzejwZwS9JhhHwgLvqZ8FeAc9l/QyDmTNji6qL2SUoRzBxb4lqQ3+KacliO8WTs0YHCX6hwe1ln7MFd+JgGndR3bdt1yF6tVdq+zFA/3AiJmzc+38KXp6plVOOI3kwnFNCGoKLgMQcszGsJJxuV3nawnImImqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435673; c=relaxed/simple;
	bh=FgLMNTk9agYplCM+z4T1uA4Lttba7ZINMUYOLN6MORM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdJEnaqYT0UvdiAEVSW2VjfcvDqe3VcAw/I3HURQBeHVPO/ELQkvMBvTIjH1DoAOdoHA7xdWQMQ7EbZ1S8y6GuFjp8vYrI9VA19TXxQ5pdP1EO/NHowKcfPkom+5tJjBb+QVZvXN4jrp46yssPzzSkyG2f6MQ7UmNNOgIr+BiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lH3XanB3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so1368a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719435670; x=1720040470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdWq6PfDUMLzy9qQvt74h4wgoGX40LxlZT+3Owmvq8o=;
        b=lH3XanB37XeiL5hDiQC/kAU0ETQAWLlpIE89UW1l9AZ1Ngh50Iruax9qJS4aELojta
         fM4wXaHFnFAvDHQQ5Dh6XZHGZOIGhdY/o5Q8P0hWKJJ8Znbm9yGCluYqJZdrfgACGuLZ
         JjYoEN5g3lfrERGucUWtsZEwY6NjttWnjIuFWRiQLItmTh55Agyg1fnhd3W0YFqNGiQW
         56fzGnxCE6SXD6qJjBxwlTxLEijvLnN2DzJEyixdSXLp/DzzN1O28Y7Tn4fv702B5XqK
         ppSl42c2Xb+pp1TELdCp1uKV804H/vuIrTnWSXOcpEnTKfFnvRTLiKYcgYJZLL5TGLX2
         46Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719435670; x=1720040470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdWq6PfDUMLzy9qQvt74h4wgoGX40LxlZT+3Owmvq8o=;
        b=cwfHUgqh7Ddpvl3LCN813FKhoTSY92ufPlzFiiFHyUoBBkfk6GZlml3KvJPtUc6fOx
         s2JHGzxWQmVv0SoC4TI7ZM/6lOabbKSjNRB64hwvRMKSygk9i5QD+1MwIznttW1gn5TE
         SIMGQKAQpo4X564K9S4n8TOp9JQj/L9hmoSKQseMYPKXBo5D0i40tbWwI2dBPmzs6IgF
         HJ0W1imOTqnZ6aBIWzTgt8nXGf7pi8NzhPGYwcVLps2vmm2ego2cYjDR2PMBhFqQhxNL
         g4NeCMB1Zk4jtWc9P8Xk79cpDll0MfTXgOPi+8iLO91xWil+2xrG3HPxoeRtZnJ/EcU3
         8dNA==
X-Forwarded-Encrypted: i=1; AJvYcCUEK1fHIVhaiHBf1bneBJ4o/UY8cTmNICCtP6X56heR1h+qWEdBKhvjS+xw2dIThINu6a6oD+Z+HD75OobjiqcpctM+qyui
X-Gm-Message-State: AOJu0YzjPFl6mscSPUWvcv8Gys+MRUFVSkM79bBS88l/VqRp0K2SphU+
	IpWa7TYka96x5r2RUgX0nuuL9jDwJZRiB6kaTki6wxkcHRTLCn3bJnh78dGGSDFokw4NaRnBOOd
	6tjzueO7VzXPeKMvlLzwSseegxJuvuWU7ySgp
X-Google-Smtp-Source: AGHT+IG4HqIIB9hCYJEJdudD5O1XOJoeLG5oyTm0bszY7gcEIeXT0yIqAI91YQoK0hJW1DYwp6J0kgmaLEdI26WENB0=
X-Received: by 2002:a05:6402:510c:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5848c4b7840mr91470a12.6.1719435668609; Wed, 26 Jun 2024
 14:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626194747.2561617-1-kuba@kernel.org>
In-Reply-To: <20240626194747.2561617-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jun 2024 23:00:54 +0200
Message-ID: <CANn89i+Xd7BgbRsDkB4+_FjXU94sMF_8Zg7zJ=b0FqPa7cHnxQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp_metrics: validate source addr length
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, christoph.paasch@uclouvain.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> I don't see anything checking that TCP_METRICS_ATTR_SADDR_IPV4
> is at least 4 bytes long, and the policy doesn't have an entry
> for this attribute at all (neither does it for IPv6 but v6 is
> manually validated).
>
> Fixes: 8a59359cb80f ("tcp: metrics: New netlink attribute for src IP and =
dumped in netlink reply")

This  commit added dump only for these attributes.

It seems the bug was added in

commit 3e7013ddf55af7bc191792b8aea0c2b94fb0fef5
Author: Christoph Paasch <christoph.paasch@uclouvain.be>
Date:   Wed Jan 8 16:05:59 2014 +0100

    tcp: metrics: Allow selective get/del of tcp-metrics based on src IP


> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> In net-next we can make v6 use policy for validation, too.
> But it will conflict, so I'll send that on Thu.


Reviewed-by: Eric Dumazet <edumazet@google.com>

