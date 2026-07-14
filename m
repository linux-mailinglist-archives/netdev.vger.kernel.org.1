Return-Path: <netdev+bounces-307546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WDllOvN2VmrY6AAAu9opvQ
	(envelope-from <netdev+bounces-307546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276A7579E1
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=YmKwBtKK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307546-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1CB303EF5A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD43F4100;
	Tue, 14 Jul 2026 17:48:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715234156DF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:48:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051325; cv=none; b=oWgQV8EZNHVzD2iqK8wBaoMc6V2C9/2eMUY4MTsAINX27kGBorSAL+PSKm6raRaKZI5bcCg2hWTFs+JcBROhVPbRlvDH3PXkR6X6useoDtbxutD43JSm+sHQZXpQe7wNdnokvVCUwzJGd3Lz9nCTybNYHxl53tM6sq774ECKeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051325; c=relaxed/simple;
	bh=8e6hSHdI724CwWnH0GaeVjz34PTzNe4kgTZ9OdXxjt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lmb36JeW1mi/xOAa3dUt9Xz+eRKl8d8I5hAVDwwoVkfTmlrtZDhkWXIXLnA9xh2WRmBRQ56aoyUIoRQypWHg+5aSgJjvO3gFmqn1CEyHDSYwDQWQoRUJg3J/9UqVpT6UBTA75JOJEkhImAtK0pwhDz7gZq0eC8jWGtWBAekHYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YmKwBtKK; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f365afc5aso1561486f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051309; x=1784656109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnbOgZY6mix2R8qxVZm3ntkswSOtMNcqG52n3byUMp8=;
        b=YmKwBtKKNI31nt33hUMyAvAXSbsDXbVKkqOG9+b4QX9o5ZROREIVRN1KmVwVJgJws1
         6XjDqu+l2e/FefhpuC6KyPz6Q9yxDf8gHXZgmXCJQfWLbeYrxv+i5FmTz1CPIHc0dW6E
         L0q0Jcj0IAfkgkaeR87T24rHxwSaqJ5WL74EaEqXfrlHqeaYDMGthn6KoJSul6Xe+Ht9
         jD+6TlcGxAX2Ory+wZZrpo4VWQ9VZVu9r2wog0A+/05rbYgu0PioiANnoNyxrQD9chSQ
         nMfLzttNTmZ5URRVXK/e6bSGthREbKtG1FsDLmMxhCxEgcTPN16qZBgUbJFqO+Ve13YM
         eHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051309; x=1784656109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnbOgZY6mix2R8qxVZm3ntkswSOtMNcqG52n3byUMp8=;
        b=QoC4OB8mhDvV+DHvi34B+J51mA3STTxi/tCFCthH69HDV+d0L5FVo12bJnfNl4WlNC
         KbCyjr7eGP6x2UQed4wmVwbljmjny0/xp6TX8SQ0R+k62f2C1X2KMO1b5DXZumEkARBo
         a3kYZQwO/ffxnczYs/EHmC2+AxHIe4eiZHsi0CGjsyeHni1Hzwbs4nktlxCi1MY+tegv
         gdEvhOV7cJOVszlBl57kPg0lXz8IEwyCkxs2c0C/CsZTfojWBR/skCJF78TVCO2TC0HR
         VctlmYY2bkDv2K2hgIyv2Dx0IynCYKGv7vLL1rJrgQHlsj2wxCsh2TvCCWG2CWs2EOpc
         5l9g==
X-Gm-Message-State: AOJu0Yx8Qb2TD3xgNDyi1UdSyrOrlQL2ThigglcmjuN9nnwzY4wF1LeO
	KAHjWMLieRiUYCrl4nBXpv+xa1zDNgWdHt0Tr/Cn+bpNPfvvzA2iKIno8aSHn2QMSTA=
X-Gm-Gg: AfdE7clKfz6+0brodNzepqU2ib+oHoNjcFs9y0gDVUSv0/Lfv3NjoiVxuCYlBAA7V+r
	FDRTOBS8F9ZhL26ylapl+Idpm0D96vGx/gE7md8h5gsGO3/+TPaIdstYYga/mdChS3fLH3DNOHY
	uRypXZUTEhjjKHOBSlAa109ufi8hMCXvvBHBvEmIfmYHyT555K7Y/U4mxADnb/REQr3We6DM9+Z
	b2SkMlZd8acZxH7ZRWIj3Cb3wSpARvXX3BcljA24qI6Amv1GA7ALVOQYAv6qsxhxSceP56rq+n1
	YlCDVIj/Fa+QVA+wZg9uAs/CNbtE/aGqJw5W8SHquqA/wtpy3hvRUMNO2Y19pugkdLo1hVZ2H0W
	SDITkDVXJrVU1Zx34YCSnPd4H9CuoBj4GrXX+j1PWZKqR8h8JmlVLyK8kNOfwhbeLUat98lLXu6
	MtzRbFAmW7z79lFz8ksSlaAKWgV3e+gQ0cTj5/rNJjvPVq0ds=
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47f4886edc6mr3882336f8f.4.1784051309376;
        Tue, 14 Jul 2026 10:48:29 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm10826048f8f.22.2026.07.14.10.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 14 Jul 2026 19:48:21 +0200
Subject: [PATCH RFC net-next 2/6] bpf: Allow access to
 bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-2-5871c07a8dd6@cloudflare.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307546-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:from_mime,cloudflare.com:mid,cloudflare.com:email,cloudflare.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5276A7579E1

sock_ops programs receive bpf_sock_ops_kern as their kernel context, which
holds a pointer to the sk_buff being processed. Mark bpf_sock_ops_kern->skb
as BTF_TYPE_SAFE_TRUSTED_OR_NULL so that BPF programs can dereference it
and pass it to kfuncs expecting a trusted sk_buff pointer, such as
bpf_skb_storage_get().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a78ef1e37f24..e10886ca5089 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5675,6 +5675,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5717,6 +5721,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0


