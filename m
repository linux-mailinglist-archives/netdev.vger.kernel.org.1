Return-Path: <netdev+bounces-300674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X5htKtwSNWqTmgYAu9opvQ
	(envelope-from <netdev+bounces-300674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997F6A5132
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="bddemX/m";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300674-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065323015725
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3636A37E;
	Fri, 19 Jun 2026 09:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1349369D40
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:58:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863091; cv=none; b=U8nQ9/flTssKkA5eSY9qCzuQEUYfblZyE7OHzlEQvETEkOfYZhJob+zveyATRhRkhiv2dciV0j2RABEuG1OshpKgY1+Bx4pEBtysSWtfDfOxCW+My/urt7NzsreDb+e92CbLA/2wHBjPSDGicJIopYCX6GlP5zy0pkCM5GwJR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863091; c=relaxed/simple;
	bh=hk2+uuYecO2IQQF9bcMQEfm2EUhrTFMxzsBYQSG8ZtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulpAVup5ObmShkNKNHNhQiVHYUeodhhgJAiaiXHY0vnRiinKhaOiWlFe0uSy57GHCtFuQCtxIUXtmOPcbBRzyUCoM3FkbTw5LH2z1a3acMQbqHUJR50uhV8wVuiWZBu/Rk0DHNhAT6Q3Qhl1V1r/XcHGSIcMZVTh1jzkN6Zqa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bddemX/m; arc=none smtp.client-ip=209.85.160.227
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-519fa6d7a78so1387081cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863083; x=1782467883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U57pja5e0yJSy8SFBtN6ioJCsbtDVqRKjAnvzO5IXeQ=;
        b=JC3C0eiY9ADnrVxLNSQ1sxZyDxUKAFVDeFPrTAjneh1YaPQb0bAzwRExCLyR8qPWz5
         HQv3ATWRMd7/kINvqIFBSgWpqej1/1f8AKJ3fwQWHeIDJo+HjGKaBIUKjjyiiToe68oX
         JpfzOefY7khnqupmbwTTzNOisPIkPg3k2dMu+mCFjI1S2/l8VXFjLNZPI6u1ZpJx/Uwy
         XI2mAob9Jqh+h6Lag0uB47z3GzLVR7Z5WEvHUQl8UgSGHaTLYFM46+nzmz4xElxl65eS
         byCly5g6yz10SyFD1pZxLhzjq5OekxiIN/HzY0CxV7qhSGw0cpcJAg4UCruTkoMul2Mq
         d0lQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HL6GRAhttSH0v6bXChK8KCWcVGbMbdikx5nVSBLFI4YiDOh7M1c8hnuRlpnG8f01PrXDwUUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0Sc8q0AZQ2bM/cMRRTdxYYmetTuhEgkCveI4Jw9C6SsNX5rK
	MICK+39m+tJWNFEFYEXoxXK+Re21Rlier/9th6HhtYbrzb/qhdYiSjmoLPV+t9PKqrhh+sBj/Ob
	lNSoP82HZwzT6LJfiexbqHgPAk3bipsxgPkCWbmjOQOJ7t7p4y6G52ukjHtjZuA+KdCpVacpGns
	rZleQHCEmngfbG+fwd81Xgr4la5RftpgDjVQMXkX67Ms0tO7NFr2uQxpH9AxjhtmAjv0F/HyQX9
	CeHwoRcbVqKYxyFyA==
X-Gm-Gg: AfdE7cny1NbOpK5UxaSH86f3/2I1a8ebeWZsg3nKoDVTV6vi11ErwxxJWh7rOLLhGO8
	zDl4VGJC6+OuFe3DdoIlPfW1CkzRE97UJrBKQdI2fx/n+VaGwB//nMcYc6IUsxmx1/bYOwRl7aR
	Fh2GS/pxx7asPJ/VXqm7rATiD8qDwPC4dlSdZ3ge7HrwE70WXxRo+f/coCQZgwIKPe73dogbDil
	vQoYuYjlylTx7Qe5AW8OfRVcys73sLs7fhvDeb+AqMs3ixrrSkblSVW3psIM9wNoDp6u8PJjIdm
	JSDD80ayZM7CnS7twePfz8IRhjWe35hjiC/Ycg+lHQRyANbd1L1yt3MCi1sE2l6o7Tdxflog9NB
	FwgrFOWGuPX3JL1MU5EV5Bzdsx418wFhe+FT9bgBI/vtECOlzAhaTb30Fyd6lIvwD2V9cPgWNzJ
	6mVCS9bxGljL00Hzd2LP1QyoiUn/SueN3+q+A5gjK3kc9TQog6kgNx
X-Received: by 2002:ac8:5d52:0:b0:517:92a6:fcd5 with SMTP id d75a77b69052e-519f02b3045mr23690411cf.18.1781863082220;
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-519e57c771fsm638731cf.26.2026.06.19.02.58.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so1957219eec.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781863081; x=1782467881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U57pja5e0yJSy8SFBtN6ioJCsbtDVqRKjAnvzO5IXeQ=;
        b=bddemX/mueuoTUw+FgpYuMdZmN2YG6KQCleH58432RU1ZqVcX9NspyjesIHnNVo1M8
         zRXNHpWkO513UvHI+jtYcrSIVHzrDP7EUgyTMneZMbULLdHLIFsZEJxrEmBVPoLK8Y8b
         xvYl2rvC6rsyZTlwCwbz3grmvbDenVoc7BqKQ=
X-Forwarded-Encrypted: i=1; AFNElJ++uHwPxJiHG6u6m9Q1leC7FZAwaJ+I3Q9VAAUJ1uRrewVkd1FFaosQuI9tJzEOAVdHXv0m40k=@vger.kernel.org
X-Received: by 2002:a05:7300:2310:b0:304:705f:e4e8 with SMTP id 5a478bee46e88-30c0d1123b2mr822013eec.32.1781863080698;
        Fri, 19 Jun 2026 02:58:00 -0700 (PDT)
X-Received: by 2002:a05:7300:2310:b0:304:705f:e4e8 with SMTP id 5a478bee46e88-30c0d1123b2mr821973eec.32.1781863079967;
        Fri, 19 Jun 2026 02:57:59 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm1851910eec.26.2026.06.19.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:57:59 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1 0/3] Fix CVE-2026-23272
Date: Fri, 19 Jun 2026 02:28:47 -0700
Message-Id: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300674-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4997F6A5132

To fix CVE-2026-23272, commit def602e498a4 is required; however,
it depends on commit d4b7f29eb85c and 8d738c1869f6. Therefore,
both patches have been backported to v6.1.

Florian Westphal (1):
  netfilter: nf_tables: always increment set element count

Pablo Neira Ayuso (2):
  netfilter: nf_tables: fix set size with rbtree backend
  netfilter: nf_tables: unconditionally bump set->nelems before
    insertion

 include/net/netfilter/nf_tables.h |  6 +++
 net/netfilter/nf_tables_api.c     | 72 ++++++++++++++++++++++++++-----
 net/netfilter/nft_set_rbtree.c    | 43 ++++++++++++++++++
 3 files changed, 110 insertions(+), 11 deletions(-)

-- 
2.53.0


