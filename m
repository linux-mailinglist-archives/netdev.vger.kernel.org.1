Return-Path: <netdev+bounces-245369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B9CCC5E5
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27FF73020CC1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE02C11F8;
	Thu, 18 Dec 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GGRmRRuW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163611547F2
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070088; cv=none; b=b19bOrOdNrIyr1W5JwQ+N/bvuCdIzXHXxBMVysWD2NcFZiPU7mhErXYJdFxwP4neQET1LjwHqbsqJuNmwOPdFRyLhviKYMaXuT1nBq2LZn+wuTXmSaceVMvwustY9YEQulU4ebfxwv70n9z2ilXAP6hQrk3OWR0YXpfaH2iQgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070088; c=relaxed/simple;
	bh=UFajhxek2FNDn9Py95rY2lNwEb+8A9xZgGln14cBtpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Akrc/VGQ5IKLB+fQJzbVDNxOe+I7ZJjhAT3GxT+10SPNJai0YkjbpZkUbdsfS+hW9XpNNyj4swf0o/mrF89cReSlNdE1uHxbXEtWlW4PHNe4pSyLCQ5mM3OYKEf8eURx3T6iMiFcgkHheyVFQ5/Q/l7onhLXvETxKUymqeMCek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GGRmRRuW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-455dc1cf59aso452556b6e.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766070083; x=1766674883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm9mnCL012TbnBQutLbQjHaN0bwArPqs3Yh4LZgZGB0=;
        b=GGRmRRuWt1uCnvw3sfYi2r5DHnq3xWxNDXMNJrBshCu1Itn7YQ9KSBB1NCd0xieRLK
         /aOtfEdlHUb20UmzI3jf4hlFObWZ0CApjrDy3lgTzUmIgfufDtSq5x4Jmp35Lk1rtgxc
         r8anUf0UR4L4GEuJ9xRbVSav9pFNJsJ/v+vQZNHd9M9r5kgfoxqNDPxSy2bm8gTdIHWw
         93D4cZRCuZ7Kp8wVYQ+yPr/bZJeDYD9DPeJJcCl1ShE+dAQ6BSTljm2iWq2JQyiS6bXr
         T31HqMOVlGUTgWV77VYNS4gI6BEMQufrh7LmpvR4NQ5+grTuHkwTXRB9v7QCmwiXYfKp
         JXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070083; x=1766674883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm9mnCL012TbnBQutLbQjHaN0bwArPqs3Yh4LZgZGB0=;
        b=NEydzSFKbjebC1oLwTyC5G0TzNVJd2NwO2bY+89uBU9UmMn/8034rTbuuq9K45e+4l
         SDRrc01IwvzyEXlvfdu9n7eeIDadvV8q7q5WXuC/xCFezgIAdCIFIR1nEy4+jAkzZ0ut
         n8wtjlJ7+MgYvF6TdCQV6jEmdc9QMo+aJT5ornJdQJLNI/h5v9seaSdQ/DSSC/usMakr
         1ypII0sDzHAMsvIMh1Kr/Dcfmdg/B0UlzrP0bKbKx5f/XivGVcKfy5EpITR5opd3kjps
         ITyzfiCVUCLGVKceDbu7cDFeFOnLJTn9KsFsLtaLd632bvSZYboLwpt5rI9ybjwP5d2+
         YlRQ==
X-Gm-Message-State: AOJu0YyAzD74D3UZf+dUdPE+e2KGXiFtRFBvzOXJ7Wwa9tVUKA+ocu9j
	JxPcix2xZRUMxJrVM/8nLkaJVzsFYqwC745+t0+ZBHQPkE2+GEIuPseVJsXTKGL+H/a6cQtGOWx
	0GYXG5Tc=
X-Gm-Gg: AY/fxX4l1nQlEx7vYIex19dT1ddFSczy1478b/Rw37NpbvtuAwrjQfCEBNdGKkIn68C
	b2hwD4xYeFo7tstbJE6GFyBjAQFme6aggvM3Ug9E38ur8qDE3w8hd/alVnlH5oILFCE8Yw4KkXx
	fgFad8yyjjlX8pbiaFMYQ5z+VQ5q6JrvtyQai8q0IozKuMGmz2pwF+xUjkfSvDonEo7F3sBGfN7
	h6i45oqdQld3Ezk280wG3n3ze+94bzlyrlJDpni2FBet8CTEgdcDDEYtdr4us9uzLdsATPQrZCa
	OIqaQhnfAqnAhqJvoksDxSp6TJ/K+6zViJY34R8Va1eYKJSOHStJzeaydNUh96rO0g7I/gs3hLV
	U2NfG6qoQJyKblBB9M6lC1ysJ7w6NkOgtuo+Q7slk/8sTKtLlue8KmxSUK/+TFjQ8JVmOrg==
X-Google-Smtp-Source: AGHT+IHaxVcFzsenzhTzxazrs7CmBAY32htAAoIyiiMXh/5fzHQwNh74QD3UxZLzFB8Ki+UIJ80VWg==
X-Received: by 2002:a05:6808:1706:b0:450:3823:b5ef with SMTP id 5614622812f47-455ac91d0a3mr9726287b6e.34.1766070081101;
        Thu, 18 Dec 2025 07:01:21 -0800 (PST)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a42fe963sm1327816b6e.1.2025.12.18.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:01:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	willemb@google.com
Subject: [PATCHSET 0/2] Fix SO_INQ for af_unix
Date: Thu, 18 Dec 2025 07:59:12 -0700
Message-ID: <20251218150114.250048-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We ran into an issue with the recently added SO_INQ support for
unix/stream sockets. First patch fixes the unconditional posting of
cmsg for io_uring cases, which it should not do, and the second patch
fixes the condition for when to post an SO_INQ cmsg in general (which
is only for the non-error case).

Please review and apply if you're happy with them, these patches fix
a regression introduced in 6.17 and newer kernels and hence are marked
for stable as well.

 net/unix/af_unix.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
Jens Axboe


