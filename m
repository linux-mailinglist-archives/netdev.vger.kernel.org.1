Return-Path: <netdev+bounces-71268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60718852DE8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3341F2255C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83822636;
	Tue, 13 Feb 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf6Cu5ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718F22630
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820238; cv=none; b=c2VpCH1/xLgNakldKtNgQ4AWUdI3PTBMxz/0dEafPGSCyxa7+CV0Fr3GmiNZT9CXUDqdCp4Nb8V3WrYmP0mnCXH6/Ziw3rABK7QsbUvp1dHc/gfSxyhTIVwV45Dv1y6EMRjdXJx19Suv8xjHueoy/tLv42owu2YaWAznOh6VCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820238; c=relaxed/simple;
	bh=k7Md9pvqFRVtErP0zrGr0YaUbP71LPzXT/Nea6Bpp9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0mIvOn0CIWpqi3RniOhUTK2Yddf679GhCC0oX29a7EhFIr/XQM3fuSdYegzK8YDd+rSB6R0rChYRYhQO73FbQS84ptNID03+1yOWR1eeW2qyaINWF0+vo/HT2JZdR+DprvVF5dseRgo381w2rQoXeUW1t5mI8jMwRz0ckMSQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf6Cu5ai; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5601eb97b29so7394814a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 02:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707820235; x=1708425035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI9yRUElbPrVcKakHt0p3JUtGiWhsdXCFkEBKrWSZBo=;
        b=Gf6Cu5aihWydbApgR4hn/ILP04ywKnhZrFioCV2GHQvlJOpPNTGkZep0sgFC8qa/1P
         O1W1gupxysGEBM1f/wQnAASNYHxRVkuWYR+x0eDi78p7Q5hkmvV4PPDJR1h98l9csEHQ
         7INClZYxiEMn/NDAwyRMuSk3FgifPIhrqY9llqGazgEdGpXyc8hhAycdyTNXyjLUjYML
         zSAahklg4PWNJtwUyr10F9XzXQNUuONmuQ2xPtnbJ+AUmYQTHZupQ2vm86hFqSBzFZ/k
         qveSg6HWZK/cpSsw5HVHVuYfZlk+13gv6RMgPSw105Lz3KLDeySwp4nWRxKVZhTRPLNZ
         q6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707820235; x=1708425035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI9yRUElbPrVcKakHt0p3JUtGiWhsdXCFkEBKrWSZBo=;
        b=cgaJOl/U+xSf/DUr3JRJgTcfphkMRWqLeLUxluSNjPnpMcxqimFQXIuEkFBkoFIpBS
         vzrGIkkK333U4fBlBqz38+WxlIUafN17duY9eDSFuq5PdCJFvmcR0/uCIRTryI/tPKjl
         WBG2RAQpsOvdvxxK5Bc3YUOLJeZJDJpoqO2A9rgnWp0ETyB01X2235msQnNAsCpTKt2q
         SaAmB2ZGcBLk7iZyszw+/L8Vb9PMJhDgOhdW0G473jsfolmJI5gsRyRtw7dX87oSULGo
         H5W90fUaMEXyk7FAOd+qjBo2CPoPTWfhcZCPTeLLkWNSFMVciorZ5+2aXw2B6xSm3HPB
         gwbg==
X-Gm-Message-State: AOJu0YyqoGm9V7VSa33jk9XlyUOEnJEejc4KPoEwSzdQkGZPsozsaKOd
	1HGnUSgb42uUpUYAkMmDgpW96vXWqVBm+RBFS8NUYn7TEqzSUrRrpnrzg067x8FUhKrHPnW6v8E
	DHryp7pjqpbUsVDPJNn79TW1DvmU=
X-Google-Smtp-Source: AGHT+IEKTzaOid+ArrPzGzFDNrFhK2DwaTNiq3f8/Lpxe91XjKsmy0x4rG8n6DJKsbhtnwM5+i1PR0UynX0BOW52MH0=
X-Received: by 2002:a05:6402:1a42:b0:561:4f2e:a92d with SMTP id
 bf2-20020a0564021a4200b005614f2ea92dmr1973350edb.11.1707820234750; Tue, 13
 Feb 2024 02:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com> <CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com>
In-Reply-To: <CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 18:29:57 +0800
Message-ID: <CAL+tcoB1BDAaL3nPNjPAKXM42LK509w30X_djGz18R7EDfzMoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> >
> > Hi Eric, Kuniyuki
> >
> > Sorry, I should have checked tcp_conn_request() carefully last night.
> > Today, I checked tcp_conn_request() over and over again.
> >
> > I didn't find there is any chance to return a negative/positive value,
> > only 0. It means @acceptable is always true and it should never return
> > TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger a
> > reset in this way.
> >
>
> Then send a cleanup, thanks.
>
> A standalone patch is going to be simpler than reviewing a whole series.

I fear that I could misunderstand what you mean. I'm not that familiar
with how it works. Please enlighten me, thanks.

Are you saying I don't need to send a new version of the current patch
series, only send a patch after this series is applied?

A standalone patch goes like this based on this patch series:
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 92513acca431..c059f7fc79f9 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -31,7 +31,6 @@
        FN(TCP_AOFAILURE)               \
        FN(SOCKET_BACKLOG)              \
        FN(TCP_FLAGS)                   \
-       FN(TCP_CONNREQNOTACCEPTABLE)                    \
        FN(TCP_ABORTONDATA)                     \
        FN(TCP_ZEROWINDOW)              \
        FN(TCP_OLD_DATA)                \
@@ -210,12 +209,6 @@ enum skb_drop_reason {
        SKB_DROP_REASON_SOCKET_BACKLOG,
        /** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
        SKB_DROP_REASON_TCP_FLAGS,
-       /**
-        * @SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE: connection request is=
 not
-        * acceptable. This reason currently is a little bit obscure. It co=
uld
-        * be split into more specific reasons in the future.
-        */
-       SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE,
        /**
         * @SKB_DROP_REASON_TCP_ABORTONDATA: abort on data, corresponding t=
o
         * LINUX_MIB_TCPABORTONDATA
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d95f59f62742..023db3438b78 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6658,8 +6658,7 @@ tcp_rcv_state_process(struct sock *sk, struct
sk_buff *skb)
                        rcu_read_unlock();

                        if (!acceptable)
-                               /* This reason isn't clear. We can
refine it in the future */
-                               return SKB_DROP_REASON_TCP_CONNREQNOTACCEPT=
ABLE;
+                               return 1;
                        consume_skb(skb);
                        return 0;
                }

If that is so, what is the status of the current patch?

Thanks,
Jason

