Return-Path: <netdev+bounces-191276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B154ABA833
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 06:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4019A051A0
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4051922FA;
	Sat, 17 May 2025 04:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0m8xkr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765715689A
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747457124; cv=none; b=mN/+3z562pJMTvaNGfyuqBZpdfQHoKolxPyGdYgSXJWUBXcAb1WKzGb6e53pNw8tXhS7I7TwN4wFbErSqbIocvvzXrk8pdFnxWk5Gm/QbwrmIjJ0BblzzhIVZJ/Z2PTlq4DS27LonmuhQWYiOCqN4ztF69aFql2RL5cQSsJ0dOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747457124; c=relaxed/simple;
	bh=h3ZYJmqY7lKWKGqXThCZRIoL+dx9Q1Lr8144Hu2uPO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOXejPXH2G7zgWfORas4wwhEq4wsDuWm1caopwT3lgqDmSx3InPxqnogHogPiYujDUti/SoAcJ1AyHrs39sqNWZSPP1ro+QrAd9fMlrzaKm3+eg/Z6558BYJtyhiFrLsoTMnUr9JbZIMy9BPJA7Dmsk4zKXanwlJEtGXVcMjOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0m8xkr8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231f37e114eso65025ad.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 21:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747457122; x=1748061922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3ZYJmqY7lKWKGqXThCZRIoL+dx9Q1Lr8144Hu2uPO8=;
        b=I0m8xkr8BaGUtWjcJ/gEKmim/6kEPktM1/4FBoQzHIEctVrFUWxMIQ3pBSC8RFo1UL
         klPYYu6m2QzhPiQ0uFtXYK/GXayDoTsnAtxxnMSNEXRqYQuf1xlTZ8xW84BT1+VLw4Sp
         1lRnVgSq1VSYKWXDFNPftO84fkwRigUf1bM7I7W/s2sWL9VGH/hOXx57KTkeWgIqwMyg
         hxbB+B3YKrKfqh05/MG694BgcVpxZ+7SOkroumc69O2zoFoaJuAjYK41XVRDBrJs63wz
         ocOQOXycRiVRYIWXrWTVBnHZLgOC72QpItzwQtIQlEFNC/lSdakJZX82zo2+w+0eLg+L
         wJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747457122; x=1748061922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3ZYJmqY7lKWKGqXThCZRIoL+dx9Q1Lr8144Hu2uPO8=;
        b=Y0nYo7eI4omFhiKqKj2oDT9vbqMe0QD4DTBqOCN3R1cn4Tpdbar5V8zfBMOWj65kFF
         a7PhB5rbjTpU9ZFsSXfnOQOufXtJHZR5s8NkBhUps7pEljzn7tPcQHyCfGc6qJBfCujB
         QTLwDmlOPsNygzZY0WJRFDS7afqff7x41+pZ2tKn0umBf6L5iG3a977/lquFUAyweYRI
         ZzfrwuebPehtWiVnJw8DEwreqorhsunhNXt8joT6wVVd7kM+L+jCzGrCw/okoRAB2jPN
         cAj8unlvC7pqk5by+GoBguMi4cy1ZZJeaC+Q0Utdt8IzSdMDw2RtXcPaUYCZLD0kRXo+
         sawA==
X-Gm-Message-State: AOJu0Yy18sF5hxSBi6wpcGcD76ten1rRbwYhpT2vNwXa+t34T50Ijx+D
	oZqkTirZHktPDfsXkxf58yV2Tm7cRS3uiXG10xF3IPr4hhbBevOAd9445Lm6fs4Kn+PQgJVQgO/
	2LUF2O21yFzyROwOQuylW0Fmei1wiv7XnPkpKX9fD
X-Gm-Gg: ASbGncu33GGWWntMtZ/9SX5+GmnvYnoLwdLFGJ7TCf11WuAp1/5W5YST47ZAnW1xQZT
	Qjh9uYlN7pqtPrLJ0+eUBiA8Sq889HDPDCPnhqwDL0MnfBLScSN3kxoK4h3X6JS3xLGJ1KKkNTF
	PHOuA/DSzytFlLEarC7c5HUs6oVE9UAsEVLw==
X-Google-Smtp-Source: AGHT+IG47ua4RGzCDfg+w8Ijsg7WnHcjk7tEFoY1lo4vF9JcyfIeu5XX3tD1NT4GKXYgDzl0jsiNot54rheb+4oDP38=
X-Received: by 2002:a17:902:ce92:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-23204154576mr756045ad.19.1747457121758; Fri, 16 May 2025
 21:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516225441.527020-1-stfomichev@gmail.com>
In-Reply-To: <20250516225441.527020-1-stfomichev@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 16 May 2025 21:45:08 -0700
X-Gm-Features: AX0GCFvpwNq82-Ipf2wTz6WnI0rg_QpT_IhTLHQNdP619TT0EiLrBt8Ze8gGkDk
Message-ID: <CAHS8izNJQFGFjVr42VVh2zHJ+PxfUYCupEdHka2dd0no_b=GHA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: drop iterator type check
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sagi@grimberg.me, 
	willemb@google.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 3:54=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> iovs becomes ITER_IOVEC. Instead of adjusting the check to include
> ITER_UBUF, drop the check completely. The callers are guaranteed
> to happen from system call side and we don't need to pay runtime
> cost to verify it.
>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>

Looks good to me, but can we please bundle this with the fix for
ITER_UBUF, and if possible get some test coverage in ncdevmem?

