Return-Path: <netdev+bounces-253823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePKpIjSheGlQrgEAu9opvQ
	(envelope-from <netdev+bounces-253823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:27:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54D93952
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE4F301C14D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4706346E47;
	Tue, 27 Jan 2026 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuwm7Lgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388AE337BAA
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513263; cv=pass; b=N9kRIKQzXfl3l7GX9u9r5NBBsochxIpx2ireGhKoT6loWAw3XmiBGH+ibECIZ+gACbT/pPSE1+99WZPR9tKSlk9PCHaiuOc4OYu6T8cQfmS9MrZphwNqMmkSC39SXAryLQWy38KrpWei+Hm27OAVz5RAcwfqc5WDxmSrhyhTsTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513263; c=relaxed/simple;
	bh=LZoxGYiN0vHiV7IaMBXIg7wAr4TzwFl7njOcZqJwhgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7Z13eS7yQZ452rvhKAEBDu8J3u5CWvxdvHEdq9WL/+/BiNWhonC6Ufo/IVM6Y/dHd20F0+9ZGZmGYvNA0p5DJs6q8/eAy58mAgtmuBdLL9bPPp7GL2tRwsByvTZyLHXVcQbSrPSX7X74htmJ/k6RjgbqpDhupPUUMmbqwc597w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuwm7Lgn; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso5450589e87.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769513260; cv=none;
        d=google.com; s=arc-20240605;
        b=Nsz+lKQALbL5hmJ1GfIE5bane+6CtNTjzIRh/XHCblWrnRPyGUHx50G9znkN4vO4I2
         mpSHxyw9GgQmB6romp9lIxYZ9IsWmdBqgEIXFhFHj9B/hddQQTSDOdpoCxHj/Sa7ucNi
         aSwkqDrw33awFEa7IAm0b4qsDBgXRP8V6M/NF7lAdBJBE8EYH9LzTnbXE59MeUIr4VXa
         C6cT4RJtlsKVWgGoxdq4YE3y6dquyCoW4zyBLrLMKE/DOiP1LU91juH9mI16iPN4s1PE
         +ObW9JY2CoqsxK/3WTPN0MO7CZh6610R3/80S56jJwWCsqpL7GllJNZCTxbrW1Gt2uh+
         CfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LZoxGYiN0vHiV7IaMBXIg7wAr4TzwFl7njOcZqJwhgc=;
        fh=3cwhs+0Qfj4lwjTVSDYreqnCxETqH6exfBJEAzgAwCA=;
        b=DT3Q4ssgH77umzQ76xdT6DxhVKeURnFGI8TlaAS1v5kgWvN2bzpi3GHatSHxdjuK6Q
         r+NRlfQDpu9CZ3vIsCEud6AvHlo1kBTr8B0PPduE3efVY65iFJjvk+ZhRZ273svncAh0
         kmmi0SMJnoARU04Z6TCV96D9MqBuQjaxAwK7QgwfrR9AN49lIbt2abFDG+9u47Khjsxn
         xPd/+kKUMsKiIpu+sX/UUOVDTNTPpajRtUGOOY6jTZdxjKnxDLOxODpQog5Wn0XFJd3j
         FDaSDyw8SE8ACTQqlUCFO09bxhH9Mfb3FGqmrlSCSehcQy0wYONkhkxSSEZ8t4FdUB/r
         vi4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769513260; x=1770118060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZoxGYiN0vHiV7IaMBXIg7wAr4TzwFl7njOcZqJwhgc=;
        b=Vuwm7LgnNzRJSBvwVeEYFu8ab8r2mQi3NAczzt5qobuZfk5MEeoE/WHOwr0RorF5Mj
         8nRtfCCXhEzJXpAqwPxDLY/11xn0o07kSApQKA91RNmMZHoKrVafTF0wKMCRZ4CA2bzd
         RQZal+5CbJW783cJvkyGE6eWQF8mD/eyCRBakOvAMpx678TAhQb1KXN9WuDdKXYjTWlb
         nWVly1SGag41aDdVeDoF1xhMdDWcY5CHvjV+1hkE/cbW9uyL53T+x6qPYz+I2JY9vRdN
         CkCnxgDBQaN1v15F/FJynbfaKzQcLrgaTpFQswQ4WbXUXIFzrf0dy9uUf5LaoWRN/fcy
         O5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769513260; x=1770118060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZoxGYiN0vHiV7IaMBXIg7wAr4TzwFl7njOcZqJwhgc=;
        b=mU+SbhkjMAZSPvmWOY8c7/WYpY6zZTlhrS5uZ6GJ/ViZA9kTXTGHPRTs0nRTKHgFnt
         6TBU4dhaavFjwQWMhzhmPZINJrZ0ZDDSE0kVTGHfLpT/kcK5O8uzCnPk1i2FuZKPGkjD
         o/p+yojgf0GKo5WFsB2wdU+Wt604YSPdn53axPVXIB3XCnhL/QDtHZzB/fFdyQp22okt
         pqcu0B7HgwlNu7VbV74wQ66+bwRiIRr7y0tdte1Y6fdrrBUauqT05DcMQusVuW95eKgn
         weX49ijnxEg2G+xTkjyl1FuI+9DmDvF27nGUsW6EPAa5LAflWWYc8KTqpwrN7dlZgNyg
         w27g==
X-Forwarded-Encrypted: i=1; AJvYcCUNPUz0qjBDz7GgEjpbemRG1QIl9Pl9JQBnaVsQ+Z6XN3RL2IQv33DvV7g31eQiGqs3dEUwD64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFJsH9OqPzjHmbC28o9O6SBn9UepNi8lfiY6fIaU7OpZFbMeE
	Tbh0qRNxnCTJtmM1mhgiKQ3s8EIyHe0UWqLxOWJ4zUslthEEZqUzoVwVLb+5SSqg8dN7Ko2fgrY
	6MNkgMkU9nXD+6mk3UsQAqZgiVGJje+g=
X-Gm-Gg: AZuq6aLPABrWX3VEScHFu+vTCCbtLSsq1mTxhlureHmk92vsVZHQOm+Rv0ONI7rY5GC
	wqLLZoYpswYHsJCIn6YQBPhu7RAfHTn0f2a0Zdf8VRaZpyIpaahZCgvyYT+p9M7mS4EHxT8i7Du
	D8CZTjRLfyvjQ8mEW8SxloaRHLG/ksCSGDihC+L6zGHBFVFrjodxY85UP/90cE/CvFcbmOlILTE
	UltqB4brdZn+62oIpG1pGte9JOfB9FrqqiJIPBy2DBFVRz1kCLO48+9/7qXcowQ+StppByVL8uv
	nyXEGckKu9HNPrlXFc7hCbBu4A==
X-Received: by 2002:a05:6512:61a4:b0:59d:eb40:3 with SMTP id
 2adb3069b0e04-59e0413e62dmr556849e87.20.1769513260389; Tue, 27 Jan 2026
 03:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121184621.198537-1-one-d-wide@protonmail.com> <20260121184621.198537-5-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-5-one-d-wide@protonmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 27 Jan 2026 11:27:28 +0000
X-Gm-Features: AZwV_Qj78QlukASUl0qBzsmck7KFGqr0HZlwBXaLlgFkIp-Cb-R9BFq_Iq-h_T0
Message-ID: <CAD4GDZxxY=RxJq-UEw49-vxuzo3SzbKj4GYCrWbEKemxha=3UQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] doc/netlink: nftables: Add sub-messages
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253823-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,protonmail.com:email]
X-Rspamd-Queue-Id: 0B54D93952
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 18:47, Remy D. Farley <one-d-wide@protonmail.com> wrote:
>
> New sub-messsages:
> - log
> - match
> - numgen
> - range
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

