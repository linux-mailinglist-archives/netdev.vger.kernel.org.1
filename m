Return-Path: <netdev+bounces-268260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNBCOVFZuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:26:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4BE29FCB6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BB9930152E5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33633A9E9;
	Mon, 16 Mar 2026 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkdrta7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C720E6E2
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689164; cv=none; b=GdoQVoUHwk7N5hOdBAwsq2HHfB3/9HhPwz8RCn3KTmmNVd9q3PVI+rkISn5IjXLRtvorXOGCc31r4nD6QcBfPrCRktUVSSeCwBl+kfKvUJTK+7zbcO53NsbwhjP5gEMqSA4SmesG98uvjbS9GkIHJpxTjn0B3o+LS7Wia/vAuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689164; c=relaxed/simple;
	bh=VVODvYdVPAPnIMUtIejNvVcYb3+5h5t9au0lrAORh/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKOuZP6AAtEiwpmAVU7y26/EsGcg+jJdEu2jPze+Ks7j9uUeQhcQZJilhr/MLbKkPLfC7EpekTNxGtjbCb0Z6FpqljWO+gKvIQI6YQF+tyS1Uy6xK6OMt8n1vlHoyL6PGbRdEZTgLYGrdPTm/3X+TVzyJgQaeJ9boSMWAPtUA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xkdrta7w; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271195d2a7so610190c88.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773689162; x=1774293962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6cMzhf4VkTVYDmEHyBOjOEPI5+8JmDa90f9gmIiMY64=;
        b=Xkdrta7w2/wGw0vEMzC8P8XFNgSo5H93Izh9TjzA2eFgYkinFQfoabvVoF32k9C41P
         W0UqQgd/agzbeMsjBEYmpBE5ie/sQDw6xJIA9StZ9apLLrkdg7rriLgaa9UVRhwox5SG
         jO48t4VetrVNy4cOUZ3H35eVBSaPH5j19+qVINMQnmJUbi/JfpziVKmhUcmzf0+iULBw
         wnor3DNdq5sVkdoGH6fwBFnodUYT09vlEc6Iz0XGu3gtpZc57aNFO1MX/3Wk7aCG+Of+
         FsEFYk+QjsPRPlNyfzl0EmIIAzxPppFEJ7/+aR2Oo7N9O/Oz50z4cBCsUNS4sz1+Ra8V
         Fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773689162; x=1774293962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cMzhf4VkTVYDmEHyBOjOEPI5+8JmDa90f9gmIiMY64=;
        b=rufDbOaoJ1XonrMtX7bpFq0ceAOuEqlrYDHo8S1BjjoXfFDPo7m6xSSpR3mmzadKNN
         DFhu1i9HRJ0Jz8W53lolK88ut6qJhpA9TLKOznP2FvfOC/zkxAJg5X8/NIhUJeJBSiwt
         mDM4aVKkearq7KC6kNCW0H83y4Au5t4oTYQ7kGmA/tEMuo/IHFMtQbqugFrV/vBlCZ+R
         c5JsQsofWbqSE2bOs46+KIQJ+63m4CI6B7pTmu5oX2ze/iNuQmgpv5A9IEzT2nI81n7s
         0jI/h/vwk4eK7XQQUWvRfxx8fPLNyGT1+LP17pjv1kMM3bufVV/gZp+ho/1Fu3Beqx9L
         oHKw==
X-Gm-Message-State: AOJu0YwGQUVo7Jm96oquLw84Um685y9ivHhKUsjjo8PI5Rl5Npv5SnDW
	3ix7y2WrpWtbg/1v4OCVTLAr8yTRqTf655Lt1eAqC/VnexbwYSxdGHGE
