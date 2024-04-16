Return-Path: <netdev+bounces-88393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E508A6FCB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AFB2554D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE943130A65;
	Tue, 16 Apr 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9WEGA9i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3ED130AC3
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281363; cv=none; b=jBk9ijIeDAePDryCssdOcU0j6uzdK/kT1vOmGvYJwWVElAnHXekQ6CFqjIIE5+HGaLupVqpYpu3wP02T23O0TvCwhDdzUvDqmoxo9vt3rZdBMSInLrTGt65vugLKmCl3v7piFIoj4LpELL8i8oAiFHpjEiKk1Bg58x+CnTQjUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281363; c=relaxed/simple;
	bh=81l9LahQytujb7cMyosnjzKZfq+r5bccBitCOg1Cmxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNr+5h+toxD0Cyx0YOItUmUGyvXKi1UF1dcByvxDjZlhpQYj/S5KBjH0eIKiSUbG2MmkDm3wHsNsoc5PNjLaqEQDQ4KS6jvZBeHGn+bps0/JDI3lRJzBy75Ey8AiyX8DD5muxRAv8mHUZmGPcQwGnqnuvx6Bj20DE02hq0qGs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9WEGA9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713281361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MxeNWUp9JUwY9cuS12LnzHtAblKzNIcTzbXO97988qc=;
	b=S9WEGA9iE5sw935rEpcNI69sWFrkalK0nv1I1Sxy7YWGDPFcci3lAmWhWKYj6cxZ0D8T2t
	rk/mdA7xXsj8VHjoPkVQe7fTY9KxzzIslmCRkO0RpMw0I1idslON7C+E+XFHFyxA5/gNw/
	FwamLfvByKRr2oNWfurJbNxWnIkSlrg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-qkrNJ_43NaaKkcgpa7LmEQ-1; Tue, 16 Apr 2024 11:29:19 -0400
X-MC-Unique: qkrNJ_43NaaKkcgpa7LmEQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d884b718f1so41097551fa.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281357; x=1713886157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxeNWUp9JUwY9cuS12LnzHtAblKzNIcTzbXO97988qc=;
        b=cNiiF7fcK+4OsKSu1h6GKP35nvmec5tFEH9k8jNuIJAs6FiYZEux4/gv8UFXaFmLEu
         5TuXUKYCOTRdUSSyRK3y+uGYDRruKCfxWB1mL4CDTpAMMfyJuTiw4BzB8i+P1WnJ6K1v
         CuxCqIFPrF7oOD3V3TLrOH5goNw7/QYMTlp8XyQz85LbABmMmFfipfIFCnZKm4hlTO1F
         xnF6ldLUDr+Lpbpt3h/Jh6bpnWq00OSD6+1ROSABgLxhulB2X8SDdhz/twyZZic2PUhk
         r19WFBiZl9MVZ4Tpfv8zHltQCJ6iAMmCQa1Gwepfk1fHnWY7a1sb7YQNu+KKG0ywwGe0
         V2DA==
X-Gm-Message-State: AOJu0YzXAfmuyvhdo2MAy9bHYHwHuUSNFC2iVyFyAqjSHfRdbADYnv59
	YGc4UPrAQKb1j72JoQU0HDjSmw1XDjizBFriqAdfiIpIG8FET8nvY9eXYlEXorwpj7BjKQh5p47
	vyqK7SB4OQ5i8nQEGRNmTffdSZhKIUucSTPc1FtzKCxzoPDYkdSa4l/063zO0cw==
X-Received: by 2002:a2e:b8c4:0:b0:2d8:10d3:1a0b with SMTP id s4-20020a2eb8c4000000b002d810d31a0bmr10016693ljp.39.1713281357093;
        Tue, 16 Apr 2024 08:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa0/Mtd7fT8GMCt99FDYYrsTJTdiHZDQfVgiPIlVTRCX5bZs8q+LO8aep+PkaKfMhdbxmpjQ==
X-Received: by 2002:a2e:b8c4:0:b0:2d8:10d3:1a0b with SMTP id s4-20020a2eb8c4000000b002d810d31a0bmr10016667ljp.39.1713281356669;
        Tue, 16 Apr 2024 08:29:16 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0041816c3049csm14695155wmq.11.2024.04.16.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:14 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Tue, 16 Apr 2024 17:29:11 +0200
Message-ID: <20240416152913.1527166-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to improve cipso_v4_skbuff_delattr() to fully
remove the CIPSO options instead of just clearing them with NOPs.
That is implemented in the second patch, while the first patch is
a bugfix for cipso_v4_delopt() that the second patch depends on.

Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
https://src.fedoraproject.org/tests/selinux/pull-request/488

Ondrej Mosnacek (2):
  cipso: fix total option length computation
  cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options

 net/ipv4/cipso_ipv4.c | 80 +++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 21 deletions(-)

-- 
2.44.0


