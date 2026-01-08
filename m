Return-Path: <netdev+bounces-248196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E2FD056D3
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B9F3150DAC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D23033E0;
	Thu,  8 Jan 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Np1WancK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935703002B3
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892529; cv=none; b=DRxMGh4WLU4W+UwF8e9EhF7QbrtUuxdKoS4MtTAWRWVS1uOA10Q6hotmeZz84A+gWfuPO2W2zGraDk0T/yjJmRW9oMJEfaQcp8T5jHmS8XY6eZsj7t1mQeWWQa6RiW6ZKlp+nPAqamnCfJMHILDO7D49o395UBzuZ7WAXUQv6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892529; c=relaxed/simple;
	bh=ZVx8dK85GAeOtadKoGQxlv4w3dZyeqyeiWpqqwnYtsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/FGMpgGzdwn+cfj4OHW5fYYxKB6UnDov4mAjtsukaMsl7R/QfBOsdtvfG3zBBJaYdajkxZCI2y0McfXWvaFB/j4HUvWcxmlq3QElbaT4HMXQMPY1xn/TYPeO6gix4VAGYhdwpRSZRY54zwsxZ70P8YjKErfZNKhOw1FHusJsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Np1WancK; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f3a10dcbbso2696489c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1767892526; x=1768497326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4CHn+mou2WTtZt3P3bklMIyNL+BFWZVIjw+t0XWi4k=;
        b=Np1WancKTN3StjiNgTElSYC2vx1jfoza6D1cJmLoRs3buka9hXul/81LtN8CQ/fW7S
         zjBs3kEYBf7R/i72mLpdV0s1+KxquDFUY96HHZiJZDM8OkzXo3xJKqQni353UQ/DmOW4
         TGiuXOpYBmpo7/jmieBBOXgCUI0rUQIMrvWZIg4sXIPLNz4A/Yn/J+HAg2ROldKmLQsY
         gDbWMzWO1Z6cAJbHx2hyhliRJlJzSEqlxIJ+csyLPmgjT4WrWccbikPefH4eydsQrds7
         7nGcJdykdkxBFsGy+nLySl6UYuMYI6FlACsf6f7HgzPFO80AV5a747aXiosoIF8UVhVP
         U0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892526; x=1768497326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4CHn+mou2WTtZt3P3bklMIyNL+BFWZVIjw+t0XWi4k=;
        b=SL92urkXNJZWrqX0HM1/sLDmWmKapCyRomRoBimuMO08VuLblmwr2yMQ8xwBorwQEp
         aPo9zyot4/yjjvCdmoe/rBumAVRowjTcgsQiysF3kh8jlACBwV1K7rvqPVJDz7hDCMnI
         JVMeEjQXPoSv8f4Shv/NN+vmy2YcNcttUDyx5YPVXa6Ls2DQ9NaJ6g8LsrugqlMzXFeM
         pPBYqUp4LfPtftDs3rUS0UFxIFDjln7wOK8KWQHGkrix/TQcsRh/GvW8Y4Z+sp9mpRoo
         Ub9VZmHPWpF8wuura6q4sBx3j84tzy9areplf2wJtPbzfYg0M2Dz3a3IkIy0slQ4DyXI
         vGfw==
X-Forwarded-Encrypted: i=1; AJvYcCXSKSqSRRyQTQ4SNPln7at1+G5mR4weCaRhrg5Mv8YEAZ0j8RPKsCcEBwq9r+HhVh5h8nhkou4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBE+qB9hj+/polw/GQ3nZ5rmnJTcbngOnXS/hjwMmgiAdYtjG8
	b4b7ySi+K/Yu2Y63nYUe/OlM2+v+8IMPbZaUWXOL4Fz7wtekdkvf40P7xN4RkHMALcGbJyLx7CL
	ME9A=
