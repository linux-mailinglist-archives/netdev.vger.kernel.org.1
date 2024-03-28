Return-Path: <netdev+bounces-82759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C586E88F9CE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65CACB27013
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD891DDD5;
	Thu, 28 Mar 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AHm7bMBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032754676
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613591; cv=none; b=txZtXMN5dgjTyUjsUtnzSfpO7/g9tA1S9LhiJBFqyZSHDsVU20Bnwy3s4t8s/fvu/p9mYACqOKVZ8ZWskAU6DPhv1jMALSWD5QcsMr13Z1XYd/10mgi39IeVx8ZTUfcOIXXfjBO7GFa/QVWYlREsjA3LW8tdJVu93b5SmXQ5WBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613591; c=relaxed/simple;
	bh=pJlCz4Y2h8JIbs7gki8cqDO9P/1JPvzb7Yi7dRevJJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFf1/7g7R+dsXu00wRuDizyqWc9ukWsnQbQ5Llfj4/A2M91KblPGnBQzJqQPLqNKq+mGJMy2SZcl4GuFDzJ/mnXc45ED8gJ5E1yrbrk9Ufm4LptYaDka2SqpZfril5GRWAaQSU/7ARCUbGjNSElFdxWGVUO+bPdUBulU29cqUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AHm7bMBy; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 536963FBD3
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711613586;
	bh=pJlCz4Y2h8JIbs7gki8cqDO9P/1JPvzb7Yi7dRevJJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=AHm7bMByfAn3xxzWm712HDsg1LVsMGTUhNOAhkRStqRBGNfFwZFwcZn17CiDHfco2
	 f6B+3bgQRbhilf8LIziJZFaLd23F9p7+ZAsPYmql+u6hm6ezWkK0H2jzDG2jikN1Vm
	 YggdmqCD6yx3qMghjPkOyXlDPzSBjR5fRo6NQLJWQhpKsS5uErpw811QQ+Av5haPzr
	 zHBYL9EXM+yTwbkQysr9h6w+W4FsGR3PrCxgPyxRcMqVfhLz8Qeu0V4E0BDPSkz5US
	 y4DoPv9kJWvvWswUU48rmrwKXzbllWp8J83e7dJu/YmcJLqeegosOii5zj7klkWTPd
	 j9x+2608axnRw==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so601102a12.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 01:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613585; x=1712218385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJlCz4Y2h8JIbs7gki8cqDO9P/1JPvzb7Yi7dRevJJ8=;
        b=olcWMPyj3J1SUoCHD/kecncmIXGHCIWjtyGxYscrzJGBSq74EliIZ/uQFsxYqSUbeo
         tCZ52HLSZEXOt5Zu9sh9a8cil6nYqCXTjo5iT4DJtWstBq50vhDoQ3Z7VArQJe/NUZnB
         5bucYbbAbjOLnhJ8IgNRhAxn7JYjt8DHdlJr0Kfysv+ulcbSoYlJmPg5p+qOQqI4gmOH
         iQ9Fg3j30JIX8filyZUuJzAhkey61Z5VpWNrNkroi6uyeCZD/FYd/+1lQ4COvuvNmt8v
         Voqa3YYf7iHJGl/PpkMn2EF6aJS2jm8SjTnFYOAoLATd5XyMLkYjjuTXnASRdpDgCYBT
         41jg==
X-Forwarded-Encrypted: i=1; AJvYcCUex6+GQ7SZpx56qW6x4o2+wk60XsMZ4mDe1jgWjYNv6jG5fS9GIr0NFEBgWo5qcZ4vuE6gPLt/5xC+usJc2qlxXYtH8oSC
X-Gm-Message-State: AOJu0YzkNcP9NWuWpMYco53MeMEXmIEq0T6jbwdrNmbGO59QXsNMuDZj
	5uDnY24PqCoU8B4l4t2f1TFZj2/M193VMbozdJKeOhnHh3NfrX0JWRucId19Gex/8sRtj/EcAPQ
	nHSYLz3ec/n2NqhTHkIOCLhj7ytoGZp2rZJCaaxHRRhyWW9ejMUbP/JjhtOpI4QVun72ruXLflQ
	gQWpT4
X-Received: by 2002:a05:6a20:e21:b0:1a3:e298:6756 with SMTP id ej33-20020a056a200e2100b001a3e2986756mr2140525pzb.28.1711613584848;
        Thu, 28 Mar 2024 01:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo9ZcMNnl7Pmw1gudSPLY8nCrzO04jYKmC9RKURHtGRCmr9D2/VkuU7bts8kitCP2exQiAcw==
X-Received: by 2002:a05:6a20:e21:b0:1a3:e298:6756 with SMTP id ej33-20020a056a200e2100b001a3e2986756mr2140516pzb.28.1711613584566;
        Thu, 28 Mar 2024 01:13:04 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id o10-20020a17090aeb8a00b0029fc4b3596bsm816440pjy.7.2024.03.28.01.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:13:04 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: hkallweit1@gmail.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: RE: Should be PATCH v3 instead of PATCH v2
Date: Thu, 28 Mar 2024 16:12:27 +0800
Message-Id: <20240328081226.31280-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c02e074-5511-4c4b-b9f3-b280d3d75a93@gmail.com>
References: <1c02e074-5511-4c4b-b9f3-b280d3d75a93@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Mar 28, 2024 at 2:49 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:

> You sent a v2 already, so I think this is v3. And the change log is missing.
> But as the change is more or less trivial, no need to resubmit IMO.

I'm sorry for the confusion. I throught that v2 does not count, since I sent
that within 24 hours and instead of creating a new thread, I just replied to
the original thread.

I will make sure to include the change log in the next patch submission. Let
me check other contributors' patches to see how they format their change log.

