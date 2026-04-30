Return-Path: <netdev+bounces-282892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOOeCiRy82l52wEAu9opvQ
	(envelope-from <netdev+bounces-282892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D44A48BA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D5C13002B41
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E319D074;
	Thu, 30 Apr 2026 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1DCKc4T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB9175A6B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561348; cv=none; b=qHvNE9gMxQIl7+4daPlzwhK4kJlkst3OLkN8WRb1hbip7Icx0q8gxfS/vGCpf/OYwKttiXxXQnw0t67hZbkL5E96ns12FLTroixD1C14Dac12s3Mw44G1n4ZUuWNgrhHOYpxXVl9ZotuTBTMmewkyNqR63BpzwbuCSsEDwbKY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561348; c=relaxed/simple;
	bh=Qf5EwEZ/zcsWNZN7V9odAiTG92zYEKKGLmXRjkbKMw8=;
	h=Message-ID:Date:From:To:Subject; b=cotxvhMY2O8li+B+6Ks5CFjLa3al+s/AaQc0BHs7+0gFqVP/HQcuhBpBOVo4wDoDTfZBLeRBwXT41YTdOxKXelB0cAjGF0yhleDHMTLJ6PWRboH+Wegvo3tv8AASPPKfFCr5htC2J14k1PO9t/RDjW6HXc1s1zAY5/d6NBd0Ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1DCKc4T; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c726f46baso1632307c88.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561345; x=1778166145; darn=vger.kernel.org;
        h=subject:to:from:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf5EwEZ/zcsWNZN7V9odAiTG92zYEKKGLmXRjkbKMw8=;
        b=d1DCKc4TDoLvVCB21rm9I9DMq207qp7Fsnr1AOetfsZQE4UJxQbUyBfs5ofr7f+U7f
         pMfNAr2JuhLfafTxv9dZ1wHL+U8nAgCZRI/b61AycpLSCGTs6p7/tyZo4aIwX5fHgyOO
         1f5oZPr2BheBcFlmFzpKf3/vMXa890hQ39KzTW3FOX+ls+HAEzwVODVBhVjOy640WRax
         UztDp3ZFoHHtXPbD4ZYQVl8CRrF1A7Jz1Gk5vBcpg9XrunrTi7DE3QD3xCdvaFC+KFM6
         8srP+VKQc18Pvrg9rkp8v8gW6A3N2bcas+lycm4ZMRzPOdl6OAy1YQiscEYXQ1YhugjZ
         bh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561345; x=1778166145;
        h=subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qf5EwEZ/zcsWNZN7V9odAiTG92zYEKKGLmXRjkbKMw8=;
        b=Xj9obP2DXVWXHuScf4jj1WljzOV10X5T2TnUtfeosesAIvnWyPV4VlvVrpuIgb5fj+
         2EXmwVK+QhrIOpVtu8lSIYVkP8eocT1mUfLlP2JLOsHrGiZ0rFcwyBKDiSvgurs/+dNh
         QYeXyoIeGr3HvLNEw1GCtxay703c3Q1pojvPC4DdgFzSkyxNHRlIVZ0Tuw32zjeWdgDz
         TARv3SCa0YOB7/YGdUXCwNf99edbmQiDXNiPj3BonPSQix1ouyvHHkZ0Gq6ZDgXw02lj
         WOabxD2CFYV5J3BU7q/7QoumK8wz7K+r41JI1oGIxGF+3eQQnDHj4MMu/WnC2teH8Y7V
         R/Cw==
X-Gm-Message-State: AOJu0YwLEl2+VwKa/AuipnZ++VedBLl7/Blh7xJfD0ICDe6oQ65s8ED3
	i38czRMXIG85e8hRIgvlLNdA9zCI+a7a1HXSrAdW1TN1vmVLAOgq+IF2hYw+QLrLpOlmqQ==
X-Gm-Gg: AeBDietR7sOzfUlAwL3BrIO497mRbtUyfVBqKfYx/cKtrUp7Be+8qbTR3XK3u4hKKqx
	KXz3WszABIH9xF2oMOKSuNXabmThIZlrw7ib6wb9/gDb7XYSjy8Ty4z+S/9v1GeV4h5N5Glwafn
	37QfoY4vlgcmiK9kdMle/XQF6hIx6o/6OVyFWqPneqYQUAMZq8mQeH0g5DeCHh2EMCk6pAOjM3k
	CmbVqyNX3GT05rAXHyfFyMfLZPiDFftQHbjc1nj6CwXN2jDXTE5XwfHdz+snnRdGaJGPnAkeQoC
	U1sGgDifJZTJGwfgELgjYnvs7ZKraa+ia93KeqPuXd0kUMInjalsCeor66GmDNiiedwIixhIXJD
	I2fBH2VgnvlvDjeTlQ7wq7y7BlupeIFHDEsIUMUc0Kl8EA7SHmLvNs5lBUE3G4admc4ubGcZtuB
	FQZbLvMNHGX8fNX31pl2E3DJ+MKqGRwMcHJDMMJTTMJSPswRlNhQwV8EfDoJP4z0aTzc711nQCh
	pQ16pcXDQDRY5eUhPaBoZAYH2VheWaprJrLtjbJ4f9Ushp4zg==
X-Received: by 2002:a05:7022:ea32:b0:12d:de3e:86b6 with SMTP id a92af1059eb24-12dead2ef91mr1258610c88.38.1777561344948;
        Thu, 30 Apr 2026 08:02:24 -0700 (PDT)
Received: from localhost (ec2-18-119-103-187.us-east-2.compute.amazonaws.com. [18.119.103.187])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8b3ff474374sm19875066d6.40.2026.04.30.08.02.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:02:24 -0700 (PDT)
Message-ID: <69f36f00.d40a0220.c9b0c.d1db@mx.google.com>
Date: Thu, 30 Apr 2026 08:02:24 -0700 (PDT)
From: ysaminushawai@gmail.com
X-Google-Original-From: PayPal, Inc.
To: netdev@vger.kernel.org
Subject: Transaction Overview – File Attached for Reference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 2B5D44A48BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_NEEDS_ENCODING(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-282892-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	GREYLIST(0.00)[pass,body];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ysaminushawai@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,paypal:email,mx.google.com:mid]

Dear Valued Customer,

We’ve detected unusual activity on your PayPal, Inc. account and want to ensure your account remains secure.

Transaction Details:
• Transaction ID: 641029-9798
• Amount: $492.45

Need Help?
Our dedicated support team is here to assist you:
📞 (802)-278-0978 (Available 24/7)
📧 security@PayPal, Inc..com

For your security, we recommend:
✓ Enabling two-factor authentication
✓ Monitoring your account regularly

Thank you for your prompt attention to this matter.

Sincerely,
The PayPal, Inc. Security Team

