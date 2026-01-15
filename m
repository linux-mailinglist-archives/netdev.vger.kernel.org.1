Return-Path: <netdev+bounces-250300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF5AD282B2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43597300B8B9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883B3191D5;
	Thu, 15 Jan 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b="LraJKY/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B612BE7DC
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505773; cv=pass; b=TiGf+X+fgn8KB6qIG5CzdLhDSan+NPzC17Ug8/dz3KCAuR16QrBjtLEBchenrZlq5Tcrru1K9l3kMKf/jFdgDukkPc5dcsm6lq2yLo6ImMUgdPKL/g8y8lvXaKW9rbMyNPlYxS0a10ZjtOD707KJK4Xkd2GNVa5GDG+UNbWL8PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505773; c=relaxed/simple;
	bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Tqui0i1RGSNkUyjxXcECkbiZskD1u6roMGfMNUX/djLypRCLz967OMA7kaF7Vb3lH02ixQFQUH9Y6iI4wS69R0OLE37dVci3MIDoxg+yBQfQLf5rUQ6iQAXAAyM+xfN79PPrr40OIMXwzhqQC3wPVXpnUcrsIZYxIohNczTemvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org; spf=pass smtp.mailfrom=oasis-open.org; dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b=LraJKY/+; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oasis-open.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a367a1dbbso19176156d6.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768505770; cv=none;
        d=google.com; s=arc-20240605;
        b=KT9M9T1eDMbt7xKaSNnVgcwMCbO829fU5nszuf2yHneFeL3bgx1AdzNXmhCsi7+YKT
         zi+q3sWKJAVpmZ48ZfHUu+PwswJwBIaRdvPI7ABc/1xZG+CBh9MficvRaZqI2/WJv9GT
         T3HLLu55C2bSA2EvBSlAUyfj8Wr6vV6sqlSEyogaOM+prQDftMQoGDZYp8ARb7g3I+QJ
         TGYE9t3sv/oRlLCljFzsl6dkvK9aTkZUZgaGOrxmbbdn0D9tOf9Zt15YscO618n3UzW6
         bfy3EpgGPVhq4rUTOH61FM9jQ2gEzoJo44fLeTPYNDIqrd/Gv20hWLO/JzB/v1qUdQ1V
         MLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=GI078Fy8uaB6AiFLNggMUi/SQbHErXQSLWyGIXBTr3avXIMiYDfFO3nIMjerKes12q
         mZu+tUIL0RSV2RCGQUeUUhV93rs4TVZt3T1zsnDLd2qGV8xopu8BRTKoh2MxtDalOgdl
         URABW0AWS2KXFFq1WtAwxb4dHdfeIr/RAxqWOKdR4kEEmpLkbHWxPBWSBLaStdc6TgNg
         +koGiEA6uPL9fmC0G37EQhtsfk+OYzYofSdo1LeCQ1oSQR7iz3Ot0DI4QJBw6r37Da4X
         ziGqoF9N4YN7JFtdkGuPlPqHUAkBZT+GHz7Vn06cqvdMsD4DEarRkwJSS/0TIxr4SKc4
         9SmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oasis-open-org.20230601.gappssmtp.com; s=20230601; t=1768505770; x=1769110570; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=LraJKY/+FLPNC8SkLnvrHP6hSEAkF8MgL3dev5Q1K2m9mcXn6jyqkLCjo+Ejfjgx78
         NcT/HqPb9FrVO7bVoTGretk9XxgTfGautbdaC/GZHx5wjPtbKTRB0YCwa3byEQ8jSD/i
         BPc6quji3ezDWvS5esQgZv4Pc2uQmkvZa0WiZanYwacvFNryEG6WtJ4pOi0jKRH2QulF
         Rnu5rlbZZoSe/2W3U4CRii/xrhaZ1IPOmNlpHrY6Wu72jL4xbCFL+xonTku92CYOCBhZ
         9etbTqv8gbAApy0wlooeNA4TiG3UCIkyENUUG4Mi4uRafHNeSElnUP2AL67cb+8SxS78
         JuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505770; x=1769110570;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=jJvcu7tQTgEOfx7TTwDoUIPAbkruyCZRaxqZ7xyqGw49xCIgv4d78nphEzxlfEZxMj
         ysSohOJpVfWvlTXLTaXzP8fbEYXwAABemJIs5boWtZy1MviI7nRGLvXJ0kMIrUcSUz1I
         ghmKZ6CaDnnMhxhvQAJ+UaB16kjpIL3i9ZtiG8sxmstaJgVE/ahR53opYlrmpo7G2jzF
         Ck+2HDGn5iJfIStRUkH6QCphV+sG2k8yxEQYY5S2rmnWCVbIhVrHXaHV6J0aO4qyqxM7
         yYbXGOy+cl0bHrpVAlR24eYRBZT/CYijjNMv//Ida9U1GboRcC0+y4y13v4pHggtRD7Q
         pWuA==
