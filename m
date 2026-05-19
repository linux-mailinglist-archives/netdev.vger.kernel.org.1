Return-Path: <netdev+bounces-289576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD5OFLuoDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:15:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6258382E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C83C304F411
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC03446CB;
	Tue, 19 May 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKmJex/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCE342510
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214421; cv=none; b=YFjfVmaWLA5BqArX2XAUNgyrlVAMHaFDoYLi1VPua+oqw5ACUZG6da9Jg37OQu+OlfU3m1NjvGHO9UWIg3EoNK/WoVqzYlb9G+jEn+Lw6Mk4D1ZD3KXAp2veK9L+MctznMRKgb9n9N1t0TjQi8p5bCzW29P6AaBOThEUDGzM/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214421; c=relaxed/simple;
	bh=QdNRFe0vIqkka4xbbVpTimo0ga8a86tcP8wKsinRgWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlk+27P/mDnYmQxcgmQIVwIJRsVd3Zf+wPYxF34BKN5n1yusYRwb6fgOISV5OKKSeHZCd8qyjjE/rAwtsln9BI2YrBkb6h8TXqlQXB5o2M0ph0PRnDKHqq5yx8HcpjkzNmPHxpJ9TkELL0n4qYYq4d7MFX4USaeJCTIo5FUWIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKmJex/8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bde9d73678so37561147b3.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214417; x=1779819217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=EKmJex/8i1GBWWvXOPSm2HahWM4x41pa1zK9bkzrWaYgwpe43+lU65MutAupvqS+JK
         pbaSUgzx+p6jc1319wcqlZMbsgZC9FNvPua1z2jnWGrOi08r38aVswVTOcGezw+hBf9S
         IviGlJf7VUU3giDGdG4uyN7qkLau2DqFCzbOe9xbwwVIQKSSFaa1GieKQSH/2t/qaOmI
         R7uugDAjMXX7uBXdzw+dAAlZFZAMA2y6MPGaQ+kYwHEyrQTFpORVleOjFrGqiCilqxDo
         RSOHkhYw/C3Yw1a6nqr+E/a9t8z26GmkIGij1I+TNA4cCnoMh2dmlggvHhULZptG7G7e
         g7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214417; x=1779819217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlP5n46PN41L6jV72akk3EQSHatEAlv9HooAnPxWzak=;
        b=jsNdl/i3W3huF1An3lcvWEGKzzhZCD27ynZIdBtdPnsgzfXNg/fomsD9pJz+pmrRkM
         2hyvKzb/iGn3XWoyWYUKBQLM8oeiplhTbP8LjGQUMN7OE55SJamjP3A+Z+Nh6TInOxPF
         qAqXnYJDn/yupapil8LUNCXBUutTEO937QNnrwxC/3erSyQpjeOcjlDfld9pYxvjkCEB
         XJ3tyC/Yn0LzCoyg7RCjGj8px7AQHBtB38vBtoq5Ktk2jcrxhF929saQpzpEt9QRln7a
         VHERNm+hNcD10IgSogLHHkb+OfwOKzbljnh0aylqFh6S+8EwDmbuaZlF3dNP6j/VIdGn
         KDxg==
X-Gm-Message-State: AOJu0Yyf4TrQEvo6N1ZQAjh0so7padqTlf+vDTmotrD81Yz+Hu3p5jCA
	sUcXubv0BZLY3uSSDFPkIGk/W+S/K3Ynpqlst3CgzqME7dXrYppVyXiM
X-Gm-Gg: Acq92OHByOXvAxXMXljQKyNRoc3LItIxAZWn5FHynbg8cIufBRyKseZaoYswOtbyPT3
	Sz/dX983E/LoRsElqcOjI+eiQuwi7+WSnxBbJx0mQJVF8rkVa2rXj67ukMurKE+9mHT1uYkmyWX
	a/2JWSULI+qUQPpxg3FlUu+siy8p1VadScwQmI5Lt0Rs9cBOfN2giN07ME9bJiYDiZUl5yK1TdS
	XKKkfWO8I0tM16Q8ntPSWyBRDhkjLV+2np0pc+Nn9w8dhIpEFt9O5E3X59FCAvZIUDOT5OLAWU7
	pKV/JuqzCIZyFLxSQmBOXIrdS9LFB4yhmlb3U5W+69GIj2OYlz/fUOH0FriwBrj+LkH4wi8Fog9
	UvJRvYljyA0ABwz4KzKG/czXjsNglg1/ZVnCstGYq4MBniYjW8FD9hyHp0Oz85Twh7JjYOj0bLC
	inusygi3Cc0D+Iiy0U2lPB5DfVMedLQ96iPg==
X-Received: by 2002:a05:690c:c4e8:b0:7bf:1433:8f92 with SMTP id 00721157ae682-7c7e5d9034amr210208817b3.7.1779214417481;
        Tue, 19 May 2026 11:13:37 -0700 (PDT)
Received: from localhost ([2a03:2880:f806::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c6ce2f4sm40449947b3.39.2026.05.19.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 14/14] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Tue, 19 May 2026 11:13:12 -0700
Message-ID: <20260519181314.2731658-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289576-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 10F6258382E
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


