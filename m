Return-Path: <netdev+bounces-262457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFgHDJW8pGkeqQUAu9opvQ
	(envelope-from <netdev+bounces-262457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:24:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B381D1D8B
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F0BB3002528
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541D375AB3;
	Sun,  1 Mar 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPV+CLmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432F36F419
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403853; cv=none; b=PHfQABXtuGvO8MR0oDdFqudGBTbRNjmUXXykG81eImwOJl2F8FaoEPnxd3w9aFbqmKur+/Escyr6CuSHkKed/8g31N58iXPj0tpbO1Cb4Gbydmipmvc2zZIsTPdmygR2hBeoq4QV/AGgQcigwb4Y9xVDyfBTGLJmZDMLr2I0iwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403853; c=relaxed/simple;
	bh=S2LpXTKHH3FqjAlSHSXSnNqRgaeuF6Syz7u6a1kowMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ev3asNXVB4Rl+KL8tWHxwxKgbaRt3Pa3dAI9aH7y64NWxQZWce9hHM7TkkBOZL+bwmHQ/gS/WVO7y6z+CkBy+whnyQv9U/XTk0fUolRSl+l4T81WRS0+jYLLoPeuhWkULeNAAFP6xEs3KKeqrlkW4KMpISaH/1KKqbjJ5VwnICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPV+CLmz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899c3441177so66380076d6.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772403851; x=1773008651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2LpXTKHH3FqjAlSHSXSnNqRgaeuF6Syz7u6a1kowMI=;
        b=RPV+CLmzQRh1ZIEgmoQtqde3nWUvANjOf30O8bNIZX4OKBLy1Hnz/17aHHelnre+kq
         1TnYBVjDN4GnZX6FHTYoe03qZQKb0FGihR8eRogchK3pdOIHJZuk6sSkO80DDvheYXcM
         4VJ0UcHEZVZTvR0jQJ+Tahmet1yPGJJitUOuYSnOhYqbWJw+eaIKk8h03aM8PNd0TbDG
         9aDW4tkNMlOSgV5qp91CIHIVN91uU41mWxoHexMV7wHBm+aYy8JESxuHyqBqzkS2Yy+N
         XmmjJOZvJ4bafM/J9CNwsS6jZcBfrThsfebuCT6HSjpwrHJTFviA5yA3481xRuN8Neh+
         m1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403851; x=1773008651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2LpXTKHH3FqjAlSHSXSnNqRgaeuF6Syz7u6a1kowMI=;
        b=s7KnkAJGUVciN0GE3YMBVftZZsqJ6wGigIcvRH+JPlrChsNFoqxgtE6+SPwWODOait
         IsBzCtu9HWvNuk72UGMp1omSulsligM7GBcPlvtgMpsXh1j/45Jk0X+r7yD4dHbYmm0w
         pgC63HuCPaPur4lCUczSHnYIGI6W9Xw8U9dNBQaBHpLHaZrjTJtP9lCYbwEuMHp44635
         fP7hvVpj35O5XddslDLU8Mdcbx3U7aCSE07s2t45Djw6CV0XxycQnsctd+gxFHPf/dfS
         aLZHri204H2nEUysQqxQbAPYgNyUU0jKkszmqO/JuI2SBLugQaVwiXzw9Mgrv2LCcyC8
         IMdw==
X-Gm-Message-State: AOJu0YyeKM0x7Y+e9ivle1tM7W2kY1hxvabEnyqGpQ7uJNnLaJYM49PQ
	NOewuwbe/gcbvHhBn6Pm/5llZTHZK17ykbbOSaGInyoY7krtLO3Tk4Ma
X-Gm-Gg: ATEYQzwSg8shYXqYIsKDI9PbD5qxW3a8KmnKfiIS8cnTTFAF3ke1pSmjs+RmspcPe2r
	2QsxHJ4YUAN27KvFFZE7PV8smBpInqcWEfmI1CnlvS8ryGVKfFwZEON7dC5nLVRAmvAhjEspLln
	+Qwebau7BWly5QiwHzHfdPfPY0it1lesbpPHyTDgRtg8bxcWelUs8AUnBYYOyH/T+tZLk7MitZZ
	OggS2P83fsGNRO7fDX8jB+dtqU9dvfBtX5OqQ6cmGxGYPkRwSHiFmddjouWAg4ImQyJUxw10f9k
	+LdRqdIWoMwzfFsv1YpNBO5DQuXN6+VNfxG4wlSVboiNpy62bphEfN6ahOQ2wcA8vGWLPe7KC9G
	NYy87IvdkIJr+vvCAYDRd/FVVxYhVepnejoD3hX1JIIJAhrhDiIZbN+VZKb1PgyvkFLlnVSDlr8
	DrgEOC48MhpTMFZZVzSQeFHXEbgdf04WwpMYl1TjjJc1Dqnj2Q2J+dYw==
X-Received: by 2002:ad4:5fce:0:b0:894:6112:457c with SMTP id 6a1803df08f44-899d1e77906mr138637646d6.56.1772403850873;
        Sun, 01 Mar 2026 14:24:10 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf7175c6sm1027263785a.37.2026.03.01.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:24:10 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	hdanton@sina.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: Re: [PATCH net v3 1/1] serial: caif: hold tty->link reference in ldisc_open and ser_release
Date: Sun,  1 Mar 2026 17:24:09 -0500
Message-Id: <20260301222409.1553551-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228094741.1e248271@kernel.org>
References: <20260228094741.1e248271@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,sina.com,linux.dev,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-262457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26B381D1D8B
X-Rspamd-Action: no action

Hi Jakub,

Thanks for the guidance. I've reposted as v4 without a cover letter and
CC'd everyone pointed out by get_maintainer.pl, including the taggers of
the Fixes commit. I also fixed the horms@kernel.org address.

Thanks,
Shuangpeng

