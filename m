Return-Path: <netdev+bounces-264822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNuUFSTlqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:31:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01C222B6A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50AD0303D11D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4383AE19D;
	Fri,  6 Mar 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9frn9Ti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836B3AA1B8
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807368; cv=none; b=A7THmPx04ShA0CMXETrsmQfwP1+picWbDlEffc1J8DQxsqUaf0SVhiObl/kZrJ1jS+B4rNuutwoEhOKyxxL/Kpt3cEPEyIuSu1EK9qfUuDyPLjwZNLBvFVK1cLOqz7ZmkwzWpr6XPTT5a+Hhf5fLyP3YtsrqJT94KumKUSwFVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807368; c=relaxed/simple;
	bh=+rZF0+20mavVdgifPyf3fliy4IJzLk0nrA93BioY7DY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=LIotyaTzv2u29xb/J9oETNvJiRCoQzDDSmxPnk39iXlNalkDBPvf49smyayrTsrO80IQW7T1tf3FxNoWrgEyC4zeruEknP5LdysjY55NOOyk6HgcXxpTBhDO8U4Zy3nevFOwDKdB6ymo2YI/zyNPjAsQq0Y+SdOcqjnH+KRX3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9frn9Ti; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483a233819aso91862575e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772807366; x=1773412166; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEaYTJ0LSzp28pZYyR0KX/e8NcXzxUvW21hdHLFdRhk=;
        b=J9frn9TirAn1+nH1Pbq7rRDe2Qc53Do4w1gkCIjhzt8hpzZpvtNcQ2g6QMM21FH0ZY
         9UZgMFGW22wrvl6hE0r8puwXsUeodRXzEBmxOp4gU5+1t5w7nJSkfxO2Y6lpv0UF8aDl
         2B4kT3Rtn6s1Eq6IaWapXV+5mb3ndoH6/S2ApRAIBX7BlUXfzBpS/5o9siDYElkVixuP
         MeP+8YeB7rWXcEE2+JJJmpju4ghDspYn223hv5n3Hfk1XnKly55lTZGoh7jYW/TB601N
         f2gUvn5Th0pKE0btsr1XaILC81wL9/feZRqpxN3+f/ixNbBblCeFIx+fuFg6gtalWp0/
         elIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807366; x=1773412166;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEaYTJ0LSzp28pZYyR0KX/e8NcXzxUvW21hdHLFdRhk=;
        b=dNPbV8Rie+9xzACnlCJQ+bQdPghk3515B9qXLQg6/goH/AXt9PQ+jSYVoMxWxKLGIU
         C43f5YYOoRNnmYDQp6dNIGUL+FOAYCxTz1VETqF8RGK9Qdz0T9cIgT9eZw5PShSX24Tw
         FpJDm877C5g33DadIHWTyJ8STIf5OnzKLgmrm+ZLlzr72LRKtyQnSDhxpVbRlY94XB0i
         2bxWln0tGKUz40RHQXTh0sA+oALek7UTw5TZhB5HPYy5omu8ApQMSFOEW2Czx8XW1aW/
         yI1G+aIR19iWcZebWX9DZJtqmFWwjvrtIBrQB9Dqo09kJUVNUqYwg9j7d1m0YxCFkkZb
         PKvA==
X-Forwarded-Encrypted: i=1; AJvYcCVNDnJd/TYKR2rHhIBd2T/DUas9dDgw4gFzX5Nmbb8ryZfSnsFB07iuUIKF3GrJ8rOUIIakiMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GREHUE7Zi1JQs+8Pu7WOzJ+nbfCPenCnCE1hqkExXvNL7+ZF
	2uG+01v3I2Hi7bjT8b5Z/CbgHv+mnpoG++sb9xMsmfXYVgD/bF7jy3+E
X-Gm-Gg: ATEYQzwkEZa7kP+TtVJJi39/fgeyb3jwz37fgCG2gNdYS0QikJnjPBaYRV65hHvEfWC
	ilrc28OxBDRu6RC34Q6gmdLII3tDmULRy3RMBX2RSN+L1uUqsDg8u0/oAF9ytaEIqtqgWuG7FF8
	EQSDNVyHmSuHG3FRgIu6+BJLEaEnJi3X/IjTObRPMQd6byGu8PEqXPI9DwPKMtZe8uQWCzgPW2w
	qQaqlYIdDBwg4oVL5sIW5K+c48n5/gh7THGuPSbuEYOVdWiuZKAc5Dxis2ImOnk6bBM7eYlFsC0
	Ep/vGFpBYkmvoAVYMLK9Zy5IUklvAMY0vUuxrV2xy8KKTUftExnBtCMlpQJClIMbfIQZjboThZo
	Dm4ZPaeQXJdaKttwKiH4xP22Jy3Fg4feMODi8NnAYjMyCw+uZxj2dwMG1SMyHnAwd3rHVhVCUEt
	oaNmsHU8T6AxDzlVquFPdfDtTQFQ==
