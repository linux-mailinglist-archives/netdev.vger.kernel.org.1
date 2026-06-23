Return-Path: <netdev+bounces-301230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9qShMuneOWq+yQcAu9opvQ
	(envelope-from <netdev+bounces-301230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:18:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEA6B3235
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PdFiLo25;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301230-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEEE6300753C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7091A376A1C;
	Tue, 23 Jun 2026 01:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672530D3E9
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:18:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177509; cv=none; b=IEHthlbplyir/mSJud6hS4hxOwq2VYhOPmNnDLsoFCPYZhN65YZ5ipHrzmFeDOAc3N0BUvpqbHQF739G1Aztoz7z+xFv2rzExX3F2upZwmvivbdwaWrMIC3Qc1RmPzsELhebaZG/2zv6M8E+UH+oiFcESHJzHWgHE7HfQnXWJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177509; c=relaxed/simple;
	bh=DmoUeLjpNfEfiOYCdY3qAp15oMfmxTnq7Cv/R8buu1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXqLZ/KUMfenUhnSiThDmPdQJb4QJI3M4BsJdoQz9TnBSNXJctvZis9SMm+Un2/RApYcCM/zwESzR1907M5SkU3KZ/iea29mCrZTgtpnOKwTOgR+GiWv2eQk8y3qD+iBddiiPhigt9GYzcO1qXMPsd3tcansUDNIQ4beQcR91ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdFiLo25; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6c101aeafso32175265ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782177507; x=1782782307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmoUeLjpNfEfiOYCdY3qAp15oMfmxTnq7Cv/R8buu1U=;
        b=PdFiLo25252QNfZVhdQm/Xiqrm9NTmt01kT5Sy0wqjgU47zKkTF/jEkZDaxEwNwHiG
         tfMGxHJyYDyp/zdQ7RPHakyfCftikdhG1/9NRinzj5W0Qm2FzlluXMccgn/h+rEM0HOM
         KPOCuNsPPrdSkZtdLdmyyEr2KJ81jmFl1/sJ4jUAzE9QMiWS6xqwD9FPIBs6cUf/7u53
         pswUxcOxcBsLrPydH8WRLt9mgwjPC9QOaCe1jmFRTlp1yZTInIdFzgS7zYBiGhD6MI7t
         T2tqQKtWpvHsRrlUFhNSlGfjsZxIGnHS7v5i4eNU9ERwF+5fKWoved/oxqYpbbb3LWpA
         IjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177507; x=1782782307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DmoUeLjpNfEfiOYCdY3qAp15oMfmxTnq7Cv/R8buu1U=;
        b=QlvriWgWKPg561R5lhRBWfjPam4exBeSAIFJzI8VUrlxCVssqft8oywHJU3yNj4SCJ
         buGkcaDGPOmFuY5LTuudaNX9u7PwJqGSpwq4lluMZ7bULYkJJQEV3XUSvpelnHhMgO4p
         m1CZ7Y9qnE/t96B3xZO+i+hihl382FqJXZijBXEVW7bM5fD2n+7QHOo2PL4GkyzZFRcu
         kw4cH7ofjxztXTDp1+Aw2V4XkLatg383CSReKU4zCseXEWP+9EQQsPZe16CIoRBTe4BM
         a7U3RkGt+3+hDKUFd3VZpm5xlzlTF/3zpw5KQ8iWwn7aGkn8kfdlYgE2me2DYUxg/caU
         Waww==
X-Forwarded-Encrypted: i=1; AHgh+RpndZyH4yd4+JzEn/ep4A/djFC0BQhL6l0TfoYpJn+DkxHIslpuHaQdNzPwzD7efOn7Ef/gbhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDYpA/7FkaVIBT+xZv0IYNhYqMEuIDNPCqroSEZH3OIEH2ks+
	sR6twYTW8l8+sDQUmHHeT9QTDxOYwMOoSKpTnfymizPmt3bMbzOFZsP8
X-Gm-Gg: AfdE7clEOspmZmmZZjj2bQ9yzMEe5QBz1jWjX2VJs9qvQmP6D2lmpRppV0iz9Kap7yq
	9smoDWf9OC2eAxnsG/QGbHcECFUbhrI7EWMxCQ6goD/8I3TQ1S3ytTSjZi05NhBdIffXsd56W0q
	VjUWxcqN5kTu7BAf29OurYklO0SexMWQvtuBxRnKMKg7FO4m39fuSJhvfGVcS41a2xnNZjmQFsH
	tDu/QNlluKtZOP+YVXzZ8gS5JFwtiYFYqtRwSIGDLyk+4INWVx34vJHKvERcW4wdq/mV+mV71MS
	TSsA0qrSp6CnCAF9nzy705gKF+SFFOY1iT6SEsC1WcvcnC73imuhtmi76unEN1IlZtQkjd/qrFl
	I5VBYjmNr501/ksHBW1mJsHK6jbNNQd5L8m08JDLRamLXgrBo/WlV3W2nPpt6qxk5ZIAPMEuzJy
	rBfIR2xA==
X-Received: by 2002:a17:902:e892:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2c7c99734famr1897205ad.11.1782177507312;
        Mon, 22 Jun 2026 18:18:27 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c799749cb3sm45863395ad.72.2026.06.22.18.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:18:26 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: andrea@common-net.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
	andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	shuah@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stefano.salsano@uniroma2.it,
	ahabdels@cisco.com
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433) behaviors
Date: Tue, 23 Jun 2026 10:18:14 +0900
Message-ID: <20260612032313.28921-05-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608023951.ccd278890d7c489dbfe21113@common-net.org>
References: <20260608023951.ccd278890d7c489dbfe21113@common-net.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301230-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea@common-net.org,m:yuya.kusakabe@gmail.com,m:andrea.mayer@uniroma2.it,m:davem@davemloft.net,m:edumazet@google.com,m:dsahern@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justin.iurman@gmail.com,m:shuah@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:yuyakusakabe@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,cisco.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,end.map:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DCEA6B3235

