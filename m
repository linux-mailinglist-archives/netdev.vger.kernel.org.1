Return-Path: <netdev+bounces-164817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C752BA2F41A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635FA3A169B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD42586C2;
	Mon, 10 Feb 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="l0me74Tg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F22586C8
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206176; cv=none; b=WG1xZ4TWB3u6PVk8V/3/bXpUffiSSFQt+0xzibH40f+UezQhbCKxY1pObBmuztyxMZaN80oFedKoicRk+306QZ7t60/l97TGdMZDCeX6BwRIxeeWrJu2AFeXG9UvxZ4ttjLuCFjDIYO3jQfk+TCSTs2wvVOMkNnb6/4Y7Gbyvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206176; c=relaxed/simple;
	bh=yQZdQZsVwBqhzmNXzbrVVN1SHjOkGrEpBj7lY8wIH4A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=WJfD/tf+8HXsPR3sADhxLoa6cFLVBHpbTe5KSzQAQosDnBQS89ppwjyBHuoXclERve3V/WZ1jdOzeMScIpN3XitA79z6hRa6l0srbEVlMFqUzLjywd+Bcts5i1jQpwSwxar7JBF8ci8KsGpac4MTyR/A65rE2E+F8GlobUpiii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=l0me74Tg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f2f386cbeso85122885ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739206173; x=1739810973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YvRvdBFBu03Qr/dUsEmvG4BCWhOSJZ5iKkgw21ypus=;
        b=l0me74Tg9XO+erGMJiwC6EKhLIGtOq0YnsMCB4Vj1SdQPYE7w0WwlvrMGvV/8/yScE
         su1WWxwdggfUATsAwdzhJY/Cg746kHK/u2ZbD+IxAZiWXW6Iges6Y0ZjMxGG4/A/Z7bB
         A8m8QBv/+UMeOZkStSt65hjMwm7cYnI3ZfEAcPlP0cwowW06f40yEf6PQAX/NB61pugJ
         Z00Jk9FEzRyy8OVa3lRYG/6igqKTqjwa3A/7Xhod2YiIsaPN5lcDictRRau3ys8HKOOo
         us2dd6eWwSe/6l0ACb+n1+u3stlwoJASAtJZ6ndYWAgV86mERYNZQlLdrbJZsUBMarxT
         PGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206173; x=1739810973;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YvRvdBFBu03Qr/dUsEmvG4BCWhOSJZ5iKkgw21ypus=;
        b=oY9d5xMnUXrLQAfSIBlr+FiYKta8LPLWNjak8A1wes9/n2tbkmtvcyLlXk8uWfgbW5
         YOm5JamMEbOFEL/3ABdbF8vpufQx/7JS7XaReOoRAtwRfvoGrKtNJp6sE77MV8LAWcMz
         3BMiEa+wv8Mvftn1bkztAqorc+71y/ckSh66E+ynxbNemSc3eNVdWjXUFHCQ8CXjVlpF
         qMpVXrXOE/gKX7ySL+bu6uEe4cJtjNikETIjX0ny0a87fdEOW4zpjrDS74HOKs5vwgHm
         Vx5mN3cgTuO6koE9YpPJTcvSNwNHDk1KsOpa7emLZk3ebCCNFQAm9Tr18XrTnjrsfQmq
         POWA==
X-Gm-Message-State: AOJu0Yy7/0joibwCDKZbS/ysfqSpcMTE02X5fYvpqfnHiidlj0IjW8x6
	DYy8nnnN/2iqQrqkD9qgGoqP4+9YB957SF/ieZTI+TP3X7Y2E7XzyNHh1haJIr33x14IJnYY6Aj
	q
X-Gm-Gg: ASbGncuqhDZwKiM6Vy94k3DZXJYtSQcoPWrIx1OskxZsk+DROdqDRUAperN0pwW9Lxn
	5Dx5u4Mqj3YVobCtByRKH1m8ZC5t76/1EbbrF1AWIOfQWbMNa9vFwHZ/cPe7m7wgK/Ea18W9m2A
	z23fSM/2ArbtbZk1DSilXqTESNr8CuUB8YycY1aVtIJt0k7tEy+OHHxSipELH7Jquf8/C0h7+xE
	wyOjK62bZxbyw4SFHWYCJATO5YGy2M3ANv2sEFtqU+FXK23TiENioVtZraD2lI20kYdrGc63eYD
	OQ8sRV/oPKB2Rv/Kssl3OfrPam+8BiETyKDznCT7kBHY8EmxVkEM036G3OLt7KOon0L2
X-Google-Smtp-Source: AGHT+IHzqt5Fzo87K7+YPO4c7fuMld10vsjtADQ5xXh6+ESgY0cLh7V9bGGutQI7SlZSD2XSKIBaVA==
X-Received: by 2002:a17:902:ef51:b0:215:b45a:6a5e with SMTP id d9443c01a7336-21f4e6bf56fmr192172665ad.18.1739206173454;
        Mon, 10 Feb 2025 08:49:33 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d576sm80402925ad.130.2025.02.10.08.49.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:49:32 -0800 (PST)
Date: Mon, 10 Feb 2025 08:49:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 219766] New: Garbage Ethernet Frames
Message-ID: <20250210084931.23a5c2e4@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Not really enough information to do any deep analysis but forwarding to netdev
anyway as it is not junk.

Begin forwarded message:

Date: Sun, 09 Feb 2025 12:24:32 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 219766] New: Garbage Ethernet Frames


https://bugzilla.kernel.org/show_bug.cgi?id=219766

            Bug ID: 219766
           Summary: Garbage Ethernet Frames
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: fmei@sfs.com
        Regression: No

I am currently troubleshooting a very strange problem which appears when
upgrading Kernel 6.6.58 to 6.6.60. The kernel version change is part of a
change of talos linux (www.talos.dev) from 1.8.2 to 1.8.3.

We are running this machines at hetzner - a company which is providing server
hosting. they complain that we are using mac addresses which are not allowed
(are not the mac addresses of the physical nic)

In the investigation of the problem I did tcpdumps on the physical adapters and
captured this suspicious ethernet frames. The frames do neither have a known
ethertype, nor do they have a mac address of a known vendor or a known virtual
mac address range. They seem garbage to me. Below an example. More can be found
in the github issue. This frames are not emitted very often and the systems are
operating normally. If I would not be informed by the hosting provider I would
not have noticed it at all.

I also tried to track it down to a specific hardware (r8169), but we have the
same problem with e1000e.

I checked the changelogs of the two kernel versions (6.6.59 & 6.6.60) and
noticed there were some changes which could be the problem, but I simply do not
have the experience for it.

Can anybody check the changelog of the 2 versions and see if there is a change
which might cause the problem? Can anybody give me a hint how to track it down
further?

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on enp9s0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
22:07:02.329668 20:00:40:11:18:fb > 45:00:00:44:f4:94, ethertype Unknown
(0x58c6), length 68:
        0x0000:  8dda 74ca f1ae ca6c ca6c 0098 969c 0400  ..t....l.l......
        0x0010:  0000 4730 3f18 6800 0000 0000 0000 9971  ..G0?.h........q
        0x0020:  c4c9 9055 a157 0a70 9ead bf83 38ca ab38  ...U.W.p....8..8
        0x0030:  8add ab96 e052                           .....R


Issue with more information: https://github.com/siderolabs/talos/issues/9837

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

