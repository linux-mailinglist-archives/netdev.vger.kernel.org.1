Return-Path: <netdev+bounces-241990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69899C8B6A5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 052B13585C5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953C284670;
	Wed, 26 Nov 2025 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpwAD0bc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052727F4CE
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181213; cv=none; b=Qfpt3iLoihJKBusMEdJ8Dy91Yk7B0GfibF+IEFt6dtVeLsLKXq7P7cAnovyVupW2iJo5AxZMHFOTpfJJbRWl7m8hjqJvh4I+HzNf51a+BcMUxJItNXmlMsjZVrDehy82YoXZBh47Q5cOO9Ps2kOGDmyzxdfjAC+fGBPi7KqoU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181213; c=relaxed/simple;
	bh=OJC7xA5e6QqUaQuf0lrvbafOJp1/7PZapvqvASkO5OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asUVWWoHZly0Ty+I/ovs2WyVEEjjC+iFDpL2eBpsSYrlc68Ej/birRhYrD/tKIuWtscgXjIGUW1frhEHiVcWWGFTcFrObHQ7VkSn0baYb+W6gniABI3GEpTFUrWiCTEvr/C5q5g641pamSOWJyAfhja2+mdVRVUBMCOVxMBJn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpwAD0bc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed7024c8c5so924491cf.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764181210; x=1764786010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyPqe3S1bmTAM13Rt+XtSs9dK5+j0gxlnLbuXRPirDg=;
        b=wpwAD0bcqzeOk4i7XndwT/niHrJOIUaVNALN84iQ31VoZA14kg+PCPEkPTESX5WrER
         biw8xu91OUhgopQSU2tGZH+eyU/20LFmZ/isebYyiFHlubaaZwEoE6DaZ/FNfjOBrtyF
         om0UWZeUQDR94eYbA09hoVSExNaPettbEt+5aTnbaoGLYyhpvIKAdAiluS4upftxihsR
         ol9TcUrFi4lOsRhuvqYPIDg/BcOGSVEoUGkUSwbGJZp6hX1FaC1HMM7ku6uuopix+5zV
         ewfygijNLZlEI/ELz9GeJc8VLEuitKpybTcs1+TYK3xb9zBRDhDW1Mvl98pf5Kh+x2Mb
         mYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764181210; x=1764786010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyPqe3S1bmTAM13Rt+XtSs9dK5+j0gxlnLbuXRPirDg=;
        b=F2IHG6yLV73iadjXx039TzbcLlS+qVbfuVZnJ7BzFshA0kIfAdlTCB2QWWwtrgvkzo
         osMggGcyd0gxJmfZfG5B2qIi5ng8TD1Soc/A+mlcGEIRivSpL/7kQO6cx2UqqcQ4NJBL
         dKuquqU5j1PTk132S4oH0CAyao/jX3BOhMPXVvzOvJPqK1ixesqoWUdTik9GRyKyyIrp
         JsyMJkXf/LFo4HYOjRsMPNcYn/CuGPvtnAXhYXOqc7ihhsoYsagIcPsCe/3h1tP7T3+G
         ILNgIlFtkjBd2LyWaymy4tHgzMTxjVbAoekHMQIRIfpFs70HniQb6R85Kk+fapSIKNY0
         3Mpg==
X-Forwarded-Encrypted: i=1; AJvYcCWkovdCQdqp9Eeh0TKjMaMivNR+qbHb3cYWy97rRjxO0OaMhRLyK/Y+v78DwEHrGwRAYB7w+Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmpfIYfp+39b4WnsjEGW10gmtvawV8mcSfpesbCd3K77YYoX5
	ZK2CSUyxSCk+jukvUCHLVoi/fCk8YSB+bKBYlBnos8Hpv+ikITkmNpFyIoDIRnQ9H18HX3fqXuZ
	mmq1DQ4LVt0CZ8MC6lHGUpVlwturfOCmRca+jRnET
X-Gm-Gg: ASbGncvzMvJqiMbYmeKRr7p8AG9n7t0sUVY0IPivMdR95nOuSGpTS05+rHj9OzW36GP
	tHANJ2CI63KwJiN1oIkMwZXTKhgoE4/CunFh04fe4hk5IfidiMdQMgzauJYANUH7ssdQetXUldd
	TU3ytKBddCcMABYOF7z6ywdkqXbWs1ma7uIB22uMmvrlmoSf7zajvfrLHqCTGFrQ5ZmsIgnl7lI
	aroKEAnqThsoWgGJWPNf8fxhrARbPh0dWX3827fOmwlFHfbYBELV9RQL8U/sfIqUKRvUiY=
X-Google-Smtp-Source: AGHT+IEKspoMq8viyrVX7XaVKBZ0tjStqKDHb3x/+rHSmzBoaCxDmvkK8EdWVdJRs4R/3hUDl929ZRw4zVnINipD8Hc=
X-Received: by 2002:ac8:5e0e:0:b0:4ee:1800:615 with SMTP id
 d75a77b69052e-4ee58841a7cmr285206791cf.14.1764181208755; Wed, 26 Nov 2025
 10:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
 <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
 <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com> <CAM0EoMm4UZ9cM6zOTH+uT1kwyMdgEsP2BPR3C+d_-nmbXfrYyQ@mail.gmail.com>
In-Reply-To: <CAM0EoMm4UZ9cM6zOTH+uT1kwyMdgEsP2BPR3C+d_-nmbXfrYyQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Nov 2025 10:19:57 -0800
X-Gm-Features: AWmQ_bnUlSYrbux7oZCg41QdRs-toAJdwMNcEwN5SrDgQSv44mTKEUUDY8Mrpzk
Message-ID: <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:

> It's the multiport redirection, particularly to ingress. When it get
> redirected to ingress it will get queued and then transitioned back.
> xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT will
> not help you.
> Example (see the first accompanying tdc test):
> packet showing up on port0:ingress mirred redirect --> port1:egress
> packet showing up on port1:egress mirred redirect --> port0:ingress

Have you tried recording both devices ?

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c07a39f9c942=
26357d5faec09
100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *=
skb,
                return retval;
        }
        for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
-               if (xmit->sched_mirred_dev[i] !=3D dev)
+               if (xmit->sched_mirred_dev[i] !=3D dev &&
+                   xmit->sched_mirred_dev[i] !=3D skb->dev)
                        continue;
-               pr_notice_once("tc mirred: loop on device %s\n",
-                              netdev_name(dev));
+               pr_notice_once("tc mirred: loop on device %s/%s\n",
+                              netdev_name(dev), netdev_name(skb->dev));
                tcf_action_inc_overlimit_qstats(&m->common);
                return retval;
        }

        xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
+       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb->dev;

        m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
        m_eaction =3D READ_ONCE(m->tcfm_eaction);

