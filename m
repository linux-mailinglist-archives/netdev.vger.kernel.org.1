Return-Path: <netdev+bounces-64918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5183788C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6987F1C27219
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 00:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07312CD8A;
	Mon, 22 Jan 2024 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="m5j53zVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06E12CD83
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967991; cv=none; b=FHgDATKBGRsBHi3r8wcSh4nLGZ0xZ8G5H5AKIB0mj+lPsfHBqyG9j46T3QDlXpxHgSG4XsSPn+AjhoBq+nh6jYJvWwvxXudgvSTOJ8IFAxTRXVM+STS/CX39Emgwt2OUElonIoQF89kFXI/Uhv9fr1Q6NApGRBYgyiSMmmuGK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967991; c=relaxed/simple;
	bh=1cpuXFapHllyU5JZGY5dSnZoVqrMowgjvxAj773vc1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KxZzwcYQnxmE8UcJtENhy8f3Ib2Nky7Lxsa7stlDbzWDoVj+D8RWVQuzo8KEzEl69PUAm2ZFt4KqHoYWRjLxk0X1+Ps1FtByA3FEqq66OPgU1sAXrVKl6TDLG3whvE/oJCBzq3Y2AFaEKHQEc7VPfR4m11gwceSU4I2ETiqfHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=m5j53zVB; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f254d1a6daso37498187b3.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 15:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705967988; x=1706572788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1cpuXFapHllyU5JZGY5dSnZoVqrMowgjvxAj773vc1g=;
        b=m5j53zVBJ54WwgO8oRcaMUfffrnFU65XQKVBYajW8BVc9FSGK6ry5kCRW24RMSwP1A
         sUFCk+3gvWkMiyVwfQgAIqRjmA5jy8GC7aDK/s7lwPPjHryoK132ccD+ckJdovj4FsOB
         U+ioW4gurU3ILHcTG/R/2rGUDygxlx6+0i35x6gmKVbBcQqhjzT1HpgpMHYXicyVOjqe
         EtT2bTgwCEWaZyImx/DcD72KM8mbYv6FqZe9AYXALkn2LToGDRI5lsA6KClUsv7Kx64S
         756uZW+4L6bdPruaHbg1wDJVyUk6PLR30Ivhk1uLhwUw78hbbu7MIv9dFEVwhcMybFoF
         5Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705967988; x=1706572788;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cpuXFapHllyU5JZGY5dSnZoVqrMowgjvxAj773vc1g=;
        b=U+JBYrdzPaNj56AjQxahIC05ZmyJuVO374WuSVSWcSol+huQ6oNiM4Ys6K/0ZvAOWm
         016JRhTjb50zjh5ckci1IUxg7nHqn4wB/xGx6sTFtB2nGP4ajkkQq72Kvl3/Ac8lUQU4
         d6ikWmWoj0bAuKyTN4/8XJqwphR54R2OXWO/qOcXgAZ7+5CrOB2CmJxVgiWe1ABY10pI
         nBB/p9XiDGbJmMyvOCnPNbyOUaySxzwgJnS+5bBNieM4oLUTHOrKVRY0c10Pz+p16z5u
         7/91LCVAXISyfn9UfI7EE7JD/GaFmUwAR0Gp3V5uMB3Nhrv88u713Wtfbyi0wRopstkd
         IJwA==
X-Gm-Message-State: AOJu0YznGLVnoYbZfPJrJgwDY8q8d5G0R27M8vBxFBxZRn4EPbYj8A/D
	7+hNQvkQRxhuLWC3QwTjtcloje7u/bUFq+RW7F6JnYZFpCdFfNGYa8a0JgI7Z7s4GY9XYUmO3YE
	Fe+FODwo49gQ/mnX8dwyLaKUbb7QOPh+6iGOlkg==
X-Google-Smtp-Source: AGHT+IEXnljb49I9p7A6olKst+2c/syrXFQTkvCTns3I7EOUunt4MEECpj7JTo0++c2hnOxBxZ0ZT8+Rd+PN5RqIgZI=
X-Received: by 2002:a81:52c5:0:b0:5ff:55f6:7530 with SMTP id
 g188-20020a8152c5000000b005ff55f67530mr3744078ywb.12.1705967988107; Mon, 22
 Jan 2024 15:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 22 Jan 2024 18:59:37 -0500
Message-ID: <CALNs47v8x8RsV=EOKQnsL3RFycbY9asrq9bBV5z-sLjYYy+AVw@mail.gmail.com>
Subject: Suggestions for TC Rust Projects
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"

Hi Jamal,

At a meeting you mentioned that TC might have some interest in a
Rust-written component, I assume probably a scheduler or BPF. Is there
anything specific you have in mind that would be useful?

We are getting more contributors interested in doing Rust work that
are looking for projects, so just collecting some ideas we can point
them at.

Thanks,
Trevor

