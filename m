Return-Path: <netdev+bounces-221355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9DFB503F8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6836C18987C7
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A031D364;
	Tue,  9 Sep 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="YsEuNfd5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F733168FC
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437248; cv=none; b=GfYTfEZHhORfJtFFaQOROZ4Rt93uSnAkk6R+i48TeSmNY2xB1Y+HVwfUIYpBJ/bHnk9xxEKZs5o9qxUagoXH6e50NQUfdVPCtp8fQJIfxMqdpU54DATnoUnEEAtWkwFv743vkjK2XMXHomujfPAzPQgR5Vf2D02uk3S6EV6ZoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437248; c=relaxed/simple;
	bh=XSIeSj830pAxnCxixhDk0Nl5CbpbAkt71UxFRmTYnKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHL9QbnI1SBCLL5uUQ8c1SwdSqJCkRAocqndw/XIKN/oUhbh1b2PIqXYWp6qOr6U3Z3tlI7ktlPhQfeSpOs6RiGMeOkeWTRiQhiXgYAtpY74rOl2MgIr00TN4/9bhKGNVFycEycG6dTV2Ea8/5oB1bcIUjNjyp5akCKppFhKbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=YsEuNfd5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4741e1cde5so641832a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437247; x=1758042047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsHf+mfrEqPsUFC8Nq/mEkzd6OpkJSukzvgBl3SUnPY=;
        b=YsEuNfd5Xl3sQ3UN0RQtd1FviFcyiwTZXD9+8tJmB24+YVYISX/CvcAJm5aueoSqSB
         H/qH+Ilw4zGOslIcKqluzYXAX9mgKsd5MkLTdmGbMnQyBa12Ye86Zq8XsAWfXS2+m0sx
         uQC1UfWOXnaZSa/US16Rzp6b60glCvHJEYTe7WUwhFnk/tf1siFVp2RZpPyZbLZNHzF0
         r4nPQdeCu/A2/U5m5SzWjV0wvXy9QMoJE45Zqy8UnBkO01XJB1JxdKZt+OW3Is+Aj6AK
         eZAtm3ksKT94HqFv4rGPV9/AOLEex8Y3Bd00Nqereqwykf1IzU97alcJI9YuTbR+35GP
         rwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437247; x=1758042047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsHf+mfrEqPsUFC8Nq/mEkzd6OpkJSukzvgBl3SUnPY=;
        b=DnsOUOQxjQMDnBSHympQHdJ4yJWEzhhFUiI1cmGznjcmmbC4k7zRqlVDdUX8c3gU2P
         3d30G5wjHn62Lp50+Rwg7otKFkNUXCTX/yxAS62K0qxLgQ2wn2o6oySRNRZN17KN/ycw
         XZd+5Rkh1Uw9jFG4Rt2Rxa2v2QPUX3vAkyzhtLrEOC90ir9D6imhSi8fp5nfNQjcnixY
         Zn5DBmXEtNsXML8zB5JfbBp8gI1OcTncllZfBbEJJ+TqsfrIXYYamKsFAY7IcgHu4N7x
         nRg9zw2noRRXlBnLeVe0Dy4NPjSXxdWZwf/PWeDAghXWTcKWiD5PNOcQmUmYpDJPIIGG
         aZqg==
X-Forwarded-Encrypted: i=1; AJvYcCVCUPoReUxEjUI6LLjzYqQtbwoHFKyiOt63Q4CITHyApWzkgLg7NueKsfT5qrhRKdAybrclSao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxbeIW79lzx0QzsqGI0HEPLAA+7PXjhOMEwnE9yZdKFov6VmO
	9vt8cGNqyK0TWrKBYrGdqslwFMicnL0Wy9bNLG8h2QGjQU/ZU/CM+01upXNVv3ChqOU=
X-Gm-Gg: ASbGncuUh1TLrgNu8dZ7K2LZIYO7BTg68LFbW4mUJsqBC0Sm6a3TfxWDA3N5qEUf9Jy
	Lr0VL7wxN9lQBrWGWkSFIxNQKRC7Sfq/2Bwvsz/bY1HXTj2CkMGh8f24/slZQErpthrTCtmGMPs
	3Z2E0f/DXVkrgBp2z1GbVjLCwLr2uXFLDRu/H7cC2HvoBocrtbLoF7RwIddd50aYVtXZx2dRQEq
	PYYlZEe6O2iRprLs2nfdeRT+iaHMw176uDgrJK5XZovMPeg+mrrSRl+ymOi9E9UesznUMUO4sb0
	pmQTxmaZEeaDhERzBKfzKN5F3VliHDmvrP8g4N7m8T0Lqoqz2D6P48An9PUqUkYSS+Ah6VeHxg8
	Af5OA1BjTtiItC0kdX83PgT1Y
X-Google-Smtp-Source: AGHT+IF3E9uQjdLgpvgZaYRlWuAMi8DPv43HfG9lBWajz8EXFCmchbRVuFfhILqZNgr5NxDQ7IMBUw==
X-Received: by 2002:a05:6a20:4322:b0:24a:3b34:19cb with SMTP id adf61e73a8af0-2534441f6cdmr11018360637.3.1757437246794;
        Tue, 09 Sep 2025 10:00:46 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:46 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 14/14] bpf, doc: Document map_extra and key prefix filtering for socket hash
Date: Tue,  9 Sep 2025 10:00:08 -0700
Message-ID: <20250909170011.239356-15-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation explaining how to use map_extra with
a BPF_MAP_TYPE_SOCKHASH to control bucketing behavior and how to iterate
over a specific bucket using a key prefix filter.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 Documentation/bpf/bpf_iterators.rst | 11 +++++++++++
 Documentation/bpf/map_sockmap.rst   |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8..135bf6a6195c 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -587,3 +587,14 @@ A BPF task iterator with *pid* includes all tasks (threads) of a process. The
 BPF program receives these tasks one after another. You can specify a BPF task
 iterator with *tid* parameter to include only the tasks that match the given
 *tid*.
+
+---------------------------------------------
+Parametrizing BPF_MAP_TYPE_SOCKHASH Iterators
+---------------------------------------------
+
+An iterator for a ``BPF_MAP_TYPE_SOCKHASH`` can limit results to only sockets
+whose keys share a common prefix by using a key prefix filter. The key prefix
+length must match the value of ``map_extra`` if ``map_extra`` is used in the
+``BPF_MAP_TYPE_SOCKHASH`` definition; otherwise, it must match the map key
+length. This guarantees that the iterator only visits a single hash bucket,
+ensuring efficient iteration over a subset of map elements.
diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00b..505e02c79feb 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -76,6 +76,12 @@ sk_msg_buff *msg``.
 
 All these helpers will be described in more detail below.
 
+Hashing behavior is configurable for ``BPF_MAP_TYPE_SOCKHASH`` using the lower
+32 bits of ``map_extra``. When provided, ``map_extra`` specifies the number of
+bytes from a key to use when calculating its bucket hash. This may be used
+to force keys sharing a common prefix, e.g. an (address, port) tuple, into the
+same bucket for efficient iteration.
+
 Usage
 =====
 Kernel BPF
-- 
2.43.0


