Return-Path: <netdev+bounces-82692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14988F430
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5746A2A2F07
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717441BDEB;
	Thu, 28 Mar 2024 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2scF5ej"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1801CAB2
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586784; cv=none; b=k7kvVTu5HaDZJUV0XWWTN//mj443R9M0fsDx9mniKIye4Ax3lSQyOHJvqWlmnMMxQmLtMldabHdMFKhR7wuCeX6clwNAcYHzSLHnLV53WOGeAIIq2A2PrKndREgFMH2ig1DlchN6mTQ19meTjBKLAn/Fqq2ySk4Hjjb9t5FzrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586784; c=relaxed/simple;
	bh=cIKRD/G7PLOI2YOYcwuWsF+zEX2GT3alAs4z8dQkNe0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCoHN1zFc6qQFbNKUAa6WlVDuVjNtOlxLnDhPbKD5D5H+1VpQ+ji7x3B8lzgZ+/CUCGpwz7phPiD5WGdD3ut1tKKCUwrzq7KjkWd24SHKVcbHnBaEkp5PKWhE1au3frBWCo1lRp+3zp+VYXXYsHujiew6X2gGf4OnKNjaqu2xzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2scF5ej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711586781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muo4TQlECPjAqvpC/FPfgccK18lah8VpjdpT8uaBVqU=;
	b=O2scF5ejRMw9sRjMN3btn0Ro8VpUKb63kt4M7ADjuBZsuC3xuOTdraGIn2PB+l0Dkm30P1
	yIOW0QkWWAekhk6m/IM5NJD/WkiS2p3vfCVTXWRWc7o+PTmOr144bL+Q80igW7EJxFsVkj
	Sw8+IQAEgRfRWUBYNdLnWldmDkpmpyY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Ojo7CqtLPvGH7t74ljfkFA-1; Wed, 27 Mar 2024 20:46:20 -0400
X-MC-Unique: Ojo7CqtLPvGH7t74ljfkFA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c465f6756so249872a12.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 17:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586779; x=1712191579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muo4TQlECPjAqvpC/FPfgccK18lah8VpjdpT8uaBVqU=;
        b=Pa0HRF/VsttB9bTfN3uXT0x+JiL+VS9+XH8BojCK+fKcBGaYbRPJhj7kg+TQ6I9oP+
         uiUZjZ223BgqbXaFpFtXOl2zMTeqA+ZmEq7ELR2ihGqtGLgrd9rdBp4eV/pNlJ3ZcMXr
         jhZY9EdFUHuqEQtKlzSKoMqQRDxYoYgdZ9VOhdv39yTIams/vcDtotrrSCCpe3bAKJS+
         3NdOooacFiyrCjRdUy1XyWHfKSiyQ0AjulRSq4tom0Ku8EAMxP0jX1wJSnPgw0GEI/DM
         rqj9JuQhl43LiLhckCDsQ5iqJvoNosUS5wt5kJH08LHmSjxe9ypTj91IE4ADyjkc917A
         YKRw==
X-Forwarded-Encrypted: i=1; AJvYcCXQEKf1Xd2yqLU1yD9Cj8yQyJOn+867onvB3RgMdBL4hN0VB2SMcA1/jwqFZaQN4IjvH0U6Lf9W+tjGp8POKkeP6vivtKdt
X-Gm-Message-State: AOJu0YwzXJ5kjlkSNuJx66CLOW5/aRshprJk5+5qZMfbcv4MDJUYhLV9
	C2APOvvG5csTw2E7APCZVLmxBrfPgMe+n5Khi81+VRuRTvzlHh86cXoJCRWvSE09RTY7EjaRMR1
	/hLQenRS0qBjELnV9uxFk7mv3NWuoZPLK9JFfwXzvf7M3Q0yKgO3WeQs/bQKYg6vzt5A5PRjucG
	mxl3O7PmuiOBXyXiyBwzmos9LHITT1
