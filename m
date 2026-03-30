Return-Path: <netdev+bounces-273193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GMpEA9/ymmR9QUAu9opvQ
	(envelope-from <netdev+bounces-273193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:47:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DB35C444
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C0F3301C597
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B84258CD7;
	Mon, 30 Mar 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OccewnNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A741B4F1F
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877543; cv=none; b=JYAFaCGsQnwv0WusOwTDEZjaQudyrgXyPufb/6Ub7L5+XWMNAOhenf5hY8S1t3vwqVbGe52gJ4DQKG8JM/lSuIrGypqwohP+kcixuWSaKcZGZLBF18u8orl1s3k2/F6/kKwj6+Wdur8HFK63m43C0bRfWtZ1soVYww55ZwNscq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877543; c=relaxed/simple;
	bh=iD3d77B2D7TjEvsYdGDnR63jDfJN3DzzvZeiONNGPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z84IRpaT6q4Mic73Uex8rE+SOoQr9bzhkSgZTmiHJOmqz15XtGnI9sBQLpL+dqpa9F2/z90RKoKTzlRgBfWEW77CLuRdj9LhXcF4UcPrRNtFpJhMHojKf/Fr4rC4DIMIi2+v56nQ95ZjyPKmkRSjNuvfe7rmYbnE8I6G6XwNEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OccewnNk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso18435725ad.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877542; x=1775482342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD3d77B2D7TjEvsYdGDnR63jDfJN3DzzvZeiONNGPCI=;
        b=OccewnNkRuoq9J8SATNCTzhv8frRTEs8F2qnGxiXCf+jxB4TOa48lO9UZyNwRNmVyi
         /nNvn/bgTBg03E6Kq8hBgo8oeDI8q2JCY2EqIRE4W/BffQgRRqC5oOvPqlWKUwqXbCHE
         T5Fzha26GPgZxmxqhG7S7jl2ExTK7JOqgzuUgk6m3ge3kTskfRn1K9Rg9h0XkE1IdUhj
         VhyPJdEC+Doj/U7SmEFNp62zaGpvRQ6msk1Kliz+hA3qRadVHaHd6i+9zQWAirGD2X4f
         fapnta+7vgj94QtYeVq7TR+NKCavB2+gNQo4gxFTq8IQKqRDNKu6W1EIoynykKpKbPnz
         MizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877542; x=1775482342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iD3d77B2D7TjEvsYdGDnR63jDfJN3DzzvZeiONNGPCI=;
        b=Wb7cwBMSPnKTu5g/28OSEshPDryylWRa6P4nJ3hVmuG969vkVtFS2eSC79H4x9quIn
         CnvXxKocYOd0bs4gRwi1SgLTiB3KBHe4lacTKZeBelowV4o06GhMG9AyifDO23Fzef5Z
         UA6eBg1aT8hmGh5HscaRW4udsjF+jVtxS7E9AUL1bItTqtsH6MsJuAXEQao2xAZ6iWW/
         KjZMxx3V30KvgObMnabVVw41nFcOxnoPkI2IV23PxJ1/suOuT9AYc3ljWaGlA2qI/w5t
         1enihr8ClqIyD4zo1IYDK3kPYtdM++Q5RSRgzg7D/xCLcnvhFceGSqvVX1LbKKtaqX+n
         PGLg==
X-Forwarded-Encrypted: i=1; AJvYcCVbjQbz6zO1tB+iJ5myDsQNtd9e14+U/DI/o5RuD86l73oiUlKIOYgdspIUoGosafy5QAL2Fms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIg2iIUqYkC7gehgS0EEp/mrE5+7vCVl3u3KaKAjAxJte0hZR
	Z5ZmjjgCEbdYa6xjoERX1dT3Zsb9gbQvPPe9zkhjyKS6rbjy9BlIFIkk3Fa8wen8kow=
X-Gm-Gg: ATEYQzw4j7yUcLEuvrjx0ZigVR8mrKlo2AWg9xaeImhtZ81y88kz34m1QKll9Cb13Hd
	aGiMljr+tYzYt3QWO2gNjEsqv/EA4yh/N61zKSheCagaWdwAbBnAUpjZq70US47V9HN1wAVr5Yi
	bP6us0qQ54nOUTUDy91b+BcK5Zq0on/8dnviVAefV4UHVJBYOcIR4liPMCJkrGlS9Rnza4XOr8R
	LhFLm6CzudF5woe6krqf8XPpzNfw+xvif4sGHgz/35aQ0TTTdfHpfYnJ3/kOcjyBvY++O9Kh2y6
	ak0zCpZiysgUhnXJ8ECjKarQk+9JLi4BEoBL0c6cyHJ3URv+zpallZ20AEqkFPqfMwuPKAQgqwC
	heraNqP+NN5fpYSGRR5uII+9XlSTzg7m1o93TOHcWrvhHVqfivSQzAve1A7um960ZgktnFs8ciy
	VDnw+TAvM3mZHsGoa0HzLwl48FX8uO1eI2rvw=
X-Received: by 2002:a17:903:2408:b0:2b2:54c1:2067 with SMTP id d9443c01a7336-2b254c120d9mr33320645ad.21.1774877541967;
        Mon, 30 Mar 2026 06:32:21 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm99601525ad.72.2026.03.30.06.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:32:21 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH] netfilter: ctnetlink: validate expect class against master helper
Date: Mon, 30 Mar 2026 21:32:16 +0800
Message-ID: <20260330133216.241532-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acpkPEJRvzeY863Y@chamomile>
References: <acpkPEJRvzeY863Y@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD3DB35C444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 01:52:36PM +0200, Pablo Neira Ayuso wrote:
> Better to ignore the helper name proposed by userspace when creating
> the expectation.
>
> The master conntrack must already has a helper, and such helper must
> be the same that is specified here.

Agreed, your approach is much cleaner -- removing the separate helper
lookup entirely eliminates the mismatch class rather than just
patching the validation side.

Thanks for the quick fix!

Qi Tang