X-Received: by 2002:a05:6000:2410:b0:439:c20e:5ed1 with SMTP id ffacd0b85a97d-439da5555f2mr4180243f8f.12.1772807365466;
        Fri, 06 Mar 2026 06:29:25 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3f267sm4879792f8f.31.2026.03.06.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:29:24 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next 04/10] tools: ynl: convert rt-link sample to
 selftest
In-Reply-To: <20260306020901.524105-5-kuba@kernel.org>
Date: Fri, 06 Mar 2026 14:29:09 +0000
Message-ID: <m2y0k5ghfu.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2A01C222B6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264822-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> Convert rt-link.c to use kselftest_harness.h with FIXTURE/TEST_F.
> Move rt-link from BINS to TEST_GEN_PROGS.
>
> Output:
>
>   TAP version 13
>   1..3
>   # Starting 3 tests from 1 test cases.
>   #  RUN           rt_link.dump ...
>   #   1:          lo: mtu 65536
>   #   2:          sit0: mtu  1480  kind sit
>   #            OK  rt_link.dump
>   ok 1 rt_link.dump
>   #  RUN           rt_link.netkit ...
>   #   4:          nk1: mtu  1500  kind netkit    primary 1  policy blackhole
>   #            OK  rt_link.netkit
>   ok 2 rt_link.netkit
>   #  RUN           rt_link.netkit_err_msg ...
>   #            OK  rt_link.netkit_err_msg
>   ok 3 rt_link.netkit_err_msg
>   # PASSED: 3 / 3 tests passed.
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/tests/Makefile  |   2 +-
>  tools/net/ynl/tests/rt-link.c | 192 +++++++++++++++++++---------------
>  tools/net/ynl/tests/config    |   1 +
>  3 files changed, 108 insertions(+), 87 deletions(-)
>
> diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
> index df9d37c8b2a4..08d1146d91ce 100644
> --- a/tools/net/ynl/tests/Makefile
> +++ b/tools/net/ynl/tests/Makefile
> @@ -21,13 +21,13 @@ TEST_PROGS := \
>  TEST_GEN_PROGS := \
>  	netdev \
>  	ovs \
> +	rt-link \
>  # end of TEST_GEN_PROGS
>  
>  BINS := \
>  	devlink \
>  	ethtool \
>  	rt-addr \
> -	rt-link \
>  	rt-route \
>  	tc \
>  	tc-filter-add \
> diff --git a/tools/net/ynl/tests/rt-link.c b/tools/net/ynl/tests/rt-link.c
> index acdd4b4a0f74..a55f7523dbe8 100644
> --- a/tools/net/ynl/tests/rt-link.c
> +++ b/tools/net/ynl/tests/rt-link.c
> @@ -7,16 +7,21 @@
>  #include <arpa/inet.h>
>  #include <net/if.h>
>  
> +#include <kselftest_harness.h>
> +
>  #include "rt-link-user.h"
>  
> -static void rt_link_print(struct rt_link_getlink_rsp *r)
> +static void rt_link_print(struct __test_metadata *_metadata,
> +			  struct rt_link_getlink_rsp *r)
>  {
>  	unsigned int i;
>  
> -	printf("%3d: ", r->_hdr.ifi_index);
> +	EXPECT_TRUE((bool)r->_hdr.ifi_index);
> +	ksft_print_msg("%3d: ", r->_hdr.ifi_index);
>  
> +	EXPECT_TRUE((bool)r->_len.ifname);
>  	if (r->_len.ifname)
> -		printf("%16s: ", r->ifname);
> +		printf("%6s: ", r->ifname);
>  
>  	if (r->_present.mtu)
>  		printf("mtu %5d  ", r->mtu);
> @@ -50,7 +55,7 @@ static void rt_link_print(struct rt_link_getlink_rsp *r)
>  	printf("\n");
>  }
>  
> -static int rt_link_create_netkit(struct ynl_sock *ys)
> +static int netkit_create(struct ynl_sock *ys)
>  {
>  	struct rt_link_getlink_ntf *ntf_gl;
>  	struct rt_link_newlink_req *req;
> @@ -58,49 +63,24 @@ static int rt_link_create_netkit(struct ynl_sock *ys)
>  	int ret;
>  
>  	req = rt_link_newlink_req_alloc();
> -	if (!req) {
> -		fprintf(stderr, "Can't alloc req\n");
> +	if (!req)
>  		return -1;
> -	}
>  
> -	/* rtnetlink doesn't provide info about the created object.
> -	 * It expects us to set the ECHO flag and the dig the info out
> -	 * of the notifications...
> -	 */
>  	rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE | NLM_F_ECHO);
> -
>  	rt_link_newlink_req_set_linkinfo_kind(req, "netkit");
> -
> -	/* Test error messages */
> -	rt_link_newlink_req_set_linkinfo_data_netkit_policy(req, 10);
> -	ret = rt_link_newlink(ys, req);
> -	if (ret) {
> -		printf("Testing error message for policy being bad:\n\t%s\n", ys->err.msg);
> -	} else {
> -		fprintf(stderr,	"Warning: unexpected success creating netkit with bad attrs\n");
> -		goto created;
> -	}
> -
>  	rt_link_newlink_req_set_linkinfo_data_netkit_policy(req, NETKIT_DROP);
>  
>  	ret = rt_link_newlink(ys, req);
> -created:
>  	rt_link_newlink_req_free(req);
> -	if (ret) {
> -		fprintf(stderr, "YNL: %s\n", ys->err.msg);
> +	if (ret)
>  		return -1;
> -	}
>  
> -	if (!ynl_has_ntf(ys)) {
> -		fprintf(stderr,
> -			"Warning: interface created but received no notification, won't delete the interface\n");
> +	if (!ynl_has_ntf(ys))
>  		return 0;
> -	}
>  
>  	ntf = ynl_ntf_dequeue(ys);
> -	if (ntf->cmd !=	RTM_NEWLINK) {
> -		fprintf(stderr,
> -			"Warning: unexpected notification type, won't delete the interface\n");
> +	if (!ntf || ntf->cmd != RTM_NEWLINK) {
> +		ynl_ntf_free(ntf);
>  		return 0;
>  	}
>  	ntf_gl = (void *)ntf;
> @@ -110,75 +90,115 @@ static int rt_link_create_netkit(struct ynl_sock *ys)
>  	return ret;
>  }
>  
> -static void rt_link_del(struct ynl_sock *ys, int ifindex)
> +static void netkit_delete(struct __test_metadata *_metadata,
> +			  struct ynl_sock *ys, int ifindex)
>  {
>  	struct rt_link_dellink_req *req;
>  
>  	req = rt_link_dellink_req_alloc();
> -	if (!req) {
> -		fprintf(stderr, "Can't alloc req\n");
> +	if (!req)
>  		return;
> -	}
>  
>  	req->_hdr.ifi_index = ifindex;
> -	if (rt_link_dellink(ys, req))
> -		fprintf(stderr, "YNL: %s\n", ys->err.msg);
> -	else
> -		fprintf(stderr,
> -			"Trying to delete a Netkit interface (ifindex %d)\n",
> -			ifindex);
> -
> +	EXPECT_EQ(0, rt_link_dellink(ys, req));
>  	rt_link_dellink_req_free(req);
>  }
>  
> -int main(int argc, char **argv)
> +FIXTURE(rt_link)
> +{
> +	struct ynl_sock *ys;
> +};
> +
> +FIXTURE_SETUP(rt_link)
> +{
> +	struct ynl_error yerr;
> +
> +	self->ys = ynl_sock_create(&ynl_rt_link_family, &yerr);
> +	ASSERT_NE(NULL, self->ys) {
> +		TH_LOG("failed to create rt-link socket: %s", yerr.msg);
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(rt_link)
> +{
> +	ynl_sock_destroy(self->ys);
> +}
> +
> +TEST_F(rt_link, dump)
>  {
>  	struct rt_link_getlink_req_dump *req;
>  	struct rt_link_getlink_list *rsp;
> -	struct ynl_error yerr;
> -	struct ynl_sock *ys;
> -	int created = 0;
> -
> -	ys = ynl_sock_create(&ynl_rt_link_family, &yerr);
> -	if (!ys) {
> -		fprintf(stderr, "YNL: %s\n", yerr.msg);
> -		return 1;
> -	}
> -
> -	if (argc > 1) {
> -		fprintf(stderr, "Trying to create a Netkit interface\n");
> -		created = rt_link_create_netkit(ys);
> -		if (created < 0)
> -			goto err_destroy;
> -	}
>  
>  	req = rt_link_getlink_req_dump_alloc();
> -	if (!req)
> -		goto err_del_ifc;
> -
> -	rsp = rt_link_getlink_dump(ys, req);
> +	rsp = rt_link_getlink_dump(self->ys, req);
>  	rt_link_getlink_req_dump_free(req);
> -	if (!rsp)
> -		goto err_close;
> +	ASSERT_NE(NULL, rsp) {
> +		TH_LOG("dump failed: %s", self->ys->err.msg);
> +	}
> +	ASSERT_FALSE(ynl_dump_empty(rsp));
>  
> -	if (ynl_dump_empty(rsp))
> -		fprintf(stderr, "Error: no links reported\n");
>  	ynl_dump_foreach(rsp, link)
> -		rt_link_print(link);
> +		rt_link_print(_metadata, link);
> +
>  	rt_link_getlink_list_free(rsp);
> -
> -	if (created)
> -		rt_link_del(ys, created);
> -
> -	ynl_sock_destroy(ys);
> -	return 0;
> -
> -err_close:
> -	fprintf(stderr, "YNL: %s\n", ys->err.msg);
> -err_del_ifc:
> -	if (created)
> -		rt_link_del(ys, created);
> -err_destroy:
> -	ynl_sock_destroy(ys);
> -	return 2;
>  }
> +
> +TEST_F(rt_link, netkit)
> +{
> +	struct rt_link_getlink_req_dump *dreq;
> +	struct rt_link_getlink_list *rsp;
> +	bool found = false;
> +	int netkit_ifindex;
> +
> +	/* Create netkit with valid policy */
> +	netkit_ifindex = netkit_create(self->ys);
> +	ASSERT_GT(netkit_ifindex, 0)
> +		TH_LOG("failed to create netkit: %s", self->ys->err.msg);
> +
> +	/* Verify it appears in a dump */
> +	dreq = rt_link_getlink_req_dump_alloc();

I see there's error handling for *_alloc() in helper functions but
not in tests. Is that intentional?

> +	rsp = rt_link_getlink_dump(self->ys, dreq);
> +	rt_link_getlink_req_dump_free(dreq);
> +	ASSERT_NE(NULL, rsp) {
> +		TH_LOG("dump failed: %s", self->ys->err.msg);
> +	}
> +
> +	ynl_dump_foreach(rsp, link) {
> +		if (link->_hdr.ifi_index == netkit_ifindex) {
> +			rt_link_print(_metadata, link);
> +			found = true;
> +		}
> +	}
> +	rt_link_getlink_list_free(rsp);
> +	EXPECT_TRUE(found);
> +
> +	netkit_delete(_metadata, self->ys, netkit_ifindex);
> +}
> +
> +TEST_F(rt_link, netkit_err_msg)
> +{
> +	struct rt_link_newlink_req *req;
> +	int ret;
> +
> +	/* Test creating netkit with bad policy - should fail */
> +	req = rt_link_newlink_req_alloc();
> +	rt_link_newlink_req_set_nlflags(req, NLM_F_CREATE);
> +	rt_link_newlink_req_set_linkinfo_kind(req, "netkit");
> +	rt_link_newlink_req_set_linkinfo_data_netkit_policy(req, 10);
> +
> +	ret = rt_link_newlink(self->ys, req);
> +	rt_link_newlink_req_free(req);
> +	EXPECT_NE(0, ret) {
> +		TH_LOG("creating netkit with bad policy should fail");
> +	}
> +
> +	/* Expect:
> +	 * Kernel error: 'Provided default xmit policy not supported' (bad attribute: .linkinfo.data(netkit).policy)
> +	 */
> +	EXPECT_NE(NULL, strstr(self->ys->err.msg, "bad attribute: .linkinfo.data(netkit).policy")) {
> +		TH_LOG("expected extack msg not found: %s",
> +		       self->ys->err.msg);
> +	}
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
> index 357b34611da4..b4c58d86a6c2 100644
> --- a/tools/net/ynl/tests/config
> +++ b/tools/net/ynl/tests/config
> @@ -3,5 +3,6 @@ CONFIG_INET_DIAG=y
>  CONFIG_IPV6=y
>  CONFIG_NET_NS=y
>  CONFIG_NETDEVSIM=m
> +CONFIG_NETKIT=y
>  CONFIG_OPENVSWITCH=m
>  CONFIG_VETH=m

