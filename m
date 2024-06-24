Return-Path: <netdev+bounces-106097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA78914917
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4641F24542
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01623137C20;
	Mon, 24 Jun 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF8W2srD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E413B294
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229600; cv=none; b=Du/5UoxqDdZ5MxNhWHF/nOGeZPnkgCnhKSVJBt3UtI/9oMOog5cifRBDR1rjE5GW4N7SLYjb9NtAV8QiOtAvhJgStFhCWBsGEYj91K99MA27YeOzLw8XmZo5OC1o2yYuJUud5mZSDTVUyhBi1FtjPUh70RJYwFW4i0oKp+b7gVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229600; c=relaxed/simple;
	bh=HTx8wnE3U2h8tlMymsm1WhTMmhSC4PbjI9XPYkCp9p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aa9ISTpo99r+lMlpcHZxAn+tsDjeU+ZMUB23ZnyfxpmnU9TWh3tNz82tMmhkvit/H4ydOjkTiqd5MEQcu/TrPgqFElVMq0G/Q9fj4Vnb756rVHJcH81UhCCQ7hSlViBQ3bucSJUR7jPAuUu7CqxjtKfXX26wawxcF+jeHlg41pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XF8W2srD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719229598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTx8wnE3U2h8tlMymsm1WhTMmhSC4PbjI9XPYkCp9p4=;
	b=XF8W2srDTYC70w+5AWT0JA8B08v7kYwqTjrngatBCyLrMpIg4WBH7HP+TgSv6IcpBjhblI
	STHgbJQ4sx2uxmK5nZBGtPOoXb4RTCurI/ED526hOB0iXPAtGP1XWxYu65bQZ7PFjFPaFu
	XSIpFeIauuQxibuhUIJ9icYNU9s0DEQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-KCAqWXKVPT2-hBIOeWsW7g-1; Mon, 24 Jun 2024 07:46:37 -0400
X-MC-Unique: KCAqWXKVPT2-hBIOeWsW7g-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec4efbbb7aso17336341fa.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229595; x=1719834395;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTx8wnE3U2h8tlMymsm1WhTMmhSC4PbjI9XPYkCp9p4=;
        b=FRGKik0zBBFhBOCJCrJqbuo9wonJvE2cZ3lh0tit8bFIT/oM2WLMqyezHLCsYvwVVY
         75fUVh+ECZs82YXGrCQK2j1gA4HoLRcLfJWkTbH540i+QJXkywCmmbr2uS+bhQWEJlpj
         juQ/3MRR+/jhjH/a9nLL9oFnYVGSSVMrGrHrrq8ux2qSC6dOaZn+zad8hkPANdXTLpHQ
         irjEKtKbv2jRHuotTcIrV4ylH+pzWDdOZok1RFby6P9fyUTs3lTsQ3qKbn6tmCt/+Q3q
         tcBsp3qeA5HyLOROO8uz58fspS1doLZpmPil/BlMRnX/VwdRXa8XTWJidIRtCI40KSUd
         5rSA==
X-Forwarded-Encrypted: i=1; AJvYcCX6188QyQElXChhajky/Ipel2owovEd/agQl7FCXdQDzeGfdc8Dkvc67xU7uUYzOvV38ryngQiki+xZ9GyM6HWTefb+3fL2
X-Gm-Message-State: AOJu0YwBY1YOkPWzPpMz5CDYc9BqTZWiszI2n4evdfK7eJL6xxodp/7h
	k//Emv0Ly2EfW28mZcUsr+ZpJ0ZHacoCI0Sa+Dju5DHA7vMMBq8jytDKhTRbJuGr414eQ89oTIC
	3BpUZJ5Hm4Pk2MfOTaQ9dQ03viPDfbOQ8pKrmkhJgOuqCdJBnFkkEqg==
X-Received: by 2002:a2e:a17a:0:b0:2ec:4093:ec7 with SMTP id 38308e7fff4ca-2ec5b2e7238mr34003821fa.30.1719229595631;
        Mon, 24 Jun 2024 04:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJt/VG/AsIrl2IZ1SfnuzF+4i4QpAF4U0KYG5A/8dV/MMwb3a/AvJp8gx45wxoVrlyma0x1w==
X-Received: by 2002:a2e:a17a:0:b0:2ec:4093:ec7 with SMTP id 38308e7fff4ca-2ec5b2e7238mr34003671fa.30.1719229595277;
        Mon, 24 Jun 2024 04:46:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725e9bd392sm40061266b.23.2024.06.24.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:46:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EC475138620D; Mon, 24 Jun 2024 13:46:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Samuel Dobron <sdobron@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, hawk@kernel.org
Cc: Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: XDP Performance Regression in recent kernel versions
In-Reply-To: <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 24 Jun 2024 13:46:33 +0200
Message-ID: <87ed8mftra.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Dobron <sdobron@redhat.com> writes:

>> It looks like this is known since March, was this ever reported to Nvidia back
>> then? :/
>
> Not sure if that's a question for me, I was told, filling an issue in
> Bugzilla/Jira is where
> our competences end. Who is supposed to report it to them?

I don't think we have a formal reporting procedure, but I was planning
to send this to the list, referencing the Bugzilla entry. Seems I
dropped the ball on that; sorry! :(

Can we set up a better reporting procedure for this going forward? A
mailing list, or just a name we can put in reports? Or something else?
Tariq, any preferences?

-Toke


