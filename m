Return-Path: <netdev+bounces-254984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM6UJAobfGlgKgIAu9opvQ
	(envelope-from <netdev+bounces-254984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:44:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1732B687D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 415F1300335C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3A3164D0;
	Fri, 30 Jan 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnje5YsJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549622E6CBF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741058; cv=none; b=g1whigTTUgFNBxZgTuu2f4lCu99Uqf4fD1ZVwsDNUj5ABU9IxNBWGWVl395x+2ETYbzS1w8dXfOxdssb6/z5uhCxCF2/1PcuVlRQALsJKt+L2wq2gjHsOuuqKKyOhSdgZSPY9irU0Z0F/S4uNAsqQuArxnq1vL7KMC+syul1fUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741058; c=relaxed/simple;
	bh=77m54Z3r12BiXyISoAMiVNiKFAaYj429ngd+jaOhBlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpH2z+2MhSZWzp36yZE82vNRyCDacIaSK9Cn3XkQp+e2dHPjBENyaCVXej2/KNKtFo4HGwf/vswjIe+OpayXvXZHDMELP1eu21sINQtoM6U9c7LmS3Qnq+q22XX4xWsMybP7lCIUuVkHuLVw5Ru5qe/btf/LIracdS9tuspbGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnje5YsJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so2084747eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769741056; x=1770345856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+bKZuo8K+L898uhyxUoNjLAoFRKKRaFaoiyxFbBVrE=;
        b=gnje5YsJJu2h5teBKMRossdOTxwxRY1pR0kLPPpkGBYUOxrqyqaKtfthgEmmpqugFE
         cOpOw1h45K2+U5KqCSXY6IYkgXJU3MBlja//7jTetWrrbp3nggo/mIyal7b4Qn0g1u5u
         HcVUL+iGEMcGbQmZl4hTdc2UHP+ZMVhM2KndqZRzNc3+dvnshJX/7T+4TXTv0UUzGs8N
         5FtrD68ZmIzRtu80lEOVi4OhaL7MD14s605lKPbTQkWbERH7G6wlZS0oSdviZD2V57gD
         uA6+gQcXbpWzQORGDMaWMbL84vcxsrNd/3Tm+gal3UhtaEOGmCWIZJcuSly5bQIXXsqS
         +08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769741056; x=1770345856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+bKZuo8K+L898uhyxUoNjLAoFRKKRaFaoiyxFbBVrE=;
        b=Ms6AcMQLvIUvVvzLXTrqlDXg8l1TYfvPhm17REkOV3rqmX5ZubeVFzwjfVeDlcKWu0
         3sAdPPKgJN2WKh9oG1rUpYV6V1rsC50OKyS65uq54196gW+Gcv6Jn0spvTDBeXFAgyDs
         E0qZf39yx8GafP7qbDA8fGngcQVdxLtrlfVqoCKNjKEvy38XLGAjoOh6yBjLKPxm4sKK
         Ed/Nie7zcgZTOhT1UkHjGH1iOmV7iZCLcgwxtPiwTlAkqOPXaMTyUFZ06ILwNUNnTEYC
         JBIE3TLkLy4hK1EvZrJ7y8wvVFGNXRh9A3OwOt23WAuffoIrCbFafxjpeCHruadBhBDy
         gOzg==
X-Forwarded-Encrypted: i=1; AJvYcCUFc/9BbXPksJf6YLgYmjTNEi51zrJlvg4ZXyd364+s8yHn8YW4RJp/WUoz7gwZTNnzD8JRcMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJ+0OE84fkJSbm3SC4wAm2XSWTGGKuXDY5BQ51qP9LjSevLaa
	XygYYjhKid4Gktm78nt1c18uwtpIFTz+BjfV/25tPUa4S9czwabfR++o
X-Gm-Gg: AZuq6aLD3aiB8vurNUWnwhgYTA68hKE5fdpNpWU0n4suKY586TSnKJVtB4945fWnI9h
	Hf/GJnXavoLHwH63Zs0O2f6bp8bIgIdLMzQaB4OIWFxXkFTMMy4tfjYQFV06jtD9Ned3dVA+HeH
	+O3Q1aOu7zF0O9iAS/c/iZpznw5JvSZ9aZkgSYbDoHUl3F2rHVl42tbIEBm2LDpCtWTlx4LnF+/
	s8cHapfDa6hljRD9soKJ7iygj0hgdkOeONYAcNH5i932TGkaH6liE8j7RkFMe64xjK5W7YgzS+K
	2MOtmuSjOG4LdFMt/fzs3kIAjWaN1XjirDIJeEsBXPtE8Zjo3axRWNdWmVZAOOp9jEoKLZaTtxk
	SXEAA9mWqXMOPnElFLTIVro/ev5HknnBDrs0qXzUXyxjbvJhP1NS6n9D2tc3OT/piwruzpTGvPl
	0O/lg=
X-Received: by 2002:a05:693c:2b12:b0:2b0:5b6b:6529 with SMTP id 5a478bee46e88-2b7c8940fa3mr687647eec.39.1769741056072;
        Thu, 29 Jan 2026 18:44:16 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abeb6asm10183448eec.19.2026.01.29.18.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:44:15 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: kuniyu@google.com
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jlayton@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	realwujing@gmail.com,
	sd@queasysnail.net,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH net-next v3] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Thu, 29 Jan 2026 21:44:06 -0500
Message-ID: <20260130024410.2491051-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAAVpQUDbYnzyBuN5SS9bSTfJDvVH18QNXrXGTYzZRb3Cgk=mQg@mail.gmail.com>
References: <CAAVpQUDbYnzyBuN5SS9bSTfJDvVH18QNXrXGTYzZRb3Cgk=mQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254984-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,redhat.com,gmail.com,queasysnail.net,chinatelecom.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1732B687D
X-Rspamd-Action: no action

Hi Kuniyuki,

Thank you for your valuable feedback!

On  Wed, 28 Jan 2026 09:13:59 -0800 Kuniyuki Iwashima <kuniyu@google.com> wrote:
> idr_for_each() sounds better to me.

I have integrated this in v4. It indeed makes the IDR traversal much more 
idiomatic and efficient.

> If we replace list_del_rcu(&net->list); with
> list_del_init_rcu(&net->list);, we can check net->list.pprev
> instead of adding dying_net, which is a bit racy since
> idr_for_each() could return a net which would have been
> processed in the next cleanup_net() invocation.

To resolve this race, I've moved the setting of 'is_dying = true' inside 
cleanup_net() while still holding the net_rwsem write lock. This ensures 
all namespaces in the current kill_list are marked before we release the 
lock and perform the batch unhashing.

Regarding list_del_init_rcu(), as it is not a standard API, I evaluated 
using list_del_rcu() followed by INIT_LIST_HEAD(). However, resetting 
list pointers is generally unsafe for RCU readers (e.g., in for_each_net_rcu), 
as it could cause them to enter an infinite loop. Using the 'is_dying' 
boolean under the existing lock seems to be the safest and simplest approach.

I've also cleaned up the redundant nsid_lock and the duplicate Signed-off-by 
tags as you suggested.

The complexity is now O(N_system * N_ids), effectively eliminating the 
O(M_batch) multiplier.

I've just sent out the v4 patch. Looking forward to your thoughts.

Thanks,
Qiliang

