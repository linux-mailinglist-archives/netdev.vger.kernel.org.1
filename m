Return-Path: <netdev+bounces-288050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBB/FhQBBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6811754510B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10CC43003498
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0669D2DF15C;
	Thu, 14 May 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5EPzIWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523C386C21
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778382; cv=none; b=sEuVldjNn77QBJMKL85jPUhm27R7qqBaqavxvlSTl+0Rio/jgOz6X4rbPVOerDFY/XoXLnVxRcMP8aulzP4nV/9rl5c3NY7IUA6SPK1YHgaStNXlZs946l5aehc6vbBRwQ2dgWJyqpbBZwZdP1961UrZHGxZ0qH9mDr3Zw+AHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778382; c=relaxed/simple;
	bh=J+qjlNG7yCfPi70a30kgJbcx9ouEfqYTcUcggQ3HxqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGpWkXeIIf4EeJnBDmBqY5colS5QHvjPd5FztLClyrY8w04iCvxmXD/YTZoohUE2Ca/ltLw4LFaARP+wLdBSJ2C+Mxegnskddjd9i6ARK9ZUh1iR0kZYlW4zl2mAdv63UZA9+VqJOOmtiACVHycll1HlKhNcGYUMpY8UrPPuUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5EPzIWT; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1309f4ee97fso10396126c88.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778778381; x=1779383181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsBBm4ZuQ5MGBzgA0ddyoKX5Ai5E3Bfgkd3FNlRPfrc=;
        b=g5EPzIWTEnYC9BWKWbN0rt6f3IbnYn4vkaTKUumPdGr2nICHJaiBUBbFwPTb0YPaqp
         6DcJBg2tkjj0D+6PBWCmjOnHN71B+p/mp+1yeOdlL1wcaXzUuAr4JHta6uIYMZG7nS3n
         WTQZuEeSY+mILnc28yeFy22gpbPCnQAr8WotDeR52/78ll2oiKiUckoeymGvVIMsNxqF
         IqXX+zDvLFrMMpoZeozoKPuEWckySWE9kUlysrrSlF35/JN9D6dgXLAI/B9ZKYxZxILb
         WZyFHoVbbiocMDbUD5QYEHV42t/CoLdbgEPRgm1KvWt5et7dB8LBYrKi7v1+Xem/LU1i
         Frmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778778381; x=1779383181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsBBm4ZuQ5MGBzgA0ddyoKX5Ai5E3Bfgkd3FNlRPfrc=;
        b=P8/xmuyjAP+1PLCpnnHIMSAYY+VXiPepKtQq/Kk1li5WuwGQw2sRJCA/9nXZCzb2yB
         Jcp7K2OBxmDX3mg2TX3E45KhZsCugmYC+CSKCrgy4H0kGywT6OXQg/VVxc9w40WBvlJh
         zsgwIo6Rm/2MsCrVA44TBDFB7ziklx8BXQ2lnAvd+PEgR/1o+sKskXxt1//oWCFHxoLb
         Pl3j+0JBfaz0T7xwnnTGdwasWARr5hr1W4v4DCRW0SO2Xsq08TbulTpF4CdxRp6M03LS
         cMr3+BnAV0M//mahLLKtWjvjzFN8LttU8AgN6Tg/1x7/vab9kHybkS/hG0l5c8KWZob7
         guQw==
X-Gm-Message-State: AOJu0YyxiMJCjl7uSl4jroGs1+BtY6NZg3LH8YNkNF2jM9nDZLMwEzde
	TgiRmZD43xP7XYv5KmT5/YnxgO7Nkg8DBmNmgEVq52D+/tCHOlvoRW9G
X-Gm-Gg: Acq92OFgsoX3VpgnUwVYkjz0RG9/6IU+Cm+pAV0ch8AUZLPkrbEg18us+e1vOyffbu/
	CSWMcI120Vg6HLwWZwrpuDIFmU22J+VMA6Y3UlWPSOvI34XXFrPQDlkLgHkWcmlnSYV+P1qSBmN
	ODWVH8QkvLidDL+7k6+151Q/C2LOOkkqHzNwsD3+UgUUL1N4SsaxiFNRURY5+k6oXbTzHo208C+
	Xa0p4J8L8zkhoZnepY6alszBd2Ck+szIXEK7ljiJBcaQfsFktqp2D7qyPrEbKFpZ2Ag5+8ldLMU
	zExSdKJ6QT2kSaEHSaPW4cOeqO0a1UhChAVP+EUOuhSX6aF4oxVbETlTmf/QuGye/DEBJ2/1vwd
	FB+9GtcJuii+Eq7pzPYwjUfHjmXFqAhM+cFgQhURi9T3FCjH1TRLJIc69r+h07zO8E7MYh8HIkS
	f2ecwjrdivDytBqCvmWXmwib7jwsPMAUhorw==
X-Received: by 2002:a05:7022:670e:b0:130:c9cc:3384 with SMTP id a92af1059eb24-1349ac64a08mr4862213c88.30.1778778380849;
        Thu, 14 May 2026 10:06:20 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm5349141c88.8.2026.05.14.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:06:20 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	paul@paul-moore.com,
	huw@codeweavers.com,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Fri, 15 May 2026 01:06:13 +0800
Message-ID: <20260514170613.4098569-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514165139.436961-1-tpluszz77@gmail.com>
References: <20260514165139.436961-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6811754510B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com,paul-moore.com,codeweavers.com];
	TAGGED_FROM(0.00)[bounces-288050-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sorry, v1 went out unthreaded and 1/4 was duplicated.  I will
resend properly as [PATCH net v2 0/4] in ~24h.  Please ignore
the v1 thread.

Qi Tang <tpluszz77@gmail.com>
Tong Liu <lyutoon@gmail.com>

