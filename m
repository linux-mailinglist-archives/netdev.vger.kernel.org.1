Return-Path: <netdev+bounces-133694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83783996B5F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7CB21A85
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97064191489;
	Wed,  9 Oct 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6Ev8wWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A21E4AE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479292; cv=none; b=Gg3H2QWSfunnfPJ+q6ryUhOQjc+qYRYazt8wd6pWcVsKksJBDirFW56j6OtCvPV54W282EZDXJED4j2Vpnv3EzYpp3W7t16HYhh8Ye3ORdEldAOIRwqp8I/S1zyU9+bg4KPo946GIjEb2t28Rv8ubdjJFK2bEY/BzUtlNgu9Pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479292; c=relaxed/simple;
	bh=vCQMT4/OGh33l5VSSGRJ9d7C/T789iko1vgWGYbPl3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx4I2vuAsmNYeTLVobVQMZ7g5e82COagxSVC4ZxkrEicx6IfNbkcgi/A8YC5BkGly3hcc+q5TIJYthOZ59PbGUqg12rf07Ade3JpLz5RpIEHzLqh4Z+Di9OMFJLLiAEVnrYW2wvAtMwXgXh/MjrCVNC0toevEjWP45vyN3sB7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6Ev8wWy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1730451a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728479289; x=1729084089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCQMT4/OGh33l5VSSGRJ9d7C/T789iko1vgWGYbPl3c=;
        b=i6Ev8wWyrJJ0Yl0c1tbvd5CmJHJjJWPTrfBJb1pGNFjIepCCc7/a8hDS7cnDANcLP4
         HfExdkHtbZOImNku/VdHtl70314hhzYL/2FOeiUswb/7LNWofZ0Zes7g3YGn6CkvGKwo
         auzUAv6CswEdvouXHjR+60F7cUH06Rri5UWzKLJKu8IrzhtQFRB3WVWueJt666buz9Bm
         t/paGayUYqTD6Uxc9Zvl7dEOKqxa94w2UxrKno7377DrMNYdEL0QK1gBSXIiDMZ6bGED
         48fq921UWwAcnDG9+8u7WjgfKj+Hcn1GKAwE4CyGlkyAr7sdUVNzjAPkC73xm30zCYou
         i9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479289; x=1729084089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCQMT4/OGh33l5VSSGRJ9d7C/T789iko1vgWGYbPl3c=;
        b=I24HrYUZDU5ZxRJYzAc+ud27CMQSlTI3k3DRnUOrNcMKBMbQBzQoVieSiGHPhbH/Cr
         KJ0oLYYa6skKKjVLn7i1Ddg0c8ukfj+RA5V9YayrMcFzG1El166cEO4TtqF3qwI2iKdD
         gihxDXx3iCr8tO1j4bdoeiDvqekGb1Lq89BErH+ZC+AFCUUYWMLyac+QR3ejWH3e4MM2
         CKGbZ4oH7s6U5kSkN+N6QusJn6WYqvPO2qKLm2GQTYm79Sqnuq/8orxOis2wOR7VjnLf
         byWAZPyMcqLhcqnp0MzRs0x1wS1b/m171ueE+ziozdMC71KF4lGKUVm3fy+qd421B3Sn
         r5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUxub4xTw+8U4p8Q3DWsnEg1SXenPbQ167IYjhusBptK9emdEKYB1wiM3YSepD+IJ4J6z6Q8Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciGOQuF9MonL5q+6tA9pkuvGoTW17pVKPiB67AceOxhUaJRnn
	Hq2YaMqlBgYASND0SpG1eeQDKntpWMXJzsw5hL2fpc0z0n2+KkI48X3fkNT62S64oBMY2EU08po
	Ws/QiuAiMc+PqnW1FEejxEmUCejrp4irEDyQM
X-Google-Smtp-Source: AGHT+IFwK3xKFaDSSCvmmCWjZJRLZHvuDOCWYPKnAPbZzhaE0XDUbBsW+cRSZvarCC5CcONpOhTI9Gbt8lX1yJczGgs=
X-Received: by 2002:a05:6402:26cd:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c91ce41ba7mr2845945a12.0.1728479288868; Wed, 09 Oct 2024
 06:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 15:07:54 +0200
Message-ID: <CANn89iLHwsKVQo_aVwVQAt3fpZ2E3SL3eM2-v+RacwbOdUqePg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:55=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> Eric report a panic on IPPROTO_SMC, and give the facts
> that when INET_PROTOSW_ICSK was set, icsk->icsk_sync_mss must be set too.
>
>

> This patch add a toy implementation that performs a simple return to
> prevent such panic. This is because MSS can be set in sock_create_kern
> or smc_setsockopt, similar to how it's done in AF_SMC. However, for
> AF_SMC, there is currently no way to synchronize MSS within
> __sys_connect_file. This toy implementation lays the groundwork for us
> to support such feature for IPPROTO_SMC in the future.
>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

