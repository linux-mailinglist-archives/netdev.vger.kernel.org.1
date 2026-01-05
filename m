Return-Path: <netdev+bounces-247192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70598CF5920
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 21:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FD6305E34E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EA25F7BF;
	Mon,  5 Jan 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVkphCrT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFA2522A1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646269; cv=none; b=qwebqP+IaaavGEVfuVz4z2r1ov9WiTyEuGXApHWPN4BdST6hyTvn9xs+l1gKYijgq1FL2LIyKXbpFmUOs1oXcREsykKOGbLnDc3nzl4EXtdFgWDd99kMhWrjyhCYkb+laj3eRy46Sg8G/P2oJeBquv4mMZEmSArTGn7OXRRnRMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646269; c=relaxed/simple;
	bh=tZckkqAI/BnUKTIVFLsn6c6/7xBNnfmfIa3Oo1nKW+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQeIlkfoKRpIrO1NMIqOiIAmOHihWpbvuqTPS6Np6rloG46HHlGqvHDU2b+jyIdYr1/Dfyn4e75hke2+2bxgn/SPsPCoRLsaRBPfy54hGHe1UiVHYQKLVo0yGmB6iHLEyil9X3oCogKeGpeG4YJPW0o0ndQGVSij1XcCIhP0gYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVkphCrT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee1939e70bso2939641cf.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 12:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767646266; x=1768251066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+7MHx3eU+Vgwn4lI0TRdVQ9rF4/2XK1HPw1wKgrTzY=;
        b=pVkphCrTSK397Flifv9uvoJ0S88T1JjLRDMoZPqvUDN+wa1uwun55MbS/29Xjggh2a
         4AfbxWY2Nm1epzp0SU8zJavvLa3JLlc7Q0Z8IAni8mUzKz5nX1HfGyrEC5iGfpVZuwAJ
         Ldi1aXdrfYtCvOOPYPCfvox7fU+1sHmnFaQ0HgQfJwm8o+o2vXicjEDbky+ED0CMzg96
         uduSInHQ0KMQ+tOdBGjzNP9SR58Xrnf27IcnMcsT2o/XoO1NMVG06b8IsxQZoO+AOXrs
         Ujn9fLPlV8Vmh1Lbhgq9ZzUHtbyulA+ttQFAlF3G/EAhGmYjQdub5NiPsv6MK0txK9N3
         pB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767646266; x=1768251066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+7MHx3eU+Vgwn4lI0TRdVQ9rF4/2XK1HPw1wKgrTzY=;
        b=Mechd0EBFxEVGThkxqN0BjCvvO8Pm7pnBGJidNOdOlA8KzGl0jTAVXVnA3LbjSwXA+
         isguHCj6U4orNBMTmDwIy29WQBhdoy/rQBcu/28zRA/N2RehPtPcU+qIkaBwsBi3531V
         5pqieNXbwhgfsdkrNss6ttXCHFAJvaOx7+FjqRBTxDZM8XqgvT2xjkxTkLGxRs2ojEkG
         h64Y4gZXR+SGBMxrUzCZcmUw6eVFSedKh60OLhN4heqVKT/487PF8JEewWtoUo2I0BbB
         URWCOECxhiKNXCZDa9IuLZQO1cLfxopTJe0QKTReUqrVVrXdBvgChnEC4TMjie0liP2Q
         8uDA==
X-Forwarded-Encrypted: i=1; AJvYcCW3NrfbEtqfTDAhxZhu1ZO9g0MyKguZXGt36QnJij6YBNBxBJPC5a+81GNjyxAngevXFkzRt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxst6fBjzc5YHypXxs0dlLMUXW/5TWs025VQQSmYcjX1O28DSmL
	lUqVa0RhI37MCngqIEnvV2TfEMykfCCf0Rl6kT8Ex7l+pAkX2a7b4DPBTMVxkocyihyb8sTcukb
	rnX4hy5zLwfWof8pxYkr804iyNsaE8tigK/7b62qP
X-Gm-Gg: AY/fxX51VSpS5It963URHI6vqOeufckEfAz+nxg1vwLGxvq+89BHZQYX9QI+8WY9U4X
	TAK8nrOSHjqZGK2TgwApsX9u0JQJnIZ+TEVp6Md/iZBPJcYiMHmP00Gh6xXlpy44/vv2CjIUkQU
	0JH8cXxzZvWqSB+ons9DSHS0pcbBG2QTZL8QvS4FpNe24qTfvPuI58n0hG3WgQFfTHc95QIP4yC
	rrz/QYgRDRCjgVHuwps2+fR9Hjf0OPWT3Yvt3Qd/lt7dEcd9fE/zMkGIXbOaFNf8tww5Zr5
X-Google-Smtp-Source: AGHT+IHz6G4AZuRIp1y1BKYR7bbiVH3cyBunWa2S6NsZwNEYu88Vri6HdHpYrD9j9SVjr3IO8nNJk6Plwrr5EDAO3A8=
X-Received: by 2002:a05:622a:b:b0:4ed:a7ba:69c with SMTP id
 d75a77b69052e-4ffa7843392mr11044561cf.83.1767646266226; Mon, 05 Jan 2026
 12:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105100330.2258612-1-edumazet@google.com> <20260105124006.299e6b86@kernel.org>
In-Reply-To: <20260105124006.299e6b86@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Jan 2026 21:50:55 +0100
X-Gm-Features: AQt7F2qIB1h3WbpqKHLIzx6dvsWXXDiBc0rqDpq9LKIg-iyJrQ7KIpbBrJFYJDI
Message-ID: <CANn89iK6uqJ8YEvzcz-EsS1piyay7hTdbC=S_z-Feho9YBeN_g@mail.gmail.com>
Subject: Re: [PATCH net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 9:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  5 Jan 2026 10:03:30 +0000 Eric Dumazet wrote:
> > I added skb_vlan_inet_prepare() helper in the cited commit, hinting
> > that we would need to use it more broadly.
>
> This appears to break all GRE tests, unfortunately.
> Conditions need to be inverted?

Ah sorry, I will send a fixed V2 tomorrow.

