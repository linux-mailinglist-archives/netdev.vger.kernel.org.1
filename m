Return-Path: <netdev+bounces-251442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEp0CORKcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-251442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:53:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3A5E559
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E51746A56
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD33ED119;
	Tue, 20 Jan 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MLoa5g2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB733A6F8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904733; cv=pass; b=BUh6McAPycKkk2rW2MBNUbY2DWE3hZnrb7G8aWdBkwrVWBagOihe09PVgxMTdPb6dmTPHxJ2mw+1g0EgtkOlTGYfll1hpkHH6iwpqucCwhLHEdW7TEIvkogc8q1/xOhR5KoE7l/SDdj7NOb1f2CdjBYeYnB28GkLnVtxTums1IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904733; c=relaxed/simple;
	bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FApRU4MToaxSBa5m612SDjJms1x0cD5b6d7dcVv3JRMvlG4zkwi6ASUnxogfSNpc275nV6WX4gTaoN+j+blp9ugz4gXsl0yx/vyMHSWK97Z4nYcX26tv78Ypde1CHfhQHk2X25+plbRQKTjOI0sjZbQwx5I8p7S/9ovpQnxhXxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MLoa5g2; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501502318b1so42392441cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904730; cv=none;
        d=google.com; s=arc-20240605;
        b=KxmgQdegwnCF386B0wHijH/cVX9fdEl1tWd5ARW06nuZcE2cKTTmQ4vqXREIhehFLa
         UFM8OJyZL2USJwLSVXi8lQu5M/AXAJ4lH/tiOVHhlWxQOqMIexfC4GX/zQyHYcCQTuQw
         axwIgCW/P5u9eH6Gw5525Pmvc/JUElYgs8V7HlFK339r1+hcFa/7mo1kZb23ncgZkmRO
         xJSd3SdhNPXwLEquM0glmlWrEgfItUv1gYJ3hMRlIKt7FOLW4VAhfVpZpC9fAHRMTC25
         36rB5tGKLGBUJqEgIQWdRTZ9r5fZdh6sMR2DUB+AP+yASnkmwAPXxUZRs1bmq4a5+gTF
         2QKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
        fh=OsvmKvdoPKCCcjigdA7sh0POOAM3AsEfsVoaKRsZ/ME=;
        b=Wfxp9ZzbEaIIT5CvCwC41FNzjk2Slya/Ol8UjYJlCu6wJv4MA+QJ4GMToumVFSXqoM
         owCvqHBh8oBnNKYkLzKmsPr70zgqbqGppWaS6CYlBy3WCWvMV48CyONL5V/YTU5ji9xv
         kvg/1KpAXgJG8WZzNY6x3i9oSRExy/dOyk/hgit62PvauybwboPpkq6ABscND7m8xTyW
         jEXDTmbPW8cNdJv1ZAK8Bt7HvXQUjDR8WFzGJNkGrs2ByRtcIpssMODfTnzDl3bZE+Ua
         Xl04ehIKWvfx4ay9w+dLBMNHuubvG8F5YZgvQ7s4Yw/QIkivs9yIFmRWmWgtSBKjyN52
         KiQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904730; x=1769509530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
        b=0MLoa5g2PfCyeo+1/vEDpd8wWDjQmTPWqQUdJjSPPpiq7qmcmGeDLKE/WzgLwrpKAQ
         3ymVQTGSykLqPZ6elyTjQFZO0QMIK5Xyd259NJ8hEgd4CPlKptQHqihhy/L3sEkKQ3pP
         fBoA7vUHQi9bE3vArS9v/adTBoCvpwPN0OPuQyehyEEumx/mmDbYCoIeEn0EsmTTLTMX
         bOZGsy/sR94ywAORlTNcYl0C1ZNMTqrulnEney6DmlSEo6auplShGYvW3x091LJS1S2R
         11IWC8b7mArisAW38h4Db0zJfR7fPWguUT+qkHzJ+/f63kuyDkqxkaNFJWGJxJZtI7rU
         Uqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904730; x=1769509530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
        b=nL4m6QgfqVh4ILwvF3k8taCLd0K/FamVSVYJK+k9wkjIjgW9iwMzGcluQZ08/uTIUQ
         i7HMW9LropgVu8girk3AP0M2TUZ+MUFMSUYWlkoKD5n9eseWQ3LVEflgxYG5yBxEWrGG
         RAkLP5Von34uWW6PMLt9g2u/iij5p+EFfFurr6FTJbf5I+v8tANlpm0U4zk9cuJTD4sM
         J/FYrUuf6qauko6epLBIKLu9+lQ13L1kjmbn0/Yo5/YkCm0Ozfay3tQ/L4i/OPX/LYxb
         FMx4oHOakicLIcixT/zRPoD9IwXgLF1hMHlXOLa4Vw0DMh4erEYKUzNataUFB/gj/42H
         2Ikg==
X-Forwarded-Encrypted: i=1; AJvYcCXkngxVIp3wSq9cYynI/y7gEmBpBnGgtibK7xrC+NLQ1ojEQTuMxmdJUJcMydv0vQtOb6lKPDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzlOGHPU0pvkAbY0UI9w02k518Xt6dPlwi9Sy03dol/mawEog
	C87YNlpF8f9u+1/aJmIy5htntg8dSvUAtf47OhPXTi9r6wHpdrWklWdS0cWo3fCpEfMO8wtg7r9
	yxqkqmsztlcASXnweu8LRF+BMv1jEQo0nVqkFoo9k
X-Gm-Gg: AY/fxX5va4FOKb0Vo8Jgzk6PRG4xQ5M9g8WQLsQZ1M48kr7hWmfoBPJjrm6056KQSWB
	i/KzwW9Ih1BEMHNcMn/vnurE+sEGxtMEW+tBvMwVov2OY8lxG5jH9iHHEuF6gGgfk9MQLPjBBMe
	7lqF8ZNyjWRC+2yvV4trwIuKxoXmT9Y7nl6QqsKMUqfI9EGHBy+FU+R8m8GJSA/XcXTE/PPguUi
	gDx+O3wX2AWscURwjf09DspYDv19icuSvu+4YzxDPA5XXy7XE3skXbTILdU+zGUrkSyhCJwK4zn
	U5V5uQ==
X-Received: by 2002:ac8:5d4e:0:b0:4ee:1c81:b1d1 with SMTP id
 d75a77b69052e-502d84d36e8mr12347611cf.22.1768904730033; Tue, 20 Jan 2026
 02:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:25:18 +0100
X-Gm-Features: AZwV_QhXZCQk1XE-q39P2gd1Nz-BCTJZ9hlSkcwUiVU-61knB_BOINgx5AQZsrs
Message-ID: <CANn89i+6KjPh916bSTJ96=mDtR8d4kQ4LNs5eqfJHZnRGMx1bQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DATE_IN_PAST(1.00)[35];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 5EF3A5E559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Before this patch, retransmitted SYN/ACK did not have a specific synack_t=
ype;
> however, the upcoming patch needs to distinguish between retransmitted an=
d
> non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
> SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
> synack_type (TCP_SYNACK_RETRANS).
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

