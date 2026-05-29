Return-Path: <netdev+bounces-292941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAbrMPbxGGr4pAgAu9opvQ
	(envelope-from <netdev+bounces-292941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DC5FC30C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B832303111F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61E365A14;
	Fri, 29 May 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPARQQF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC73624C2
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019396; cv=none; b=GO9J3dN+DmH4+wm2N2D/IrXIh731DzCKUKuem69153zgWalgj8gxvgXz6oDU5wcSI3wFIUQ/ICtGQ5pyMdkkH3Wi0lj5UV2YZ7dpAJBMsI2S3EMmaybZPD9lH0iWrdTMiI6vsTTo8WKFXOn429JWdRjyl5AP3lxKfHYaWb/Rse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019396; c=relaxed/simple;
	bh=QdNRFe0vIqkka4xbbVpTimo0ga8a86tcP8wKsinRgWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEBJLMiwzJ+vZa8yzOkmNTmGotuGty/37sNnqQ8fbeztckVb9NqXzTAKrsOz9W7INreHoRh6ZZchR8jigxvHAVkIj1N1fyQ+mRk/3uovtxggP75oGoGh9hVO9kO7nghVWBuNGmM9VxWQMIEiMI937BuOpACXJDdSTM4hUFba6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPARQQF3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso5461638a12.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019392; x=1780624192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=oPARQQF3/3WRBn+7e7KDPOGGRjbFpEi9o2xZ6O07RlOZyx9ixZpA85uUy/AwH3tLhN
         92K2UC4XlCRqz4FJU/zsCryq7LEVrjnS1wafgN/5KY1yRuR3cPzSM8+x2JSx05JPNFAo
         3VlqRjGhZeO4uy5i4lUJclBfsRBx1g5KaBlueKvMN1IoyCcOdQB3ZACIqrVJ4O16kTYp
         YEZsN9ZWb2kdNZbV3VZCLNMK82Q1RzAE3zmS7TV8SKFIs5YnQT86KaHK3wMRsVYZeCs4
         5tSdMWSK9fqKGFEjbZpQQzmjfA4g/WagIkv4EqzERXyGCBW9LizHgSoE08R4SEhR3QVY
         mrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019392; x=1780624192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=bA/6VmYV3Aey5UTCjGcx65+LZCkwZxPuJurymJBDVcrfjSqQe5/2IwOfdF8M9Q92WP
         6JSWDiixK+aOyu/jyfkJd60x4Db3jhV9boqygxg/VRbfuS5KUsZI9zXgeyHxwLK7J9nm
         MgY1TxmXXW5vFgGUVPbtNd0U4QmJlT7AkbKc2MZ3wPF3qkxTxzxjdd5oY52lqsWWj0ep
         eZyJM985w56SCIF/UUe59bzSX6CuMWp0C5KCr88UGgPlPZ4immISX1aKlBaUI3+pQhAf
         xwf/5UHUun8bU/IcRmZX5iSifwCCdfHWcznk+09HL4imdQlQe557dz2wpmehLWqk0FFu
         J/pg==
X-Gm-Message-State: AOJu0YylX+Q62LF2pKNPj7Utn6Mpg4hUxIOxFxfWbO9Pxu6Meq89Pbwk
	etTJFRZSnDNg9mhBIZdihshFPwoBT+SFvEMCCgQJ5yJh7JgA3+1TQuBk
X-Gm-Gg: Acq92OGV6EgnkZuB/90aLMeKaweAUf/4lqrA+oFy5t3pXk2sa61EHYl8cl0V3TKmUN1
	uyG09TIarvBgD9O2DpkN1nl11UsKC9VchWLK8NKchYAsIs04O2RIG7DnSycaQf3HatZUMz+Wy+L
	dYBLCKk64GS72D0E6lVxoQO6lYrq6oLCwDi6fEuGskfsE0XPOEQAv7XtDAg4kQkomlI0uz7bYV7
	F4UFOwixQ11Xm2jQ9vEyYsvKhHvNU9ZIRBGsV1I1YfGRhiCshoNEMHFIwekz8aUrpMOwT/otw07
	zjknb/e8sG/EO2dYKdt31sbTdRUjQ+UYw44xJcLA3duPxcVKrt1AuuRE9YmMWW1FHxyNaOqWuoV
	yqxwmubjxPncDAsJx4lt51BqpaNtN5VcCAbattRv5OzeUsRgq5H2MIgsTX9+GWmWFBe3hoHNCTz
	d8HuFiBPYWLmfQ1xnCLLCM6/U=
X-Received: by 2002:a17:902:f54c:b0:2bd:7ff4:ab0b with SMTP id d9443c01a7336-2bf20cec053mr11149765ad.39.1780019392139;
        Thu, 28 May 2026 18:49:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fea7sm856715ad.29.2026.05.28.18.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:51 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Thu, 28 May 2026 18:49:35 -0700
Message-ID: <20260529014936.2811085-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292941-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 654DC5FC30C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 0739620dea8a..d5fae5e4cf9a 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.53.0-Meta


