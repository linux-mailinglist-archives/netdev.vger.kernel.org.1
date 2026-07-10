Return-Path: <netdev+bounces-306396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8RQHM6U5UGoovQIAu9opvQ
	(envelope-from <netdev+bounces-306396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3073653F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:15:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XH2llc+X;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306396-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306396-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3386E3052FE7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA54378F2E;
	Fri, 10 Jul 2026 00:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3B17A2E8
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:13:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642424; cv=none; b=VdqXldagiB9hP9sYh/bzlKYSdKOzX5OB0kfQ6Vosz8s4NeIHL1hoZeLchaaqlKbJ8hdfgiVq3kYTSiq3bO6ESZfsjON5a8so7VM4X/Y4iISfYeyWzu+WY0yW6TNbZXvLszfJlsavFl3hC44mK4FodZ98kuufH0yl2Mb94Bi3dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642424; c=relaxed/simple;
	bh=thvftvBatjKZR+GPnk6us63Rp1kjylbihEf1IrFFa6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM6LiyKxKjLy2JJOjBlUlzQvOWsobWJ2+qTsqxWNyV2iJkdWrYzN1Bf6WaOo+yhqR5kjm5OKKRFgcYVN8AHqjYX3LTyKRjlH2wkyMtJCQbcZTBInIF5iz80wqCExfUnOsSRo/x8iV7V+I8cQMU+H6lMFVmk1oeLiCgnaFJVIO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH2llc+X; arc=none smtp.client-ip=209.85.214.194
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2caf4496889so2750295ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642423; x=1784247223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y8qOpSBsfUs22KItaR0neP8aEEt8SwOwfSruEwWXFmM=;
        b=XH2llc+XaQ1uD0JC0DP5vbwf784vyFbdOVYMbuSPSd/FtDCOLhhPTINp7dGO78ev+/
         giJAy/TQnCoWzsNXYPnNTjcGNL8OqAnu/tll5/66TZOtMqrAgioe7ak/+/DZ6D/plsix
         ijqUClR9mFp1f05gouPv447PH6l+axK/RwbvquqT24IIlff6peWCbaE1AyFlw0t5UuE/
         VT5XfwIixRW/lgiQ1+DcPeeoWw3hHxzcercBQcwddtLsUxHjvZTJlpMe/kCdPmHEtu/i
         2O9Gezqus1xU2a8xtsFL/GFuNIOVwjMjZRyEetLBatsiIcIQW04jxzsfvhbbnFLJFHmY
         nciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642423; x=1784247223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8qOpSBsfUs22KItaR0neP8aEEt8SwOwfSruEwWXFmM=;
        b=HjUw3+y3GPVSgIcvOM4KXQsO9PFzniFU85zRWNpaE8HafJqb4JTVHkqDONFkzI2DlU
         UBN8ONL42zYylG6BinNyPE/5+EfJsbeAF9DsDeOE825qWB0JfJnv0HbPxDy38t9xkPel
         xYGsaToWzrugQtCC+jNwdef0xh9CdMMPvx3lcXz+C8efMq0TxoCML93tPfUHc7vmgBRn
         p2PBqV3JsKyoYBFyHza87OVCHzbwgWUjCe4TosbjPFmKnwtO5xSm751/EcPs0tVWO6z/
         VaKRyHkyvkoLMI5CKSsMCn0yIX2uhf4SH6OUUIDc4w9gwSNDFGDTDLTjKsj7/IiyM0zX
         e8Kw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3FLThi5TQkK6XlLqTzXT3NL27wwcmcL1+jvguKwjtCH040uHwFDQrrRf+mZznhiz7MrRZQpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DVwW3seZDCLjDe1ba6O6qfHNMan7zc/D4mFx3YEubSzG/Oza
	CzCM/LKNEUMAdJKMWwiOXY4yjsdKsDuyYnNL7jALi6O1YzKJi/AVoPhi
X-Gm-Gg: AfdE7cn9Xg6Za4lRwI+aqAiVHcG9v/Sfj6liBJE6ciA9jONsFAj/EXDgHh5xCk9aVyt
	o02sHo+uWPZU5S7eRWuLAcjSSxc1NaCzw5HonlEcKABqAqaAZSQr7kgzb2Fo96wBU51iyxh5uJM
	2EnqUyTDekyOem7Ui49xaeo+Xso2el29Lxry7mrEA3+tNaLfE9rfEiikkeQq7AVxhRrOncZQZYg
	7aett3Fe/M7Sr00XvCdQ4lCLqOKvrRJedD1+4uizXAhlIs5/M8nad8PTCEpFLyOAEuOKJe3dKF7
	kAlwfSRTBsOlf2F2osjrZ83j5sxzt+y3BeflhOr9rpTjXqZl5rFRiycGkcYwaecssgVCfeSgGaF
	N3jUAfrvKl812s+wTih5P7DELGr4dVGIAoamG/1NvDlJikV8sFRx76+cOhyzlEhDQ3oEl9k4Qv6
	e99wcLjumQpGBJIYXw
X-Received: by 2002:a17:903:4b2b:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2ce8285a73bmr12198765ad.2.1783642422634;
        Thu, 09 Jul 2026 17:13:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3c99fsm51196295ad.68.2026.07.09.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:42 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:13:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 4/5] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <alA5Bh7tICCSqgX_@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-5-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306396-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid,fomichev.me:email,etsalapatis.com:email,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25F3073653F

On 07/09, Mahe Tardy wrote:
> This test is similar to test_icmp_send_unreach_cgroup but checks that,
> in case of recursion, meaning that the BPF program calling the kfunc was
> re-triggered by the icmp_send done by the kfunc, the kfunc will stop
> early and return -EBUSY.
> 
> The test attaches to the root cgroup to ensure the ICMP packet generated
> by the kfunc re-triggers the BPF program.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

