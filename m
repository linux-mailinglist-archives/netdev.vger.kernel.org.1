Return-Path: <netdev+bounces-111242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C39305B8
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844A91C20DDB
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22C1311A1;
	Sat, 13 Jul 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCK5IGr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA31C2BE;
	Sat, 13 Jul 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876798; cv=none; b=P4cVR9gIAs12dWXut0gbnCgWT+7ws9i53iiVdcIfWKPyrKmZk7mQ+VKZdE6R7AynVn0g7lSIhVNQyeBfW9gDPsxYulmj/mWKEuCXm6bduNh3fnoeDwMAEGBfMpChdT4xIBzgG0YxA5+2CN92f6MDvzwSumC3TRrPaeiSxj7PT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876798; c=relaxed/simple;
	bh=snAHb3S0OFKlY3/bv1o90bbWpgSNXsWdtPgypbM5f4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjwVu4POVDtDLcEP97fsSRr5bVm/tXRtNykghxmPg+/I/c2hlIzzWJ4bCrn4Lvq6i7h9pToL5ETmL5WxBtoP+5P/oaxeVkTWtdURStF5cKj4FAswxBZlQSsLIOEban+roseUYhYvqVSBO1AZod6mcGQvQrjkW3tZFPYO+MlXZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCK5IGr9; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e1610e359so1279892fac.1;
        Sat, 13 Jul 2024 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720876796; x=1721481596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snAHb3S0OFKlY3/bv1o90bbWpgSNXsWdtPgypbM5f4E=;
        b=fCK5IGr9gbRNd9kqlpDZWFgmpBzskFyL01jRJUS/3vl7SvRWK9CTajaKauUQFntEzP
         JDp7gyFRmuv+6HKOMNId62RQqBVsLJxNHHXXKjeGtw20Kvc3AJk7H1OVL7Hif7RXHLS/
         G6bYkNkM71MiBQPUlkakuZBLgRy5qnj+ogtT5MnhS1oBZYIuULbJsPQ7pQe8ZyamP+e/
         108/VsTcZVcAbPvjGamAgaAOJuhfvV5vCeBEJEMUQFQfE4Z4zvsLuGoQeVi6RrD29Wsp
         80syYe9Ti5TXvHyMx+lmYCjN15O9081xRw3L6Dm7WdzHYuChAqmgJMv/Fv/gWzqyL2bB
         b2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720876796; x=1721481596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snAHb3S0OFKlY3/bv1o90bbWpgSNXsWdtPgypbM5f4E=;
        b=BLUQlrD+sik/gGz6YbreYzF8sJ1td+4jKZLS4UI1UxgEnOr80ZvkRxi2JRVWjEJ9rj
         FpwQB9zTOqVVhrywO0d6XCB2LWblxDoWxR8tG9sND9Su0CiiNxcpNtzH/fzX0Vt30LYe
         xZmTtfvLzz0L5St9NTgZ4lqyHLGGCXgKXYlbllD2RrYvIaUWboUd9LxJbfvI/bh8G2rV
         5QVR9wAkS5CqRjD0Wnrphqb5N7FDznFp80SH764HhMBuQRXpQyn9oaa3D79h6tUAfJZn
         ypQTbxvhlzEAIKznxeYQIaPrtm6yTdFF5J9Albvtj8ooMWTDAWPGQnCISUtJ/hGRSGYd
         AXrg==
X-Forwarded-Encrypted: i=1; AJvYcCUsg0PAkPrmI6Q3Nw4+vW2C2YiUbCMPluyIpTCf+lfNttbsD+ae+CpPUPGPgw/6em9verAFTpoM8D1jDm97DtVQLuuxXiypK13eBhIz
X-Gm-Message-State: AOJu0Ywo4hABjQLUnXlpvcHmuIIQ8xbbMefYGHWUhfpIKD94Sx/0Swup
	kXCxpc5sfFlHLYpqAsOnZm8hN68azjxSA1gRVrV6o+QSE7R5b36wmA8XX8LIpfgxbSc8q3miEUu
	K8LimVukh/TZkg/CudG2cUapHSRDK223p
X-Google-Smtp-Source: AGHT+IG9DdeUOCo472DCsJjs1OTAc1SI79weAAouhKnpoHAtjUX9gdgkedavUerv2T7ZWP/Cmq/9qo2bCyqTJOziWHI=
X-Received: by 2002:a05:6870:718f:b0:254:b5b9:354e with SMTP id
 586e51a60fabf-25eae7ee5c3mr12359594fac.19.1720876796339; Sat, 13 Jul 2024
 06:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713021911.1631517-1-ast@fiberby.net> <20240713021911.1631517-4-ast@fiberby.net>
In-Reply-To: <20240713021911.1631517-4-ast@fiberby.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 13 Jul 2024 14:19:44 +0100
Message-ID: <CAD4GDZztKRLNCZ=acwtwQAFCBc1899y49wiuSwdjCisUsx2OjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/13] net/sched: flower: define new tunnel flags
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024 at 03:19, Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby=
.net> wrote:
>
> Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
> flow_dissector_key_control, covering the same flags as
> currently exposed through TCA_FLOWER_KEY_ENC_FLAGS.
>
> Put the new flags under FLOW_DIS_F_*. The idea is that we can
> later, move the existing flags under FLOW_DIS_F_* as well.
>
> The ynl flag names have been taken from the RFC iproute2 patch.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