X-Gm-Gg: ATEYQzxV6Fl/9PmAc14LV7W9rZLt6PPQVvsXZxdwmGXR4S0j5hUdFxxjMPEwgrg/gfS
	pEaRCZo9+ipvPaWXLosoyacBhdvc21nvmqGwSaUlLaUH1ycdO01wT4MgVAcO96WXWoMuZmSQ+O1
	OsDQy9fAjWepFQhOnofJ4DYb02Z7tp+Dwxm5OnfD9ATgC7BnSeJMjncPAla9mvfARAs3o+bO1ks
	DkUSKWcDVjPRQiRBboNiIDMaNWyNvVdwgUPKhUsRaHUsdSeuEiO7kuQDKPDGBdnp4f5KJlMyUtS
	wXbjbEFwq4uunJldBMy6eHMmVx+a1judNukzoB+kiAao+Y+lx2o+ZYZ+COjECa1atl0LNaLgKnQ
	p9i7T1vpltMEof5BksoWjwUoF5ofosieW2HWtyQvNXoE33U1BGHueqPD7uGOB3+VuWsT4pzOARS
	kvUqUNtZ7nFBPA/NJPvpaISM27RT1PPbLqsaG3L8DqxOLTkNB8x/FKBoNrTy8=
X-Received: by 2002:a05:7022:6b94:b0:11b:9386:a3be with SMTP id a92af1059eb24-128f3e2a387mr7005017c88.41.1773689161705;
        Mon, 16 Mar 2026 12:26:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab55541fsm19113857eec.24.2026.03.16.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:26:01 -0700 (PDT)
Message-ID: <430af20f8bdeb4965e7367578e0795d4eb006504.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 09/11] selftests/bpf: Test using dynptr
 after freeing the underlying object
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 12:25:59 -0700
In-Reply-To: <20260307064439.3247440-10-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-10-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-268260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E4BE29FCB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:

[...]

> @@ -223,6 +253,12 @@ void test_ns_bpf_qdisc(void)
>  		test_qdisc_attach_to_non_root();
>  	if (test__start_subtest("incompl_ops"))
>  		test_incompl_ops();
> +	if (test__start_subtest("invalid_dynptr"))
> +		test_invalid_dynptr();
> +	if (test__start_subtest("invalid_dynptr_slice"))
> +		test_invalid_dynptr_slice();
> +	if (test__start_subtest("invalid_dynptr_cross_frame"))
> +		test_invalid_dynptr_cross_frame();
>  }

Nit:

maybe consider using test_loader.c based infrastructure for failure tests?
E.g. like below:

    +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
    @@ -115,6 +115,7 @@
     #include "verifier_lsm.skel.h"
     #include "verifier_jit_inline.skel.h"
     #include "irq.skel.h"
    +#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
    =20
     #define MAX_ENTRIES 11
    =20
    @@ -259,6 +260,7 @@ void test_verifier_lsm(void)                  { RUN=
(verifier_lsm); }
     void test_irq(void)			      { RUN(irq); }
     void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
     void test_verifier_jit_inline(void)               { RUN(verifier_jit_i=
nline); }
    +void test_bpf_qdisc_fail__invalid_dynptr(void) { RUN(bpf_qdisc_fail__i=
nvalid_dynptr); }
    =20
     static int init_test_val_map(struct bpf_object *obj, char *map_name)
     {
    diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_=
dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr=
.c
    index 2e76470bc261..f085872c3900 100644
    --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.=
c
    +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.=
c
    @@ -3,12 +3,14 @@
     #include <vmlinux.h>
     #include "bpf_experimental.h"
     #include "bpf_qdisc_common.h"
    +#include "bpf_misc.h"
    =20
     char _license[] SEC("license") =3D "GPL";
    =20
     int proto;
    =20
     SEC("struct_ops")
    +__failure
     int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc=
 *sch,
     	     struct bpf_sk_buff_ptr *to_free)
     {

For tests that exercise verifier failure messages this has some
benefits. E.g. the following command would reliably produce log
output even if program load succeeds:

  ./test_progs -vvv -a bpf_qdisc_fail__invalid_dynptr/bpf_qdisc_test_enqueu=
e

And __msg annotations can be used to force-check the failure reason.

[...]

