Return-Path: <netdev+bounces-188925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A29AAF67C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410591C06D5F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7720C02A;
	Thu,  8 May 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYda9pDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FB1DE2C9;
	Thu,  8 May 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695709; cv=none; b=FsQmVBQM54wccCyRwTi3KdwYQaLgfBXhDIOaXFhGFhS41NhyO+GsR7D0vzsazNX9PtdIz6CbbN327z/opC/BGyP5yC4VFaMs2X49Kv6NXxSzfAQ5hFHI7ujv4ysn46Sgu1TOYO+XOyFSA2B0nRY1/7g2nlNChTW8DF7Xs48wKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695709; c=relaxed/simple;
	bh=FjYljBe4oTo0pnbVadsFStee1/DgTYUg3+A3NRoFeEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO0uhy9eq5StI07R89suHz5bIh2EGsQLzsz5bXtXr7zUdM0jT3xZ0tMew6BGBeHaDNoCem1XIzHl2yQVViAtduJLH3QJK+f4xsqSPgmSabLuNOAhfmsr9lP1PJmrUlEccWmL8kVgOCjxNXMy+JvW4JOv/Ohvxm2a7Gj8eZa1nJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYda9pDv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e75607f95eeso771017276.2;
        Thu, 08 May 2025 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746695707; x=1747300507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FjYljBe4oTo0pnbVadsFStee1/DgTYUg3+A3NRoFeEo=;
        b=WYda9pDv3OLmKpjMwJqjHvYNAm8wBkak9q0tegEz2cybEOMAl8GKlccnfHh6DXk55S
         ZB5ZHIADGJXDBE0DqATdBSGicB3syKCpHfbToqu3A1owJo+dzU3kRa/Rn5MZiqJQoq4c
         4EVEUPKZf1drIY/IG163cwG8o+xQ9WvMyUEKEdKefAFV4MKs+7YRaXvBoLmru111ewR6
         YPKtmRA+O6/fBXQmcwAwb6Gd8rkeilM1SZsNfYhBT9a5wl2qLlMKbqCJdXCrG1NdMVpL
         BaZdotkHx0RnuFAmhnocjlOfIzLry3QqMyToucLXDhXpHuvZbh2J3avnZowvmCsUkbhH
         Mw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746695707; x=1747300507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjYljBe4oTo0pnbVadsFStee1/DgTYUg3+A3NRoFeEo=;
        b=Ew3XwMm5rCbqiI8yzaGrnKk49wBODW0ZNLXwu2ph/0jKuvPJiVPnBQJewadR+8BoRL
         oVaoqgeMFCJGBMeRb6Ex6Dzz3AFLurfbQ9tXIbxjr6FnUsUKAYzvqghtmXnKcxQd3eaQ
         HgXbQy967GV70YbtrbVptiwZqqWPsm30JR6EMWFuGzn55TzwRERkzZeQJmNl/zgY4m7r
         bYNqoLbVeCFF1hKmXEOuV6lae36dYbBcOQeJMW5oWbIeMU2pFCG2iwX0tgaGzVFEK6v7
         iQh7Wot/oJTrPNzd374MVQmW/j9vDtpPpAKPAC7ArmaKeCmIDsFr+6UxJ8G9G3YnU5j/
         /oJg==
X-Forwarded-Encrypted: i=1; AJvYcCVaFxm55NSJXfNwiHsu31joyR6EefLoqYGjzRiCzjOhg/0mp8DcRw1HcAj4s031yMJ2hiorTZpavCQjXbw=@vger.kernel.org, AJvYcCXkTw2dip7aaKXdjKyv8aAYAdidrhfxn+d+bK+rsqWDKrsvteruwZOxfLbrMcAkyCH1tTYZ+A5r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29Wgq15XcCQEpYBlzyjKykw05hfTqW82p7qGlyaSsTuuf/vSc
	wZNSn+NEIYaEohWEwxettrCFKxErkBk6Qmsxc0sYW4ZfkbQIybT9t9y/kLFmuCP2aC9jN331Fik
	mJHDuRBtud93zrk6oxwSymN6ImA==
X-Gm-Gg: ASbGnct8FklmOetRUrUo+3an7zchhP05BDPSJXKPdROghQA11E7RK1KGYUe+h73iwoM
	YAcwp6bFGISQ51ckDfXPY0/CcrZGE/+/aaeh/PnibkzwbvQKxTHkPlLQmgbVIWWDegA4yLTftqk
	rpwCi0PjcxJTqkiM4Tu6jY+i0p2cp7Fl8vCq6Mk/ACp5wKsjZ+VXDVPiPS7oLnGivRAQ==
X-Google-Smtp-Source: AGHT+IGbSdjxNeBnmQbUT7RFU5XmB9IVGhtN8FWmE6R3R9cyNr/FEJXrvrRdwwIKfyEu7oBcaCZGvbA4ySJ3grL8Jq0=
X-Received: by 2002:a05:6902:100c:b0:e78:f3d5:d189 with SMTP id
 3f1490d57ef6-e78f3d5e720mr1135793276.7.1746695706808; Thu, 08 May 2025
 02:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjTZvYKHWrD5m+RXimjxODvpFPw7Cq_EOEuzRi1PZT9_JxF+g@mail.gmail.com>
 <CALs4sv2vN3+MOzRnK=nQ_uMXbR4Fi8xW9H8LdX79vYA7tHx+2g@mail.gmail.com>
 <CALjTZvbopTcm9P7Hp1ep54R3_7yODg7r4j=OR2y3WOA1X84e2Q@mail.gmail.com> <CALs4sv2DgtkcWtMSsMiP9VLW98+5T9hz13j+O3qnqKYce6G+qw@mail.gmail.com>
In-Reply-To: <CALs4sv2DgtkcWtMSsMiP9VLW98+5T9hz13j+O3qnqKYce6G+qw@mail.gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Thu, 8 May 2025 10:14:54 +0100
X-Gm-Features: ATxdqUF2LpbSedW74Nfub64pYrrfkK1F0wqDqmLT9mfix1uIl_MaVJp5gqrdsN8
Message-ID: <CALjTZvYPsYb8FYsmN+YSO6U4UGPRGJSbVyxCmAfVQ4jSyBSzMg@mail.gmail.com>
Subject: Re: [REGRESSION] tg3 is broken since 6.13-rc1
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: mchan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Pavan,


On Thu, 8 May 2025 at 05:10, Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>

[snipped]

> Can you please mention your model and the make again? Let me see if I
> can find one in our lab or near me.

The machine is a late 2012 Mac Mini (DMI: Apple Inc. Macmini6,2).
From lspci -nn, the Ethernet controller is a...

01:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries
NetXtreme BCM57766 Gigabit Ethernet PCIe [14e4:1686] (rev 01)

IMHO, whilst this issue doesn't personally affect me anymore (I'm now
using a faster 2.5 GbE USB adapter), it's a serious regression that
should be fixed ASAP.


Kind regards,

Rui Salvaterra

