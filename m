Return-Path: <netdev+bounces-280996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPKxMw1362kQNAAAu9opvQ
	(envelope-from <netdev+bounces-280996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7196F45FE3C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 378E13001338
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15923D904F;
	Fri, 24 Apr 2026 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojp6IXyl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6C3570C1
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039111; cv=none; b=Eo3207MoEUmHg0OkWGRe7XjKd+hLaq4quhY7U8upbF++13spASs6YSTEU4RpxnrabeKWmxE6/gf6xGs2rhWdR6tJzlmzFE0Z5iD3OWE3FFB81vvxy5ILiskPmsNoZjn3z5PSMrCb82CKS4nkositTs0yiUSAPp1pB0rSP1bGFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039111; c=relaxed/simple;
	bh=0Z+CWB+qdcZOEp5cOyO7jH6G/XktPWmtPtKts55rcqU=;
	h=Message-ID:Date:From:To:Subject; b=ETQaq5cIevMVxeztjck1XBhYmvVvW7eo72kxMb0LDY6s9znL0XaUKR+3cqaswnO7U3eO8k0SIDBMENvdsAsg1urEqp+wO04KdcuYv81gTFeKBSvBe9iw7vcEZZ3M2uHkqc5am1aKUTdHMs4So8zOdR/I15LUFTC/99hiky0dFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojp6IXyl; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8d6d5e45c43so898199885a.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039108; x=1777643908; darn=vger.kernel.org;
        h=subject:to:from:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Z+CWB+qdcZOEp5cOyO7jH6G/XktPWmtPtKts55rcqU=;
        b=ojp6IXylXPVLXYxYYsoDmzVs4JgwN5PN5Z5T4kGqsqppELlitXCnCdO9opOv8+KOU5
         MHgR1IkCfYSwhEfco63tqPvVHtE6in8vHPgy6scuu23EIhEkgiCflzo3cEwnEDpz3a9f
         Vo1J5nQmHHZ+7vD3fitq9XNLbJIh0loHkYsPrkO/RYrvjQaSwoaSGlY3JYux/i8MzhyN
         XC8cIXN3BQnWzmyW5RURlTlidsZ+XSRh5YHtUg6/tcAYyskwAJ6kKcqOXbNgg+1Ai6MW
         txbSo7l0ZT9XUmNtM0lwTLeHXp9rX4jLJYGyZKq5lv1P41WfIX3PEk1uZ9LnNmXauZ+X
         bCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039108; x=1777643908;
        h=subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Z+CWB+qdcZOEp5cOyO7jH6G/XktPWmtPtKts55rcqU=;
        b=LHZeHqNtCQFbxfJYwqPDA0nnuEve52c6o+MGGBo9At077m7+iJKrTz58GT2O972aRw
         +lrM05xcMgfL604RK+k+lnh8UaBkMylfPb9DrCTVkxmkCAvz848kJHBl4p7QUcAqgFpa
         La1pegzhl6DoQEVIUkMoBeH0O0nplgt1BhAy1eG0K2ts1adXBIYhaSNVr3XekYOU/8ln
         OeqavNV4KVj9R/M7dA1J48pU52ngm7nXNrv96A7gkTpv6fV6gAq28cYTukjVwCCocJFq
         1cZfqO1BuiQAJaqReA8uOwnWNRNFJytVluCH3Ipz2ONH1ypU36b1KqiJgEGehCyy9J7p
         2pcg==
X-Gm-Message-State: AOJu0YxQZ7yi2CmWGM3pnOapX+9DC4JEBQ70fiIypSFltUW4sdsicfKd
	anS2aSn01ZfBT9qqEJTewVdH/NgAcUPE6fGn0eGG/uLjrQ7wyMLBdiCRJeUyMNtM1xIvYw==
X-Gm-Gg: AeBDievGVIYvrG+9fnGmtJboAqD7qi4mNii7G6YeR49HwjDi1tkc0eaGsWKg+8uQ8XH
	UUrDnwlKSkt2rRAkgeKvZ3RwIDrs3iEpukp77kH2cLMerQSSTA/+TaUPdZQqg1IAAOC07p3D7RN
	bAU3kYjnMVROz6RJMNIwiHIuok5CB+ZRlZqeLgGRWJ1NNQegIs9bhCnJfdjmUQrAZWGj+upK96J
	f/L5SLJ4UGw54dXqjm+B24FDulGIuy7WEuO/ErOLM9njMjUZjVs8jMrBt7zn7GIvBp85LN3jvYr
	6le0lR5OUhp2zq90vh0dv2Efn3jjTWt5Z/0+cdk0dpXZgs8W3onjgn6hCo2hFGJTYQDqJrLxvLG
	OHlxqg+0yWoDyiRW5zE+o2ArWiOR17gbcFCCjavc+MJMesFq6k1tcXlO+Z2qc0IyvMKQYi7pqXs
	vlV7FvMlJTUALX+tVyhccw7bC3EMywOPG/8SBGBpDgJxL9KpENgroEfdtElHqJ2pICpCxlKRY39
	Hkl75Js6vlptvtuAYTD8lTuKMHJX9hnfeqfFH8Eju+KrzO60nIumBAoVVAWwBQ=
X-Received: by 2002:a05:620a:4403:b0:8ed:d6df:c778 with SMTP id af79cd13be357-8edd6ef1bfamr2706519285a.37.1777039107999;
        Fri, 24 Apr 2026 06:58:27 -0700 (PDT)
Received: from localhost (ec2-3-148-253-139.us-east-2.compute.amazonaws.com. [3.148.253.139])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8eb9becc72dsm1469246485a.34.2026.04.24.06.58.27
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:58:27 -0700 (PDT)
Message-ID: <69eb7703.050a0220.ef548.07c1@mx.google.com>
Date: Fri, 24 Apr 2026 06:58:27 -0700 (PDT)
From: anithambabazi1983@gmail.com
X-Google-Original-From: PayPal,Inc.
To: netdev@vger.kernel.org
Subject: netdev, Your order EBFA0471GF was processed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7196F45FE3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280996-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anithambabazi1983@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mx.google.com:mid]

Sub: Your PayPal,Inc. Account is Now Verified

Dear Account Holder,

We've successfully completed your account verification. Your PayPal,Inc. account is now fully active.

Verification Details
• Process: Standard authentication
• Authorization: $261.6 (temporary hold)
• Reference: ZKXPWQMT91

About the Authorization

Temporary hold only (not a charge)

Automatically released in 1-3 business days

No action required on your part

Customer Support
For any questions:
📞 (803)-886-5964 (24/7)

Welcome to the PayPal,Inc. community!

Best regards,
The PayPal,Inc. Team

