Return-Path: <netdev+bounces-265536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAMaJjHCrmmRIgIAu9opvQ
	(envelope-from <netdev+bounces-265536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:50:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010512392C7
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C232531070CD
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC93BE14F;
	Mon,  9 Mar 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itXUpGGs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AA3BD650
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060349; cv=none; b=JsEq9svRHbMcRTD6+TTmzZ84RMW+HhEFyC4CP07I9pTGwVo1gMxVFERBe69GC+rn2PEwIi33cjWKzDZLsDR18bYQY7o8qGEax16APaN+/e9t8A6rS13v1spsLiWOG55zBhhoFN0JyE/tXW09bYy0IfgBNmkipGxJ/C5QWllyGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060349; c=relaxed/simple;
	bh=td9mtcqNyCoWzzi/ND+cgmuQulM++m9brhPZsmPZ8yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUkBfX0uK+/fUXcGBNHq0/8x1LQxjU49o35HyZnSbLpnJrwmQ3Nv3SGVfWdEDLTYodNtfLfdnkhXU/oxLYQZwtP7val4dkRsHJM1etzHbSGP0eNq4wE05tjiV3wHwMuGRf5YcCj6KsNmUrfDE2vO6EEJC1ggWDm9s77zq+ZR1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itXUpGGs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3598e065d8dso3793914a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060347; x=1773665147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hX/CT0FDleEvdCw/BsUoSYklLMZdXCYL0N1qTX3Ll/E=;
        b=itXUpGGsv9gkMK5Od/uIqOwKN9CbHgTwxmnP/PBX958zH/WAq2nMp6ebnp5pE8szx3
         +aElHs8YABH9BeHLy2QYQnIlDOH3qRtIi6OFTzWQ+SZ7PIDzYoRXRtkwI4MnezoCDy2h
         9gLurKUsdbfsJMpsJqG0pzkWbgsGefRRUKTLqWrmRMSQaBSC1yjcy1RZKgcVXa73ebz0
         YFijarChe+Af3V25z7ENLx+XklQxw/XdEqRx4hPc+4m8j3GWkzyJpMig9FXe67+w0/EC
         y3GT9IJWchX3jcAseGzbhJg4PjSjN039r3eA+3QqDGTsZ5dWcRjSjFgj3VyQmZiouOwP
         uaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060347; x=1773665147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX/CT0FDleEvdCw/BsUoSYklLMZdXCYL0N1qTX3Ll/E=;
        b=CqK4vI6AAt54d2rSTGFtRLhAq712azQTo7pei0Xg4/0Im00accagQEi5jZRgoehRUA
         q7sWuvjBoHOjbnpx5+LcBKJzypiI/3B/FjYloiCRG4IPzLJDOEdGEgA3IhxQ/WTipUnT
         GxbrombkjMBD2ESv1kae2wwmufnWg/MMJ4J1h57stf2F31ilxJI28GEViTFt+M8CilIY
         GFGHAVXpiizQN+nkUyO4hFejxPeesvRQFMbd0fO/xnLyPFpLPcME748/UH9X61jdBuko
         wZmeYGTMFWPY/DJY78xX1+rsbwDICJP3/DznORMiAdnlguoya0K5bB10VRYFkBTdPSNt
         uqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUySQ7ZjhoVmYbcu4x6rn/DCXcr+tbs1AAliwfmY1iR9FwMZ7I88i7upRpdxCX4NFLVk+Pe04k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVVaK6Bin3PcbEAAb5S8qR0q9oC4LvJTDw8YEoOP8JuaKAl60
	h+S/z5JHyXDBaGmdB7FBdQLcrW+pbCvT/uPuiDZ++8NcYG9z4QVc3xgf
X-Gm-Gg: ATEYQzy6y/+tdteyiszuC0WSxTzX+ZctsiUKLJepy9b0kmxQDBMGqKTUpwKAc4Cs9jQ
	vXTspF0cfuw0f4i7FeOXCI2rOHZQSgiwnJ6ROpOTGwSo9UT0XTeEiORALtk+Vk+LNkQXICkPxQ0
	8bQQITt0zxPyMcpzBA/Ln3W/cBekmgPHXveL75ePTR0Xi0ZGPIE+Fqgzd0ljIJkRMv0JMIqruhW
	j3j/JFuKheWZIa1GeRwe9mri+5xu5uo1mLpnNe9lR3TpQIv5QFIB5LF1n8Peb9dSS6jAD8drXl9
	5zFddpf10Y6C5PIGQMrfgFXEiimzRWpSDmeRSLYrMqLJ0vAyLYzixf5XUKYDU3MA/EchsxsRqki
	4gx1U+wHt/ykhIWJdlVt10o1ZgUmNNGY9ifkZbhBN9NUO8Rw5hUpkmvgxuls8SWUd3l/LVpgbyq
	t+7/tlJPvbQsxzPHJykQXlsApianAhn7kKZRGNrBpL8WZLgCXVFb+GjdgZWFpM
X-Received: by 2002:a17:90b:3f4d:b0:354:bd08:480c with SMTP id 98e67ed59e1d1-359be376e89mr9615343a91.30.1773060346835;
        Mon, 09 Mar 2026 05:45:46 -0700 (PDT)
Received: from ubuntu24-04.. (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e183596sm9178830a12.27.2026.03.09.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:45:46 -0700 (PDT)
From: sawara04.o@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 net-next 0/2] smc-sysctl formatting and missing entries
Date: Mon,  9 Mar 2026 21:45:38 +0900
Message-ID: <20260309124541.22723-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 010512392C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265536-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sawara04o@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Hi,

this series updates SMC sysctl documentation in two small steps.

- patch 1 fixes indentation in the smcr_buf_type section
- patch 2 documents missing sysctl parameters limit_smc_hs and hs_ctrl,
  including values/defaults and hs_ctrl usage notes

No code or runtime behavior is changed.

Thanks,
Kyoji

Kyoji Ogasawara (2):
  net/smc: fix indentation in smcr_buf_type section
  net/smc: Add documentation for limit_smc_hs and hs_ctrl

 Documentation/networking/smc-sysctl.rst | 43 ++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 8 deletions(-)

-- 
2.43.0


