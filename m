Return-Path: <netdev+bounces-262144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFWWEfkAo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:51:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE91C3B43
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49002303E7AE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F74043E9D9;
	Sat, 28 Feb 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lhZ/i5v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523C43E9D0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290102; cv=pass; b=nHeGZAN+eoBd3WvOKdNMS9+0EFPXFFDbzh6F3sjIZAhP6aCKrj08IMlTcHvmgrpbDWHLP7hmyr5J1tstpMa71/7QIoNTvyGrn2kiEp7LzswVvJs1JlmBCerg39vGxHi1+ll03u5fvtd3nLo9mAqPn5PvGImfNwIXrp7RxcCeJdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290102; c=relaxed/simple;
	bh=1Ma+fyaSD4HnjfFrmb8+WKyqGbYrcv+PT4G6IMRlZYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFp+RbTr08zVS2sRUE9ipS92lVD+kaifQfm6t+wYj1vcoOajVC30bVFzYce3xJPisHytur2VXGWUiy8ANOSpUwuhVWpa3gmiyhyPtNegU3KTAhu1yR49QYTEph/KApNPjsdrvIc4n7YK50R/e01WXcoWDqu4teHeTAZYCQ/f+C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lhZ/i5v; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506aa685d62so17864941cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:48:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290100; cv=none;
        d=google.com; s=arc-20240605;
        b=eaGNr1dfZiHoWJv50+lAqxQo+Z9+BZpJ8dr8CmMnSicF7ymb/CY/tK4KXXp5w6DFQq
         CpZzspjF9LNcDeKkH/m/Ji2XltfLetd/hjJGztDsHCmZ/TeCRcAEQNpg62jRFRRynzrz
         sloKrRdDyVBdhjH4OamXiX7wPUuI+1mguOvxOtbPoTvywpVx+zx5a7Gtdj7fyab6adDp
         +3uVwcZSHnL29lRKv5x42P64vZvrZaklOq72CyhdT+TTmVyMPm23b8WxasWnupI4IXIG
         U7O+8ASznLOOwVz4PAoW2qEkyfhs/2yvlzR/gyVzgdQveht4xUfSVeed/NYbaxh7wN1q
         QIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Ma+fyaSD4HnjfFrmb8+WKyqGbYrcv+PT4G6IMRlZYU=;
        fh=qjJ2GuFw/x102gtmpfsdZYqz4M43/yMZBPM5ucl3KIY=;
        b=XpeZGbWq26+Sb4LtWt0CsK+M+LQa8dHuoXmpnQcllvXf9ON91Az/Q7rXs+fpKjJdYj
         bVL6W0DzM+Ywk7WJomh/S4bTLp5RgCogk93aGy7HBIWhFhrYS1mk9NBWNl7+tTiO2ALs
         LpYANAmWwxXngG01urKU/KLQ/5LuqAxV7Y8gTVoI13qCwKtEtd08XXibW5xhyVA15pui
         1Z1Spm9GxKhdwAH6Kh6cHJgvaTu8lh+Fzsgp3488WSvrifzZdIzDKG13spkZREeB/0o6
         huJb6M2rLmtx6wpJ37qsh31gE4HtqEiflA462cc4GfkIQGGmWt8vUWRDbkYpTd8tXiZ+
         ozhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772290100; x=1772894900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ma+fyaSD4HnjfFrmb8+WKyqGbYrcv+PT4G6IMRlZYU=;
        b=4lhZ/i5vrt6cFIvtaxymm7c19/MT+WInvUv9ICQUVTwAwRfNUCzGlodi5d8tiTp9Gs
         +SQH+P8WdRRmo94k2UPvYlxECnAlDT4h+05uOF2mQg7/vXRec1v3PkQ/+G+MjfYU17ZR
         x257PAvoyeM/fh55g33hNrudleTgKtgzS7iplGO8SaqrvsXavdn3mFUFxNPDfgcwkmN8
         qwnBylIlvn0lB73VBpBARQDw8mVe1/JrywCQ0IogTMa4QefWiiryrXKfN04LOfcNgWfk
         zYMI9RX9mMq239v3DYLRlIy3IgS/GvLLbro4AWslUNCmU/0QTVnOzByV5T3eRIGpbv34
         IkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290100; x=1772894900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Ma+fyaSD4HnjfFrmb8+WKyqGbYrcv+PT4G6IMRlZYU=;
        b=oYe8+/DqPOek5JKj5loFTxqqAyXFz/urSLpfzNSXy6fbI6nSj+/IxtjzMcmNNb4zoF
         Z8Z+kBgXWrCPio9bLK7DAjmJyK6Q1dpOSpE3jF03qCqD4gtC7DcOBx6ZMEdGbp0B2zyQ
         1BDovq7ed7Q/4UZxwXtjiEVeODbjok7RlWqiD0OVrbbpnTC/3MA2vgn4CmrgotgsZdQa
         tg+IKuHjl+wpTvhBtqtsBoDsoPIgKg9uyAsteGhTBvG/HQcPozwCt3ydykNYgqnl/m66
         SbkezLqWkD2l+Nb7oj0KqzYl4YZkwcbi7IOJA27iYAWasektSk4XpyM8GnAg8XKCXOdl
         jWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW33e1ztEZS6a8uOz2XIyuNCMZuRwSTiOSjm7Qm6ns7Gn2PCm3ubmzNpuJ3JYpPMyUTr6BotEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5ydX3sdVPkPK9VriCjnl6n5U0UwnoZN9ckgcMcigeRH9PtKQ
	c0aV0H6F46VFVRMowIbuJO0zcjox5engbr4IPqiR1jvZ2W/lyP+PhZ+Ppn2v6CzqgjKDNPeGgpQ
	c4JTfJhSQ+c3r2dB4sLJ6jMOG929baMHeT2gi9riO
