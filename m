Return-Path: <netdev+bounces-288927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIFSCTfOCmq18QQAu9opvQ
	(envelope-from <netdev+bounces-288927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA084568CB9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DD413024A94
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A173E7BD4;
	Mon, 18 May 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO0o0eTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB553E4C97
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092655; cv=none; b=kmSGilcJw37Bz4K6jeHbjz1FzvBYpUcUYxq3Xk2mTmH7kF84ShWyzpCeNu3nabNzRPgVyUxwDzh+uhs3jk/Seuppc2BqPLliHDsAMWnOGYxy9/dgq7PHB1F2dblCKGzhYX53EE9Lu4KbTlJ0j4kqI0hSkAyWcpWdUhvEqhobWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092655; c=relaxed/simple;
	bh=DOfWH6hLKc3o9vRvYL5MSuCO1dG989HvIXld9/XiNFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epQBlkp12j0LClbJ6ocFE8zBoszylYxI8NRRNwF8FDCEpzyqSZqNofgudbwUeUYCmri9sr+p8oynkWCc8PX4KjCi5NAoX/Z7yB95NYxzFr3K5yNKoRhXfqL5B4tY5YlcKsRznhejbdy65DRqX1sWGujhzIaM4q+vMryj9raC6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO0o0eTP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so689473a91.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092654; x=1779697454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=mO0o0eTPa3N8fHbdHmiWgjWP3+npe4MPM60zDiziD7kqb1Iw0JK2DnZwzQ41UW2tSY
         I8G6Lvhcp2ACn0kHXI117LybXaOUHzlJtJz58Wfltd8OIE2r3pH8SLng9GAZ7gA2gf1W
         auRyO8HsEcqKJkGrGvBXOzWYs0ojDJQd4q3HdmwrWcJN3ovcgGgBh7v99CPwGYbs8vMo
         uflE+EVN5RAY5C90op/ZcQx5f2VbA7N42PD4XagUzWf9pSvtdfCiaQ9hyT/cs0XzcT5C
         1LzRqowhikY4FH5EUfc9s2iIDbOVygGU5mhji47vslZvH+chXhkvLAdb3V0xYD9bbSMZ
         Eh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092654; x=1779697454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=qu7cp0LxXg5lJcQdpjQ8b8/pxX7kyjuiRqb0uu+FLztYVocG3PV6OIMzHraQqAwyrQ
         +UIkqVRg7dkH39zV7VEggMsV+Hzp6ZxyLt+ZaTO059H7V7/EZ2LeWnsQltKKIwBZKBDF
         N2JwTIRzgtZzTM9y/bQuWRJwRyMNWIzr4FZ8Ll0iW7r66MduHkvLb33bc5zm5ieGNMuz
         ITKI00Bid31wlsBzx7BdqeDyuZxwECwhKwbZ0Tr7w6MZbVfahbKdeWLelZQhTV2nK9nA
         41Xi2iMUeM0RMXkX2gmsMtLIms1kPnsoqklKrtHxK29WaLMqcsHPSkMsoi3wH2jTrp9U
         nZmQ==
X-Gm-Message-State: AOJu0Yz7IqAybOHk305ccQd72/Sc7buWCkHGoCjufO616PeHxzPj2hNc
	hpKPQzWceJQqCJmznyt5qUqHlh5IgbQ4c1b6cuAVynCf0ceki4mIjh4a
X-Gm-Gg: Acq92OH9LdMCfyB4TV2sHDdSXNiagm6GpgpEuUexzgcMzvsBy5Gy6mfk+Fts9D7fOeK
	QwZW8D7LwgM7JY4NKU/tGhjIH4VIg7xUrfzCU8qrMtA1BbVg95uwm2cYxYJEtcfj9OUHFE1j/LT
	PFaGAwLOAM9XQyLySA2LIbd3FOsHOtiukX1Xm+KdbwN7zdVL5CV3ep2llCiAM2h/fACJk1NgZc7
	SMj5vU6HyPJ6hZkXXYtgBwQQ9FqcpeBHl9rqn53EOr9+6h5YKzEGr2RiflpekP27sghDAwYmu5L
	6cLFdJJU8DnOpYkkc85J8z7s9kZ0Bi5H1hhobH5AlCfwqfX/rOKg5JwW+Fuw34rf0/iscMMSRya
	AZJMd1zNsyCJfTVKnBFHAjB6v9TUaWThqEkjbkUozvFrrNCLlE98UPIv4iTSP7LlUSHXSuIEZt0
	uEfcdWuUAFPx4dy1Gud/87UVT548MdoTJULBj1ydelPfSoM97MnWQ+5tgIY++pcrwZ/UVAWUvW8
	K2LyM8FJBzFtZdyelVCBS6B5boHqw==
X-Received: by 2002:a17:90b:3505:b0:365:3154:7b1 with SMTP id 98e67ed59e1d1-36951dd55famr13420003a91.26.1779092653628;
        Mon, 18 May 2026 01:24:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:12 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
Date: Mon, 18 May 2026 16:23:39 +0800
Message-Id: <20260518082344.96647-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA084568CB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288927-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
populated by the network stack uses ktime_get_real() which is in the
CLOCK_REALTIME domain.

In the series, kernel reports the software/hardware timestamps through
sockopt and then userspace bpf application gets them and calculate the
delta only through an unified time unit.

However, prior to this, when a BPF program tries to measure RX packet
delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
is incorrect because the two clocks have different epochs.

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time. This allows BPF programs to perform
accurate delay calculations without clock domain mismatch issue.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..863645d096ef 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
+{
+	return ktime_get_real_fast_ns();
+}
+
 /**
  * bpf_obj_new() - allocate an object described by program BTF
  * @local_type_id__k: type ID in program BTF
@@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.7


