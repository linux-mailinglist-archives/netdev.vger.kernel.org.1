Return-Path: <netdev+bounces-262142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBDWCuv/omkJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:47:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D01C3A5D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFDD3043D19
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB27344DAC;
	Sat, 28 Feb 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRDByWay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F93382E0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289901; cv=pass; b=SYYPHOGnEMnFXkif+dpa8QuQgr6G/RQx5Kxva2GVe60FgHTkkUZPKCcaAwLGlDsSOARD+sSYW8Iag15OIUdA3p5eDBPMNfW3UPHgtCAlM8iuBKG8CWfMYbN09C8wbZa+ETwvG37kEOQtm/MURCvfe6zcsP3JKl66PgfQTMzUZXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289901; c=relaxed/simple;
	bh=rD76h0+KYR02tE5XEI9njO9l156jU2pJT5Sdu+x5pTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9Ln0g5gpZtaqOC5o9uKDZxqjtjvqb45LbL14bmSw5uKbFAlnVbrLO5qu8EBcNxLdaom43Do0FYHc3GwsmG7SrhYMK7u/tXFKKAqCSuXKrTuA7mAWUVsV+rOrYsAYag/FVDbfPexD1JpgtvzfXP1xdLRHDH63am5gOUrhQKnz44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRDByWay; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-896fd2c5337so33151016d6.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:45:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772289900; cv=none;
        d=google.com; s=arc-20240605;
        b=AYgxwkJ0hpcJu4ylsVORlAItLbboL/UvsQEhNcnvjcB1jz31bJM1/pFUcxY/kbFHcv
         MgMWQlThT68Wf1ybln1E0c9Hq+6m8xX9f2IBtqSRAZHDx23Dish1A+iVuLBW++D/vh7f
         Kzh2geqDPnbvCejlOw+LcvfkbPWoRJ6TSJ+1ZlDAcmGQt1g+F0IFWaZQxmBpyADi27sw
         mG9mFITiipWpkFEcdv/XM7gCDQJNlMWSe/KdiUTOTuPrPrwBQe0vgsB56pHqg/6SrT0P
         C64yRAXZzC3dRiEyAhml2OkuzHqMEs9pT2kRaS3cQy6XHookirGsavzdGQY6HBsOiiXl
         KCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rD76h0+KYR02tE5XEI9njO9l156jU2pJT5Sdu+x5pTo=;
        fh=Xo02gduAdVSSRwRPcUWP5cxiD1M9a+Ry7oDSGKggUTA=;
        b=GuxrOm3AVINZ3/kIAZiQ2w0QC4hC/IRruHZzJnjoK8P9uH7ykrO0gSp334b7tgYdNf
         hWGlENlZriGYz7glV3yGu6hck5nX8CQOj318gnzdaTXsIaIhxZ85jCUpBqoX8NaQQm1O
         QKgYh68gSTb8EkxX8QKhFfnnN/zTE/VIckKDzuuUV7qzWufFzkrr2mCFKFjaQQ5clJ3F
         iovYVPfvM9VyDaycM3aXuhRFB86vWjnef3+PUzm3ym/ZZGIsMeKmGM3HIs2nmfG9MiTH
         NaU2BjhsLPECvkIGRkqJxIe4ANwcaB+y5BuwA6CYieztvCzV0gaWOhVmZOVI2Am2Uv8G
         ILAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772289900; x=1772894700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD76h0+KYR02tE5XEI9njO9l156jU2pJT5Sdu+x5pTo=;
        b=SRDByWayx2bkSP/0TluYSpfjdaVzFFAsKEq2whQo1Xm0+HVQl40OMQBRGrB55LlPZB
         be5VVyeOdRPcWjHpreA3JuEjr3UIMvk601hebYxrJ+m6abGcoarSh2S+cp6HfNLqXpk/
         9Jb6zRlpCePcPZFbSbbOjbPYY9IQojjsU5gI4UV2210/yw+sSPKEUxKYcJojlI1WghWv
         t/hJJV3qO0M3hAzLAN/myp1tmbdgaK/CXrj6o2nekn5188GYzsMDHgXfei+6UZBAHCWH
         fGgpsobK5eJrBXMNs1m+kSj8hspwgsgE4na4jr6sZvU5ZvCUqPuSECB1H8fXqMggaIsm
         ZxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772289900; x=1772894700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rD76h0+KYR02tE5XEI9njO9l156jU2pJT5Sdu+x5pTo=;
        b=mFjRlzz7hCfVIN9sjBoFhz0qI8AQXCMBe8SqiGZThULd9P0sMKykDa9qO2i6TWqOft
         ZkBkjy8SFkHuCX701cI/Pa/SKcarV4ErklKfExXgEnU4RasZyQqmpwaAL4CAceFtlXaN
         /zk9EnPKmlIRm5L0QkO9KFY77Sh/x7ISTXS0fExpcVWr1VLUsPOSDPFewAl8epfJdLSQ
         tWXeZFU9OgiQ3EnwUbNa4oiRBObjpXRVIJfaDDaRVbCFI76YIG1WmkeiVuRuLQwvy2Sb
         w8wc5ZAgTy4BmCiCHkUUk6S43Q4+nI7AcKTezXRK5cqenoEKZX2dWAWhquZ6MuZ6nQFI
         cKdw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZi9AT5yyF4CcI81IOuFCEhY6GoP/GoeAyeRqRXp2gyY0WjwRPqo2jomw0sEpsMKxWRn38Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOsdlitG80S5vO5i62tIVd+KHD6Dl20kaVtDiMoTyPXjJY6Py
	leYd7k/TuxI5j9q/KDy2uSrBa5vpZBAWTrVCn5kWyR5kRUWIiRg+JgNrf1RJJufY5dZ1Y/ZLFL8
	wQf9drWc561MDoVCepa/bVRG+1qHrBkjgUNCxjvUL
