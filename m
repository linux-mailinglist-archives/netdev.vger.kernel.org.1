Return-Path: <netdev+bounces-226196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16562B9DD5E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9C116D462
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8892E92B3;
	Thu, 25 Sep 2025 07:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145032E8DFF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784745; cv=none; b=Y0FXCmf42g+9kPfbk2PLzvrbbcPkND8vE+ry+SbP2s59w+Vz/A68cQvQOSe+TatrPGVYlBeP3YD7dFpp5ZWEfA5x2khD4TcLfigRLN6YABgmu/jfZZOXVooqLjBOtYHnKuHeQ43D5dClO/YMJW+35tfiQa0hY5q2xBwhy+tzAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784745; c=relaxed/simple;
	bh=Ka6Xvi4Yww6lCaGWo00VHFXKK6uSJ9eN8nTKNsJT8aM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Vxkytro8Ok4tTj/lWZSyODbMqbaDzFbq6C854Iu67q2bcVWr5ykutLKCLHmzkaFnC2f1xePR1dmmF7t3r0BOZvq62x/sDMFVIiOnouEXdwqw+adZpRQ8XsgBdtpY3L4LglZA6VXAipndj4YJ+4KeMTkQmhyVERGmmjzaF/hlcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4247f4fda63so8224555ab.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784742; x=1759389542;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka6Xvi4Yww6lCaGWo00VHFXKK6uSJ9eN8nTKNsJT8aM=;
        b=xGCgxUEKLUXVREGt1CBOjwLxG/bwsQIk80FS63bjG5dAPR0QIfamJZ56H7LDCFpS3N
         Fig/Zpi/sfjMykA66LwTR6u4oeyyJiUL5ND9vk39/aUAxc+MZnRTHCwln4+qk8XnnZ6W
         LvI9Xz/hYEU83f3X2Be4Ealq4ywt120LxRzJLx903Qq6Kt9Y0G38jA+/Vw0XJQ2luG49
         sN63b0+IjiJlvc467kahI4IouDG+jjuLY3WeBb3m4QFz2IlDdphJdFHFoRlw/7krkUt+
         F+woHMHLTYkaYUzD9PvrAF25rpr1muMQaQF9OZ5iYanLpjUEciRcBCLbOIRWlBG3Dn1Z
         nxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvpg5azMzSqUPxlIanRp8i852fDZvw+jEiQAwC9Gwpe/GIj42X6zDsblQ+uUq+TDQGTLYGCEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQQJAc4Z8KRh8SC1d/KFJyKus6I7K0GJCpdNgXyHf+rxE+THj
	pr+lTEPicHVopHrtPC/mwnWsv/KRIM5gYW8kEgWT/6r4c869iLMGkFZAFNNzq+pkS0WyWtnN+DT
	UWC/XjUkxWV656UMSkV6ykt72rHxBUbuqqgrGFYXi+VjKiYk8OAXWoyQlKjM=
X-Google-Smtp-Source: AGHT+IFhvykbd4EPbrKfpqQ6rCbpWctQsXUWlvAS1AXrjYMd7F7GLkmW3ZINEeZTv6e4obpuAhGzkd+zVdFxfjKZ2tBjxKdeeQcI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id
 e9e14a558f8ab-4259563befbmr33661665ab.17.1758784742302; Thu, 25 Sep 2025
 00:19:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:19:02 -0700
In-Reply-To: <CANpmjNM7cCDoLUGV4J+MfAbQFedmEXhNrhf7fYiFs7Gi7Yz0mg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4ece6.a00a0220.303701.0004.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: fixes two virtio-net related bugs.
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: elver@google.com
Cc: alvaro.karsz@solid-run.com, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, elver@google.com, eperezma@redhat.com, 
	hengqi@linux.alibaba.com, jasowang@redhat.com, jiri@resnulli.us, 
	kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, willemb@google.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"


Failed to process the command. Contact syzkaller@googlegroups.com.


