Return-Path: <netdev+bounces-277705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COobGuxf2mlB1AgAu9opvQ
	(envelope-from <netdev+bounces-277705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB93E072A
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92D7130173B8
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C93876AC;
	Sat, 11 Apr 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="UJUmjP0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D1387371
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775919068; cv=none; b=ebblFitdQQYioQ2J+cAKdp3Ydpegjs7jiZHI+Eswkix036wgJQ7bTZI9LQZLpgQKSXub5ggwmquKKZAnt2xZ3BiqFVKovql5Rtmc8uchAchqdGKIQHXcjNlo+OfaHuKAoqHg45+72qI7hCB21BnJAFn1Bij29RrWlAeCN29UTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775919068; c=relaxed/simple;
	bh=SMC5AvmifltHpG6pxgih//w69xc+q1tf1fMtC4UbJHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP12C3pRbrBTOIB5soLgZn6ITbD14/jaI0SZKzL6su7LjmW88v/K7oZ9SaRJ+xdADpnxvFz9TJ4VGwNNLcF5K658Q0G74E6h5sA6pScaLHuNCGCBXGL1JKKzaUhQ7K6JzO1Qiw/1Xen2kpzvWBuO7e2asyxRfL77dNAUR/9Lx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=UJUmjP0s; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5193382eec.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775919065; x=1776523865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMC5AvmifltHpG6pxgih//w69xc+q1tf1fMtC4UbJHA=;
        b=UJUmjP0srT82Dv0/jSSo/UYQs9hukJEtsJpaU9cDdzP21jBBy0WecUvTaY1GdwroIn
         WtbCpx89GOTCTKbM3HAn0u0N7gt8vUjE4yziSYKIhOSDiCmEtI9qO4xFs2sE8Ic2Yf/c
         3T5J5mxJpdb7hoClra2ETUviqBdiaaCRI/PQA1WAjyr5W4+GiWiL+mVq81Sw6u5xLxfK
         Aru0s2xWHn2nmTtBxJzJIkAmOutOiU8aegjsdubrNs1XwM8O00GuhA1A6hKOwCfLE1Gs
         t4UPdZO47mj/3DYbpylX3mOi+CR82ZTE22w9ZOpxGsZVTX6tgxYA9NoDpmsTHBuhkZ67
         jUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775919065; x=1776523865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMC5AvmifltHpG6pxgih//w69xc+q1tf1fMtC4UbJHA=;
        b=o8XweveUYQGyLMQhdCb5Bje7VvNZFUphj2Pk18neaSgTU/zlcGz4GCm/t/xmlCNwvz
         50n8RyrmSPwGEFmlW8mvOYEoy86HA9jZDrOcfo9CE0HpZ/l8cOpNmwZHo/SMYNoznFrb
         Jp2sLRcweCOXXMct52fejGpf6diOyUrK0fOulUp3ywDZXUvCnieaIYOM3fu9Aw5LeJwg
         DpHBdfSz5qmMyYXRTSLE+V5vRC6S0zsaJtal2ctpyfhgkPNa1oZPj8JAt9cA7RxOVK9M
         JXWibjraSMSwRGSkLB6//r6hC/j226a4uAi/JgVQTBDXhuiwSuUsnNLfhiE7LsRzRl20
         OdwA==
X-Gm-Message-State: AOJu0YxX0yy1t2Y2gfszuV6zsvA8+ZAHxa3p1lEUuqB2liFtf1x95T47
	AfT6F9cOZmm/hf5Svix+kAUPxOkySzRa89BrB9e8Wlh2IH43y9H1uqe+wuueZkUkHkE=
X-Gm-Gg: AeBDieuLLm825CunHHaYo7TaFGEU6GI5e0fwepyXdcnQ+Qi0g/WB7FkMUuq67msH3o3
	9k6eDBZ8ZxonHv954MqYmPr15fdCEssa2vB08/G25lROKqDOyL2vIK2R37tPhxlWNdo0gUXH4l3
	luphxllMotHbQuu08LmtLweVepa5QxJ/B+gAf06u6YH5CuPdiGrpLgINaYDcClJS+lKWMxOM0qQ
	3QgOQ+z5g5cQH1bs0H6OxBEB+w/OhZzH3s6pjGoMkAcmAGwuSshwjhJUpT5mYDYsDwC3t5tpfRT
	H+dAwUiZYVlstJ4v/wCVCAllIqeC2paHe8ckgHhGIdCsD0hKJ56vPglAbvhaMlyTvIWVsJ685yR
	uBp6SG67Sy7PFVc53Gm8ZdwILXbW7raDeL4rJrEQ2DFJ6gIzD1EZcFNpDuXroBOOLGbK4IJMGjt
	t5QpFlAiofmiwt7E8+B38OKnZTAYD3+Bsmb78=
X-Received: by 2002:a05:7301:1003:b0:2d3:dff7:13c0 with SMTP id 5a478bee46e88-2d5891766ebmr3827856eec.14.1775919064627;
        Sat, 11 Apr 2026 07:51:04 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562ac344csm8845922eec.25.2026.04.11.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:51:04 -0700 (PDT)
Date: Sat, 11 Apr 2026 07:51:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Peter Oskolkov <posk@google.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATTCH net v5 6/8] net/sched: netem: null-terminate tfifo
 linear queue tail
Message-ID: <20260411075101.05c2d8b3@phoenix.local>
In-Reply-To: <CANn89iJeS-Hw7NNouSWYw6BZvTUG=-grVxAiYzg8a8pEO_LJXQ@mail.gmail.com>
References: <20260411051700.311679-1-stephen@networkplumber.org>
	<20260411051700.311679-7-stephen@networkplumber.org>
	<CANn89iJeS-Hw7NNouSWYw6BZvTUG=-grVxAiYzg8a8pEO_LJXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-277705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: AADB93E072A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 23:38:08 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Apr 10, 2026 at 10:17=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > When tfifo_enqueue() appends a packet to the linear queue tail,
> > nskb->next is never set to NULL. The list terminates correctly
> > only by accident if the skb arrived with next already NULL.
> >
> > Explicitly null-terminate the tail to prevent list corruption.
> >
> > Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > Reviewed-by: Simon Horman <horms@kernel.org> =20
>=20
> Can you explain how skb->next could be not NULL ?
>=20
> This would be a bug in the upper stack.
>=20
> Only TCQ_F_NOLOCK qdiscs (pfifo_fast) can possibly get such skbs, and
> it would not care.
>=20
> Other qdiscs already get skbs with skb_mark_not_on_list(skb).


Thanks, this patch came from a false positive from one of the
review prompts. Dropping it.

