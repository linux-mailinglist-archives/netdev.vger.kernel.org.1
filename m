Return-Path: <netdev+bounces-226462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167EBA0B8F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004321B26CB2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F78309EE7;
	Thu, 25 Sep 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/UgMLe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CD306B15
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819616; cv=none; b=Qy7LggLynBSc4hGeYBV4GbtVe2QT0jmwyeZiouguMFZRPh1tE4BQDRewUHi5jlFZbWzLoh/GeNxBQkOcw/K+qrbSXJZqp0xzIHH6wFYdG+9xSYQqeVMsNdU7aToFyphhNm/5spbOEoiTwGzJE9etxdbDdi/nYD2bQO9xInLadFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819616; c=relaxed/simple;
	bh=SPvutgf/0wlSxzU/BGGR07xozaCO3CWXty8/w3Fcp54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtZ3+UgT2hmnh7sa1OOSDjhjbYXLgw96aqt7gPbv/tYND9DMupUOLk/KMOcIDjSqqcYmBqQPS4pmjsFpGBC+YfQ6XrPylTpATHo5zZzdvIeNDJSef8QCaLl1XpC+lmXfVjggiAIORSZ8d3ojXiVZJCidZYgU8Hb7i0rYaaViC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ/UgMLe; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54dc768f11so1030921a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758819614; x=1759424414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyDMrFJ10ozuZKJidiIpM+48MXCub922AW0orXQAw94=;
        b=dJ/UgMLesl4e/UR6ScLdpZmcKEUnIPFFeato/M0guf6lPfmPXEfaSmu9xFKz4ua5KG
         PrpbYqP9w6vvezHHoaRToOj7q3imKLy8bK5X7VN/WXLrfyrgTrlsUhA7faG3GIkorQWq
         w0HDyDgwyQIKFuInD/hb5e44TqxUAfo+7wtcNxKS6X633PcloZS51BRatf3uoC/sR529
         svPDukhNNTIQe7WUStYgrVfLodgn/C6gKcc/65HMyKzLs2u6zbpAB9RfbUzHQ+ohe41o
         3s32zzkVV0rhzMQ5PScijs4ToGUTaWJpApGRvUH7wjQ5EBI784bNQdjqT2lZKJgBYsx4
         0daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819614; x=1759424414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyDMrFJ10ozuZKJidiIpM+48MXCub922AW0orXQAw94=;
        b=tz0Gdfx0pzflGBrmLJyXMid/WLeLYl+bVxQsiaRUxpuOnGtjuTucXL/FYp+CrnLroz
         OgesBTFMWZ8UYoI321wLNWTgEq+zhzNEpASyF+Mtsc2tv50db0FjPQEUj7+6o1bHKvlJ
         iM1V1LZtOwJBcEVKMqKrjsOaF461z9vXxsMcEwqwI6if8NY8ofH3fC3jF/hbYmmmduRZ
         BRIL9t2bdejjaYiAvZZdsiKe4rM1Wm65Ibe7etL2ssALpNBZ9JqbiVcyqsKDW0Uk9h6t
         ysR061KUqQoMmD18RqihLIkXRC0xso8eP8EqJXe4R3zwAGIqUKGP+t/ns7m7A5EvXsF7
         3TIQ==
X-Gm-Message-State: AOJu0Yws5SXEsZAgHP/sqNbTZTEzaCkmMpjfAc+gv4ZIHieI5Qc2VSmr
	88oTJ+bPJfODr8y9pry1gDdr0bhpJAAVYWmnDphOTMBGgedqMh+qGzs8
X-Gm-Gg: ASbGncvselIlIrp0+sq00IYxYyQz2eRJMOc7oYKVOkQWhOybBgvCOXtd/gFkpy/fBTJ
	qp6fwxdM8vT9eykghH5Z0QfC5RxQHMwU7FSoS0411CC6LjKzo4rwmSEs0lAFixdlGo2i51Hd3eC
	SK1prg16nRmjvCeQWHz5JyaCItScUj9/4ObsFxpoJIJK5Q+Ie9SPazieaCHMhfbbfp/Wau5fT08
	kiecn4grLBRLapPjArPI9uY1WMFUlC/9+8JPcV6go5J6abSkeTV592wqHNia+e3efXqHe3itaTi
	72rgZXKPOkVI1i1aDN1l5rSlycFuhGbZzLyid0jX2DqpIfcgWb7KuD/PTb76fJOuoAfDvl3dR25
	zaFoczaHXQoJgiObM+hnWYyQ=
X-Google-Smtp-Source: AGHT+IECup8tv/RPmEj9LeHqIi9Nezmq0eALAm1L5tBiIgzTFrtGP33k18mujwoJhJTZsvz//a8CCQ==
X-Received: by 2002:a17:903:3d0e:b0:269:6e73:b90a with SMTP id d9443c01a7336-27ed49d0298mr42964225ad.15.1758819614292;
        Thu, 25 Sep 2025 10:00:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69beeafsm29744395ad.126.2025.09.25.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:00:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Emit struct bpf_xdp_sock type in vmlinux BTF
Date: Thu, 25 Sep 2025 10:00:12 -0700
Message-ID: <20250925170013.1752561-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to other BPF UAPI struct, force emit BTF of struct bpf_xdp_sock
so that it is defined in vmlinux.h.

In a later patch, a selftest will use vmlinux.h to get the definition of
struct bpf_xdp_sock instead of bpf.h.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b20d59bb19b8..2af0a5f1d748 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7439,6 +7439,8 @@ u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(struct xdp_sock, FIELD)); \
 	} while (0)
 
+	BTF_TYPE_EMIT(struct bpf_xdp_sock);
+
 	switch (si->off) {
 	case offsetof(struct bpf_xdp_sock, queue_id):
 		BPF_XDP_SOCK_GET(queue_id);
-- 
2.47.3


