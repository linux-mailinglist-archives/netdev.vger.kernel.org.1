Return-Path: <netdev+bounces-237776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77757C501DE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2113B2370
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6532A1C84D7;
	Wed, 12 Nov 2025 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="aOKjRYqW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C211B4244
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906688; cv=none; b=GbGqK+PcXcleRh0gU8RI8iESr+kIDJvBpmqjLYT7IYsT4GKhfp6UgyUGaOS6VbmE8Ltwf6w5RCr3anTUNfCEFq9Nbvl3Ypdk9dozAhv+YAAb4fHM9CfV3qZ3E73ijxYBPUcBzc0cCkUTvFpLxvOkwYlTnPZztbwZibB0i5mo1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906688; c=relaxed/simple;
	bh=89nQblDme8wE0iaTDko19h+OYOCH2Lz9bsEE8dabZgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRaPCNmxkNjqicOpEqLKhgsFGo2hK3zlSNcqIkYzW6PZ5qa8BcxYZ+cFFUUdPMStLvAQH4C9jyzF41WcxjVTVVlx69AJhTM56o7A0DkXvkQ/vI477VFvNJDhCzAlwNedExHw/+ugkWKi+tZomlfxfMTrrTot7HccAW7UnQikyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=aOKjRYqW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so213412b3a.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1762906686; x=1763511486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eimYjHX5fk2d/1kuQRVtRmu5ghsTLXELxJun9RdyGEk=;
        b=aOKjRYqWt5ZdhC6YNRPrh4DOqOYJLdWvdktWZFcibR1MMlj2kwc/Coj8yWiXUUm8S7
         ly0GW/JlY+Er5f98VU0zSSUKlM9tUvKKDQwmsDadPpdCKH2fmTkMTmnn/ZdRHgHtQQyW
         HiaGUJXD0XY6amKQZcQ6ct835y4sgBJt/ORE2/hANqCatinJy9Vmr5Fd8SLmOMDy+Mwa
         jgbZ2HbBe6VFfvmqUXvzDK1E2iZQO1IUdzkhPXtNfM4tguRgakbaI59FFcD2toJIvjne
         WVNrg/nJrSGF6GBgEUMYVOEevjrPp16QqGC/S4IWgopAi4Mv/C7v3jO0J2TqqLuQsT6S
         HraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906686; x=1763511486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eimYjHX5fk2d/1kuQRVtRmu5ghsTLXELxJun9RdyGEk=;
        b=W4NSh+SrFgtoeU8zItPxjLdX/LSMufka6c7fDhhaN6+QgPzJS4+6+5KA+S2UBAcKkc
         kG1iW3o4syDs+uvR25AKhKLignP7VlJa4PpBsONV79Udiz2wjtk/UwcgPjVSaGHLPyWK
         Za4gx0WqUI0Y0ShczTcxPsdFMtQ7mpPGchy8R08wRGHku4+Zf3sgvZnPIoF3QJno9Kcr
         MSNa97roy+O7HmBSYv4YBw201trGerfCdfBV1ClnQbYmpmZEx2evF9VLpWRdoe+KtHM7
         v8eNoXgTLQ3f/YwLAmSTusrU5FKNBArXB0rdDztB5l+z1X1KVFCVAgsdL/3MvICWyEAE
         cfow==
X-Forwarded-Encrypted: i=1; AJvYcCUnIOi4HMqBCzfUnnUgEAOPn/boARfEpjWqiS3FGT5D+sz7O+GSnHNp+PU9Hb3gmssZTG0Qyrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQKS8VROuDMvE8lEH8nsk93NyzlrHV7oCnevQB6KZhyxFzIvQ
	+74J3rQW+XWMHu6d3Xx8ptBqp0727BjT4CPAY3xF7BfOoO630o7MhYa3HeheeTBIQw==
X-Gm-Gg: ASbGncu2F5WZjiSAAPm6GyZAyNW6W6DRXDgBru1tacei9pKciuCcqTJmz7LSwcjYdW4
	q39IkI42FGVIZuOW9+PBMYQ/Jhwf1OgKj/4THuFpuPDbNuMxRRIFTh5lM+yFRqh2ohSF2bDvzzf
	Fo9gf6LokPmOVGZGRkvRvYPfL5HNqIvGnlu6yw9tyfbuxC1E2GvZ60ZD0cOQfAHeEz1NBGh65zt
	9q7LHz2/fYtgojuy27vLRZFgESSEj89FBcXOT/P1zUBeK48Y/+OBzXSjZAhlqOFglhmLNuL6ctJ
	595C7X37C6mrlX5ddkeUzmvnhgueIyJ1effXVX5uqwFMV/oFhCluDrArFcBNTS2wbCZqnh5YJax
	ZlCZo1tKhYy4kl0cgFd8CX/wCg/U7G4VV/hyepyAoFV/jxr8JglWRg/je8vYbLPSt6sLNfsfznI
	ILeun2S2HuVu+bI11WOYNLSGRQZu5AlCDqFcHhudAv4Iys9Q==
X-Google-Smtp-Source: AGHT+IEz64zNS1IfM0Ywxs3kkEPtu1tjVk3mebjtI0O94UhKB5/Q5BR0rxJiWqV3zI6gvUJXk657NQ==
X-Received: by 2002:a05:6a20:9186:b0:358:dc7d:a2d0 with SMTP id adf61e73a8af0-359090919dcmr1111053637.7.1762906686021;
        Tue, 11 Nov 2025 16:18:06 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:8c01:13c7:88d7:93c8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf1782bed9sm754222a12.27.2025.11.11.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:18:04 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [RFC net-next 2/3] ipv6: Disable IPv6 Destination Options RX processing by default
Date: Tue, 11 Nov 2025 16:16:00 -0800
Message-ID: <20251112001744.24479-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112001744.24479-1-tom@herbertland.com>
References: <20251112001744.24479-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set IP6_DEFAULT_MAX_HBH_OPTS_CNT to zero. This disables
processing of Destinations Options extension headers by default.
Processing can be enabled by setting the net.ipv6.max_dst_opts_number
to a non-zero value.

The rationale for this is that Destination Options pose a serious risk
of Denial off Service attack. The problem is that even if the
default limit is set to a small number (previously it was eight) there
is still the possibility of a DoS attack. All an attacker needs to do
is create and MTU size packet filled  with 8 bytes Destination Options
Extension Headers. Each Destination EH simply contains a single
padding option with six bytes of zeroes.

In a 1500 byte MTU size packet, 182 of these dummy Destination
Options headers can be placed in a packet. Per RFC8200, a host must
accept and process a packet with any number of Destination Options
extension headers. So when the stack processes such a packet it is
a lot of work and CPU cycles that provide zero benefit. The packet
can be designed such that every byte after the IP header requires
a conditional check and branch prediction can be rendered useless
for that. This also may mean over twenty cache misses per packet.
In other words, these packets filled with dummy Destination Options
extension headers are the basis for what would be an effective DoS
attack.

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
---
 include/net/ipv6.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 74fbf1ad8065..723a254c0b90 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,8 +86,11 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination options. By default
+ * packets received with Destination Options headers are dropped to thwart
+ * Denial of Service attacks (see sysctl documention)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 0
 #define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
-- 
2.43.0


