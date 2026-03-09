Return-Path: <netdev+bounces-265498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJkULrWyrmkSHwIAu9opvQ
	(envelope-from <netdev+bounces-265498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF072381C9
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A95306B9F8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F83A5E74;
	Mon,  9 Mar 2026 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6DocFnV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lccRjXH3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756C3A4F50
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056658; cv=none; b=Hx7G+DBCLQsroEH0AR7kAAlxEY0L8oTcBQGtDQFeCiq27kcVQse0Yb/FsnkSrO8NCBucQHNKdLbOSOnkBp6ddoHx+xpX3n3pL1FV2TFyVejciwKc8uQR2Jq96IqDWhlDIqgCqzletFoABFyL5Wo0DHYvlKsSr8iMam6D72XquZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056658; c=relaxed/simple;
	bh=bNDsGMnQx71dEQWIFI4yiXH735wX4TuPuBfM6VuqrfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=te93FOVcwcguh9Ni6rpGNkOqSFKnsA6EjT0nM8mFM7dAnPXyga28o4AitHqDSmLMWrQG+lrbbEq0J8jUoSO3TVwqJLin53EL0gMVyKZG2+LkqvDPO2gJd5pDSkLBVtjdvGZZOL3NkKvagCaAwTVHrM7M51BFdMNjgLnttFjCCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6DocFnV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lccRjXH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773056656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3bg7TH0WlNH+XsmNxKjZXpIrTM8y8yXJ1xiD9A5bt0=;
	b=C6DocFnVjuqqSC7ptkxw6uHsprTrNdljvVi2zEBti0df/y2gT5iLimCBrq2er1ksk7JkyP
	MLezfCAgxiUGNmkTR6E+fhOAsJ8HT2/5tzkeU5kbvAQB5U/5lDv24uED4BuuzmpdMkoihT
	qihDvLT8djCxiHenLHMzm2QvwfMXNlI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-2pt9guQaNJye_erilxQiWw-1; Mon, 09 Mar 2026 07:44:14 -0400
X-MC-Unique: 2pt9guQaNJye_erilxQiWw-1
X-Mimecast-MFC-AGG-ID: 2pt9guQaNJye_erilxQiWw_1773056653
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439cbc5fd75so3927220f8f.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773056653; x=1773661453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3bg7TH0WlNH+XsmNxKjZXpIrTM8y8yXJ1xiD9A5bt0=;
        b=lccRjXH3TV5q7d/Q5hMzIENBPUg8VxtaLppwRsgbnh2X/Z5Cd5qzErPPUgwdeybyeM
         /fiv34zanvlHj4mzgj6YmCjqX7e1QRt49UcmphTAxj2M+ayEO9XyE5Gv7Ql8S57VWOGq
         WtGEjnPmOzBMp/etNJjhiL3gzhu7CobzkQlQkxTyaEg4891c7VSOcGMR4f5fvnInqrtX
         qmu6bzapGersDfitENoPqf1AtOgPs/YCg0iea6pJTDNdt2FYKkRDNTMm+XSGEmYtzvJZ
         ahvRt2ygnibZnzbSWASyRULHgK9nCVR5lEJFL/kYxbgA6rR9tpifDQQM0HU3th6XgWQ3
         oRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056653; x=1773661453;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3bg7TH0WlNH+XsmNxKjZXpIrTM8y8yXJ1xiD9A5bt0=;
        b=TYO4whJch/qBBivECk0BXEMEu8BGVL6nqTW+ho8xJ13WZ6FY4KjTASaBAKtG45YTvd
         UVN7VAGotnhvVIrghK+7iGq7rtPq+50yV11gJkOm8mdqWqLqIG6qE4cMabpKc1GTFX6a
         +Lh4/A0uAPf09rA/JSCSSZMMfna1Sxt5C8QIPj3Th/YvDQwBaBxmIWmp6z4csK1/0Nr8
         33M8jyp2XPhpagffSHySFv1NKtlo0w7TO1mjEJy7fFHoM06z8aQAiPdvFA4lTrppIYLs
         ub1Z/4/fvsQgdFdu9wQWezxgKnKJUviwMLqjGGuQrl8QPT8chTsjOIgJqJO1OC27dD+I
         2Ixw==
X-Gm-Message-State: AOJu0Yxe6PAuNOB3jbJl6znMmyo/MGmOno0KgeMQqQVOpZHkLDbRMilz
	zZ8oN8AeCo8TXmnO2hV36rh0IRa/IL/4i9Uas7zwiPphc+cjVyUFB5rC9iqGeV1keCcsJpXwyLr
	rygnWjYx8glCgbSeXfemv8o7Lk74WAeMX3O9xrNImgEnvyNVQMYHJm0Jr8g==
X-Gm-Gg: ATEYQzyBajmS8tansxjgvy7jdT5g85G6d3ro+VGSG5yO0UvhDLfDQmKnrrajOU7Skfk
	E/IJ+1e5s/MySEPy4Y6VMDKWUzV2BJtnKMTc6g06G/tewtvvj5IFlV0wvc1n4R4dFPpVyOdqe8l
	HNZrio29KuoQUlD+j5OIrGW966HpaBDNV3/vpDo4Db5zIrQ4ijagONVy3q0xwCBY37z1Lgg5S6Y
	/vEb2Nq69QXBxtliK46AUx3zlyyEPchy66aa0IaeFHUtbagX5tjEBXM2IkgTLVY2hhPQOrUMOCd
	4He3Qfqb97ijQFrwyfHS+6Xvo2xoR56BK1/aw3egablW95xaJHHdqBl0kTcBP9l1oQc5E/uBtEW
	RfmwTY2v3+3aj7VRCH72WYYp1DURqrrAe9m4v66gNoat3bZN9
X-Received: by 2002:a05:600c:8712:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-4852ce24f8cmr151212935e9.1.1773056653008;
        Mon, 09 Mar 2026 04:44:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8712:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-4852ce24f8cmr151212305e9.1.1773056652400;
        Mon, 09 Mar 2026 04:44:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246ff886sm87283795e9.24.2026.03.09.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:44:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A86F5A1D3A; Mon, 09 Mar 2026 12:44:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft
 operations
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
References: <20260307163430.470644-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 09 Mar 2026 12:44:09 +0100
Message-ID: <87qzptp6ra.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4AF072381C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265498-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mojatatu.com,gmail.com,resnulli.us,google.com,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> writes:

> Following typical script is extremely disruptive,
> because each graft operation calls dev_deactivate()
> which resets all the queues of the device.
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
> done
>
> One can add "ip link set dev $ETH down/up" to reduce the disruption time:
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  ip link set dev $ETH down
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
>  ip link set dev $ETH up
> done
>
> Or we can add a @reset_needed flag to dev_deactivate() and
> dev_deactivate_many().
>
> This flag is set to true at device dismantle or linkwatch_do_dev(),
> and to false for graft operations.
>
> In the future, we might only stop one queue instead of the whole
> device, ie call dev_deactivate_queue() instead of dev_deactivate().
>
> I think the problem (quadratic behavior) was added in commit
> 2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
> for lockless qdisc") but this does not look serious enough to deserve
> risky backports.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Yunsheng Lin <linyunsheng@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


