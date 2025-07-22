Return-Path: <netdev+bounces-209094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F9B0E45A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19FA7AA8D7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F8B2853E9;
	Tue, 22 Jul 2025 19:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A82853F7
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213638; cv=none; b=uOIeqAADRDJL6/4hFUUU02o8bXC6qCsREH+AVVv2gzZysqHmjqp0m+q6aAG+oCM+d61U26Das/Ymw+N2/JgBKTsCb8+ErOqP8K9YkgLTsDRZE1CVkbK6I+WkEsCFABYNp8bRcbtl+xeLahVHjKXlJgTuYRs+TihAx6xdaqagPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213638; c=relaxed/simple;
	bh=KhAupNvkqYbB+L15tQt/GviWL4AKCEiGwpuo76Nu0v4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=n4SHADrzGaHD4A/es6+ZbLf32jk1ltmPVGoVIi5+FTdZ+z8jsQ+KJnAByOkazWyb48KZn+li++SM4rw/g9VycKAkIJJcnhmNkt8PY452TEdqNzs1uNzZY47X5FeRbAayr0FG+96U6mIcD0IAFICU3CIcJLi58ZnSpo81cW3UCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c1d1356f3so369239039f.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 12:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213636; x=1753818436;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhAupNvkqYbB+L15tQt/GviWL4AKCEiGwpuo76Nu0v4=;
        b=COh0jctALHuuklz6iSjOvwnGLnJ0vETYtWdOCbPwSXELCV/jOJh/dxGqVfqEj9MrVU
         6N6AeAKxtQD8MKl1zJCT9+Y5iGhdXuv23A0lS1y3U2BvM/N/pgF4v1kGvXoz3i030IKZ
         EucNym7ueYsse10IrNurSPTK/9n6EGx4Bii7jeBg+mFBzvHIknBrixRkNBC5HsiXIywK
         9GK8/YzBiIQSyNkGpE4vJfYljYKcnPBUZgazXY+XOWumRDTbhvDz+6aw5rO9ET053qvC
         xQrYUf0AyQ078hK9JnsM/SFEsHvmjpWDB8wi1DrsEKYlE0npY91uBWsSb6EDBWrIqygH
         V3OA==
X-Forwarded-Encrypted: i=1; AJvYcCXoXbHirRp08QbexqCjkej101YA/xQP8xM19ITVYwR9hfhtMlfFv2NP2o6M7xGC5DpyvDY7uLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1sndao/skXH0+Q0HRPfDlhfvoZnDiBAJzcaa+e88qgqK+r02Y
	vW0Gs8UCkohlY3knLmWt9vsCXv4SwtINCTemI7hLN8Tn7o6Gpwf9SvSLdfuNXWoy7Kmk+zswV4Q
	8mjsNK+fxT50crEZRfqHtL0GWseICm0tCClR+E8y377xuTJrG23ZIRAzMzI8=
X-Google-Smtp-Source: AGHT+IHkT5bOsizzU4GRs55SoiHPfaxYPynREfRYvB8D/6LfMyvr/79oLo0wP85sSp16FuCWGJLBWrzBJ3OdxAlHmMvHFGDxa1eO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1584:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-87c64fd8f3dmr67755639f.7.1753213636550; Tue, 22 Jul 2025
 12:47:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 12:47:16 -0700
In-Reply-To: <CAF3JpA5JPbEByou1OKfuPMKH1o--0q113pNoPyPR-h3QjuZxUg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687feac4.a70a0220.21b99c.0014.GAE@google.com>
Subject: Re: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
From: syzbot <syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com>
To: moonhee.lee.ca@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	moonhee.lee.ca@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main

This crash does not have a reproducer. I cannot test it.


