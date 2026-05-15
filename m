Return-Path: <netdev+bounces-288287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFGWLUAOB2p0rAIAu9opvQ
	(envelope-from <netdev+bounces-288287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:14:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B96B54F476
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F74B325442E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3442496916;
	Fri, 15 May 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXiZjQV5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9E4968E5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845736; cv=none; b=SST3cbfFCQtjfgzfAqI+CK1c+Iq5tf995zbzE6jJyyZ/jc+jlp0nf4fJ0PucYlZJcVN+FReZyerHi4sHLUcszSQG6TnXp1KHFXIZ1tPmuzamH/7qO7gi3f6gjjDr0+Ex/vvRi5wRDAv+nex5G2lntGP7xp6ji2FDH5dUoyBWenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845736; c=relaxed/simple;
	bh=wwiNcYnDC1z10P0PrRs9APY772ZKV/kzqcnC5P5allo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAKecuLWuiMqNN+k5fQAgzvxQcFbyyz99EB78AOMR2aer54BQeqzRYsSCTGVKKDxh6BfNUXclkKUGRDLsH/+4b7qlQxLvUb/B20f8aLvrkmQVnSlDOiPXc3gQgirOIXlbri69IfVAVRy6bx7cOawimQ0qITMP8VhIWgcfV/oz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXiZjQV5; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f68f3b075fso13552705eec.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778845734; x=1779450534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REkPrp5VneTuK6ehtYR1UAlutKollViGkaFp6MZ6pyY=;
        b=TXiZjQV5RqNHr/6bEk9wDCgK72Gm24+OtLYHe2Ib1W80uZXRq8bCE55bqcPQZkd5h/
         iW7VfXqcRQB71xdPwi2oJ6IX/R3QNioJQ9xmdeY+rUA0A1Y2c6PbnDzyOkM7qIBxvITd
         De8tnaN+u9jyrQH9wCAm2ybaoyvr0da6yNqN1nIfWyIafMXbj8xMs+g4yDMmCv0YVfa4
         SwXynq6blXJjBMztam4eXs4/HLtiTjj7+Sd32M/JHIMs5g0R/mlR7S9xfSwQ4santlI8
         HJ6vyNcZPfzMf1WNRxR25pyXa+3xcG5vbiVS0g68rI0wI5mGd2QAg6pKm09JqxuEcYUB
         wtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845734; x=1779450534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=REkPrp5VneTuK6ehtYR1UAlutKollViGkaFp6MZ6pyY=;
        b=mkshQC26yOGK9gK4iebgkr8gaitcOJy/XH4RPZFXW5HmchubhZhWXvQWHkkJrjqj2A
         aK8/S53W0hSRJ0e9rIsAsDPmK6brPpNyBHem9qfuie15igcoOE0XD4wSxV2IWtlA82vr
         LTIpIRZqkaOpjnpxYuZ9T4LedNHGkMqfK7FbmVUBlKANZMo0Lj3GVBrIt5MwKFhYdZbg
         eUpCD3UeS469hPRRvfYNfRGFDb9nBzV4683o8o+5dO2rcPrEb3K8GTkde1sSWVp1LW/L
         jjeRnQR/PEnxiFJQekI2SvGVk2mo822v43BoUYosnX8n34KVLX/V9gQanoQaIQIqlzYT
         pICg==
X-Forwarded-Encrypted: i=1; AFNElJ+2BQ2zGMhbcw6vS+suzSMgmho0epVI2GU+dIGgxKhZz6uT/pL8rhe0/zD+/N0C8SlQcDv33so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2DIj8TWLq922dmk7bSt0LWX2RzGlkHrvuBzGLXkFbmeXjKyo7
	5bV+5R+KGmPZtBgYoXs6A/lU+Fa7fMywoofgt2+IzS0ZrfKSi5KyZYURd5WC0xl0eIg=
X-Gm-Gg: Acq92OExbZvclhKgefnIyBAy6a+Rbndne/E05WK2a6ZHvzhgOX92aOr6H+9Rq6w0OxL
	AhE93+Tre0KDKydwjHqBksF3TGnAhPF1H3uMTm5ZfmuxbRyvoavTBqihi78ttAPlrniqx9IrmEM
	gKfoBDZyiBcuXk9dyxvzvalx25yr9ao9xGjdNoBvFW4hns4GuPe9K9UBSo9/wpUwaGdoRPU7ZMW
	DsIpwUsRsq0W5m2fRFQooe/yE5hoVwwxrKuSX4uIc701f3EwqbL6rFlgCXaGRpBJvKK4EWQICw1
	0/gRE3rGig+6tNX6+muBr8qlxqHlgfvW2Eq0WMluFY5bHdDHMtb/zPY+YvJvvpzxmLKd3i9GW7U
	PKnBpjOxRDRntaN7Krg2xxyqhML1wnRRi872sNUhJFnQ+EaeemKhXiYNQG0/b8dFNFE7obkyt/p
	oW7TpqpsU3y+FuLxZqHHDSQIXt9RQsqfbEtw==
X-Received: by 2002:a05:7300:ec17:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-30398626570mr1942874eec.17.1778845734267;
        Fri, 15 May 2026 04:48:54 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm8288053eec.30.2026.05.15.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:48:53 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: fw@strlen.de
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	pablo@netfilter.org,
	herbert@gondor.apana.org.au,
	michael.bommarito@gmail.com,
	lyutoon@gmail.com,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [RFC] netfilter: disable payload mangling in userns
Date: Fri, 15 May 2026 19:48:48 +0800
Message-ID: <20260515114848.1105927-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515100411.3141-1-fw@strlen.de>
References: <20260515100411.3141-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B96B54F476
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gondor.apana.org.au,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288287-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

I agree with the userns block.  I'll keep pushing the five
consumer-side bounds-check patches: root in init userns can
still install the same payload-set rule and trigger the same
OOB at the re-read sites, so the underlying bug fix is still
worth landing.

None of the five sites overlap with the relax wishlist (saddr/
daddr, transport, linklayer).  Same class showed up in an
earlier patch:
  https://lore.kernel.org/netdev/20260514035802.1540395-1-tpluszz77@gmail.com/

These five are unlikely to be all of them; we think the
consumer side warrants a broader audit.  Thoughts?

Qi