X-Gm-Message-State: AOJu0Yx6lF610oHVCoLIxvr9rLAj+MOP3X6ApMkj43rZr7n0uWDn69oi
	qnep2Pc1euAE3iqy0rkQlPce0QtAVTgwEU4avdIGm6zq2XK2P6nFob4J+46XeOJLtqAE3vUWu0o
	tkiOxfuzQ/C6LuULWl9Tvr6WiSTmIXSMoegd4bUfL6nS28R4PWUMINA4=
X-Gm-Gg: AY/fxX6paI95Vy0Wqh4wzSO+Tp1X5yh9x7dhFEX6K6D6NThP0YvIB0cD2WC8vO9bmGn
	3EKJjltXUUgRUHabawybgnFRuScWAjDoSHMdk9NXV5XcSv86Qjssg773p8FOZgBHVplwAYKNtvl
	M+/VqcUcOxlf7UgJqygGFjpbGWvKmWCrS1Ze8aRhx904RO6cKbe7HnnmdglNt9RWg1sQcDt9ejC
	NousCy6hb7IIlZW8Yoj+/62FHRsUD9ARCRSlY+gAePRcA4buGw1Gh3YtwqyUkKFd6UXcg6vy4fD
	CncLpreBmyXWM9lFBC35oMbNKQIyvxDGwXsNmLOlpfSTd1VDKPJa9FfMfrkJ
X-Received: by 2002:ad4:5741:0:b0:87d:622d:dd7b with SMTP id
 6a1803df08f44-8942e41bf9emr7694526d6.1.1768505770158; Thu, 15 Jan 2026
 11:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kelly Cullinane <kelly.cullinane@oasis-open.org>
Date: Thu, 15 Jan 2026 14:35:34 -0500
X-Gm-Features: AZwV_Qj6FROjwnOx0DRRdNg7214DxnD9Erx2FsnVFFXhk2Yg2j-AxfJKJY5FLpQ
Message-ID: <CAAiF6017cLKgnjCSshSKqWzk72ruAQeWKbSCVZov8+cXW0C60w@mail.gmail.com>
Subject: Invitation to comment on VIRTIO v1.4 CSD01
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OASIS members and other interested parties,

OASIS and the VIRTIO TC are pleased to announce that VIRTIO v1.4 CSD01
is now available for public review and comment.

VIRTIO TC aims to enhance the performance of virtual devices by
standardizing key features of the VIRTIO (Virtual I/O) Device
Specification.

Virtual I/O Device (VIRTIO) Version 1.4
Committee Specification Draft 01 / Public Review Draft 01
09 December 2025

TEX: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.html
(Authoritative)
HTML: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01.html
PDF: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.pdf

The ZIP containing the complete files of this release is found in the direc=
tory:
https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01.=
zip

How to Provide Feedback
OASIS and the VIRTIO TC value your feedback. We solicit input from
developers, users and others, whether OASIS members or not, for the
sake of improving the interoperability and quality of its technical
work.

The public review is now open and ends Friday, February 13 2026 at 23:59 UT=
C.

Comments may be submitted to the project=E2=80=99s comment mailing list at
virtio-comment@lists.linux.dev. You can subscribe to the list by
sending an email to
virtio-comment+subscribe@lists.linux.dev.

All comments submitted to OASIS are subject to the OASIS Feedback
License, which ensures that the feedback you provide carries the same
obligations at least as the obligations of the TC members. In
connection with this public review, we call your attention to the
OASIS IPR Policy applicable especially to the work of this technical
committee. All members of the TC should be familiar with this
document, which may create obligations regarding the disclosure and
availability of a member's patent, copyright, trademark and license
rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose
these if they may be essential to the implementation of the above
specification, so that notice of them may be posted to the notice page
for this TC's work.

Additional information about the specification and the VIRTIO TC can
be found at the TC=E2=80=99s public homepage.