X-Gm-Gg: ATEYQzyE6KsAMzkg8eQlHVeSA6P9zLiy2cWeOUYxSS+xfmgwdt2cAKbNMlMsPv5t93/
	/KAn3JmwGH8ctYyXX6IZiClF2J2iKkBLcLB2u+N7hX6pIfetWa/Pc2sy6/x20YNHxKJqYDiqIm5
	ub6DjVm9BoRNt+zCphlLc2gIyHO6/tXrMCDm68RWkYpZ7EJ6pLl1kPv5KKkch2kSGussjIzdNdi
	84fH1levYu7oZkedG0Y67py2t8Wwjy6wZEMTApxP1L0//r+EszNhI29LWrkCrpYkUc4xFWZ0AJ5
	qZh3egPeDShUV7gQgfU=
X-Received: by 2002:a05:622a:1987:b0:4ee:4512:4a24 with SMTP id
 d75a77b69052e-507529f98a2mr72259971cf.72.1772290099615; Sat, 28 Feb 2026
 06:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-7-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-7-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:48:08 +0100
X-Gm-Features: AaiRm50zrwL_Qs54x3D1i20gBBhIWYFEcrl5ELPF_UFCik1-pB3cNkcRBx9qDT0
Message-ID: <CANn89i+h2ZGqDJACo8zgTFd8h0zxN1J31UHmeu5xU5Mo55r2Ow@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/15] ipmr: Convert ipmr_rtm_dumproute() to RCU.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262144-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 60BE91C3B43
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> ipmr_rtm_dumproute() calls mr_table_dump() or mr_rtm_dumproute(),
> and mr_rtm_dumproute() finally calls mr_table_dump().
>
> mr_table_dump() calls the passed function, _ipmr_fill_mroute().
>
> _ipmr_fill_mroute() is a wrapper of ipmr_fill_mroute() to cast
> struct mr_mfc * to struct mfc_cache *.
>
> ipmr_fill_mroute() can be already called safely under RCU.
>
> Let's convert ipmr_rtm_dumproute() to RCU.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

