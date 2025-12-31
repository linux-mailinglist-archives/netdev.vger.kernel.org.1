Return-Path: <netdev+bounces-246449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8025ACEC68D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 18:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E54302E157
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2562BE642;
	Wed, 31 Dec 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PeLjBzk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090C2BE032
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202648; cv=none; b=C2xTsA23KRINx3pQgi18awYkeYuOPPvvLOLncSvcvQRAAOM4sbNDXRAhNrQyw6cYNx1ACwlG2+nb7nIqzf8jKMQj4USeh9P2SvEpSOba2iSmrEWEVvhedbRJHwfxX8rlsp89AQg6hCqrVcTQhkzYeOOT9c+o7gf9ub4pFnC/Yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202648; c=relaxed/simple;
	bh=WVYQGhpSvliDxHIS3oLwubflGM55eX6MoNuxuho0+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU4PeM+S9GxLOfHxOiGRqytSW5ntsGRG2FaEDoGBVVBy9QzI6qbU+I9uAe3t/QnbMbjpjEK0tGgP8eSn5bL3InhIrqUchoMdH6C++xApyOwaI+nnT8W5H8U4VmxDdDmz73feGuFcHkyQkzzP7dZq6CFdKMflGTxfPhPk/T11wUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PeLjBzk6; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b737d4cde73so77937966b.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=PeLjBzk6HD/l348HM8MLW1j5beEB21RZ112O4uvyZIZLMA55gblkaKZ2+Mb91hFnY5
         3xyXEyfKbkFaEORoDTeGujBGvo9Mgde/bR0k4fKNzUS85UwkKgp3W5G4IWKl/0Yt8686
         aGl8ymFQekBTdTHyUb7uPi+WekMbyjU8IfBgsPor4YDI1E+PS5EKR5VYt4xEARUdsEG6
         Cb2SRjHTdMhPk5pvMjOOO25PIByS+KZaJmPUfT8OTpglbwB7dzhmMz9mcJNd0PEjCHyK
         ETY4LqgN3btjlMPs9EUGii6evKaTJ36XHobXs1b3Ubn4MCXySU0QB2d2dDRgXN3fWOaH
         r36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=v4Gg0Itf9KVjpO/ERbwv5Ceo42MMBG+1M+buNsWEFUVdXIytkWhubRa8rGqYPgktEv
         FH9QmeGVv3oTfZL31booTIGHZI9uqOj70vJQdiyqK2OqbKESkQPX95jvarNs5FLUKqR3
         q9Ml3C5RYVh61EL4HYYNLLuKzG3cCCzjGCiYugZT9DFwFg1s7p1ktA2ulSJYxAJC3BUd
         iyhGjNBP+9wLSVvaUmoQ6ae70uVz0tITza7Mm5Gwti8rohH8m53YrjAFNcKKKiNL+m+W
         NSFKelkIedT/MUVZWekYoZ4axgdaZCsorOIhqugJeCU+/QoqNdZf+ty7FqFcyLpcSzMW
         0r7w==
X-Forwarded-Encrypted: i=1; AJvYcCVGacxu/MPxM4N7nx69a5LV0oViQpj/XXPn8/TRksC5hgUvkjDnY3v9x7zjH78pgXqr8BQ2cV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Kf/Ad+K73hlWYqErphCN4wJGLGcaM3InqaXq/RUO+DDohCoG
	D5W3LpyzmOZYkT7VJj/VDNeLlaOMpP/fKVoGaLDaeAqoFn7Yl3Ev8VKEvrLwqJgpRCM8dxJh7GZ
	kfQ0/N2aNp66EbX3efY6FCFzqBxKFfgZ9FbMB
X-Gm-Gg: AY/fxX71x82xbYwLXAsH5cNdZLP6ep/lhGTZFDzD7qEv4JukKA9Qk8mDDXfh/gT+ErI
	MEm0IMk0QBYFWDlGWIaPuy6LxSvk0dtT7IxUJBN41O+bbeucwXuEMI/3ahrdTsV98Sg9rH+n++y
	vqiNL9eO7EoZRKw5fKOCsRKzyxeFQFP2YlH/ikU/+G+k4dHxvtSegqV3Q9n8SD5s/UGyMUcshpz
	GVqxBLERFJJNSuyazTA0Sdg/x8zNheynjt/yD9fYn4zRl8CW0sYpkmjFiseNIhUfsqjZq6CNFxJ
	GyxugGdFnrJx888PunjjBC3bR6BOKowP5jjBOAxh6UOHeuLQba8vorMzjvJ3UbBeBbIlrGzwXE7
	28IO0YhI3kmkfkLDBkqPbFgY3RihCnYp63u0cKaq0QQ==
X-Google-Smtp-Source: AGHT+IEi03ZQZjXAnQiEZTFYKeIsY3RuVDBYnomwpJqWJlLI46xo1bUhyzXBcQMLZiL4Tr8s0Id0tWh610wS
X-Received: by 2002:a17:907:7209:b0:b76:3548:c34c with SMTP id a640c23a62f3a-b80372602eamr1981571766b.8.1767202643158;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b8037d637fasm499254166b.58.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA50C34076F;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C307BE4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/5] HID: bpf: make __bpf_hid_bpf_ops const
Date: Wed, 31 Dec 2025 10:36:30 -0700
Message-ID: <20251231173633.3981832-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __bpf_hid_bpf_ops global variable it points to as const.
This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..30ddcf78e0ea 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -286,11 +286,11 @@ static int __hid_bpf_hw_request(struct hid_bpf_ctx *ctx, unsigned char reportnum
 static int __hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, u64 source)
 {
 	return 0;
 }
 
-static struct hid_bpf_ops __bpf_hid_bpf_ops = {
+static const struct hid_bpf_ops __bpf_hid_bpf_ops = {
 	.hid_device_event = __hid_bpf_device_event,
 	.hid_rdesc_fixup = __hid_bpf_rdesc_fixup,
 	.hid_hw_request = __hid_bpf_hw_request,
 	.hid_hw_output_report = __hid_bpf_hw_output_report,
 };
-- 
2.45.2


