Return-Path: <netdev+bounces-100435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2FE8FAA58
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 07:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFAA1C21701
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1F13D889;
	Tue,  4 Jun 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="D5s7StFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6068F77
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480695; cv=none; b=TwjuSxD4roplkdaVpuxkrQh0M0uTYN3GHtPcmy0Ol7O5BDJi2z79h4HH8xw8kiJdRyB5eji3jYI8E+X99XMH2MA99c13YuJXhd07spEadFD+rRAnsyS4zGWwWu/9cqW5YbE+TvGqguNzoAsN1Ae2GPy3xOedANvI8ZRFfQ8+/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480695; c=relaxed/simple;
	bh=+Cc7S0rpTyhMJW+MSgDx2/e7NnGuZIxj/StkSvTlQ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXKAdkhF1lWMBbM9KVnmEPKQQ0pY6S/cTuBEABzoBP6hur/8iuV7mjwcqGZRralMoPkmwcNcH+HSsKAw7seR/PRgC9A81xRdKA0mxqPu4qDWAUAHWIb4lY3foSMZYuN1f4TFta2PvdKlio0ZmWAp9B8Bqka+oXIDoy2Jkw6quF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=D5s7StFF; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d19dfb3dceso2862157b6e.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1717480693; x=1718085493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cc7S0rpTyhMJW+MSgDx2/e7NnGuZIxj/StkSvTlQ24=;
        b=D5s7StFFcG6BkHgF6WbBq04stjwhpnZRLf+SjAyZcVQpuWq1Xxa0rB8YV7NTlMEp39
         YAf0tQ2ILJrSIeh3ZlZVfBqy4QuNENXeFV19R+wRXTvN5319T2irJktFwmEzF05YVElE
         nIJg66udRB/pDkCcC33XwtycYUkuifDKiIqDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717480693; x=1718085493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Cc7S0rpTyhMJW+MSgDx2/e7NnGuZIxj/StkSvTlQ24=;
        b=HPxQfjMB/MJi8Bv5nH/Hchm0wqQ+QW/h62dzO6E3xnh4caKFkG/0sFy5HVXO4aLm/Y
         17EUtfxQrFo3WwTSm5TSqxhiK3y6vSth/qFgYviyFnT/5to+H9yxoDn5yheRSOUDAPCy
         bTZf5GgS1Tz9BpOyBSJW6vvhiFODmvOqseQu/Q1VtZZZg9ZULVF8KEXI3+VacB97uCIr
         MdsemgDHEhoSD2syEAHmAGuZ7y6XKXiJ4ssOXrbd3GNoj879NgPHTxkLoChwnUNPOfW4
         75ucARAfgZ/pJVHPUIddtGeVAes59zxgfitPJIv6rf1VF8LwS64ziUsKvxaNpdH/ZGUp
         7eug==
X-Gm-Message-State: AOJu0YxVO9VvcJ/tWBy2HTipkEMTCviEUjLvoSm0ZfI04V3k9hUqWI6D
	BL9Csv2YnJ4hxwBkzovZDTZCShbiEF8D7q7A5vkXuDijGJ2TZkyZJ7LEsNcBdfwvUPTlrnL3BJQ
	wOjzgW9oslHld+uehuGHJ2lU+SI9TYxdrBUST
X-Google-Smtp-Source: AGHT+IHpYp4WohpRH/yNvD9m7EV5/LphYNy1YwUbyOb30A2d7qIKP5Ksxm8ggL+7+HnqkJjrB2NUve2rjpL01kdHlwU=
X-Received: by 2002:aca:1803:0:b0:3d1:d209:c25b with SMTP id
 5614622812f47-3d1e349418cmr10362652b6e.18.1717480693524; Mon, 03 Jun 2024
 22:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
 <20240530173324.378acb1f@kernel.org> <CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
 <20240531142607.5123c3f0@kernel.org> <CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
 <20240601142527.475cdc0f@kernel.org> <CAK8fFZ76h79N76D+OJe6nbvnLA7Bsx_bdpvjP2j=_a5aEzgw-g@mail.gmail.com>
 <20240602145654.296f62e4@kernel.org> <CAK8fFZ5S24+YqsTW0ZWCOU++ADzffovpty4pd0ZAVEba1RBotA@mail.gmail.com>
 <20240603114929.5db96e58@kernel.org>
In-Reply-To: <20240603114929.5db96e58@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Tue, 4 Jun 2024 07:57:46 +0200
Message-ID: <CAK8fFZ7NnUPg+RWixc_BiJoJrE=VtV0H_Qg4=MOJZ2yo=f70zA@mail.gmail.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, 3 Jun 2024 07:44:59 +0200 Jaroslav Pulchart wrote:
> > > > I built the kernel with the new patch but still do not works but we
> > > > might hit another issue (strace is different): See attached strace.log
> > >
> > > Thanks, added that one and sent v2.
> >
> > Great! With v2 it WORKS! Thank you
>
> Thanks! I'm sorry to report that I found a bug in v2, it loop forever
> on filtered address dumps :S So I sent v3. Third time is the charm?

Thanks, I built the kernel with v3 and can confirm the original issue
is not there.