X-Gm-Gg: ATEYQzwPXbNZY5JoVXEJFp5Z2yueaUsep2u2bby15gSnJCa5qAuHWaCwQ1IGgKYArfQ
	0+Z34Yvla4GXvyDrWm1z9Ngk82U1tfTtgysM864pDkQjV5wR4kAw0q4RCt9F3usW2mZ+EcNkFQL
	qudhXRW1nPBLk0NQS+j9dRdCUddf/WIp77sG3azgTF95TK9NHFadyLD6urTVVUwB3ZXMA89MYRE
	ZM2IIORReKUZVMAbxCePYDNX/o9qSZmzO1YibKAIS26hcTieIpve8NEBVqjhvw7mnArMNtPKUKx
	jR7QKld1yjzLIeLkGkw=
X-Received: by 2002:ac8:5991:0:b0:506:9944:8cfe with SMTP id
 d75a77b69052e-507527ca544mr80278181cf.15.1772289899220; Sat, 28 Feb 2026
 06:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-5-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:44:48 +0100
X-Gm-Features: AaiRm50Hmrm-HxXFI3JFRTdmVR1gSprFwo9ogPIW9xhdgAaHsTAxBUXX1sOXLoQ
Message-ID: <CANn89i+FkCp-VVHQGHXu7aBa-tc1F2Ph_b6pszETKn1v4M8Hew@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 04/15] ipmr: Use MAXVIFS in mroute_msgsize().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262142-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 813D01C3A5D
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> mroute_msgsize() calculates skb size needed for ipmr_fill_mroute().
>
> The size differs based on mrt->maxvif.
>
> We will drop RTNL for ipmr_rtm_getroute() and mrt->maxvif may
> change under RCU.
>
> To avoid -EMSGSIZE, let's calculate the size with the maximum
> value of mrt->maxvif, MAXVIFS.
>
> struct rtnexthop is 8 bytes and MAXVIFS is 32, so the maximum delta
> is 256 bytes, which is small enough.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

