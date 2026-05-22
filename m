Return-Path: <netdev+bounces-290659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA0rJ5PMD2obPwYAu9opvQ
	(envelope-from <netdev+bounces-290659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:25:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202885AE526
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F80302BBF7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBBC32BF52;
	Fri, 22 May 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAPMLsrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FA3233ED
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420303; cv=none; b=OvN+IZ63T1lzVUYyo03TozYns1PsRnZBLQrmYZ6VYKvgzhZDajJtVrj5ktrjFIpLJagAnZPva3BY2ffzRTz2j9Zem2AZySZncMWC2J2JOZbjA1p6vhJwUpkyYqLykh7jeRtBWrmtWDMTOBZCh16P9dfbes8PdcQPnecRCNiHRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420303; c=relaxed/simple;
	bh=L2jg9D0XFL1VvN9nyVxBY1HFgSfAg+BCJi++Ra9EGhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAgwu6pTgHWHxaeHpn6OjEEoqWuGEhJQCekjbMCNh2lhCJgFuHhNyyO/AzDXRWrRVJHkqaS/Y1KBBzJm+JpwCA83d9y5OfAUMZp5UtHdI7uR2CrG4DjNAlNb6qy+rHdCkh8kzociC5FIjgLri0rH5DF9jBEcXKsjk6HbADevqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAPMLsrn; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6949192b840so1927181eaf.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779420301; x=1780025101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqSX+qOoTZNsA5tItQHuM3Tq846LID2NTSA7TvluY5c=;
        b=fAPMLsrn4eNdMapYxDUGnyXhU4YvHsTw8rpr/scBHCY9R8u1dbfCyCyp1ZEm2Ub9xi
         /R8rNrprvJ4+LLwEYlOqZnATGM6LkxQ10Jp3DnBaMkeOtzvHZ0gzPYMdojsY9rrh+XsL
         +8UQP8IKw616RiGjWcmfRbPnTbjLIgSwSZh604Cnsm8osg06Xk++T2SF5knEVY+oE0Zb
         y98JS3y7tVtHaHE1m19G+s2i8GqGfO8kuz6pw/SQelj8n8ScYK27sRdCYdN50JnU1Za2
         aBsE4WwpwtdCg8/Sd1VbZJWcTyqY7aRSq38FreQSg2jfn7hwtUgq8FkqkQzqOHvCeLNb
         CUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779420301; x=1780025101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqSX+qOoTZNsA5tItQHuM3Tq846LID2NTSA7TvluY5c=;
        b=X4tXsfsBkAuZY6jIuieXdBShG529YDhZFYBMXNiGjG7D5fcoXxojm6Zt9JJUiMPTNA
         zWrss2xWSl4gvrSGf+qR+4p+7VZ8UcQe40wKIX8P+80X0LZfOFON/K/Rio/9YlXV1uvY
         WOCQ6CpCbW2rabNOc4c9J5kOh9e7Lt4f98TjpVDrebboCZrf1kWVcX/Qjp7c6hriZXao
         tQIy1dRP8idDe1xBqUhigTUaRry8hvh2b6m5QAkyAwNhdsVxPSLwdyzAHqupr6qeECbU
         PIPRuSNnSptSj6Y6fsDXbnanMQzqbniZpNrV2e8QArBOKaRn5S8iMT74V8lXnYM9DEhr
         6EWQ==
X-Gm-Message-State: AOJu0Yy24+Ss0cJNe8nXHVUlJSjZEi3GKRaUuGfFPZXh5Mtphd/kBSil
	70P6g732G17afiK3f/yyCYcddX0jQ/2YOjc8irWQWpgPkyUGlk9Bk2IeT2fey5su
X-Gm-Gg: Acq92OFQOMA2xGJiE2MEqbJT+Km/Q3wS+4qZUxSscYlEDWAKWXVJUs9jB1QCCRp/SSf
	xexqAzPqXiu4AfjAEvzLTW+nLWV802EARKlt2Jz509Tkc7mXxbyAyyS0MV3EJHjLlgsNV1duFw5
	FqjbtX4K1VofAeAmPmntrc2NY7Sn1KlgA1LfjORrKOdg9UyzASBhewa22nCHc+/EH8dLc55ypy8
	taNdMw5opUYTMPDcN6tL26dk1HTTOwywkSVESF7eN4V87oZe+WG08gyytrtYxxwf7hmySebxCZL
	T9mxQjQIiWZTBqSii8s0U2UWmlI6lYrkpqZpqgANWL41tZ2TdOlgcfgkRqBJsR1b2S9zDtYEcTc
	pBjGtcsllIBS2FPI/O4VhLH0ASGbgZeU2A3/PVcZXtQEw1+7u37egAqfB0DCo/XLZKd7OGPFnWG
	lXuNwJ5Km2ffLECO16nJNKH9e1EQ==
X-Received: by 2002:a4a:ee07:0:b0:69d:84c9:ae70 with SMTP id 006d021491bc7-69d84c9b556mr237926eaf.40.1779420300958;
        Thu, 21 May 2026 20:25:00 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83a4eef1sm239063eaf.11.2026.05.21.20.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 20:24:59 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] Add OVS packet family YNL spec and unicast notification support
Date: Fri, 22 May 2026 11:24:47 +0800
Message-ID: <20260522032447.238715-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521022002.879334-1-houminxi@gmail.com>
References: <20260521022002.879334-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290659-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 202885AE526
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko flagged a few things on this series, noting my analysis here
for the record.

The dp-ifindex field is typed as u32 in the spec while the kernel
struct uses "int".  All three existing OVS specs (ovs_datapath,
ovs_flow, ovs_vport) also use u32 for this field, so I kept it
consistent.

key/actions/egress-tun-key are typed as binary rather than nest.
This is documented in the commit message and inline comments --
the nested attribute-sets belong to ovs_flow's spec, and YNL does
not support cross-spec references.

The execute operation does not carry uns-admin-perm in the spec.
The kernel sets GENL_UNS_ADMIN_PERM on it, but none of the existing
OVS specs declare admin-perm flags on any of their operations either
(ovs_datapath new/del/set, ovs_flow new/del/set, ovs_vport new/del/set
all have GENL_UNS_ADMIN_PERM in the kernel but omit it in the YAML).

ntf_bind() will raise OSError if the socket was already bound.
ntf_subscribe() has the same constraint -- both expect to be called
before any operation that triggers autobind.

