Return-Path: <netdev+bounces-263195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMu4GXzdpmnRXwAAu9opvQ
	(envelope-from <netdev+bounces-263195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 920361EFEBF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 189A0301BC0D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0633E360;
	Tue,  3 Mar 2026 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0D2a/0WO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E24311940
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543267; cv=none; b=KkF3IxnGfP78qb/1e6eoYXD+WiKsTlYyhKtYzg+ywMdQh0MsQ07BWCm1uXXtWJt1SvDgl+AljJ6aavfGKSKq/MTtYdYIJI+XaT23ebQX5mgC74e8o+7KpyHHBdR7CPPijLL9mYoxEeqIP0dbDWDUytr7QojVD08u3So3PnvfvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543267; c=relaxed/simple;
	bh=P7uBXAD8UGwKJwSEQ+P0PMrvtswuFIKZebErqOSpVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RykZldqh8p1UhFM+ZmHqUsM6sWYfTKaQx0+5sHgWdAy11ymbUFJXzSwANzYu5HTtJJrAQ7d2wo/gOn3ir41rj4T99blXm0lkQ6mRGSB+ifogDjiUE/oiCp2PUu1tw5aoZLM1aUNZu7U/0Li4+hC04c27W92CvToiLstGzjBrEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0D2a/0WO; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94a231b285dso2998519241.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772543265; x=1773148065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSFvuHYraGGIGL3b5V3p77h34Yf6133w/ppsYKFjvTE=;
        b=0D2a/0WOSvdASNu/ygthi3GuHtmt5X3cvLMwZvWg8lYW4C+BOl8kYaUteIV+6loz2O
         20TRG7+EiF+ct04cGdqNb7joDFOBVHwD+VSaU2vGBzI47Ze1wNvIj/rWiYCWZSA8Pe7v
         NCkWq9WibQ3k3gWwRogtkk/nmJAhIBVKz9yIY7mUq2AJroJelS+bHE7zWiapZShVLKkf
         M10N3nebGTAzgRWbMMfDERvLRXXSOZR47GHty6gzoudUEpQmYeLAIqTUVmdqFNH1gIp9
         Joptd5Hco6e00JRdtXXKFx9jKzS9OfrAwz1f/YlDBM2tkVpTNgAStc6lCAmvvHIVtQo9
         Czyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543265; x=1773148065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSFvuHYraGGIGL3b5V3p77h34Yf6133w/ppsYKFjvTE=;
        b=qqGNr3etoktCJ2cjzoA0qi3WMp5CeT0mbgaWAkPchHJYmIuJ/88rwrEeYeunNWIAaF
         O47w136vrb1w0+gwoEQhlPPLeuxOdjzxytjV7x8TUYalVNHkrSHQriFPr6rdLP+OygxW
         vCRO7IDclBB5t802ZQuAzO0cPWFxe0WycTb+nEKF2Ezq9nYboK7yRQUXmbV8MN5ix4nM
         yLCUfTwuDMP5w4hYjHelCa9EBB8ruyhuNKRe2yalL6O9YdIaM/TXHWrpyOBSS9EhcRIB
         +evGArDwf5RlcIl2H10fDu2Xxr5sr7nOix8smMMpoQa7yU5NCfsLh9Hv9tSq1WjHT52+
         Pplw==
X-Forwarded-Encrypted: i=1; AJvYcCUMBGFhODN7HJbtTIBZb/7Da5z5X6fSc/XtvSN1AKo9K2bk78yPy0/S8EGPi1Kb5PJiFLtxXbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyxymiKsJ1OroutpZshkZbb47WWkOLuvAvN0h1NTtog9tjhko
	rPEjYsqmE3gFh933HMjH1MpfPBy9YO9k1RvlkXTbtp6SEU49my6Lv3Hz8rr2BltXoQ==
X-Gm-Gg: ATEYQzxSpV1KNHviLhdhyh3LDal1kmWd1NUQqS1PNtGzb1p23ZfXIKW9jzBClWHe2HZ
	VYWRnIUUuUKLTXQdzupsqYFIwGMEWPuaj76hQEgTF4Iab5x171I4+yhdYT3fINNimRMUD5QvjLn
	MtA/qYRESRv8dQdnOFom0jQM0fWcsYkNCAaxU0ln87FcY5waNw6OqD3xf3iAFV1IgiSjFldBG4u
	9yMPgC/VB3ecirD7nYCvH6IW/gz9spYIlYTs/VgFNzY4+QCu4KqjLI28L+t/DgLSNphQvlG/2Z3
	BKy+ltf57oIMoovuZiWWV1O1xR+vJ0QGl8DTuVX21mKa/YIW7uR6CEeIOgCUo9qslHtLjWyEz61
	+o3Cfk13WEVGan+D1kvNK+K3P9oZ/ltrFuHtkcYAF8/w7Rnkt4Tny/Igz0vpzvS8KCcVMBVcO/r
	NE1pkE3QQ=
X-Received: by 2002:a05:6102:a46:b0:5db:cf38:f506 with SMTP id ada2fe7eead31-5ff324e889cmr8080863137.23.1772543264603;
        Tue, 03 Mar 2026 05:07:44 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e80818dsm16583894137.5.2026.03.03.05.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:07:44 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 v2 0/3] Add JSON output support to the remaining qdiscs
Date: Tue,  3 Mar 2026 10:07:30 -0300
Message-ID: <20260303130733.540278-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 920361EFEBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to the remaning qdiscs (HFSC, QFQ, muiltiq)
so that a JSON qdisc dump outputs valid JSON.

v1 -> v2:
- Fix bug on line printing "level" field in HFSC (Pointed out by Stephen)
- Emit HFSC d (delay) as a raw numeric microseconds
  value (Suggested by Stephen)
- Use nested JSON objects instead of flat names with spaces when
  necessary in HFSC (Suggested by Stephen)
- Output bands and max_bands as separate JSON fields for
  multiq (Suggested by Stephen)

Victor Nogueira (3):
  tc: Add JSON output support to HFSC
  tc: Add JSON output support to QFQ
  tc: Add JSON output support to multiq

 tc/q_hfsc.c   | 27 +++++++++++++++++----------
 tc/q_multiq.c |  6 +++++-
 tc/q_qfq.c    |  8 ++++----
 3 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.53.0


