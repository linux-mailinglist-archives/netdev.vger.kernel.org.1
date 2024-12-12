Return-Path: <netdev+bounces-151466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DD19EF6C6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2138728B275
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576E62210F8;
	Thu, 12 Dec 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2K5wiRN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E02210DE;
	Thu, 12 Dec 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024545; cv=none; b=Nu85yEZPPgtKmQN5wbsgrmjce1efRAKtTRplfbpJ+Ky70kHs2qDzqtCwYwa4cEmgIMKIwyC3/gfyrhDlekUyALEV5VCOXi4s7cl6vUJX7i4YBXow4uiBbkK5wrBY6HLDfnBGQe3XTu0PwUx6TBy8vo9E2b7eCXuddXGUWoQgK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024545; c=relaxed/simple;
	bh=htYmj36mp8h+Pv0w684UL9RsDcfi/7VjMwIBfrIhGOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlVyAuDhPmd+C7SM+iuxMISZgMGp6y7UfdnMNxmoXGZw+fsoIwHd5Yfv2dZHLububkIXUfKskBJw58MoUY15yRDoVz0wXCiAyKTB27ZOgPLk13q5/iJcoyR9QugWgKAxbrA/PdykJjYty6lEKla2aqRVb5eFIgDdwbA+0AsC8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2K5wiRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB614C4CED0;
	Thu, 12 Dec 2024 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024544;
	bh=htYmj36mp8h+Pv0w684UL9RsDcfi/7VjMwIBfrIhGOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2K5wiRNqnbIwtKuefqF5unzZb6vHwqvB775JOvVG4tvCE26Ik0m/uiee0KsAnXrI
	 lEEY7ktzPRZbWEfF/7MMABJF3d8GxDwhLaQ+6gIZ+KRXOjYczPyv6eGePlJSrOYwGY
	 OOVbCv3/9pqHvrjMMJwZq9UGQN1g8iZn2T4fBT6000NscDVs8b9hQeRy+Iw2PqxFoo
	 iYhIjxS4e9mgM6gy6vDZP4LyYA5aRX3eiPHgxgPQG9HD22hPNG1Vfs9MHQt7mwwOhs
	 hc1gco1lv88jPBdKoktS40LQha4eSfGeOu0qf6IVwrA689qw/ayz6/dmS5oc6AaY8l
	 Md3NGDAjPmmgA==
Date: Thu, 12 Dec 2024 09:29:02 -0800
From: Kees Cook <kees@kernel.org>
To: Christopher Ferris <cferris@google.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	android-llvm-dev@google.com
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
Message-ID: <202412120927.943DFEDD@keescook>
References: <20241109100213.262a2fa0@kernel.org>
 <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
 <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>
 <202411151215.B56D49E36@keescook>
 <Z1HZpe3WE5As8UAz@google.com>
 <CANtHk4mnjE5aATk2r8uOsyLKm+7-tbEv5AaXVWGP_unhLNEvsg@mail.gmail.com>
 <20241209131032.6af473f4@kernel.org>
 <CANtHk4kM-9BDCm69+z3hS58uCrjCmma0aQ+nOqFUROaFhLAkDg@mail.gmail.com>
 <0e336341-9575-436f-8e41-df190f67bdd7@embeddedor.com>
 <CANtHk4nyP8HyYMobB76z9LpbA_jD=fLkWtyK9w_aMkzP8iB7Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANtHk4nyP8HyYMobB76z9LpbA_jD=fLkWtyK9w_aMkzP8iB7Cg@mail.gmail.com>

On Mon, Dec 09, 2024 at 04:39:38PM -0800, Christopher Ferris wrote:
> By the way, there are some places where __struct_group is used in other
> uapi headers, the only difference is that the TAG field of the macro is
> left empty. That compiles fine when used in C++ code.

Does this fix the C++ inclusion for you?


diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 2c32080416b5..aeff841c528d 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -245,20 +245,27 @@ struct tc_u32_key {
 	int		offmask;
 };
 
+#define tc_u32_sel_hdr_members			\
+	unsigned char		flags;		\
+	unsigned char		offshift;	\
+	unsigned char		nkeys;		\
+	__be16			offmask;	\
+	__u16			off;		\
+	short			offoff;		\
+	short			hoff;
+
+struct tc_u32_sel_hdr {
+	tc_u32_sel_hdr_members
+};
+
 struct tc_u32_sel {
-	/* New members MUST be added within the __struct_group() macro below. */
-	__struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
-		unsigned char		flags;
-		unsigned char		offshift;
-		unsigned char		nkeys;
-
-		__be16			offmask;
-		__u16			off;
-		short			offoff;
-
-		short			hoff;
-		__be32			hmask;
-	);
+	/* Open-coded struct_group() to avoid C++ errors. */
+	union {
+		struct tc_u32_sel_hdr hdr;
+		struct {
+			tc_u32_sel_hdr_members
+		};
+	};
 	struct tc_u32_key	keys[];
 };
 


-- 
Kees Cook

