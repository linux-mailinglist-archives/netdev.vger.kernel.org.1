Return-Path: <netdev+bounces-257465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA7bNyN0hWlzBwQAu9opvQ
	(envelope-from <netdev+bounces-257465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:54:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86BFA2C3
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDFB83006835
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 04:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9699336EF8;
	Fri,  6 Feb 2026 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxkOTaw/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38EC2E62C3
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770353697; cv=none; b=j2UM+W5FVj8tjp1T6U/1rXgWLrU4ND2mEE8SI7h0HDC2RcP438jSU6rtFH3IElwesiogeZRD/T0urwec0awieDszO0oP7ZarIJANAgfznfcSgeMmh1MwzEXb7GrP42m/VJ6H2tsXOkHAJ547lo96Nz5BNmWVRupkZs6k8XAs3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770353697; c=relaxed/simple;
	bh=PlHFFdGueYam39J3KxtGgbJHGJBfEpbJWejTsKCw03Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmdMqkq0vnp/kR4SzqtG+4Prv8Te6wd6PpITJQHSis0tVnHYxP3UzZ92uAdq5Ba8rlzHqh1g+nPFAIoBW/la180hBmyycSVc5booZtgcw27ssh6titvi8iDR1rr+A9QtnKWuc3ZwJ5UEBwdBF+6rDJ2CgvBN9bq+eT/HORS+Id4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxkOTaw/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29efd139227so1864695ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 20:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770353697; x=1770958497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlHFFdGueYam39J3KxtGgbJHGJBfEpbJWejTsKCw03Q=;
        b=BxkOTaw/x+snswsBuyhCo7GMpvOnv2+E9h0B46YwX37s4bvbGpZGutUD8EtH7wk386
         RZJAWnI7AB80eFvVTtsZ9gm570SQ+KESw1YA71Jju6Uodh39VVv33egWR+lkmeHeQsoY
         KnOpUtNO5YT0dlmikRhKhf7nvsio/jVERSCvXG4hrKa1w6J2LYCDFx+3In7IPH2rds9F
         6N2zEbwg2ByJjy4wpieuEiyvXK6eQKmDkitehEJsxIkHW26aDzBteCoq1Cdr2aK0kwVC
         q9mEwgxSdJQL/fXrJpk0CgYHfknscGCNPQRZ1ivfW/LreLl2H8cxH23mm7h390aVKpFm
         upaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770353697; x=1770958497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlHFFdGueYam39J3KxtGgbJHGJBfEpbJWejTsKCw03Q=;
        b=Lsiuvlzc+9d66dNU0e+qb9J2CsEyQtd1igeM1gp1bcv2xCB64UhHKqF7u2okIB/PKi
         rAp69MRgvFprv9siZUqm6Pjf/7bgaItQr0OGqkFuFkbeWV29dtYqaAJV1vpvhnWRWf36
         9rOOEh5sq12S3eMOaab7H6zf6CA8mXALyMrcy5El++PaOaqlWFs8nbtw1b93QMf3LwIQ
         WDWLZVhADB1KjP1M0C+m31aLZDiuHV9ferADIM9ynuUHonNLtX7BSZoMdLinRsNj054d
         Gt1J3o+Fd2h5BaJxbrtNbH0CfblMdbo1sFMe/zkDVSJDGu/UqcFT2bvJUeXFm668I/rx
         ZDKA==
X-Forwarded-Encrypted: i=1; AJvYcCVLGIxmsASFSKcbDEWgQ83NuwCNxypfszWVVPukVRcPLwOGJ19z26Ea3V1kncBj3OL+zWC9Hmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQTiTJOitIS6YXFoxINFl9KqEF8l9pBA7YPZq8x/mYbPZrcyK
	kF0bR4LqaEhcXfARlTKocXU6WyVzMfKrsuKTx+AcHS9XKfRwWYM3xusG
X-Gm-Gg: AZuq6aI5FasmdC2QKEtGagrNivODkiC65VaojY82A75E4PlLbWSMn1FFVto4UaiDx8Y
	S9SuHDBlYtNK9Md2m0axMxakVMaamGO8lZPSIFLb2jTOIe2SV0UXy4m9pltFULFlXYLQK6ox0UV
	GrfEdbQL80QVYz80riBJv6B2ng3vrJs1B9cMzmxGTFn1l9+9n5nykycuoqs9CW6YnaWOZGzSJuW
	UXhdXSmKxLAf3RCv8SURqxQIREqDrYDYQdW7hQR0lB4Bq1FzVW7j8BJryXeRmh1EN7lesZ4rYqV
	at55tvmI1nnvLjokY19IRnJYoa/43rmU+dIGeC2XKSb2RVNyy9M1QhhGv+Pq3BqlbG6yl2TBNw5
	98t6PIi8VourdGu1fz4pSHP3adhzKfMBJFAaMES/XqWIxQYPVITl2gDEJRvP5JDQG9loKiKCIsE
	OQ20o4lfLA9uTPTrilb8dHwiHGuMwbT1KTGheOmeriCrKjgOWJjLRgp/6HEv0oxcBbFw4rWSH/
X-Received: by 2002:a17:903:b4e:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2a95194aaeamr13854855ad.55.1770353696910;
        Thu, 05 Feb 2026 20:54:56 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a952217ffdsm11599825ad.88.2026.02.05.20.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 20:54:56 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: maciej.fijalkowski@intel.com
Cc: aleksandr.loktionov@intel.com,
	alice.michael@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	kmta1236@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	przemyslaw.kitszel@intel.com,
	tony.nguyen@intel.com
Subject: Re: [PATCH v2] ice: fix race condition in TX timestamp ring cleanup
Date: Fri,  6 Feb 2026 13:54:26 +0900
Message-Id: <20260206045426.3547398-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aYSeb42KRzlc4SbA@boxer>
References: <aYSeb42KRzlc4SbA@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,lists.osuosl.org,gmail.com,kernel.org,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257465-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A86BFA2C3
X-Rspamd-Action: no action

> am I reading this right or you only modified flags to be bitmap on Tx side
> and Rx is left as-is?
>
> Would be nice to reflect this on Rx side as well, but I know it is out of
> the scope for this patch.
>
> Would you like to do a follow-up patch for that which would be sent to
> -next tree?

Yes, I intentionally left RX side as is because it seems less obviously that
rx flags are touched concurrently than tx ones.

But sure, it's a good idea to make the handling more defensive on the rx side as well.
I think it can be a follow-up patch as TX has more obvious race condition.

> Also your patch should contain the tree you are dedicating your work:
> [PATCH net v2] ice: fix race condition in TX timestamp ring cleanup

Didn't know that! Thank you for the comment. I will follow this in future
(I'm also happy to resend the V2 patch with the updated subject if you think it's).

> As for rest of the stuff it makes sense to me, however best if Paul could
> give his ack here.

