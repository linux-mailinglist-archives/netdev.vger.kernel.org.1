Return-Path: <netdev+bounces-220728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69AB48621
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61E83A5232
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F322E7BBB;
	Mon,  8 Sep 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRFydOo4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C32E62A9
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318117; cv=none; b=i8i5Oj4MJ93X2kaQ33SSs5Eg+D3yQfa55vNknH3+Cm+V+YfEV/GIW6En+eYj9eRZe7UUSCtb71oeU1QMRCdaUlZY7g/nLUPmzSPM+oES6ZoVFIWtsnA1TzpOdtXPlni039JKyopyruEAOw1SFNl3et8oeQD5sHmaPonylMFCXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318117; c=relaxed/simple;
	bh=kMAdkEesf6bbVaFlUVQqYAa13fJGEFJLv/3W4iM237A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJrqDGluz1qN9zZCOcXC8nZa0DdtqDJUIczQKGV842vttyDo2Vt2dSc+EekY2dqIlfJfc5UcbN8Qrc+XyV16SRtd62UmvXg9ndxt1greMVcTVGU8LadjOGaaEzvdgRFdgi3Lj1S3VHKnCB8W0SMcsBlZf5ac+SxKdQ44EpWOhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRFydOo4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5eee40cc0so28483531cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757318114; x=1757922914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMAdkEesf6bbVaFlUVQqYAa13fJGEFJLv/3W4iM237A=;
        b=NRFydOo4a+6OwIXh8UmI+AY35mo9cFJsWY97DHtTXrHCg4Mp2paXDJTnLJ2ZNiwGII
         1y2eDt3vFot3b9VlcGXPSjNVk8/YkFLuxCHKQZ+q4J0Vrs3stYjtdp4mEJ0PQqVdZchU
         3A7+/fCph6kEzbk9XRLMs3L7kh6rrnXeLTEZAgrdNPtRnQ1XFUICGZ6vxhAwB3TDYljL
         GTPPSrtGB1GCrBqyDNpDFE7XJp1k1+0QbcXjrbY4xd89CcMFXl84eYYW7I9a9Gw46IBV
         UdGOw99U5ri7hlxeLQcCsxEbH6GNf9EskEY7+T+dKeh95uu3aUphmx1ve1tqKKf9Wj8M
         PKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318114; x=1757922914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMAdkEesf6bbVaFlUVQqYAa13fJGEFJLv/3W4iM237A=;
        b=mCR8gL1lfLg3IR3VOTe3dEMJ08y1KdIbN6/YS43Fa5WdDySgWXAlYCdoScp4eebwhb
         3KiCIOebN6zoUj475qiCGTxyR362RLh3pcDNuNWOK9ow9KeX827GzPtj5X4P7zWdKVvy
         WBUSM5FueMRxDwDaWrdFW+LbCXyoqTcmpHedInZwr33i86f2T25i/o42zA/ot5PKzBbF
         8hd+dmoVA7XvTaSz+sExUSBN2/HEIIYLi/Nf6CGDSiLqlMFfunuTpotp6aDcMNrMcEH/
         5e2ebaWCxvsuRFho8Ho7J95uSqZmgyH0mNq4ScVVsSYt00rNcwriEP6+VYAFE8FYpUWH
         9rOw==
X-Gm-Message-State: AOJu0Yw7WdtQlHJf4paM41Mz+32drVGfd43BK9K7JhDYJQNx0+6h/JMs
	I4/gO9A9vcZeGimm/lK+20GFl+ziTUuZeP9Iasi70Etm18j417qW2KReLZBn6+0wlGoFgP9IrOr
	SgZkV3G0hlCNkan/h67fgRfd16IzyywvrW9OuiLD96btyFgIb9dtO3zRk
X-Gm-Gg: ASbGncsgdey90XgvkgrC93bOBVcBNxjH0UbrTCmdSBE6mHrDBb6peBfqecgr1r7r2A4
	qWHHxJvnC9KIp/X3/Ck846sn4h1Axk9Sl0f2kJcHay6g6Z4t4GYTzp9C3mqs2l4bJZjGqE4FcyM
	9BmS+ZIHetYzJJ1QiBzDqV2f2eSTLz9rbKuspYKWsB3aUsDEAmyTo/NEeDFOins6rCyJa+Bfxhj
	bWVO8VP0gdQbmODtmUDJMqF
X-Google-Smtp-Source: AGHT+IE+DEtH3qbj8Gqg6gFy/3Z86KPShC5oG53QMgfLuSSWoagYTvVUj2zm9mak3D+Wg4ppn7vMjUWHj/IxZ7JsG5c=
X-Received: by 2002:a05:622a:285:b0:4b3:ca6b:fbaf with SMTP id
 d75a77b69052e-4b5f83b0d91mr63659271cf.26.1757318113799; Mon, 08 Sep 2025
 00:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908073238.119240-1-idosch@nvidia.com> <20250908073238.119240-3-idosch@nvidia.com>
In-Reply-To: <20250908073238.119240-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 00:55:02 -0700
X-Gm-Features: Ac12FXyjlgT2QbxcrAhtD0bWlIkl_fK9moFOPeDt0E03DmL9SoHOVj9Co8O5rrY
Message-ID: <CANn89iKir3_tS59i5ve=RKTgeOS6vRP_JLZyfkbFU0jRA_s_Zg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/8] ipv4: icmp: Pass IPv4 control block
 structure as an argument to __icmp_send()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, paul@paul-moore.com, dsahern@kernel.org, 
	petrm@nvidia.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:35=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> __icmp_send() is used to generate ICMP error messages in response to
> various situations such as MTU errors (i.e., "Fragmentation Required")
> and too many hops (i.e., "Time Exceeded").
>
> The skb that generated the error does not necessarily come from the IPv4
> layer and does not always have a valid IPv4 control block in skb->cb.
>
> Therefore, commit 9ef6b42ad6fd ("net: Add __icmp_send helper.") changed
> the function to take the IP options structure as argument instead of
> deriving it from the skb's control block. Some callers of this function
> such as icmp_send() pass the IP options structure from the skb's control
> block as in these call paths the control block is known to be valid, but
> other callers simply pass a zeroed structure.
>
> A subsequent patch will need __icmp_send() to access more information
> from the IPv4 control block (specifically, the ifindex of the input
> interface). As a preparation for this change, change the function to
> take the IPv4 control block structure as an argument instead of the IP
> options structure. This makes the function similar to its IPv6
> counterpart that already takes the IPv6 control block structure as an
> argument.
>
> No functional changes intended.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

