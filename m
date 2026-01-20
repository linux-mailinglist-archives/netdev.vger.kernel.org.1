Return-Path: <netdev+bounces-251422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363DD3C4A9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C11E46A8313
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7CD345CA3;
	Tue, 20 Jan 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sjtQ1x9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EB3A7F51
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903013; cv=pass; b=RGgLHRfk6qz3W/7tytPUeMAsbLPzJZ9391MR7/ACErBmFORutgaxV4ttJso/Cg2JlTXKxKC4ld6rYfcpgOqyfJqZWTi7sObfTsW9K0ReSgFSSIqjDqFgYciBejq4E55i0jdwZIAg5jOoJ+DPSRj1ZdErr+etdGCmQGoUJ88uo4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903013; c=relaxed/simple;
	bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDAPYI6sYR3mamL4Bu5E+y1M5o3eoIIdQsXY+PVdUuAJMg/dsrGkC5o+z+JrmoNE3aOxeGtPuaCUZBw4x5J14+LZAs6vYheOwZd/RYkaOtJz/h/iFX+CWa+W8Chn5tUcA65GIqNAMc+KwblxshOmq39CniEAXo8CuB4Q5IZHR9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3sjtQ1x9; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5014d4ddb54so55629931cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:56:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903011; cv=none;
        d=google.com; s=arc-20240605;
        b=dXEgWlftCBdqe0cydXlv08HDVlGv+nG2V6u7pk0iHNcrXv8BT+3MxF8dxpvdGn5LR9
         wgQpAMyDX41EtMNpNm9XETBKWCfIRqqVKzUhRAcZfCMJW9JIgbki6oFm/f3qboILM5QV
         1ScxYfpMoRic0iJELuD5T9seWbKu3Fe0f5UjbsuMafPDaA1G2MY1mJ3ghx+BSKpb5P7v
         YVNorQcTeXKVb28DvYWhtwLyDR+rB0rDqO6wPoGSbvdSWPSrBtkk0LBuvl+kisEU+EdG
         yQGg2DDJY5Zy3xJQ8OjlYNSvBVEj/buVR8QHICPFqcy2JbSX1ZRFCdHtX6WaqGntQ++Z
         YFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        fh=ZOpZvj0+7zbbiK13ggQut6r+HELTf9mmn3vTwTn1Rzw=;
        b=SMv1Yg9cLuqJtFDMq/pSdIq6S+104umF1mtn95DHs2erlCpR/0R1Aept5pu8BrT17z
         6YNmQaSW6JgnlHbvpasXauxYOtPZYfxUZ/ZbZbEt4sA20/flwi0C8cKPt2cQ5PnAv5pH
         BoCZmaTrb/wtQdUGuVR3EYhS+9kNxiais6KBHx/KaltfXedU38fbL1Y2MzcJQDCJrWFl
         uKgys+uLu8BLMN02cFAXTQiW4Wv0R0/Xhyw8FFxfDBC6J4vQuFir31aDpKF7eHaHMxp0
         1yE/BhMHTs8ueVe4wjWpxK9Z4likgXL8vyYKb3JVVUPaYXoc0wyapfLtrvGZtXJaWn60
         r71g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768903011; x=1769507811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        b=3sjtQ1x9WmRvbdYB06aePiearuKrghc0l2W/2s0AEik+5hKq6QlTBKAsMVRl9/LRT0
         i2i+q7iKvKng2K621u7/hzupoRZquXkthX6XaBBR6N2yNmJU2VDfovpnJiPACbZSPyn0
         32bUBEZn3E5RqZYd5Olxu4G40D1/6zK+qnBo1XEBKsq+8flch6FDQ54uALk8dyBkrES/
         l3Z0xK1WGGesc4V2W78cUG9JKAWtmFfSTt0KXrEbRE2y1DJxfze2do4uujC7BrEShkpO
         fVBCYHHrIAmjPyV7HJm8Sf9j6AcYQqin+sgBrYW6y2RsnwW4aJh9GAeknshdsrFdqclp
         /z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903011; x=1769507811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        b=bKDGvhFLI6ZlIFDIrnItfhKpAZpG8dSXcwVLE1PLXKbZuHjxO1Ogli3Md4qajMIC8N
         1f+XY9+jRcM0DPnAcpvq468H3CI3l0STKxN3aWMU/fj9w7E0lVJQ4BtI9BWwpNgHlGgm
         NYpFSkfueP31QskUHMxrtgVsHFssqEVuJDooCvUDDQnu/3UvDNLYt5fXNWDsiFaDjn8v
         GJbj5MuhZEjmZs7hdTC3yFYhq41NbjucpuDbrc47Hd2A5FKiaMNcsoSUFxOvOnZrOOff
         BoMWcJsKfvnuov2gA6B42IY3gxOHaMn0TPDw05lgpc6TqnyCdwBjdDX4EubH60FewVjb
         0DdA==
X-Forwarded-Encrypted: i=1; AJvYcCXZVhrQJacgSsduLXo7fFg53UKTD2ABzdGAXdRFd1XPN9uuxR3/wjm3UtXNrUAF2S1FbGYMuLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnViRwjJPUGgEiX8QsHYbt6JYOCWKEGAcu4ltKD+gP6snIiRLy
	SkIr8MGp5+n8WrGlz7xl4cX5Sz58PBROzvbqiV596mdqMOgX7uXDzJoFXKJW7WJCUvEgSEg1JJ6
	VQ3czWeId/RoB1h3Lz9NjcbWeMjsI6nlowtUu8H+2
X-Gm-Gg: AY/fxX5Bp6imGB4Uv7+1mFOTwphN0LR+8EaponR+SF1R7GdbxaI/6aSN3dEfMqlLm9k
	V52NCq3kCzVbTmaO9xntvwanpfhe6E75C5KehBkSye/g3GtpeOLqE2REZA+Du7lUesGqvB2F0B+
	S/QeEDEtiBVC5jWIcDLnl/I/XEpeOOHi1YLTATUr3P6D82lUqyPtM9+jxWpNmg07bSpzcOIXfGM
	GTs7V0r90fi7goJLgb9i/p1Qu4ukgcohazRjJZ82TEou76www6JFPoQPiWfJhGbH95xCbI=
X-Received: by 2002:a05:622a:1794:b0:4e8:b9fd:59f0 with SMTP id
 d75a77b69052e-502a179c31emr197588841cf.61.1768903010232; Tue, 20 Jan 2026
 01:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:56:39 +0100
X-Gm-Features: AZwV_Qi434Atr1gPGVfzbX7Cut4_5_Pnu1U9A-PDsd4oFP08xwfXslULTipllTc
Message-ID: <CANn89i+P_g8XB++mQ-MMXSSaTURLsohqnxHBcVpVrBBBoru91w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 05/15] tcp: disable RFC3168 fallback
 identifier for CC modules
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> When AccECN is not successfully negociated for a TCP flow, it defaults
> fallback to classic ECN (RFC3168). However, L4S service will fallback
> to non-ECN.
>
> This patch enables congestion control module to control whether it
> should not fallback to classic ECN after unsuccessful AccECN negotiation.
> A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
> behavior expected by the CA.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

