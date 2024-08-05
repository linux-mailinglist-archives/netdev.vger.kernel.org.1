Return-Path: <netdev+bounces-115647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72E947580
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A3BB21537
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F74149009;
	Mon,  5 Aug 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pILr2IVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CD145A0B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840154; cv=none; b=uuhEE7HlTJM1X0tkDCPFSZMoVsDbP2N69HtEpL3Eqqzd13J2vvcyABojxwFQ4uZ7Tdu2fo8lhuT84Nf7/yHswzL5UgafEAoz0qs2+P69UAeI4SKSbkKA0cwlGH4CPD5FI1+Bgxr6FCwMws4q46Q6IjlQsTlooucgQE16+uI7fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840154; c=relaxed/simple;
	bh=YzPGDXjl+eDy+6N4e8OZmZe9l2E04UtisDrDRuOId4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzDTbvm2TE0tGQnVVPPrdYQk9+Iuqb8kR68Dw/zIZoEdRa0071bKH4DqA392bFgWPzh/E1gIRtcRRuWADJLvxwsHNp/Z8kTMyxomd2cb6w4wsGVK2mflHYfmor/BSretPye0FdD87mdi+kIHlLjKx/oNLhp89t7fv/Md/QgciOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pILr2IVP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a83a968ddso1341808466b.0
        for <netdev@vger.kernel.org>; Sun, 04 Aug 2024 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722840151; x=1723444951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzPGDXjl+eDy+6N4e8OZmZe9l2E04UtisDrDRuOId4c=;
        b=pILr2IVPBECX0PblY0vj7LFrh+7TTUotBCORKq1T4giRMbvpuA5PnpHu2czvf+S+Mr
         QUM/4ThUIg6ApD+kdtX5BIrACOzCEz3bOku3yKRWrt/wKNkKs1SEpt8Foon9842Oqu+P
         S4HgXBSVDu1sizLfUccOfp/4EQG6BHfM/XSQg6zuXne2/7lDPwW3YbSpsPFCeJgcOuJb
         GNlUf1DEhQuIDhdjBYCIDDxJKPQQ6y/0cSux34dZPq7IlVkkacp96ypN3ixLf93MJc6J
         AkEw7Ppi9DBKo8F9O4bNVLTE1nWR2D6f4Av3Kh510hRHv06pDnYYbfGdKEK6zaQELqdl
         8sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722840151; x=1723444951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzPGDXjl+eDy+6N4e8OZmZe9l2E04UtisDrDRuOId4c=;
        b=L9jCDxe7czRf+f0NOQriL60pRYE6u8D6C0UoNcOu0IgXgoODnpBb0Sagzq7DkGwJqF
         uTpKwfXX9/iLefUMChZNFYDJfr/45FMGZjae8yJ77xljBZ4fRDJ8oQUPTxQ8JEhZ9PY8
         vj6Mt6HfBlmnPdaVBuQnKCOR5270jtEgwFWUVUZGpk/ItCNszjGsjzR3ekLuHi0Tbnc1
         Q/HHmGZcx3En+zZ38Vew4h5VztlcPQkodoxKb0B3W/vQ7ktKZRDc1ISz2zhgNAnlmFfP
         sjXbsEmJDU0cFpU0HWPphyv1z/cw39TdTs2JB9lbG+mf2CO7NxhO02K+nxVR1LdCgy04
         fEDg==
X-Forwarded-Encrypted: i=1; AJvYcCWTrS/ncyVgDROuRoCiBddF87iUPeqp0FwkA9/yAfXRFPDwKSIhaRsCSVW+VTGJtIAtv8YPBVtby/C2zgdZc9tbpztTVLyt
X-Gm-Message-State: AOJu0YyMMKb4gGiKaMZa5HATwH+Ai8qmeW7dbHnd1zPE88Cs62zmlRJg
	8ywarK5uhkBI2IWitsjgkUhFbxWDfhkV1YSdv5eblXwp+AGjGgmWXIkJluF0hAGXKYcDyPuYbZp
	D+OEYpQU20U1k/xqdqqVdch0+lXe3ZHznF7YI
X-Google-Smtp-Source: AGHT+IH15Ujg8tPz1fJtw9Huyg2yIRaAIJXfYpvCzwAb670F2TzQXL6sR1QEXEtpyqaAojAbleCRXilC6e87NM5eCSg=
X-Received: by 2002:a17:907:97c2:b0:a7d:3cf6:48d1 with SMTP id
 a640c23a62f3a-a7dc4ffe3b0mr675122166b.32.1722840150244; Sun, 04 Aug 2024
 23:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
In-Reply-To: <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Mon, 5 Aug 2024 15:42:19 +0900
Message-ID: <CAKD1Yr1O+ZHg_oVYu39z=qKPC2CX7P56ewRLWOkvXqvekKk6uA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Xueming Feng <kuro@kuroa.me>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> > This patch removes the SOCK_DEAD check in tcp_abort, making it send
> > reset to peer and close the socket accordingly. Preventing the
> > timer-less orphan from happening.
> > [...]
>
> This seems legit, but are you sure these two blamed commits added this bu=
g ?
>
> Even before them, we should have called tcp_done() right away, instead
> of waiting for a (possibly long) timer to complete the job.
>
> This might be important when killing millions of sockets on a busy server=
.
>
> CC Lorenzo
>
> Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?

I think I took it from the original tcp_nuke_addr implementation that
Android used before SOCK_DESTROY and tcp_abort were written. The
oldest reference I could find to that code is this commit that went
into 2.6.39 (!), which already had that check.

https://android.googlesource.com/kernel/common/+/06611218f86dc353d5dd0cb5ac=
ac32a0863a2ae5

I expect the check was intended to prevent force-closing the same socket tw=
ice.

