Return-Path: <netdev+bounces-255128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OON3HI2dfGkLOAIAu9opvQ
	(envelope-from <netdev+bounces-255128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FEBBA4E7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C5CA3002F62
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815333EAED;
	Fri, 30 Jan 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohkJTpA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBC2FD69E
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774467; cv=pass; b=IabLT9rtmQcxkpVZeOyM5fHOgR7VT4ME2ItLZKfXkBDbv37pdrOXdf8MvdUMqLS2w4gdgN3w2WajHITsfPoQzyfiEyGGFDDvCWROeOISpBf+GKaSfIwwtigJyC5KlToLQcgya4BJwhCWzee+eMLeoSziDATjxJ3Xkjcg3RuMvyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774467; c=relaxed/simple;
	bh=ZJZXP6xEL3dYy7NoAOgI7OyTGIr9OGLgzegcneaY+Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTj07GQgblrIiWmCN8LANEktPLbXL9LD2hIgsQp2iL/KoEzDVwTyDrWOeyOiagWxKrrhH7MmN8FdhsvN+qXaAkdMRsw4w6sBLaE4ggkuqcguiEjm2cV9+h/wEhJIFzSFjAavZFP0A4iA7aTTY5fuXPZjAINolVefPqIE442PdPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohkJTpA6; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502a407dabaso14570891cf.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769774465; cv=none;
        d=google.com; s=arc-20240605;
        b=DVJgK0hewMaFmsYqMchnFrgPVh2A81Jibyd+HKzw9a7O+FXEchy8VIN+lXb9QzodoU
         x1o0pqJ8V16pAIFZwlbyTOrcPuD/Agp4IB8IHInBeHY9hEWc/4F4FseZ1xxN7aztUF6I
         l8eyYt47OXA7L/Op6HC/xSdeLKWIzeGB7ayJOfSchJJ6pAWTUnw9jEdA4Ogkx74BcFgy
         jXuI+eEesnxUKn1TcJpoQUsjJ+kfWFzWJisUjB3iDFaj/13tfmtaXxXcw+0xF++Hd22t
         6TI9jIIMZBpHJR8d7HNoHOYrDCy3AD8OPc8/fIXbvDS/EITmJdcYhUa6C+iwtmj09qn6
         8jvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZJZXP6xEL3dYy7NoAOgI7OyTGIr9OGLgzegcneaY+Xk=;
        fh=dNSdwjG+5bbMSPg9kmgdkGAC888LaufVAQsQp8CQV10=;
        b=P4dy+/ydWvhEwi0aTkc3+7NCrAT5LVMePXnBthXSypxSeKWsOJX8a16tRTxJXaPbgx
         UaiyOTnmz7Qq1/JGfozITGM4gDFNFp0zKx7bOTZx5I4ePrz/cyf30VQcm776KymXQZYK
         RCHMKbcrHJdKN/gjlYaZqDt3C0vaDCvoe/LCgLT/22/g5XGBDcGlsCNxDYtFxR85XmkH
         RB8CBzmY6UE4q3w4b7IAZjmXP+kEX7Ew6Gp28pW1j07Xg7dLVWdNe8jIHIFwCAkko9dA
         OgK7GymQ4cxt23ZWek80bXJ/iJh//PWfT1074EyeXnJqtg6w9+b3BKMnmNYVIQUhSgvF
         sfDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769774465; x=1770379265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJZXP6xEL3dYy7NoAOgI7OyTGIr9OGLgzegcneaY+Xk=;
        b=ohkJTpA6aUaBSogWQ7TrdqIngygfG8dwe4k30B1iIUve7IV+DuwHmINUkiCZ9//1Kw
         86urwjq2a8pJTRq0+EOGy1cccUMbIcTJYmdFWh9+8MgVUEgGhi2yyd7+MqPLk2RFWFDq
         XIU3iOvQqkTlBhoUFhNmD7BrMIvFtDnF2W7BMy5a2FcRo6fzPPRSJdnQPIirJ5abr4O1
         hEpWiQVDf2it8GJol6M5VeWPYTjg9YK0Mf7Zkp+fmTkhJe2FLgG+tNvpp+sK7qR13Sse
         p/eAUqcBY8OOasR13PMdnu+olNcyllIYDYQO2fyk7H9XfKHwQqm0V9wW83nGtnMu6r2m
         FlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774465; x=1770379265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZJZXP6xEL3dYy7NoAOgI7OyTGIr9OGLgzegcneaY+Xk=;
        b=RrpfUq3uuOVcFzSOJHoNfml/P7Y8Cfip1LBeTWr29DLRxicku6UiHfUdZfCphGLBRI
         /5RyqJv0Wt+sh6ZEd0N0M+sdcuOzKLdWQ39lS8+v1D7z1HlIIsepfSCXV8W+/TtaE0bg
         q9W5FeX1xXyC34GkFvtG+Mk40S13YGQ3+CS9+VTNZIwxcvNwkLGb2wm5JlqRbX+0xMMa
         sE29Cd5a1LOhdbzaa8is5DrWl40wyZrmeM9lJJs8prTQYe9Y/Oarm5nb0QszwBvas73L
         PDQrLbUaqo2+IrMclugbktQIk6qAX1mlKPWObHyCoatCoqWoW8shiA5Yx9EAx1KOu3nR
         nR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpP1ed7Sg/lsTA1o5gWBK5VjBr9p4jyp8eaGTt+slBQ5fhJj0hIRaHF8wEqORTRHWTxcmtoCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRcrNmQReNt1TNtarPNF5O1/OTgE9+uzxdKuS4bQiALOerqyo
	Ks/wZJpP/5ikhCjxJEJeZWMdpXyxOPhAUx8RqvtASIVSxAZkufC3SHA14TgDAbOMoot5xuUoslw
	n+npwjFa6FhLqKArA3qRUooht5dc1jdnROoh33ovc
X-Gm-Gg: AZuq6aI3U0vsi0AQBLqROKJllsEAg4qs4PJ04DkJcZw+EtNEYAjAA26L09qLrjTRXMO
	fgUtd0CADmg45uy00Sdqvp64gh/c3/qpuHrlGLOimoRjWF+4Pqy4QQT1psW/ufxmnTPaO0/Vul9
	dxHmDoe/S+pCbwMtslk+VPB1O17Th768fNxYRPADd2Bjm+p4l8FNEa7N6We0HizYXeYWgRKJO85
	GvG55Ew5ycT1U3D8zFtDSrAmf/cV+G5Xz/0hln2I4EWc7cd5rVaVTHDQCV7TGFmBR+9g8k=
X-Received: by 2002:a05:622a:254:b0:4ec:f410:2470 with SMTP id
 d75a77b69052e-505d228c282mr36041711cf.71.1769774463982; Fri, 30 Jan 2026
 04:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com>
In-Reply-To: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 13:00:52 +0100
X-Gm-Features: AZwV_Qg5wvn7xde5VVnxU95HF-y-lX10m7yb3gH2CXSHB4-WuKWtvMlYRHbwT3c
Message-ID: <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
To: Hirokazu MORIKAWA <morikw2@gmail.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255128-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E5FEBBA4E7
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 5:15=E2=80=AFAM Hirokazu MORIKAWA <morikw2@gmail.co=
m> wrote:
>
> [REGRESSION] ip6_tunnel: IPv4 traffic broken in MAP-E/DS-Lite since
> commit df5ffde96693
>
> Hi,
> I am reporting a regression in the IPv6 tunneling stack (MAP-E and
> DS-Lite) introduced in kernel 6.12.67.
>
> [Description] After upgrading the kernel from 6.12.66 to 6.12.67 in
> the OpenWrt snapshot, IPv4 packets can no longer be sent to the
> external network via MAP-E or DS-Lite interfaces.
> [Environment]
> * Hardware: FriendlyElec NanoPi R6C
> * OS: OpenWrt snapshot
> * Kernel version: 6.12.67 (Broken), 6.12.66 (Working)
> * Protocol: MAP-E and DS-Lite
> [Culprit] By bisecting/reverting individual commits, I have identified
> that the following commit is responsible for this issue:
> "ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()" (Link to
> the patch: https://lore.kernel.org/netdev/20260107163109.4188620-1-edumaz=
et@google.com/)
> Reverting this specific commit on top of kernel 6.12.67 restores
> normal connectivity for both MAP-E and DS-Lite.
> [Steps to reproduce]
> 1. Set up a MAP-E or DS-Lite connection on kernel 6.12.67.
> 2. Attempt to send IPv4 traffic (e.g., ping 8.8.8.8).
> 3. The packets fail to reach the destination.

Thanks for the report.

Can you provide detailed instructions ?

Apparently none of our selftests caught the issue, it would be great to add=
 one.

I have no idea what MAP-E or DS-Lite are.

