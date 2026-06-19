Return-Path: <netdev+bounces-300598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GXP/JyzYNGqGiQYAu9opvQ
	(envelope-from <netdev+bounces-300598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:48:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68B6A3FAF
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:48:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B2wbxIFm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300598-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15BB630205CE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE82322768;
	Fri, 19 Jun 2026 05:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BF40D599
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 05:48:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848104; cv=none; b=RJurmwHvDar+tx81lK6bmUgsYNYstJ8twx3dyPfZAHPoS2qxDNWDWXMELhEAParbdwUxkMivD9ii6mEnfW7kNfaQrOObAg0gVraV3wTbpSBBbHwS/QAlk0ZAY+gdkdQ+Pp1UphIQMG3qiLPm7LLXDuN9SsK23EYpn2lM7C+F6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848104; c=relaxed/simple;
	bh=cooLtirQK1VfrgbFbfezM8xLN8Z6EyEh9oqq/Ro0VMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgAGKlK+ZpMETRUBFTPQc0GZF1kThoh0TB4a0qJUI09pG2lUjReBBzFbeoxCxysVgZKVblEcEgpO11p22ktVqU3o/p8k81LWeRskAzAM+ruR3KZyKSznGy4ZWZi/eOnrhO8TXseLExYMs1eKzcEIpU0jtMZ4gS2VZbAFu1fEfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2wbxIFm; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6d31bfc8aso12294145ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781848103; x=1782452903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cooLtirQK1VfrgbFbfezM8xLN8Z6EyEh9oqq/Ro0VMk=;
        b=B2wbxIFm5lLJ2uRNWe0MsLofoJS+xxQh8xlLjWSoWgIBsa9WPR4qR4zUWcmF1n4xBI
         cRmOB1kwoBK5lks7nQCSK7noquqeWENEEuLusYvSRde03X9JjGr/o5jzgEQujfBeJ4qL
         RLnxKOzUouiaVJQA+1DNyegmlat5sMiodB2lmLLug11rOxHyOJa6mgVh2Wdkf8lQBQnG
         lHo5SqFrS6B0ztOP4QPPuwwMPQl0xoScQ7XGI9kCA8s5lgVM2aDpOinNo7fobEx12lH9
         kwcPZByUw6J1NIKlFfwBV8cQ4f7ZacVEcogHKPwUGGftx4W1qstFwzRb5lXXUFLIlrKa
         sSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781848103; x=1782452903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cooLtirQK1VfrgbFbfezM8xLN8Z6EyEh9oqq/Ro0VMk=;
        b=i6DQ74tL0V7rDzVPFkcQa44cF4SGfl2J+w7sTomzPXaPaRJO3OHakk+fdjWBp5eblp
         mpH34YgRMsv3MTbywk3XriysEburET0KqEnZyvT4Og6nuYyqHWUM+M8givWk7npcE5H2
         jCx46Xl4Rr54vH0SXFhgjpAKTCatENpfLnYjNw9fRQ/KB5YsQ/4Wj4Nhp43M2NfYIFNr
         AQAqKYwYMuxzs/oy1ki/CQYbuibwkFRBM8rHTusufT267AvOf0AgQUrTvJBB1dheR8se
         oC+4vq/PqzmuRNRNWWTXXvt9Vjo7Xz5H8lLLdD3P4oehBMcp+Se2M+2kk1Ws9WBuwlGj
         MDeg==
X-Forwarded-Encrypted: i=1; AFNElJ/HQyAYqdLdMGZkTEgOzt93i/HSn1H/g4q7p66ekTCyg0yImTwuP/MRMU8lbIor0AI0qqOMPBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/9juzKsD9TIcgx3vI+NUejBDbsyqBtap+PRep65xT7T2ucQd
	1bGppz9MANN0LxbEzCSEVDvk+tsiAee261ZQhXo6zyu9O6/+LX/NZe4H
X-Gm-Gg: AfdE7cnWOOCZZLGskizHqYEvnioAQWdBqZw2B8iFq4BYR8OR2nA8bC/KfVbDceKyN2U
	89QmYTCweZOkjy0LDfbPzOKXJ4niX2i66oJfsplnLbbgr9rGh6KXFNxyQX3fyCYOXRpRfRRDD3p
	Nr8InsQJ2uHkdtXZNJK59nn5jJp5chKYwGhTo/biru8WaQytT6LAWw30LBOLqnazD1hMf1GyZxo
	63l/hEFq2FA6voVqASxm6xY6FpDyIqcCaGHqIo2pIiY0LUa1rRoBnt8xHHMP1xU2dN9Cls0EXTH
	LSMv3MWaT5QdXXICIvv+ig9sqGGi0Ek4kMwVdpp7K7rvP+Js0QL9/40dkfOr4tFNN8q/UO1Gg2K
	6OWA8jgCQv3tyJF90DSY7L6rRI1xQkUjzpXEgbbuYPGVh9zXZaNN/Btm2muHP+3KT8uBThuoiew
	vp8JvDTw==
X-Received: by 2002:a17:903:120c:b0:2c6:b40a:d0c7 with SMTP id d9443c01a7336-2c718f1f0ddmr26069695ad.7.1781848102997;
        Thu, 18 Jun 2026 22:48:22 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c72089a155sm10555245ad.8.2026.06.18.22.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 22:48:22 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: andrea@common-net.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	shuah@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stefano.salsano@uniroma2.it,
	ahabdels@cisco.com
Subject: Re: [PATCH v2 5/7] seg6: add End.M.GTP6.D.Di behavior
Date: Fri, 19 Jun 2026 14:48:11 +0900
Message-ID: <20260612032313.662-04-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607160119.ed2022e8a358d700e1134318@common-net.org>
References: <20260607160119.ed2022e8a358d700e1134318@common-net.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300598-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea@common-net.org,m:yuya.kusakabe@gmail.com,m:andrea.mayer@uniroma2.it,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,cisco.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C68B6A3FAF

Hi Andrea,

Thank you for the review.

> The patch 4 review applies here, except for the parts where Section 6.4 is
> implemented instead of Section 6.3 (which is incorrectly implemented in
> patch 4).

Answered in the patch 4 reply: the next version of End.M.GTP6.D will
implement Section 6.3 (Args.Mob.Session stamped into SRH[0], no
preserved D), leaving the original-DA preservation exclusive to this
drop-in variant.

> input_action_end_m_gtp6_d_di() and its finish callback are largely
> identical to the patch 4 functions (input_action_end_m_gtp6_d() and its
> finish): the SRH check, GTP-U dispatch, outer strip, inner protocol
> detection, and NF_HOOK invocation are identical. The duplication should be
> reduced via shared helpers.

Will do. The plan is one decap helper (SRH check, GTP-U dispatch,
outer strip, inner protocol detection) shared between End.M.GTP6.D and
End.M.GTP6.D.Di, and one SRv6-push helper (including the GSO offload
setup) shared with H.M.GTP4.D as well, with the GTP-U parser common to
all of them. The D.Di handler then reduces to the prepended-slot
handling specific to the drop-in variant. (The NF_HOOK invocation goes
away in the initial series per the cover letter thread.)

> D.Di does not use teid or qfi, so these variables and the (void) casts are
> dead code and should be avoided. For example, seg6_mobile_parse_gtpu() could
> accept NULL for teid and qfi so callers that do not need them can pass NULL
> directly.

Will do exactly that: the GTP-U parser (and the decap helper above)
will accept NULL for teid/qfi, and the drop-in variant will pass NULL.

Thanks,
Yuya

