Return-Path: <netdev+bounces-306343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCMMBYXpT2qVqAIAu9opvQ
	(envelope-from <netdev+bounces-306343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6B7344D7
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=p0FYNUaJ;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306343-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306343-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45C33020A91
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775A3AD531;
	Thu,  9 Jul 2026 18:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FCA3563DD
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:33:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622000; cv=none; b=TmPRZBj2+blCwNvxqDWAVLw912KQy1QSRKtVDBg/02Tz7Cbq1mltZ1D15pLn/U0vwtslGid9iTT2r5t9J83tU/LjihoIwSprslCdyKokxEOn2G5eprSjWlcK0AMvy7fQc9lRpKeOOrG0DwDGZKwh3gO5fbeprQX/YGYPKm9hKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622000; c=relaxed/simple;
	bh=payVMhQSUMwNCwdqze4KtENdKbHD6++fpuhUzGiHWHs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TJxouWuavwSZ2YPxX6jo1K3BrrLpJeDgbsfuNNLvs7OEyiLMFAnz2q/xKrlrJzgubjgt6Xq37HZEF6/gZPtPcP3LsARXH92JFcpzx52ULvhfGEt5b4Id+sdRE+gZ04f6FQV4EOtWkUnPj4Hi+6iTNkvcI/PBVnnGuuFyovu04Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0FYNUaJ; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848544a8496so52567b3a.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783621998; x=1784226798; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GRoTGFzFJI/kqr2GgTFhVnQ4q60YusMm9G2xnzNMhCI=;
        b=p0FYNUaJ75Kl9mC02MhfoTOttP3TgZVs+MHnguNya6TsK87ksgFNuZUVqzaG+KSEoL
         b5ocGrr63VC0Iu4A8A8vIBuOVi8BQUkEPa3iXA0Mt44Ei1iGE+mPGlcGESDp9DNrVC2V
         8AAT+ZKMSImUHHwSzal3qb0Z8d00u9FXjVmdVXdQ9AIKjALzofgtd5wvFhdnOUMMiwbk
         9DXlm6vdiPJHygqbyRqD0X/s8y6nM2e53ztlAsWdmIQxlrRJHgdTIHnBqJ108v9mD5tA
         QnXHmdoq9e/L0NVvy5LgoUJaaNiLqBZA2Tn4OWsiJ2XYtvCPwoML86U1k4wtjY9zYOo0
         IoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621998; x=1784226798;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRoTGFzFJI/kqr2GgTFhVnQ4q60YusMm9G2xnzNMhCI=;
        b=NUPZONNQjV4w3vxES3XrJcemeV5SK4DRkQmwf9aMeheLlMj14TBdzRcW5fxqlN4KkC
         l6g50BLTAaxsz5DdGX65eqQfnlg6QZNHM3WPKsCvKYDPPAn8MgzikzXe8A9X/LguxYN6
         Aw6hhsgiMwRU3Gd0XbNUOaROP5NX6S90CdX0bzP+n9u5MHouCOjq0f0lQuYFDFrcUgBM
         eLFIT+rJNGNCG7cGbiwkZn52W72EzER8vIC1EinhwWm314xzFaFRNZUVzjmmpFbmWKJR
         P97y3wGJ5hEfX29/DfPBZTvLfAlND9B0uNeDPr3E0mwqLNOSxKEZLyasRCr5CxDpyUdb
         n1tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Mcto90zTKx4HsFigZdig7DKyPPIU62Y3SvfivOPfAOnS7X6mZBPOIGd0Ni8nFjY3P9QwLC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP761tPSDZtfEsiDwybh+8sPzBKqzZg7usrTJseTo2tQJPF56h
	sZn6zgD0i0OyQ235rhL+G+jIJ5CsnPtg6EC3qsv67kicvGqDvhVYr9eXn8e1ihiBkqEc8O/XOKm
	giqBPEQ==
X-Received: from pfoa23.prod.google.com ([2002:aa7:8657:0:b0:847:99d5:ef10])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:91c7:b0:848:6447:e0a6
 with SMTP id d2e1a72fcca58-8486447e2fcmr2177652b3a.9.1783621997988; Thu, 09
 Jul 2026 11:33:17 -0700 (PDT)
Date: Thu,  9 Jul 2026 18:31:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709183315.965751-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] net: Fix two issues in sk_clone() error path.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Octavian Purdila <tavip@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:willemb@google.com,m:horms@kernel.org,m:tavip@google.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:martin.lau@linux.dev,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BB6B7344D7

Sashiko reported issues in the sk_clone() error path.

  https://lore.kernel.org/bpf/20260709032007.9E4D61F000E9@smtp.kernel.org/

This series fixes them.

Note that Sashiko may point out the same issue for sk_bpf_storage,
but the fix was already merged in the bpf tree:

  7cbd0c4cebe4 ("bpf: Fix UAF in sock clone early bailouts")


Kuniyuki Iwashima (2):
  soreuseport: Clear sk_reuseport_cb before failure in sk_clone().
  net: Call net_enable_timestamp() before failure in sk_clone().

 net/core/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog


