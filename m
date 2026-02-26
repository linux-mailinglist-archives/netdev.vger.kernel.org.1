Return-Path: <netdev+bounces-261595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPJyBIK4oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:17:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BABB1AF9B9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10DF3145244
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC26477E2C;
	Thu, 26 Feb 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f7KXdzwo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47854779A6
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140398; cv=none; b=IujlsIIU/R6bHa9BXgx/ttH/U5BRdDqMcRjWl0uhC67t15qxcUSNJK47bcLNGA0MbmIhlX1zJa5CsskPjkykQHSxtsuflgj6qyYWoV1rdWROshAP/1QWY+9ZtGLxju1eNHX839/H+IbKfNmCfRUjPP0JF7jYxBHJMT4EWLpNFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140398; c=relaxed/simple;
	bh=XbEkPZmmxMM06mfa4GbanySLFtWRautszz5kowh13Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuKRcDatTGB+XR3n8Ya7a8n4oijnGnpnD/ZDn2pMievq5Dj6ct2ogyCLZfMRJ4xpA5KZdFWrrYVkypc0UwAey5UqP9zMuDiA3vsDjGSVaer5nJyyRGqTe4nrOqI3uecMCJilTFSoqFhMpAwXKPyTqUdvtYEedSkuu9oVDElm0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f7KXdzwo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so1408892e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140393; x=1772745193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk5pjyiEM/wfnw6Yz5Eo6aG1OQbiuhAmToZFA1Fwx+M=;
        b=f7KXdzwoCYhxb4HBSfhQxzFSa/vMdq3Jwk8fHKtDvwiQcKcfW9B8OeqKmh5PU9YBhj
         LTv2kBRJFiMkLm3c3p0hmaUcDe4Sf4HJw2vy6QHvzEUl/QWp71Bup2ubPvaYA9jJwlNj
         qWq13Ay2L3XdnaLJHWTriF0pPEitefwV61PlHvIDM23nKbNhhMT0GEPk2TL/iSvFAJDR
         tlecEaLNtzyuRa6shIy1y364TJ5USV5uktybRf9Caxeu5COPR25mF6F//HYE8qtGqdCh
         S4F0u1Cwfy/V3fLmqjCoVLYMvH++k9dzq1EXR9THsNOIH4w8Apn/T6iqgbYxIyumNanV
         wDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140393; x=1772745193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vk5pjyiEM/wfnw6Yz5Eo6aG1OQbiuhAmToZFA1Fwx+M=;
        b=Eh4YijxBEwPlNPUXeTLG5Nm1Rhg4i5C4zfhueGvrad6r5Zm+ZSYMSrAK5DdLXeQXPf
         ofAT0ZYbl9EAHCFlvDtaqiHvoPCEQhglFu7gM5uHWNowqE+s2p9sPtW/I7lUnrbonnBF
         qnJjWsgEuE1fJf8F2uijDMufxXLJYxXkPAsuacimybYByL/OFp5sRYPrja9PpvqSECvz
         v7ArN98MsLl2aIoWPRSeo0Li0LFEKEmkojBEZqP3vHoPpLdUAvlgNCFebxsJlNZtjGCn
         ljMqv49jDI9WH0LMuhx5USaFUKeoJBjzrnxQ3+xlALsbzXQHhqKN+bEq0T+iTxqAt8XT
         iWEg==
X-Forwarded-Encrypted: i=1; AJvYcCX8a72Lz6J7gCXSOjusfTIeWeN1z895OkmhUoR2AYJ/FoT31tXdBKaK4nWN2lckIowe99AZJbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlOQdyndA6CEo/x7D3YPawqjpqaOnyAqCykTmqKhz4fQg+oOQ
	Jgb7DI/aZkFcDjJENDOLOyTCRMQ15PCSQ3j1+vFjYRbONoHqwNZKB2LYNUqktLvgbY1t9wP6X7J
	XzgODwXw=
X-Gm-Gg: ATEYQzzlYcxLFIz33TFvAydr1335Z/f91VsSE6epjZ61aPkFDz4/DnngnpCvmUwaYuk
	M6mJwBvfbp7b7n4mAMuKKuucLIYlTgAyKvEu+/gsnXrF/NnodE9yWIUofeaXCM4Co+7czCJzX2H
	TucAsuU0J3sZWWQv8pV1Fo4dcXaoawge8FUCErr1TQkpprUegt+foH59jW+3wkST2nq+yYnsxXU
	p3T1qJftuSfyoG+Id7/DrjXSgoTOa2tZkwWPUDmj+8ZutHxHd4RNcmoYkZSNlSCyoxvJ/ndw0O1
	SfSI4EuSDKxO0CR+200iaV/VQ6mrougtRrcK95HK6NsaeuZZHC1nHdSB+6501fHhusTlByP3zaB
	C4f7t3VCWAJsSjdlb4J/rwDVW/NVZwDnKE859Y2IWkRICRGuOVbqnL1WS/bYa23sf8chE7xg7fY
	DG45aUOBP9wtTJCLgH1B0fvd31q5pbVFAZNnjtgHfUkjcLKQ844W+J/pKq/EutDaV2peFE
X-Received: by 2002:a05:6512:230a:b0:59f:8546:203c with SMTP id 2adb3069b0e04-5a10ff991f4mr161708e87.12.1772140392639;
        Thu, 26 Feb 2026 13:13:12 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10f937896sm283750e87.11.2026.02.26.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:11 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:54 +0100
Subject: [PATCH RFC bpf-next 3/5] bpf: Allow access to
 bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-3-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BABB1AF9B9
X-Rspamd-Action: no action

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
index 017071197466..378ff9dd450f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7257,6 +7257,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7299,6 +7303,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0


