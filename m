Return-Path: <netdev+bounces-270208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNn4NTOTvmnkTQMAu9opvQ
	(envelope-from <netdev+bounces-270208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:46:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CF2E555D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A38730160CD
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DB175A74;
	Sat, 21 Mar 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHacFUDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0163CB
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774097201; cv=none; b=sdP+dc7qmhracvYhid8vFssdZ19lyihme39I4S5/9N0DpYl7Npv3kVSEW5PPDHOgM7tJ6+pKGOq78+NqhIdrP4zTBbfGBwCkRK2NR0IeutxIsq8OoY1mLD4qIl/h+QaB9qqxDKMb987GtZc6IZ0+cE/6QhBI4mq8yeqXYzcDX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774097201; c=relaxed/simple;
	bh=fZI6befk7S1set7eQp9G7dPMBkw+HSr1A3jeOtIoX4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/W81VXktlAAKsMNhhspNZhjTarGw7F696YBZFkoRsHV7TzCSe7FCY60yx9YrqYdDv6a5vrq6NoqXPkDFSQbrrc+2A+15Fdo+5ZwpXtS1n3xasJvDqgRi+VL0PWhU4qAZOmhjT3Grm0XkrjlI7hvKhm6EWffaOFHw1DDmUOWA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHacFUDY; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so985647a12.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774097200; x=1774702000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZI6befk7S1set7eQp9G7dPMBkw+HSr1A3jeOtIoX4E=;
        b=KHacFUDYxfmAPNb1Ao5uNDhCbWjJQYFw1XMsQ1b8xUnOqScxP0T2z3KBvGT8I9co8s
         1Lra1XBmaLAs1XIH6qvh2vv2JqUDUPGklO6XRt7ZIQiPO4dGaQQAHBoiXyCINkaOTOSR
         V3tVu8JUaJv5fexXz9eXut8g8UGRvBOyIUbHVMh3LqYSyqZYLZHC4W5Kr1hrN/WgLLOR
         c9xDX2fGWbeHAaQWCZ17HQjhR3qIMm3/kSt5dAeIjkQTOLQgnRjpwDXjZuE7/k1qQM9e
         29sjgmRuXeiZgfe7HrqvX4qk6E+SNBkiJcakM+1wf0DT1Jdkd2Mx4smENwUkttsuj8Fg
         DaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774097200; x=1774702000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZI6befk7S1set7eQp9G7dPMBkw+HSr1A3jeOtIoX4E=;
        b=TmR1UISU4XvsZ8iPTG7vSyuDjXszM6pN9pCV9xOA521tf0mwPGQDFDdUAwFsS9/lBO
         VwBZQAkPWWWDgkLGc+lebR3ltuzNZ6V4bd7NkGTN+Fnq0JQU0bflZQfa00LA1u7rk5c7
         tYJuyyq8sRDpi4xybvGYN0W8pofdJb51Ky82WhpTMY2FBhUTymuV3tyf5xqaveQEfy9I
         Z9zhelwhNJNMUZDcO6HzFy5QlsHj81AQU0aalbQr23rtHF+JmVQXbQUt/IQL3+5dTPQA
         i86c0n9SfTrbZYMs10600v7qrmu9BHFzFC/EPUDBbGC9nQEE4kW5DvO1h/CL+d6R6NIG
         6QCA==
X-Forwarded-Encrypted: i=1; AJvYcCWgoiq49rhvwECkQzDjbdtiFQdRnCfkyvBL//4MfgkceJwTtvklUAKO+tcSzHEYWyFU2BXiANY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSjv0BMeKcloKAiU8qMXq4fgQMLKzndOwteaRJLFqkrFqNdiV
	bIWrEKybuTRJRD2Wdl5tRhLYovgpSOaU8P7lqaT7JNxJzgeArZSHe21u
X-Gm-Gg: ATEYQzzI94vqsbpnjrKCKd/YXX3MY66Yjw5eaHd+DJEYovnSWjdnaD78TI+lbmpuyDj
	GsRseJQfj+C4eF9rgCWBrWhzAefZ84VPbmi+M0j1tqNatGQzJzJQTW0hOWv3ZeoUquIhgIRD+20
	cbjQCVqWzfK1i/8E74+LQk26P2zhQQCiCg5C1hCq3eooIUFxb7Jj8JL4bG/bSJ7ghM1iPPoFC/P
	huZwasUqJe92UK39IKMtpRgkTSFUWhKxk1RP1+7ID5CeEguyIO6wkXDjVWnSms40fB2TDUvtMPU
	Ho0gYqRTMxHOi/j2o1/lIqgDNedadbFx7O8dj1OmAjMZ5olgnreTY5DJ3P0Q2GftX6E3ETji4ed
	k3fZG4N8/64D++58glcCdpz7jGWdDr9WMoTtZXl/2Pw1sA52EJztZhqgEeEfyw0PSaeLbDah4ib
	l0WdopPNWHmq2jm2kawNCxS/6D
X-Received: by 2002:a05:6a21:998a:b0:39b:91d1:6bf3 with SMTP id adf61e73a8af0-39bcebf11e1mr5705097637.56.1774097199715;
        Sat, 21 Mar 2026 05:46:39 -0700 (PDT)
Received: from ubuntu.. ([152.58.130.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa9fc6sm4656177b3a.7.2026.03.21.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 05:46:39 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mohd.abd.6602@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	quan@os.amperecomputing.com
Subject: Re: [PATCH] net: xgene: fix signedness bug in xgene_enet_get_fpsel()
Date: Sat, 21 Mar 2026 12:45:58 +0000
Message-ID: <20260321124618.1221-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320162152.GA79627@horms.kernel.org>
References: <20260320162152.GA79627@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,os.amperecomputing.com,kernel.org,vger.kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270208-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohdabd6602@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 571CF2E555D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

Thanks for taking a look.

You are right — xgene_enet_is_bufpool() checks
(id & RING_BUFNUM_MASK) >= 0x20, and
xgene_enet_ring_bufnum() returns the same masked value.
So the condition guarantees that the subtraction cannot
underflow.

This appears to be a false positive from Smatch. I missed checking all the conditions.
Sorry for the inconvenience caused. I will drop this patch.

Thanks for pointing it out.

Regards,
Anas