X-Gm-Gg: AY/fxX7+7r+89ejXkEIR0JzhWJkvJ6ksH6aUbDRqbHJyeUVxeOFjb12LKllmq4HOCmY
	gNtOAa7q64+seStZyYaYx7IhpNe9lED5xZ8TuIJDIbfghKaBsB6cstotaomLOy0rchaEPkRaYyV
	10GlFEOIjQwDTF/F2i2VrbTkAntDhCf8p7o4L0jEY0FTJ2RSLe8HFRYwr+M4u3UycferPg58+L1
	3R1I+f26q46MryNG6xh5s0HTrUvGiS4Ki35pH+K5s/I6caXEDB9bqBtZzJp6uZPCMa7eFXw2SVk
	f7CLL19yVgM9kWbauxyKiftPST+gRpYUpvgf9DnI02GnFOzTYq41+tJBMfKSBo0/oZ3jjnT2znR
	Nh00R2VJKLK6DkTBE7u4jnEzS9vJuR/ITSxP2TYPBWxzdOsl03urZhh8ZtcVnhQSoYD1P+Uwken
	GOswuBlDUTYDH8H7fidcoeGIGjpuRa0vjadPLb+j19qaxJh0aHwAbb9NYK
X-Google-Smtp-Source: AGHT+IHnJIekxEcOZD19nH0rA2S+unNLugm/83FIuSynT+rNV13VpDC4NgmRX+Mf1xram7O8tqp3Gg==
X-Received: by 2002:a05:7022:43a9:b0:121:9f05:7d6e with SMTP id a92af1059eb24-121f8b9beeamr5259790c88.43.1767892526066;
        Thu, 08 Jan 2026 09:15:26 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:812d:d4cb:feac:3d09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm14029259c88.12.2026.01.08.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:15:25 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 0/4] ipv6: Disable IPv6 Destination Options RX processing by default
Date: Thu,  8 Jan 2026 09:14:52 -0800
Message-ID: <20260108171456.47519-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset set changes the interpretation of the Destination Options
and Hop-by-Hop Options sysctl limits, net.ipv6.max_dst_opts_number and
net.ipv6.max_dst_opts_number to mean that when the sysctl is zero
processing of the associated extension header is disabled such that
packets received with the extension header are dropped.

This patch sets the default limit for Destination Options to zero
meaning that packets with Destination Options are dropped by default.
The rationale for this is that Destinations Options extension header
can be used in an effective Denial of Service attack, and Destination
Options have very little or possibly no deployment. Note that the only
non-padding Destination option supported by the kernel is the Home
Address Option (RFC6275). It is unknown if anyone is using that.

The Denial of Service attack goes like this: All an attacker needs to
do is create and MTU size packet filled  with 8 bytes Destination
Options Extension Headers. Each Destination EH simply contains a single
padding option with six bytes of zeroes. In a 1500 byte MTU size
packet, 182 of these dummy Destination Options headers can be placed
in a packet. Per RFC8200, a host must accept and process a packet with
any number of Destination Options extension headers. So when the stack
processes such a packet is a lot of work and CPU cycles that yield zero
benefit. The packet can be designed such that every byte after the IP
header requires a conditional check and branch prediction can be
rendered useless for that. This also may mean over twenty cache misses
per packet. In other words, these packets filled with dummy Destination
Options extension headers are the basis for what would be an effective
DoS attack.

Disabling Destination Options is not a major issue for the following
reasons:

* Linux kernel only supports one Destination Option (Home Address
  Option). There is no evidence this has seen any real world use

* On the Internet packets with Destination Options are dropped with
  a high enough rate such that use of Destination Options is not
  feasible

* It is unknown however quite possible that no one anywhere is using
  Destination Options for anything but experiments, class projects,
  or DoS. If someone is using them in their private network then
  it's easy enough to configure a non-zero limit for their use case

Additionally, this patch set sets the default limit of number of
Hop-by-Hop options to one. The rationale is similar to disabling
Destination options on RX however unlike Destination options
Hop-by-Hop options have one common use case in the Router
Alert option. It should be noted that RFC9673, IPv6 Hop-by-Hop
Options Processing Procedures, states "A Source MAY, based on local
configuration, allow only one Hop-by-Hop option to be included in a
packet". That implies an expectation that one Hop-by-Hop may be
suffcient.

Note that the limits on number of non-padding Destination options and
the number of Hop-by-Hop options are configurable via a sysctl.

Tom Herbert (4):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Disable IPv6 Destination Options RX processing by default
  ipv6: Set Hop-by-Hop options limit to 1
  ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls

 Documentation/networking/ip-sysctl.rst | 38 ++++++++++++++++++--------
 include/net/ipv6.h                     |  9 ++++--
 net/ipv6/exthdrs.c                     |  6 ++--
 3 files changed, 37 insertions(+), 16 deletions(-)

-- 
2.43.0


