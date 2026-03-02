Return-Path: <netdev+bounces-262470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ManmHxbnpGnWvAUAu9opvQ
	(envelope-from <netdev+bounces-262470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3408B1D24B1
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AF1330154AC
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 01:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3123EAB0;
	Mon,  2 Mar 2026 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXQlEh/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125E183CC3
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772414732; cv=none; b=fZ1BsDdAfqRmDooTVVbufFHGzEE7i4PUSS8Tns9XWQ3/NqNjYLburgzMuWTRxxMkZ1fYNqO+6BrjYlnqQwCfas8IyDaRNRv2TawnYAoX7Dayv/zOXf0cZFhN5MoZuxRNKlg8N1S8wkeBDBWqykrCJfkvblmhLZeudYFz0FkiKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772414732; c=relaxed/simple;
	bh=c11Ik9Wu6rWFx89nAQqqQ2uqdevqJ9lypkYRGm4U544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRmq7fdaHJlFpJYtNFc5ttgjdKKmlHS4VRZU3yjt5FAAgSKjsAEJO8Cd4tnejJaXLHT8oTb7dRh9D3DZXoDdd5OM9/bJjzMWSGceQIxLyvorlxWvTfnT0EkpgCpYxpOAF9jQ4z8/Ok4l/GUr81nfyzdcBUOC4A5tFdu6SJ4qLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXQlEh/b; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82418b0178cso2168053b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 17:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772414730; x=1773019530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+sFBMEk2xP6V4+icz7JQnrewXI0dluunX//sXy6N9A=;
        b=KXQlEh/bqncMUZ6FfhyPSJNoVdjCn8xshLuSlgei+EWeZ9dS4pChkP86mFWJVQ9Gw2
         eflMZBUdMec+YYYJKxjNhGchSZy3fHnJPj4yNFS9NkewUrBesJ9CtCY23n2MO1gALQPM
         Ff+kG3H2EBO3irVsipqA5ViOwOrPbg94plqOSxcbIA4IwwUwnqCYTABu2zZQFOCbSKPA
         AoOwEn9yMIGThJNC1mMmlpqQ11juBakmfGBxR71jRWCB/Qps8Hr4cBWNhR4SPLBqY0O5
         le1Q1vVOAzDc8OFnPFNpHs1hNnzAX+RQSTxgrbqMH3ablUcvOwWQS6vxA5zW2swJo+Ht
         pKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772414730; x=1773019530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+sFBMEk2xP6V4+icz7JQnrewXI0dluunX//sXy6N9A=;
        b=M/u15rKPpC/1LS5PX+C3dcSEUE39q6k8rMaQwYVVTPNTerSYQnEA0JuruLxI/z3uPW
         EksT3A3aT8Spv6OVUqG6e9I/vUGmcyywI9lKsUTYGTcVFPp7m6HB+kcXzkDdfrtQq884
         gVZi3eaeftWjardlOQa1DwD0s0uIiAiZBGb1bIPP7DTUfMmXW2GyXTuUCF9ttCNHS0eu
         Ee7IPqwPIEwsCt1TkbQXHdWZ2l5fkgG56OXUn/epPATzAZic71bnnXWA232wnWBITcWf
         E1xl8ca6PYvH5rwbj+RhbEIXvdgpOibpTN/463xSDSbz28XdlSXS7giGVdeYt4EVhdC8
         PW3g==
X-Forwarded-Encrypted: i=1; AJvYcCVAz0jLVVHeG6xb2fQKR3P+z+ku7xfgoylv58yGlpz0Q3kqCj1255aCxQwUQiZrYBXIHVRZ8WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2uir5S2xbWfsRyi69Oln6FzUHABis5YlIdpAPvbNZXkK4jFR
	8k+eBCo1j5FTUkZrkwsXWc1gpLTeYCSFYg5nGR3w8bROl/T1SDaZBm4/
X-Gm-Gg: ATEYQzy1flO20siSXI5M60JgaEXFjNOf4DH3UzjkGVgp9wEW0mWEQ1UOem6usgBMh15
	/6vWuqeFNSKyurxWzmb79eN4pjCvXls8EZ5P9RMk9KI4pnseIXp+AMmHTMs4EP8HBcz38Zl+y3I
	i3du2Imi+r/0QcjpISpjYYCEMCp5bwjmcGsDzyrpzoMPALp/ATlV6NFrjVBZZjJn30ivtq86pVJ
	eQrekisa72rYvpL6CHhqtVJxcLuIQuPW5iE17FVDPwb2v//+v9bIfkZgacmyn2mrwcM7rfX18Mt
	H9Y0ob7w5Uei7e2z+MgKbN76UZ0pRKjT0SID9hzr2JyLjmUoMox69/TeVLmmkFsxjfzjk4mCaUN
	nt/UeQODcg0mfDvgB9dSqcg0JUk0BZtcayrMPnjAZQQj05m/Xb5EuAYrhs4gkIe23ogHAmxFpO5
	+/o2la50HJgh8ahS0w7HQXIsec01g++oPvrtmk5Q==
X-Received: by 2002:a05:6a00:909e:b0:81f:4046:1490 with SMTP id d2e1a72fcca58-8274da06b33mr8806359b3a.44.1772414730092;
        Sun, 01 Mar 2026 17:25:30 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm11200214b3a.15.2026.03.01.17.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 17:25:29 -0800 (PST)
Date: Mon, 2 Mar 2026 01:25:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <aaTm8ydbxRe0jbPk@fedora>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-3-2b2a274df9bb@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-3-2b2a274df9bb@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262470-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3408B1D24B1
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 02:46:28PM -0300, Ricardo B. Marlière wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never

If it's booting without ipv6 module, maybe we can use ipv6_mod_enabled() to
stop ns validation early. e.g

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a1de08ee3815..be9e01ddd6ac 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3372,7 +3372,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
        } else if (is_arp) {
                return bond_arp_rcv(skb, bond, slave);
 #if IS_ENABLED(CONFIG_IPV6)
-       } else if (is_ipv6) {
+       } else if (is_ipv6 && ipv6_mod_enabled()) {
                return bond_na_rcv(skb, bond, slave);
 #endif
        } else {

Thanks
Hangbin