X-Received: by 2002:a50:f610:0:b0:56c:3644:9945 with SMTP id c16-20020a50f610000000b0056c36449945mr1077035edn.7.1711586778875;
        Wed, 27 Mar 2024 17:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFidnp8svLeqqOiMFaZBQdHriQ6yQSJBxUFB9NmDeKPwAn4bbF2S49CUU2kuwcWR3b40LAt3ECQeQnDWDQh7H0=
X-Received: by 2002:a50:f610:0:b0:56c:3644:9945 with SMTP id
 c16-20020a50f610000000b0056c36449945mr1077024edn.7.1711586778491; Wed, 27 Mar
 2024 17:46:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 17:46:17 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325204740.1393349-1-ast@fiberby.net> <20240325204740.1393349-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325204740.1393349-4-ast@fiberby.net>
Date: Wed, 27 Mar 2024 17:46:17 -0700
Message-ID: <CALnP8ZbmCUM8EP-jAGaFqvMbYTm+=18AG0h-DEvZ81+Vrea9hw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: sched: make skip_sw actually skip software
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:47:36PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
...
>  +----------------------------+--------+--------+--------+
>  | tests with only skip_sw rules below:                  |
>  +----------------------------+--------+--------+--------+
>  | 1 non-matching rule        | 2694.7 | 3058.7 |  1.14x |
>  | 1 n-m rule, match trap     | 2611.2 | 3323.1 |  1.27x |
>  | 1 n-m rule, goto non-chain | 2886.8 | 2945.9 |  1.02x |
>  | 5 non-matching rules       | 1958.2 | 3061.3 |  1.56x |
>  | 5 n-m rules, match trap    | 1911.9 | 3327.0 |  1.74x |
>  | 5 n-m rules, goto non-chain| 2883.1 | 2947.5 |  1.02x |
>  | 10 non-matching rules      | 1466.3 | 3062.8 |  2.09x |
>  | 10 n-m rules, match trap   | 1444.3 | 3317.9 |  2.30x |
>  | 10 n-m rules,goto non-chain| 2883.1 | 2939.5 |  1.02x |
>  | 25 non-matching rules      |  838.5 | 3058.9 |  3.65x |
>  | 25 n-m rules, match trap   |  824.5 | 3323.0 |  4.03x |
>  | 25 n-m rules,goto non-chain| 2875.8 | 2944.7 |  1.02x |
>  | 50 non-matching rules      |  488.1 | 3054.7 |  6.26x |
                                            [A]

>  | 50 n-m rules, match trap   |  484.9 | 3318.5 |  6.84x |

Interesting. I can't explain why it consistently got 10% better than
[A] after the patch. If you check tcf_classify(), even though it
resumes to action, it still searches for the right chain. Maybe
something works differently in the driver.

In on the logs,
https://files.fiberby.net/ast/2024/tc_skip_sw/v2_tests/test_runs/netnext/te=
sts/non_matching_and_trap_007/tc.txt

filter protocol 802.1Q pref 8 flower chain 0
filter protocol 802.1Q pref 8 flower chain 0 handle 0x1
  vlan_ethtype ip
  eth_type ipv4
  dst_ip 10.53.22.3
  skip_sw
  in_hw in_hw_count 1
	action order 1: gact action trap
	 random type none pass val 0
	 index 8 ref 1 bind 1 installed 20 sec used 0 sec
	Action statistics:
	Sent 29894330340 bytes 439622505 pkt (dropped 0, overlimits 0 requeues 0)
	Sent software 0 bytes 0 pkt
	Sent hardware 29894330340 bytes 439622505 pkt
	backlog 0b 0p requeues 0
	used_hw_stats delayed

It matched nicely.

>  | 50 n-m rules,goto non-chain| 2884.1 | 2939.7 |  1.02x |
                                   [B]

If we compare [A] and [B], there's still a 5.9% increase, plus
not requiring somewhat hacky rules.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


