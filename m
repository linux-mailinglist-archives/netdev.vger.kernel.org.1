Return-Path: <netdev+bounces-286631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNmHJXvHAWoRjwEAu9opvQ
	(envelope-from <netdev+bounces-286631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102150D652
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E09302B389
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765137AA6F;
	Mon, 11 May 2026 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ7AK+GV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F537AA83
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501157; cv=none; b=fOcN6NwQuzycdGoVv4g/FGPq5wFfWJ4tfBNF3XQ0DGPYB4w+IYSYCiyg3g3Ns3HFxEr1Y0v4Lp0gTxOuvmDXlK0e/0ZQteSRUviWKkhRYuh4CP1xO34nwqy1yk5SjP9DfJvxr7ntcl8OI9xv50dcn98GVJRRDd358iLWTwfr3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501157; c=relaxed/simple;
	bh=y4bazO79X2luP3aXo5Zu79w/2ssn3oIiVFWNhmrzfUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxA2LAsY6eNYki0fNSd4AuA8ToSWovjXSvAF0rBVNBF49eOu19VhvjoX636CmIo2AYpRDTznn2ZLVwx/xtQjmMgDa7+sbDWt995jwLZYI992oufokKF81p1xhymgO3/vHpyXWoRlaFLEao+KMCcmehromlbWOsZtdsthDgs+4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ7AK+GV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e363c6141dso2655497a34.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778501155; x=1779105955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4XcVvpH9Ox3FvY9rNYp2Al5P5pekeYZiWZMMmvoOw0=;
        b=PQ7AK+GVwCZ94XfbfgiuVnmKhUGeVxmCLix9GVJJoJHTdJrSoPqqM/UVjJoHdyG2m0
         TbgMLn6mWOz8m+hfBomf7gj/F0gl/NfXaJWYQ5mfQs1wamLYpOZ7baXP9iQBMqwri6jg
         LPTAgXxtAheE/hbQkL++PwLeSN/So0pN3sCd51PlVz+N/uacmID3OSS+6XSRU7G5wsLx
         iWWKCUPnmTN1R33DqrZ6KwyaJ+Qbn4hmlOO+Ry+0y6UQqrmU0q3j9KPbDSxCSWAZiICN
         2fndhVbZBmiI+2tYTOSWtp8BhjNprHdXfITEqGkEjAt8ubiE1AnsT73H3sB6yux2O48z
         0bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501155; x=1779105955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4XcVvpH9Ox3FvY9rNYp2Al5P5pekeYZiWZMMmvoOw0=;
        b=EXwGOI+zysmOtX9aDGlQ+Upr57TFpg1NgxrrMst1rrPw3jNTHh4uz5goEhMzshEP1E
         PT0DxwBu3LWtrKLrxAmz1CHP4TImsB8L+ooZ0ByFAE9EfUumwxzUofqk6ZGD9Sas2NZd
         alSym30PrHwiIUsA2BKuy69AQU8ZwFvTJ0LNYx8ziXPkjcihMjIIlgyDhQ//Hp+xWgLo
         0z8rJ7bwGCK/Ek8gwgV6c1NHEr0VkQyCUWJDRTRLR2FiFjaVS08MX+2fJtJXvfJO1mBX
         yESAHeFi9fV2Ub80ETTcRVdW3f8/1yPyTChN16B3Kv1iD35ZMSleO12vqG9ljAQPKOv6
         46HQ==
X-Gm-Message-State: AOJu0YyFkHHxE+WyHqhkKgrtPvxuD4CFdaEPHoGP8urzrlJlPwIa2d6b
	a0M1nUO2VSpmc1LKc/WGO/0/7xesqk0yFV0RCJbH07cK5Bh4Qa8V7ogUnglmKvX4d68=
X-Gm-Gg: Acq92OFT3bNuGnACzwTSirRANqhK/fDZtTFN90g6fk95vVUooBMBHfYFrb+dJ+GuzkL
	POqrOnMPFw9D14TsIdcrks9ln3RB6det3g5b1UCbBO4tRuNBZpgscdDYhFr8W8GEJgzfaLtskHC
	OWkLrO0UkCRSKArsbnWlnFqUecSojneKLJ9lllucq/Tt2Atlsk+e+HI8ZIQSxaGFyqJuyJm9ILV
	ekLEX02kkpG+j3nx2xc9MSGMIBOY87oQmZvJ76bdnPRIfLtw2j7QylzhC6dSKaZWkNTiYPcPGNK
	E3Z4g28Uh5TY3pWmBZH8l2h1lKNIjccaRSZ8QCb9vU9zpemN0P213ve29aL1Eb76vE1LG7WT14o
	ezfS59B70j3J3X6a3tMK2szMhJRWNEYE+Elha6EKqYlX+9FQCN5yeZNSGsO0bvzBqR45J7BRZ+J
	2AVtHvpK4MnIDf4Fs=
X-Received: by 2002:a05:6820:150d:b0:694:8b4d:5f8c with SMTP id 006d021491bc7-69998ca0697mr13574825eaf.12.1778501154591;
        Mon, 11 May 2026 05:05:54 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e0e79asm5608123eaf.14.2026.05.11.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:05:54 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/2] selftests: openvswitch: add pop_vlan test
Date: Mon, 11 May 2026 20:05:43 +0800
Message-ID: <20260511120543.390702-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509135423.3433910-1-houminxi@gmail.com>
References: <20260509135423.3433910-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3102150D652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286631-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Found a few issues in v9 that need fixing, will respin as v10:

- Commit message for patch 1 references removing MAX_ENCAP_DEPTH,
  which was dropped in an earlier revision. Needs cleanup.

- Masked VLAN format string produces output that cannot be parsed
  back (round-trip failure for vlan key with masks).

- Negative test in patch 2 lacks a return flow for in_port(2),
  so ping fails regardless of whether pop_vlan works correctly.
  Need to add a return flow to make the negative case meaningful.

Minxi

