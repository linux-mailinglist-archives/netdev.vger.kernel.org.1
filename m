Return-Path: <netdev+bounces-111239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7FA9305AF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC92B1C20DE9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C0627715;
	Sat, 13 Jul 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmIhmzO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7E4A3D;
	Sat, 13 Jul 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876605; cv=none; b=K2AcsG8UsiQEy6p4qLK+nBJdwUf4wxahuuysdkVkreHjXiuwKGIm7DRI6z8cXPsbuNMhnH5P8k8VrQPrSo10vIaOeMjsNYlIrs/pnIO8K9+7vzB7l2+fsOEXb34uJF6fhd3YV+3/+ctTrVXqXy0soS3L4uoJDlZ7eNSyHbltfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876605; c=relaxed/simple;
	bh=K0ihYGFrJdXqoYhd3xTyuZYAIGMJDheWYYIxFz/30Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDHQlo8T5zHRfCzN0lgcBz3p9w58Uhf4hn0a0qCl3s8TxLw6tzmxLVEhh2NB4GrGuJuqObjOSBdpmZLxaFPsoQtLILxmv0deEi2ZSw3ATZUkq/hPK9pGY2sR8XCfT0lyA/XHsYeSzrSeXfxkZ+QlqFI5TtPRm+PGKYW8OKOMyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmIhmzO0; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f8d0a1e500so2387487a34.3;
        Sat, 13 Jul 2024 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720876603; x=1721481403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0ihYGFrJdXqoYhd3xTyuZYAIGMJDheWYYIxFz/30Nk=;
        b=EmIhmzO0HovXSxzqxhqRs/KyWoGisr/lK14+41F2R917B4XIDbj64ml1z7WNAiPz2k
         SwjT8vmGp/oPwnaBRTLTYXjtSoJsCwzZRT2eXVxmtVowHY9/4ePXPFN+ywMAQx3A2PwJ
         8mwEIFNM9TKUdvE6vNRV0PazYok+G+QkKeKrmDeqtMP3IQ1Zbx8zmqxLjww5flFL4r7w
         j+4sobsM059M79WyfBgKdYGtcrGaSPSDb9TqhRwBr3R8jnEIR6gQr2VykJ7eQ29Goe6m
         VDLdZaup3BPyH/SSJDbImgzcVpFn82VHa26RN4HzMKOBrKxYRFwoSWUKdEP5Ax6lvSBb
         aiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720876603; x=1721481403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0ihYGFrJdXqoYhd3xTyuZYAIGMJDheWYYIxFz/30Nk=;
        b=w5tkO2ECdMrQKipraUxR3v9bmnbTiDn/G0LbcpCOXW/Mq3J+6SA5EO5ZlB5CZZmcU1
         5X7OZAfV0GXpEmV2qk3sc1xMXJsP98E22KSybS6cFQllgLJHIt0ayQ1io6sgTDh6ji2S
         mMxi4jbIwATNIaD/va1PhACbSZ+t7CkzguEEJqiLt78KuDXC0OLJmQhPFcSZQ8XEahbS
         2MSBihl0J3JW0/5efxjJF9hSjRWx2zYSjwdqWQwHwljsCZRw3L5OhZg9eGZ7KY70KwOC
         q7i8GCvu+Q+EyVeS18/veNgkcQMgNZgWLyJJriekiTpOV4i5dkqIPdWWa4OKcnHknz15
         kmww==
X-Forwarded-Encrypted: i=1; AJvYcCWKg8lMtFF/q/g1M8H02PjCtziS1ffYFQnSD4lplAOX8nsBufc3lGBsOlX8M1l9vzZZmfTaLQ6blHNW/yEi0rE+YCO2uf2aaYXcvBXG
X-Gm-Message-State: AOJu0Yy2OQEMj1ca0w/Q0xhnmd0MGhUTA53nSyaSHNprl/ygI9qKJUP2
	cbu9YTMUfBT1vxnYtTU0k7p3S6o481wak/rQ3PLwrWvqezUMfMU5ee3R9hVVXzJIo5d3tgy7OOP
	8N4tH1JG/0pjggOsEXIGrucxK92o=
X-Google-Smtp-Source: AGHT+IFs6Us9/6t22JROP1jR2u2V7ci+ImNwkRuzdFNMTmzjPTqVbR3eTO6ec9ICGHegZe/bYWZ2eXXfQpY3aRsl9/A=
X-Received: by 2002:a05:6871:7981:b0:254:7ca2:745c with SMTP id
 586e51a60fabf-25eae75610dmr11700233fac.4.1720876603270; Sat, 13 Jul 2024
 06:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713021911.1631517-1-ast@fiberby.net> <20240713021911.1631517-3-ast@fiberby.net>
In-Reply-To: <20240713021911.1631517-3-ast@fiberby.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 13 Jul 2024 14:16:32 +0100
Message-ID: <CAD4GDZw9UOybQUpyUxzKB6QZoS0oyonwwHDQ=X46DTt=q9OSwA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/13] doc: netlink: specs: tc: describe
 flower control flags
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
> Describe the flower control flags, and use them
> for key-flags and key-flags-mask.
>
> The flag names have been taken from iproute2.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

