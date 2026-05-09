Return-Path: <netdev+bounces-286195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPouBnNo/2nQ6AAAu9opvQ
	(envelope-from <netdev+bounces-286195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6704D500993
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BF403007E07
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368143ACEF6;
	Sat,  9 May 2026 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="tzyw0Tx/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A63ACA72
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346096; cv=none; b=N7eZQLrNOl114JqwRUimPFm35MBkuxC8oXM85CKS3ccoI31HMsO34MlsjKO8dFZoqfSxvEhdnPCQbWDdbpx9MJdnT5yXUuZNfUtlIVAUxVzgsk+4Wysogu6VBWu0f+rb7kColqvGy9cI2RRQT0T7ONPlo/Qa41pgyCBYWVbfxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346096; c=relaxed/simple;
	bh=2xHBxHhOw0metm1Bj2XnOoJZ6B5jE2rTXV+9FjhbGY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JdTbTEBfBexx0oTNvkGZUDeIKvxe6iVezZe4QH8vvr+iqtq+8ss41qU3og5/QdANsIJiv1e9K/NHMCI3awxS5WcLp2kLezUB4+kaJCVPVYI09Pi56KeelQwrBEUTozrO4pEt0MqM3EI6b7hiFRn2znj6j9K43CTexFxafsGNhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=tzyw0Tx/; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12ddbe104ccso2822450c88.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346094; x=1778950894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xHBxHhOw0metm1Bj2XnOoJZ6B5jE2rTXV+9FjhbGY8=;
        b=tzyw0Tx/Lg43Gn6gymdzYrf57XqFyhHt0f28Uq04/68dHQC47IalxsXaB2b1bH1fcb
         +Yuyp9wiJvcio6Y7qgy+p4AGJ9RhvVE9g2QC33Whol+P8iBZEPF46mChD+JtXC1jirfL
         EgfYSjSf0mcjam3SxEt7/pNAWYaoBxfuij5NOMsgdh2Jv30wDkjWzrChHpBKuhHyLTsb
         5sNiJu94wLLo83cWMqAeJwKVKbILtRq3NEaU/wHsNDi10inDYp+6glXrKmlE4zT/nkrL
         XMN/3ZXaq3jcMsK+GDQvTViISdXmJEDhEAXwxWJDdKKEy8WvDZvDUGDDdB8sC8ATWEG6
         abfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346094; x=1778950894;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xHBxHhOw0metm1Bj2XnOoJZ6B5jE2rTXV+9FjhbGY8=;
        b=labYAj07ScyGOd1hh4P8cbUF+hs+o6yD1s9LgoiFRi6C67zPuohr5/vlu+SjGmU7kq
         wp47Hdo+ZbAdLj4xy5cHsSx2JbzOq18TJlhBsLdAaHHSnLNoiAGGqtuJBnV6JPnQNVEK
         EgpLybwurhMRVh+VoHyF3F88rhzfjPqXrNtA3tZRSWPt20hMerfB78zVuUKrAQ1FH26T
         F3X6KZXLGS7ajo2PVWZbBvbMwx718ZGbkrum25Q143teqoeyjgcDt1/pMxCP8UwMdyt2
         kCJsN2HuwuQ9eGb9gzWlZ8QNRoHrAgQgvl+gxNXqurdvNHfy552rZnKVhnqPuVome9dV
         qUjg==
X-Gm-Message-State: AOJu0Yy/YRZyQHgxt8wZYCK+sk8h2flAxHBZXHQev/ADXzPYqMYtGxm9
	8+ji8DKyHRofbYWmKjf+j8oMT5gGMIU7btv5UCrT1un6pVA0teYK5NuMl9NiIcGuog2YVFbfvck
	pc1RN
X-Gm-Gg: Acq92OE3LH5pHdw6NJgfyy7LImYJamYOM+gafcAtcByw8tzdqkNY0jQle0elnotdzsQ
	wDV43GhNPELU+bzA75v1Ii/bHJhfXyTMO2vPp1omdfRiBb1b1mrahyDeYzJy5Dfudux/1p83P4/
	oCDkJhi0YyQgBwtfHNf+IAQA3WGWPLqXtlaaGItkm0KR+Zrl7DIUuoQMHM9Qz17ZCyeTALO1i4G
	H+saELE+a8UFZKd17xFGutQ69gJZ9Q+aU71Zhli1MYPwiY9bIPVSUaEY8mGHpgmHf61yVL7L/Jk
	sElgtb5kXq4B5EpPDx+ONoXy+E963CdFlWZ0U/WHO2EztXBaO+isSRC9o+tjLISsYJN4KYBZ6jB
	tMxZL5xbgA7QYzUNFyI3w3lr86mTGOdRlPJkVFSS+c0d+OrlFzK69cdC7DHoG6AjoL1MZ3tVDl6
	v8rg8dZoGSOW75nWGMqkKubX9RwYDc7Hn2In0h4Z0ya5imwg==
X-Received: by 2002:a05:7022:4594:b0:11a:fb3c:568b with SMTP id a92af1059eb24-131853e5b5amr7446935c88.17.1778346093618;
        Sat, 09 May 2026 10:01:33 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327875a269sm7238728c88.13.2026.05.09.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:01:33 -0700 (PDT)
Date: Sat, 9 May 2026 10:01:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Eric Dumazet <edumazet@google.com>
Subject: Is current INET_ECN_set_ce() safe with cloned skb?
Message-ID: <20260509100129.479aec7e@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6704D500993
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286195-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,phoenix.local:mid]
X-Rspamd-Action: no action

While doing changes to netem, Sashiko flagged that INET_ECN_set_ce is not
safe on a cloned skb. This wasn't something that was in any of the patches
it was a "drive by" in the review.

But it got me thinking it may have found a pre-existing bug.
The function INET_ECN_set_ce() modifies the skb to set ECN;
but skb is likely a clone from TCP. So modifying the IP header
to set ECN will modify the version that TCP is holding as well.

The same pattern applies to cake, choke, dualpi2, fq, fq_pie, gred,
pie, red, sfb, sfq. I.e all the qdisc that do ECN.

Is this a real bug? Is TCP just working around it?

BPF is already has fix for this but qdisc usage does not.

