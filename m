Return-Path: <netdev+bounces-300063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OH3nIzFUMmqqygUAu9opvQ
	(envelope-from <netdev+bounces-300063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E227F697556
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:00:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VRbMrlvo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300063-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303D4301110A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7213B8BD9;
	Wed, 17 Jun 2026 07:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589703C4154
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:59:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683180; cv=none; b=cPfNN5SJ9RkNNrOBsk1RNiGiZkeRD/OqnpjMQPuYfUPpidPGdWtEsQ3o35O33B2qXj/YLPbdtqBrmPXV39AAxXnDWE1XlYOaB5XdPDJIJ+LxoiqVo2i27dcXzIhhDELZuh8SRprgbvmsP2tPGJ6R8grCAphj+bjswjgd0iF31x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683180; c=relaxed/simple;
	bh=A3GAMuRshjtA+BCPsV8T4r559/tQzjz9ppRESXnv06g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lC+/hUUp4Sb3bTKwD0JrhQ773J/Ye8BxojXA1czuEGV0Z6FDnQ9n9k1LYDAiR5U27i3Hu+iPpePByMa3LdZFO/SUrIFUGcyTEFhREkP8xW2BfdZZ/qQxTJXSb34+54Lu994DLbOxP2Grr+L3QQbo7ulSdxY62qAOaB5OCD3uQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRbMrlvo; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37cae998401so182925a91.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683177; x=1782287977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3GAMuRshjtA+BCPsV8T4r559/tQzjz9ppRESXnv06g=;
        b=VRbMrlvoap86rx6IT4aUBB+eOHAAKElPBwqf68dGBtEZ8Vbvpi/JeCdH/+U3gBtQYM
         3d0jCQD0dfn4H5VGlbqUHN54RbEO2hTAR9etSZR6377szZaSN8OcZTaM0Th+YrW5Gvz5
         42mq+4q0qJpbursPvW1Rcyp0YR383PSxwhdIk6vSDOjvRFxTOSyH0QnC2kQWfJTcOAKC
         IzaD6e69cfa22yKglLBdcocutzRBz/LqtPTBpYJHqL1DynfIw9JkH6DFVzNP/fO+QGxG
         OFSQGzGcaA9+nXOrEXIoDlWPqbgC0XSpsEXo/UvR+ve6iqDpSR/kOP6p6+NUtbkzZ9P/
         qlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683177; x=1782287977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3GAMuRshjtA+BCPsV8T4r559/tQzjz9ppRESXnv06g=;
        b=LCGV5u3CD0iuTNH6RUjdjjez9oYBQHjCIV8hiRjGXE0mvm/i4+1aTW0KDfuef+cNyU
         Xf/26hRv7L6Q0xUr5lpiSaCF9Um4LfNdvoV4gxRu/q2I3puwoKZbXQwW7/lQpfS02Qre
         ThP52MiuKxGRdk9Y8nQiCs1VRe0ie/bGEXrSZAWZVubJAVm3lcQq4FXSeIBdZw664CzV
         pHelzjIaEdEM3RnLwxm2CC9UpWxUlMcE5U7BQb2qAp71MOIA2zsfcNUz+vqDAD6Kba0a
         YM/BO/HEbGodNJuizn8oCf10qzKqlb+FyDCuPaLnwqOCzO1PXTyR2jkYJbxGzZQkr9Hb
         BGLg==
X-Forwarded-Encrypted: i=1; AFNElJ/v9myWbDWmB7iV1Hkg6tQofkfeTLz6AUQ9IEBRoGpB0dzno9KPoMPQTHV1nXEzfBHkpWnLkfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZqo1hJewXwT854Zk7mBH5R/a4mhPWdcfKf1hCzDzbdk8ejNa
	ifG6RBmSmLOdvO1vOhpMxcF7/JMJ/22MyrNfUsIdqpIpevXv2bw6gLLL
X-Gm-Gg: AfdE7ckM+SGd8g+72vWWV+AmtccsMXWh0Cs8IJGyYnIKnzBk+S0OL7dyW52iZUodAaf
	8PuGeduxjd/Hq2Giz3f1PvIpQ7T/9kszhUgEV2pUJwk5aSXCBdGGBTs55OLLDYefezkhrmUT3Vx
	CueWt1fr2/iSKUwrFVfvxQq76OJnx8I8k796lLEaCWav4oejPx7sGC41gip2WN4v3iwh/0+8fqt
	S34qLUw4kBddUJmVk+umko0zQm2vELYjGHkmZV01ExdNpHn5FwM9ttHqWZzREGnQ4ARtf+p5/qM
	/4TJvlpJsYiXosMUBZ/cEEW8Tkgey3G3hoJg75TWJaa7Ci8DsAIdYiIwpf1BIVmuUt5gV9jJ6OR
	JPUS/awF2ghBblJ9Y1nS77IrOarXePMZGfgeljaIkwo+EcKXBmKo+NT26/xwv8LEINFUjuLOquk
	8bkJP8FBI3q5pE3sR+OqaY2mYv4K9j8Is=
X-Received: by 2002:a17:90b:4f8b:b0:36d:633a:e8aa with SMTP id 98e67ed59e1d1-37c9366d955mr2768787a91.13.1781683177276;
        Wed, 17 Jun 2026 00:59:37 -0700 (PDT)
Received: from localhost ([2409:40c4:1ac:d898:fbf1:3aa5:fc3:5b67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521aa047sm6342095a91.3.2026.06.17.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:59:36 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	lovekeshsolanki00@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH] e1000: Remove redundant else after return
Date: Wed, 17 Jun 2026 13:28:55 +0530
Message-ID: <20260617075855.113719-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ead7bfc9-3978-4442-9cd1-23c2182b36b3@lunn.ch>
References: <ead7bfc9-3978-4442-9cd1-23c2182b36b3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lovekeshsolanki00@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300063-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lovekeshsolanki00@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lovekeshsolanki00@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E227F697556

Hi Andrew,

I read the documentation you linked and understand simple standalone
cleanups are discouraged.

Thanks for the review, I will drop this patch.

Regards,
Lovekesh