Hi Andrea,

Thank you for the answers.

> On the placement, the new lwtunnel encap type you propose could be a way to
> implement the seg6_mobile.c separation. Since this touches UAPI in
> include/uapi/linux/lwtunnel.h beyond the SRv6 subsystem and cannot be
> undone once merged, it needs careful design.
[...]
> As far as I can see, RFC 9433 has only one Headend behavior, and no L2 or
> reduced variants. So a single LWTUNNEL_ENCAP_SEG6_MOBILE handling both
> End.M.* and H.M.GTP4.D could be viable if accepting both input families
> (ETH_P_IPV6 for End.M.*, ETH_P_IP for H.M.GTP4.D) is treated as a design
> choice of the new encap type, not a stretching of the seg6_local endpoint
> processing model.
>
> These trade-offs are worth weighing in the final design. [...] I think the
> lwtunnel direction will need feedback and comments from its community and
> maintainers.

Agreed. The first per-behavior RFC series (End.MAP) will introduce the
LWTUNNEL_ENCAP_SEG6_MOBILE encap type and the SEG6_MOBILE_* attribute
namespace, and explain in its cover letter that this is the shared
container for the RFC 9433 Section 6 behaviors, so the lwtunnel and
routing folks can weigh in early. The dual input family (ETH_P_IPV6
for End.M.*, ETH_P_IP for H.M.GTP4.D) is specific to H.M.GTP4.D, so I
will lay that out in the H.M.GTP4.D cover letter; keeping it last in
the posting order gives that discussion time to converge.

> If LWTUNNEL_ENCAP_SEG6_MOBILE is added, using SEG6_MOBILE_* attributes
> instead of SEG6_LOCAL_* removes the NH6/SRH/OIF overload raised in v2.
> After solving the above, additional issues remain in the patchset,
> for example src is overloaded across MUP behaviors, and v4_mask_len
> needs revision. These are independent of the lwtunnel decision.

Both will be addressed in the rework; the details are in my replies to
your patch 2 and patch 3 reviews. In short: v4_mask_len and the src
template will be removed from End.M.GTP4.E entirely (full 32-bit IPv4
DA/SA recovery only), src will mean the verbatim outer IPv6 SA for the
IPv6-emitting behaviors, and the H.M.GTP4.D "Source UPF Prefix"
template can get its own attribute name in that series if you prefer.

> I can lead it. I have been evaluating the SRv6 drop reasons with my
> research group, alongside other pending SRv6 patches.
>
> We can sync offline on which SRv6 reasons fit your MUP behaviors, which
> v2 MUP-specific reasons would fit better as SRv6 or generic, and what
> stays MUP-specific.

Thanks for taking the lead; happy to sync offline. Until the prep
series lands, the per-behavior series will carry no MUP-specific drop
reasons.

> Thanks. Maybe also worth covering bad packets, like fragmented input or
> malformed GTP-U extensions.

Will do; the C-helper selftests will cover malformed and truncated
GTP-U extension chains, a duplicated PDU Session Container, and
fragmented outer input (which the behaviors will reject explicitly).

> Works for me. What matters is that the upcoming patches are well structured
> so NF_HOOK can be wired in cleanly in the follow-up.
>
> I am already working on the fix.

Understood. Each behavior will keep a single strip / transform / push
flow in its input handler, so the hook can later slot between strip
and push without reintroducing the skb->cb context pattern.

Thanks,
Yuya

