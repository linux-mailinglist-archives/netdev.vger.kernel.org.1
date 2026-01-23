Return-Path: <netdev+bounces-252647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBq7CWUac2mwsAAAu9opvQ
	(envelope-from <netdev+bounces-252647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C771279
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2611E300233A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC130F52C;
	Fri, 23 Jan 2026 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx18/y2b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D429BDA2
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151073; cv=none; b=DZ6UlByiv4bkiTvpAXWdJNsQ2dd9zVhf5bsC2EGh0Jpp38sYflpmoQ8SLFG87I4Q2Oh10xM7liH6hCsCM12plZgR3W7pCOdT4CagZo9dqv2g3t19PBxhEE/5NF/LawXpHW6W0iuMjTieM3E1BzZ1XnYPwZRaVL+ZWdr3L+eFc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151073; c=relaxed/simple;
	bh=WKxwqy028bHM/flN3UE3UY90mpCsQdFmKCbm5ICus5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXos+TAMn8VD77QvmQuqqjMZcH/OAg3Z/xPBSLz05Zx8VTPdAgMPir3wTdEeCHbYaWdpXxegGN2wq2gXKzsWqf8fNnB0O/XaaUiwLklUTF7YvSslLbMnH9dzhmRN0XuwquvqGeX2tIDi/JdZztrGgsVvcN+ofAsnctZ2UxnaK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx18/y2b; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1232d9f25e9so2264791c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769151071; x=1769755871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh9xMPBAfEqI5JKP5L7PsbeTrLZpUAW4aLq8P7MxDI0=;
        b=Yx18/y2bS4+IyCXO3B7UNaCjqac4HYiJ6SnrdcBRZ5NdJk/dq5mWMqwzANytXe5hYe
         dicsynfu8gqEzcHA5afYIh7VV2IdTu+bF9AX3kznX9BZrlcRnmRG4cYUpWXMPlwp13S9
         VXEwSfnExeEPjqHae4S2GJ/GURMIPjCC6QH7j4WKU4i6RPU/RKdgzMOgHkOy11Jn2uQk
         N5AKiFCN8DlwelOoAoIONipmqo4HCO5ppZ/TBVRNLSGmzWUBAXjnVG8IuMJDD7ORW5wk
         Kl327ZZVCNYXf/dYLxOjujESsNEjG3QnhDKNBrgCbLsyolRrWFp5xJTgId95GyV4onA5
         Vb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769151071; x=1769755871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh9xMPBAfEqI5JKP5L7PsbeTrLZpUAW4aLq8P7MxDI0=;
        b=mMKaYUEKBA+b9c5JxYbr/mMEemwQv0ZfiAQwlIZr23QuDnHLOsZewbLjHuY458itEq
         uerWU4bAKz3rbtPK+4v0gppklQf4DkXQo/LI+bpz8Fpi5LIAKFoKvx07nBdF0L7YbTSN
         +Ecsgs+DESTwhJF0FxKdS0honeuhS4nXUvXrYFTMMlRBieloY3QKqANJzs0NmwB2YyCc
         fEfpl/kIYe3B32ws15k480RL3XeHPQYlIpWOenya/Qrpx8Nmfuu6/CA/CZLenCxmc03l
         jXQ+pAu8nfKHiVBg8fKLDQ7F2Km9Rri88rqjof6G9wpuKTYwGlsNY/TA5Ul08dC7mznA
         xEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7J+/nzOy3sgz8+KfNFq9mhb5rsiwV9b/2RTUX2NNt5GXtMbIvD8GN4HZQA33nrG0Fn3hPXGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Fob66h3Bxqp/tac4+QfbaQHjuYn5fFwHAH92LQF2eWb4699d
	6Sqc1EbvgwkleTrVzJGcFk/QW8rWYWPzuDLL60kR/ll6ciWK0KV90pZf
X-Gm-Gg: AZuq6aLqV02JeaTDeaHRJa2+GYS/P+PrUzAIirQFWoQNqsxPn10H6ohGwq7LZthmUn9
	6VMB1DdEy4mYqDyMXiVYeDSiH8JZ6hwXUyH+pVexOzJbFTQkGsHANbrPeV9N2rthPYk4jSWInvk
	t/y2zq5hY2qRqZIcQFZLKzMqoinZeRAk8H/28tc2yHiuKaR4ugPK4sCQ93hT5heRtA2hN54lliu
	TjCmmhNwkJCg1IudCM2CImCD7Ez6HZXA85OHuUINjHEUzwd+8LrlIUENyQVeJqG1i8IHlCccO/1
	NLXBJnBAIDfJ+bEP+WWjqg6Oq6e8tTzUEBVtD7DniddatJQ1mBjK8oI88djcU42yCRGWjcn0H2J
	VMnMzYDVbJ3CunT0biVZ6S+0bHHqzZMholz4qyEbin9idtYBaUzElhFyXXi7UNjc=
X-Received: by 2002:a05:7022:438e:b0:121:9f05:7e4c with SMTP id a92af1059eb24-1247dbbba30mr972266c88.16.1769151071394;
        Thu, 22 Jan 2026 22:51:11 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0c:28::4:33f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm3071176c88.6.2026.01.22.22.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:51:10 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	netdev@vger.kernel.org,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	Chuanhong Guo <gch981213@gmail.com>
Subject: RE: [PATCH iwl-next v1] ixgbe: fix type punning in ixgbe_update_flash_X550
Date: Fri, 23 Jan 2026 14:45:22 +0800
Message-ID: <20260123065052.237216-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA3PR11MB89869D6FDF168BE8A17C40FEE597A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260122085102.1117651-1-aleksandr.loktionov@intel.com> <IA3PR11MB89869D6FDF168BE8A17C40FEE597A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252647-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B83C771279
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 10:12:54 +0000, Aleksandr Loktionov wrote:
> Thanks for the review, and agreed on the root cause.
> My motivation here was the mismatch between how the buffer is defined and
> how it’s consumed: the current cast-to-u32 * pattern felt brittle.
> Making the HIC buffer naturally 4-byte aligned is simpler and clearer for
> both readers and the compiler. Separately, while x86 will typically
> tolerate this, other architectures require natural alignment and may trap
> or penalize unaligned 32-bit accesses. So even if a crash hasn’t been
> reported, relying on 1-byte alignment for something treated as u32[] is
> not great practice across all supported arches. This change makes the
> layout explicitly safe. I’ll resend with a corrected commit message that
> focuses on alignment (not strict aliasing, given the kernel is built with -fno-strict-aliasing).
> 
> ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
> 
> ixgbe_host_interface_command() treats its buffer as a u32 array. The local
> buffer we pass in was a union of byte-sized fields, which gives it 1-byte
> alignment on the stack. On strict-align architectures this can cause
> unaligned 32-bit accesses.
> 
> Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte aligned, and
> pass the u32 member when calling ixgbe_host_interface_command().
> 
> No functional change on x86; prevents unaligned accesses on architectures
> that enforce natural alignment.
> 
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> What do you think?
> 
> Thanks!

LGTM, but do wait 24h after v1 before posting v2.

Regards,
Qingfang

