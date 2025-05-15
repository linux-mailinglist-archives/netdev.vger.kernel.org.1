Return-Path: <netdev+bounces-190794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A0AB8D96
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766AE3BE4FF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60D25A2C6;
	Thu, 15 May 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckO/i4QT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151325A2AA;
	Thu, 15 May 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329554; cv=none; b=OWPOe7hVlNnN8KV9RkJGsihYj1LQ1DYfvoBsj6uW2Eiwya/yYBEvEPkeJhgKrD3bMdmk6wLPC9KWlhK75m8W64cXAfz0iPuJhefjD7z9pSlhuRf+c67oAOV5UOM2BmuNo4cmxGPXyii/x7Ku7IETlw9eppEelRdpzVdzIJyqyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329554; c=relaxed/simple;
	bh=Zm8fnwR2kVtMdLct1namh/elgyXGja8J0e36xyNaBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWbv+fLe3DK15pxaV6OCtAsxzmKOR0xxArJ+kO5bmAi3AY3WOAUTTer+jT0h+F2huEokCLDSuMhMwSdcBBOv/bFuq+gLDD9dKX33/PtrzMAVOtYBf3/STdj2XujhQFPqK+YY7VQ8EVDqyUjOSVUJqccsORl6BuKYjnxZiDBWKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckO/i4QT; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4df4ef9c59dso351537137.0;
        Thu, 15 May 2025 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329551; x=1747934351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWrFTU/3aHvstH3XrJyNgWc+dUCV8UVVZ8Z4wBXwYew=;
        b=ckO/i4QT+3fjG8fFU7EQmapn3fxuRnA0TIwb3qmI6e961oHqP1Ah2mncdq8wjypUTT
         4AEN5q1nAq6cdzgQ4cFqUViPSKe49Rzwrf18m0P5bwmcQSD/d0o6P3GVf9AGaW8TMOOO
         AlhDsjA9C5wujhW7Kk4sCNY/2Vjdijd+MMxdYNxQA+K/EpiCmYDZ/K50gW/qiLkXiXyq
         ASGUTqQsWhzZ8FkJ2z/11VTal4E3PqgizBb7Iz7pII7uMMhIrMXut+KHR/qtR4VjCDov
         zEOBSvokEEokBhJi1HsFHWaWReuElOPM9RtQ5TKYqSpSHG3TmgmW7z7Tt8pq2IZiDAIO
         2Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329551; x=1747934351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWrFTU/3aHvstH3XrJyNgWc+dUCV8UVVZ8Z4wBXwYew=;
        b=IJkOWDKaLp6DYkpwvLAbALLH5xnKk9udGgpxdw/C+nlIMjev3/Zus6aTgwyVfCeNNF
         qWwADCMjqxZdVG6WRPG9MDb0KNd2VoNS23nbSVRFD1t2hGfH07bvi2abjeDONEH0v8/+
         HUBjEhlFs9LDhrtpCS9OMGeNPuJXfzHyEf0eAuYvGZyGybc/OsmOgLVzZPegnckIr0jt
         6S9V86SROjkbT/J+Mj8s/WpSV/QlVz/xASlUmjZxwX0nq1YyJQPpl7lQoYeqbVk/psAV
         /+o42YMPXU5jk5yy3hY5ms7pB6uDteXemH67uRMpOhq36fyTHR3IECD49jl0XqyUqd2/
         x9vw==
X-Forwarded-Encrypted: i=1; AJvYcCXmcu7bX+yQB8q9/9jklC31UvJHD4L9EJNZyjaXZFXb8im24pjpGkd7ovOjfFWrqn7VEkyjMek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgjAdtNTMQXEAqLJvKCDK0iN4ckTDShowpNYOc7aAocpy4IYy
	2fTdR4Opr4RaHuNTPpLhMjgjQlvGnmaThqd3If3w1jUCWWEGR3TKLdMWB5il1OrBJZc=
X-Gm-Gg: ASbGnctRgvXpnHN1SNeVZMhxwkH4expy0rCWm2biig5/Qzvy4CQIsmkS1t1hdDH2wsq
	Slq30rAeMKQm9oGWV0uLZFmuPQxGiE4Ulw76o5TVwCD8PAywo6QDXROdrdX16F9dp3g9gFLvtD/
	GwddVLGH57EGt/1dnxcoVvjJ7Lti1RitCDFvzSiDnZHKLYNFth/GWnLj/GVjo8oRjRC1Cdrx8Ph
	JkVFpuIXXZWuMARqFvvzzHcZQXB1dobCH0G0qGrV1RpkQvHim6dVRmdmj0fzM1Mak4Kkm1lYUHt
	R8CoroCdo6yuD7EVkM7AoYCqMwBwGg/iSDJSwZmRNkaNPNxUR9hdV6BVrU5wywDOKzaLly5hkDN
	6tXt1SWqZ2pWyjra2g0HZ
X-Google-Smtp-Source: AGHT+IEyZMlALMyUMTM1L8hl0xcy+0ntzanuWjaLa8weJHTCzRlikUVhdg7eBSceTqLtWW3KD6Ie6A==
X-Received: by 2002:a05:6122:da9:b0:52a:7787:53d7 with SMTP id 71dfb90a1353d-52dba8d9616mr955495e0c.6.1747329551384;
        Thu, 15 May 2025 10:19:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba9405adsm226402e0c.11.2025.05.15.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 10:19:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-05-15
Date: Thu, 15 May 2025 13:19:09 -0400
Message-ID: <20250515171909.1606243-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 0afc44d8cdf6029cce0a92873f0de5ac9416cec8:

  net: devmem: fix kernel panic when netlink socket close after module unload (2025-05-15 08:05:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-15

for you to fetch changes up to 4bcb0c7dc25446b99fc7a8fa2a143d69f3314162:

  Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling (2025-05-15 13:12:54 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btusb: use skb_pull to avoid unsafe access in QCA dump handling
 - L2CAP: Fix not checking l2cap_chan security level

----------------------------------------------------------------
En-Wei Wu (1):
      Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not checking l2cap_chan security level

 drivers/bluetooth/btusb.c  | 98 +++++++++++++++++++---------------------------
 net/bluetooth/l2cap_core.c | 15 +++----
 2 files changed, 48 insertions(+), 65 deletions(-)

